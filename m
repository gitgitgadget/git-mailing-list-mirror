X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Teach bash the new features of 'git show'.
Date: Fri, 15 Dec 2006 02:20:03 -0500
Message-ID: <20061215072003.GA28031@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 07:20:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
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
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34474>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv7Mb-00011w-Tv for gcvg-git@gmane.org; Fri, 15 Dec
 2006 08:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751222AbWLOHUJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 02:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWLOHUJ
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 02:20:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59236 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751222AbWLOHUI (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 02:20:08 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gv7MT-0006y0-IB; Fri, 15 Dec 2006 02:20:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 E8F3B20FB65; Fri, 15 Dec 2006 02:20:03 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Now that 'git show' accepts ref:path as an argument to specify a
tree or blob we should use the same completion logic as we support
for cat-file's object identifier.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9c4d23a..234cd09 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -752,6 +752,24 @@ _git_reset ()
 	COMPREPLY=($(compgen -W "$opt $(__git_refs)" -- "$cur"))
 }
 
+_git_show ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--pretty=*)
+		COMPREPLY=($(compgen -W "
+			oneline short medium full fuller email raw
+			" -- "${cur##--pretty=}"))
+		return
+		;;
+	--*)
+		COMPREPLY=($(compgen -W "--pretty=" -- "$cur"))
+		return
+		;;
+	esac
+	__git_complete_file
+}
+
 _git ()
 {
 	local i c=1 command __git_dir
@@ -802,7 +820,7 @@ _git ()
 	rebase)      _git_rebase ;;
 	repo-config) _git_repo_config ;;
 	reset)       _git_reset ;;
-	show)        _git_log ;;
+	show)        _git_show ;;
 	show-branch) _git_log ;;
 	whatchanged) _git_log ;;
 	*)           COMPREPLY=() ;;
@@ -839,7 +857,7 @@ complete -o default -o nospace -F _git_push git-push
 complete -o default            -F _git_rebase git-rebase
 complete -o default            -F _git_repo_config git-repo-config
 complete -o default            -F _git_reset git-reset
-complete -o default            -F _git_log git-show
+complete -o default -o nospace -F _git_show git-show
 complete -o default -o nospace -F _git_log git-show-branch
 complete -o default -o nospace -F _git_log git-whatchanged
 
@@ -861,7 +879,7 @@ complete -o default            -F _git_merge_base git-merge-base.exe
 complete -o default            -F _git_name_rev git-name-rev.exe
 complete -o default -o nospace -F _git_push git-push.exe
 complete -o default            -F _git_repo_config git-repo-config
-complete -o default -o nospace -F _git_log git-show.exe
+complete -o default -o nospace -F _git_show git-show.exe
 complete -o default -o nospace -F _git_log git-show-branch.exe
 complete -o default -o nospace -F _git_log git-whatchanged.exe
 fi
-- 
