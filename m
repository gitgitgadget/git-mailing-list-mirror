From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH 1/3] Make test "using invalid commit with -C" more strict
Date: Sat, 24 Aug 2013 06:01:44 +0200
Message-ID: <1377316906-70338-2-git-send-email-draenog@pld-linux.org>
References: <1377316906-70338-1-git-send-email-draenog@pld-linux.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 06:02:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD53F-0002Bv-TY
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 06:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852Ab3HXEB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 00:01:57 -0400
Received: from carme.pld-linux.org ([193.239.45.140]:59352 "EHLO
	carme.pld-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227Ab3HXEB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 00:01:56 -0400
Received: from draenog by carme.pld-linux.org with local (Exim 4.80.1)
	(envelope-from <draenog@carme.pld-linux.org>)
	id 1VD52w-000IWM-SP
	for git@vger.kernel.org; Sat, 24 Aug 2013 06:01:54 +0200
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1377316906-70338-1-git-send-email-draenog@pld-linux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232862>

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
