Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657D43F39CE
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018771; cv=none; b=K5QEXMpkGD9sCgqJARBmnxfF+USQrR0QShCMnsyN5LnH8O96/uXQvzhmtLWcd6YAATxQCETIs1jVHZ22pMgUpPGCVmIsggM6hdzNwcxp8XtoOan2TZGxxh2B8bng6/Zp+QbiXlpDmHip0aogNcm4q7HVrPd+bI5sS+4bhMo252g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018771; c=relaxed/simple;
	bh=wrz4Pgl9scrLacckUjLG56OtizFkmCaQ8CMZGngKong=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=h0xFKCMad+wTryQ2s8BMOX7KO7YipwUQxRh9HwJDnEL2LEZDWiPz7NOLQbRGO5Dm2LC5jrOCu9I23Ctbdg/VnjGmxzFkkaORp185SQSCmYugdvPSoamgvi3cTGyluReNQBf2LgbThJObwOftkYaIGwKrU7vC0AKf+Tl4GtfR0jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=G87+kAvw; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="G87+kAvw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784018760; x=1784623560; i=l.s.r@web.de;
	bh=Lv9hWAsxLz7gRASOV884/Z1eE7Hw6v/XmO/NANWS5G0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=G87+kAvw0183FblJ3q6mE25hLDdiX+I7EwCfEKftIARalYfR5ep1UBlrgHsaoEfh
	 yyS8u/tj6wZv/2J2zITb66KngwC5VKtGBwxucLuqy96V32xFqsFkinIWdCJp+IFDU
	 HWMlIaThmOubGvygtleA+DuU88rLP6GjQKP+UMSGMgGM/4AHooXBOKjsiXTOmN3ZV
	 u6JYm6JriJWqQHh0/uRHtaZtzw8E/971nzZqDdi8FlbKisSUxvlpydiAg6LKnH7fy
	 uUj1UlvYlCWADBW7M5RHpBvA58Z2mPr+nEyZH+fwjOspnWQv+skQcC6Mug4bnVAkf
	 /t9f1Lw1I8AL5g3C6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MaHSp-1wUrO90Ax3-00V6mm for
 <git@vger.kernel.org>; Tue, 14 Jul 2026 10:46:00 +0200
