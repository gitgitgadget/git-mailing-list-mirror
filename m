From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH-fix] fetch/pull: short-hand notation for remote repositories.
Date: Sat, 16 Jul 2005 09:47:10 -0700
Message-ID: <7vek9yn1f5.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vbr55kgq2.fsf@assigned-by-dhcp.cox.net>
	<7vzmsots7t.fsf@assigned-by-dhcp.cox.net>
	<7voe93rbmu.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507151529590.19183@g5.osdl.org>
	<7virzbnruf.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 16 18:50:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtpr0-0001SF-AA
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 18:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVGPQtE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 12:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVGPQtE
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 12:49:04 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:39328 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261711AbVGPQrM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 12:47:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050716164711.WUIQ1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Jul 2005 12:47:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7virzbnruf.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat, 16 Jul 2005 00:16:24 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The logic to decide when to store fetched head/tag under
$GIT_DIR/refs/, and http transport were broken in the previous
round. 

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** I see you have already merged my broken one; sorry.

*** Anything written under the influence should be tested as twice
*** as hard than usual before being sent --- Don't drink and
*** develop ;-).  *Blush*

cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-diff 8:10
# - 4: Documentation: describe short-hand used in fetch/pull.
# + 6: git-fetch-script: fix thinko in http fetch.
diff --git a/git-fetch-script b/git-fetch-script
--- a/git-fetch-script
+++ b/git-fetch-script
@@ -12,7 +12,7 @@ case "$merge_repo" in
 http://*)
 	head=$(wget -q -O - "$merge_repo/$merge_head") || exit 1
 	echo Fetching "$merge_head" using http
-	git-http-pull -v -a "$merge_head" "$merge_repo/"
+	git-http-pull -v -a "$head" "$merge_repo/"
 	;;
 rsync://*)
 	rsync -L "$merge_repo/$merge_head" "$TMP_HEAD" || exit 1
@@ -27,10 +27,10 @@ esac || exit 1
 
 git-rev-parse --verify "$head" > /dev/null || exit 1
 
-case "$merge_store" in
-'')
+if test "$merge_store"
+then
 	echo "$head" > "$GIT_DIR/$merge_store"
-esac &&
+fi &&
 
 # FETCH_HEAD is fed to git-resolve-script which will eventually be
 # passed to git-commit-tree as one of the parents.  Make sure we do

Compilation finished at Sat Jul 16 09:37:07
