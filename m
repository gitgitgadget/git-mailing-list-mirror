From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] handle empty notes gracefully
Date: Fri,  6 Feb 2009 16:19:03 +0100
Message-ID: <1233933543-28407-3-git-send-email-git@drmicha.warpmail.net>
References: <1233933543-28407-1-git-send-email-git@drmicha.warpmail.net>
 <1233933543-28407-2-git-send-email-git@drmicha.warpmail.net>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 16:21:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVSWM-0001nD-7t
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbZBFPTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753048AbZBFPTR
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:19:17 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:46155 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756283AbZBFPTN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 10:19:13 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 7935D287979;
	Fri,  6 Feb 2009 10:19:12 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 06 Feb 2009 10:19:12 -0500
X-Sasl-enc: XLYtViYcADP6JHm6YWU5VAvKkb/hA5RJPXaOZo3Kxpkm 1233933552
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F355E29A79;
	Fri,  6 Feb 2009 10:19:11 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.253.ga34a
In-Reply-To: <1233933543-28407-2-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108728>

Currently, git-notes barfs when asked to show an empty (i.e.
non-existing) note. Change this to explicitely say there is none.
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
index 4900dca..81d5028 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -36,7 +36,7 @@ test_expect_success 'need valid notes ref' '
 '
 
 # 1 indicates caught gracefully by die, 128 means git-show barfed
-test_expect_failure 'handle empty notes gracefully' '
+test_expect_success 'handle empty notes gracefully' '
 	git notes show || test 1 = $?
 '
 
-- 
1.6.1.2.253.ga34a
