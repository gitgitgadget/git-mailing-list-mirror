Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E9DCDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 20:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442635AbjJLUFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 16:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442407AbjJLUFF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 16:05:05 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67066BB
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 13:05:02 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c8a1541233so11349055ad.1
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 13:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fxue.dev; s=google; t=1697141101; x=1697745901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y1uq66DVqSzNcx6Yxwijls3Hbfd9RBOJml5vEN9qNsI=;
        b=SV9vaVksf7i6XBVzTJAeOtA6FNIShrhTayWFxY7BIYVjxILMQD2vAuoDkaOYdOo+WJ
         JYuoSc88yOYcI1OcLnGQo7umIwXvUiFps2MLPlvZ13VwyasvGMOpxyBIGHq2WNyIkUfQ
         sKIlujxcx0nLts3BuPsRQklWCa4fA447vpk675mmjM6lsMifLQxhB59atRzcbPyYnebN
         iZxvQpvjygURpBMUDq2z6w+t79XTOaGj08yEeHlCJtEYOYCMDFrvfzpyZetHqhyfqSab
         TgB7ZgRGBprIDcNSBNkTkDFRQBqKUIvtDR4blebAHsOukz2if3Humd+2RyZ4g2Qw3VVt
         /7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697141101; x=1697745901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1uq66DVqSzNcx6Yxwijls3Hbfd9RBOJml5vEN9qNsI=;
        b=iBCOxQognxY2gh6mY9s5XckB0vHfYUez06X05T89Q3wB0KqwkK7MhhJsI0O5cSkrQK
         ACEcLyFTxYcx3sd6wwVjiwXssuTbUhcdyWvyJiNxLNq41Axx/FmT2YXgoXGfknOVDbuQ
         mq/5IcQUgPQo+r/rqykV+ZIMJMzn4TN+TeMsusGpwoa1bXzUIWdi6T7uosZoPCJcjIqf
         5u4eN5SkxvGPwROqM5TV8JFRxBRY1rSlTDaozTM8N2xObKfO0HXHu4ndVnifzL8DDCYK
         E46rbK1mRmYnNf3DM0yt8JS15RgwbqLWPpYVBuhdMVsmXyASTQPLDFtfpfqfr0GnPfuw
         Lf/g==
X-Gm-Message-State: AOJu0YwksVNUfUtrdS21BEZQptn00NbjqzHu1x8iHZRFkvX5E14PXPIJ
        HJSXdSdXcG0HaEF8gWTntenvNGQF9di6NlczbqOpnA==
X-Google-Smtp-Source: AGHT+IFf0+eH+I5g0Tulh47LOtR6X+GGKOny8THdIouyOpV58EFGggJzx1Sf1EPNtor+t8noNVoQCg==
X-Received: by 2002:a17:903:192:b0:1c8:9bc6:2a09 with SMTP id z18-20020a170903019200b001c89bc62a09mr15057181plg.15.1697141100938;
        Thu, 12 Oct 2023 13:05:00 -0700 (PDT)
Received: from fleeb.corp.roku (slip-12-66-24-102.mis.prserv.net. [12.66.24.102])
        by smtp.gmail.com with ESMTPSA id z17-20020a170903019100b001c62b9a51a4sm2367686plg.239.2023.10.12.13.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:05:00 -0700 (PDT)
From:   Feiyang Xue <hi@fxue.dev>
To:     git@vger.kernel.org
Cc:     Feiyang Xue <hi@fxue.dev>
Subject: [PATCH] Add x64 SHA-NI implementation to sha1 and sha256 in git ?
Date:   Thu, 12 Oct 2023 15:04:47 -0500
Message-ID: <20231012200447.3553757-1-hi@fxue.dev>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looking for comments on if this is a good idea to add SHA-NI option to git,=
 =0D
And if so, what'd be a good implementation.=0D
=0D
The attached patch is more of a proof of concept,  using a sha-ni example =
=0D
found on internet and have it tapped into git's "hash-ll.h" when it sees ma=
ke =0D
flags "SHA1_SHANI=3D1" and/or "SHA256_SHANI=3D1" for sha1/sha256 respective=
ly.=0D
=0D
"git hash-object" is about 3-ish times faster for me=0D
=0D
There are few topics that i'm uncertain about. =0D
=0D
1. Is it good idea to have machine-specific asm codes in git. I read there =
was =0D
commit fd1ec82547 which removed assembly implementation for PPC_SHA1. Does =
that =0D
imply maintainers doesn't want machine-specific assembly in source?=0D
=0D
2. If it is cool to have machine-specific codes in git, what's a good logic=
 for=0D
their on/off? Build time flag? Run time flag? Run time automatic detection =
to =0D
corresponding instructions? =0D
=0D
3. If i can include machine-specific codes, what'd be a good way/idea to cl=
eanup=0D
the asm? I suppose git maintainers do not want someone else's license heade=
r?=0D
=0D
Regards,=0D
Feiyang=0D
=0D
=0D
---=0D
 Makefile                                      |  28 ++=0D
 hash-ll.h                                     |   8 +-=0D
 .../intel_sha_extensions_sha1_assembly.asm    | 308 +++++++++++++++=0D
 sha1-x64shani/sha1_x64.c                      |  71 ++++=0D
 sha1-x64shani/sha1_x64.h                      |  21 +=0D
 .../intel_sha_extensions_sha256_assembly.asm  | 371 ++++++++++++++++++=0D
 sha256-x64shani/sha256_x64.c                  |  82 ++++=0D
 sha256-x64shani/sha256_x64.h                  |  23 ++=0D
 8 files changed, 910 insertions(+), 2 deletions(-)=0D
 create mode 100644 sha1-x64shani/intel_sha_extensions_sha1_assembly.asm=0D
 create mode 100644 sha1-x64shani/sha1_x64.c=0D
 create mode 100644 sha1-x64shani/sha1_x64.h=0D
 create mode 100644 sha256-x64shani/intel_sha_extensions_sha256_assembly.as=
m=0D
 create mode 100644 sha256-x64shani/sha256_x64.c=0D
 create mode 100644 sha256-x64shani/sha256_x64.h=0D
=0D
diff --git a/Makefile b/Makefile=0D
index e440728c24..6892af2ee5 100644=0D
--- a/Makefile=0D
+++ b/Makefile=0D
@@ -1917,6 +1917,11 @@ ifdef PPC_SHA1=0D
 $(error the PPC_SHA1 flag has been removed along with the PowerPC-specific=
 SHA-1 implementation.)=0D
 endif=0D
 =0D
+ifdef SHA1_SHANI=0D
+	LIB_OBJS +=3D sha1-x64shani/sha1_x64.o=0D
+	LIB_OBJS +=3D sha1-x64shani/intel_sha_extensions_sha1_assembly.o=0D
+	BASIC_CFLAGS +=3D -DSHA1_SHANI=0D
+else=0D
 ifdef OPENSSL_SHA1=0D
 	EXTLIBS +=3D $(LIB_4_CRYPTO)=0D
 	BASIC_CFLAGS +=3D -DSHA1_OPENSSL=0D
