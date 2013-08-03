From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: [[TIG][PATCH] 3/3] Revert "Scroll diff with arrow keys in log view"
Date: Fri, 02 Aug 2013 20:23:19 -0400
Message-ID: <1375489399-11618-4-git-send-email-a.kumar@alumni.iitm.ac.in>
References: <1375489399-11618-1-git-send-email-a.kumar@alumni.iitm.ac.in>
Content-Transfer-Encoding: 7BIT
Cc: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
To: git@vger.kernel.org, fonseca@diku.dk
X-From: git-owner@vger.kernel.org Sat Aug 03 02:23:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5PdC-0001Ci-A6
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 02:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199Ab3HCAXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 20:23:25 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.4.197]:56555 "EHLO
	mta2.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118Ab3HCAXX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 20:23:23 -0400
Received: from odessa (ool-18bb429a.dyn.optonline.net [24.187.66.154])
 by mta2.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPA id <0MQX00I0YIEXPCD0@mta2.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Fri, 02 Aug 2013 20:23:22 -0400 (EDT)
Received: from kumar by odessa with local (Exim 4.80)
	(envelope-from <a.kumar@alumni.iitm.ac.in>)	id 1V5Pcv-000364-9K; Fri,
 02 Aug 2013 20:23:21 -0400
In-reply-to: <1375489399-11618-1-git-send-email-a.kumar@alumni.iitm.ac.in>
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231551>

This reverts commit 888611dd5d407775245d574a3dc5c01b5963a5ba. This is
because, in the re-engineered log view, scrolling the log with the
arrows now updates the diff in the diff view when the screen is
split. This resembles the earlier behaviour, and is also what users of
software like Mutt (which uses the pager view concept) would expect.

Signed-Off-By: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>

Conflicts:
	tig.c
---
 tig.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tig.c b/tig.c
index 53947b7..65c91a0 100644
--- a/tig.c
+++ b/tig.c
@@ -1901,7 +1901,6 @@ enum view_flag {
 	VIEW_STDIN		= 1 << 8,
 	VIEW_SEND_CHILD_ENTER	= 1 << 9,
 	VIEW_FILE_FILTER	= 1 << 10,
-	VIEW_NO_PARENT_NAV	= 1 << 11,
 };
 
 #define view_has_flags(view, flag)	((view)->ops->flags & (flag))
@@ -3774,7 +3773,7 @@ view_driver(struct view *view, enum request request)
 
 	case REQ_NEXT:
 	case REQ_PREVIOUS:
-		if (view->parent && !view_has_flags(view->parent, VIEW_NO_PARENT_NAV)) {
+		if (view->parent) {
 			int line;
 
 			view = view->parent;
@@ -4498,7 +4497,7 @@ log_request(struct view *view, enum request request, struct line *line)
 static struct view_ops log_ops = {
 	"line",
 	{ "log" },
-	VIEW_ADD_PAGER_REFS | VIEW_OPEN_DIFF | VIEW_SEND_CHILD_ENTER | VIEW_NO_PARENT_NAV,
+	VIEW_ADD_PAGER_REFS | VIEW_OPEN_DIFF | VIEW_SEND_CHILD_ENTER,
 	sizeof(struct log_state),
 	log_open,
 	pager_read,
-- 
1.8.3.2
