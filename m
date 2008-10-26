From: "David M. Syzdek" <david.syzdek@acsalaska.net>
Subject: [PATCH] Add support for uintmax_t type on FreeBSD 4.9
Date: Sun, 26 Oct 2008 03:52:37 -0800
Message-ID: <1225021957-11880-1-git-send-email-david.syzdek@acsalaska.net>
Cc: "David M. Syzdek" <david.syzdek@acsalaska.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 26 13:08:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ku4QI-0007jp-Mj
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 13:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbYJZMHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 08:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbYJZMHb
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 08:07:31 -0400
Received: from iris.acsalaska.net ([209.112.173.229]:23092 "EHLO
	iris.acsalaska.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbYJZMH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 08:07:28 -0400
Received: from localhost.localdomain (209-193-51-248.static.acsalaska.net [209.193.51.248])
	by iris.acsalaska.net (8.14.1/8.14.1) with ESMTP id m9QBqb0f055331;
	Sun, 26 Oct 2008 03:52:37 -0800 (AKDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99158>

This adds NO_UINTMAX_T for ancient systems. If NO_UINTMAX_T is defined, then
uintmax_t is defined as uint32_t. This adds a test to configure.ac for
uintmax_t and adds a check to the Makefile for FreeBSD 4.9-SECURITY.

Signed-off-by: David M. Syzdek <david.syzdek@acsalaska.net>
---
 Makefile      |    3 +++
 config.mak.in |    1 +
 configure.ac  |    8 ++++++++
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 0d40f0e..bf6a6dc 100644
--- a/Makefile
+++ b/Makefile
@@ -931,6 +931,9 @@ endif
 ifdef NO_IPV6
 	BASIC_CFLAGS += -DNO_IPV6
 endif
+ifdef NO_UINTMAX_T
+	BASIC_CFLAGS += -Duintmax_t=uint32_t
+endif
 ifdef NO_SOCKADDR_STORAGE
 ifdef NO_IPV6
 	BASIC_CFLAGS += -Dsockaddr_storage=sockaddr_in
diff --git a/config.mak.in b/config.mak.in
index b776149..c6558eb 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -39,6 +39,7 @@ NO_C99_FORMAT=@NO_C99_FORMAT@
 NO_STRCASESTR=@NO_STRCASESTR@
 NO_MEMMEM=@NO_MEMMEM@
 NO_STRLCPY=@NO_STRLCPY@
+NO_UINTMAX_T=@NO_UINTMAX_T@
 NO_STRTOUMAX=@NO_STRTOUMAX@
 NO_SETENV=@NO_SETENV@
 NO_UNSETENV=@NO_UNSETENV@
diff --git a/configure.ac b/configure.ac
index d3b8bc3..d9de93f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -415,6 +415,14 @@ AC_CHECK_FUNC(strlcpy,[
 [NO_STRLCPY=YesPlease])
 AC_SUBST(NO_STRLCPY)
 #
+# Define NO_UINTMAX_T if your platform does not have uintmax_t
+AC_CHECK_TYPE(uintmax_t,
+[NO_UINTMAX_T=],
+[NO_UINTMAX_T=YesPlease],[
+#include <inttypes.h>
+])
+AC_SUBST(NO_UINTMAX_T)
+#
 # Define NO_STRTOUMAX if you don't have strtoumax in the C library.
 AC_CHECK_FUNC(strtoumax,[
  AC_SEARCH_LIBS(strtoumax,,
-- 
1.6.0.2.GIT
