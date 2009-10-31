From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 1/2] configure: add function to directly set Makefile variables
Date: Sat, 31 Oct 2009 16:41:34 -0400
Message-ID: <1257021695-21260-2-git-send-email-bwalton@artsci.utoronto.ca>
References: <1257021695-21260-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 21:41:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4Kln-00068J-CP
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 21:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933239AbZJaUll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 16:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933236AbZJaUlj
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 16:41:39 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:38881 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933235AbZJaUlh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 16:41:37 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:41961 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1N4KlZ-0003LK-JD; Sat, 31 Oct 2009 16:41:41 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1N4KlZ-0005bQ-Gn; Sat, 31 Oct 2009 16:41:41 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n9VKffiV021536;
	Sat, 31 Oct 2009 16:41:41 -0400
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1257021695-21260-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131854>

Add function GIT_WITH_MAKE_VAR to provide an easy way to allow user
input to directly specify values for variables in the Makefile.

An example use is:
GIT_WITH_MAKE_VAR(gitconfig, ETC_GITCONFIG)

This would allow the user to add --with-gitconfig=/etc/mysiteconf
to their ./configure command line to add
ETC_GITCONFIG=/etc/mysiteconf to the config.mak.autogen file.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 configure.ac |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 84b6cf4..2829dbb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -68,6 +68,20 @@ else \
 	GIT_CONF_APPEND_LINE(${PACKAGE}DIR=$withval); \
 fi \
 ])# GIT_PARSE_WITH
+dnl
+dnl GIT_WITH_MAKE_VAR(withname, VAR)
+dnl ---------------------
+dnl Set VAR to the value specied by --with-$withname if --with-$withname
+dnl is specified.  This is a direct way to allow setting variables in the
+dnl Makefile.
+AC_DEFUN([GIT_WITH_MAKE_VAR],
+[AC_ARG_WITH([$1],
+ [AS_HELP_STRING([--with-$1=VALUE],
+		 [provide value for $2])],
+ if test -n "$withval"; then \
+    AC_MSG_NOTICE([Setting $2 to $withval]); \
+    GIT_CONF_APPEND_LINE($2=$withval); \
+ fi)])# GIT_WITH_MAKE_VAR
 
 dnl
 dnl GIT_CHECK_FUNC(FUNCTION, IFTRUE, IFFALSE)
-- 
1.6.5
