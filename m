From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/3] t6024-recursive-merge: quiet down this test
Date: Thu, 28 Dec 2006 01:10:50 -0800
Message-ID: <11672970542015-git-send-email-normalperson@yhbt.net>
References: <11672970521665-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Dec 28 10:11:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzrHw-0002Eq-JE
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 10:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWL1JK6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 04:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWL1JK6
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 04:10:58 -0500
Received: from hand.yhbt.net ([66.150.188.102]:43001 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964953AbWL1JK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 04:10:57 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 0F2C27DC093;
	Thu, 28 Dec 2006 01:10:55 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 28 Dec 2006 01:10:54 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.4.3.gd4ada
In-Reply-To: <11672970521665-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35542>

We get an extra measure of error checking here as well.
While we're at it, also removed a less portable use of export.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t6024-recursive-merge.sh |   90 +++++++++++++++++++++++---------------------
 1 files changed, 47 insertions(+), 43 deletions(-)

diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 69b18f7..31b9625 100644
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -11,50 +11,54 @@ test_description='Test merge without common ancestors'
 #       X   \
 # 2 - C - E - G
 
-export GIT_COMMITTER_DATE="2006-12-12 23:28:00 +0100"
-echo 1 > a1
-git add a1
-GIT_AUTHOR_DATE="2006-12-12 23:00:00" git commit -m 1 a1
-
-git checkout -b A master
-echo A > a1
-GIT_AUTHOR_DATE="2006-12-12 23:00:01" git commit -m A a1
-
-git checkout -b B master
-echo B > a1
-GIT_AUTHOR_DATE="2006-12-12 23:00:02" git commit -m B a1
-
-git checkout -b D A
-git-rev-parse B > .git/MERGE_HEAD
-echo D > a1
-git update-index a1
-GIT_AUTHOR_DATE="2006-12-12 23:00:03" git commit -m D
-
-git symbolic-ref HEAD refs/heads/other
-echo 2 > a1
-GIT_AUTHOR_DATE="2006-12-12 23:00:04" git commit -m 2 a1
-
-git checkout -b C
-echo C > a1
-GIT_AUTHOR_DATE="2006-12-12 23:00:05" git commit -m C a1
-
-git checkout -b E C
-git-rev-parse B > .git/MERGE_HEAD
-echo E > a1
-git update-index a1
-GIT_AUTHOR_DATE="2006-12-12 23:00:06" git commit -m E
-
-git checkout -b G E
-git-rev-parse A > .git/MERGE_HEAD
-echo G > a1
-git update-index a1
-GIT_AUTHOR_DATE="2006-12-12 23:00:07" git commit -m G
-
-git checkout -b F D
-git-rev-parse C > .git/MERGE_HEAD
-echo F > a1
-git update-index a1
+GIT_COMMITTER_DATE="2006-12-12 23:28:00 +0100"
+export GIT_COMMITTER_DATE
+
+test_expect_success "setup tests" '
+echo 1 > a1 &&
+git add a1 &&
+GIT_AUTHOR_DATE="2006-12-12 23:00:00" git commit -m 1 a1 &&
+
+git checkout -b A master &&
+echo A > a1 &&
+GIT_AUTHOR_DATE="2006-12-12 23:00:01" git commit -m A a1 &&
+
+git checkout -b B master &&
+echo B > a1 &&
+GIT_AUTHOR_DATE="2006-12-12 23:00:02" git commit -m B a1 &&
+
+git checkout -b D A &&
+git-rev-parse B > .git/MERGE_HEAD &&
+echo D > a1 &&
+git update-index a1 &&
+GIT_AUTHOR_DATE="2006-12-12 23:00:03" git commit -m D &&
+
+git symbolic-ref HEAD refs/heads/other &&
+echo 2 > a1 &&
+GIT_AUTHOR_DATE="2006-12-12 23:00:04" git commit -m 2 a1 &&
+
+git checkout -b C &&
+echo C > a1 &&
+GIT_AUTHOR_DATE="2006-12-12 23:00:05" git commit -m C a1 &&
+
+git checkout -b E C &&
+git-rev-parse B > .git/MERGE_HEAD &&
+echo E > a1 &&
+git update-index a1 &&
+GIT_AUTHOR_DATE="2006-12-12 23:00:06" git commit -m E &&
+
+git checkout -b G E &&
+git-rev-parse A > .git/MERGE_HEAD &&
+echo G > a1 &&
+git update-index a1 &&
+GIT_AUTHOR_DATE="2006-12-12 23:00:07" git commit -m G &&
+
+git checkout -b F D &&
+git-rev-parse C > .git/MERGE_HEAD &&
+echo F > a1 &&
+git update-index a1 &&
 GIT_AUTHOR_DATE="2006-12-12 23:00:08" git commit -m F
+'
 
 test_expect_failure "combined merge conflicts" "git merge -m final G"
 
-- 
1.4.4.3.gd4ada
