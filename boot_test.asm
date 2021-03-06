[BITS 16]
[org 0x7C00]

start:
    mov si,MSG
    call print_string
    jmp $

print_string:           ; Expects null terminated message in si
    mov al,[si]
    or al,al
    jz  .end
    inc si
    call print_char
    jmp print_string
.end:
    retn

print_char:
    mov ah,0x0E         ; Specifies that we want to write a character to the screen
    mov bl,0x07         ; Specifies output text color.  Not required, but useful to know
    mov bh,0x00         ; Page number.  Leave this alone.
    int 0x10            ; Signal video interrupt to BIOS
    retn

;data
    MSG db 'Hello World!',0x0A,0

TIMES 510 - ($ - $$) db 0
DW 0xAA55
