From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Use git-update-ref and git-symbolic-ref in tests
Date: Tue, 11 Oct 2005 16:02:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510111601460.27536@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Oct 11 16:10:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPKlI-0007Px-CL
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 16:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVJKOFq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 10:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbVJKOFp
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 10:05:45 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:53458 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932080AbVJKOFp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 10:05:45 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2017C13EBDF; Tue, 11 Oct 2005 16:05:44 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0D0C49EC7D; Tue, 11 Oct 2005 16:05:44 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E9C279EE22; Tue, 11 Oct 2005 16:02:39 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CB30C13F06D; Tue, 11 Oct 2005 16:02:39 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9965>

This makes all tests pass on cygwin.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 t/t5000-tar-tree.sh             |    6 +++---
 t/t6001-rev-list-merge-order.sh |    2 +-
 t/t6002-rev-list-bisect.sh      |    2 +-
 t/t6003-rev-list-topo-order.sh  |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

applies-to: c6ce0dfdf028e37ae907628a56895afc14d6d7a0
f86f79547964a7e9d23535c4971d757117800aa2
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 5dffb8e..4db1bb1 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -41,8 +41,8 @@ test_expect_success \
      find a -type l | xargs git-update-index --add &&
      treeid=`git-write-tree` &&
      echo $treeid >treeid &&
-     TZ=GMT GIT_COMMITTER_DATE="2005-05-27 22:00:00" \
-     git-commit-tree $treeid </dev/null >.git/HEAD'
+     git-update-ref HEAD $(TZ=GMT GIT_COMMITTER_DATE="2005-05-27 22:00:00" \
+     git-commit-tree $treeid </dev/null)'
 
 test_expect_success \
     'git-tar-tree' \
@@ -59,7 +59,7 @@ test_expect_success \
 test_expect_success \
     'git-get-tar-commit-id' \
     'git-get-tar-commit-id <b.tar >b.commitid &&
-     diff .git/HEAD b.commitid'
+     diff .git/$(git-symbolic-ref HEAD) b.commitid'
 
 test_expect_success \
     'extract tar archive' \
diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
index 0101242..8ec9ebb 100755
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -108,7 +108,7 @@ save_tag h2 unique_commit g4 tree -p g2
 save_tag g3 unique_commit g5 tree -p g2
 save_tag g4 unique_commit g6 tree -p g3 -p h2
 
-tag l5 > .git/HEAD
+git-update-ref HEAD $(tag l5)
 
 test_expect_success 'rev-list has correct number of entries' 'git-rev-list HEAD | wc -l | tr -s " "' <<EOF
 19
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index 42fcbc6..693de9b 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -58,7 +58,7 @@ on_committer_date "1971-08-16 00:00:15" 
 on_committer_date "1971-08-16 00:00:16" save_tag l3 unique_commit l3 tree -p a4
 on_committer_date "1971-08-16 00:00:17" save_tag l4 unique_commit l4 tree -p l3
 on_committer_date "1971-08-16 00:00:18" save_tag l5 unique_commit l5 tree -p l4
-tag l5 > .git/HEAD
+git-update-ref HEAD $(tag l5)
 
 
 #     E
diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-order.sh
index 88d14ee..3c4c44c 100755
--- a/t/t6003-rev-list-topo-order.sh
+++ b/t/t6003-rev-list-topo-order.sh
@@ -77,7 +77,7 @@ save_tag h2 unique_commit g4 tree -p g2
 save_tag g3 unique_commit g5 tree -p g2
 save_tag g4 unique_commit g6 tree -p g3 -p h2
 
-tag l5 > .git/HEAD
+git-update-ref HEAD $(tag l5)
 
 test_expect_success 'rev-list has correct number of entries' 'git-rev-list HEAD | wc -l | tr -s " "' <<EOF
 19
---
0.99.8.GIT
