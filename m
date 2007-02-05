From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] bash: Complete git-remote subcommands.
Date: Sun, 4 Feb 2007 23:52:08 -0500
Message-ID: <20070205045208.GB13398@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 05:52:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDvpz-0007e9-5q
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 05:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbXBEEwN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 23:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbXBEEwN
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 23:52:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60776 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbXBEEwM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 23:52:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDvpd-0002bA-SG; Sun, 04 Feb 2007 23:51:57 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F118120FBAE; Sun,  4 Feb 2007 23:52:08 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38726>

Completing the 3 core subcommands to git-remote, along with the
names of remotes for 'show' and 'prune' (which take only existing
remotes) is handy.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5f9a34b..2387506 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -804,6 +804,32 @@ _git_config ()
 	"
 }
 
+_git_remote ()
+{
+	local i c=1 command
+	while [ $c -lt $COMP_CWORD ]; do
+		i="${COMP_WORDS[c]}"
+		case "$i" in
+		add|show|prune) command="$i"; break ;;
+		esac
+		c=$((++c))
+	done
+
+	if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
+		__gitcomp "add show prune"
+		return
+	fi
+
+	case "$command" in
+	show|prune)
+		__gitcomp "$(__git_remotes)"
+		;;
+	*)
+		COMPREPLY=()
+		;;
+	esac
+}
+
 _git_reset ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -883,6 +909,7 @@ _git ()
 	pull)        _git_pull ;;
 	push)        _git_push ;;
 	rebase)      _git_rebase ;;
+	remote)      _git_remote ;;
 	reset)       _git_reset ;;
 	show)        _git_show ;;
 	show-branch) _git_log ;;
@@ -925,6 +952,7 @@ complete -o default -o nospace -F _git_pull git-pull
 complete -o default -o nospace -F _git_push git-push
 complete -o default -o nospace -F _git_rebase git-rebase
 complete -o default -o nospace -F _git_config git-config
+complete -o default -o nospace -F _git_remote git-remote
 complete -o default -o nospace -F _git_reset git-reset
 complete -o default -o nospace -F _git_show git-show
 complete -o default -o nospace -F _git_log git-show-branch
-- 
1.5.0.rc3.39.gec804
