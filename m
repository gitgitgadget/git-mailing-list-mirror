From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-branch: display sha1 on branch deletion
Date: Fri, 12 Dec 2008 13:29:01 -0600
Message-ID: <uTIFnEi0iyLKcAungf7u1Gu2xl50j9i-AMiZaQp-QTs1q-ppgyHZoelGLgvK7BFKpYE03BLRHJ4@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 12 20:32:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBDix-0002Qk-Ly
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 20:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbYLLT3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 14:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbYLLT3h
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 14:29:37 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44909 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbYLLT3g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 14:29:36 -0500
Received: by mail.nrlssc.navy.mil id mBCJTPdo024866; Fri, 12 Dec 2008 13:29:25 -0600
X-OriginalArrivalTime: 12 Dec 2008 19:29:24.0874 (UTC) FILETIME=[F0EA5EA0:01C95C8F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102931>

Make it easier to recover from a mistaken branch deletion by displaying the
sha1 of the branch's tip commit.

Update t3200.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin-branch.c  |    3 ++-
 t/t3200-branch.sh |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 494cbac..b3d0d20 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -165,7 +165,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 			ret = 1;
 		} else {
 			struct strbuf buf = STRBUF_INIT;
-			printf("Deleted %sbranch %s.\n", remote, argv[i]);
+			printf("Deleted %sbranch %s (%s).\n", remote, argv[i],
+                                sha1_to_hex(sha1));
 			strbuf_addf(&buf, "branch.%s", argv[i]);
 			if (git_config_rename_section(buf.buf, NULL) < 0)
 				warning("Update of config-file failed");
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 25e9971..e9bb6d5 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -194,7 +194,8 @@ test_expect_success 'test deleting branch deletes branch config' \
 
 test_expect_success 'test deleting branch without config' \
     'git branch my7 s &&
-     test "$(git branch -d my7 2>&1)" = "Deleted branch my7."'
+     sha1=$(git rev-parse my7) &&
+     test "$(git branch -d my7 2>&1)" = "Deleted branch my7 ($sha1)."'
 
 test_expect_success 'test --track without .fetch entries' \
     'git branch --track my8 &&
-- 
1.6.0.4.794.g35fad
