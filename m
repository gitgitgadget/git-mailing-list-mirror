From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] Do not build i18n on Windows.
Date: Sat, 14 Aug 2010 00:02:40 +0200
Message-ID: <201008140002.40587.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 00:02:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok2Kt-0005AP-5y
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 00:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202Ab0HMWCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 18:02:42 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:32420 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754132Ab0HMWCm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 18:02:42 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2BD4B2C4004;
	Sat, 14 Aug 2010 00:02:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id DA76119F5AF;
	Sat, 14 Aug 2010 00:02:40 +0200 (CEST)
User-Agent: KMail/1.9.10
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153517>

We do not have the necessary libraries and tools.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 It is necessary to move the first check for NO_GETTEXT after the
 configuration section.

 NEEDS_LIBINTL receives a default setting before the configuration
 section (not visible in the patch text), hence, I have to unset it
 when NO_GETTEXT is set. Perhaps you have a better idea to arrange
 these settings.

 -- Hannes

 Makefile |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index cdb8222..48cf304 100644
--- a/Makefile
+++ b/Makefile
@@ -598,9 +598,6 @@ LIB_OBJS += entry.o
 LIB_OBJS += environment.o
 LIB_OBJS += exec_cmd.o
 LIB_OBJS += fsck.o
-ifndef NO_GETTEXT
-LIB_OBJS += gettext.o
-endif
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
 LIB_OBJS += hash.o
@@ -1100,6 +1097,7 @@ ifeq ($(uname_S),Windows)
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
 	NATIVE_CRLF = YesPlease
+	NO_GETTEXT = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
@@ -1150,6 +1148,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_REGEX = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
+	NO_GETTEXT = YesPlease
 	COMPAT_CFLAGS 
+= -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
@@ -1499,6 +1498,9 @@ endif
 
 ifdef NO_GETTEXT
 	COMPAT_CFLAGS += -DNO_GETTEXT
+	NEEDS_LIBINTL =
+else
+	LIB_OBJS += gettext.o
 endif
 
 ifdef NEEDS_LIBINTL
-- 
1.7.1.402.gf1eeb
