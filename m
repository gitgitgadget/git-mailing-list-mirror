Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0826420A17
	for <e@80x24.org>; Sun, 22 Jan 2017 18:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbdAVSCp (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 13:02:45 -0500
Received: from mout.web.de ([217.72.192.78]:51918 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750925AbdAVSCo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 13:02:44 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Le4Tw-1cAHms26e4-00puhN; Sun, 22
 Jan 2017 19:02:30 +0100
Subject: [DEMO][PATCH v2 6/5] compat: add a qsort_s() implementation based on
 GNU's qsort_r(1)
To:     Git List <git@vger.kernel.org>
References: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9f8b564d-ec9f-abc9-77f6-aa84c6e78b7a@web.de>
Date:   Sun, 22 Jan 2017 19:02:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:DRk+Pw5jEn6R1h0o9e8pVcbRdnyl4gmuNqPVBs1nzhhGEDIEE2S
 ksEbEz1LZNj1Vdq6ISTnUyl8US/DJRW0Ab5ks6kbujgUlBZMCXiY0TSTivHpCrUfyPGN9oN
 d3h/fHTcik7UluW1gm/3QSw0tZLIGrdHeNtLR7hd71C9tSYwTFAeTGq3kvTmObETxwoQLBf
 g0uOjy0hzncMeRrqGki/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/GPsX33rjGA=:uTyQFbEN5g3AzAYiw3P3g4
 t8aCi4OwKRMjhRSe2GCvlClfgAkm7dc5nJsEAMSeDTNWZAnc1/DKSGNMOClTNLQCzUHQcudno
 cXvoNOTnY1AQ8Xd1+HW82iEpRJcsXnPYa0IXwg0rPJdrHbiq+s5sjb1Zr6RriCrnuqmWdWawp
 oerw6FwAKlIey9OI0lUrhxRc+yw0JAwTR97sbrDM8ArbtntoqiOLOAA52QWQZIKqinArlvZd9
 00NBptkZvbCwfi3Dhr3y1oZ4lfvfuRLMqaMmP4LywZEDjfGFi8HJKqS6s+9ZawFPmozyMIbn1
 BUPuoCNVGd17o/sb23mdb8vvu9B2rcMlkkV8GGkNauZbrr83LtU665ruM3spI6M7FlaxlZMGg
 8ChAhf9ppX8fYwPVPdRXLjVaG7nwnS95/gPB/2YLNf1am9TRYloqF5IgdImZjqADW3f8gz2Q7
 UP7mBxsFWmDZv7ULomAdGIuAs4j9Nrst5o1CsggGvvgAtxevuv78ODzIsmPbb8ITZ2OMIpGsu
 SWwCxogCrkbb9k+FTjoRJ+l7Kul6hD1z6AJJpjdQkrOjxnFjhE3zYwcFkw19oi+yTxlsaIb41
 LctCG2OgjS6Yv/a8XIbKZXGtXTgXv6TiHqv42jHev2KJJQMyOSUtk2zLcR74+Ujcsgbjc5zog
 1sPv/2FkS/qCwBHYv8NpsN5uNgQibudJIgNi6r+G4OUow19XJ/FFEWfffdBipnR7FxWaXHbK7
 IXZ/xvbEL/rsDgv6C8RenwtqnT7eTNzjpzH3vn3O/EIby5pB1N2j1V2pCD37tNdW/JUN+O4dl
 0nBTfml
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement qsort_s() as a wrapper to the GNU version of qsort_r(1) and
use it on Linux.  Performance increases slightly:

Test                         HEAD^             HEAD
--------------------------------------------------------------------
0071.2: sort(1)              0.10(0.20+0.02)   0.10(0.21+0.01) +0.0%
0071.3: string_list_sort()   0.17(0.15+0.01)   0.16(0.15+0.01) -5.9%

Additionally the unstripped size of compat/qsort_s.o falls from 24576
to 16544 bytes in my build.

IMHO these savings aren't worth the increased complexity of having to
support two implementations.
---
 Makefile         |  6 ++++++
 compat/qsort_s.c | 18 ++++++++++++++++++
 config.mak.uname |  1 +
 3 files changed, 25 insertions(+)

diff --git a/Makefile b/Makefile
index 53ecc84e28..46db1c773f 100644
--- a/Makefile
+++ b/Makefile
@@ -282,6 +282,9 @@ all::
 # Define HAVE_ISO_QSORT_S if your platform provides a qsort_s() that's
 # compatible with the one described in C11 Annex K.
 #
+# Define HAVE_GNU_QSORT_R if your platform provides a qsort_r() that's
+# compatible with the one introduced with glibc 2.8.
+#
 # Define UNRELIABLE_FSTAT if your system's fstat does not return the same
 # information on a not yet closed file that lstat would return for the same
 # file after it was closed.
@@ -1426,6 +1429,9 @@ ifdef HAVE_ISO_QSORT_S
 else
 	COMPAT_OBJS += compat/qsort_s.o
 endif
+ifdef HAVE_GNU_QSORT_R
+	COMPAT_CFLAGS += -DHAVE_GNU_QSORT_R
+endif
 ifdef RUNTIME_PREFIX
 	COMPAT_CFLAGS += -DRUNTIME_PREFIX
 endif
diff --git a/compat/qsort_s.c b/compat/qsort_s.c
index 52d1f0a73d..763ee1faae 100644
--- a/compat/qsort_s.c
+++ b/compat/qsort_s.c
@@ -1,5 +1,21 @@
 #include "../git-compat-util.h"
 
+#if defined HAVE_GNU_QSORT_R
+
+int git_qsort_s(void *b, size_t n, size_t s,
+		int (*cmp)(const void *, const void *, void *), void *ctx)
+{
+	if (!n)
+		return 0;
+	if (!b || !cmp)
+		return -1;
+
+	qsort_r(b, n, s, cmp, ctx);
+	return 0;
+}
+
+#else
+
 /*
  * A merge sort implementation, simplified from the qsort implementation
  * by Mike Haertel, which is a part of the GNU C Library.
@@ -67,3 +83,5 @@ int git_qsort_s(void *b, size_t n, size_t s,
 	}
 	return 0;
 }
+
+#endif
diff --git a/config.mak.uname b/config.mak.uname
index 447f36ac2e..a1858f54ff 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -37,6 +37,7 @@ ifeq ($(uname_S),Linux)
 	NEEDS_LIBRT = YesPlease
 	HAVE_GETDELIM = YesPlease
 	SANE_TEXT_GREP=-a
+	HAVE_GNU_QSORT_R = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
-- 
2.11.0

