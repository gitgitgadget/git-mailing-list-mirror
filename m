From: Cameron Currie <me@cameroncurrie.net>
Subject: [PATCH v2] git-stash: Don't GPG sign when stashing changes
Date: Mon, 2 May 2016 20:50:02 +0000
Message-ID: <01020154733c27e9-deaa7a20-1de6-416a-a7d4-3229854117eb-000000@eu-west-1.amazonses.com>
References: <00000150dddb0eeb-b77240fb-1b63-4676-ac4b-1220b8d011ca-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 23:02:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axKzS-0007Xd-6e
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 23:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152AbcEBVCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 17:02:46 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:41114
	"EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754976AbcEBVCp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2016 17:02:45 -0400
X-Greylist: delayed 759 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 May 2016 17:02:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1462222202;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=ZmI0sSIk/Fsi3aC5/AIBoIf/3mjTibjopS1PqqbGOY8=;
	b=Cicqa1o/Gpjoz2E4Pma+nmI6DEp7MwfunCDMhBSN2/5+JNf4HbbvmUP5xHI77MWP
	/bEvIlS/U88uI2epieLH4saDiCCcO9pCXed4LAVeHs1XYOmMiBdKyHSnHUmhrvVA3oS
	LLv0EQpG2yM7LYXIWHYXaf8GTW4bxMp9bt/KVLbk=
In-Reply-To: <00000150dddb0eeb-b77240fb-1b63-4676-ac4b-1220b8d011ca-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.05.02-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293290>

This is helpful for folks with commit.gpgsign = true in their .gitconfig.

Signed-off-by: Cameron Currie <me@cameroncurrie.net>
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
