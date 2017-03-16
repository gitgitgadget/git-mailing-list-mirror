Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 162FB20323
	for <e@80x24.org>; Thu, 16 Mar 2017 20:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbdCPUdL (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 16:33:11 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34894 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752122AbdCPUdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 16:33:09 -0400
Received: by mail-pg0-f68.google.com with SMTP id g2so7225611pge.2
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 13:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=HArrqqDECmGmjj3TjfEPmWgCbvRg1/+TBxW1/sMP2Sg=;
        b=IwXlGZH1Jd2s+LE2gzaFK4edjJzFjQY03+cdS4uR6P9laQM8HrXuosfYBV5nCpkDAa
         sWbkaJQXbDRBECiPliuA47xXYU/k6w7E+HOabi8v4tstLJTttjhhbJ5+J9ASx1XQBdZL
         LeZx5zK/EAnp11MA4QPMfU4eOxlF7W1IQkSUUt91VLQpG098Hz8lCzRkX8aG8cBHG0LX
         jCYzPbohMBScgToJ6J2CMPHWbS3aF8/sJVSqZEa47X3vM4X5r/QcSWqEvE5VMXLxCSjG
         gcqR06tRLNqFdAVXX60ibPfB2h+9KP5NG5ZFrw/kbIy7bQ/Sv0/oEpCmy/sDNMuneUOL
         7GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :user-agent:mime-version;
        bh=HArrqqDECmGmjj3TjfEPmWgCbvRg1/+TBxW1/sMP2Sg=;
        b=h4p+KmFBMuM9Xdyx8r/60jzEayCRM/dHIuYD0GtMHt3pK+TLVGzJOY1VbssA7Ko7r0
         CKxupuKcIqU99miFQgKVPb7dcRGH37id7GOzFC+HLZW1aDAK2EYnlyTBGR8kbhGt0giQ
         uDBGOVhcSoWS8iIGNpb2MklmyIL3StZRWCKBJpJvRp/PSag+I9YKmc3kJMO7dXkcI1AL
         Xa2E7SjojARCbSzr/jotjiAQA96/4ZwZcuW/9xdK2eCtYf7FXJKvcsIPR12YYSiRkm5S
         YRs7Pt0ib4QftHVJqsqlOVzewPu05sjaUUFmHLONxJbeQELDxdo86JQQTkXu39pj1UGB
         QfWg==
X-Gm-Message-State: AFeK/H3Hqt3cCLbEy3h4bS5G+Tq7Q8OGhBWRKlDlk2m7ocyIvGcLk55KWJUvqVTnBR5Nzw==
X-Received: by 10.99.62.4 with SMTP id l4mr10832810pga.172.1489695930617;
        Thu, 16 Mar 2017 13:25:30 -0700 (PDT)
Received: from i7.lan (c-73-11-52-149.hsd1.or.comcast.net. [73.11.52.149])
        by smtp.gmail.com with ESMTPSA id 197sm12216939pfv.19.2017.03.16.13.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Mar 2017 13:25:30 -0700 (PDT)
Date:   Thu, 16 Mar 2017 13:25:29 -0700 (PDT)
From:   Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@i7.lan
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/2] Integrate the sha1dc code with the git build
Message-ID: <alpine.LFD.2.20.1703161325081.18484@i7.lan>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 Mar 2017 13:08:38 -0700
Subject: [PATCH 2/2] Integrate the sha1dc code with the git build

This adds the proper magic to actually build the sha1dc code as part of
git when USE_SHA1DC is enabled.

This includes

 - adjusting the sha1dc include directives for git use

 - adding the proper USE_SHA1DC logic to the Makefile

 - adding the SHA1DC case to the "hash.h" header

 - adding the proper "git platform" wrappers for the SHA1 interface

Much of this comes from Jeff King's previous integration effort, with
modifications for the new world order of hash.h.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 Makefile           | 10 ++++++++++
 hash.h             |  2 ++
 sha1dc/sha1.c      | 33 +++++++++++++++++++++++++--------
 sha1dc/sha1.h      | 18 ++++++++++++++++--
 sha1dc/ubc_check.c |  4 ++--
 sha1dc/ubc_check.h |  2 --
 6 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index a5a11e721..186ce17f2 100644
--- a/Makefile
+++ b/Makefile
@@ -140,6 +140,10 @@ all::
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
+# Define USE_SHA1DC to unconditionally enable the collision-detecting sha1
+# algorithm. This is slower, but may detect attempted collision attacks.
+# Takes priority over other *_SHA1 knobs.
+#
 # Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
 # in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
 # wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
@@ -1383,6 +1387,11 @@ ifdef APPLE_COMMON_CRYPTO
 	SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
 endif
 
