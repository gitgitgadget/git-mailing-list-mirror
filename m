From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 1/2] configure: add macro to set arbitrary make variables
Date: Wed,  4 Nov 2009 13:05:59 -0500
Message-ID: <1257357960-12763-2-git-send-email-bwalton@artsci.utoronto.ca>
References: <20091103222123.GA17097@progeny.tock>
 <1257357960-12763-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 19:06:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5kFN-0006we-NE
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 19:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbZKDSGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 13:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbZKDSGH
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 13:06:07 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:49373 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbZKDSGE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 13:06:04 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:59407 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1N5kFF-0001Q6-V0; Wed, 04 Nov 2009 13:06:09 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1N5kFF-0003Kc-Rp; Wed, 04 Nov 2009 13:06:09 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id nA4I695g012806;
	Wed, 4 Nov 2009 13:06:09 -0500
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1257357960-12763-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132106>

Add macro GIT_PARSE_WITH_SET_MAKE_VAR to configure.ac to allow --with
style options that set values for variables used during the make
process.

Arguments are the $name part of --with-$name, the name of
the variable to set in the Makefile (config.mak.autogen) and
the help text for the option.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 configure.ac |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 84b6cf4..a305d0b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -68,6 +68,26 @@ else \
 	GIT_CONF_APPEND_LINE(${PACKAGE}DIR=$withval); \
 fi \
 ])# GIT_PARSE_WITH
+#
+# GIT_PARSE_WITH_SET_MAKE_VAR(WITHNAME, VAR, HELP_TEXT)
+# ---------------------
+# Set VAR to the value specied by --with-WITHNAME.
+# No verification of arguments is performed, but warnings are issued
+# if either 'yes' or 'no' is specified.
+# HELP_TEXT is presented when --help is called.
+# This is a direct way to allow setting variables in the Makefile.
+AC_DEFUN([GIT_PARSE_WITH_SET_MAKE_VAR],
+[AC_ARG_WITH([$1],
+ [AS_HELP_STRING([--with-$1=VALUE], $3)],
+ if test -n "$withval"; then \
+  if test "$withval" = "yes" -o "$withval" = "no"; then \
+    AC_MSG_WARN([You likely do not want either 'yes' or 'no' as]
+		     [a value for $1 ($2).  Maybe you do...?]); \
+  fi; \
+  \
+  AC_MSG_NOTICE([Setting $2 to $withval]); \
+  GIT_CONF_APPEND_LINE($2=$withval); \
+ fi)])# GIT_PARSE_WITH_SET_MAKE_VAR
 
 dnl
 dnl GIT_CHECK_FUNC(FUNCTION, IFTRUE, IFFALSE)
-- 
1.6.5.1
