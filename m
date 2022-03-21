Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F73CC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 17:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351609AbiCURHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 13:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351594AbiCURHs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 13:07:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F17497288
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 10:06:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p9so21570700wra.12
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 10:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/REXERHRVQCAiwIlTcHKdiWVWXUhTqneXCl8VMnS4E=;
        b=XjUAWXLlrElY3HEkgNRzCtTmzEgXlUnWbTN74/Z7GzS9MWm7vaMsj7YctZ6XBv4SZf
         oD6eeT+fuhpSi7P6UGWhIKz+v86l1uGaEtQmy1VxvYfH6OSUjQWEy29YaimKF2Qptegc
         59cPRyA65y/VYIaGJKBVM0aNoPt7GSG7qJRAo0UCmcWIDK5+qJpmXBxe2Xc+zn/Gi53/
         4sovHfETjOgSo1an9m6F0v7voUS/BoMZowA7QL552tMbF0z/GlHyR1cAjwyf2CIo38uO
         I5ka113x3nqEKqT9q5TNfNdqDtt39NTeNKGxeU+hWICOAyLFV7yoUyVfkzxMYy6IOfd3
         y0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/REXERHRVQCAiwIlTcHKdiWVWXUhTqneXCl8VMnS4E=;
        b=wXjxaTGvqZoCJ8mZlBWnyi9GclxGQSKaOutaYG/FWxTRmTmnnUHWG4gURSBv97yNXG
         KUDxHLc3Fg88fR18aHhRMdiGTpDblXY3iKqfSF/8NmHOFpt1S69lyBbEGRHGy+apH5hT
         SboUvrNer0yDnX8M52AqOb7lH3zLsi/eYmAQ0znwrQjew/xGAAGGe5EteakOnoNpPE+r
         a5Z5vnX0IRtgCiFsvKgWCgTthA6LE2BY+ad4VqtZshTGXNXms5m733bmTkr2qYuPgMcb
         LODMv6+XLyMksUmQMmPcMoaTPnUkQLMcrs2PlBJlI8aGQj5fRPCY+EM9+O84XDbG+G3N
         YY+Q==
X-Gm-Message-State: AOAM530SoqejIhOsZgN6mKM2N6nBaEZmXelu9nmUHZ3TPpks7kfIMXSP
        l6gyx6G7ffGO+tuK7OXp4bJUsG7GKo8=
X-Google-Smtp-Source: ABdhPJwZFfUiZLzTcBRr/ZnDAzO+9vDOAQZ0CQqZPxYT0TSS7/6P3LMLsWK3wPR0OCdByNBF+JTQ6A==
X-Received: by 2002:adf:cf12:0:b0:203:f917:82ba with SMTP id o18-20020adfcf12000000b00203f91782bamr12729666wrj.538.1647882375940;
        Mon, 21 Mar 2022 10:06:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm73765wms.25.2022.03.21.10.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 10:06:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] ppc: remove custom SHA-1 implementation
Date:   Mon, 21 Mar 2022 18:06:12 +0100
Message-Id: <patch-v2-1.1-e77fd23a824-20220321T170412Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1441.g83331fcb493
In-Reply-To: <patch-1.1-05dcdca3877-20220319T005952Z-avarab@gmail.com>
References: <patch-1.1-05dcdca3877-20220319T005952Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the PPC_SHA1 implementation added in a6ef3518f9a ([PATCH] PPC
assembly implementation of SHA1, 2005-04-22). When this was added
Apple consumer hardware used the PPC architecture, and the
implementation was intended to improve SHA-1 speed there.

Since it was added we've moved to DC_SHA1 by default, and anyone
wanting hard-rolled non-DC SHA-1 implementation can use OpenSSL's via
the OPENSSL_SHA1 knob.

I'm unsure if this was ever supposed to work on 64-bit PPC. It clearly
originally targeted 32 bit PPC, but there's some mailing list
references to this being tried on G5 (PPC 970). I can't get it to do
anything but segfault on the BE POWER8 machine in the GCC compile
farm. Anyone caring about speed on PPC these days is likely to be
using IBM's POWER, not PPC 970.

