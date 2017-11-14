Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E007201C8
	for <e@80x24.org>; Tue, 14 Nov 2017 09:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754162AbdKNJeN (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 04:34:13 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:51407 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754115AbdKNJeK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 04:34:10 -0500
Received: by mail-pf0-f195.google.com with SMTP id j28so11677939pfk.8
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 01:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C3H29gOnwxC8aH+x2qthlUz+nTXKjqF2f2lY8LfoFvQ=;
        b=oYe5avvor4I0CW4rDbcvdR6PFZRNgcEHFbkpnNhb4osbgHWHThmed2c4l90euIp2cE
         4uj2vmvUk4djNn8pvulc74cfWtc3JWu+oTxGBdu3pbpBcUBGAIGI69u1J30Li0x56MbM
         0t+nAASQ2MqujGB2JsDbxRU60AQ5Nv403uvz0OpoAMeHodpwx66oQyvf9c7NvMjYFmMk
         aYZ9A5EF/EKGoLU8bZI7wZbvyC1OFxb2rG28QpNLT5JL8wPkE156bzB1J62gIhYEcbYu
         rIYAdVb/RkaiJWItFI8xzqYwN4eLA1TndNitPm3xo9pHoTQNoXmNqTDmMnBd/Sk5VR16
         SQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C3H29gOnwxC8aH+x2qthlUz+nTXKjqF2f2lY8LfoFvQ=;
        b=jPOxgHZPEW2Jk+zhdG2W9VXI2iWptD8Q4JDDVA7EmnF63c73AWAagfwEpIH5ghVciY
         jIT/ptpOLpNPjg4torIXvtix8Skh1THZOQJsALqGeUNLWOPwhky1qaGgIyKUflCELPPO
         4HPzrtpuhmI5088QSaask5y3bA7tsQJ3a5tNjGZ1MhO5MAakm1W9a7ZqTMbAgXJV0yLn
         pX+xrk2FnRA2/MoQbSfRnkZgtAmmUjTlVIsXYNg55Sno+81NipDt89PvLZ2lG/e9TIXQ
         Rv6P0sz5qzjvOGFbO6UZSZkFbRRMVcHw38J6gkORXtePhLS1FJFyLSaEtkfWEAHrUcxP
         O24A==
X-Gm-Message-State: AJaThX7QjWgz1VOeuluczsWET0/r/hiIZVmW7uUz+H9lzeW5oBrJLkQN
        zj5Z1FFqLkGlZubPr0ywuwg=
X-Google-Smtp-Source: AGs4zMbrGcQZCmWC68fpEG/lT1dJe6aGPhL0eIkT/qTak9P10Rm9/mzwSQwjZ+yS32PZMMZkE8xgtQ==
X-Received: by 10.84.196.129 with SMTP id l1mr11780849pld.290.1510652049630;
        Tue, 14 Nov 2017 01:34:09 -0800 (PST)
Received: from t410s.hsd1.wa.comcast.net (c-73-53-16-142.hsd1.wa.comcast.net. [73.53.16.142])
        by smtp.googlemail.com with ESMTPSA id w3sm2690004pge.59.2017.11.14.01.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2017 01:34:08 -0800 (PST)
From:   Shawn Landden <slandden@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Shawn Landden <slandden@gmail.com>
Subject: [PATCH] sha1: add gnutls as a sha1 provider
Date:   Tue, 14 Nov 2017 01:34:02 -0800
Message-Id: <20171114093402.29256-1-slandden@gmail.com>
X-Mailer: git-send-email 2.15.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GNUTLS uses the same cryptograms SHA1 routines (Cryptograms)
by Andy Polyakov <appro@openssl.org> as OpenSSL, but with a license
that is acceptable for downstream packagers.

This is not the cleanest way to use the GNUTLS library,
as it is reallocating the context every time, and GNUTLS itsself
fudges an OpenSSL CTX to use the cryptograms code, HOWEVER
in my benchmarks the code performs as well as both the OpenSSL library,
and my own integration of cryptograms with git.

I think this is preferrable to bringing the assembly routines into
the git code-base, as a way of getting access to these high-performance
routines to a git available in Debian, Ubuntu, or Fedora (which
all use BLK_SHA1=1 due to GPLv2 + OpenSSL license considerations,
see Debian Bug #879459).

I struggle with autotools, and I suspect something is wrong with that
part of the patch.

This laptop is ancient, Intel(R) Core(TM) i5 CPU M 520.
When I get arm64 hardware in a week I will update with new benchmarks.
Builtin (BLK_SHA1=1):
~/git/git$ time git fsck
Checking object directories: 100% (256/256), done.
Checking objects: 100% (238410/238410), done.
Checking connectivity: 236605, done.

real	0m25.806s
user	0m25.187s
sys	0m0.579s

This patch:
~/git/git$ time ./git fsck
Checking object directories: 100% (256/256), done.
Checking objects: 100% (238410/238410), done.
Checking connectivity: 236606, done.

real	0m22.368s
user	0m21.790s
sys	0m0.539s

Signed-off-by: Shawn Landden <slandden@gmail.com>
---
 Makefile           | 10 ++++++++++
 configure.ac       | 31 +++++++++++++++++++++++++++++++
 gnutls-sha1/sha1.c | 25 +++++++++++++++++++++++++
 gnutls-sha1/sha1.h | 12 ++++++++++++
 hash.h             |  2 ++
 5 files changed, 80 insertions(+)
 create mode 100644 gnutls-sha1/sha1.c
 create mode 100644 gnutls-sha1/sha1.h

diff --git a/Makefile b/Makefile
index cd7598599..e23648dbd 100644
--- a/Makefile
+++ b/Makefile
@@ -1252,7 +1252,9 @@ ifndef NO_OPENSSL
 	endif
 else
 	BASIC_CFLAGS += -DNO_OPENSSL
+ifndef GNUTLS_SHA1
 	BLK_SHA1 = 1
+endif
 	OPENSSL_LIBSSL =
 endif
 ifdef NO_OPENSSL
@@ -1481,6 +1483,11 @@ ifdef BLK_SHA1
 	LIB_OBJS += block-sha1/sha1.o
 	BASIC_CFLAGS += -DSHA1_BLK
 else
+ifdef GNUTLS_SHA1
+	LIB_OBJS += gnutls-sha1/sha1.o
+	BASIC_CFLAGS += -DSHA1_GNUTLS
+	EXTLIBS += -lgnutls
+endif
 ifdef PPC_SHA1
 	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
 	BASIC_CFLAGS += -DSHA1_PPC
@@ -1488,6 +1495,8 @@ else
 ifdef APPLE_COMMON_CRYPTO
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
 	BASIC_CFLAGS += -DSHA1_APPLE
+else
+ifdef GNUTLS_SHA1
 else
 	DC_SHA1 := YesPlease
 	BASIC_CFLAGS += -DSHA1_DC
@@ -1506,6 +1515,7 @@ ifdef DC_SHA1_SUBMODULE
 else
 	LIB_OBJS += sha1dc/sha1.o
 	LIB_OBJS += sha1dc/ubc_check.o
+endif
 endif
 	BASIC_CFLAGS += \
 		-DSHA1DC_NO_STANDARD_INCLUDES \
diff --git a/configure.ac b/configure.ac
index 2f55237e6..109c4758d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -250,6 +250,23 @@ AS_HELP_STRING([--with-openssl],[use OpenSSL library (default is YES)])
 AS_HELP_STRING([],              [ARG can be prefix for openssl library and headers]),
 GIT_PARSE_WITH([openssl]))
 
+# Define GNUTLS_SHA1 if you have and want to use libgnutls. This offers
+# similar sha1 routines as openssl.
+AC_ARG_WITH(gnutls,
+AS_HELP_STRING([--with-gnutls],[use GNUTLS library (default is YES)]),
+    if test "$withval" = "no"; then
+        USE_GNUTLS=
+    elif test "$withval" = "yes"; then
+	USE_GNUTLS=YesPlease
+    else
+	USE_GNUTLS=YesPlease
+	LIBGNUTLSDIR=$withval
+	AC_MSG_NOTICE([Setting LIBGNUTLSDIR to $LIBGNUTLSDIR])
+        dnl USE_LIBGNUTLS can still be modified below, so don't substitute
+        dnl it yet.
+	GIT_CONF_SUBST([LIBGNUTLSDIR])
+    fi)
+
 # Define USE_LIBPCRE if you have and want to use libpcre. Various
 # commands such as log and grep offer runtime options to use
 # Perl-compatible regular expressions instead of standard or extended
@@ -540,6 +557,20 @@ GIT_UNSTASH_FLAGS($OPENSSLDIR)
 GIT_CONF_SUBST([NEEDS_SSL_WITH_CRYPTO])
 GIT_CONF_SUBST([NO_OPENSSL])
 
+#
+# Handle USE_GNUTLS from above
+#
+if test -n "$USE_GNUTLS"; then
+
+GIT_STASH_FLAGS($LIBGNUTLSDIR)
+
+AC_CHECK_LIB([gnutls], [gnutls_hash_init],
+[GNUTLS_SHA1=YesPlease],
+[GNUTLS_SHA1=])
+
+GIT_UNSTASH_FLAGS($LIBGNUTLSDIR)
+
+fi
 #
 # Handle the USE_LIBPCRE1 and USE_LIBPCRE2 options potentially set
 # above.
diff --git a/gnutls-sha1/sha1.c b/gnutls-sha1/sha1.c
new file mode 100644
index 000000000..f7ede4ddf
--- /dev/null
+++ b/gnutls-sha1/sha1.c
@@ -0,0 +1,25 @@
+/* this is only to get definitions for memcpy(), ntohl() and htonl() */
+#include "../git-compat-util.h"
+
+#include <gnutls/gnutls.h>
+#include <gnutls/crypto.h>
+
+#include "sha1.h"
+
+void gnutls_SHA1_Init(gnutls_SHA_CTX *ctx)
+{
+	int ret;
+	ret = gnutls_hash_init((void *) &ctx->handle, GNUTLS_DIG_SHA1);
+	if (ret < 0)
+		abort();
+}
+
+void gnutls_SHA1_Update(gnutls_SHA_CTX *ctx, const void *data, unsigned long len)
+{
+	gnutls_hash(ctx->handle, data, len);
+}
+
+void gnutls_SHA1_Final(unsigned char hashout[20], gnutls_SHA_CTX *ctx)
+{
+	gnutls_hash_deinit(ctx->handle, hashout);
+}
diff --git a/gnutls-sha1/sha1.h b/gnutls-sha1/sha1.h
new file mode 100644
index 000000000..ade60fcbe
--- /dev/null
+++ b/gnutls-sha1/sha1.h
@@ -0,0 +1,12 @@
+typedef struct {
+	void *handle;
+} gnutls_SHA_CTX;
+
+void gnutls_SHA1_Init(gnutls_SHA_CTX *ctx);
+void gnutls_SHA1_Update(gnutls_SHA_CTX *ctx, const void *dataIn, unsigned long len);
+void gnutls_SHA1_Final(unsigned char hashout[20], gnutls_SHA_CTX *ctx);
+
+#define platform_SHA_CTX	gnutls_SHA_CTX
+#define platform_SHA1_Init	gnutls_SHA1_Init
+#define platform_SHA1_Update	gnutls_SHA1_Update
+#define platform_SHA1_Final	gnutls_SHA1_Final
diff --git a/hash.h b/hash.h
index 024d0d3d5..7e5e307fc 100644
--- a/hash.h
+++ b/hash.h
@@ -9,6 +9,8 @@
 #include <openssl/sha.h>
 #elif defined(SHA1_DC)
 #include "sha1dc_git.h"
+#elif defined(SHA1_GNUTLS)
+#include "gnutls-sha1/sha1.h"
 #else /* SHA1_BLK */
 #include "block-sha1/sha1.h"
 #endif
-- 
2.15.0.rc2

