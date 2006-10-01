From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Use git-update-ref to delete a tag instead of rm()ing the
 ref file.
Date: Sun, 1 Oct 2006 22:16:22 +0200
Message-ID: <20061001221622.0f68b471.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 22:10:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU7dn-00011W-9v
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 22:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWJAUKQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 16:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWJAUKP
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 16:10:15 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:52153 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S932233AbWJAUKO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 16:10:14 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with SMTP id 3D5AC5497C;
	Sun,  1 Oct 2006 22:10:13 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28198>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-tag.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-tag.sh b/git-tag.sh
index 2bde3c0..6463b31 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -47,8 +47,10 @@ do
     -d)
     	shift
 	tag_name="$1"
-	rm "$GIT_DIR/refs/tags/$tag_name" && \
-	        echo "Deleted tag $tag_name."
+	tag=$(git-show-ref --verify --hash -- "refs/tags/$tag_name") ||
+		die "Seriously, what tag are you talking about?"
+	git-update-ref -m 'tag: delete' -d "refs/tags/$tag_name" "$tag" &&
+		echo "Deleted tag $tag_name."
 	exit $?
 	;;
     -*)
-- 
1.4.2.1.g8a7b-dirty
