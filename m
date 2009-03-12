From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] configure: add macros to stash FLAG variables
Date: Thu, 12 Mar 2009 15:20:08 -0400
Message-ID: <1236885612-22575-4-git-send-email-bwalton@artsci.utoronto.ca>
References: <1236885612-22575-1-git-send-email-bwalton@artsci.utoronto.ca>
 <1236885612-22575-2-git-send-email-bwalton@artsci.utoronto.ca>
 <1236885612-22575-3-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 20:23:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhqTf-0007sz-Gv
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 20:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756801AbZCLTUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 15:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756361AbZCLTUS
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 15:20:18 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:36885 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756438AbZCLTUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 15:20:16 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253] ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1LhqRx-0004Sh-Qo; Thu, 12 Mar 2009 15:20:13 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1LhqRx-0005ty-O5; Thu, 12 Mar 2009 15:20:13 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n2CJKDUd022685;
	Thu, 12 Mar 2009 15:20:13 -0400
X-Mailer: git-send-email 1.5.5.6
In-Reply-To: <1236885612-22575-3-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113112>

Allow for quick stash/unstash of CPPFLAGS and LDFLAGS.  Library tests
can now be easily bracketted with these macros to allow for values
set in user/site arguments.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 configure.ac |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0bff480..469c9a9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -80,6 +80,32 @@ AC_DEFUN([GIT_CHECK_FUNC],[AC_CHECK_FUNC([$1],[
   AC_SEARCH_LIBS([$1],,
   [$2],[$3])
 ],[$3])])
+
+dnl
+dnl GIT_STASH_FLAGS(BASEPATH_VAR)
+dnl -----------------------------
+dnl Allow for easy stashing of LDFLAGS and CPPFLAGS before running
+dnl tests that may want to take user settings into account.
+AC_DEFUN([GIT_STASH_FLAGS],[
+if test -n "$1"; then
+   old_CPPFLAGS="$CPPFLAGS"
+   old_LDFLAGS="$LDFLAGS"
+   CPPFLAGS="-I$1/include $CPPFLAGS"
+   LDFLAGS="-L$1/$lib $LDFLAGS"
+fi
+])
+
+dnl
+dnl GIT_UNSTASH_FLAGS(BASEPATH_VAR)
+dnl -----------------------------
+dnl Restore the stashed *FLAGS values.
+AC_DEFUN([GIT_UNSTASH_FLAGS],[
+if test -n "$1"; then
+   CPPFLAGS="$old_CPPFLAGS"
+   LDFLAGS="$old_LDFLAGS"
+fi
+])
+
 ## Site configuration related to programs (before tests)
 ## --with-PACKAGE[=ARG] and --without-PACKAGE
 #
-- 
1.6.0.5
