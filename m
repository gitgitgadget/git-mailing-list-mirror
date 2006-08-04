From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/5] autoconf: Unset NO_STH and NEED_STH when it is detected not needed
Date: Fri, 4 Aug 2006 23:43:59 +0200
Message-ID: <200608042343.59450.jnareb@gmail.com>
References: <200608042333.19011.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 04 23:43:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G97S3-00067s-9o
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 23:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161504AbWHDVnY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 17:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161505AbWHDVnX
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 17:43:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:12990 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161504AbWHDVnW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 17:43:22 -0400
Received: by nf-out-0910.google.com with SMTP id k26so31174nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 14:43:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qqiufSJ8W9/UuQeWqw2Q+2Qm3b81ZodGsFoT/RIII2SMcbuJGF8I0onB3Zj6L8tMNgQDGanIglK/lRZlsaD9+evgG4k4kVYxdg7p1tu3ju3aMhyLjLxhk3wx/bciB9PHiy816hmaMKfPm1SrXscEjgc5jiKDWgwnWYZeTrkg99Q=
Received: by 10.48.48.18 with SMTP id v18mr6014249nfv;
        Fri, 04 Aug 2006 14:43:21 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id c28sm2886644nfb.2006.08.04.14.43.20;
        Fri, 04 Aug 2006 14:43:21 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608042333.19011.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24847>

When configure detects some NO_XXX or NEEDS_XXX is unneeded, unset
this variable (actually set it to empty string).  This allow
autodetection to override the default set in Makefile.

Suggested-by: Junio C Hamano <junkio@cox.net>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 configure.ac |   49 +++++++++++++++++++++++++++++++++----------------
 1 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6557bd2..74984e1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -154,31 +154,36 @@ AC_MSG_NOTICE([CHECKS for libraries])
 #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl (Darwin).
