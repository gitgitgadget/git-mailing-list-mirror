From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 2/3] help.c: Add support for htmldir relative to git_exec_path()
Date: Fri, 11 Jul 2008 09:28:05 +0200
Message-ID: <1215761286-2489-2-git-send-email-prohaska@zib.de>
References: <4668B2FF-2B2B-4221-8151-F0AEA681983C@zib.de>
 <1215761286-2489-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Jul 11 09:29:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHD4g-00039X-4c
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 09:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbYGKH2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 03:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753872AbYGKH2w
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 03:28:52 -0400
Received: from mailer.zib.de ([130.73.108.11]:49631 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426AbYGKH2v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 03:28:51 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6B7S7i5014454;
	Fri, 11 Jul 2008 09:28:12 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6B7S6CU029856;
	Fri, 11 Jul 2008 09:28:06 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1215761286-2489-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88091>

If htmldir (in the Makefile) is a relative path, this path will now be
interpreted relative to git_exec_path.  This can be used to create an
installation that can be moved to a different directory without
re-compiling.  The Windows installer (msysgit) is an example for such
a setup.

Note that the Makefile maps htmldir to the define GIT_HTML_PATH.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 help.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/help.c b/help.c
index ca9632b..0f055bf 100644
--- a/help.c
+++ b/help.c
@@ -633,13 +633,15 @@ static void show_info_page(const char *git_cmd)
 static void get_html_page_path(struct strbuf *page_path, const char *page)
 {
 	struct stat st;
+	const char *html_path = system_path(GIT_HTML_PATH);
 
 	/* Check that we have a git documentation directory. */
-	if (stat(GIT_HTML_PATH "/git.html", &st) || !S_ISREG(st.st_mode))
-		die("'%s': not a documentation directory.", GIT_HTML_PATH);
+	if (stat(mkpath("%s/git.html", html_path), &st)
+	    || !S_ISREG(st.st_mode))
+		die("'%s': not a documentation directory.", html_path);
 
 	strbuf_init(page_path, 0);
-	strbuf_addf(page_path, GIT_HTML_PATH "/%s.html", page);
+	strbuf_addf(page_path, "%s/%s.html", html_path, page);
 }
 
 static void show_html_page(const char *git_cmd)
-- 
1.5.6.1.282.gd8a0d
