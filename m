X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/6] Support bash completion on symmetric difference operator.
Date: Sun, 5 Nov 2006 06:24:56 -0500
Message-ID: <20061105112456.GE20495@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 11:25:19 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30970>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggg7c-0007mA-On for gcvg-git@gmane.org; Sun, 05 Nov
 2006 12:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932651AbWKELZA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 06:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWKELZA
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 06:25:00 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:19585 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S932651AbWKELY7
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 06:24:59 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ggg7S-00007M-Ex; Sun, 05 Nov 2006 06:24:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 8C25F20E491; Sun,  5 Nov 2006 06:24:56 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Now that log, whatchanged, rev-list, etc. support the symmetric
difference operator '...' we should provide bash completion for it
just like we do for '..'.

While we are at it we can remove two sed invocations during the
interactive prompt and replace them with internal bash operations.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f258f2f..74be651 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -222,11 +222,16 @@ _git_ls_tree ()
 
 _git_log ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local pfx cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
+	*...*)
+		pfx="${cur%...*}..."
+		cur="${cur#*...}"
+		COMPREPLY=($(compgen -P "$pfx" -W "$(__git_refs)" -- "$cur"))
+		;;
 	*..*)
-		local pfx=$(echo "$cur" | sed 's/\.\..*$/../')
-		cur=$(echo "$cur" | sed 's/^.*\.\.//')
+		pfx="${cur%..*}.."
+		cur="${cur#*..}"
 		COMPREPLY=($(compgen -P "$pfx" -W "$(__git_refs)" -- "$cur"))
 		;;
 	*)
-- 
1.4.3.3.g9621
