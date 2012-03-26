From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH 2/3] configure: avoid some code repetitions thanks to m4_{push,pop}def
Date: Mon, 26 Mar 2012 18:42:25 +0200
Message-ID: <4732affdd77695e93817935c3f44bbad5e450d8c.1332779755.git.stefano.lattarini@gmail.com>
References: <cover.1331333479.git.stefano.lattarini@gmail.com>
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 18:42:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCD0M-0000uJ-39
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 18:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932940Ab2CZQmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 12:42:45 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45699 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932784Ab2CZQmn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 12:42:43 -0400
Received: by mail-ey0-f174.google.com with SMTP id q12so1592623eaa.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=Q945Wbekxn5ZXSe6dHrX02NiQTSVByQLZ4CBpmDauXo=;
        b=vTS/7bRmbnPciwdlh21/+sq1swyWlqQuRBpE7dphjV3EQkk5rzS76GdgXyzYMLeVg4
         oj/YfvkRHO1LmrfLYKtGyfWjG3bRfI8gWx+ofNm7qFxGrtfO6smf1m/EvQaASBOl7HIX
         EDjCYsQcSXkjhhVRUGUeiY8aKg5fBOQnWA5tkKgGmPBU2UL59r6urzs76X0PscvoTXKC
         BWn6Nl1e8oTlov3Ebjv0o7t2Y/qwkATy36fDyN8aJFCGCSiEv6fh0cWkOOvRwvPjcYLD
         pwzT49++mvKptEzkwN1nOXR4DSyT7SrSnIgFVo0QhTU/04viUSAiWqUlgcmZemFSkvOC
         yOKg==
Received: by 10.213.15.129 with SMTP id k1mr1584363eba.70.1332780162954;
        Mon, 26 Mar 2012 09:42:42 -0700 (PDT)
Received: from localhost.localdomain (host210-95-dynamic.0-87-r.retail.telecomitalia.it. [87.0.95.210])
        by mx.google.com with ESMTPS id p57sm60152731eei.8.2012.03.26.09.42.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 09:42:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <cover.1331333479.git.stefano.lattarini@gmail.com>
In-Reply-To: <cover.1332779754.git.stefano.lattarini@gmail.com>
References: <cover.1332779754.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193927>

This change is just cosmetic, and should cause no semantic change, nor
any change in the generated configure script.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 configure.ac |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0743a70..e888601 100644
--- a/configure.ac
+++ b/configure.ac
@@ -27,10 +27,11 @@ AC_DEFUN([GIT_ARG_SET_PATH],
 # Optional second argument allows setting NO_PROGRAM=YesPlease if
 # --without-PROGRAM is used.
 AC_DEFUN([GIT_CONF_APPEND_PATH],
-[PROGRAM=m4_toupper($1); \
+[m4_pushdef([GIT_UC_PROGRAM], m4_toupper([$1]))dnl
+PROGRAM=GIT_UC_PROGRAM; \
 if test "$withval" = "no"; then \
 	if test -n "$2"; then \
-		m4_toupper($1)_PATH=$withval; \
+		GIT_UC_PROGRAM[]_PATH=$withval; \
 		AC_MSG_NOTICE([Disabling use of ${PROGRAM}]); \
 		GIT_CONF_APPEND_LINE(NO_${PROGRAM}=YesPlease); \
 		GIT_CONF_APPEND_LINE(${PROGRAM}_PATH=); \
@@ -41,12 +42,12 @@ else \
 	if test "$withval" = "yes"; then \
 		AC_MSG_WARN([You should provide path for --with-$1=PATH]); \
 	else \
-		m4_toupper($1)_PATH=$withval; \
-		AC_MSG_NOTICE([Setting m4_toupper($1)_PATH to $withval]); \
+		GIT_UC_PROGRAM[]_PATH=$withval; \
+		AC_MSG_NOTICE([Setting GIT_UC_PROGRAM[]_PATH to $withval]); \
 		GIT_CONF_APPEND_LINE(${PROGRAM}_PATH=$withval); \
 	fi; \
 fi; \
-]) # GIT_CONF_APPEND_PATH
+m4_popdef([GIT_UC_PROGRAM])]) # GIT_CONF_APPEND_PATH
 #
 # GIT_PARSE_WITH(PACKAGE)
 # -----------------------
@@ -55,18 +56,19 @@ fi; \
 # * Set PACKAGEDIR=PATH for --with-PACKAGE=PATH
 # * Unset NO_PACKAGE for --with-PACKAGE without ARG
 AC_DEFUN([GIT_PARSE_WITH],
-[PACKAGE=m4_toupper($1); \
+[m4_pushdef([GIT_UC_PACKAGE], m4_toupper([$1]))dnl
+PACKAGE=GIT_UC_PACKAGE; \
 if test "$withval" = "no"; then \
-	m4_toupper(NO_$1)=YesPlease; \
+	NO_[]GIT_UC_PACKAGE=YesPlease; \
 elif test "$withval" = "yes"; then \
-	m4_toupper(NO_$1)=; \
+	NO_[]GIT_UC_PACKAGE=; \
 else \
-	m4_toupper(NO_$1)=; \
-	m4_toupper($1)DIR=$withval; \
-	AC_MSG_NOTICE([Setting m4_toupper($1)DIR to $withval]); \
+	NO_[]GIT_UC_PACKAGE=; \
+	GIT_UC_PACKAGE[]DIR=$withval; \
+	AC_MSG_NOTICE([Setting GIT_UC_PACKAGE[]DIR to $withval]); \
 	GIT_CONF_APPEND_LINE(${PACKAGE}DIR=$withval); \
 fi \
-])# GIT_PARSE_WITH
+m4_popdef([GIT_UC_PACKAGE])]) # GIT_PARSE_WITH
 #
 # GIT_PARSE_WITH_SET_MAKE_VAR(WITHNAME, VAR, HELP_TEXT)
 # ---------------------
-- 
1.7.9
