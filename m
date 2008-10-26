From: "David M. Syzdek" <david.syzdek@acsalaska.net>
Subject: [PATCH] autoconf: Add link tests to each AC_CHECK_FUNC() test
Date: Sun, 26 Oct 2008 03:52:19 -0800
Message-ID: <1225021939-11858-1-git-send-email-david.syzdek@acsalaska.net>
Cc: jnareb@gmail.com, "David M. Syzdek" <david.syzdek@acsalaska.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 26 13:08:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ku4QH-0007jp-5U
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 13:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbYJZMH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 08:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbYJZMH2
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 08:07:28 -0400
Received: from iris.acsalaska.net ([209.112.173.229]:18368 "EHLO
	iris.acsalaska.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbYJZMH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 08:07:27 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Oct 2008 08:07:26 EDT
Received: from localhost.localdomain (209-193-51-248.static.acsalaska.net [209.193.51.248])
	by iris.acsalaska.net (8.14.1/8.14.1) with ESMTP id m9QBqKDQ055318;
	Sun, 26 Oct 2008 03:52:20 -0800 (AKDT)
	(envelope-from david.syzdek@acsalaska.net)
X-Mailer: git-send-email 1.6.0.2.GIT
X-ACS-Spam-Status: no
X-ACS-Spam-Score: 1.3 (x)
X-ACS-Spam-Tests: HELO_LH_LD,ACS_BOGUS_LOCALHOST
X-ACS-Scanned-By: MD 2.63; SA 3.2.4; spamdefang 1.122
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99159>

Update configure.ac to test libraries for getaddrinfo, strcasestr, memmem,
strlcpy, strtoumax, setenv, unsetenv, and mkdtemp.  The default compilers
on FreeBSD 4.9-SECURITY and FreeBSD 6.2-RELEASE-p4 do not generate warnings
for missing prototypes unless `-Wall' is used. This behavior renders the
results of AC_CHECK_FUNC() void on these platforms. The test AC_SEARCH_LIBS()
verifies a function is valid by linking to symbol within the system libraries.

Signed-off-by: David M. Syzdek <david.syzdek@acsalaska.net>
---
 configure.ac |   57 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7c2856e..d3b8bc3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -293,9 +293,11 @@ AC_SUBST(NO_SOCKADDR_STORAGE)
 #
 # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
 AC_CHECK_TYPE([struct addrinfo],[
- AC_CHECK_FUNC([getaddrinfo],
-  [NO_IPV6=],
-  [NO_IPV6=YesPlease])
+ AC_CHECK_FUNC([getaddrinfo],[
+  AC_SEARCH_LIBS([getaddrinfo],,
+    [NO_IPV6=],
+    [NO_IPV6=YesPlease])
+ ],[NO_IPV6=YesPlease])
 ],[NO_IPV6=YesPlease],[
 #include <sys/types.h>
 #include <sys/socket.h>
@@ -387,44 +389,65 @@ AC_SUBST(SNPRINTF_RETURNS_BOGUS)
 AC_MSG_NOTICE([CHECKS for library functions])
 #
 # Define NO_STRCASESTR if you don't have strcasestr.
-AC_CHECK_FUNC(strcasestr,
-[NO_STRCASESTR=],
+AC_CHECK_FUNC(strcasestr,[
+ AC_SEARCH_LIBS(strcasestr,,
+ [NO_STRCASESTR=],
+ [NO_STRCASESTR=YesPlease])
+],
 [NO_STRCASESTR=YesPlease])
 AC_SUBST(NO_STRCASESTR)
 #
 # Define NO_MEMMEM if you don't have memmem.
-AC_CHECK_FUNC(memmem,
-[NO_MEMMEM=],
+AC_CHECK_FUNC(memmem,[
+ AC_SEARCH_LIBS(memmem,,
+ [NO_MEMMEM=],
+ [NO_MEMMEM=YesPlease])
+],
 [NO_MEMMEM=YesPlease])
 AC_SUBST(NO_MEMMEM)
 #
 # Define NO_STRLCPY if you don't have strlcpy.
-AC_CHECK_FUNC(strlcpy,
-[NO_STRLCPY=],
+AC_CHECK_FUNC(strlcpy,[
+ AC_SEARCH_LIBS(strlcpy,,
+ [NO_STRLCPY=],
+ [NO_STRLCPY=YesPlease])
+],
 [NO_STRLCPY=YesPlease])
 AC_SUBST(NO_STRLCPY)
 #
 # Define NO_STRTOUMAX if you don't have strtoumax in the C library.
-AC_CHECK_FUNC(strtoumax,
-[NO_STRTOUMAX=],
+AC_CHECK_FUNC(strtoumax,[
+ AC_SEARCH_LIBS(strtoumax,,
+ [NO_STRTOUMAX=],
+ [NO_STRTOUMAX=YesPlease])
+],
 [NO_STRTOUMAX=YesPlease])
 AC_SUBST(NO_STRTOUMAX)
 #
 # Define NO_SETENV if you don't have setenv in the C library.
-AC_CHECK_FUNC(setenv,
-[NO_SETENV=],
+AC_CHECK_FUNC(setenv,[
+ AC_SEARCH_LIBS(setenv,,
+ [NO_SETENV=],
+ [NO_SETENV=YesPlease])
+],
 [NO_SETENV=YesPlease])
 AC_SUBST(NO_SETENV)
 #
 # Define NO_UNSETENV if you don't have unsetenv in the C library.
-AC_CHECK_FUNC(unsetenv,
-[NO_UNSETENV=],
+AC_CHECK_FUNC(unsetenv,[
+ AC_SEARCH_LIBS(unsetenv,,
+ [NO_UNSETENV=],
+ [NO_UNSETENV=YesPlease])
+],
 [NO_UNSETENV=YesPlease])
 AC_SUBST(NO_UNSETENV)
 #
 # Define NO_MKDTEMP if you don't have mkdtemp in the C library.
-AC_CHECK_FUNC(mkdtemp,
-[NO_MKDTEMP=],
+AC_CHECK_FUNC(mkdtemp,[
+ AC_SEARCH_LIBS(mkdtemp,,
+ [NO_MKDTEMP=],
+ [NO_MKDTEMP=YesPlease])
+],
 [NO_MKDTEMP=YesPlease])
 AC_SUBST(NO_MKDTEMP)
 #
-- 
1.6.0.2.GIT
