From: Johan Herland <johan@herland.net>
Subject: [CGit RFC/PATCH 2/5] ui-log: Move 'Age' column to the right of
 'Author', like in gitk
Date: Tue, 13 Jul 2010 23:40:18 +0200
Message-ID: <1279057221-28036-3-git-send-email-johan@herland.net>
References: <1279056219-27096-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 23:40:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYnDX-0004Or-F8
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 23:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186Ab0GMVki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 17:40:38 -0400
Received: from smtp.getmail.no ([84.208.15.66]:64044 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754970Ab0GMVkh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 17:40:37 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5I00AU8MVMA660@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 13 Jul 2010 23:40:34 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 5DD2D1EA5B58_C3CDD52B	for <git@vger.kernel.org>; Tue,
 13 Jul 2010 21:40:34 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 34CD71EA33DE_C3CDD52F	for <git@vger.kernel.org>; Tue,
 13 Jul 2010 21:40:34 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5I00782MVL0N10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 13 Jul 2010 23:40:34 +0200 (MEST)
X-Mailer: git-send-email 1.7.0.4
In-reply-to: <1279056219-27096-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150924>

This is in preparation for putting the commit graph to the left of the
commit message. IMHO, it looks better when the commit message is right
next to the graph, than if the age is wedged in between.

Signed-off-by: Johan Herland <johan@herland.net>
---
 ui-log.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/ui-log.c b/ui-log.c
index 33ec8a9..390c38b 100644
--- a/ui-log.c
+++ b/ui-log.c
@@ -79,23 +79,22 @@ void print_commit(struct commit *commit)
 {
 	struct commitinfo *info;
 	char *tmp;
-	int cols = 2;
+	int cols = 3;
 
 	info = cgit_parse_commit(commit);
-	htmlf("<tr%s><td>",
-		ctx.qry.showmsg ? " class='logheader'" : "");
-	tmp = fmt("id=%s", sha1_to_hex(commit->object.sha1));
-	tmp = cgit_fileurl(ctx.repo->url, "commit", ctx.qry.vpath, tmp);
-	html_link_open(tmp, NULL, NULL);
-	cgit_print_age(commit->date, TM_WEEK * 2, FMT_SHORTDATE);
-	html_link_close();
-	htmlf("</td><td%s>",
-		ctx.qry.showmsg ? " class='logsubject'" : "");
+	htmlf("<tr%s>", ctx.qry.showmsg ? " class='logheader'" : "");
+	htmlf("<td%s>", ctx.qry.showmsg ? " class='logsubject'" : "");
 	cgit_commit_link(info->subject, NULL, NULL, ctx.qry.head,
 			 sha1_to_hex(commit->object.sha1), ctx.qry.vpath, 0);
 	show_commit_decorations(commit);
 	html("</td><td>");
 	html_txt(info->author);
+	html("</td><td>");
+	tmp = fmt("id=%s", sha1_to_hex(commit->object.sha1));
+	tmp = cgit_fileurl(ctx.repo->url, "commit", ctx.qry.vpath, tmp);
+	html_link_open(tmp, NULL, NULL);
+	cgit_print_age(commit->date, TM_WEEK * 2, FMT_SHORTDATE);
+	html_link_close();
 	if (ctx.repo->enable_log_filecount) {
 		files = 0;
 		add_lines = 0;
@@ -115,7 +114,7 @@ void print_commit(struct commit *commit)
 			if (ctx.repo->enable_log_linecount)
 				cols++;
 		}
-		htmlf("<tr class='nohover'><td/><td colspan='%d' class='logmsg'>",
+		htmlf("<tr class='nohover'><td colspan='%d' class='logmsg'>",
 			cols);
 		html_txt(info->msg);
 		html("</td></tr>\n");
@@ -176,8 +175,7 @@ void cgit_print_log(const char *tip, int ofs, int cnt, char *grep, char *pattern
 	if (pager)
 		html("<table class='list nowrap'>");
 
-	html("<tr class='nohover'><th class='left'>Age</th>"
-	      "<th class='left'>Commit message");
+	html("<tr class='nohover'><th class='left'>Commit message");
 	if (pager) {
 		html(" (");
 		cgit_log_link(ctx.qry.showmsg ? "Collapse" : "Expand", NULL,
@@ -186,7 +184,7 @@ void cgit_print_log(const char *tip, int ofs, int cnt, char *grep, char *pattern
 			      ctx.qry.search, ctx.qry.showmsg ? 0 : 1);
 		html(")");
 	}
-	html("</th><th class='left'>Author</th>");
+	html("</th><th class='left'>Author</th><th class='left'>Age</th>");
 	if (ctx.repo->enable_log_filecount) {
 		html("<th class='left'>Files</th>");
 		columns++;
-- 
1.7.0.4
