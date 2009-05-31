From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 11/11] MinGW: Teach Makefile to detect msysgit and apply specific settings
Date: Sun, 31 May 2009 18:15:25 +0200
Message-ID: <1243786525-4493-12-git-send-email-prohaska@zib.de>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de>
 <1243786525-4493-2-git-send-email-prohaska@zib.de>
 <1243786525-4493-3-git-send-email-prohaska@zib.de>
 <1243786525-4493-4-git-send-email-prohaska@zib.de>
 <1243786525-4493-5-git-send-email-prohaska@zib.de>
 <1243786525-4493-6-git-send-email-prohaska@zib.de>
 <1243786525-4493-7-git-send-email-prohaska@zib.de>
 <1243786525-4493-8-git-send-email-prohaska@zib.de>
 <1243786525-4493-9-git-send-email-prohaska@zib.de>
 <1243786525-4493-10-git-send-email-prohaska@zib.de>
 <1243786525-4493-11-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 18:17:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAniW-0001uB-SP
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 18:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758884AbZEaQQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 12:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758767AbZEaQQu
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 12:16:50 -0400
Received: from mailer.zib.de ([130.73.108.11]:58696 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757399AbZEaQQt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 12:16:49 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n4VGFWnl006804;
	Sun, 31 May 2009 18:15:52 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n4VGFPVI021220;
	Sun, 31 May 2009 18:15:32 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1243786525-4493-11-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120415>

This commit changes handling of the msysgit specific settings, so
that they can be applied to official git.git.  Some msysgit
settings differ from the standard MinGW settings.  We move them
into an ifndef block that is only evaluated if a file
THIS_IS_MSYSGIT is present in the parent directory, which is the
case for an msysgit working environment.  The tag file is unlikely
to be present accidentally.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Makefile |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index f9657ce..7803ae7 100644
--- a/Makefile
+++ b/Makefile
@@ -823,7 +823,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
 	NO_PREAD = YesPlease
 	NO_OPENSSL = YesPlease
-	NO_CURL = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
 	NO_SETENV = YesPlease
@@ -831,7 +830,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_MEMMEM = YesPlease
-	NO_PTHREADS = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	OLD_ICONV = YesPlease
 	NO_C99_FORMAT = YesPlease
@@ -853,6 +851,18 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/regex/regex.o compat/winansi.o
 	EXTLIBS += -lws2_32
 	X = .exe
+ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
+	htmldir=doc/git/html/
+	prefix =
+	INSTALL = /bin/install
+	EXTLIBS += /mingw/lib/libz.a
+	NO_R_TO_GCC_LINKER = YesPlease
+	INTERNAL_QSORT = YesPlease
+	THREADED_DELTA_SEARCH = YesPlease
+else
+	NO_CURL = YesPlease
+	NO_PTHREADS = YesPlease
+endif
 endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
-- 
1.6.3.1.54.g99dd
