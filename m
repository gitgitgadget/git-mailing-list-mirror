From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] cg-commit: Fix a typo that would inhibit running of post-commit script:
Date: Thu, 24 Aug 2006 20:19:54 +0200
Message-ID: <8764giro6t.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 24 20:19:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGJng-00011e-2S
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 20:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbWHXSTY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 14:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbWHXSTX
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 14:19:23 -0400
Received: from mx.meyering.net ([82.230.74.64]:14986 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S1751674AbWHXSTW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 14:19:22 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 39C25F5E; Thu, 24 Aug 2006 20:19:54 +0200 (CEST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25970>

I tried cg-commit with a commit hook, but the hook never ran.
The problem was a typo:

Fix a typo that would inhibit running the post-commit script:
s/commit-post/post-commit/.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 cg-commit |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/cg-commit b/cg-commit
index 9d3b1a1..82eea60 100755
--- a/cg-commit
+++ b/cg-commit
@@ -604,15 +604,16 @@ if [ "$newhead" ]; then
 		branchname="$(cat "$_git/branch-name")"
 	fi
 	[ -z "$branchname" ] && [ "$_git_head" != "master" ] && branchname="$_git_head"
-	if [ -x "$_git/hooks/post-commit" -a ! "$no_hooks" ]; then
+	post_commit="$_git/hooks/post-commit"
+	if [ -x "$post_commit" -a ! "$no_hooks" ]; then
 		if [ "$(git-repo-config --bool cogito.hooks.commit.post.allmerged)" = "true" ]; then
 			# We just hope that for the initial commit, the user didn't
 			# manage to install the hook yet.
 			for merged in $(git-rev-list $newhead ^$oldhead | tac); do
-				"$_git/hooks/post-commit" "$merged" "$branchname"
+				"$post_commit" "$merged" "$branchname"
 			done
 		else
-			"$_git/hooks/post-commit" "$newhead" "$branchname"
+			"$post_commit" "$newhead" "$branchname"
 		fi
 	fi
 
-- 
1.4.1.1