@@ -1957,7 +1962,13 @@ endif=0D
 endif=0D
 endif=0D
 endif=0D
+endif=0D
 =0D
+ifdef SHA256_SHANI=0D
+	LIB_OBJS +=3D sha256-x64shani/sha256_x64.o=0D
+	LIB_OBJS +=3D sha256-x64shani/intel_sha_extensions_sha256_assembly.o=0D
+	BASIC_CFLAGS +=3D -DSHA256_SHANI=0D
+else=0D
 ifdef OPENSSL_SHA256=0D
 	EXTLIBS +=3D $(LIB_4_CRYPTO)=0D
 	BASIC_CFLAGS +=3D -DSHA256_OPENSSL=0D
@@ -1975,6 +1986,9 @@ else=0D
 endif=0D
 endif=0D
 endif=0D
+endif=0D
+=0D
+$(info $$LIB_OBJS is [${LIB_OBJS}])=0D
 =0D
 ifdef SHA1_MAX_BLOCK_SIZE=0D
 	LIB_OBJS +=3D compat/sha1-chunked.o=0D
@@ -2711,6 +2725,20 @@ missing_compdb_dir =3D=0D
 compdb_args =3D=0D
 endif=0D
 =0D
+$(info $$OBJECTS is [${OBJECTS}])=0D
+=0D
+### for SHA-NI =0D
+YASM_SRC :=3D $(wildcard $(OBJECTS:o=3Dasm))=0D
+YASM_OBJ :=3D $(YASM_SRC:asm=3Do)=0D
+OBJECTS :=3D $(filter-out $(YASM_OBJ),$(OBJECTS))=0D
+=0D
+$(info $$YASM_SRC is [${YASM_SRC}])=0D
+$(info $$YASM_OBJ is [${YASM_OBJ}])=0D
+$(info $$OBJECTS is [${OBJECTS}])=0D
+=0D
+$(YASM_OBJ): %.o: %.asm $(missing_dep_dirs)=0D
+	$(QUIET_CC)yasm $< -f elf64 -X gnu -g dwarf2 -o $@=0D
+=0D
 $(OBJECTS): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)=
=0D
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EX=
TRA_CPPFLAGS) $<=0D
 =0D
diff --git a/hash-ll.h b/hash-ll.h=0D
index 8050925137..31d9e91f26 100644=0D
--- a/hash-ll.h=0D
+++ b/hash-ll.h=0D
@@ -1,7 +1,9 @@=0D
 #ifndef HASH_LL_H=0D
 #define HASH_LL_H=0D
 =0D
-#if defined(SHA1_APPLE)=0D
+#if defined(SHA1_SHANI)=0D
+#include "sha1-x64shani/sha1_x64.h"=0D
+#elif defined(SHA1_APPLE)=0D
 #include <CommonCrypto/CommonDigest.h>=0D
 #elif defined(SHA1_OPENSSL)=0D
 #include <openssl/sha.h>=0D
@@ -11,7 +13,9 @@=0D
 #include "block-sha1/sha1.h"=0D
 #endif=0D
 =0D
-#if defined(SHA256_NETTLE)=0D
+#if defined(SHA256_SHANI)=0D
+#include "sha256-x64shani/sha256_x64.h"=0D
+#elif defined(SHA256_NETTLE)=0D
 #include "sha256/nettle.h"=0D
 #elif defined(SHA256_GCRYPT)=0D
 #define SHA256_NEEDS_CLONE_HELPER=0D
diff --git a/sha1-x64shani/intel_sha_extensions_sha1_assembly.asm b/sha1-x6=
4shani/intel_sha_extensions_sha1_assembly.asm=0D
new file mode 100644=0D
index 0000000000..ba59825966=0D
--- /dev/null=0D
+++ b/sha1-x64shani/intel_sha_extensions_sha1_assembly.asm=0D
@@ -0,0 +1,308 @@=0D
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;=
;;;;;;=0D
+; Copyright (c) 2013, Intel Corporation =0D
+; =0D
+; All rights reserved. =0D
+; =0D
+; Redistribution and use in source and binary forms, with or without=0D
+; modification, are permitted provided that the following conditions are=0D
+; met: =0D
+; =0D
+; * Redistributions of source code must retain the above copyright=0D
+;   notice, this list of conditions and the following disclaimer.  =0D
+; =0D
+; * Redistributions in binary form must reproduce the above copyright=0D
+;   notice, this list of conditions and the following disclaimer in the=0D
+;   documentation and/or other materials provided with the=0D
+;   distribution. =0D
+; =0D
+; * Neither the name of the Intel Corporation nor the names of its=0D
+;   contributors may be used to endorse or promote products derived from=0D
+;   this software without specific prior written permission. =0D
+; =0D
+; =0D
+; THIS SOFTWARE IS PROVIDED BY INTEL CORPORATION ""AS IS"" AND ANY=0D
+; EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE=0D
+; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR=0D
+; PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL INTEL CORPORATION OR=0D
+; CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,=0D
+; EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0D
+; PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR=0D
+; PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF=0D
+; LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING=0D
+; NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS=0D
+; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.=0D
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;=
;;;;;;=0D
+;=0D
+; Intel SHA Extensions optimized implementation of a SHA-1 update function=
 =0D
+;=0D
+; The function takes a pointer to the current hash values, a pointer to th=
e =0D
+; input data, and a number of 64 byte blocks to process.  Once all blocks =
have =0D
+; been processed, the digest pointer is  updated with the resulting hash v=
alue.=0D
+; The function only processes complete blocks, there is no functionality t=
o =0D
+; store partial blocks.  All message padding and hash value initialization=
 must=0D
