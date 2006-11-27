X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 8/10] Teach bash about git log/show/whatchanged options.
Date: Mon, 27 Nov 2006 03:42:18 -0500
Message-ID: <20061127084218.GH19745@spearce.org>
References: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 08:42:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32398>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goc4H-0007iZ-IZ for gcvg-git@gmane.org; Mon, 27 Nov
 2006 09:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757430AbWK0ImW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 03:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757425AbWK0ImW
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 03:42:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:10636 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757430AbWK0ImV
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 03:42:21 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Goc4A-0004VI-4y; Mon, 27 Nov 2006 03:42:18 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 4EF9520FB7F; Mon, 27 Nov 2006 03:42:18 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Typing out options to git log/show/whatchanged can take a while, but
we can easily complete them with bash.  So list the most common ones,
especially --pretty=online|short|medium|... so that users don't need
to type everything out.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   34 ++++++++++++++++++++++++-------
 1 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a61b6b9..8acfb09 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -358,6 +358,29 @@ _git_ls_tree ()
 
 _git_log ()
 {
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--pretty=*)
+		COMPREPLY=($(compgen -W "
+			oneline short medium full fuller email raw
+			" -- "${cur##--pretty=}"))
+		return
+		;;
+	--*)
+		COMPREPLY=($(compgen -W "
+			--max-count= --max-age= --since= --after=
+			--min-age= --before= --until=
+			--root --not --topo-order --date-order
+			--no-merges
+			--abbrev-commit --abbrev=
+			--relative-date
+			--author= --committer= --grep=
+			--all-match
+			--pretty= --name-status --name-only
+			" -- "$cur"))
+		return
+		;;
+	esac
 	__git_complete_revlist
 }
 
@@ -474,12 +497,6 @@ _git_reset ()
 	COMPREPLY=($(compgen -W "$opt $(__git_refs)" -- "$cur"))
 }
 
-_git_show ()
-{
-	local cur="${COMP_WORDS[COMP_CWORD]}"
-	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
-}
-
 _git ()
 {
 	local i c=1 command __git_dir
@@ -526,7 +543,7 @@ _git ()
 	push)        _git_push ;;
 	rebase)      _git_rebase ;;
 	reset)       _git_reset ;;
-	show)        _git_show ;;
+	show)        _git_log ;;
 	show-branch) _git_log ;;
 	whatchanged) _git_log ;;
 	*)           COMPREPLY=() ;;
@@ -559,7 +576,7 @@ complete -o default -o nospace -F _git_pull git-pull
 complete -o default -o nospace -F _git_push git-push
 complete -o default            -F _git_rebase git-rebase
 complete -o default            -F _git_reset git-reset
-complete -o default            -F _git_show git-show
+complete -o default            -F _git_log git-show
 complete -o default -o nospace -F _git_log git-show-branch
 complete -o default -o nospace -F _git_log git-whatchanged
 
@@ -579,6 +596,7 @@ complete -o default -o nospace -F _git_ls_tree git-ls-tree.exe
 complete -o default            -F _git_merge_base git-merge-base.exe
 complete -o default            -F _git_name_rev git-name-rev.exe
 complete -o default -o nospace -F _git_push git-push.exe
+complete -o default -o nospace -F _git_log git-show.exe
 complete -o default -o nospace -F _git_log git-show-branch.exe
 complete -o default -o nospace -F _git_log git-whatchanged.exe
 fi
-- 
1.4.4.1.ge3fb
