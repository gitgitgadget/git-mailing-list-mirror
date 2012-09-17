From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH v7 2/4] fix some win32 specific dependencies in poll.c
Date: Mon, 17 Sep 2012 23:18:27 +0200
Message-ID: <004c01cd9519$fb402b20$f1c08160$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 23:18:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDiiR-0002mU-Dl
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 23:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348Ab2IQVSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 17:18:42 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:63881 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab2IQVSm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 17:18:42 -0400
Received: from DualCore (dsdf-4db53772.pool.mediaWays.net [77.181.55.114])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LnHlS-1TivKY2oSU-00hacF; Mon, 17 Sep 2012 23:18:41 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2VGfomgdM5sjKjQVCuQ7/XfwOPRQ==
Content-Language: de
X-Provags-ID: V02:K0:dLJgRYyxEY7glXUuNQTeSgXZMGcu335386uBowPHhBf
 /D97TMjecsf/URoc3PW64JcsKaELBz0MXMCTIIdAJk5aMM3AFk
 Bq1OwhjNyunVboEdpvstG7zWBGedmupwGXBIG4B4RrRhIAQkKv
 xXk4d5dJl13TVfulkIyobPXcVtPsxgUopKFBTFvM/HmIt5BTfU
 dk2bNmVZgpOt83OPoWnhaxrvc/x6KGWMXIQIf8Q+uxoKoTF3FB
 cowKNd5nr1fiR8rSEEsYUEYi95EmsuS9++//cLdBOkDL5hpDuU
 pATgj5r9k0YX5en5seRZeKq7Hz14MYSruHmA1pGSHl4xTyCPQT
 n+C8lYF2H9r7mdoj+aul6Fw0+hF5UV5P/TEtJML6HuPf4vygDI
 eIBPNMd/53Y+g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205752>

In order for non-win32 platforms to be able to use poll.c, #ifdef the
inclusion of two header files properly

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 compat/poll/poll.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index 9e7a25c..e4b8319 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -24,7 +24,9 @@
 # pragma GCC diagnostic ignored "-Wtype-limits"
 #endif
 
-#include <malloc.h>
+#if defined(WIN32)
+# include <malloc.h>
+#endif
 
 #include <sys/types.h>
 
@@ -48,7 +50,9 @@
 #else
 # include <sys/time.h>
 # include <sys/socket.h>
-# include <sys/select.h>
+# ifndef NO_SYS_SELECT_H
+#  include <sys/select.h>
+# endif
 # include <unistd.h>
 #endif
 
-- 
1.7.12
