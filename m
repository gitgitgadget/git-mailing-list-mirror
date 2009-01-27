From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 6/6] Simplify t3412
Date: Tue, 27 Jan 2009 23:35:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901272334570.3586@pacific.mpi-cbg.de>
References: <7v7i4g31lj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 27 23:36:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRwXk-0002ti-EK
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbZA0Wex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522AbZA0Wew
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:34:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:45387 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752340AbZA0Weu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 17:34:50 -0500
Received: (qmail invoked by alias); 27 Jan 2009 22:34:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 27 Jan 2009 23:34:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19tbfx+PMZtKd+1ZOL1j5i1+bniCjQIsrxWzLALMq
	7whHFA93lFJm7s
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v7i4g31lj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107402>

Use the newly introduced test_commit() and test_merge() helpers.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3412-rebase-root.sh |   28 +++++++---------------------
 1 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 3d8ff67..9fc528f 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -7,23 +7,13 @@ Tests if git rebase --root --onto <newparent> can rebase the root commit.
 . ./test-lib.sh
 
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
@@ -103,9 +93,7 @@ test_expect_success 'pre-rebase got correct input (5)' '
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
@@ -132,9 +120,7 @@ test_expect_success 'set up second root and merge' '
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
