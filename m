From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 1/2] Avoid using the git wrapper in git-rebase.sh.
Date: Fri, 14 Jul 2006 00:46:55 -0400
Message-ID: <20060714044655.GA1982@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jul 14 06:47:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1FaB-0007jK-KH
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 06:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161260AbWGNEq7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 00:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161261AbWGNEq7
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 00:46:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54202 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1161260AbWGNEq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 00:46:58 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G1FZp-0001nc-Kp
	for git@vger.kernel.org; Fri, 14 Jul 2006 00:46:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 757C820E462; Fri, 14 Jul 2006 00:46:55 -0400 (EDT)
To: git@vger.kernel.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23870>

Ideally 'shipped' commands (e.g. git-rebase) should avoid calling
the git wrapper when executing other commands to prevent the user
from shadowing those commands with aliases and causing the shipped
command behavior to differ unexpectedly.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-rebase.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 1b9e986..6d06665 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -131,7 +131,7 @@ do
 			finish_rb_merge
 			exit
 		fi
-		git am --resolved --3way --resolvemsg="$RESOLVEMSG"
+		git-am --resolved --3way --resolvemsg="$RESOLVEMSG"
 		exit
 		;;
 	--skip)
@@ -150,7 +150,7 @@ do
 			finish_rb_merge
 			exit
 		fi
-		git am -3 --skip --resolvemsg="$RESOLVEMSG"
+		git-am -3 --skip --resolvemsg="$RESOLVEMSG"
 		exit
 		;;
 	--abort)
@@ -163,7 +163,7 @@ do
 		else
 			die "No rebase in progress?"
 		fi
-		git reset --hard ORIG_HEAD
+		git-reset --hard ORIG_HEAD
 		exit
 		;;
 	--onto)
@@ -231,7 +231,7 @@ esac
 
 # The upstream head must be given.  Make sure it is valid.
 upstream_name="$1"
-upstream=`git rev-parse --verify "${upstream_name}^0"` ||
+upstream=`git-rev-parse --verify "${upstream_name}^0"` ||
     die "invalid upstream $upstream_name"
 
 # If a hook exists, give it a chance to interrupt
@@ -250,7 +250,7 @@ case "$#" in
 	git-checkout "$2" || usage
 	;;
 *)
-	branch_name=`git symbolic-ref HEAD` || die "No current branch"
+	branch_name=`git-symbolic-ref HEAD` || die "No current branch"
 	branch_name=`expr "z$branch_name" : 'zrefs/heads/\(.*\)'`
 	;;
 esac
@@ -288,7 +288,7 @@ fi
 if test -z "$do_merge"
 then
 	git-format-patch -k --stdout --full-index "$upstream"..ORIG_HEAD |
-	git am --binary -3 -k --resolvemsg="$RESOLVEMSG"
+	git-am --binary -3 -k --resolvemsg="$RESOLVEMSG"
 	exit $?
 fi
 
-- 
1.4.1.gd3d5
