From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] git-clone: honor --quiet
Date: Mon, 23 Oct 2006 15:59:48 +0200
Message-ID: <87u01v3zfv.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 23 16:00:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc0LK-0006mu-E4
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 15:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWJWN7u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 09:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWJWN7u
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 09:59:50 -0400
Received: from mx.meyering.net ([82.230.74.64]:61878 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S964858AbWJWN7u (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 09:59:50 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id F06E7289B; Mon, 23 Oct 2006 15:59:48 +0200 (CEST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29832>

I noticed that a cron-launched "git-clone --quiet" was generating
progress output to standard error -- and thus always spamming me.
The offending output was due to git-clone invoking git-read-tree with
its undocumented -v option.
This change turns off "-v" for --quiet.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 git-clone.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 786d65a..3f006d1 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -401,7 +401,8 @@ Pull: refs/heads/$head_points_at:$origin
 
 	case "$no_checkout" in
 	'')
-		git-read-tree -m -u -v HEAD HEAD
+		test "z$quiet" = z && v=-v || v=
+		git-read-tree -m -u $v HEAD HEAD
 	esac
 fi
 rm -f "$GIT_DIR/CLONE_HEAD" "$GIT_DIR/REMOTE_HEAD"
-- 
1.4.3.1.g178e-dirty
