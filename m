From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Makefile: remove pointless conditional assignment in SunOS section
Date: Thu, 27 Aug 2009 10:35:46 -0500
Message-ID: <dp9hIoAW5cYWA19k8Uz1mjyaMwG81BRJNhvvYiQVR3eKlOcw9qDI2AVF-YGIRUTxe_5qbaek5Qc@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 27 17:36:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgh1f-0000Mj-IY
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 17:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbZH0Pg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 11:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbZH0Pg0
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 11:36:26 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44802 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbZH0PgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 11:36:25 -0400
Received: by mail.nrlssc.navy.mil id n7RFa0pw003499; Thu, 27 Aug 2009 10:36:02 -0500
X-OriginalArrivalTime: 27 Aug 2009 15:35:59.0854 (UTC) FILETIME=[13D968E0:01CA272C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127164>

From: Brandon Casey <drafnel@gmail.com>

It is true that NEEDS_RESOLV is needed on SunOS if NO_IPV6 is set since
hstrerror() resides in libresolv, but performing this test at its current
location is not very useful.  It will only have any effect if the user
modifies the make variables from the make command line, and will have no
effect if a config.mak file is used.  A better location for this
conditional would have been further down in the Makefile after the
config.mak and config.mak.autogen had been parsed.  Rather than adding
clutter to the Makefile for a conditional that will likely never be
triggered, just remove it, and any user on SunOS that manually sets NO_IPV6
can also set NEEDS_RESOLV.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Makefile |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 66eedef..a9a4d89 100644
--- a/Makefile
+++ b/Makefile
@@ -757,9 +757,6 @@ ifeq ($(uname_S),SunOS)
 		NO_C99_FORMAT = YesPlease
 		NO_STRTOUMAX = YesPlease
 	endif
-	ifdef NO_IPV6
-		NEEDS_RESOLV = YesPlease
-	endif
 	INSTALL = /usr/ucb/install
 	TAR = gtar
 	BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__ -DHAVE_ALLOCA_H
-- 
1.6.4
