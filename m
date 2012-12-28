From: Aaron Schrab <aaron@schrab.com>
Subject: [PATCH] Use longer alias names in subdirectory tests
Date: Fri, 28 Dec 2012 18:03:06 -0500
Message-ID: <1356735786-24001-1-git-send-email-aaron@schrab.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 29 00:03:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Toixp-0004W8-T5
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 00:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661Ab2L1XDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 18:03:23 -0500
Received: from pug.qqx.org ([50.116.43.67]:57447 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754115Ab2L1XDW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 18:03:22 -0500
Received: from zim.qqx.org (cpe-107-015-024-243.nc.res.rr.com [107.15.24.243])
	by pug.qqx.org (Postfix) with ESMTPSA id 19EB31D0A4
	for <git@vger.kernel.org>; Fri, 28 Dec 2012 18:03:22 -0500 (EST)
Received: from ats (uid 1000)
	(envelope-from aaron@schrab.com)
	id 48071
	by zim.qqx.org (DragonFly Mail Agent);
	Fri, 28 Dec 2012 18:03:21 -0500
X-Mailer: git-send-email 1.8.1.rc3.16.g47d6ba6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212275>

When testing aliases in t/t1020-subdirectory.sh use longer names so that
they're less likely to conflict with a git-* command somewhere in the
$PATH.

I have a git-ss command in my path which prevents the 'ss' alias from
being used.  This command will always fail for git.git, causing the test
to fail.  Even if the command succeeded, that would be a false success
for the test since the alias wasn't actually used.  A longer, more
descriptive name will make it much less likely that somebody has a
command in their $PATH which will shadow the alias created for the test.

While here, use a longer name for the 'test' alias as well since that is
also short and meaningful enough to make it not unlikely that somebody
would have a command in their $PATH which will shadow that as well.

Signed-off-by: Aaron Schrab <aaron@schrab.com>
---
 t/t1020-subdirectory.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index e23ac0e..1e2945e 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -111,19 +111,19 @@ test_expect_success 'read-tree' '
 
 test_expect_success 'alias expansion' '
 	(
-		git config alias.ss status &&
+		git config alias.test-status-alias status &&
 		cd dir &&
 		git status &&
-		git ss
+		git test-status-alias
 	)
 '
 
 test_expect_success NOT_MINGW '!alias expansion' '
 	pwd >expect &&
 	(
-		git config alias.test !pwd &&
+		git config alias.test-alias-directory !pwd &&
 		cd dir &&
-		git test >../actual
+		git test-alias-directory >../actual
 	) &&
 	test_cmp expect actual
 '
@@ -131,9 +131,9 @@ test_expect_success NOT_MINGW '!alias expansion' '
 test_expect_success 'GIT_PREFIX for !alias' '
 	printf "dir/" >expect &&
 	(
-		git config alias.test "!sh -c \"printf \$GIT_PREFIX\"" &&
+		git config alias.test-alias-directory "!sh -c \"printf \$GIT_PREFIX\"" &&
 		cd dir &&
-		git test >../actual
+		git test-alias-directory >../actual
 	) &&
 	test_cmp expect actual
 '
-- 
1.8.1.rc3.16.g47d6ba6
