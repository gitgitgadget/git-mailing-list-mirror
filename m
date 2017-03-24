Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15D4B1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 23:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754624AbdCXXZG (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 19:25:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:65149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751773AbdCXXZE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 19:25:04 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbrR4-1cZTiy0uIA-00JL7k; Sat, 25
 Mar 2017 00:24:54 +0100
Date:   Sat, 25 Mar 2017 00:24:52 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/7] Makefile: optionally compile with both SHA1DC and
 SHA1_OPENSSL
In-Reply-To: <cover.1490397869.git.johannes.schindelin@gmx.de>
Message-ID: <7a2444f08dea1b2fe497ae7498eba44626414d29.1490397869.git.johannes.schindelin@gmx.de>
References: <cover.1490397869.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3Q/tE6NevILVS9H0KsjcXSQsKGsKMbfv9O2n0/GQdslZmKs58vT
 vKPx1RQdN8h5a0a1pSskvXxdLwRZWTkY6T2UHrfcPUxq0rNDqNG01T5kCnNVRUEhvW/XEcO
 siw/68twln920bXNUp4w0FEMuLlnaGjelX53BJDSp3aMHxIWHc1MQfC4UwmF2p/GqzoT/HP
 IF2Nk1ExhEbINQEjAK8YQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B71W/48Wuwg=:nEsbby/m5paEDN//gKVDbI
 V2XD22j1+Qawmt3wMlTNpgj6YaPy0rp+D+8M9bse8cg5rpx+wXFleIdu+S4xunSxhfgcWrxoB
 Vspo+yBYCrjtbsGPYKqchlaspSbtfi2RBJzPBq09eW/uNH/Cbxw4MpdLcwykPLCBp+OeQB7Gr
 qLeTdvc9Ag4yaHMQPZBmOzgOMeN92UArcdtSdaa5XdnprApFRehSe9l9D4bRbBiKgGno65kKe
 l+tV7pZizrLbtvOlUrMzl12lLQGEc2ngiN8QEBii9ycRxIXDyALZa36D1k18k629nsP6lCbJW
 8b9txIwowH+o1Cc45tn+/w48/VPvpwBo3XL0l53eKH99R6NcBZC0oDULia/C5c0hnfFnubQTO
 DkbdHzKLrGLyT6bSkiu3uVRXhrQYP8zNR+NDMklqJfmxogcJCaAXTvLXsPEor5wCKshYaNI67
 +rxStdb/QN5wwUjiO/RIXG8Z9O3ptJ6mduJIhhWrkQHJzKrYdveQVQuGHX8DAtKnJso8IIV0k
 +/LopWVmVAF1Nb9cBM9C06K9NOj7kZu3zG1UUAv/DScluC6D3pdseW0/dtNtjWBlO0nRtyfPZ
 O5EX7acgyI3/w3OHT47c7bhPA2dX6KrxDbFQ/06ksWAWCDt4e5cSs0nVEy7nULMEsw6k1Bios
 sfAB5qsBwUWy8Ic4867yFQqNahSGd7RPq8+xj+u6OJ5I4OyjmVpEV3kiZh7XZmoGfxGNiTsBV
 JVnApRSNw5BZCs5Qj1jyxgJeuayE3WfBskU0Sk9kMzG23a8HC2OUNSxxwQgBzAb4A/EiL34GE
 KofClKliqqNW8fme6J7AreFgy0ISg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nowadays, there are practical collision attacks on the SHA-1 algorithm.
For that reason, Git integrated code that detects attempts to sneak in
objects using those known attack vectors and enabled it by default.

The collision detection is not for free, though: when using the SHA1DC
code, calculating the SHA-1 takes substantially longer than using
OpenSSL's (in some case hardware-accelerated) SHA1-routines, and this
happens even when switching off the collision detection in SHA1DC's code.

Therefore, it makes sense to limit the use of the collision-detecting
SHA1DC to the cases where objects are introduced from any outside source,
and use the fast OpenSSL code instead when working on implicitly trusted
data (such as when the user calls `git add`).

This patch introduces the DC_AND_OPENSSL_SHA1 Makefile knob to compile
with both SHA1DC and OpenSSL's SHA-1 routines, defaulting to SHA1DC. A
later patch will add the ability to switch between them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile      | 12 ++++++++++++
 hash.h        |  2 +-
 sha1dc/sha1.c | 21 +++++++++++++++++++++
 sha1dc/sha1.h | 16 ++++++++++++++++
 4 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9f8b35ad41f..3e181d2f0e2 100644
