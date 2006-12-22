From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Suggest 'add' in am/revert/cherry-pick.
Date: Thu, 21 Dec 2006 21:30:17 -0500
Message-ID: <20061222023017.GA15136@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 03:30:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxaB0-0005SW-CG
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 03:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945916AbWLVCaW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 21:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945917AbWLVCaW
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 21:30:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:32961 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945916AbWLVCaW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 21:30:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GxaAi-0007Qm-KC; Thu, 21 Dec 2006 21:30:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BA58D20FB65; Thu, 21 Dec 2006 21:30:17 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35121>

Now that we have decided to make 'add' behave like 'update-index'
(and therefore fully classify update-index as strictly plumbing)
the am/revert/cherry-pick family of commands should not steer the
user towards update-index.  Instead send them to the command they
probably already know, 'add'.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-am.sh     |    4 ++--
 git-revert.sh |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 5df6787..0126a77 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -401,14 +401,14 @@ do
 		changed="$(git-diff-index --cached --name-only HEAD)"
 		if test '' = "$changed"
 		then
-			echo "No changes - did you forget update-index?"
+			echo "No changes - did you forget to use 'git add'?"
 			stop_here_user_resolve $this
 		fi
 		unmerged=$(git-ls-files -u)
 		if test -n "$unmerged"
 		then
 			echo "You still have unmerged paths in your index"
-			echo "did you forget update-index?"
+			echo "did you forget to use 'git add'?"
 			stop_here_user_resolve $this
 		fi
 		apply_status=0
diff --git a/git-revert.sh b/git-revert.sh
index 6eab3c7..50cc47b 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -155,7 +155,7 @@ Conflicts:
 		uniq
 	    } >>"$GIT_DIR/MERGE_MSG"
 	    echo >&2 "Automatic $me failed.  After resolving the conflicts,"
-	    echo >&2 "mark the corrected paths with 'git-update-index <paths>'"
+	    echo >&2 "mark the corrected paths with 'git-add <paths>'"
 	    echo >&2 "and commit the result."
 	    case "$me" in
 	    cherry-pick)
-- 
1.4.4.3.g87d8
