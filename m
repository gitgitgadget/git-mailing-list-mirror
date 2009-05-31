From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 01/11] MinGW: GCC >= 4 does not need SNPRINTF_SIZE_CORR anymore
Date: Sun, 31 May 2009 18:15:15 +0200
Message-ID: <1243786525-4493-2-git-send-email-prohaska@zib.de>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 18:19:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAnky-0002tv-6j
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 18:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759224AbZEaQTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 12:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759162AbZEaQTS
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 12:19:18 -0400
Received: from mailer.zib.de ([130.73.108.11]:58959 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759103AbZEaQTR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 12:19:17 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n4VGFVBX006794;
	Sun, 31 May 2009 18:15:36 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n4VGFPV8021220;
	Sun, 31 May 2009 18:15:31 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1243786525-4493-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120418>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Makefile          |    1 -
 compat/snprintf.c |    4 ++++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index eaae45d..77d8d9c 100644
--- a/Makefile
+++ b/Makefile
@@ -845,7 +845,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/regex -Icompat/fnmatch
-	COMPAT_CFLAGS += -DSNPRINTF_SIZE_CORR=1
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/regex/regex.o compat/winansi.o
 	EXTLIBS += -lws2_32
diff --git a/compat/snprintf.c b/compat/snprintf.c
index 357e733..6c0fb05 100644
--- a/compat/snprintf.c
+++ b/compat/snprintf.c
@@ -6,8 +6,12 @@
  * number of characters to write without the trailing NUL.
  */
 #ifndef SNPRINTF_SIZE_CORR
+#if defined(__MINGW32__) && defined(__GNUC__) && __GNUC__ < 4
+#define SNPRINTF_SIZE_CORR 1
+#else
 #define SNPRINTF_SIZE_CORR 0
 #endif
+#endif
 
 #undef vsnprintf
 int git_vsnprintf(char *str, size_t maxsize, const char *format, va_list ap)
-- 
1.6.3.1.54.g99dd
