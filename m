From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 1/2] builtin-apply: minor cleanup of whitespace detection
Date: Sun, 16 Dec 2007 12:58:01 -0500
Message-ID: <1197827882-11710-2-git-send-email-bfields@citi.umich.edu>
References: <1197822702-5262-7-git-send-email-bfields@citi.umich.edu>
 <1197827882-11710-1-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 18:59:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3xlU-0003Q5-0x
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 18:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934490AbXLPR6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 12:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934395AbXLPR6I
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 12:58:08 -0500
Received: from mail.fieldses.org ([66.93.2.214]:39129 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421AbXLPR6F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 12:58:05 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J3xkY-00036y-BA; Sun, 16 Dec 2007 12:58:02 -0500
X-Mailer: git-send-email debian.1.5.3.7.1-dirty
In-Reply-To: <1197827882-11710-1-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68472>

Use 0 instead of -1 for the case where not tabs or spaces are found; it
will make some later math slightly simpler.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 builtin-apply.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 2edd83b..bd94a4b 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1550,8 +1550,8 @@ static int apply_line(char *output, const char *patch, int plen,
 	int i;
 	int add_nl_to_tail = 0;
 	int fixed = 0;
-	int last_tab_in_indent = -1;
-	int last_space_in_indent = -1;
+	int last_tab_in_indent = 0;
+	int last_space_in_indent = 0;
 	int need_fix_leading_space = 0;
 	char *buf;
 
@@ -1582,12 +1582,12 @@ static int apply_line(char *output, const char *patch, int plen,
 		if (ch == '\t') {
 			last_tab_in_indent = i;
 			if ((ws_rule & WS_SPACE_BEFORE_TAB) &&
-			    0 <= last_space_in_indent)
+			    0 < last_space_in_indent)
 			    need_fix_leading_space = 1;
 		} else if (ch == ' ') {
 			last_space_in_indent = i;
 			if ((ws_rule & WS_INDENT_WITH_NON_TAB) &&
-			    last_tab_in_indent < 0 &&
+			    last_tab_in_indent <= 0 &&
 			    8 <= i)
 				need_fix_leading_space = 1;
 		}
-- 
1.5.4.rc0.44.g21147
