From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v6 2/3] compat: add a basename() compatibility function
Date: Sat, 30 May 2009 21:37:54 -0700
Message-ID: <1243744675-24160-2-git-send-email-davvid@gmail.com>
References: <1243744675-24160-1-git-send-email-davvid@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, markus.heidelberg@web.de,
	jnareb@gmail.com, j.sixt@viscovery.net,
	David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 31 06:38:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAcoQ-0008Bb-UA
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 06:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbZEaEiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 00:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbZEaEiE
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 00:38:04 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:60950 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbZEaEiE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 00:38:04 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2095514rvb.1
        for <git@vger.kernel.org>; Sat, 30 May 2009 21:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=90y6jW24XJJu9IFiTc+AexaBYat6vpXuqWhNErNGruQ=;
        b=ahW4KJ7ZMffVZGULqxsm9r5SAnfzV/Drg5ZITN8N05mqzBM91gjRxOmCG2IoIUGLoe
         mWVZ2hWKs+e2h1WhQcld4kt+H/k8kIP1z8+J/TCI66+K0nCi5VtPg1qu0By9WmYQ/lo4
         6VArfeHahigMLN7wWg+eCDDArp+2ibo7W9QB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LT6Ys5hQDA2y5b96TuTTUdUQjPtdE/bon5VQXuZ6KN0u7caHA8Tk+1M2I3/BH7QVK6
         JcKcZ1dSWteNl/YGv546i7GEF77oeG68yjgU7gogn696eob3qzf5Q56PEPTa0oPQnLZt
         vay8qzZ7gEESkEpUxSl+n8hJmIoJls3W4oCpY=
Received: by 10.141.194.6 with SMTP id w6mr3908045rvp.118.1243744685471;
        Sat, 30 May 2009 21:38:05 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id d20sm4187815waa.12.2009.05.30.21.38.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 May 2009 21:38:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.178.g5b6b2
In-Reply-To: <1243744675-24160-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120376>

Some systems such as Windows lack libgen.h so provide a
basename() implementation for cross-platform use.

This introduces the NO_LIBGEN_H construct to the Makefile
and autoconf scripts.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Makefile          |   12 ++++++++++++
 compat/basename.c |   19 +++++++++++++++++++
 config.mak.in     |    1 +
 configure.ac      |    6 ++++++
 git-compat-util.h |    7 +++++++
 5 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100644 compat/basename.c

diff --git a/Makefile b/Makefile
index a70b5f0..caa3002 100644
--- a/Makefile
+++ b/Makefile
@@ -54,6 +54,8 @@ all::
 #
 # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
 #
+# Define NO_LIBGEN_H if you don't have libgen.h.
+#
 # Define NO_SYS_SELECT_H if you don't have sys/select.h.
 #
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
@@ -834,6 +836,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_PREAD = YesPlease
 	NO_OPENSSL = YesPlease
 	NO_CURL = YesPlease
+	NO_LIBGEN_H = UnfortunatelyYes
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
 	NO_SETENV = YesPlease
@@ -855,6 +858,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_POSIX_ONLY_PROGRAMS = YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
+	USE_WIN32_FS = YesPlease
 	USE_WIN32_MMAP = YesPlease
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
@@ -899,6 +903,11 @@ ifndef CC_LD_DYNPATH
 	endif
 endif
 
+ifdef NO_LIBGEN_H
+	COMPAT_CFLAGS += -DNO_LIBGEN_H
+	COMPAT_OBJS += compat/basename.o
+endif
+
 ifdef NO_CURL
 	BASIC_CFLAGS += -DNO_CURL
 else
@@ -1046,6 +1055,9 @@ else
 		COMPAT_OBJS += compat/win32mmap.o
 	endif
 endif
+ifdef USE_WIN32_FS
+	COMPAT_CFLAGS += -DWIN32_FS
+endif
 ifdef OBJECT_CREATION_USES_RENAMES
 	COMPAT_CFLAGS += -DOBJECT_CREATION_MODE=1
 endif
diff --git a/compat/basename.c b/compat/basename.c
new file mode 100644
index 0000000..c45716a
--- /dev/null
+++ b/compat/basename.c
@@ -0,0 +1,19 @@
+#include "../git-compat-util.h"
+
+/* Adapted from libiberty's basename.c.  */
+char *gitbasename (char *path)
+{
+	const char *base;
+
+#ifdef USE_WIN32_FS
+	/* Skip over the disk name in MSDOS pathnames. */
+	if (isalpha(path[0]) && path[1] == ':')
+		path += 2;
+#endif
+	for (base = path; *path; path++) {
+		if (is_dir_sep(*path)) {
+			base = path + 1;
+		}
+	}
+	return (char *)base;
+}
diff --git a/config.mak.in b/config.mak.in
index b6619af..e8d96e8 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -30,6 +30,7 @@ NEEDS_SSL_WITH_CRYPTO=@NEEDS_SSL_WITH_CRYPTO@
 NO_OPENSSL=@NO_OPENSSL@
 NO_CURL=@NO_CURL@
 NO_EXPAT=@NO_EXPAT@
+NO_LIBGEN_H=@NO_LIBGEN_H@
 NEEDS_LIBICONV=@NEEDS_LIBICONV@
 NEEDS_SOCKET=@NEEDS_SOCKET@
 NO_SYS_SELECT_H=@NO_SYS_SELECT_H@
diff --git a/configure.ac b/configure.ac
index 953da07..3e7a0e4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -627,6 +627,12 @@ AC_SUBST(SNPRINTF_RETURNS_BOGUS)
 ## (in default C library and libraries checked by AC_CHECK_LIB)
 AC_MSG_NOTICE([CHECKS for library functions])
 #
+# Define NO_LIBGEN_H if you don't have libgen.h.
+AC_CHECK_HEADER([libgen.h],
+[NO_LIBGEN_H=],
+[NO_LIBGEN_H=UnfortunatelyYes])
+AC_SUBST(NO_LIBGEN_H)
+#
 # Define NO_STRCASESTR if you don't have strcasestr.
 GIT_CHECK_FUNC(strcasestr,
 [NO_STRCASESTR=],
diff --git a/git-compat-util.h b/git-compat-util.h
index 5a2d4e7..d248047 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -97,6 +97,13 @@
 #include "compat/mingw.h"
 #endif	/* __MINGW32__ */
 
+#ifndef NO_LIBGEN_H
+#include <libgen.h>
+#else
+#define basename gitbasename
+extern char *gitbasename(char *);
+#endif
+
 #ifndef NO_ICONV
 #include <iconv.h>
 #endif
-- 
1.6.3.1.178.g5b6b2
