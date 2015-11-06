From: Cameron Currie <me@cameroncurrie.net>
Subject: [PATCH] git-stash: Don't GPG sign when stashing changes
Date: Fri, 6 Nov 2015 17:32:12 +0000
Message-ID: <00000150dddb0eeb-b77240fb-1b63-4676-ac4b-1220b8d011ca-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 18:46:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zul64-0007Ru-CS
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 18:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161796AbbKFRqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 12:46:40 -0500
Received: from a6-246.smtp-out.eu-west-1.amazonses.com ([54.240.6.246]:38449
	"EHLO a6-246.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161731AbbKFRqk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2015 12:46:40 -0500
X-Greylist: delayed 865 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2015 12:46:39 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1446831132;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=uvWCUeMonDK4TzwMyglV56uo61xZTIPleer8HIIO+HQ=;
	b=cgfqhRlvjF4rrlO/yhn1Srz2zT0TiE0+wbyoTm74wD/4FbYFPIOrfxsDRZx4aWmh
	s9IZ8X3xRSWESwoy4CErNGTPksHcfQIkoqyiGCqWfOp+RIGHTr7B0W14ZLzm+2Nv0KZ
	l8BWZP+ZCnOvKMGLwU6itqc2f35QSQsR5EGXvW+c=
X-SES-Outgoing: 2015.11.06-54.240.6.246
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280991>

This is helpful for folks with commit.gpgsign = true in their .gitconfig.
---
 git-stash.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index c7c65e2..fcf01b9 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -85,7 +85,7 @@ create_stash () {
 	# state of the index
 	i_tree=$(git write-tree) &&
 	i_commit=$(printf 'index on %s\n' "$msg" |
-		git commit-tree $i_tree -p $b_commit) ||
+		git commit-tree --no-gpg-sign $i_tree -p $b_commit) ||
 		die "$(gettext "Cannot save the current index state")"
 
 	if test -n "$untracked"
@@ -99,7 +99,7 @@ create_stash () {
 				rm -f "$TMPindex" &&
 				git update-index -z --add --remove --stdin &&
 				u_tree=$(git write-tree) &&
-				printf 'untracked files on %s\n' "$msg" | git commit-tree $u_tree  &&
+				printf 'untracked files on %s\n' "$msg" | git commit-tree --no-gpg-sign $u_tree  &&
 				rm -f "$TMPindex"
 		) ) || die "Cannot save the untracked files"
 
@@ -153,7 +153,7 @@ create_stash () {
 		stash_msg=$(printf 'On %s: %s' "$branch" "$stash_msg")
 	fi
 	w_commit=$(printf '%s\n' "$stash_msg" |
-	git commit-tree $w_tree -p $b_commit -p $i_commit $untracked_commit_option) ||
+	git commit-tree --no-gpg-sign $w_tree -p $b_commit -p $i_commit $untracked_commit_option) ||
 	die "$(gettext "Cannot record working tree state")"
 }
 

--
https://github.com/git/git/pull/186
