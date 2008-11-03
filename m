From: david.syzdek@acsalaska.net
Subject: [PATCH] Add autoconf tests for pthreads
Date: Mon,  3 Nov 2008 09:14:28 -0900
Message-ID: <1225736068-97988-1-git-send-email-david.syzdek@acsalaska.net>
Cc: jnareb@gmail.com, "David M. Syzdek" <david.syzdek@acsalaska.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 19:15:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx3xr-0000tu-IO
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 19:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbYKCSOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 13:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753560AbYKCSOd
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 13:14:33 -0500
Received: from hermes.acsalaska.net ([209.112.173.230]:41794 "EHLO
	hermes.acsalaska.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbYKCSOc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 13:14:32 -0500
Received: from localhost.localdomain (209-193-51-248.static.acsalaska.net [209.193.51.248])
	by hermes.acsalaska.net (8.14.1/8.14.1) with ESMTP id mA3IEScn079570;
	Mon, 3 Nov 2008 09:14:29 -0900 (AKST)
	(envelope-from david.syzdek@acsalaska.net)
X-Mailer: git-send-email 1.6.0.2.GIT
X-ACS-Spam-Status: no
X-ACS-Spam-Score: 1.3 (x)
X-ACS-Spam-Tests: HELO_LH_LD,ACS_BOGUS_LOCALHOST
X-ACS-Scanned-By: MD 2.63; SA 3.2.3; spamdefang 1.122
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99968>

From: David M. Syzdek <david.syzdek@acsalaska.net>

Sets the value of PTHREAD_LIBS to the correct flags for linking pthreads on
the current environment.  If the correct flags can be determined then
THREADED_DELTA_SEARCH is set.  If the correct flags cannot be determined,
then THREADED_DELTA_SEARCH is unset.

Signed-off-by: David M. Syzdek <david.syzdek@acsalaska.net>
---
 config.mak.in |    2 ++
 configure.ac  |   20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 7170729..3d3fbcd 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -51,3 +51,5 @@ OLD_ICONV=@OLD_ICONV@
 NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
 FREAD_READS_DIRECTORIES=@FREAD_READS_DIRECTORIES@
 SNPRINTF_RETURNS_BOGUS=@SNPRINTF_RETURNS_BOGUS@
+THREADED_DELTA_SEARCH=@THREADED_DELTA_SEARCH@
+PTHREAD_LIBS=@PTHREAD_LIBS@
diff --git a/configure.ac b/configure.ac
index 9dfc0d3..3bf5d15 100644
--- a/configure.ac
+++ b/configure.ac
@@ -489,6 +489,26 @@ AC_SUBST(NO_MKDTEMP)
 #
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
 # Enable it on Windows.  By default, symrefs are still used.
+#
+# Define PTHREAD_LIBS to the linker flag used for Pthread support and define
+# THREADED_DELTA_SEARCH if Pthreads are available.
+AC_LANG_CONFTEST([AC_LANG_PROGRAM(
+  [[#include <pthread.h>]],
+  [[pthread_mutex_t test_mutex;]]
+)])
+${CC} -pthread conftest.c -o conftest.o > /dev/null 2>&1
+if test $? -eq 0;then
+ PTHREAD_LIBS="-pthread"
+ THREADED_DELTA_SEARCH=YesPlease
+else
+ ${CC} -lpthread conftest.c -o conftest.o > /dev/null 2>&1
+ if test $? -eq 0;then
+  PTHREAD_LIBS="-lpthread"
+  THREADED_DELTA_SEARCH=YesPlease
+ fi
+fi
+AC_SUBST(PTHREAD_LIBS)
+AC_SUBST(THREADED_DELTA_SEARCH)
 
 ## Site configuration (override autodetection)
 ## --with-PACKAGE[=ARG] and --without-PACKAGE
-- 
1.6.0.2.GIT
