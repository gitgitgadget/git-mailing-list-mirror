From: Jeff King <peff@peff.net>
Subject: [PATCH 65/68] Makefile: drop D_INO_IN_DIRENT build knob
Date: Thu, 24 Sep 2015 17:08:30 -0400
Message-ID: <20150924210830.GJ30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:09:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDlC-00032s-VW
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510AbbIXVIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:08:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:36049 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754495AbbIXVId (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:08:33 -0400
Received: (qmail 12213 invoked by uid 102); 24 Sep 2015 21:08:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:08:33 -0500
Received: (qmail 29616 invoked by uid 107); 24 Sep 2015 21:08:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:08:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:08:30 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278613>

Now that fsck has dropped its inode-sorting, there are no
longer any users of this knob, and it can go away.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile         | 5 -----
 config.mak.uname | 3 ---
 configure.ac     | 7 -------
 3 files changed, 15 deletions(-)

diff --git a/Makefile b/Makefile
index 8d5df7e..2f350ca 100644
--- a/Makefile
+++ b/Makefile
@@ -74,8 +74,6 @@ all::
 # Define HAVE_PATHS_H if you have paths.h and want to use the default PATH
 # it specifies.
 #
-# Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
-#
 # Define NO_D_TYPE_IN_DIRENT if your platform defines DT_UNKNOWN but lacks
 # d_type in struct dirent (Cygwin 1.5, fixed in Cygwin 1.7).
 #
@@ -1160,9 +1158,6 @@ endif
 ifdef NO_D_TYPE_IN_DIRENT
 	BASIC_CFLAGS += -DNO_D_TYPE_IN_DIRENT
 endif
-ifdef NO_D_INO_IN_DIRENT
-	BASIC_CFLAGS += -DNO_D_INO_IN_DIRENT
-endif
 ifdef NO_GECOS_IN_PWENT
 	BASIC_CFLAGS += -DNO_GECOS_IN_PWENT
 endif
diff --git a/config.mak.uname b/config.mak.uname
index 943c439..f34dcaa 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -166,7 +166,6 @@ endif
 ifeq ($(uname_O),Cygwin)
 	ifeq ($(shell expr "$(uname_R)" : '1\.[1-6]\.'),4)
 		NO_D_TYPE_IN_DIRENT = YesPlease
-		NO_D_INO_IN_DIRENT = YesPlease
 		NO_STRCASESTR = YesPlease
 		NO_MEMMEM = YesPlease
 		NO_MKSTEMPS = YesPlease
@@ -370,7 +369,6 @@ ifeq ($(uname_S),Windows)
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	NATIVE_CRLF = YesPlease
 	DEFAULT_HELP_FORMAT = html
-	NO_D_INO_IN_DIRENT = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
@@ -520,7 +518,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_INET_NTOP = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
-	NO_D_INO_IN_DIRENT = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
diff --git a/configure.ac b/configure.ac
index 14012fa..3fcca61 100644
--- a/configure.ac
+++ b/configure.ac
@@ -767,13 +767,6 @@ elif test x$ac_cv_member_struct_stat_st_mtim_tv_nsec != xyes; then
 	GIT_CONF_SUBST([NO_NSEC])
 fi
 #
-# Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
-AC_CHECK_MEMBER(struct dirent.d_ino,
-[NO_D_INO_IN_DIRENT=],
-[NO_D_INO_IN_DIRENT=YesPlease],
-[#include <dirent.h>])
-GIT_CONF_SUBST([NO_D_INO_IN_DIRENT])
-#
 # Define NO_D_TYPE_IN_DIRENT if your platform defines DT_UNKNOWN but lacks
 # d_type in struct dirent (latest Cygwin -- will be fixed soonish).
 AC_CHECK_MEMBER(struct dirent.d_type,
-- 
2.6.0.rc3.454.g204ad51
