From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Add a simple getpass() for MinGW
Date: Wed, 8 Apr 2009 03:30:22 +0200 (CEST)
Message-ID: <7ba615a300fe2742e8d32f0313c6ee9a1a1aaed3.1239154140u.git.johannes.schindelin@gmx.de>
References: <cover.1239154140u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 03:29:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrMbU-0004r6-PX
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 03:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757669AbZDHB1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 21:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754915AbZDHB1v
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 21:27:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:56863 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753223AbZDHB1v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 21:27:51 -0400
Received: (qmail invoked by alias); 08 Apr 2009 01:27:48 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 08 Apr 2009 03:27:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18LK2VmgyELP57FrCn6+UBkfD3HClq6KGvy0I0yZE
	AxAnZ/7JaTzA7g
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1239154140u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116015>

This should be replaced with a graphical getpass() at some stage.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I saw it coming that I had to do this.

 compat/mingw.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index d50186e..2ab5bbe 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1157,3 +1157,18 @@ int link(const char *oldpath, const char *newpath)
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
-- 
1.6.2.1.613.g25746
