From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] repack: honor -d even when no new pack was created
Date: Sun, 7 May 2006 20:18:53 +0200
Message-ID: <20060507181853.GA23738@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 07 20:19:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcnqZ-00041a-Ks
	for gcvg-git@gmane.org; Sun, 07 May 2006 20:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWEGSS5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 14:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWEGSS4
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 14:18:56 -0400
Received: from admingilde.org ([213.95.32.146]:32719 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1750701AbWEGSS4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 14:18:56 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FcnqH-0000pI-Tk
	for git@vger.kernel.org; Sun, 07 May 2006 20:18:53 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19709>

If all objects are reachable via an alternate object store then we
still have to remove all obsolete local packs.

Signed-off-by: Martin Waitz <tali@admingilde.org>

---

 git-repack.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

c37df94d2b1633ce329bbe079805073b40a48548
diff --git a/git-repack.sh b/git-repack.sh
index e0c9f32..4fb3f26 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -48,15 +48,15 @@ name=$(git-rev-list --objects --all $rev
 	exit 1
 if [ -z "$name" ]; then
 	echo Nothing new to pack.
-	exit 0
-fi
-echo "Pack pack-$name created."
+else
+	echo "Pack pack-$name created."
 
-mkdir -p "$PACKDIR" || exit
+	mkdir -p "$PACKDIR" || exit
 
-mv .tmp-pack-$name.pack "$PACKDIR/pack-$name.pack" &&
-mv .tmp-pack-$name.idx  "$PACKDIR/pack-$name.idx" ||
-exit
+	mv .tmp-pack-$name.pack "$PACKDIR/pack-$name.pack" &&
+	mv .tmp-pack-$name.idx  "$PACKDIR/pack-$name.idx" ||
+	exit
+fi
 
 if test "$remove_redundant" = t
 then
-- 
1.3.1.g6ef7
