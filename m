From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 1/6] whitespace: fix off-by-one error in non-space-in-indent checking
Date: Sun, 16 Dec 2007 11:31:37 -0500
Message-ID: <1197822702-5262-2-git-send-email-bfields@citi.umich.edu>
References: <B54C9483-90BE-4B45-A3B7-39FACF0E9F62@wincent.com>
 <1197822702-5262-1-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 17:32:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3wPV-0006dk-AL
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 17:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933035AbXLPQbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 11:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933071AbXLPQbo
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 11:31:44 -0500
Received: from mail.fieldses.org ([66.93.2.214]:60077 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765880AbXLPQbn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 11:31:43 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J3wP0-0001Qh-NJ; Sun, 16 Dec 2007 11:31:42 -0500
X-Mailer: git-send-email debian.1.5.3.7.1-dirty
In-Reply-To: <1197822702-5262-1-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68464>

If there were no tabs, and the last space was at position 7, then
positions 0..7 had spaces, so there were 8 spaces.

Update test to check exactly this case.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 t/t4015-diff-whitespace.sh |    4 ++--
 ws.c                       |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 9bff8f5..0f16bca 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -298,7 +298,7 @@ test_expect_success 'check space before tab in indent (space-before-tab: on)' '
 test_expect_success 'check spaces as indentation (indent-with-non-tab: off)' '
 
 	git config core.whitespace "-indent-with-non-tab"
-	echo "                foo ();" > x &&
+	echo "        foo ();" > x &&
 	git diff --check
 
 '
@@ -306,7 +306,7 @@ test_expect_success 'check spaces as indentation (indent-with-non-tab: off)' '
 test_expect_success 'check spaces as indentation (indent-with-non-tab: on)' '
 
 	git config core.whitespace "indent-with-non-tab" &&
-	echo "                foo ();" > x &&
+	echo "        foo ();" > x &&
 	! git diff --check
 
 '
diff --git a/ws.c b/ws.c
index 46cbdd6..5ebd109 100644
--- a/ws.c
+++ b/ws.c
@@ -159,5 +159,5 @@ unsigned check_and_emit_line(const char *line, int len, unsigned ws_rule,
 	}
 
 	/* Check for indent using non-tab. */
-	if ((ws_rule & WS_INDENT_WITH_NON_TAB) && leading_space >= 8)
+	if ((ws_rule & WS_INDENT_WITH_NON_TAB) && leading_space >= 7)
 		result |= WS_INDENT_WITH_NON_TAB;
\ No newline at end of file
-- 
1.5.4.rc0.41.gf723
