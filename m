From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH v2 2/2] handle empty notes gracefully
Date: Fri,  6 Feb 2009 17:17:55 +0100
Message-ID: <1233937075-31194-3-git-send-email-git@drmicha.warpmail.net>
References: <1233937075-31194-1-git-send-email-git@drmicha.warpmail.net>
 <1233937075-31194-2-git-send-email-git@drmicha.warpmail.net>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 17:19:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVTQm-0000tR-KJ
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 17:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074AbZBFQSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 11:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbZBFQSJ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 11:18:09 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:38090 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752643AbZBFQSG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 11:18:06 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id C36BF28AF8D;
	Fri,  6 Feb 2009 11:18:05 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 06 Feb 2009 11:18:05 -0500
X-Sasl-enc: JFrqzXihOQ9ZUGGNko2QHQlNUDxi/tbUQFSaQpdLax2O 1233937085
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2907E14B14;
	Fri,  6 Feb 2009 11:18:05 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.253.ga34a
In-Reply-To: <1233937075-31194-2-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108756>

Currently, git-notes barks when asked to show an empty (i.e.
non-existing) note. Change this to explicitly say there is none.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 git-notes.sh     |    2 ++
 t/t3301-notes.sh |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-notes.sh b/git-notes.sh
index bfdbaa8..9cbad02 100755
--- a/git-notes.sh
+++ b/git-notes.sh
@@ -58,6 +58,8 @@ edit)
 		"$GIT_NOTES_REF" $NEW_HEAD $CURRENT_HEAD
 ;;
 show)
+	git rev-parse -q --verify "$GIT_NOTES_REF":$COMMIT > /dev/null ||
+		die "No note for commit $COMMIT."
 	git show "$GIT_NOTES_REF":$COMMIT
 ;;
 *)
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 7ef1c29..ff4ea05 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -36,7 +36,7 @@ test_expect_success 'need valid notes ref' '
 '
 
 # 1 indicates caught gracefully by die, 128 means git-show barked
-test_expect_failure 'handle empty notes gracefully' '
+test_expect_success 'handle empty notes gracefully' '
 	git notes show ; test 1 = $?
 '
 
-- 
1.6.1.2.253.ga34a
