From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/8] bash: Complete long options to git-add.
Date: Sun, 4 Feb 2007 02:38:23 -0500
Message-ID: <20070204073823.GC17603@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 08:38:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDbxJ-0007PP-Dh
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 08:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbXBDHi3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 02:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752142AbXBDHi3
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 02:38:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55512 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbXBDHi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 02:38:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDbxA-0008Vc-FL; Sun, 04 Feb 2007 02:38:24 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 08CDA20FBAE; Sun,  4 Feb 2007 02:38:24 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38657>

The new --interactive mode of git-add can be very useful, so users
will probably want to have completion for it.

Likewise the new git-add--interactive executable is actually a
plumbing command.  Its invoked by `git add --interactive` and is
not intended to be invoked directly by the user.  Therefore we
should hide it from the list of available Git commands.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b87f96d..93f2af5 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -235,6 +235,7 @@ __git_commands ()
 	for i in $(git help -a|egrep '^ ')
 	do
 		case $i in
+		add--interactive) : plumbing;;
 		cat-file)         : plumbing;;
 		check-ref-format) : plumbing;;
 		commit-tree)      : plumbing;;
@@ -358,6 +359,19 @@ _git_apply ()
 	COMPREPLY=()
 }
 
+_git_add ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		COMPREPLY=($(compgen -W "
+			--interactive
+			" -- "$cur"))
+		return
+	esac
+	COMPREPLY=()
+}
+
 _git_branch ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -786,6 +800,7 @@ _git ()
 
 	case "$command" in
 	am)          _git_am ;;
+	add)         _git_add ;;
 	apply)       _git_apply ;;
 	branch)      _git_branch ;;
 	checkout)    _git_checkout ;;
@@ -852,6 +867,7 @@ complete -o default -o nospace -F _git_log git-whatchanged
 # included the '.exe' suffix.
 #
 if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
+complete -o default            -F _git_add git-add.exe
 complete -o default            -F _git_apply git-apply.exe
 complete -o default -o nospace -F _git git.exe
 complete -o default            -F _git_branch git-branch.exe
-- 
1.5.0.rc3.22.g5057
