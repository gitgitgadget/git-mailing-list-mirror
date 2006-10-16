From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] bisect reset: Leave the tree in usable state if git-checkout failed
Date: Mon, 16 Oct 2006 02:59:25 +0200
Message-ID: <20061016005925.27019.38262.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 02:59:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZGpV-0006MV-7G
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 02:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWJPA71 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 20:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWJPA71
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 20:59:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54938 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750822AbWJPA70 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 20:59:26 -0400
Received: (qmail 27029 invoked from network); 16 Oct 2006 02:59:25 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 16 Oct 2006 02:59:25 +0200
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28938>

I had local modifications in the tree and doing bisect reset required me to
manually edit .git/HEAD.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 git-bisect.sh |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 06a8d26..09cd179 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -179,11 +179,12 @@ bisect_reset() {
         *)
 	    usage ;;
 	esac
-	git checkout "$branch" &&
-	rm -fr "$GIT_DIR/refs/bisect"
-	rm -f "$GIT_DIR/refs/heads/bisect" "$GIT_DIR/head-name"
-	rm -f "$GIT_DIR/BISECT_LOG"
-	rm -f "$GIT_DIR/BISECT_NAMES"
+	if ! git checkout "$branch"; then
+		rm -fr "$GIT_DIR/refs/bisect"
+		rm -f "$GIT_DIR/refs/heads/bisect" "$GIT_DIR/head-name"
+		rm -f "$GIT_DIR/BISECT_LOG"
+		rm -f "$GIT_DIR/BISECT_NAMES"
+	fi
 }
 
 bisect_replay () {
