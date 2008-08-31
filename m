From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] t6013: Avoid using tac
Date: Sun, 31 Aug 2008 16:03:18 -0400
Message-ID: <1220212998-90810-1-git-send-email-benji@silverinsanity.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 31 22:04:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZt9v-0002hH-72
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 22:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346AbYHaUDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 16:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756620AbYHaUDW
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 16:03:22 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:35509 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756270AbYHaUDV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 16:03:21 -0400
Received: from localhost.localdomain (cpe-69-205-127-75.rochester.res.rr.com [69.205.127.75])
	by silverinsanity.com (Postfix) with ESMTP id 70E831FFC13C;
	Sun, 31 Aug 2008 20:03:14 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.1.207.g020e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94505>

Although tac is useful for testing for reversed output, it is not
available everywhere.  Replace uses of tac with hand-rolled expected
files.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 t/t6013-rev-list-reverse-parents.sh |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/t/t6013-rev-list-reverse-parents.sh b/t/t6013-rev-list-reverse-parents.sh
index d294466..f023fae 100755
--- a/t/t6013-rev-list-reverse-parents.sh
+++ b/t/t6013-rev-list-reverse-parents.sh
@@ -23,17 +23,29 @@ test_expect_success 'set up --reverse example' '
 	commit five
 	'
 
+cat >expected <<\EOF
+86412ffbe95da677fa145e05bcedc75d0d4e49f7
+4931c530d1fde996a29be48a97a056f13ab5e9ce 86412ffbe95da677fa145e05bcedc75d0d4e49f7
+0fcb03eaefb4569dea16195a244d95523cff4934 86412ffbe95da677fa145e05bcedc75d0d4e49f7
+524efe5b12a180964d586b6c47314ea015a98614 4931c530d1fde996a29be48a97a056f13ab5e9ce 0fcb03eaefb4569dea16195a244d95523cff4934
+2ed4a763ad375916b4f0fc34ed08f5843299ded6 524efe5b12a180964d586b6c47314ea015a98614
+EOF
+
 test_expect_success '--reverse --parents --full-history combines correctly' '
-	git rev-list --parents --full-history master -- foo |
-		tac > expected &&
 	git rev-list --reverse --parents --full-history master -- foo \
 		> actual &&
 	test_cmp actual expected
 	'
 
+cat >expected <<\EOF
+-86412ffbe95da677fa145e05bcedc75d0d4e49f7
+4931c530d1fde996a29be48a97a056f13ab5e9ce 86412ffbe95da677fa145e05bcedc75d0d4e49f7
+0fcb03eaefb4569dea16195a244d95523cff4934 86412ffbe95da677fa145e05bcedc75d0d4e49f7
+524efe5b12a180964d586b6c47314ea015a98614 4931c530d1fde996a29be48a97a056f13ab5e9ce 0fcb03eaefb4569dea16195a244d95523cff4934
+2ed4a763ad375916b4f0fc34ed08f5843299ded6 524efe5b12a180964d586b6c47314ea015a98614
+EOF
+
 test_expect_success '--boundary does too' '
-	git rev-list --boundary --parents --full-history master ^root -- foo |
-		tac > expected &&
 	git rev-list --boundary --reverse --parents --full-history \
 		master ^root -- foo > actual &&
 	test_cmp actual expected
-- 
1.6.0.1.207.g020e5
