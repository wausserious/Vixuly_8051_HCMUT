LCD_E	BIT	P3.4
	LCD_RS	BIT	P3.5
	LCDADDR	EQU	6000H
	ORG	2000H
	MAIN:
		MOV		@R0, 30H
		MOV	DPTR, #LCDADDR
		ACALL	CLEAR
		ACALL	INIT_LCD
		
MOV SCON,#01010000B
MOV TMOD,#20H
MOV TH1,#(-3)
SETB TR1
L:JNB RI,L
CLR RI
MOV A,SBUF
ACALL WRITETEXT
SJMP L	
	INIT_LCD:
		MOV	A, #38H
		ACALL	WRITECOM
		MOV	A, #0EH
		ACALL	WRITECOM
		

                                  MOV	A, #06H
		ACALL	WRITECOM
		RET
	CLEAR:
		MOV	A, #01H
		ACALL	WRITECOM		
		RET
	WRITECOM:
		MOV	DPTR, #LCDADDR
		SETB	LCD_E
		CLR		LCD_RS
		MOVX	@DPTR, A
		CLR		LCD_E
		ACALL	WAIT_LCD
		RET
	WRITETEXT:
		MOV	DPTR, #LCDADDR
		SETB	LCD_E
		SETB	LCD_RS
		MOVX	@DPTR, A
		CLR		LCD_E
		ACALL	WAIT_LCD
		RET
	WAIT_LCD:	
		MOV	R6,#10
	DL1:			
		MOV	R7, #250
		DJNZ	R7, $
		DJNZ	R6,DL1
		RET
		END
