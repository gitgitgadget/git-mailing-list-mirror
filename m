From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] t7003-filter-branch: Fix test of a failing --msg-filter.
Date: Tue, 27 Nov 2007 13:10:19 +0100
Message-ID: <1196165419-10201-1-git-send-email-johannes.sixt@telecom.at>
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 13:43:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwzm6-0006RF-Ag
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 13:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602AbXK0Mmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 07:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754544AbXK0Mmc
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 07:42:32 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:50115 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536AbXK0Mmb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 07:42:31 -0500
X-Greylist: delayed 1928 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2007 07:42:31 EST
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1IwzFy-0008Ma-45; Tue, 27 Nov 2007 13:09:38 +0100
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A56396EF; Tue, 27 Nov 2007 13:10:19 +0100 (CET)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 51842FA45; Tue, 27 Nov 2007 13:10:19 +0100 (CET)
X-Mailer: git-send-email 1.5.3.6.967.ga9b45
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66200>

The test passed for the wrong reason: If the script given to --msg-filter
fails, it is expected that git-filter-branch aborts. But the test forgot
to tell the branch name to rewrite, and so git-filter-branch failed due to
incorrect usage.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 t/t7003-filter-branch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 2089351..5f60b22 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -114,7 +114,7 @@ test_expect_success 'use index-filter to move into a subdirectory' '
 
 test_expect_success 'stops when msg filter fails' '
 	old=$(git rev-parse HEAD) &&
-	! git-filter-branch -f --msg-filter false &&
+	! git-filter-branch -f --msg-filter false HEAD &&
 	test $old = $(git rev-parse HEAD) &&
 	rm -rf .git-rewrite
 '
-- 
1.5.3.6.967.ga9b45
