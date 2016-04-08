From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH 4/4] configure: remove checking for HMAC_CTX_cleanup
Date: Sat,  9 Apr 2016 01:22:16 +0900
Message-ID: <ad0647c1b135ce2fb21daae35a45209715d7ebbc.1460130092.git.k@rhe.jp>
References: <cover.1460130092.git.k@rhe.jp>
Cc: Kazuki Yamaguchi <k@rhe.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 18:22:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoZBD-0000dJ-Bt
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 18:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758361AbcDHQWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 12:22:36 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:42472 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864AbcDHQWd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 12:22:33 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id EA5F061CA7;
	Fri,  8 Apr 2016 16:22:30 +0000 (UTC)
X-Mailer: git-send-email 2.8.1.104.g0d1aca6
In-Reply-To: <cover.1460130092.git.k@rhe.jp>
In-Reply-To: <cover.1460130092.git.k@rhe.jp>
References: <cover.1460130092.git.k@rhe.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291043>

We don't need it, as we no longer use HMAC_CTX_cleanup() directly.

Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
---
 Makefile          | 6 ------
 configure.ac      | 4 ----
 git-compat-util.h | 3 ---
 3 files changed, 13 deletions(-)

diff --git a/Makefile b/Makefile
index 2742a6977c6a..47ccb0042591 100644
--- a/Makefile
+++ b/Makefile
@@ -355,9 +355,6 @@ all::
 #
 # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC in librt.
 #
-# Define NO_HMAC_CTX_CLEANUP if your OpenSSL is version 0.9.6b or earlier to
-# cleanup the HMAC context with the older HMAC_cleanup function.
-#
 # Define USE_PARENS_AROUND_GETTEXT_N to "yes" if your compiler happily
 # compiles the following initialization:
 #
@@ -1138,9 +1135,6 @@ ifndef NO_OPENSSL
 	ifdef NEEDS_CRYPTO_WITH_SSL
 		OPENSSL_LIBSSL += -lcrypto
 	endif
-	ifdef NO_HMAC_CTX_CLEANUP
-		BASIC_CFLAGS += -DNO_HMAC_CTX_CLEANUP
-	endif
 else
 	BASIC_CFLAGS += -DNO_OPENSSL
 	BLK_SHA1 = 1
diff --git a/configure.ac b/configure.ac
index 0cd9f4680b84..c27902574734 100644
--- a/configure.ac
+++ b/configure.ac
@@ -970,10 +970,6 @@ AC_CHECK_LIB([iconv], [locale_charset],
                      [CHARSET_LIB=-lcharset])])
 GIT_CONF_SUBST([CHARSET_LIB])
 #
-# Define NO_HMAC_CTX_CLEANUP=YesPlease if HMAC_CTX_cleanup is missing.
-AC_CHECK_LIB([crypto], [HMAC_CTX_cleanup],
-	[], [GIT_CONF_SUBST([NO_HMAC_CTX_CLEANUP], [YesPlease])])
-#
 # Define HAVE_CLOCK_GETTIME=YesPlease if clock_gettime is available.
 GIT_CHECK_FUNC(clock_gettime,
 	[HAVE_CLOCK_GETTIME=YesPlease],
diff --git a/git-compat-util.h b/git-compat-util.h
index 474395471f62..1f8b5f3b1f1a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -279,9 +279,6 @@ extern char *gitdirname(char *);
 #endif
 #include <openssl/ssl.h>
 #include <openssl/err.h>
-#ifdef NO_HMAC_CTX_CLEANUP
-#define HMAC_CTX_cleanup HMAC_cleanup
-#endif
 #endif
 
 /* On most systems <netdb.h> would have given us this, but
-- 
2.8.1.104.g0d1aca6
