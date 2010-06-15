From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/3] t3508 (cherry-pick): futureproof against unmerged files
Date: Tue, 15 Jun 2010 05:29:49 +0200
Message-ID: <20100615032952.3977.85581.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 05:38:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOMz1-00071h-0a
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 05:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830Ab0FODie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 23:38:34 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:39593 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856Ab0FODid (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 23:38:33 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6530281805A;
	Tue, 15 Jun 2010 05:38:26 +0200 (CEST)
X-git-sha1: b2b0181d696e5fe1286d033259ca08e3e1e9a0bb 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149155>

From: Jonathan Nieder <jrnieder@gmail.com>

Each of the tests in t3508 begins by navigating to a sane state:

	git checkout master &&
	git reset --hard $commit

If a previous test left unmerged files around, they are untouched and
the checkout fails, causing later tests to fail, too.  This is not a
problem in practice because no test except the final one produces
unmerged files.

But as a futureproofing measure, it is still best to avoid the problem
with 'checkout -f'.  In particular, this is needed for new tests to be
added to the end of the script.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t3508-cherry-pick-many-commits.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 3b87efe..26a8730 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -23,7 +23,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'cherry-pick first..fourth works' '
-	git checkout master &&
+	git checkout -f master &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick first..fourth &&
@@ -33,7 +33,7 @@ test_expect_success 'cherry-pick first..fourth works' '
 '
 
 test_expect_success 'cherry-pick --ff first..fourth works' '
-	git checkout master &&
+	git checkout -f master &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick --ff first..fourth &&
@@ -43,7 +43,7 @@ test_expect_success 'cherry-pick --ff first..fourth works' '
 '
 
 test_expect_success 'cherry-pick -n first..fourth works' '
-	git checkout master &&
+	git checkout -f master &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick -n first..fourth &&
@@ -53,7 +53,7 @@ test_expect_success 'cherry-pick -n first..fourth works' '
 '
 
 test_expect_success 'revert first..fourth works' '
-	git checkout master &&
+	git checkout -f master &&
 	git reset --hard fourth &&
 	test_tick &&
 	git revert first..fourth &&
@@ -63,7 +63,7 @@ test_expect_success 'revert first..fourth works' '
 '
 
 test_expect_success 'revert ^first fourth works' '
-	git checkout master &&
+	git checkout -f master &&
 	git reset --hard fourth &&
 	test_tick &&
 	git revert ^first fourth &&
@@ -73,7 +73,7 @@ test_expect_success 'revert ^first fourth works' '
 '
 
 test_expect_success 'revert fourth fourth~1 fourth~2 works' '
-	git checkout master &&
+	git checkout -f master &&
 	git reset --hard fourth &&
 	test_tick &&
 	git revert fourth fourth~1 fourth~2 &&
@@ -83,7 +83,7 @@ test_expect_success 'revert fourth fourth~1 fourth~2 works' '
 '
 
 test_expect_failure 'cherry-pick -3 fourth works' '
-	git checkout master &&
+	git checkout -f master &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick -3 fourth &&
-- 
1.7.1.530.g14dc.dirty
