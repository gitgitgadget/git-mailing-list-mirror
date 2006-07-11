From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Log ref changes made by quiltimport.
Date: Tue, 11 Jul 2006 02:10:19 -0400
Message-ID: <20060711061019.GA11822@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 08:10:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0BRz-000776-B4
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 08:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWGKGKY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 02:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWGKGKY
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 02:10:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34242 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964820AbWGKGKX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 02:10:23 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G0BRs-0006va-Oi; Tue, 11 Jul 2006 02:10:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 61D2A20E43C; Tue, 11 Jul 2006 02:10:19 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23688>

When importing a quilt patch to a branch which has a reflog record
the update to HEAD with a log message indicating the change was
made by quiltimport and what patch caused the change.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Aside from git-resolve and git-clone this is the last shell script
 which didn't include a log message when invoking update-ref.  So
 here it is.  :-)

 git-quiltimport.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 86b51ab..9f16e18 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -112,7 +112,7 @@ for patch_name in $(cat "$QUILT_PATCHES/
 		git-apply --index -C1 "$tmp_patch" &&
 		tree=$(git-write-tree) &&
 		commit=$((echo "$SUBJECT"; echo; cat "$tmp_msg") | git-commit-tree $tree -p $commit) &&
-		git-update-ref HEAD $commit || exit 4
+		git-update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
 	fi
 done
 rm -rf $tmp_dir || exit 5
-- 
1.4.1.gc48f
