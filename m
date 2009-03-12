From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] configure: ensure settings from user are also usable in the script
Date: Thu, 12 Mar 2009 15:20:06 -0400
Message-ID: <1236885612-22575-2-git-send-email-bwalton@artsci.utoronto.ca>
References: <1236885612-22575-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 20:24:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhqVD-0000Gf-1B
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 20:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbZCLTUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 15:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756783AbZCLTUk
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 15:20:40 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:36883 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756469AbZCLTUR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 15:20:17 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253] ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1LhqRx-0004Sd-J1; Thu, 12 Mar 2009 15:20:13 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1LhqRx-0005tg-G7; Thu, 12 Mar 2009 15:20:13 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n2CJKDN9022666;
	Thu, 12 Mar 2009 15:20:13 -0400
X-Mailer: git-send-email 1.5.5.6
In-Reply-To: <1236885612-22575-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113114>

Allow things set by the user (--with-lib, --with-iconv, etc) to set
variables for use by other parts of the script.  Display values as
they're set.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 configure.ac |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 082a03d..0b314d7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -42,6 +42,8 @@ else \
 	if test "$withval" = "yes"; then \
 		AC_MSG_WARN([You should provide path for --with-$1=PATH]); \
 	else \
+		m4_toupper($1)_PATH=$withval; \
+		AC_MSG_NOTICE([Setting m4_toupper($1)_PATH to $withval]); \
 		GIT_CONF_APPEND_LINE(${PROGRAM}_PATH=$withval); \
 	fi; \
 fi; \
@@ -61,6 +63,8 @@ elif test "$withval" = "yes"; then \
 	m4_toupper(NO_$1)=; \
 else \
 	m4_toupper(NO_$1)=; \
+	m4_toupper($1)DIR=$withval; \
+	AC_MSG_NOTICE([Setting m4_toupper($1)DIR to $withval]); \
 	GIT_CONF_APPEND_LINE(${PACKAGE}DIR=$withval); \
 fi \
 ])# GIT_PARSE_WITH
@@ -86,9 +90,16 @@ AC_ARG_WITH([lib],
  [if test "$withval" = "no" || test "$withval" = "yes"; then \
 	AC_MSG_WARN([You should provide name for --with-lib=ARG]); \
 else \
+	lib=$withval; \
+	AC_MSG_NOTICE([Setting lib to '$lib']); \
 	GIT_CONF_APPEND_LINE(lib=$withval); \
 fi; \
 ],[])
+
+if test -z "$lib"; then
+   AC_MSG_NOTICE([Setting lib to 'lib' (the default)])
+   lib=lib
+fi
 #
 # Define SHELL_PATH to provide path to shell.
 GIT_ARG_SET_PATH(shell)
-- 
1.6.0.5
