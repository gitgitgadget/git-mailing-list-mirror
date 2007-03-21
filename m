From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Wed, 21 Mar 2007 14:06:43 +0200
Message-ID: <20070321120643.GI20583@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Mar 21 13:06:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTzZz-0004Ob-TL
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 13:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbXCUMGG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 08:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbXCUMGF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 08:06:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:9572 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbXCUMGC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 08:06:02 -0400
Received: by ug-out-1314.google.com with SMTP id 44so280220uga
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 05:06:01 -0700 (PDT)
Received: by 10.66.252.4 with SMTP id z4mr2987427ugh.1174478761016;
        Wed, 21 Mar 2007 05:06:01 -0700 (PDT)
Received: from ?127.0.0.1? ( [194.90.237.34])
        by mx.google.com with ESMTP id q40sm1797416ugc.2007.03.21.05.05.59;
        Wed, 21 Mar 2007 05:06:00 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42788>

Hi!
I often like to fetch some code from others, review and
then merge. So:

git fetch <URL>
git log -p FETCH_HEAD
git merge FETCH_HEAD

which is all good but gets me this message in commit log:

    Merge commit 'FETCH_HEAD' into master

which is not very informative.
I can always fix this up with git commit --amend, but
I'd like to avoid the extra step.

Would the following patch be appropriate?

Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>

---

diff --git a/git-merge.sh b/git-merge.sh
index 8759c5a..629611b 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -108,6 +108,10 @@ merge_name () {
 		git-show-ref -q --verify "refs/heads/$truname" 2>/dev/null
 	then
 		echo "$rh		branch '$truname' (early part) of ."
+	elif test -r "$GIT_DIR/$remote"
+	then
+		echo -n "$rh		"
+		grep -v not-for-merge "$GIT_DIR/$remote"
 	else
 		echo "$rh		commit '$remote'"
 	fi
