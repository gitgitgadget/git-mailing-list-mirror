From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/5] MinGW: Scan for \r in addition to \n when reading shbang lines
Date: Sat, 23 May 2009 10:04:47 +0200
Message-ID: <1243065891-13270-2-git-send-email-prohaska@zib.de>
References: <1243065891-13270-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Peter Harris <git@peter.is-a-geek.org>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 10:30:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7mcJ-000525-ID
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 10:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbZEWIaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 04:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbZEWIaA
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 04:30:00 -0400
Received: from mailer.zib.de ([130.73.108.11]:34254 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbZEWI36 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 04:29:58 -0400
X-Greylist: delayed 1475 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 May 2009 04:29:52 EDT
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n4N84veZ001292;
	Sat, 23 May 2009 10:05:03 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n4N84pOK028553;
	Sat, 23 May 2009 10:04:57 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1243065891-13270-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119762>

From: Peter Harris <git@peter.is-a-geek.org>

\r is common on Windows, so we should handle it gracefully.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 compat/mingw.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index cdeda1d..b723c4d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -525,8 +525,8 @@ static const char *parse_interpreter(const char *cmd)
 	if (buf[0] != '#' || buf[1] != '!')
 		return NULL;
 	buf[n] = '\0';
-	p = strchr(buf, '\n');
-	if (!p)
+	p = buf + strcspn(buf, "\r\n");
+	if (!*p)
 		return NULL;
 
 	*p = '\0';
-- 
1.6.3.1.54.g99dd