There have been proposals to entirely remove non-DC_SHA1
implementations from the tree[1]. I think per [2] that would be a bit
overzealous. I.e. there are various set-ups git's speed is going to be
more important than the relatively implausible SHA-1 collision attack,
or where such attacks are entirely mitigated by other means (e.g. by
incoming objects being checked with DC_SHA1).

The main reason for doing so at this point is to simplify follow-up
Makefile change. Since PPC_SHA1 included the only in-tree *.S assembly
file we needed to keep around special support for building objects
from it. By getting rid of it we know we'll always build *.o from *.c
files, which makes the build process simpler.

As an aside the code being removed here was also throwing warnings
with the "-pedantic" flag, but let's remove it instead of fixing it,
as 544d93bc3b4 (block-sha1: remove use of obsolete x86 assembly,
2022-03-10) did for block-sha1/*.

1. https://lore.kernel.org/git/20200223223758.120941-1-mh@glandium.org/
2. https://lore.kernel.org/git/20200224044732.GK1018190@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

A more minimal change to the Makefile than that in v1. In v1 I thought
it was a bit odd to leave in-place the C_OBJ variable that was only
declared for now-removed code. But sure, we can keep it and keep
defining SP_OBJ etc. as being derived from it.

Range-diff against v1:
1:  05dcdca3877 ! 1:  e77fd23a824 ppc: remove custom SHA-1 implementation
    @@ Makefile: ifdef OPENSSL_SHA1
      	BASIC_CFLAGS += -DSHA1_OPENSSL
      else
     +ifdef PPC_SHA1
    -+$(error PPC_SHA1 has been removed! You should almost definitely remove that \
    -+knob and use the DC_SHA1 default! See INSTALL for more information)
    ++$(error PPC_SHA1 has been removed! Use DC_SHA1 instead, which is the default)
     +endif
      ifdef BLK_SHA1
      	LIB_OBJS += block-sha1/sha1.o
    @@ Makefile: endif
      
      ifdef OPENSSL_SHA256
      	EXTLIBS += $(LIB_4_CRYPTO)
    -@@ Makefile: OBJECTS += $(SCALAR_OBJECTS)
    - .PHONY: objects
    - objects: $(OBJECTS)
    - 
    -+# Derived from $(OBJECTS)
    -+OBJECTS_C = $(OBJECTS:%.o=%.c)
    -+OBJECTS_S = $(OBJECTS:%.o=%.s)
    -+OBJECTS_SP = $(OBJECTS:%.o=%.sp)
    -+
    - dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
    - dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
    - 
     @@ Makefile: missing_compdb_dir =
      compdb_args =
      endif
    @@ Makefile: missing_compdb_dir =
     -ASM_SRC := $(wildcard $(OBJECTS:o=S))
     -ASM_OBJ := $(ASM_SRC:S=o)
     -C_OBJ := $(filter-out $(ASM_OBJ),$(OBJECTS))
    --
    --$(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
    --	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
    --$(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
    -+$(OBJECTS): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
    ++C_OBJ = $(OBJECTS)
    + 
    + $(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
      	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
    +-$(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
    +-	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
      
      %.s: %.c GIT-CFLAGS FORCE
    -@@ Makefile: XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
    - 	--keyword=gettextln --keyword=eval_gettextln
    - XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
    - 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
    --LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
    -+LOCALIZED_C = $(OBJECTS_C) $(LIB_H) $(GENERATED_H)
    - LOCALIZED_SH = $(SCRIPT_SH)
    - LOCALIZED_SH += git-sh-setup.sh
    - LOCALIZED_PERL = $(SCRIPT_PERL)
    -@@ Makefile: t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
    - check-sha1:: t/helper/test-tool$X
    - 	t/helper/test-sha1.sh
    - 
    --SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
    --
    --$(SP_OBJ): %.sp: %.c %.o
    -+$(OBJECTS_SP): %.sp: %.c %.o
    - 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
    - 		-Wsparse-error \
    - 		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $< && \
    - 	>$@
    - 
    - .PHONY: sparse
    --sparse: $(SP_OBJ)
    -+sparse: $(OBJECTS_SP)
    - 
    - EXCEPT_HDRS := $(GENERATED_H) unicode-width.h compat/% xdiff/%
    - ifndef GCRYPT_SHA256
    -@@ Makefile: clean: profile-clean coverage-clean cocciclean
    - 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
    - 	$(RM) $(TEST_PROGRAMS)
    - 	$(RM) $(FUZZ_PROGRAMS)
    --	$(RM) $(SP_OBJ)
    -+	$(RM) $(OBJECTS_SP)
    - 	$(RM) $(HCC)
    - 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
    - 	$(RM) -r po/build/
    + 	$(QUIET_CC)$(CC) -o $@ -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
     
      ## configure.ac ##
     @@ configure.ac: AC_MSG_NOTICE([CHECKS for site configuration])

 INSTALL       |   3 +-
 Makefile      |  17 +---
 configure.ac  |   3 -
 hash.h        |   6 +-
 ppc/sha1.c    |  72 ----------------
 ppc/sha1.h    |  25 ------
 ppc/sha1ppc.S | 224 --------------------------------------------------
 7 files changed, 7 insertions(+), 343 deletions(-)
 delete mode 100644 ppc/sha1.c
 delete mode 100644 ppc/sha1.h
 delete mode 100644 ppc/sha1ppc.S

diff --git a/INSTALL b/INSTALL
index 4140a3f5c8b..89b15d71df5 100644
--- a/INSTALL
+++ b/INSTALL
@@ -135,8 +135,7 @@ Issues of note:
 
 	  By default, git uses OpenSSL for SHA1 but it will use its own
 	  library (inspired by Mozilla's) with either NO_OPENSSL or
-	  BLK_SHA1.  Also included is a version optimized for PowerPC
-	  (PPC_SHA1).
+	  BLK_SHA1.
 
 	- "libcurl" library is used for fetching and pushing
 	  repositories over http:// or https://, as well as by
diff --git a/Makefile b/Makefile
index 70f0a004e75..33c6db5e6c9 100644
--- a/Makefile
+++ b/Makefile
@@ -155,9 +155,6 @@ include shared.mak
 # Define BLK_SHA1 environment variable to make use of the bundled
 # optimized C SHA1 routine.
 #
-# Define PPC_SHA1 environment variable when running make to make use of
-# a bundled SHA1 routine optimized for PowerPC.
-#
 # Define DC_SHA1 to unconditionally enable the collision-detecting sha1
 # algorithm. This is slower, but may detect attempted collision attacks.
 # Takes priority over other *_SHA1 knobs.
@@ -1770,14 +1767,13 @@ ifdef OPENSSL_SHA1
 	EXTLIBS += $(LIB_4_CRYPTO)
 	BASIC_CFLAGS += -DSHA1_OPENSSL
 else
+ifdef PPC_SHA1
+$(error PPC_SHA1 has been removed! Use DC_SHA1 instead, which is the default)
+endif
 ifdef BLK_SHA1
 	LIB_OBJS += block-sha1/sha1.o
 	BASIC_CFLAGS += -DSHA1_BLK
 else
-ifdef PPC_SHA1
-	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
-	BASIC_CFLAGS += -DSHA1_PPC
-else
 ifdef APPLE_COMMON_CRYPTO
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
 	BASIC_CFLAGS += -DSHA1_APPLE
@@ -1811,7 +1807,6 @@ endif
 endif
 endif
 endif
-endif
 
 ifdef OPENSSL_SHA256
 	EXTLIBS += $(LIB_4_CRYPTO)
@@ -2540,14 +2535,10 @@ missing_compdb_dir =
 compdb_args =
 endif
 
-ASM_SRC := $(wildcard $(OBJECTS:o=S))
-ASM_OBJ := $(ASM_SRC:S=o)
-C_OBJ := $(filter-out $(ASM_OBJ),$(OBJECTS))
+C_OBJ = $(OBJECTS)
 
 $(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
-$(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
-	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 
 %.s: %.c GIT-CFLAGS FORCE
 	$(QUIET_CC)$(CC) -o $@ -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
diff --git a/configure.ac b/configure.ac
index 5ee25ec95c8..9c75b00d3eb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -237,9 +237,6 @@ AC_MSG_NOTICE([CHECKS for site configuration])
 # tests.  These tests take up a significant amount of the total test time
 # but are not needed unless you plan to talk to SVN repos.
 #
-# Define PPC_SHA1 environment variable when running make to make use of
-# a bundled SHA1 routine optimized for PowerPC.
-#
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 #
 # Define OPENSSLDIR=/foo/bar if your openssl header and library files are in
diff --git a/hash.h b/hash.h
index 5d40368f18a..efc14c5f56d 100644
--- a/hash.h
+++ b/hash.h
@@ -4,9 +4,7 @@
 #include "git-compat-util.h"
 #include "repository.h"
 
-#if defined(SHA1_PPC)
-#include "ppc/sha1.h"
-#elif defined(SHA1_APPLE)
+#if defined(SHA1_APPLE)
 #include <CommonCrypto/CommonDigest.h>
 #elif defined(SHA1_OPENSSL)
 #include <openssl/sha.h>
@@ -30,7 +28,7 @@
  * platform's underlying implementation of SHA-1; could be OpenSSL,
  * blk_SHA, Apple CommonCrypto, etc...  Note that the relevant
  * SHA-1 header may have already defined platform_SHA_CTX for our
- * own implementations like block-sha1 and ppc-sha1, so we list
+ * own implementations like block-sha1, so we list
  * the default for OpenSSL compatible SHA-1 implementations here.
  */
 #define platform_SHA_CTX	SHA_CTX
