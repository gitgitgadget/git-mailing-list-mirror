From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-rebase.sh: Use POSIX/Susv command substitution instead of backticks
Date: Wed, 06 Feb 2008 00:08:06 +0200
Organization: Private
Message-ID: <lk5zxdix.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 23:09:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMVyv-00046f-NY
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 23:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759103AbYBEWI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 17:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759386AbYBEWI4
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 17:08:56 -0500
Received: from main.gmane.org ([80.91.229.2]:37320 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759085AbYBEWIz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 17:08:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JMVyG-00072t-O8
	for git@vger.kernel.org; Tue, 05 Feb 2008 22:08:52 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 22:08:52 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 22:08:52 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:Gq3dPfJ4lT5zU9tapHPHvvGkH/4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72706>

Use redable $(<command>) syntax instead of backtics in code.  See The
Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition

Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
---
 See http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_06_03

 git-rebase.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index bdcea0e..d2b329f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -60,7 +60,7 @@ continue_merge () {
 		die "$RESOLVEMSG"
 	fi
 
-	cmt=`cat "$dotest/current"`
+	cmt=$(cat "$dotest/current")
 	if ! git diff-index --quiet HEAD --
 	then
 		if ! git-commit -C "$cmt"
@@ -75,7 +75,7 @@ continue_merge () {
 	fi
 	git rev-list --pretty=oneline -1 "$cmt" | sed -e 's/^[^ ]* //'
 
-	prev_head=`git rev-parse HEAD^0`
+	prev_head=$(git rev-parse HEAD^0)
 	# save the resulting commit so we can read-tree on it later
 	echo "$prev_head" > "$dotest/prev_head"
 
@@ -233,7 +233,7 @@ do
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
 		case "$#,$1" in
 		*,*=*)
-			strategy=`expr "z$1" : 'z-[^=]*=\(.*\)'` ;;
+			strategy=$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
 		1,*)
 			usage ;;
 		*)
@@ -295,7 +295,7 @@ esac
 
 # The upstream head must be given.  Make sure it is valid.
 upstream_name="$1"
-upstream=`git rev-parse --verify "${upstream_name}^0"` ||
+upstream=$(git rev-parse --verify "${upstream_name}^0") ||
     die "invalid upstream $upstream_name"
 
 # Make sure the branch to rebase onto is valid.
@@ -318,9 +318,9 @@ case "$#" in
 	git-checkout "$2" || usage
 	;;
 *)
-	if branch_name=`git symbolic-ref -q HEAD`
+	if branch_name=$(git symbolic-ref -q HEAD)
 	then
-		branch_name=`expr "z$branch_name" : 'zrefs/heads/\(.*\)'`
+		branch_name=$(expr "z$branch_name" : 'zrefs/heads/\(.*\)')
 	else
 		branch_name=HEAD ;# detached
 	fi
@@ -399,7 +399,7 @@ echo "$orig_head" > "$dotest/orig-head"
 echo "$head_name" > "$dotest/head-name"
 
 msgnum=0
-for cmt in `git rev-list --reverse --no-merges "$upstream"..ORIG_HEAD`
+for cmt in $(git rev-list --reverse --no-merges "$upstream"..ORIG_HEAD)
 do
 	msgnum=$(($msgnum + 1))
 	echo "$cmt" > "$dotest/cmt.$msgnum"
-- 
1.5.4-rc5.GIT-dirty


-- 
Welcome to FOSS revolution: we fix and modify until it shines
