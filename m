From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] autoconf: Check autoconf version (ASCIIDOC8)
Date: Sun,  9 Dec 2007 13:57:39 +0100
Message-ID: <1197205059-16742-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 09 13:58:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Ljo-0004K5-D8
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 13:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbXLIM5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 07:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbXLIM5y
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 07:57:54 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:59900 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbXLIM5x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 07:57:53 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1932103mue
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 04:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=5f2hOmM/iFZTFKAhdhE2Dw0MzCA5JKcWsdQ8Pu9ct6M=;
        b=x0bY4eul9/Vap8uRTm499C9xeDdrPPQxip31/KksTNEmgx979ZomaLnnvM8Puh99ZrBjpsyIq8cur3GxyYQagXhYQsdvrr0y/HxeEwLmkg/9SGHbnIJHygRPmtcRnDm8kfQ25xrbmTGj2Ugk6mtkydnWBdzIBzcPTvRo3wM1/u8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=eMBMf5ZcEehGDThMBnmS6fsWDHWA26DyvTm35BpNK5+8Z6PEXHcuDxq1HdKzykZH2u0v26qWQbF94J127b6OKIs7Vrvzkx3Kyqtb1uw25CJs20iZkCuA59hjACuxKinVAy3JqiLEg5Oi63oTGansnnHlnuro4NinWwApRUYD5rc=
Received: by 10.82.146.14 with SMTP id t14mr6463011bud.1197205065448;
        Sun, 09 Dec 2007 04:57:45 -0800 (PST)
Received: from roke.D-201 ( [83.8.230.31])
        by mx.google.com with ESMTPS id w7sm4782449mue.2007.12.09.04.57.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Dec 2007 04:57:44 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB9CveJ9016757;
	Sun, 9 Dec 2007 13:57:40 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB9CvdlF016756;
	Sun, 9 Dec 2007 13:57:39 +0100
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67622>

Check for asciidoc, and if it exists check asciidoc version, setting
ASCIIDOC8 when needed.  Currently it just runs asciidoc in asciidoc7
compatibility mode (see: Documentation/Makefile).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Hmmm... perhaps ASCIIDOC8 should be called ASCIIDOC7COMPATIBILITY?
We should revisit Makefiles and configure.ac when asciidoc 9 gets
released.

This should be "git portability" portable, even if it is not portable
according to "instanely autoconf-like portable" rules  ;-)

 config.mak.in |    2 ++
 configure.ac  |   21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 7d5df9b..759470a 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -7,6 +7,7 @@ AR = @AR@
 TAR = @TAR@
 #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
 TCLTK_PATH = @TCLTK_PATH@
+ASCIIDOC=@ASCIIDOC@
 
 prefix = @prefix@
 exec_prefix = @exec_prefix@
@@ -23,6 +24,7 @@ VPATH = @srcdir@
 export exec_prefix mandir
 export srcdir VPATH
 
+ASCIIDOC8=@ASCIIDOC8@
 NEEDS_SSL_WITH_CRYPTO=@NEEDS_SSL_WITH_CRYPTO@
 NO_OPENSSL=@NO_OPENSSL@
 NO_CURL=@NO_CURL@
diff --git a/configure.ac b/configure.ac
index dd4b4eb..6f641e3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -122,6 +122,27 @@ if test -z "$NO_TCLTK"; then
     AC_SUBST(TCLTK_PATH)
   fi
 fi
+AC_CHECK_PROGS(ASCIIDOC, [asciidoc])
+if test -n "$ASCIIDOC"; then
+	AC_MSG_CHECKING([for asciidoc version])
+	asciidoc_version=`$ASCIIDOC --version 2>&1`
+	case "${asciidoc_version}" in
+	asciidoc' '8*)
+		ASCIIDOC8=YesPlease
+		AC_MSG_RESULT([${asciidoc_version} > 7])
+		;;
+	asciidoc' '7*)
+		ASCIIDOC8=
+		AC_MSG_RESULT([${asciidoc_version}])
+		;;
+	*)
+		ASCIIDOC8=
+		AC_MSG_RESULT([${asciidoc_version} (unknown)])
+		;;
+	esac
+fi
+AC_SUBST(ASCIIDOC8)
+
 
 ## Checks for libraries.
 AC_MSG_NOTICE([CHECKS for libraries])
-- 
1.5.3.7
