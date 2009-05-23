From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 4/5] MinGW: Add a simple getpass()
Date: Sat, 23 May 2009 10:04:50 +0200
Message-ID: <1243065891-13270-5-git-send-email-prohaska@zib.de>
References: <1243065891-13270-1-git-send-email-prohaska@zib.de>
 <1243065891-13270-2-git-send-email-prohaska@zib.de>
 <1243065891-13270-3-git-send-email-prohaska@zib.de>
 <1243065891-13270-4-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 10:30:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7mcl-0005CC-Ug
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 10:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbZEWIaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 04:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600AbZEWIaQ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 04:30:16 -0400
Received: from mailer.zib.de ([130.73.108.11]:34254 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752239AbZEWIaN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 04:30:13 -0400
X-Greylist: delayed 1475 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 May 2009 04:29:52 EDT
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n4N84woq001295;
	Sat, 23 May 2009 10:05:03 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n4N84pON028553;
	Sat, 23 May 2009 10:04:57 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1243065891-13270-4-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119765>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We need getpass() to activate curl on MinGW.  Although the default
Makefile currently has 'NO_CURL = YesPlease', msysgit releases do
provide curl support, so getpass() is used.

[spr: - edited commit message.
      - squashed commit that provides getpass() declaration.]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 compat/mingw.c |   15 +++++++++++++++
 compat/mingw.h |    2 ++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index b723c4d..e190fdd 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1156,3 +1156,18 @@ int link(const char *oldpath, const char *newpath)
 	}
 	return 0;
 }
+
+char *getpass(const char *prompt)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	fputs(prompt, stderr);
+	for (;;) {
+		char c = _getch();
+		if (c == '\r' || c == '\n')
+			break;
+		strbuf_addch(&buf, c);
+	}
+	fputs("\n", stderr);
+	return strbuf_detach(&buf, NULL);
+}
diff --git a/compat/mingw.h b/compat/mingw.h
index b1156b8..4c50f5b 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -38,6 +38,8 @@ struct passwd {
 	char *pw_dir;
 };
 
+extern char *getpass(const char *prompt);
+
 struct pollfd {
 	int fd;           /* file descriptor */
 	short events;     /* requested events */
-- 
1.6.3.1.54.g99dd