Message-ID: <d4ffe7fb-f782-4f06-9e3b-f72729d1e225@web.de>
Date: Tue, 14 Jul 2026 10:45:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] strbuf: avoid redundant reset in strbuf_getwholeline()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N+iOpoQ60TUL7twuPxzFXLzLrgsUPFok6AenubfXDRCUoOo+Nio
 uwy+UABstabBGd8DQyo/+7+RHkqS69eE8p/DRcLD7YcXlhmPk0WVjOM2cTy3xaAyzkFPmy0
 h6avr06Rl9ohGQ02OlYXtk2Z+Yz/LWN6Xwi/VU4oYCq1ZDtibeToJLVy/HIraKSAYQZwiJ1
 LOfCRUjKbBRCeDfGQFf3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mMahJ+xYtTE=;iVmld1FtJ7I+gzJhzuMqrDXjq6D
 Ln/GQV1Y6Ct+Q6YHwG6gEmprROnrQBZcANwHFIPE/QH/E8iUkGLzxL4D/adoKjrWUNH0Evoou
 AgF9fuBAv2p/ifdvD7Vfzd9jIelUARifgCY2Yi+qzoj4meWExfXNTD3HP3XyEk/HSL+kxj0Pa
 UwRZ6D8gOYlbJUx7uXznlOa+qAMBrm+euI+ai76Kho692fjpSnEe1bFsLH8QjGUDAJpfEvy2u
 h8QU3Ro5mLbTVQzr702ext/4vscdrjBp8NS83zZQchsVt3dGWnYcmgHG+UCOJmh53ge3AL6vg
 GkGoYd0s2d+z+ollvBqed2/RY20iiNpwJHOZ5BL0dzbuJZR/auEl7h/4KvAiPa3+XF2c7MkRA
 wUpOhnDKV7kfALZjJFWErIu18okqwZJgdA1eKR+Cb+oMswVAtXcllCwZZDRGu1kViXJjRBUc3
 1rs4GjwPXLUgN6xZXA1m8FqEa06eUUOgZWV8v2XSJG2k+TIzmL5T80RhmEbaCBH+vUhpjx0Z/
 NcTE9lrS5f6fkVKl10ro40fdkOrwYC7AmXaWWSbwEaGGVazqkydBU7rPPKso1l079A2BbiX77
 q2Xf7WIywq1zjWOlE7gU2giIWhErAJCTG7Ve0x/N5XLOXRJ5GY5Zly3ftyp8YWbWtLTyFIHnN
 CokeCetYeCN/6nvz2jstGbYNG71lretl4jy0f8MKRFdAidEQQwGaH5m0vKvSBnGzVoOI+h08H
 t9I95Y5QV9wCqxABS9KGxuwfBnYP+RyxvjfrEcX46+PBn2GgIQy4cszeFYrMDsBNSnVwGMDox
 aFG0VyBPKPh0iZlF2fftAR7EIpC951iv3Iq9Tq7PoUFnc7hdfo4f46k6oB3+lefZR5Z6GfBBK
 qtqr87mD/r8vnBJz0ES8G2YZAXBnsmQ4lPQ1i6orgW/wDpXKoNRwd3dOmp72EAM5i7TI7Zxc2
 /4ylHBVXvAOR6Cye0cjpJ5Amrghrpp9MNtznLjOBtlBjrD7paUqUvQQtoR4WvDD8URMJsp2IK
 sTKrmdkX4OEQep6t7Ungh7DLKZ2U63uEM06A06ahYn1JQB6bgFTfDWVg87ysv9Qe7GKK5v2Kz
 D+NgOzNpBtYuH3rsop4l4JXfUUW8aEpyFlB0tiBXU4jXosYq+gAx4yUkP4+dYwX1h9li/o2d7
 GAL35bPRg/P0Z/pKTS5M8pcr3IqgV9uA6Z3BTVxujO+YhS5WSnp1BWvq+tv0ok13FmLDKqs8C
 eN5VMi0jZ4KRa4X/SvG9pFJpjCrDloNY96q2UKDaqK8hFxLr8LROEL+CwTf0mLtHXhGxQ8o3L
 iU4gERB7v8m4fp9A36M+TYekWJLIzLwXMwED/TL+Zz+6tHV3EAzexDg+OaEIUEMWijtjmPNO1
 chj7bn/ZzpI1bd9L1YQ03nlNXo0rJ/Y6XW3df257rr62kJ6g9fRpLTFCJCfy13Eol6FOy2QUL
 LHwuZzlcX8UQDjGaHwKKG2pR3sqkolSr729vrQTVQS279f4nVhSKeRKy8q08JBFxn9ArDR+qf
 35r8APqewG7wNv+gONH5Ec4PdYvGl8PTkbct/UOU15x67ob2Ph/Ep94SoeBtxt7BHPnbIH7lk
 33f7H/XMaLbBcj3Y0GCRAjrBmhlMJcznXZ6Z7LrymtXzur3Q0hbfIl5HrlDOi1XW3EciK/mRX
 CKw34XAjdGjRQz17KFbWytH1F+VrAEYUNg4PV5v8l5SUoPak9e1QzhHX7vciN4BL3Ebjn/cV5
 +DSUkZ16QeLtBDIB0lOsTCLKL73ri318HLYvbWJRMkAHbV6T/eXTCcsfG67ywOSeGFRsGPJCI
 LivvDa7m1zxNVn1Odbs405KvIdLtQ1opmhk2Zjtd2jUKrpXc3fWzKEgOm6GUW1+/wmdl65RNy
 YfxhIZuPteQQd5sdhZIY4wb/qsZGn0koAK7HG7QQdwTafE3bJSv8OCKsbeSDu+KP5vPDza21c
 qOh+ATWiNdQdxGOIP4QGS6cImBtKbFOZRWYFx6KolfwLcftm8MG9Y7MJSEDgxkCjQxUsumo0q
 eg4m1lcyQAiKfvVcKWXv4N+psdmMHBdKqJF1QUaLulr9T9c9+SLM0b6cqo6jRb66MMx7rbzmM
 UrnVc+zYLGE78/oVMS8y8rCz3WjWCnrsz90ZB6hkEMyQGsK8ePNsh3XewtcrA40DW6vAHUzaZ
 VoULsBHsls+df18MrITzsxRC7d5TM0czgA963kvWZQ1KXFTxwTlAN0iEzrJLRZ2A8A7fvIZWf
 DlheOjQ0kq1tIa0eTIVmlE0PolBczqlJn1h1Ff7YBfNlOfxjFgcBgc/zBlP1tAOu7aP11ki7M
 +ZzYXVzQmfUDLOXqoRGechXetSMEZ/9jrKRqjKnXO0A+y+DXiVhR9xh6jLNn7IE6yWXf3993z
 ESJQzErkYYM48EkmdVFsLbL1TGQAtM99Yr6U+2f17dUWK8K1Lssqv7MAXgVsVqxM/ZsYTZhUl
 yuv5mJmgay2h+s/ciRVVee8zMH02/F5pP0kPQXZH+CPT64oXP6ut6DZybCHXy+sOy6Q9JsP7h
 C/ZMG18JSxBt30hYQy/O7/NnvhjQHQdrtvXZLv/W3tnTEJlr9tah/hA2MAoKmrZMzGV03Z9jB
 blLlbvXWTf9f/cbNaGulp6soxHzhR1ao03XZrx0Wc1/s8m0vR4Qbstz0nfygm4GiBevfOAByY
 Cg0siHUGAoifuSCLTuNjaBke45ckNzkGkqvUhedVb+AJT0JkKES2mTEfhBNdF8UA4z8xRLgzW
 F6v7031omp+TdglNdVmRprl5x6QUFc2K5rwQ36CYzcKGTaQXEeOeOpk3DyVVDrgz63ci8A4wh
 MrGWlsBv8CS9xm1C+uU1wUijNhgFLckSsx/+I5fExVk3kHLZ/dpfKTsK9wmaWCipKFDIwJvQz
 kLNw9foyDsHHjInkn2KfMm/XHiSoYj9bmuLS9rKPuRrpl8xBq5SaC26YR9L0ytGjcp7feAlTk
 Z1xX1wRHoken6BFTR6NLmpPgH8iQqugIvgIeo3VtL74Rp6Rry2J8mgxdyjL3iSvtJC7ra9QCs
 q8etPYS0m2/d/f/rNlf8G999vtwHfUxq/HSkUymYvsbK4UYPA8IAA7LoadVSRAic6UR6Pu7au
 wF8MVKvkHUWp4WuboQu4/PgL+YgMiwtJilDJtTmMg1Z/SYVhITfT31o+bFu9uYY0BvHGH0wfi
 YNq2gBRFDTLgRmqVSQe48PHWVFrOTZQv8AJWsQiL2LX//BbJB2lCsrxO7aT3tw04Zw1L5eHxs
 vTf7Ht/Bpj/wHGg6vxy+gXN0WCu97O+APL09C+1Ef/5CQSg0xLUZuKszkApEX7sbN3V3rURTK
 DUmWXqbB3Pg47uv4FTLtaDZx5azMYu0RyTyeHT0eW652YZ9kkt7AgxUVHr3FdwdHcwuJByBSD
 Z+LKUSH2OT1XCSFU8jE5Vf2ZEsWhSFT7tYiZuHy2E8UgiXjNqy7n5noCZhpQgdVU5plGoVb6T
 c/HhdmoeGWtRakuA3WuwSepQQAjQO/8ISLKueDFD5/nKfYbf6hHsIEQulzXM3QfVaQ9YU/PtQ
 fwWeIWh8rMEwK67/pZthehyu3rmvejaEI3hgugRrF2jk19+oL+NknInJjehVW7pz7DdrQfSLN
 VDS+qsbsxtJFE0lNNYXTaGSiZZ6Oulb+ThG5jQPxlk8Q6NmwbuV9DZSZ2oFqb8qu9p7yjhwU6
 yFSmflx8RXqV9feLx4//Egsc1TWGzT3IgNfgsvwFnDBPGcudKJ6jdGyOWzARoRF4i6Mj0be0q
 qKNoliuqG2Lp7vTXkBUjAJOjqC/p8460kIVAEkjI8PIFTgY6HpYrL89M7aRzloX0i26S5s7zx
 BWXbwm9NkRckZHLdDegnRvTW+68Ppvcep8IGmG2NUErasjJJH/7s+azDUfzq34l6yV7y//+t3
 cZd1Au4GdCPF3wWDptPwbwWWCXVPZmd1RQQSpDsu6z+fnnH6f0EvC2wiDOYXN7AI23AC5qOMc
 TTJWgxHA8TTw+H4LlQZG5SH0iTZQjY0pYFHNex02KMr7bSKh/qjVCzxtWuf3KFKYDzpVXErYq
 8JJqUxVeDfQAZRlgbQ1RLoa6s22dC6emldA2bYBv1XkZPio7rMhvCVedDqPuPLLaWI0eyePhN
 p2FAJLeL+D7624Wf0MRnKwokZQvZz9OVIjqPIkgoDXNHorE+beF5UHBVNUOhix0Sf5onoKN0Z
 UiywuuyXBoieEBSqje+39tWjKB2dw73stZoczgbnX12P2kSGYIAalEm0LdM1PGZD/s+yD9jNX
 PeRo6UiuXcGq5CKMwHXB5AbxKMQRbgZsUbOd5YTVGMiWD5DX0HDZSZFgPrxEGFyJA/zepdlI/
 G+5RYp58OB3Cqo3kq8kiUaEg6/zXYK3E2S9OVAEWAeO9eSmpsV9VCRxDC3Mdl39oH/fMh6mEo
 emrgyNrW/8Q3bWZ9IR7/zfhs0xCTbbLAm+0+I13nSwCmvMCeDbbNhSiTXiu67sIF6C2KGZy28
 E0s8V2S3C+Wfo9zxqga5ko7llVT50Zvs+YM6Kvo2H0/yA0sTFr9X9B2kh1Wdw7pJ6pmbumEqz
 ZARB9IE73AkHAihDsrK0/icK/CM2+zY7ThbAuIGy0PnEm5b906um38MUCklF2N5DnsVewqjGy
 G8v+u5G9CO1WKI/TIA4+RdMgMycPtzKdg7RXKlPpjHYypON8Ug37iDxLMLEE34BnpiLnR+kXL
 b2iSlQbMyOLcepT6mMfmP9rusJ91fQAUD+brms0cebh+w0H24qRF8cqXljkNwmYLrpFD7r9a/
 CXgTJSOtJq3eFLI9tOD9Duri5P8a0DqAN8M3MneEyO0EgaIOyTaU0+D8G8QdQRqNq3FgMx0gz
 dGN1UhLqbRWKmb9bpBS5fY/IXDxHSaab8oOWWzHMLE+Jb2yBL7rbBwDtYCKTv8dPNDQQSSgC1
 tmHxAIFNQkbouySihQ6pDsIB4Gnl+WaoDs72F0K3qdvBDUDO+uDeEN2KoHAGO945RWGaqPApI
 zE3a75anNLb9AFmlTcorz2pge2vswIIowepoP+/UIlngtNwXwp3s7usXo4qekOUVWZtO+N/sT
 ek1Rty5QUOus9ZxlIr9Kje6gDSp/CPlTPRSt7f7Q78Dar0+EwoI/jBUYvrL13yiC8ODFKEjAk
 UI+pRLlIe5bBz9fAHN21c9qhS8OgQ8hGulwnNLoncpTJfdvbJ/V+TXwo2bHS448OcxdMbRJzP
 S5lKabrWnrSmVJF3Y/ZtZ5wsliESpAXF4TPpGiQXOZ16fpAAtO4GdgxKx6S+WLKQFuLgZ4zlE
 eHD2VrUKn2qzTatz93EzOLR5uWmClE5bE3pNYeAqk/lZ0iaD+gMyByYGhuxX5Pd07lPMLHMWv
 3O2HoBZ4jH5u0ecx/ywnSOCybazUI/56qc38rTZbt0iWyyi2AjGzMyivS5RkorZJWRw/tmeUl
 8+dyL+Pwcc7OqvhYly2vOUe60YLtbs2q377UifZrNxTnz3EnoJSWPBPmxiPOcV25ppEHV1E9e
 KQtXpivFvzJhQoM0g9I0fnl9bBRsPYBoWqYbdnoEgoUU9Fw78WtBfEa5UsxrmpLnwAz2E+l/9
 BEkKuOF261tuIYwnqAdTQlHdXfSGXokJT4EeOtve3Jz2MDLx

The HAVE_GETDELIM variant of strbuf_getwholeline() calls strbuf_reset()
on the strbuf before handing it over to getdelim(3).  This is
unnecessary:

  - getdelim(3) doesn't care whether the old buffer contents is
    NUL-terminated and has no access to ->len,
  - on success getdelim(3) NUL-terminates the buffer and we set ->len,
  - on error we either call strbuf_init() or strbuf_reset().

Remove the superfluous preparatory call.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 strbuf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 764b629927..44955669e8 100644
=2D-- a/strbuf.c
+++ b/strbuf.c
@@ -646,8 +646,6 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, i=
nt term)
 	if (feof(fp))
 		return EOF;
=20
-	strbuf_reset(sb);
-
 	/* Translate slopbuf to NULL, as we cannot call realloc on it */
 	if (!sb->alloc)
 		sb->buf =3D NULL;
=2D-=20
2.55.0
