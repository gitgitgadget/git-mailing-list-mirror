From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH 1/3] Make test "using invalid commit with -C" more strict
Date: Sat, 24 Aug 2013 05:30:30 +0200
Message-ID: <1377315030-22668-2-git-send-email-draenog@pld-linux.org>
References: <1377315030-22668-1-git-send-email-draenog@pld-linux.org>
Cc: Kacper Kornet <draenog@pld-linux.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 05:53:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD4ut-0004XY-SR
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 05:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346Ab3HXDx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 23:53:29 -0400
Received: from carme.pld-linux.org ([193.239.45.140]:58666 "EHLO
	carme.pld-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107Ab3HXDx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 23:53:28 -0400
X-Greylist: delayed 1359 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Aug 2013 23:53:28 EDT
Received: from draenog by carme.pld-linux.org with local (Exim 4.80.1)
	(envelope-from <draenog@carme.pld-linux.org>)
	id 1VD4ZX-0008TG-7p; Sat, 24 Aug 2013 05:31:31 +0200
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1377315030-22668-1-git-send-email-draenog@pld-linux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232857>

In the test 'using invalid commit with -C' git-commit would have failed
even if the -C option  had been given the correct commit, as there was
nothing to commit. Fix it by making sure there is always something to
commit and git-commit fails because of the invalid commit provided to
it.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 t/t7501-commit.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 99ce36f..699a603 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -53,7 +53,10 @@ test_expect_success PERL 'can use paths with --interactive' '
 '
 
 test_expect_success 'using invalid commit with -C' '
-	test_must_fail git commit -C bogus
+	echo bong >file &&
+	git add file &&
+	test_must_fail git commit -C bogus &&
+	git reset
 '
 
 test_expect_success 'nothing to commit' '
-- 
1.8.3.4


>From 8ad7ef374e1b05cb73d6cf445c44f10e5ec36be3 Mon Sep 17 00:00:00 2001
From: Kacper Kornet <draenog@pld-linux.org>
Date: Sat, 24 Aug 2013 03:58:05 +0100
Subject: [PATCH 2/3] t/t3701-add-interactive.sh: Add PERL prerequisite

The test 'patch mode ignores unmerged entries' uses git-add -p, so it
depends on the perl code.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 t/t3701-add-interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 9fab25c..8514220 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -330,7 +330,7 @@ test_expect_success PERL 'split hunk "add -p (edit)"' '
 	! grep "^+15" actual
 '
 
-test_expect_success 'patch mode ignores unmerged entries' '
+test_expect_success PERL 'patch mode ignores unmerged entries' '
 	git reset --hard &&
 	test_commit conflict &&
 	test_commit non-conflict &&
-- 
1.8.3.4


>From 14f135b178bfaba67653bc3bedf65ec45e38bc76 Mon Sep 17 00:00:00 2001
From: Kacper Kornet <draenog@pld-linux.org>
Date: Sat, 24 Aug 2013 04:01:02 +0100
Subject: [PATCH 3/3] t/t7106-reset-unborn-branch.sh: Add PERL prerequisite

The test 'reset -p' uses git-reset -p, so it depends on the perl code.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 t/t7106-reset-unborn-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7106-reset-unborn-branch.sh b/t/t7106-reset-unborn-branch.sh
index 8062cf5..499cd88 100755
--- a/t/t7106-reset-unborn-branch.sh
+++ b/t/t7106-reset-unborn-branch.sh
@@ -27,7 +27,7 @@ test_expect_success 'reset $file' '
 	test "$(git ls-files)" = "b"
 '
 
-test_expect_success 'reset -p' '
+test_expect_success PERL 'reset -p' '
 	rm .git/index &&
 	git add a &&
 	echo y | git reset -p &&
-- 
1.8.3.4