+; be done outside the update function.  =0D
+;=0D
+; The indented lines in the loop are instructions related to rounds proces=
sing.=0D
+; The non-indented lines are instructions related to the message schedule.=
=0D
+;=0D
+; Author: Sean Gulley <sean.m.gulley@intel.com>=0D
+; Date:   July 2013=0D
+;=0D
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;=
;;;;;;=0D
+;=0D
+; Example YASM command lines:=0D
+; Windows:  =0D
+;  yasm -Xvc -f x64 -rnasm -pnasm -DWINABI -o intel_sha_extensions_sha1_as=
sembly.obj -g cv8 intel_sha_extensions_sha1_assembly.asm=0D
+; Linux:    =0D
+;  yasm -f elf64 -X gnu -g dwarf2 -o intel_sha_extensions_sha1_assembly.o =
intel_sha_extensions_sha1_assembly.asm=0D
+;=0D
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;=
;;;;;;=0D
+=0D
+%ifdef WINABI=0D
+%define DIGEST_PTR	rcx 	; 1st arg=0D
+%define DATA_PTR	rdx 	; 2nd arg=0D
+%define NUM_BLKS 	r8	; 3rd arg=0D
+%else=0D
+%define DIGEST_PTR	rdi	; 1st arg=0D
+%define DATA_PTR	rsi	; 2nd arg=0D
+%define NUM_BLKS	rdx	; 3rd arg=0D
+%endif=0D
+=0D
+%define RSPSAVE		rax=0D
+=0D
+struc frame=0D
+%ifdef WINABI=0D
+.xmm_save:	resdq	2=0D
+%endif=0D
+.hash_save:	resdq	2=0D
+endstruc=0D
+=0D
+%define ABCD		xmm0=0D
+%define E0		xmm1	; Need two E's b/c they ping pong=0D
+%define E1		xmm2=0D
+%define MSG0		xmm3=0D
+%define MSG1		xmm4=0D
+%define MSG2		xmm5=0D
+%define MSG3		xmm6=0D
+%define SHUF_MASK	xmm7=0D
+=0D
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;=
;;;;;;=0D
+;; void sha1_update(uint32_t *digest, const void *data, uint32_t numBlocks=
);=0D
+;; arg 1 : pointer to digest=0D
+;; arg 2 : pointer to input data=0D
+;; arg 3 : Number of blocks to process=0D
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;=
;;;;;;=0D
+section .text=0D
+global sha1_update:function=0D
+align 32=0D
+sha1_update:=0D
+	mov		RSPSAVE, rsp=0D
+	sub		rsp, frame_size=0D
+	and		rsp, ~0xF=0D
+=0D
+%ifdef WINABI=0D
+	movdqa		[rsp + frame.xmm_save + 0*16], xmm6=0D
+	movdqa		[rsp + frame.xmm_save + 1*16], xmm7=0D
+%endif=0D
+=0D
+	shl		NUM_BLKS, 6		; convert to bytes=0D
+	jz		.done_hash=0D
+	add		NUM_BLKS, DATA_PTR	; pointer to end of data=0D
+=0D
+	;; load initial hash values=0D
+	pinsrd		E0,   [DIGEST_PTR + 1*16], 3=0D
+	movdqu		ABCD, [DIGEST_PTR + 0*16]=0D
+	pand		E0,   [UPPER_WORD_MASK wrt rip]=0D
+	pshufd		ABCD, ABCD, 0x1B=0D
+=0D
+	movdqa		SHUF_MASK, [PSHUFFLE_BYTE_FLIP_MASK wrt rip]=0D
+=0D
+.loop0:=0D
+	;; Save hash values for addition after rounds=0D
+	movdqa		[rsp + frame.hash_save + 0*16], E0=0D
+	movdqa		[rsp + frame.hash_save + 1*16], ABCD=0D
+=0D
+	;; Rounds 0-3=0D
+	movdqu		MSG0, [DATA_PTR + 0*16]=0D
+	pshufb		MSG0, SHUF_MASK=0D
+		paddd		E0, MSG0=0D
+		movdqa		E1, ABCD=0D
+		sha1rnds4	ABCD, E0, 0=0D
+=0D
+	;; Rounds 4-7=0D
+	movdqu		MSG1, [DATA_PTR + 1*16]=0D
+	pshufb		MSG1, SHUF_MASK=0D
+		sha1nexte	E1, MSG1=0D
+		movdqa		E0, ABCD=0D
+		sha1rnds4	ABCD, E1, 0=0D
+	sha1msg1	MSG0, MSG1=0D
+=0D
+	;; Rounds 8-11=0D
+	movdqu		MSG2, [DATA_PTR + 2*16]=0D
+	pshufb		MSG2, SHUF_MASK=0D
+		sha1nexte	E0, MSG2=0D
+		movdqa		E1, ABCD=0D
+		sha1rnds4	ABCD, E0, 0=0D
+	sha1msg1	MSG1, MSG2=0D
+	pxor		MSG0, MSG2=0D
+=0D
+	;; Rounds 12-15=0D
+	movdqu		MSG3, [DATA_PTR + 3*16]=0D
+	pshufb		MSG3, SHUF_MASK=0D
+		sha1nexte	E1, MSG3=0D
+		movdqa		E0, ABCD=0D
+	sha1msg2	MSG0, MSG3=0D
+		sha1rnds4	ABCD, E1, 0=0D
+	sha1msg1	MSG2, MSG3=0D
+	pxor		MSG1, MSG3=0D
+=0D
+	;; Rounds 16-19=0D
+		sha1nexte	E0, MSG0=0D
+		movdqa		E1, ABCD=0D
+	sha1msg2	MSG1, MSG0=0D
+		sha1rnds4	ABCD, E0, 0=0D
+	sha1msg1	MSG3, MSG0=0D
+	pxor		MSG2, MSG0=0D
+	=0D
+	;; Rounds 20-23=0D
+		sha1nexte	E1, MSG1=0D
+		movdqa		E0, ABCD=0D
+	sha1msg2	MSG2, MSG1=0D
+		sha1rnds4	ABCD, E1, 1=0D
+	sha1msg1	MSG0, MSG1=0D
+	pxor		MSG3, MSG1=0D
+	=0D
+	;; Rounds 24-27=0D
+		sha1nexte	E0, MSG2=0D
+		movdqa		E1, ABCD=0D
+	sha1msg2	MSG3, MSG2=0D
+		sha1rnds4	ABCD, E0, 1=0D
+	sha1msg1	MSG1, MSG2=0D
+	pxor		MSG0, MSG2=0D
+	=0D
+	;; Rounds 28-31=0D
+		sha1nexte	E1, MSG3=0D
+		movdqa		E0, ABCD=0D
+	sha1msg2	MSG0, MSG3=0D
+		sha1rnds4	ABCD, E1, 1=0D
+	sha1msg1	MSG2, MSG3=0D
+	pxor		MSG1, MSG3=0D
+=0D
+	;; Rounds 32-35=0D
+		sha1nexte	E0, MSG0=0D
+		movdqa		E1, ABCD=0D
+	sha1msg2	MSG1, MSG0=0D
+		sha1rnds4	ABCD, E0, 1=0D
+	sha1msg1	MSG3, MSG0=0D
+	pxor		MSG2, MSG0=0D
+	=0D
+	;; Rounds 36-39=0D
+		sha1nexte	E1, MSG1=0D
+		movdqa		E0, ABCD=0D
+	sha1msg2	MSG2, MSG1=0D
+		sha1rnds4	ABCD, E1, 1=0D
+	sha1msg1	MSG0, MSG1=0D
+	pxor		MSG3, MSG1=0D
+	=0D
+	;; Rounds 40-43=0D
+		sha1nexte	E0, MSG2=0D
+		movdqa		E1, ABCD=0D
+	sha1msg2	MSG3, MSG2=0D
+		sha1rnds4	ABCD, E0, 2=0D
+	sha1msg1	MSG1, MSG2=0D
+	pxor		MSG0, MSG2=0D
+	=0D
+	;; Rounds 44-47=0D
+		sha1nexte	E1, MSG3=0D
+		movdqa		E0, ABCD=0D
+	sha1msg2	MSG0, MSG3=0D
+		sha1rnds4	ABCD, E1, 2=0D
+	sha1msg1	MSG2, MSG3=0D
+	pxor		MSG1, MSG3=0D
+=0D
+	;; Rounds 48-51=0D
+		sha1nexte	E0, MSG0=0D
+		movdqa		E1, ABCD=0D
+	sha1msg2	MSG1, MSG0=0D
+		sha1rnds4	ABCD, E0, 2=0D
+	sha1msg1	MSG3, MSG0=0D
+	pxor		MSG2, MSG0=0D
+	=0D
+	;; Rounds 52-55=0D
+		sha1nexte	E1, MSG1=0D
+		movdqa		E0, ABCD=0D
+	sha1msg2	MSG2, MSG1=0D
+		sha1rnds4	ABCD, E1, 2=0D
+	sha1msg1	MSG0, MSG1=0D
+	pxor		MSG3, MSG1=0D
+	=0D
+	;; Rounds 56-59=0D
+		sha1nexte	E0, MSG2=0D
+		movdqa		E1, ABCD=0D
+	sha1msg2	MSG3, MSG2=0D
+		sha1rnds4	ABCD, E0, 2=0D
+	sha1msg1	MSG1, MSG2=0D
+	pxor		MSG0, MSG2=0D
+	=0D
+	;; Rounds 60-63=0D
+		sha1nexte	E1, MSG3=0D
+		movdqa		E0, ABCD=0D
+	sha1msg2	MSG0, MSG3=0D
+		sha1rnds4	ABCD, E1, 3=0D
+	sha1msg1	MSG2, MSG3=0D
+	pxor		MSG1, MSG3=0D
+=0D
+	;; Rounds 64-67=0D
+		sha1nexte	E0, MSG0=0D
+		movdqa		E1, ABCD=0D
+	sha1msg2	MSG1, MSG0=0D
+		sha1rnds4	ABCD, E0, 3=0D
+	sha1msg1	MSG3, MSG0=0D
+	pxor		MSG2, MSG0=0D
+	=0D
+	;; Rounds 68-71=0D
+		sha1nexte	E1, MSG1=0D
+		movdqa		E0, ABCD=0D
+	sha1msg2	MSG2, MSG1=0D
+		sha1rnds4	ABCD, E1, 3=0D
+	pxor		MSG3, MSG1=0D
+	=0D
+	;; Rounds 72-75=0D
+		sha1nexte	E0, MSG2=0D
+		movdqa		E1, ABCD=0D
+	sha1msg2	MSG3, MSG2=0D
+		sha1rnds4	ABCD, E0, 3=0D
+	=0D
+	;; Rounds 76-79=0D
+		sha1nexte	E1, MSG3=0D
+		movdqa		E0, ABCD=0D
+		sha1rnds4	ABCD, E1, 3=0D
+=0D
+	;; Add current hash values with previously saved=0D
+	sha1nexte	E0,   [rsp + frame.hash_save + 0*16]=0D
+	paddd		ABCD, [rsp + frame.hash_save + 1*16]=0D
+=0D
+	;; Increment data pointer and loop if more to process=0D
+	add		DATA_PTR, 64=0D
+	cmp		DATA_PTR, NUM_BLKS=0D
+	jne		.loop0=0D
+=0D
+	;; Write hash values back in the correct order=0D
+	pshufd		ABCD, ABCD, 0x1B=0D
+	movdqu		[DIGEST_PTR + 0*16], ABCD=0D
+	pextrd		[DIGEST_PTR + 1*16], E0, 3=0D
+=0D
+.done_hash:=0D
+%ifdef WINABI=0D
+	movdqa		xmm6, [rsp + frame.xmm_save + 0*16]=0D
+	movdqa		xmm7, [rsp + frame.xmm_save + 1*16]=0D
+%endif=0D
+	mov		rsp, RSPSAVE=0D
+=0D
+	ret	=0D
+=0D
+section .data=0D
+align 64=0D
+PSHUFFLE_BYTE_FLIP_MASK: ddq 0x000102030405060708090a0b0c0d0e0f=0D
+UPPER_WORD_MASK:         ddq 0xFFFFFFFF000000000000000000000000=0D
+=0D
diff --git a/sha1-x64shani/sha1_x64.c b/sha1-x64shani/sha1_x64.c=0D
new file mode 100644=0D
index 0000000000..0ed0d49ed6=0D
--- /dev/null=0D
+++ b/sha1-x64shani/sha1_x64.c=0D
@@ -0,0 +1,71 @@=0D
+#include "../git-compat-util.h"=0D
+#include "sha1_x64.h"=0D
+#include <byteswap.h>=0D
+=0D
+// static inline void shani_SHA1_Init(shani_SHA_CTX *c);=0D
+=0D
+void shani_SHA1_Init(shani_SHA_CTX *c)=0D
+{=0D
+    static const uint32_t sha1InitialDigest[5] =3D {=0D
+           0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476, 0xc3d2e1f0=0D
+    };=0D
+    memcpy(c->h, sha1InitialDigest, 20);=0D
+    c->len =3D 0;=0D
+    c->total_len =3D 0;=0D
+}=0D
+=0D
+void sha1_update(void *c, const void *d, int l);=0D
+void shani_SHA1_Update(shani_SHA_CTX *c, const void *data, unsigned long l=
en)=0D
+{=0D
+    while (len > 0)=0D
+    {=0D
+        if (c->len =3D=3D 0 && len >=3D 64)=0D
+        {=0D
+            sha1_update(c->h, data, len/64);=0D
+            unsigned long bytes_hashed =3D (len/64)*64;=0D
+            data +=3D bytes_hashed;=0D
+            len -=3D bytes_hashed;=0D
+            c->total_len +=3D bytes_hashed;=0D
+            continue;=0D
+        }=0D
+#define MIN(x, y) (((x) < (y)) ? (x) : (y))=0D
+        size_t cpy =3D MIN(64 - c->len, len);=0D
+#undef MIN=0D
+        memcpy(c->msgbuf + c->len, data, cpy);=0D
+        data +=3D cpy;=0D
+        len -=3D cpy;=0D
+        c->len +=3D cpy;=0D
+        c->total_len +=3D cpy;=0D
+=0D
+        if (c->len =3D=3D 64)=0D
+        {=0D
+            sha1_update(c->h, c->msgbuf, 1);=0D
+            c->len =3D 0;=0D
+        }=0D
+    }=0D
+}=0D
+=0D
+void shani_SHA1_Final(unsigned char *md, shani_SHA_CTX *c)=0D
+{=0D
+    c->msgbuf[c->len] =3D 0x80;=0D
+    ++c->len;=0D
+    memset(c->msgbuf + c->len, 0, 64 - c->len);=0D
+    if (c->len > (64-8))=0D
+    {=0D
+        sha1_update(c->h, c->msgbuf, 1);=0D
+        memset(c->msgbuf, 0, 64);=0D
+        c->len =3D 0;=0D
+    }=0D
+=0D
+    for (int ibyte =3D 0; ibyte < 8; ++ibyte)=0D
+       c->msgbuf[63-ibyte] =3D (uint8_t)((c->total_len * 8ULL) >> (ibyte*8=
));=0D
+=0D
+    sha1_update(c->h, c->msgbuf, 1);=0D
+    c->len =3D 0;    =0D
+=0D
+    // flip endianness=0D
+    int i;=0D
+    for (i =3D 0; i < 20; i +=3D 4) {=0D
+        *(uint32_t *)(md + i) =3D __bswap_32(c->h[i / 4]);=0D
+    }=0D
+}=0D
diff --git a/sha1-x64shani/sha1_x64.h b/sha1-x64shani/sha1_x64.h=0D
new file mode 100644=0D
index 0000000000..ca1ec116cf=0D
--- /dev/null=0D
+++ b/sha1-x64shani/sha1_x64.h=0D
@@ -0,0 +1,21 @@=0D
+/*=0D
+ * SHA1 routine using x64 SHA-NI instructions=0D
+ */=0D
+=0D
+typedef struct shani_SHA_CTX=0D
+{=0D
+    uint32_t h[5];=0D
+    int len;=0D
+    uint64_t total_len;=0D
+    char msgbuf[64];=0D
+} shani_SHA_CTX;=0D
+=0D
+=0D
+void shani_SHA1_Init(shani_SHA_CTX *ctx);=0D
+void shani_SHA1_Update(shani_SHA_CTX *ctx, const void *dataIn, size_t len)=
;=0D
+void shani_SHA1_Final(unsigned char hashout[20], shani_SHA_CTX *ctx);=0D
+=0D
+#define platform_SHA_CTX	shani_SHA_CTX=0D
+#define platform_SHA1_Init	shani_SHA1_Init=0D
+#define platform_SHA1_Update	shani_SHA1_Update=0D
+#define platform_SHA1_Final	shani_SHA1_Final=0D
diff --git a/sha256-x64shani/intel_sha_extensions_sha256_assembly.asm b/sha=
256-x64shani/intel_sha_extensions_sha256_assembly.asm=0D
new file mode 100644=0D
index 0000000000..b587e82154=0D
--- /dev/null=0D
+++ b/sha256-x64shani/intel_sha_extensions_sha256_assembly.asm=0D
@@ -0,0 +1,371 @@=0D
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;=
;;;;;;=0D
+; Copyright (c) 2013, Intel Corporation =0D
+; =0D
+; All rights reserved. =0D
+; =0D
+; Redistribution and use in source and binary forms, with or without=0D
+; modification, are permitted provided that the following conditions are=0D
+; met: =0D
+; =0D
+; * Redistributions of source code must retain the above copyright=0D
+;   notice, this list of conditions and the following disclaimer.  =0D
+; =0D
+; * Redistributions in binary form must reproduce the above copyright=0D
+;   notice, this list of conditions and the following disclaimer in the=0D
+;   documentation and/or other materials provided with the=0D
+;   distribution. =0D
+; =0D
+; * Neither the name of the Intel Corporation nor the names of its=0D
+;   contributors may be used to endorse or promote products derived from=0D
+;   this software without specific prior written permission. =0D
+; =0D
+; =0D
+; THIS SOFTWARE IS PROVIDED BY INTEL CORPORATION ""AS IS"" AND ANY=0D
+; EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE=0D
+; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR=0D
+; PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL INTEL CORPORATION OR=0D
+; CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,=0D
+; EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0D
+; PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR=0D
+; PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF=0D
+; LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING=0D
+; NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS=0D
+; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.=0D
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;=
;;;;;;=0D
+;=0D
+; Intel SHA Extensions optimized implementation of a SHA-256 update functi=
on =0D
+;=0D
+; The function takes a pointer to the current hash values, a pointer to th=
e =0D
+; input data, and a number of 64 byte blocks to process.  Once all blocks =
have =0D
+; been processed, the digest pointer is  updated with the resulting hash v=
alue.=0D
+; The function only processes complete blocks, there is no functionality t=
o =0D
+; store partial blocks.  All message padding and hash value initialization=
 must=0D
