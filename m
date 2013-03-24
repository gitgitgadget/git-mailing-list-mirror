From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 08/15] t5520: use test_config to set/unset git config variables
Date: Sun, 24 Mar 2013 22:06:07 +0100
Message-ID: <94763817377b46e79e1fabd559133301d638ca70.1364158574.git.ydroneaud@opteya.com>
References: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <cover.1364158574.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:26:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJsRI-0007wZ-IX
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011Ab3CXV0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:26:24 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:42963 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754991Ab3CXV0X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:26:23 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 3C713940201;
	Sun, 24 Mar 2013 22:26:13 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2OL6kVS007295;
	Sun, 24 Mar 2013 22:06:46 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2OL6kM7007294;
	Sun, 24 Mar 2013 22:06:46 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
References: <cover.1364158574.git.ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218996>

Instead of using construct such as:
    test_when_finished "git config --unset <key>"
    git config <key> <value>
uses
    test_config <key> <value>
The latter takes care of removing <key> at the end of the test.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 t/t5520-pull.sh | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 35304b4..cb1a4c5 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -96,8 +96,7 @@ test_expect_success '--rebase' '
 '
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
-	git config --bool pull.rebase true &&
-	test_when_finished "git config --unset pull.rebase" &&
+	test_config pull.rebase true &&
 	git pull . copy &&
 	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
 	test new = $(git show HEAD:file2)
@@ -105,8 +104,7 @@ test_expect_success 'pull.rebase' '
 
 test_expect_success 'branch.to-rebase.rebase' '
 	git reset --hard before-rebase &&
-	git config --bool branch.to-rebase.rebase true &&
-	test_when_finished "git config --unset branch.to-rebase.rebase" &&
+	test_config branch.to-rebase.rebase true &&
 	git pull . copy &&
 	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
 	test new = $(git show HEAD:file2)
@@ -114,10 +112,8 @@ test_expect_success 'branch.to-rebase.rebase' '
 
 test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	git reset --hard before-rebase &&
-	git config --bool pull.rebase true &&
-	test_when_finished "git config --unset pull.rebase" &&
-	git config --bool branch.to-rebase.rebase false &&
-	test_when_finished "git config --unset branch.to-rebase.rebase" &&
+	test_config pull.rebase true &&
+	test_config branch.to-rebase.rebase false &&
 	git pull . copy &&
 	test $(git rev-parse HEAD^) != $(git rev-parse copy) &&
 	test new = $(git show HEAD:file2)
-- 
1.7.11.7
