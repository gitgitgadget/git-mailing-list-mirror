From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] add "-f" option to git-commit-script to force commit
 withoutchanges
Date: Thu, 28 Jul 2005 16:47:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507281646340.25783@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jul 28 16:50:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dy9gg-0000Ce-KS
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 16:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVG1OsS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 10:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVG1OsL
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 10:48:11 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:54704 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261520AbVG1Orx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 10:47:53 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 8715AE25BE
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:47:49 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 5136EA86B0
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:47:49 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 2A3E8A8678
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:47:49 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 13FDDE25BE
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:47:49 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Sometimes a failed automatic merge means that we do not want those
changes. In this case, it is desirable to commit the current HEAD (as if
actually something was merged).

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 git-commit-script |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

89e6c9495d7877e9922b22d6c87f51c6902b7056
diff --git a/git-commit-script b/git-commit-script
--- a/git-commit-script
+++ b/git-commit-script
@@ -6,12 +6,16 @@
 . git-sh-setup-script || die "Not a git archive"

 usage () {
-	die 'git commit [-m existing-commit] [<path>...]'
+	die 'git commit [-f] [-m existing-commit] [<path>...]'
 }

+force=false
 while case "$#" in 0) break ;; esac
 do
     case "$1" in
+    -f) shift
+        force=true
+        ;;
     -m) shift
         case "$#" in
 	0) usage ;;
@@ -82,7 +86,7 @@ else
 	fi >.editmsg
 	git-status-script >>.editmsg
 fi
-if [ "$?" != "0" ]
+if [ "$?" != "0" -a $force = false ]
 then
 	cat .editmsg
 	rm .editmsg