-AC_CHECK_LIB([crypto], [SHA1_Init],[],
+AC_CHECK_LIB([crypto], [SHA1_Init],
+[GIT_CONF_APPEND_LINE(NEEDS_SSL_WITH_CRYPTO=)],
 [AC_CHECK_LIB([ssl], [SHA1_Init],
- [GIT_CONF_APPEND_LINE(NEEDS_SSL_WITH_CRYPTO=YesPlease)],
+ [GIT_CONF_APPEND_LINE(NEEDS_SSL_WITH_CRYPTO=YesPlease)
+  GIT_CONF_APPEND_LINE(NEEDS_SSL_WITH_CRYPTO=)],
  [GIT_CONF_APPEND_LINE(NO_OPENSSL=YesPlease)])])
 #
 # Define NO_CURL if you do not have curl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
-AC_CHECK_LIB([curl], [curl_global_init],[],
+AC_CHECK_LIB([curl], [curl_global_init],
+[GIT_CONF_APPEND_LINE(NO_CURL=)],
 [GIT_CONF_APPEND_LINE(NO_CURL=YesPlease)])
 #
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports.
-AC_CHECK_LIB([expat], [XML_ParserCreate],[],
+AC_CHECK_LIB([expat], [XML_ParserCreate],
+[GIT_CONF_APPEND_LINE(NO_EXPAT=)],
 [GIT_CONF_APPEND_LINE(NO_EXPAT=YesPlease)])
 #
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
-AC_CHECK_LIB([c], [iconv],[],
+AC_CHECK_LIB([c], [iconv],
+[GIT_CONF_APPEND_LINE(NEEDS_LIBICONV=)],
 [GIT_CONF_APPEND_LINE(NEEDS_LIBICONV=YesPlease)])
 #
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
 # Patrick Mauritz).
-AC_CHECK_LIB([c], [socket],[],
-[AC_CHECK_LIB([socket],[socket],
- [GIT_CONF_APPEND_LINE(NEEDS_SOCKET=YesPlease)],[])])
+AC_CHECK_LIB([c], [socket],
+[GIT_CONF_APPEND_LINE(NEEDS_SOCKET=)],
+[GIT_CONF_APPEND_LINE(NEEDS_SOCKET=YesPlease)])
 
 
 ## Checks for header files.
@@ -188,24 +193,28 @@ ## Checks for typedefs, structures, and 
 AC_MSG_NOTICE([CHECKS for typedefs, structures, and compiler characteristics])
 #
 # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
-AC_CHECK_MEMBER(struct dirent.d_ino,[],
+AC_CHECK_MEMBER(struct dirent.d_ino,
+[GIT_CONF_APPEND_LINE(NO_D_INO_IN_DIRENT=)],
 [GIT_CONF_APPEND_LINE(NO_D_INO_IN_DIRENT=YesPlease)],
 [#include <dirent.h>])
 #
 # Define NO_D_TYPE_IN_DIRENT if your platform defines DT_UNKNOWN but lacks
 # d_type in struct dirent (latest Cygwin -- will be fixed soonish).
-AC_CHECK_MEMBER(struct dirent.d_type,[],
+AC_CHECK_MEMBER(struct dirent.d_type,
+[GIT_CONF_APPEND_LINE(NO_D_TYPE_IN_DIRENT=)],
 [GIT_CONF_APPEND_LINE(NO_D_TYPE_IN_DIRENT=YesPlease)],
 [#include <dirent.h>])
 #
 # Define NO_SOCKADDR_STORAGE if your platform does not have struct
 # sockaddr_storage.
-AC_CHECK_TYPE(struct sockaddr_storage,[],
+AC_CHECK_TYPE(struct sockaddr_storage,
+[GIT_CONF_APPEND_LINE(NO_SOCKADDR_STORAGE=)],
 [GIT_CONF_APPEND_LINE(NO_SOCKADDR_STORAGE=YesPlease)],
 [#include <netinet/in.h>])
 #
 # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
-AC_CHECK_TYPE(struct addrinfo,[],
+AC_CHECK_TYPE(struct addrinfo,
+[GIT_CONF_APPEND_LINE(NO_IPV6=)],
 [GIT_CONF_APPEND_LINE(NO_IPV6=YesPlease)],
 [#include <sys/types.h>
 #include <sys/socket.h>
@@ -230,6 +239,8 @@ AC_RUN_IFELSE(
 ])
 if test $ac_cv_c_c99_format = no; then
 	GIT_CONF_APPEND_LINE(NO_C99_FORMAT=YesPlease)
+else
+	GIT_CONF_APPEND_LINE(NO_C99_FORMAT=)
 fi
 
 
@@ -238,25 +249,31 @@ ## (in default C library and libraries c
 AC_MSG_NOTICE([CHECKS for library functions])
 #
 # Define NO_STRCASESTR if you don't have strcasestr.
-AC_CHECK_FUNC(strcasestr,[],
+AC_CHECK_FUNC(strcasestr,
+[GIT_CONF_APPEND_LINE(NO_STRCASESTR=)],
 [GIT_CONF_APPEND_LINE(NO_STRCASESTR=YesPlease)])
 #
 # Define NO_STRLCPY if you don't have strlcpy.
-AC_CHECK_FUNC(strlcpy,[],
+AC_CHECK_FUNC(strlcpy,
+[GIT_CONF_APPEND_LINE(NO_STRLCPY=)],
 [GIT_CONF_APPEND_LINE(NO_STRLCPY=YesPlease)])
 #
 # Define NO_SETENV if you don't have setenv in the C library.
-AC_CHECK_FUNC(setenv,[],
+AC_CHECK_FUNC(setenv,
+[GIT_CONF_APPEND_LINE(NO_SETENV=)],
 [GIT_CONF_APPEND_LINE(NO_SETENV=YesPlease)])
 #
 # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
-AC_CHECK_FUNC(getaddrinfo,[],
+AC_CHECK_FUNC(getaddrinfo,
+[GIT_CONF_APPEND_LINE(NO_IPV6=)],
 [GIT_CONF_APPEND_LINE(NO_IPV6=YesPlease)])
 #
 # Define NO_MMAP if you want to avoid mmap.
 AC_FUNC_MMAP
 if test $ac_cv_func_mmap_fixed_mapped != yes; then
 	GIT_CONF_APPEND_LINE(NO_MMAP=YesPlease)
+else
+	GIT_CONF_APPEND_LINE(NO_MMAP=)
 fi
 #
 # Define NO_ICONV if your libc does not properly support iconv.
-- 
1.4.1.1
