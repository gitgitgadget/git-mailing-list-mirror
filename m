From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 8] autoconf: Checks for some programs
Date: Sat,  8 Jul 2006 23:07:13 +0200
Message-ID: <11523928372070-git-send-email-jnareb@gmail.com>
References: <200607030156.50455.jnareb@gmail.com> <1152392835436-git-send-email-jnareb@gmail.com> <11523928361444-git-send-email-jnareb@gmail.com> <1152392836910-git-send-email-jnareb@gmail.com> <1152392837823-git-send-email-jnareb@gmail.com> <11523928373026-git-send-email-jnareb@gmail.com> <11523928373299-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 08 23:07:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzK1h-0003ja-Df
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 23:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWGHVHe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 17:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWGHVHe
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 17:07:34 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:62913 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1030390AbWGHVHa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 17:07:30 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k68L6oBP021764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Jul 2006 23:06:53 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k68L7I8e015603;
	Sat, 8 Jul 2006 23:07:18 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k68L7HIe015602;
	Sat, 8 Jul 2006 23:07:17 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11523928373299-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23508>

./configure script checks now for the following programs:
 * CC  - using AC_PROG_CC
 * AR  - using AC_CHECK_TOOL among ar
 * TAR - among gtar, tar

Checks not implemented:
 * INSTALL  - needs install-sh or install.sh in sources
 * RPMBUILD - not known alternatives for rpmbuild
 * PYTHON   - no PYTHON variable in Makefile,
              has to set NO_PYTHON if not present

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
If I remember correctly there was patch adding some very minimal
install script for building git on some architecture.  If it were
added, the lines with INSTALL in configure.ac and config.mak.in
should be uncommented in.

Currently it is commented out to ./configure not fail.

 config.mak.in |    5 +++++
 configure.ac  |    7 +++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 82c9781..89520eb 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -1,6 +1,11 @@
 # git Makefile configuration, included in main Makefile
 # @configure_input@
 
+CC = @CC@
+AR = @AR@
+TAR = @TAR@
+#INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
+
 prefix = @prefix@
 exec_prefix = @exec_prefix@
 bindir = @bindir@
diff --git a/configure.ac b/configure.ac
index d938546..56e765f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -22,6 +22,13 @@ AC_DEFUN([GIT_CONF_APPEND_LINE],
 
 
 ## Checks for programs.
+AC_MSG_NOTICE([CHECKS for programs])
+
+AC_PROG_CC
+#AC_PROG_INSTALL		# needs install-sh or install.sh in sources
+AC_CHECK_TOOL(AR, ar, :)
+AC_CHECK_PROGS(TAR, [gtar tar])
+
 # Define NO_PYTHON if you want to loose all benefits of the recursive merge.
 
 
-- 
1.4.0
