From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 6/6] bash: Support git-bisect and its subcommands.
Date: Mon, 5 Feb 2007 15:44:37 -0500
Message-ID: <20070205204437.GF8824@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 21:44:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEAhm-0007ZE-8w
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 21:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933447AbXBEUol (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 15:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933454AbXBEUol
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 15:44:41 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36115 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933447AbXBEUok (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 15:44:40 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEAhS-0008J4-W2; Mon, 05 Feb 2007 15:44:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C022320FBAE; Mon,  5 Feb 2007 15:44:37 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38785>

We now offer completion support for git-bisect's subcommands,
as well as ref name completion on the good/bad/reset subcommands.
This should make interacting with git-bisect slightly easier on
the fingers.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c410678..eecdaa0 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -407,6 +407,35 @@ _git_add ()
 	COMPREPLY=()
 }
 
+_git_bisect ()
+{
+	local i c=1 command
+	while [ $c -lt $COMP_CWORD ]; do
+		i="${COMP_WORDS[c]}"
+		case "$i" in
+		start|bad|good|reset|visualize|replay|log)
+			command="$i"
+			break
+			;;
+		esac
+		c=$((++c))
+	done
+
+	if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
+		__gitcomp "start bad good reset visualize replay log"
+		return
+	fi
+
+	case "$command" in
+	bad|good|reset)
+		__gitcomp "$(__git_refs)"
+		;;
+	*)
+		COMPREPLY=()
+		;;
+	esac
+}
+
 _git_branch ()
 {
 	__gitcomp "$(__git_refs)"
@@ -910,6 +939,7 @@ _git ()
 	am)          _git_am ;;
 	add)         _git_add ;;
 	apply)       _git_apply ;;
+	bisect)      _git_bisect ;;
 	branch)      _git_branch ;;
 	checkout)    _git_checkout ;;
 	cherry)      _git_cherry ;;
@@ -955,6 +985,7 @@ complete -o default -o nospace -F _git git
 complete -o default -o nospace -F _gitk gitk
 complete -o default -o nospace -F _git_am git-am
 complete -o default -o nospace -F _git_apply git-apply
+complete -o default -o nospace -F _git_bisect git-bisect
 complete -o default -o nospace -F _git_branch git-branch
 complete -o default -o nospace -F _git_checkout git-checkout
 complete -o default -o nospace -F _git_cherry git-cherry
-- 
1.5.0.rc3.58.g79812
