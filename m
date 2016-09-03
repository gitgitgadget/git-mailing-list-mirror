Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDD6B1F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 16:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753910AbcICQBM (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 12:01:12 -0400
Received: from mout.web.de ([212.227.17.12]:50346 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752609AbcICQBG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 12:01:06 -0400
Received: from [192.168.178.36] ([79.237.54.191]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MORuj-1blyVP3sxB-005rqC; Sat, 03 Sep 2016 17:59:19
 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] compat: move strdup(3) replacement to its own file
Message-ID: <89725a44-8afa-1eb1-732a-23b1e264616c@web.de>
Date:   Sat, 3 Sep 2016 17:59:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:TDI1+ckoj5bX0OWfdYOWXHCQcl/3swLXCXVOagj6X/a6VHcqavF
 yHSWGWnPEwb6VE0yPaYZTl3hnvVw+B96SNSGCjKQgGTO1xXcRKNASQP2cYc8ByNcRkqPh+o
 wzw1rrwdAtIIdtrUANteWKIZpr+z6oYSH19J1aR4588RsHddIxoLJ0ikFUSrdGS/efyw18g
 M5Kf2lfK7y3hZr5Zf92nA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n4rym5eKl5w=:Gqp3n3d4hxzua/dSaVRLQO
 kipG/DKksa3kZJk/Nna6KM6GqQZpUKo3FD4lRNbc4eai2RnIBWu/f35nKBipJHWO2yC9J89Lt
 Ek522qZjSZdzjyKZnjBs9+cVsOoh6D1aEg4eC4vvKh8VopIE7LXcrHtxxp+Mqkg+7dhHd4vz5
 qW3bRYkBzM/HJva6OBjhIOh5ZzWzpkULuO4gBATlaEiu8yHsnCIV4IAS1ohI7QnfXHLN42Pj7
 YP/EKyaT8HSKOH8NPYWmhTSrWpfAQQQgDayO6//i2H/uyWdLKC7dPWhVcy2DAFbr6d1yzycuK
 pDZgHAdgnQrBqc6g/Qohq1UWeor9mSnTKOYPLZI8rowAAhD96eKcjnFkflaG2JXiCe4k8w6oN
 kdBVHpmA4jQWhOZi3nup79JCt05r7TlFc2SwTNWbuUp3FJgTwqxoeaBldGbzs8AulnkAj+Ubl
 /4WlLaSCd5W8bN8WOOgslFCVuD+SC01D/Y1gaHvumok4G6IANswxRABLBU40z1HTbhcf5p3Jk
 ZmeMAFxjNehPyblW/HzqtxmnLVuJitoNYYeUWBZXHPBC/8FvkxymSH/b4EiPiHz00hWISUFLJ
 NMxZ4K/TRQC1uZj7Fwo10C8vINs8Mtrd1YPiWAst26JH92LZjuoXn8I1h0XI6Ik+/L0mfCP/H
 YZI+7PysnuB/i+Pgl7gfZPayGo8eQ4GBLquQOQRM79zctzRdJTKneysqLhqse+6oP/alsRMn9
 6i5DpR2oPvcaQWyEsRUUukkonaF+r8ZZR2S3DrN1m1Lj3c3vbdRS1wneAFiG3uCsNJqPSKi/W
 dATf1D/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move our implementation of strdup(3) out of compat/nedmalloc/ and allow
it to be used independently from USE_NED_ALLOCATOR.  This reduces the
difference of our copy of nedmalloc from the original, making it easier
to update, and allows for easier testing and reusing of our version of
strdup().

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Makefile                     | 17 ++++++++++++++---
 compat/nedmalloc/nedmalloc.c | 16 ----------------
 compat/strdup.c              | 11 +++++++++++
 git-compat-util.h            |  8 ++++++++
 4 files changed, 33 insertions(+), 19 deletions(-)
 create mode 100644 compat/strdup.c

diff --git a/Makefile b/Makefile
index d96ecb7..7f18492 100644
--- a/Makefile
+++ b/Makefile
@@ -296,6 +296,11 @@ all::
 # Define USE_NED_ALLOCATOR if you want to replace the platforms default
 # memory allocators with the nedmalloc allocator written by Niall Douglas.
 #
+# Define OVERRIDE_STRDUP to override the libc version of strdup(3).
+# This is necessary when using a custom allocator in order to avoid
+# crashes due to allocation and free working on different 'heaps'.
+# It's defined automatically if USE_NED_ALLOCATOR is set.
+#
 # Define NO_REGEX if you have no or inferior regex support in your C library.
 #
 # Define HAVE_DEV_TTY if your system can open /dev/tty to interact with the
@@ -1456,8 +1461,14 @@ ifdef NATIVE_CRLF
 endif
 
 ifdef USE_NED_ALLOCATOR
-       COMPAT_CFLAGS += -Icompat/nedmalloc
-       COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
+	COMPAT_CFLAGS += -Icompat/nedmalloc
+	COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
+	OVERRIDE_STRDUP = YesPlease
+endif
+
+ifdef OVERRIDE_STRDUP
+	COMPAT_CFLAGS += -DOVERRIDE_STRDUP
+	COMPAT_OBJS += compat/strdup.o
 endif
 
 ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
@@ -2029,7 +2040,7 @@ endif
 
 ifdef USE_NED_ALLOCATOR
 compat/nedmalloc/nedmalloc.sp compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS = \
-	-DNDEBUG -DOVERRIDE_STRDUP -DREPLACE_SYSTEM_ALLOCATOR
+	-DNDEBUG -DREPLACE_SYSTEM_ALLOCATOR
 compat/nedmalloc/nedmalloc.sp: SPARSE_FLAGS += -Wno-non-pointer-null
 endif
 
diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
index 2d4ef59..1cc31c3 100644
--- a/compat/nedmalloc/nedmalloc.c
+++ b/compat/nedmalloc/nedmalloc.c
@@ -948,22 +948,6 @@ void **nedpindependent_comalloc(nedpool *p, size_t elems, size_t *sizes, void **
 	return ret;
 }
 
-#ifdef OVERRIDE_STRDUP
-/*
- * This implementation is purely there to override the libc version, to
- * avoid a crash due to allocation and free on different 'heaps'.
- */
-char *strdup(const char *s1)
-{
-	size_t len = strlen(s1) + 1;
-	char *s2 = malloc(len);
-
-	if (s2)
-		memcpy(s2, s1, len);
-	return s2;
-}
-#endif
-
 #if defined(__cplusplus)
 }
 #endif
diff --git a/compat/strdup.c b/compat/strdup.c
new file mode 100644
index 0000000..f3fb978
--- /dev/null
+++ b/compat/strdup.c
@@ -0,0 +1,11 @@
+#include "../git-compat-util.h"
+
+char *gitstrdup(const char *s1)
+{
+	size_t len = strlen(s1) + 1;
+	char *s2 = malloc(len);
+
+	if (s2)
+		memcpy(s2, s1, len);
+	return s2;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index db89ba7..93f6f23 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -663,6 +663,14 @@ void *gitmemmem(const void *haystack, size_t haystacklen,
                 const void *needle, size_t needlelen);
 #endif
 
+#ifdef OVERRIDE_STRDUP
+#ifdef strdup
+#undef strdup
+#endif
+#define strdup gitstrdup
+char *gitstrdup(const char *s);
+#endif
+
 #ifdef NO_GETPAGESIZE
 #define getpagesize() sysconf(_SC_PAGESIZE)
 #endif
-- 
2.10.0

