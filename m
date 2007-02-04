From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/8] bash: Classify cat-file and reflog as plumbing.
Date: Sun, 4 Feb 2007 02:38:21 -0500
Message-ID: <20070204073821.GB17603@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 08:38:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDbxI-0007PP-TI
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 08:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbXBDHi0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 02:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbXBDHiZ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 02:38:25 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55506 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbXBDHiY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 02:38:24 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDbx7-0008VU-Py; Sun, 04 Feb 2007 02:38:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5AB3F20FBAE; Sun,  4 Feb 2007 02:38:21 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38656>

Now that git-show is capable of displaying any file content from any
revision and is the approved Porcelain-ish level method of doing so,
cat-file should no longer be classified as a user-level utility by
the bash completion package.

I'm also classifying the new git-reflog command as plumbing for the
time being as there are no subcommands which are really useful to
the end-user.  git-gc already invokes `git reflog expire --all`,
which makes it rather unnecessary for the user to invoke it directly.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   23 +++--------------------
 1 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 971fefb..b87f96d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1,7 +1,7 @@
 #
 # bash completion support for core Git.
 #
-# Copyright (C) 2006 Shawn Pearce
+# Copyright (C) 2006,2007 Shawn Pearce
 # Conceptually based on gitcompletion (http://gitweb.hawaga.org.uk/).
 #
 # The contained completion routines provide support for completing:
@@ -235,6 +235,7 @@ __git_commands ()
 	for i in $(git help -a|egrep '^ ')
 	do
 		case $i in
+		cat-file)         : plumbing;;
 		check-ref-format) : plumbing;;
 		commit-tree)      : plumbing;;
 		convert-objects)  : plumbing;;
@@ -258,6 +259,7 @@ __git_commands ()
 		peek-remote)      : plumbing;;
 		read-tree)        : plumbing;;
 		receive-pack)     : plumbing;;
+		reflog)           : plumbing;;
 		rerere)           : plumbing;;
 		rev-list)         : plumbing;;
 		rev-parse)        : plumbing;;
@@ -362,22 +364,6 @@ _git_branch ()
 	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
 }
 
-_git_cat_file ()
-{
-	local cur="${COMP_WORDS[COMP_CWORD]}"
-	case "${COMP_WORDS[0]},$COMP_CWORD" in
-	git-cat-file*,1)
-		COMPREPLY=($(compgen -W "-p -t blob tree commit tag" -- "$cur"))
-		;;
-	git,2)
-		COMPREPLY=($(compgen -W "-p -t blob tree commit tag" -- "$cur"))
-		;;
-	*)
-		__git_complete_file
-		;;
-	esac
-}
-
 _git_checkout ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -802,7 +788,6 @@ _git ()
 	am)          _git_am ;;
 	apply)       _git_apply ;;
 	branch)      _git_branch ;;
-	cat-file)    _git_cat_file ;;
 	checkout)    _git_checkout ;;
 	cherry-pick) _git_cherry_pick ;;
 	commit)      _git_commit ;;
@@ -840,7 +825,6 @@ complete -o default            -F _gitk gitk
 complete -o default            -F _git_am git-am
 complete -o default            -F _git_apply git-apply
 complete -o default            -F _git_branch git-branch
-complete -o default -o nospace -F _git_cat_file git-cat-file
 complete -o default            -F _git_checkout git-checkout
 complete -o default            -F _git_cherry_pick git-cherry-pick
 complete -o default            -F _git_commit git-commit
@@ -871,7 +855,6 @@ if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
 complete -o default            -F _git_apply git-apply.exe
 complete -o default -o nospace -F _git git.exe
 complete -o default            -F _git_branch git-branch.exe
-complete -o default -o nospace -F _git_cat_file git-cat-file.exe
 complete -o default -o nospace -F _git_diff git-diff.exe
 complete -o default -o nospace -F _git_diff_tree git-diff-tree.exe
 complete -o default -o nospace -F _git_format_patch git-format-patch.exe
-- 
1.5.0.rc3.22.g5057
