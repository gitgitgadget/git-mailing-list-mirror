From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 6/6] Simplify t3412
Date: Tue, 27 Jan 2009 18:49:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901271848440.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901271012550.14855@racer> <20090127085418.e113ad5a.stephen@exigencecorp.com> <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>,
	Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 27 18:50:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRs4h-0000my-Qz
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 18:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407AbZA0Rsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 12:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753305AbZA0Rsq
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 12:48:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:44621 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752786AbZA0Rsp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 12:48:45 -0500
Received: (qmail invoked by alias); 27 Jan 2009 17:48:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 27 Jan 2009 18:48:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+sraRsoVisuQwZGepI9i9UupFSu7/e5rK7DIHWj7
	Is8rhRu90TPokF
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107371>


Use the newly introduced test_commit() and test_merge() helpers.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Thomas, this touches your code.

 t/t3412-rebase-root.sh |   30 +++++++++---------------------
 1 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 6359580..39f7768 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -6,24 +6,16 @@ Tests if git rebase --root --onto <newparent> can rebase the root commit.
 '
 . ./test-lib.sh
 
+. ../lib-rebase.sh
+
 test_expect_success 'prepare repository' '
-	echo 1 > A &&
-	git add A &&
-	git commit -m 1 &&
-	echo 2 > A &&
-	git add A &&
-	git commit -m 2 &&
+	test_commit 1 A &&
+	test_commit 2 A &&
 	git symbolic-ref HEAD refs/heads/other &&
 	rm .git/index &&
-	echo 3 > B &&
-	git add B &&
-	git commit -m 3 &&
-	echo 1 > A &&
-	git add A &&
-	git commit -m 1b &&
-	echo 4 > B &&
-	git add B &&
-	git commit -m 4
+	test_commit 3 B &&
+	test_commit 1b A 1 &&
+	test_commit 4 B
 '
 
 test_expect_success 'rebase --root expects --onto' '
@@ -103,9 +95,7 @@ test_expect_success 'pre-rebase got correct input (5)' '
 test_expect_success 'set up merge history' '
 	git checkout other^ &&
 	git checkout -b side &&
-	echo 5 > C &&
-	git add C &&
-	git commit -m 5 &&
+	test_commit 5 C &&
 	git checkout other &&
 	git merge side
 '
@@ -132,9 +122,7 @@ test_expect_success 'set up second root and merge' '
 	git symbolic-ref HEAD refs/heads/third &&
 	rm .git/index &&
 	rm A B C &&
-	echo 6 > D &&
-	git add D &&
-	git commit -m 6 &&
+	test_commit 6 D &&
 	git checkout other &&
 	git merge third
 '
-- 
1.6.1.482.g7d54be
