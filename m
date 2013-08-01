From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: [PATCH] Scroll diff with arrow keys in log view
Date: Wed, 31 Jul 2013 23:11:50 -0400
Message-ID: <1375326710-2856-1-git-send-email-a.kumar@alumni.iitm.ac.in>
Content-Transfer-Encoding: 7BIT
Cc: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
To: git@vger.kernel.org, fonseca@diku.dk
X-From: git-owner@vger.kernel.org Thu Aug 01 05:42:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4jmN-00072C-8I
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 05:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364Ab3HADmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 23:42:15 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.4.197]:46641 "EHLO
	mta2.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab3HADmO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 23:42:14 -0400
X-Greylist: delayed 1805 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Jul 2013 23:42:14 EDT
Received: from odessa (ool-18bb429a.dyn.optonline.net [24.187.66.154])
 by mta2.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPA id <0MQU00A7M0W7CJ50@mta2.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Wed, 31 Jul 2013 23:12:08 -0400 (EDT)
Received: from kumar by odessa with local (Exim 4.80)
	(envelope-from <a.kumar@alumni.iitm.ac.in>)	id 1V4jJ8-0000ll-S8; Wed,
 31 Jul 2013 23:12:06 -0400
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231483>

This commit introduces the VIEW_NO_PARENT_NAV flag and adds it to the
log view. This allows the scrolling commands to fall through from the
pager to the diff when the diff is viewed in the log mode.

Signed-Off-By: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
---
 tig.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tig.c b/tig.c
index 8301295..52831fd 100644
--- a/tig.c
+++ b/tig.c
@@ -1895,6 +1895,7 @@ enum view_flag {
 	VIEW_STDIN		= 1 << 8,
 	VIEW_SEND_CHILD_ENTER	= 1 << 9,
 	VIEW_FILE_FILTER	= 1 << 10,
+	VIEW_NO_PARENT_NAV      = 1 << 11,
 };
 
 #define view_has_flags(view, flag)	((view)->ops->flags & (flag))
@@ -3765,7 +3766,7 @@ view_driver(struct view *view, enum request request)
 
 	case REQ_NEXT:
 	case REQ_PREVIOUS:
-		if (view->parent) {
+		if (view->parent && !view_has_flags(view->parent, VIEW_NO_PARENT_NAV)) {
 			int line;
 
 			view = view->parent;
@@ -4431,7 +4432,7 @@ log_request(struct view *view, enum request request, struct line *line)
 static struct view_ops log_ops = {
 	"line",
 	{ "log" },
-	VIEW_ADD_PAGER_REFS | VIEW_OPEN_DIFF | VIEW_SEND_CHILD_ENTER,
+	VIEW_ADD_PAGER_REFS | VIEW_OPEN_DIFF | VIEW_SEND_CHILD_ENTER | VIEW_NO_PARENT_NAV,
 	0,
 	log_open,
 	pager_read,
-- 
1.8.3.2
