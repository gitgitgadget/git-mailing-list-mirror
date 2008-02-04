From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-rebase.sh: Unchain the git-COMMAND into git COMMAND
Date: Mon, 04 Feb 2008 22:25:16 +0200
Organization: Private
Message-ID: <3as81nbn.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 21:27:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM7uX-0004D3-US
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 21:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758942AbYBDU0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 15:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758940AbYBDU0F
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 15:26:05 -0500
Received: from main.gmane.org ([80.91.229.2]:58493 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758937AbYBDU0D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 15:26:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JM7t9-0006Wb-7n
	for git@vger.kernel.org; Mon, 04 Feb 2008 20:25:59 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 20:25:59 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 20:25:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:xT32WH23XVWy28AgKPITka91ISs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72557>

Change the commadns to use new style 'git COMMAND', without the dash.
Use better syntax in output displayed to user that suggests to use
--continue|--abort commands.

Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
---
 git-rebase.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index bdcea0e..37ba8a8 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -21,7 +21,7 @@ Note that if <branch> is not specified on the command line, the
 currently checked out branch is used.  You must be in the top
 directory of your project to start (or continue) a rebase.
 
-Example:       git-rebase master~1 topic
+Example:       git rebase master~1 topic
 
         A---B---C topic                   A'\''--B'\''--C'\'' topic
        /                   -->           /
@@ -63,7 +63,7 @@ continue_merge () {
 	cmt=`cat "$dotest/current"`
 	if ! git diff-index --quiet HEAD --
 	then
-		if ! git-commit -C "$cmt"
+		if ! git commit -C "$cmt"
 		then
 			echo "Commit failed, please do not call \"git commit\""
 			echo "directly, but instead do one of the following: "
@@ -94,7 +94,7 @@ call_merge () {
 	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
 	eval GITHEAD_$hd='$(cat "$dotest/onto_name")'
 	export GITHEAD_$cmt GITHEAD_$hd
-	git-merge-$strategy "$cmt^" -- "$hd" "$cmt"
+	git merge-$strategy "$cmt^" -- "$hd" "$cmt"
 	rv=$?
 	case "$rv" in
 	0)
@@ -111,7 +111,7 @@ call_merge () {
 		;;
 	*)
 		die "Unknown exit code ($rv) from command:" \
-			"git-merge-$strategy $cmt^ -- HEAD $cmt"
+			"git merge-$strategy $cmt^ -- HEAD $cmt"
 		;;
 	esac
 }
@@ -279,7 +279,7 @@ else
 	if test -d "$dotest"
 	then
 		die "previous dotest directory $dotest still exists." \
-			'try git-rebase < --continue | --abort >'
+			'try git rebase {--continue|--abort}'
 	fi
 fi
 
@@ -315,7 +315,7 @@ fi
 case "$#" in
 2)
 	branch_name="$2"
-	git-checkout "$2" || usage
+	git checkout "$2" || usage
 	;;
 *)
 	if branch_name=`git symbolic-ref -q HEAD`
@@ -363,7 +363,7 @@ esac
 
 # Rewind the head to "$onto"; this saves our current head in ORIG_HEAD.
 echo "First, rewinding head to replay your work on top of it..."
-git-reset --hard "$onto"
+git reset --hard "$onto"
 
 # If the $onto is a proper descendant of the tip of the branch, then
 # we just fast forwarded.
@@ -387,7 +387,7 @@ then
 	exit $ret
 fi
 
-# start doing a rebase with git-merge
+# start doing a rebase with "git merge"
 # this is rename-aware if the recursive (default) strategy is used
 
 mkdir -p "$dotest"
-- 
1.5.4-rc5.GIT-dirty


-- 
Welcome to FOSS revolution: we fix and modify until it shines
