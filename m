Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01C4A1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 16:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933408AbcLAQ04 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 11:26:56 -0500
Received: from mout.web.de ([217.72.192.78]:54887 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932924AbcLAQ0z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 11:26:55 -0500
Received: from [192.168.178.36] ([79.213.126.9]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MddJY-1c2WQS1oEu-00PNGV; Thu, 01
 Dec 2016 17:26:44 +0100
Subject: [PATCH 1/3] compat: add qsort_s()
To:     Git List <git@vger.kernel.org>
References: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Newsgroups: gmane.comp.version-control.git
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fc602a66-a06c-203e-b50b-55fd7b258b54@web.de>
Date:   Thu, 1 Dec 2016 17:26:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:SgcQlVQlv26dJSjjQ5Znz4TJanGfkGKNPbJhCAmmijDQSopjS6T
 I8/sJ+aviFiO1JdIuvshSCipiJDrq/LD8mo/o4u30NUFQF09xaq7tdEDCNMc97eQ85cJBmU
 UnL4smZSBTVTIHzHc9LUKRtIboFysSxAVUgavW4AZpxF87qux58w1F8gWk9IfgU8OYhMvzE
 sew5A+aOe5Zap3uy5MTVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L/zcaz0cfEw=:ZLHQXo42m3lIMNwC/lYkQj
 jkAHml3uM+JA4haxGpdEeGoNtMM5CzRPD47YQQx/aYm9Tz7LOqVKbqZenBzRWc5WIOxLAJjfz
 67M0P9N5zCXLtKQoJ6Gzg4rZuworwiv3ywJ1qkuAyhnV3kcbeVp6VnJagUEBSlvYVhG76hLwK
 d5fy4U6xF6n/4fbhrx9x4w9VXW4uYXszTWtaZ+g/wg+oHs0eYK3V57Upcma4Q2ed4cXiFqLUI
 GiDic29st7me+n0zYcqPLRO0OzxKOwNdvNTNeriIjKjLCf3ydkbEqCNDxQovr5c+OIuW4fG6A
 LkdQud6yF3gIxv1ZFiF7MSn2d6yfHWtSAPImQp97BO6F5SYuaSNNzJSt1rNYFDnyqzFDvYaxZ
 WaIruIDk77F6vjwr+FABncRvyJi5aIrEn+eSeQ1YmETNxTrHiYN83kZck1TFLvcoV6HnLq2Lo
 PO8SBXuJxQChAKvcZMkdvY4bysrhWYuXfKWKhnxqLb9mpNjM/AtCoEJc3zs7btOKPia1Yblgr
 VUrCWvo074gMwZzNhGCpRG8gGVO6elhFR1186bCswx7GcKLTdc5h73BwE8Rt/bA08xCqqheJP
 ZSpbYp58+Mw0odt0+Hk16YdTM7P3w3zg2/Ez5Q26Nft0uzAMe/iJHytNRI55eQe6PEkSNClm0
 nUhRnl01x2LBJ1eZFbQfsdaNrcu8LV01fnOJuQiqSA5Iuui55RT3j9IWS/b2GmFO0lzOhB7O7
 n4te5KYDvELhq8CC+z3IN01eBUF6b00jQ9yTNGlBLMRCV/9Y65kPeOUakEai811glaNOkKk73
 LbBIlTg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function qsort_s() was introduced with C11 Annex K; it provides the
ability to pass a context pointer to the comparison function, supports
the convention of using a NULL pointer for an empty array and performs a
few safety checks.

Add an implementation based on compat/qsort.c for platforms that lack a
native standards-compliant qsort_s() (i.e. basically everyone).  It
doesn't perform the full range of possible checks: It uses size_t
instead of rsize_t and doesn't check nmemb and size against RSIZE_MAX
because we probably don't have the restricted size type defined.  For
the same reason it returns int instead of errno_t.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Makefile          | 10 ++++++++
 compat/qsort_s.c  | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h |  6 +++++
 3 files changed, 85 insertions(+)
 create mode 100644 compat/qsort_s.c

diff --git a/Makefile b/Makefile
index f53fcc90d..2245fd95d 100644
--- a/Makefile
+++ b/Makefile
@@ -279,6 +279,9 @@ all::
 # is a simplified version of the merge sort used in glibc. This is
 # recommended if Git triggers O(n^2) behavior in your platform's qsort().
 #
+# Define HAVE_QSORT_S if your platform provides a qsort_s() that's
+# compatible with the one described in C11 Annex K.
+#
 # Define UNRELIABLE_FSTAT if your system's fstat does not return the same
 # information on a not yet closed file that lstat would return for the same
 # file after it was closed.
@@ -1423,6 +1426,13 @@ ifdef INTERNAL_QSORT
 	COMPAT_CFLAGS += -DINTERNAL_QSORT
 	COMPAT_OBJS += compat/qsort.o
 endif
+
+ifdef HAVE_QSORT_S
+	COMPAT_CFLAGS += -DHAVE_QSORT_S
+else
+	COMPAT_OBJS += compat/qsort_s.o
+endif
+
 ifdef RUNTIME_PREFIX
 	COMPAT_CFLAGS += -DRUNTIME_PREFIX
 endif
diff --git a/compat/qsort_s.c b/compat/qsort_s.c
new file mode 100644
index 000000000..52d1f0a73
--- /dev/null
+++ b/compat/qsort_s.c
@@ -0,0 +1,69 @@
+#include "../git-compat-util.h"
+
+/*
+ * A merge sort implementation, simplified from the qsort implementation
+ * by Mike Haertel, which is a part of the GNU C Library.
+ * Added context pointer, safety checks and return value.
+ */
+
+static void msort_with_tmp(void *b, size_t n, size_t s,
+			   int (*cmp)(const void *, const void *, void *),
+			   char *t, void *ctx)
+{
+	char *tmp;
+	char *b1, *b2;
+	size_t n1, n2;
+
+	if (n <= 1)
+		return;
+
+	n1 = n / 2;
+	n2 = n - n1;
+	b1 = b;
+	b2 = (char *)b + (n1 * s);
+
+	msort_with_tmp(b1, n1, s, cmp, t, ctx);
+	msort_with_tmp(b2, n2, s, cmp, t, ctx);
+
+	tmp = t;
+
+	while (n1 > 0 && n2 > 0) {
+		if (cmp(b1, b2, ctx) <= 0) {
+			memcpy(tmp, b1, s);
+			tmp += s;
+			b1 += s;
+			--n1;
+		} else {
+			memcpy(tmp, b2, s);
+			tmp += s;
+			b2 += s;
+			--n2;
+		}
+	}
+	if (n1 > 0)
+		memcpy(tmp, b1, n1 * s);
+	memcpy(b, t, (n - n2) * s);
+}
+
+int git_qsort_s(void *b, size_t n, size_t s,
+		int (*cmp)(const void *, const void *, void *), void *ctx)
+{
+	const size_t size = st_mult(n, s);
+	char buf[1024];
+
+	if (!n)
+		return 0;
+	if (!b || !cmp)
+		return -1;
+
+	if (size < sizeof(buf)) {
+		/* The temporary array fits on the small on-stack buffer. */
+		msort_with_tmp(b, n, s, cmp, buf, ctx);
+	} else {
+		/* It's somewhat large, so malloc it.  */
+		char *tmp = xmalloc(size);
+		msort_with_tmp(b, n, s, cmp, tmp, ctx);
+		free(tmp);
+	}
+	return 0;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 87237b092..d25f0bd4c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -988,6 +988,12 @@ static inline void sane_qsort(void *base, size_t nmemb, size_t size,
 		qsort(base, nmemb, size, compar);
 }
 
+#ifndef HAVE_QSORT_S
+int git_qsort_s(void *base, size_t nmemb, size_t size,
+		int (*compar)(const void *, const void *, void *), void *ctx);
+#define qsort_s git_qsort_s
+#endif
+
 #ifndef REG_STARTEND
 #error "Git requires REG_STARTEND support. Compile with NO_REGEX=NeedsStartEnd"
 #endif
-- 
2.11.0

