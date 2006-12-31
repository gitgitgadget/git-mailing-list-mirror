From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Refresh the index before starting merge-recursive.
Date: Sun, 31 Dec 2006 00:02:13 -0500
Message-ID: <20061231050213.GA6008@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 06:02:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0spz-0005at-7y
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 06:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732AbWLaFCS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 00:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932746AbWLaFCS
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 00:02:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43756 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932732AbWLaFCR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 00:02:17 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0spe-00014q-Pr; Sun, 31 Dec 2006 00:02:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 481FA20FB65; Sun, 31 Dec 2006 00:02:14 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35667>

Since merge-recursive won't perform a refresh of stale stat data on
its own we need to make sure we run `update-index --refresh` prior
to starting it, otherwise stale stat data may cause an otherwise
valid merge to fail.

This was simply a thinko on my part when I reorganized this section
of code.  Silly copy and paste error and all....

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Applies to the top of my sp/merge topic.

 git-merge.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 922c5b8..ced5524 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -296,6 +296,7 @@ f,*)
 ?,1,*,)
 	# We are not doing octopus, not fast forward, and have only
 	# one common.  See if it is really trivial.
+	git-update-index --refresh 2>/dev/null
 	case "$use_strategies" in
 	recursive|'recursive '|recur|'recur ')
 		: run merge later
@@ -303,7 +304,6 @@ f,*)
 	*)
 		git var GIT_COMMITTER_IDENT >/dev/null || exit
 		echo "Trying really trivial in-index merge..."
-		git-update-index --refresh 2>/dev/null
 		if git-read-tree --trivial -m -u -v $common $head "$1" &&
 		   result_tree=$(git-write-tree)
 		then
-- 
1.5.0.rc0.g6bb1
