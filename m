From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] help.c: Add support for htmldir relative to git_exec_path()
Date: Sun, 13 Jul 2008 22:31:19 +0200
Message-ID: <1215981083-10815-2-git-send-email-johannes.sixt@telecom.at>
References: <7v1w1yupn4.fsf@gitster.siamese.dyndns.org>
 <1215981083-10815-1-git-send-email-johannes.sixt@telecom.at>
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 22:32:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI8FA-0005Rf-EP
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 22:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353AbYGMUb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 16:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755296AbYGMUb2
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 16:31:28 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:37006 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124AbYGMUb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 16:31:27 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 8FD2B34AAC;
	Sun, 13 Jul 2008 22:31:25 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.300.ga3a9
In-Reply-To: <1215981083-10815-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88329>

From: Steffen Prohaska <prohaska@zib.de>

If htmldir (in the Makefile) is a relative path, this path will now be
interpreted relative to git_exec_path.  This can be used to create an
installation that can be moved to a different directory without
re-compiling.  The Windows installer (msysgit) is an example for such
a setup.

Note that the Makefile maps htmldir to the define GIT_HTML_PATH.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
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
1.5.6.2.300.ga3a9
