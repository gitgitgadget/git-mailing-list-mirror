From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH 1/2] build: improve GIT_CONF_SUBST signature
Date: Tue, 11 Sep 2012 17:45:29 +0200
Message-ID: <1be62f9a7bbe728e6422e668d982ddf313d016eb.1347378209.git.stefano.lattarini@gmail.com>
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 11 17:45:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBSex-0005HT-18
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 17:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757408Ab2IKPpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 11:45:47 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39468 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756821Ab2IKPpr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 11:45:47 -0400
Received: by eaac11 with SMTP id c11so344653eaa.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=8YwdoVGK9/+HJdsjoEu8EjjDTSpWHVQu2Sbwm26SfX4=;
        b=wieaN7e/LwvrmhZua/E1PMEI+RSNAWvbDENrggorBERPn7brM88tWFKdL3X6E5BC5y
         IAuX/zL6aTL/TYH6/IaE37RPtQREjgHzycJAggLRRodl+k6UXVaCdJH1fS3+j96sRZCm
         oFxoachLWm3rf+hTPHJleFMuHE5P3mNnUIV3X+a++RTkmQFcgAf2F3g8GXeZAFaX7dIY
         Zy2E1yVrhN/4kdUkmPfN9xArylbQjLldORuib9iWtVKL7m/jiQ7mHIs0phhFs5e3bNV2
         Cz2TdMRFsKIQEbMp2PJug5Bx8s8zAbrmN2511h4+UXEzAlQLYdUvTetd9x4f7P/tKid+
         tmtg==
Received: by 10.205.134.133 with SMTP id ic5mr5151370bkc.15.1347378345625;
        Tue, 11 Sep 2012 08:45:45 -0700 (PDT)
Received: from localhost.localdomain (host194-94-dynamic.2-87-r.retail.telecomitalia.it. [87.2.94.194])
        by mx.google.com with ESMTPS id hg13sm10046535bkc.7.2012.09.11.08.45.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Sep 2012 08:45:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.317.g1c54b74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205240>

Now, in configure.ac, a call like:

    GIT_CONF_SUBST([FOO])

will be considered equivalent to:

    GIT_CONF_SUBST([FOO], [$FOO])

This is mostly a preparatory refactoring in view of future changes.
No semantic change to the generated configure or config.mak.auto is
intended.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 configure.ac | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index df7e376..450bbe7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -7,8 +7,9 @@
 # ------------------------
 # Cause the line "VAR=VAL" to be eventually appended to ${config_file}.
 AC_DEFUN([GIT_CONF_SUBST],
-   [AC_REQUIRE([GIT_CONF_SUBST_INIT])
-   config_appended_defs="$config_appended_defs${newline}$1=$2"])
+[AC_REQUIRE([GIT_CONF_SUBST_INIT])
+config_appended_defs="$config_appended_defs${newline}dnl
+$1=m4_if([$#],[1],[${$1}],[$2])"])
 
 # GIT_CONF_SUBST_INIT
 # -------------------
@@ -179,7 +180,7 @@ AC_ARG_WITH([lib],
   else
 	lib=$withval
 	AC_MSG_NOTICE([Setting lib to '$lib'])
-	GIT_CONF_SUBST([lib], [$withval])
+	GIT_CONF_SUBST([lib])
   fi])
 
 if test -z "$lib"; then
@@ -215,7 +216,7 @@ AC_ARG_ENABLE([jsmin],
 [
   JSMIN=$enableval;
   AC_MSG_NOTICE([Setting JSMIN to '$JSMIN' to enable JavaScript minifying])
-  GIT_CONF_SUBST([JSMIN], [$enableval])
+  GIT_CONF_SUBST([JSMIN])
 ])
 
 # Define option to enable CSS minification
@@ -225,7 +226,7 @@ AC_ARG_ENABLE([cssmin],
 [
   CSSMIN=$enableval;
   AC_MSG_NOTICE([Setting CSSMIN to '$CSSMIN' to enable CSS minifying])
-  GIT_CONF_SUBST([CSSMIN], [$enableval])
+  GIT_CONF_SUBST([CSSMIN])
 ])
 
 ## Site configuration (override autodetection)
@@ -265,8 +266,8 @@ AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and hea
     else
 	USE_LIBPCRE=YesPlease
 	LIBPCREDIR=$withval
-	AC_MSG_NOTICE([Setting LIBPCREDIR to $withval])
-	GIT_CONF_SUBST([LIBPCREDIR], [$withval])
+	AC_MSG_NOTICE([Setting LIBPCREDIR to $LIBPCREDIR])
+	GIT_CONF_SUBST([LIBPCREDIR])
     fi)
 #
 # Define NO_CURL if you do not have curl installed.  git-http-pull and
-- 
1.7.12.317.g1c54b74