+ifdef USE_SHA1DC
+	LIB_OBJS += sha1dc/sha1.o
+	LIB_OBJS += sha1dc/ubc_check.o
+	BASIC_CFLAGS += -DSHA1DC
+else
 ifdef BLK_SHA1
 	LIB_OBJS += block-sha1/sha1.o
 	BASIC_CFLAGS += -DSHA1_BLK
@@ -1400,6 +1409,7 @@ else
 endif
 endif
 endif
+endif
 
 ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
diff --git a/hash.h b/hash.h
index f0d9ddd0c..b9e7e34fc 100644
--- a/hash.h
+++ b/hash.h
@@ -3,6 +3,8 @@
 
 #if defined(SHA1_PPC)
 #include "ppc/sha1.h"
+#elif defined(SHA1DC)
+#include "sha1dc/sha1.h"
 #elif defined(SHA1_APPLE)
 #include <CommonCrypto/CommonDigest.h>
 #elif defined(SHA1_OPENSSL)
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 8d12b832b..76a8d1a85 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -5,14 +5,9 @@
 * https://opensource.org/licenses/MIT
 ***/
 
-#include <string.h>
-#include <memory.h>
-#include <stdio.h>
-#include <stdlib.h>
-
-#include "sha1.h"
-#include "ubc_check.h"
-
+#include "git-compat-util.h"
+#include "sha1dc/sha1.h"
+#include "sha1dc/ubc_check.h"
 
 /* 
    Because Little-Endian architectures are most common,
@@ -1790,3 +1785,25 @@ int SHA1DCFinal(unsigned char output[20], SHA1_CTX *ctx)
 	output[19] = (unsigned char)(ctx->ihv[4]);
 	return ctx->found_collision;
 }
+
+static const char collision_message[] =
+"The SHA1 computation detected evidence of a collision attack;\n"
+"refusing to process the contents.";
+
+void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
+{
+	if (SHA1DCFinal(hash, ctx))
+		die(collision_message);
+}
+
+void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, unsigned long len)
+{
+	const char *data = vdata;
+	/* We expect an unsigned long, but sha1dc only takes an int */
+	while (len > INT_MAX) {
+		SHA1DCUpdate(ctx, data, INT_MAX);
+		data += INT_MAX;
+		len -= INT_MAX;
+	}
+	SHA1DCUpdate(ctx, data, len);
+}
diff --git a/sha1dc/sha1.h b/sha1dc/sha1.h
index e867724c0..37ee415da 100644
--- a/sha1dc/sha1.h
+++ b/sha1dc/sha1.h
@@ -9,8 +9,6 @@
 extern "C" {
 #endif
 
-#include <stdint.h>
-
 /* uses SHA-1 message expansion to expand the first 16 words of W[] to 80 words */
 /* void sha1_message_expansion(uint32_t W[80]); */
 
@@ -100,6 +98,22 @@ void SHA1DCUpdate(SHA1_CTX*, const char*, size_t);
 /* returns: 0 = no collision detected, otherwise = collision found => warn user for active attack */
 int  SHA1DCFinal(unsigned char[20], SHA1_CTX*); 
 
+
+/*
+ * Same as SHA1DCFinal, but convert collision attack case into a verbose die().
+ */
+void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
+
+/*
+ * Same as SHA1DCUpdate, but adjust types to match git's usual interface.
+ */
+void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
+
+#define platform_SHA_CTX SHA1_CTX
+#define platform_SHA1_Init SHA1DCInit
+#define platform_SHA1_Update git_SHA1DCUpdate
+#define platform_SHA1_Final git_SHA1DCFinal
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/sha1dc/ubc_check.c b/sha1dc/ubc_check.c
index 27d0976da..089dd4743 100644
--- a/sha1dc/ubc_check.c
+++ b/sha1dc/ubc_check.c
@@ -24,8 +24,8 @@
 // ubc_check has been verified against ubc_check_verify using the 'ubc_check_test' program in the tools section
 */
 
-#include <stdint.h>
-#include "ubc_check.h"
+#include "git-compat-util.h"
+#include "sha1dc/ubc_check.h"
 
 static const uint32_t DV_I_43_0_bit 	= (uint32_t)(1) << 0;
 static const uint32_t DV_I_44_0_bit 	= (uint32_t)(1) << 1;
diff --git a/sha1dc/ubc_check.h b/sha1dc/ubc_check.h
index b349bed92..b64c306d7 100644
--- a/sha1dc/ubc_check.h
+++ b/sha1dc/ubc_check.h
@@ -27,8 +27,6 @@
 extern "C" {
 #endif
 
-#include <stdint.h>
-
 #define DVMASKSIZE 1
 typedef struct { int dvType; int dvK; int dvB; int testt; int maski; int maskb; uint32_t dm[80]; } dv_info_t;
 extern dv_info_t sha1_dvs[];
-- 
2.12.0.434.g76f8c11c1