--- a/Makefile
+++ b/Makefile
@@ -147,6 +147,11 @@ all::
 # Define OPENSSL_SHA1 environment variable when running make to link
 # with the SHA1 routine from openssl library.
 #
+# Define DC_AND_OPENSSL_SHA1 environment variable when running make to use
+# the collision-detecting sha1 algorithm by default, configurable via the
+# core.enableSHA1DC setting, falling back to OpenSSL's faster algorithm when
+# the collision detection is disabled.
+#
 # Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
 # in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
 # wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
@@ -1391,6 +1396,12 @@ ifdef APPLE_COMMON_CRYPTO
 	SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
 endif
 
+ifdef DC_AND_OPENSSL_SHA1
+	EXTLIBS += $(LIB_4_CRYPTO)
+	LIB_OBJS += sha1dc/sha1.o
+	LIB_OBJS += sha1dc/ubc_check.o
+	BASIC_CFLAGS += -DSHA1_DC_AND_OPENSSL
+else
 ifdef OPENSSL_SHA1
 	EXTLIBS += $(LIB_4_CRYPTO)
 	BASIC_CFLAGS += -DSHA1_OPENSSL
@@ -1415,6 +1426,7 @@ endif
 endif
 endif
 endif
+endif
 
 ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
diff --git a/hash.h b/hash.h
index a11fc9233fc..3a09343270d 100644
--- a/hash.h
+++ b/hash.h
@@ -7,7 +7,7 @@
 #include <CommonCrypto/CommonDigest.h>
 #elif defined(SHA1_OPENSSL)
 #include <openssl/sha.h>
-#elif defined(SHA1_DC)
+#elif defined(SHA1_DC) || defined(SHA1_DC_AND_OPENSSL)
 #include "sha1dc/sha1.h"
 #else /* SHA1_BLK */
 #include "block-sha1/sha1.h"
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index d99db4f2e1b..e6bcf0ffa86 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -1806,3 +1806,24 @@ void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, unsigned long len)
 	}
 	SHA1DCUpdate(ctx, data, len);
 }
+
+#ifdef SHA1_DC_AND_OPENSSL
+void (*SHA1_Init_func)(SHA_CTX_union *ctx) = (void *)SHA1DCInit;
+void (*SHA1_Update_func)(SHA_CTX_union *ctx, const void *pointer, size_t size) =
+	(void *)git_SHA1DCUpdate;
+int (*SHA1_Final_func)(unsigned char sha1[20], SHA_CTX_union *ctx) =
+	(void *)git_SHA1DCFinal;
+
+void toggle_sha1dc(int enable)
+{
+	if (enable) {
+		SHA1_Init_func = (void *)SHA1DCInit;
+		SHA1_Update_func = (void *)git_SHA1DCUpdate;
+		SHA1_Final_func = (void *)git_SHA1DCFinal;
+	} else {
+		SHA1_Init_func = (void *)SHA1_Init;
+		SHA1_Update_func = (void *)SHA1_Update;
+		SHA1_Final_func = (void *)SHA1_Final;
+	}
+}
+#endif
diff --git a/sha1dc/sha1.h b/sha1dc/sha1.h
index bd8bd928fb3..243c2fe0b6b 100644
--- a/sha1dc/sha1.h
+++ b/sha1dc/sha1.h
@@ -110,10 +110,26 @@ void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
  */
 void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
 
+#ifdef SHA1_DC_AND_OPENSSL
+extern void toggle_sha1dc(int enable);
+
+typedef union {
+	SHA1_CTX dc;
+	SHA_CTX openssl;
+} SHA_CTX_union;
+extern void (*SHA1_Init_func)(SHA_CTX_union *ctx);
+extern void (*SHA1_Update_func)(SHA_CTX_union *ctx, const void *data, size_t len);
+extern int (*SHA1_Final_func)(unsigned char sha1[20], SHA_CTX_union *ctx);
+#define platform_SHA_CTX SHA_CTX_union
+#define platform_SHA1_Init SHA1_Init_func
+#define platform_SHA1_Update SHA1_Update_func
+#define platform_SHA1_Final SHA1_Final_func
+#else
 #define platform_SHA_CTX SHA1_CTX
 #define platform_SHA1_Init SHA1DCInit
 #define platform_SHA1_Update git_SHA1DCUpdate
 #define platform_SHA1_Final git_SHA1DCFinal
+#endif
 
 #if defined(__cplusplus)
 }
-- 
2.12.1.windows.1


