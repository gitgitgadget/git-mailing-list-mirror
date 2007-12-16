From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] whitespace: fix off-by-one error in non-space-in-indent checking
Date: Sat, 15 Dec 2007 22:48:34 -0500
Message-ID: <1197776919-16121-2-git-send-email-bfields@citi.umich.edu>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org>
 <1197776919-16121-1-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 04:49:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3kV3-0003Cm-PM
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 04:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758756AbXLPDss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 22:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758682AbXLPDsr
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 22:48:47 -0500
Received: from mail.fieldses.org ([66.93.2.214]:56274 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755738AbXLPDsr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 22:48:47 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J3kUa-0004Ey-22; Sat, 15 Dec 2007 22:48:40 -0500
X-Mailer: git-send-email debian.1.5.3.7.1-dirty
In-Reply-To: <1197776919-16121-1-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68432>

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
