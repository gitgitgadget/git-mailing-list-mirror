From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: [PATCHv2] put FETCH_HEAD data in merge commit message
Date: Wed, 21 Mar 2007 19:29:16 +0200
Message-ID: <20070321172916.GC5233@mellanox.co.il>
References: <20070321120643.GI20583@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Mar 21 18:29:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU4c8-00035S-2j
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 18:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933200AbXCUR2l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 13:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933215AbXCUR2l
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 13:28:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:52812 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933200AbXCUR2k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 13:28:40 -0400
Received: by ug-out-1314.google.com with SMTP id 44so403350uga
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 10:28:34 -0700 (PDT)
Received: by 10.67.22.7 with SMTP id z7mr3402099ugi.1174498113979;
        Wed, 21 Mar 2007 10:28:33 -0700 (PDT)
Received: from ?127.0.0.1? ( [89.138.180.55])
        by mx.google.com with ESMTP id 59sm2099743ugf.2007.03.21.10.28.32;
        Wed, 21 Mar 2007 10:28:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070321120643.GI20583@mellanox.co.il>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42808>

> Quoting Michael S. Tsirkin <mst@dev.mellanox.co.il>:
> Subject: [PATCH] have merge put FETCH_HEAD data in commit message
> 
> Hi!
> I often like to fetch some code from others, review and
> then merge. So:
> 
> git fetch <URL>
> git log -p FETCH_HEAD
> git merge FETCH_HEAD
> 
> which is all good but gets me this message in commit log:
> 
>     Merge commit 'FETCH_HEAD' into master
> 
> which is not very informative.
> I can always fix this up with git commit --amend, but
> I'd like to avoid the extra step.
> 
> Would the following patch be appropriate?

OK, I since discovered git-fmt-merge-msg does all the necessary formatting,
so here's a better and smaller patch. Seems to work well for me.

Junio, could you apply this?

-------------------------

Make git-fetch <URL> && git-merge FETCH_HEAD produce same merge message
as git-pull <URL>

Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>

---

diff --git a/git-merge.sh b/git-merge.sh
index 8759c5a..1e11593 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -108,6 +108,9 @@ merge_name () {
 		git-show-ref -q --verify "refs/heads/$truname" 2>/dev/null
 	then
 		echo "$rh		branch '$truname' (early part) of ."
+	elif test -r "$GIT_DIR/$remote"
+	then
+		cat "$GIT_DIR/$remote"
 	else
 		echo "$rh		commit '$remote'"
 	fi
-- 
MST
