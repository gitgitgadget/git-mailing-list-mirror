Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A44120A17
	for <e@80x24.org>; Sun, 22 Jan 2017 17:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750967AbdAVRxE (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 12:53:04 -0500
Received: from mout.web.de ([212.227.15.14]:51845 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbdAVRxD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 12:53:03 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMVpO-1cbPEj3fN0-008KvA; Sun, 22
 Jan 2017 18:51:15 +0100
Subject: [PATCH v2 1/5] compat: add qsort_s()
To:     Git List <git@vger.kernel.org>
References: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1caa38ac-0214-441f-8e8a-1ade0839337e@web.de>
Date:   Sun, 22 Jan 2017 18:51:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:c/kmF+Qjgw4POY3i2BGOwlG3Ol8XeyKDnU+savvEu93WBqLnxfi
 CdmnqCrP3QRHFOPpzZE+gwCiVWw0vXNQ9xUbDlDVxEhtVcUf4dauu4GC4Xib/V3aTJ0xLXm
 GdF7AzoL3PcKTtVYCOnfPgoQ8+c1NdE7ULtIlx32dZhlYtOfaWdg8Qsrq7UXMaPzPx0YSVm
 FVguDVty742epKCNjWuPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+DF0T+qbWrs=:RIEG66blrCUEpcxl6RFYyQ
 yOx20JSoTl7pG7ZihN8kFfeZnmtIUcpPBVGB1xvFkU1RF9FalsXW/Qft6hBT07EeHGgHLo9ZV
 YQsLL7373KBYgjCxCPD+oOVqOYN1CtYOCd/rN0W+pPliym3b1zGWKPFim1T/UrnHE8wzjoiKU
 LfKnlF9lzCF3i9DYkLhNtcLMNZN683L/19FkoKywu9s0Bybdkvni7UGjEfzHEUwQ52nHxAGCR
 bsTLTcPSH81ytrO/H7+xY0gI/DgzBtwUvcs+wdohyZIIR4RUcu+cPz8Sb2keTfibkiaWEg3+J
 D4sTzIc8yiqds2e/znKriY0czZa93dZ413FFFRdE8ampYklXG+uVA7gogLiJj1e7Kbivp3i/u
 JSoucy2BpWNnnL2cRUNWtZTvLVSL8oYWHoyLmsQW5naIpsMMDjhhXyXwo5TMJFGjR+NPcIXZ7
 9HC/mzEaV5qdYLAm6P4Vm6N3xJDZ9AY4o6u+mAKk9nAidgSF/WKvHcg1JjqzmGq6s9Al8XFNc
 BAuAzdxTRBG1XExWv9pF0muRikv3zMecdWhdoX/eWqgrY6L0q9GmbBJav0eFm0koELYzSgM1+
 /TLgcPp56EohBDuwhX6WiRK8V0VQZb8gLJeBrfxFyyIgYoLiFXjct9t/LbzQhwx+YG1nWdhcu
 kwA+BiCj96L5/28EhONXZ25sygqIdPhc+uysjPT/IBePYFVM07iLOxfMUGTiNmDq1Z0bf/hYe
 VBaBaAK8ENZ1lBneuqEltLsubtaQPB0ef9sTflRBLlhES6wK22ktI2/UlETm6bTVblTEz5AsT
 sVxUFpa
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
 Makefile          |  8 +++++++
 compat/qsort_s.c  | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h |  6 +++++
 3 files changed, 83 insertions(+)
 create mode 100644 compat/qsort_s.c

diff --git a/Makefile b/Makefile
index 27afd0f378..53ecc84e28 100644
--- a/Makefile
+++ b/Makefile
@@ -279,6 +279,9 @@ all::
 # is a simplified version of the merge sort used in glibc. This is
 # recommended if Git triggers O(n^2) behavior in your platform's qsort().
 #
+# Define HAVE_ISO_QSORT_S if your platform provides a qsort_s() that's
+# compatible with the one described in C11 Annex K.
+#
 # Define UNRELIABLE_FSTAT if your system's fstat does not return the same
 # information on a not yet closed file that lstat would return for the same
 # file after it was closed.
@@ -1418,6 +1421,11 @@ ifdef INTERNAL_QSORT
 	COMPAT_CFLAGS += -DINTERNAL_QSORT
 	COMPAT_OBJS += compat/qsort.o
 endif
+ifdef HAVE_ISO_QSORT_S
+	COMPAT_CFLAGS += -DHAVE_ISO_QSORT_S
+else
+	COMPAT_OBJS += compat/qsort_s.o
+endif
 ifdef RUNTIME_PREFIX
 	COMPAT_CFLAGS += -DRUNTIME_PREFIX
 endif
diff --git a/compat/qsort_s.c b/compat/qsort_s.c
new file mode 100644
index 0000000000..52d1f0a73d
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
index 87237b092b..f706744e6a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -988,6 +988,12 @@ static inline void sane_qsort(void *base, size_t nmemb, size_t size,
 		qsort(base, nmemb, size, compar);
 }
 
+#ifndef HAVE_ISO_QSORT_S
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

