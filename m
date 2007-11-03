From: Blake Ramsdell <blaker@gmail.com>
Subject: [PATCH] Removed OLD_ICONV in favor of checking _LIBICONV_VERSION directly
Date: Fri,  2 Nov 2007 17:00:10 -0700
Message-ID: <1194048010-65955-1-git-send-email-blaker@gmail.com>
References: <985966520711021303g905f638y2056219c22e5edeb@mail.gmail.com>
Cc: Blake Ramsdell <blaker@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 01:00:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io6RA-0002it-Fg
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 01:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755925AbXKCAAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 20:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755830AbXKCAAM
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 20:00:12 -0400
Received: from c-24-17-217-200.hsd1.mn.comcast.net ([24.17.217.200]:56056 "EHLO
	Adverlingus.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755575AbXKCAAL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 20:00:11 -0400
Received: by Adverlingus.local (Postfix, from userid 501)
	id 63C1AEFFEC; Fri,  2 Nov 2007 17:00:10 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.GIT
In-Reply-To: <985966520711021303g905f638y2056219c22e5edeb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63194>

Signed-off-by: Blake Ramsdell <blaker@gmail.com>
---
 Makefile |    8 --------
 utf8.c   |    2 +-
 2 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 71479a2..96c8a73 100644
--- a/Makefile
+++ b/Makefile
@@ -95,9 +95,6 @@ all::
 #
 # Define NO_ICONV if your libc does not properly support iconv.
 #
-# Define OLD_ICONV if your library has an old iconv(), where the second
-# (input buffer pointer) parameter is declared with type (const char **).
-#
 # Define NO_R_TO_GCC_LINKER if your gcc does not like "-R/path/lib"
 # that tells runtime paths to dynamic libraries;
 # "-Wl,-rpath=/path/lib" is used instead.
@@ -401,7 +398,6 @@ endif
 ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
-	OLD_ICONV = UnfortunatelyYes
 	NO_STRLCPY = YesPlease
 	NO_MEMMEM = YesPlease
 endif
@@ -657,10 +653,6 @@ ifdef NO_ICONV
 	BASIC_CFLAGS += -DNO_ICONV
 endif
 
-ifdef OLD_ICONV
-	BASIC_CFLAGS += -DOLD_ICONV
-endif
-
 ifdef PPC_SHA1
 	SHA1_HEADER = "ppc/sha1.h"
 	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
diff --git a/utf8.c b/utf8.c
index 4efef6f..a7feb4f 100644
--- a/utf8.c
+++ b/utf8.c
@@ -300,7 +300,7 @@ int is_encoding_utf8(const char *name)
  * with iconv.  If the conversion fails, returns NULL.
  */
 #ifndef NO_ICONV
-#ifdef OLD_ICONV
+#if _LIBICONV_VERSION <= 0x0109
 	typedef const char * iconv_ibp;
 #else
 	typedef char * iconv_ibp;
-- 
1.5.3.GIT
