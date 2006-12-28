From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 6/11] Allow git-merge to select the default strategy.
Date: Thu, 28 Dec 2006 02:35:11 -0500
Message-ID: <20061228073511.GF17867@spearce.org>
References: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 08:35:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzpnP-0000vl-7c
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 08:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWL1HfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 02:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWL1HfT
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 02:35:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45827 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964992AbWL1HfR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 02:35:17 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gzpmo-0007xW-Gi; Thu, 28 Dec 2006 02:34:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DD7C320FB65; Thu, 28 Dec 2006 02:35:11 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35528>

Now that git-merge knows how to use the pull.{twohead,octopus}
configuration options to select the default merge strategy there
is no reason for git-pull to do the same immediately prior to
invoking git-merge.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-pull.sh |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 2725946..28d0819 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -90,18 +90,6 @@ case "$merge_head" in
 		echo >&2 "Cannot merge multiple branches into empty head"
 		exit 1
 	fi
-	var=`git-repo-config --get pull.octopus`
-	if test -n "$var"
-	then
-		strategy_default_args="-s $var"
-	fi
-	;;
-*)
-	var=`git-repo-config --get pull.twohead`
-	if test -n "$var"
-        then
-		strategy_default_args="-s $var"
-	fi
 	;;
 esac
 
@@ -112,12 +100,6 @@ then
 	exit
 fi
 
-case "$strategy_args" in
-'')
-	strategy_args=$strategy_default_args
-	;;
-esac
-
 merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
 exec git-merge $no_summary $no_commit $squash $strategy_args \
 	"$merge_name" HEAD $merge_head
-- 
1.4.4.3.gd2e4