diff --git a/ppc/sha1.c b/ppc/sha1.c
deleted file mode 100644
index 1b705cee1fe..00000000000
--- a/ppc/sha1.c
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * SHA-1 implementation.
- *
- * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
- *
- * This version assumes we are running on a big-endian machine.
- * It calls an external sha1_core() to process blocks of 64 bytes.
- */
-#include <stdio.h>
-#include <string.h>
-#include "sha1.h"
-
-void ppc_sha1_core(uint32_t *hash, const unsigned char *p,
-		   unsigned int nblocks);
-
-int ppc_SHA1_Init(ppc_SHA_CTX *c)
-{
-	c->hash[0] = 0x67452301;
-	c->hash[1] = 0xEFCDAB89;
-	c->hash[2] = 0x98BADCFE;
-	c->hash[3] = 0x10325476;
-	c->hash[4] = 0xC3D2E1F0;
-	c->len = 0;
-	c->cnt = 0;
-	return 0;
-}
-
-int ppc_SHA1_Update(ppc_SHA_CTX *c, const void *ptr, unsigned long n)
-{
-	unsigned long nb;
-	const unsigned char *p = ptr;
-
-	c->len += (uint64_t) n << 3;
-	while (n != 0) {
-		if (c->cnt || n < 64) {
-			nb = 64 - c->cnt;
-			if (nb > n)
-				nb = n;
-			memcpy(&c->buf.b[c->cnt], p, nb);
-			if ((c->cnt += nb) == 64) {
-				ppc_sha1_core(c->hash, c->buf.b, 1);
-				c->cnt = 0;
-			}
-		} else {
-			nb = n >> 6;
-			ppc_sha1_core(c->hash, p, nb);
-			nb <<= 6;
-		}
-		n -= nb;
-		p += nb;
-	}
-	return 0;
-}
-
-int ppc_SHA1_Final(unsigned char *hash, ppc_SHA_CTX *c)
-{
-	unsigned int cnt = c->cnt;
-
-	c->buf.b[cnt++] = 0x80;
-	if (cnt > 56) {
-		if (cnt < 64)
-			memset(&c->buf.b[cnt], 0, 64 - cnt);
-		ppc_sha1_core(c->hash, c->buf.b, 1);
-		cnt = 0;
-	}
-	if (cnt < 56)
-		memset(&c->buf.b[cnt], 0, 56 - cnt);
-	c->buf.l[7] = c->len;
-	ppc_sha1_core(c->hash, c->buf.b, 1);
-	memcpy(hash, c->hash, 20);
-	return 0;
-}
diff --git a/ppc/sha1.h b/ppc/sha1.h
deleted file mode 100644
index 9b24b326159..00000000000
--- a/ppc/sha1.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * SHA-1 implementation.
- *
- * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
- */
-#include <stdint.h>
-
-typedef struct {
-	uint32_t hash[5];
-	uint32_t cnt;
-	uint64_t len;
-	union {
-		unsigned char b[64];
-		uint64_t l[8];
-	} buf;
-} ppc_SHA_CTX;
-
-int ppc_SHA1_Init(ppc_SHA_CTX *c);
-int ppc_SHA1_Update(ppc_SHA_CTX *c, const void *p, unsigned long n);
-int ppc_SHA1_Final(unsigned char *hash, ppc_SHA_CTX *c);
-
-#define platform_SHA_CTX	ppc_SHA_CTX
-#define platform_SHA1_Init	ppc_SHA1_Init
-#define platform_SHA1_Update	ppc_SHA1_Update
-#define platform_SHA1_Final	ppc_SHA1_Final
diff --git a/ppc/sha1ppc.S b/ppc/sha1ppc.S
deleted file mode 100644
index 1711eef6e71..00000000000
--- a/ppc/sha1ppc.S
+++ /dev/null
@@ -1,224 +0,0 @@
-/*
- * SHA-1 implementation for PowerPC.
- *
- * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
- */
-
-/*
- * PowerPC calling convention:
- * %r0 - volatile temp
- * %r1 - stack pointer.
- * %r2 - reserved
- * %r3-%r12 - Incoming arguments & return values; volatile.
- * %r13-%r31 - Callee-save registers
- * %lr - Return address, volatile
- * %ctr - volatile
- *
- * Register usage in this routine:
- * %r0 - temp
- * %r3 - argument (pointer to 5 words of SHA state)
- * %r4 - argument (pointer to data to hash)
- * %r5 - Constant K in SHA round (initially number of blocks to hash)
- * %r6-%r10 - Working copies of SHA variables A..E (actually E..A order)
- * %r11-%r26 - Data being hashed W[].
- * %r27-%r31 - Previous copies of A..E, for final add back.
- * %ctr - loop count
- */
-
-
-/*
- * We roll the registers for A, B, C, D, E around on each
- * iteration; E on iteration t is D on iteration t+1, and so on.
- * We use registers 6 - 10 for this.  (Registers 27 - 31 hold
- * the previous values.)
- */
-#define RA(t)	(((t)+4)%5+6)
-#define RB(t)	(((t)+3)%5+6)
-#define RC(t)	(((t)+2)%5+6)
-#define RD(t)	(((t)+1)%5+6)
-#define RE(t)	(((t)+0)%5+6)
-
-/* We use registers 11 - 26 for the W values */
-#define W(t)	((t)%16+11)
-
-/* Register 5 is used for the constant k */
-
-/*
- * The basic SHA-1 round function is:
- * E += ROTL(A,5) + F(B,C,D) + W[i] + K;  B = ROTL(B,30)
- * Then the variables are renamed: (A,B,C,D,E) = (E,A,B,C,D).
- *
- * Every 20 rounds, the function F() and the constant K changes:
- * - 20 rounds of f0(b,c,d) = "bit wise b ? c : d" =  (^b & d) + (b & c)
- * - 20 rounds of f1(b,c,d) = b^c^d = (b^d)^c
- * - 20 rounds of f2(b,c,d) = majority(b,c,d) = (b&d) + ((b^d)&c)
- * - 20 more rounds of f1(b,c,d)
- *
- * These are all scheduled for near-optimal performance on a G4.
- * The G4 is a 3-issue out-of-order machine with 3 ALUs, but it can only
- * *consider* starting the oldest 3 instructions per cycle.  So to get
- * maximum performance out of it, you have to treat it as an in-order
- * machine.  Which means interleaving the computation round t with the
- * computation of W[t+4].
- *
- * The first 16 rounds use W values loaded directly from memory, while the
- * remaining 64 use values computed from those first 16.  We preload
- * 4 values before starting, so there are three kinds of rounds:
- * - The first 12 (all f0) also load the W values from memory.
- * - The next 64 compute W(i+4) in parallel. 8*f0, 20*f1, 20*f2, 16*f1.
- * - The last 4 (all f1) do not do anything with W.
- *
- * Therefore, we have 6 different round functions:
- * STEPD0_LOAD(t,s) - Perform round t and load W(s).  s < 16
- * STEPD0_UPDATE(t,s) - Perform round t and compute W(s).  s >= 16.
- * STEPD1_UPDATE(t,s)
- * STEPD2_UPDATE(t,s)
- * STEPD1(t) - Perform round t with no load or update.
- *
- * The G5 is more fully out-of-order, and can find the parallelism
- * by itself.  The big limit is that it has a 2-cycle ALU latency, so
- * even though it's 2-way, the code has to be scheduled as if it's
- * 4-way, which can be a limit.  To help it, we try to schedule the
- * read of RA(t) as late as possible so it doesn't stall waiting for
- * the previous round's RE(t-1), and we try to rotate RB(t) as early
- * as possible while reading RC(t) (= RB(t-1)) as late as possible.
- */
-
-/* the initial loads. */
-#define LOADW(s) \
-	lwz	W(s),(s)*4(%r4)
-
-/*
- * Perform a step with F0, and load W(s).  Uses W(s) as a temporary
- * before loading it.
- * This is actually 10 instructions, which is an awkward fit.
- * It can execute grouped as listed, or delayed one instruction.
- * (If delayed two instructions, there is a stall before the start of the
- * second line.)  Thus, two iterations take 7 cycles, 3.5 cycles per round.
- */
-#define STEPD0_LOAD(t,s) \
-add RE(t),RE(t),W(t); andc   %r0,RD(t),RB(t);  and    W(s),RC(t),RB(t); \
-add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;      rotlwi RB(t),RB(t),30;   \
-add RE(t),RE(t),W(s); add    %r0,%r0,%r5;      lwz    W(s),(s)*4(%r4);  \
-add RE(t),RE(t),%r0
-
-/*
- * This is likewise awkward, 13 instructions.  However, it can also
- * execute starting with 2 out of 3 possible moduli, so it does 2 rounds
- * in 9 cycles, 4.5 cycles/round.
- */
-#define STEPD0_UPDATE(t,s,loadk...) \
-add RE(t),RE(t),W(t); andc   %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
-add RE(t),RE(t),%r0;  and    %r0,RC(t),RB(t); xor    W(s),W(s),W((s)-8);      \
-add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     xor    W(s),W(s),W((s)-14);     \
-add RE(t),RE(t),%r5;  loadk; rotlwi RB(t),RB(t),30;  rotlwi W(s),W(s),1;     \
-add RE(t),RE(t),%r0
-
-/* Nicely optimal.  Conveniently, also the most common. */
-#define STEPD1_UPDATE(t,s,loadk...) \
-add RE(t),RE(t),W(t); xor    %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
-add RE(t),RE(t),%r5;  loadk; xor %r0,%r0,RC(t);  xor W(s),W(s),W((s)-8);      \
-add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     xor    W(s),W(s),W((s)-14);     \
-add RE(t),RE(t),%r0;  rotlwi RB(t),RB(t),30;  rotlwi W(s),W(s),1
-
-/*
- * The naked version, no UPDATE, for the last 4 rounds.  3 cycles per.
- * We could use W(s) as a temp register, but we don't need it.
- */
-#define STEPD1(t) \
-                        add   RE(t),RE(t),W(t); xor    %r0,RD(t),RB(t); \
-rotlwi RB(t),RB(t),30;  add   RE(t),RE(t),%r5;  xor    %r0,%r0,RC(t);   \
-add    RE(t),RE(t),%r0; rotlwi %r0,RA(t),5;     /* spare slot */        \
-add    RE(t),RE(t),%r0
-
-/*
- * 14 instructions, 5 cycles per.  The majority function is a bit
- * awkward to compute.  This can execute with a 1-instruction delay,
- * but it causes a 2-instruction delay, which triggers a stall.
- */
-#define STEPD2_UPDATE(t,s,loadk...) \
-add RE(t),RE(t),W(t); and    %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
-add RE(t),RE(t),%r0;  xor    %r0,RD(t),RB(t); xor    W(s),W(s),W((s)-8);      \
-add RE(t),RE(t),%r5;  loadk; and %r0,%r0,RC(t);  xor W(s),W(s),W((s)-14);     \
-add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     rotlwi W(s),W(s),1;             \
-add RE(t),RE(t),%r0;  rotlwi RB(t),RB(t),30
-
-#define STEP0_LOAD4(t,s)		\
-	STEPD0_LOAD(t,s);		\
-	STEPD0_LOAD((t+1),(s)+1);	\
-	STEPD0_LOAD((t)+2,(s)+2);	\
-	STEPD0_LOAD((t)+3,(s)+3)
-
-#define STEPUP4(fn, t, s, loadk...)		\
-	STEP##fn##_UPDATE(t,s,);		\
-	STEP##fn##_UPDATE((t)+1,(s)+1,);	\
-	STEP##fn##_UPDATE((t)+2,(s)+2,);	\
-	STEP##fn##_UPDATE((t)+3,(s)+3,loadk)
-
-#define STEPUP20(fn, t, s, loadk...)	\
-	STEPUP4(fn, t, s,);		\
-	STEPUP4(fn, (t)+4, (s)+4,);	\
-	STEPUP4(fn, (t)+8, (s)+8,);	\
-	STEPUP4(fn, (t)+12, (s)+12,);	\
-	STEPUP4(fn, (t)+16, (s)+16, loadk)
-
-	.globl	ppc_sha1_core
-ppc_sha1_core:
-	stwu	%r1,-80(%r1)
-	stmw	%r13,4(%r1)
-
-	/* Load up A - E */
-	lmw	%r27,0(%r3)
-
-	mtctr	%r5
-
-1:
-	LOADW(0)
-	lis	%r5,0x5a82
-	mr	RE(0),%r31
-	LOADW(1)
-	mr	RD(0),%r30
-	mr	RC(0),%r29
-	LOADW(2)
-	ori	%r5,%r5,0x7999	/* K0-19 */
-	mr	RB(0),%r28
-	LOADW(3)
-	mr	RA(0),%r27
-
-	STEP0_LOAD4(0, 4)
-	STEP0_LOAD4(4, 8)
-	STEP0_LOAD4(8, 12)
-	STEPUP4(D0, 12, 16,)
-	STEPUP4(D0, 16, 20, lis %r5,0x6ed9)
-
-	ori	%r5,%r5,0xeba1	/* K20-39 */
-	STEPUP20(D1, 20, 24, lis %r5,0x8f1b)
-
-	ori	%r5,%r5,0xbcdc	/* K40-59 */
-	STEPUP20(D2, 40, 44, lis %r5,0xca62)
-
-	ori	%r5,%r5,0xc1d6	/* K60-79 */
-	STEPUP4(D1, 60, 64,)
-	STEPUP4(D1, 64, 68,)
-	STEPUP4(D1, 68, 72,)
-	STEPUP4(D1, 72, 76,)
-	addi	%r4,%r4,64
-	STEPD1(76)
-	STEPD1(77)
-	STEPD1(78)
-	STEPD1(79)
-
-	/* Add results to original values */
-	add	%r31,%r31,RE(0)
-	add	%r30,%r30,RD(0)
-	add	%r29,%r29,RC(0)
-	add	%r28,%r28,RB(0)
-	add	%r27,%r27,RA(0)
-
-	bdnz	1b
-
-	/* Save final hash, restore registers, and return */
-	stmw	%r27,0(%r3)
-	lmw	%r13,4(%r1)
-	addi	%r1,%r1,80
-	blr
-- 
2.35.1.1441.g83331fcb493