+; be done outside the update function.  =0D
+;=0D
+; The indented lines in the loop are instructions related to rounds proces=
sing.=0D
+; The non-indented lines are instructions related to the message schedule.=
=0D
+;=0D
+; Author: Sean Gulley <sean.m.gulley@intel.com>=0D
+; Date:   July 2013=0D
+;=0D
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;=
;;;;;=0D
+;=0D
+; Example YASM command lines:=0D
+; Windows:  yasm -Xvc -f x64 -rnasm -pnasm -DWINABI -o intel_sha_extension=
s_sha256_assembly.obj -g cv8 intel_sha_extensions_sha256_assembly.asm=0D
+; Linux:    yasm -f elf64 -X gnu -g dwarf2 -o intel_sha_extensions_sha256_=
assembly.o intel_sha_extensions_sha256_assembly.asm=0D
+;=0D
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;=
;;;;;;=0D
+=0D
+%ifdef WINABI=0D
+%define DIGEST_PTR	rcx 	; 1st arg=0D
+%define DATA_PTR	rdx 	; 2nd arg=0D
+%define NUM_BLKS 	r8	; 3rd arg=0D
+%else=0D
+%define DIGEST_PTR	rdi	; 1st arg=0D
+%define DATA_PTR	rsi	; 2nd arg=0D
+%define NUM_BLKS	rdx	; 3rd arg=0D
+%endif=0D
+=0D
+%define SHA256CONSTANTS	rax=0D
+=0D
+%ifdef WINABI=0D
+%define RSPSAVE		r9=0D
+=0D
+struc frame=0D
+.xmm_save:	resdq	5=0D
+endstruc=0D
+%endif=0D
+=0D
+%define MSG		xmm0=0D
+%define STATE0		xmm1=0D
+%define STATE1		xmm2=0D
+%define MSGTMP0		xmm3=0D
+%define MSGTMP1		xmm4=0D
+%define MSGTMP2		xmm5=0D
+%define MSGTMP3		xmm6=0D
+%define MSGTMP4		xmm7=0D
+=0D
+%define SHUF_MASK	xmm8=0D
+=0D
+%define ABEF_SAVE	xmm9=0D
+%define CDGH_SAVE	xmm10=0D
+=0D
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;=
;;;;;;=0D
+;; void sha256_update(uint32_t *digest, const void *data, uint32_t numBloc=
ks);=0D
+;; arg 1 : pointer to digest=0D
+;; arg 2 : pointer to input data=0D
+;; arg 3 : Number of blocks to process=0D
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;=
;;;;;;=0D
+section .text=0D
+global sha256_update:function=0D
+align 32=0D
+sha256_update:=0D
+%ifdef WINABI=0D
+	mov		RSPSAVE, rsp=0D
+	sub		rsp, frame_size=0D
+	and		rsp, ~0xF=0D
+=0D
+	movdqa		[rsp + frame.xmm_save + 0*16], xmm6=0D
+	movdqa		[rsp + frame.xmm_save + 1*16], xmm7=0D
+	movdqa		[rsp + frame.xmm_save + 2*16], xmm8=0D
+	movdqa		[rsp + frame.xmm_save + 3*16], xmm9=0D
+	movdqa		[rsp + frame.xmm_save + 4*16], xmm10=0D
+%endif=0D
+=0D
+	shl		NUM_BLKS, 6		; convert to bytes=0D
+	jz		.done_hash=0D
+	add		NUM_BLKS, DATA_PTR	; pointer to end of data=0D
+=0D
+	;; load initial hash values=0D
+	;; Need to reorder these appropriately=0D
+	;; DCBA, HGFE -> ABEF, CDGH=0D
+	movdqu		STATE0, [DIGEST_PTR + 0*16]=0D
+	movdqu		STATE1, [DIGEST_PTR + 1*16]=0D
+=0D
+	pshufd		STATE0,  STATE0,  0xB1	; CDAB=0D
+	pshufd		STATE1,  STATE1,  0x1B	; EFGH=0D
+	movdqa		MSGTMP4, STATE0=0D
+	palignr		STATE0,  STATE1,  8	; ABEF=0D
+	pblendw		STATE1,  MSGTMP4, 0xF0	; CDGH=0D
+=0D
+	movdqa		SHUF_MASK, [PSHUFFLE_BYTE_FLIP_MASK wrt rip]=0D
+	lea		SHA256CONSTANTS,[K256 wrt rip]=0D
+=0D
+.loop0:=0D
+	;; Save hash values for addition after rounds=0D
+	movdqa		ABEF_SAVE, STATE0=0D
+	movdqa		CDGH_SAVE, STATE1=0D
+=0D
+	;; Rounds 0-3=0D
+	movdqu		MSG, [DATA_PTR + 0*16]=0D
+	pshufb		MSG, SHUF_MASK=0D
+	movdqa		MSGTMP0, MSG=0D
+		paddd		MSG, [SHA256CONSTANTS + 0*16]=0D
+		sha256rnds2	STATE1, STATE0=0D
+		pshufd 		MSG, MSG, 0x0E=0D
+		sha256rnds2	STATE0, STATE1=0D
+=0D
+	;; Rounds 4-7=0D
+	movdqu		MSG, [DATA_PTR + 1*16]=0D
+	pshufb		MSG, SHUF_MASK=0D
+	movdqa		MSGTMP1, MSG=0D
+		paddd		MSG, [SHA256CONSTANTS + 1*16]=0D
+		sha256rnds2	STATE1, STATE0=0D
+		pshufd 		MSG, MSG, 0x0E=0D
+		sha256rnds2	STATE0, STATE1=0D
+	sha256msg1	MSGTMP0, MSGTMP1=0D
+=0D
+	;; Rounds 8-11=0D
+	movdqu		MSG, [DATA_PTR + 2*16]=0D
+	pshufb		MSG, SHUF_MASK=0D
+	movdqa		MSGTMP2, MSG=0D
+		paddd		MSG, [SHA256CONSTANTS + 2*16]=0D
+		sha256rnds2	STATE1, STATE0=0D
+		pshufd 		MSG, MSG, 0x0E=0D
+		sha256rnds2	STATE0, STATE1=0D
+	sha256msg1	MSGTMP1, MSGTMP2=0D
+=0D
+	;; Rounds 12-15=0D
+	movdqu		MSG, [DATA_PTR + 3*16]=0D
+	pshufb		MSG, SHUF_MASK=0D
+	movdqa		MSGTMP3, MSG=0D
+		paddd		MSG, [SHA256CONSTANTS + 3*16]=0D
+		sha256rnds2	STATE1, STATE0=0D
+	movdqa		MSGTMP4, MSGTMP3=0D
+	palignr		MSGTMP4, MSGTMP2, 4=0D
+	paddd		MSGTMP0, MSGTMP4=0D
+	sha256msg2	MSGTMP0, MSGTMP3=0D
+		pshufd 		MSG, MSG, 0x0E=0D
+		sha256rnds2	STATE0, STATE1=0D
+	sha256msg1	MSGTMP2, MSGTMP3=0D
+=0D
+	;; Rounds 16-19=0D
+	movdqa		MSG, MSGTMP0=0D
+		paddd		MSG, [SHA256CONSTANTS + 4*16]=0D
+		sha256rnds2	STATE1, STATE0=0D
+	movdqa		MSGTMP4, MSGTMP0=0D
+	palignr		MSGTMP4, MSGTMP3, 4=0D
+	paddd		MSGTMP1, MSGTMP4=0D
+	sha256msg2	MSGTMP1, MSGTMP0=0D
+		pshufd 		MSG, MSG, 0x0E=0D
+		sha256rnds2	STATE0, STATE1=0D
+	sha256msg1	MSGTMP3, MSGTMP0=0D
+=0D
+	;; Rounds 20-23=0D
+	movdqa		MSG, MSGTMP1=0D
+		paddd		MSG, [SHA256CONSTANTS + 5*16]=0D
+		sha256rnds2	STATE1, STATE0=0D
+	movdqa		MSGTMP4, MSGTMP1=0D
+	palignr		MSGTMP4, MSGTMP0, 4=0D
+	paddd		MSGTMP2, MSGTMP4=0D
+	sha256msg2	MSGTMP2, MSGTMP1=0D
+		pshufd 		MSG, MSG, 0x0E=0D
+		sha256rnds2	STATE0, STATE1=0D
+	sha256msg1	MSGTMP0, MSGTMP1=0D
+=0D
+	;; Rounds 24-27=0D
+	movdqa		MSG, MSGTMP2=0D
+		paddd		MSG, [SHA256CONSTANTS + 6*16]=0D
+		sha256rnds2	STATE1, STATE0=0D
+	movdqa		MSGTMP4, MSGTMP2=0D
+	palignr		MSGTMP4, MSGTMP1, 4=0D
+	paddd		MSGTMP3, MSGTMP4=0D
+	sha256msg2	MSGTMP3, MSGTMP2=0D
+		pshufd 		MSG, MSG, 0x0E=0D
+		sha256rnds2	STATE0, STATE1=0D
+	sha256msg1	MSGTMP1, MSGTMP2=0D
+=0D
+	;; Rounds 28-31=0D
+	movdqa		MSG, MSGTMP3=0D
+		paddd		MSG, [SHA256CONSTANTS + 7*16]=0D
+		sha256rnds2	STATE1, STATE0=0D
+	movdqa		MSGTMP4, MSGTMP3=0D
+	palignr		MSGTMP4, MSGTMP2, 4=0D
+	paddd		MSGTMP0, MSGTMP4=0D
+	sha256msg2	MSGTMP0, MSGTMP3=0D
+		pshufd 		MSG, MSG, 0x0E=0D
+		sha256rnds2	STATE0, STATE1=0D
+	sha256msg1	MSGTMP2, MSGTMP3=0D
+=0D
+	;; Rounds 32-35=0D
+	movdqa		MSG, MSGTMP0=0D
+		paddd		MSG, [SHA256CONSTANTS + 8*16]=0D
+		sha256rnds2	STATE1, STATE0=0D
+	movdqa		MSGTMP4, MSGTMP0=0D
+	palignr		MSGTMP4, MSGTMP3, 4=0D
+	paddd		MSGTMP1, MSGTMP4=0D
+	sha256msg2	MSGTMP1, MSGTMP0=0D
+		pshufd 		MSG, MSG, 0x0E=0D
+		sha256rnds2	STATE0, STATE1=0D
+	sha256msg1	MSGTMP3, MSGTMP0=0D
+=0D
+	;; Rounds 36-39=0D
+	movdqa		MSG, MSGTMP1=0D
+		paddd		MSG, [SHA256CONSTANTS + 9*16]=0D
+		sha256rnds2	STATE1, STATE0=0D
+	movdqa		MSGTMP4, MSGTMP1=0D
+	palignr		MSGTMP4, MSGTMP0, 4=0D
+	paddd		MSGTMP2, MSGTMP4=0D
+	sha256msg2	MSGTMP2, MSGTMP1=0D
+		pshufd 		MSG, MSG, 0x0E=0D
+		sha256rnds2	STATE0, STATE1=0D
+	sha256msg1	MSGTMP0, MSGTMP1=0D
+=0D
+	;; Rounds 40-43=0D
+	movdqa		MSG, MSGTMP2=0D
+		paddd		MSG, [SHA256CONSTANTS + 10*16]=0D
+		sha256rnds2	STATE1, STATE0=0D
+	movdqa		MSGTMP4, MSGTMP2=0D
+	palignr		MSGTMP4, MSGTMP1, 4=0D
+	paddd		MSGTMP3, MSGTMP4=0D
+	sha256msg2	MSGTMP3, MSGTMP2=0D
+		pshufd 		MSG, MSG, 0x0E=0D
+		sha256rnds2	STATE0, STATE1=0D
+	sha256msg1	MSGTMP1, MSGTMP2=0D
+=0D
+	;; Rounds 44-47=0D
+	movdqa		MSG, MSGTMP3=0D
+		paddd		MSG, [SHA256CONSTANTS + 11*16]=0D
+		sha256rnds2	STATE1, STATE0=0D
+	movdqa		MSGTMP4, MSGTMP3=0D
+	palignr		MSGTMP4, MSGTMP2, 4=0D
+	paddd		MSGTMP0, MSGTMP4=0D
+	sha256msg2	MSGTMP0, MSGTMP3=0D
+		pshufd 		MSG, MSG, 0x0E=0D
+		sha256rnds2	STATE0, STATE1=0D
+	sha256msg1	MSGTMP2, MSGTMP3=0D
+=0D
+	;; Rounds 48-51=0D
+	movdqa		MSG, MSGTMP0=0D
+		paddd		MSG, [SHA256CONSTANTS + 12*16]=0D
+		sha256rnds2	STATE1, STATE0=0D
+	movdqa		MSGTMP4, MSGTMP0=0D
+	palignr		MSGTMP4, MSGTMP3, 4=0D
+	paddd		MSGTMP1, MSGTMP4=0D
+	sha256msg2	MSGTMP1, MSGTMP0=0D
+		pshufd 		MSG, MSG, 0x0E=0D
+		sha256rnds2	STATE0, STATE1=0D
+	sha256msg1	MSGTMP3, MSGTMP0=0D
+=0D
+	;; Rounds 52-55=0D
+	movdqa		MSG, MSGTMP1=0D
+		paddd		MSG, [SHA256CONSTANTS + 13*16]=0D
+		sha256rnds2	STATE1, STATE0=0D
+	movdqa		MSGTMP4, MSGTMP1=0D
+	palignr		MSGTMP4, MSGTMP0, 4=0D
+	paddd		MSGTMP2, MSGTMP4=0D
+	sha256msg2	MSGTMP2, MSGTMP1=0D
+		pshufd 		MSG, MSG, 0x0E=0D
+		sha256rnds2	STATE0, STATE1=0D
+=0D
+	;; Rounds 56-59=0D
+	movdqa		MSG, MSGTMP2=0D
+		paddd		MSG, [SHA256CONSTANTS + 14*16]=0D
+		sha256rnds2	STATE1, STATE0=0D
+	movdqa		MSGTMP4, MSGTMP2=0D
+	palignr		MSGTMP4, MSGTMP1, 4=0D
+	paddd		MSGTMP3, MSGTMP4=0D
+	sha256msg2	MSGTMP3, MSGTMP2=0D
+		pshufd 		MSG, MSG, 0x0E=0D
+		sha256rnds2	STATE0, STATE1=0D
+=0D
+	;; Rounds 60-63=0D
+	movdqa		MSG, MSGTMP3=0D
+		paddd		MSG, [SHA256CONSTANTS + 15*16]=0D
+		sha256rnds2	STATE1, STATE0=0D
+		pshufd 		MSG, MSG, 0x0E=0D
+		sha256rnds2	STATE0, STATE1=0D
+=0D
+	;; Add current hash values with previously saved=0D
+	paddd		STATE0, ABEF_SAVE=0D
+	paddd		STATE1, CDGH_SAVE=0D
+=0D
+	;; Increment data pointer and loop if more to process=0D
+	add		DATA_PTR, 64=0D
+	cmp		DATA_PTR, NUM_BLKS=0D
+	jne		.loop0=0D
+=0D
+	;; Write hash values back in the correct order=0D
+	pshufd		STATE0,  STATE0,  0x1B	; FEBA=0D
+	pshufd		STATE1,  STATE1,  0xB1	; DCHG=0D
+	movdqa		MSGTMP4, STATE0=0D
+	pblendw		STATE0,  STATE1,  0xF0	; DCBA=0D
+	palignr		STATE1,  MSGTMP4, 8	; HGFE=0D
+=0D
+	movdqu		[DIGEST_PTR + 0*16], STATE0=0D
+	movdqu		[DIGEST_PTR + 1*16], STATE1=0D
+=0D
+.done_hash:=0D
+%ifdef WINABI=0D
+	movdqa		xmm6,  [rsp + frame.xmm_save + 0*16]=0D
+	movdqa		xmm7,  [rsp + frame.xmm_save + 1*16]=0D
+	movdqa		xmm8,  [rsp + frame.xmm_save + 2*16]=0D
+	movdqa		xmm9,  [rsp + frame.xmm_save + 3*16]=0D
+	movdqa		xmm10, [rsp + frame.xmm_save + 4*16]=0D
+	mov		rsp, RSPSAVE=0D
+%endif=0D
+=0D
+	ret	=0D
+	=0D
+section .data=0D
+align 64=0D
+K256:=0D
+	dd	0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5=0D
+	dd	0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5=0D
+	dd	0xd807aa98,0x12835b01,0x243185be,0x550c7dc3=0D
+	dd	0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174=0D
+	dd	0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc=0D
+	dd	0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da=0D
+	dd	0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7=0D
+	dd	0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967=0D
+	dd	0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13=0D
+	dd	0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85=0D
+	dd	0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3=0D
+	dd	0xd192e819,0xd6990624,0xf40e3585,0x106aa070=0D
+	dd	0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5=0D
+	dd	0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3=0D
+	dd	0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208=0D
+	dd	0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2=0D
+=0D
+PSHUFFLE_BYTE_FLIP_MASK: ddq 0x0c0d0e0f08090a0b0405060700010203=0D
+=0D
diff --git a/sha256-x64shani/sha256_x64.c b/sha256-x64shani/sha256_x64.c=0D
new file mode 100644=0D
index 0000000000..01f3417719=0D
--- /dev/null=0D
+++ b/sha256-x64shani/sha256_x64.c=0D
@@ -0,0 +1,82 @@=0D
+#include "../git-compat-util.h"=0D
+#include "sha256_x64.h"=0D
+#include <byteswap.h>=0D
+=0D
+static int shani =3D -1;=0D
+=0D
+void shani_SHA256_Init(shani_SHA256_CTX *ctx)=0D
+{=0D
+	ctx->total_len =3D 0;=0D
+	ctx->len =3D 0;=0D
+	ctx->h[0] =3D 0x6a09e667ul;=0D
+	ctx->h[1] =3D 0xbb67ae85ul;=0D
+	ctx->h[2] =3D 0x3c6ef372ul;=0D
+	ctx->h[3] =3D 0xa54ff53aul;=0D
+	ctx->h[4] =3D 0x510e527ful;=0D
+	ctx->h[5] =3D 0x9b05688cul;=0D
+	ctx->h[6] =3D 0x1f83d9abul;=0D
+	ctx->h[7] =3D 0x5be0cd19ul;=0D
+=0D
+    if (shani !=3D 1) {=0D
+        shani =3D 1;=0D
+        printf("set shani to 1\n");=0D
+    } else {=0D
+        printf("shani is 1 already\n");=0D
+    }=0D
+}=0D
+=0D
+void sha256_update(uint32_t *digest, const void *data, uint32_t numBlocks)=
;=0D
+void shani_SHA256_Update(shani_SHA256_CTX *c, const void *data, size_t len=
)=0D
+{=0D
+    while (len > 0)=0D
+    {=0D
+        if (c->len =3D=3D 0 && len >=3D 64)=0D
+        {=0D
+            sha256_update(c->h, data, len/64);=0D
+            unsigned long bytes_hashed =3D (len/64)*64;=0D
+            data +=3D bytes_hashed;=0D
+            len -=3D bytes_hashed;=0D
+            c->total_len +=3D bytes_hashed;=0D
+            continue;=0D
+        }=0D
+#define MIN(x, y) (((x) < (y)) ? (x) : (y))=0D
+        size_t cpy =3D MIN(64 - c->len, len);=0D
+#undef MIN=0D
+        memcpy(c->msgbuf + c->len, data, cpy);=0D
+        data +=3D cpy;=0D
+        len -=3D cpy;=0D
+        c->len +=3D cpy;=0D
+        c->total_len +=3D cpy;=0D
+=0D
+        if (c->len =3D=3D 64)=0D
+        {=0D
+            sha256_update(c->h, c->msgbuf, 1);=0D
+            c->len =3D 0;=0D
+        }=0D
+    }=0D
+}=0D
+=0D
+void shani_SHA256_Final(unsigned char *digest, shani_SHA256_CTX *c)=0D
+{=0D
+    c->msgbuf[c->len] =3D 0x80;=0D
+    ++c->len;=0D
+    memset(c->msgbuf + c->len, 0, 64 - c->len);=0D
+    if (c->len > (64-8))=0D
+    {=0D
+        sha256_update(c->h, c->msgbuf, 1);=0D
+        memset(c->msgbuf, 0, 64);=0D
+        c->len =3D 0;=0D
+    }=0D
+=0D
+    for (int ibyte =3D 0; ibyte < 8; ++ibyte)=0D
+       c->msgbuf[63-ibyte] =3D (uint8_t)((c->total_len * 8ULL) >> (ibyte*8=
));=0D
+=0D
+    sha256_update(c->h, c->msgbuf, 1);=0D
+    c->len =3D 0;=0D
+    =0D
+    // flip endianness=0D
+    int i;=0D
+    for (i =3D 0; i < 32; i +=3D 4) {=0D
+        *(uint32_t *)(digest + i) =3D __bswap_32(c->h[i / 4]);=0D
+    }=0D
+}=0D
\ No newline at end of file=0D
diff --git a/sha256-x64shani/sha256_x64.h b/sha256-x64shani/sha256_x64.h=0D
new file mode 100644=0D
index 0000000000..25f1ff67ba=0D
--- /dev/null=0D
+++ b/sha256-x64shani/sha256_x64.h=0D
@@ -0,0 +1,23 @@=0D
+/*=0D
+ * SHA256 routine using x64 SHA-NI instructions=0D
+ */=0D
+=0D
+#define SHANI_SHA256_BLKSIZE 64=0D
+=0D
+struct shani_SHA256_CTX {=0D
+    uint32_t h[8];=0D
+    int len;=0D
+    uint64_t total_len;=0D
+    char msgbuf[SHANI_SHA256_BLKSIZE];=0D
+};=0D
+=0D
+typedef struct shani_SHA256_CTX shani_SHA256_CTX;=0D
+=0D
+void shani_SHA256_Init(shani_SHA256_CTX *ctx);=0D
+void shani_SHA256_Update(shani_SHA256_CTX *c, const void *data, size_t len=
);=0D
+void shani_SHA256_Final(unsigned char *digest, shani_SHA256_CTX *c);=0D
+=0D
+#define platform_SHA256_CTX	    shani_SHA256_CTX=0D
+#define platform_SHA256_Init	shani_SHA256_Init=0D
+#define platform_SHA256_Update	shani_SHA256_Update=0D
+#define platform_SHA256_Final	shani_SHA256_Final=0D
\ No newline at end of file=0D
-- =0D
2.41.0=0D
=0D
