From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 1/3] t7508: .gitignore 'expect' and 'output' files
Date: Thu,  5 Mar 2015 15:13:02 +0100
Message-ID: <3d26af588ac54fd3060952b140c035f28b1b655b.1425564336.git.git@drmicha.warpmail.net>
References: <xmqqr3t479ey.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 15:13:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTWWd-0008KN-8S
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 15:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990AbbCEONL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 09:13:11 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44007 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755869AbbCEONI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 09:13:08 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 69B902080C
	for <git@vger.kernel.org>; Thu,  5 Mar 2015 09:13:06 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Thu, 05 Mar 2015 09:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references:in-reply-to:references; s=
	smtpout; bh=JkJ5PQ8b3/dJzAkmv7Jo4gBy0/s=; b=d4qQa+Pmn8mpI+kMuAxV
	dfqLPeR278m6yWf20GMEICFcIcxYO58UxoGGZnIIiH3LaBO+keptI4m9e3Ca/LWx
	X/Mn0+o4GIsSxaUp3yHzOz+gVAF2Ks+DLO3xGbIw6Zh35mGWGtNUjMhvZA1i3n8b
	cM3vCZ1qF3Puw9SCtkxG/sE=
X-Sasl-enc: R52bTFu/HVWb5lMhodMAMV1Z0j2WdeREsxnDuYrcEeQy 1425564787
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id F12E0C002A7;
	Thu,  5 Mar 2015 09:13:06 -0500 (EST)
X-Mailer: git-send-email 2.3.1.303.g5174db1
In-Reply-To: <xmqqr3t479ey.fsf@gitster.dls.corp.google.com>
In-Reply-To: <cover.1425564336.git.git@drmicha.warpmail.net>
References: <cover.1425564336.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264837>

From: Junio C Hamano <gitster@pobox.com>

These files are used to observe the behaviour of the 'status'
command and if there weren't any such observer, the expected
output from 'status' wouldn't even mention them.

Place them in .gitignore to unclutter the output expected by the
tests.  An added benefit is that future tests can add such files
that are purely for use by the observer, i.e. the tests themselves,
by naming them as expect-foo and/or output-bar.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7508-status.sh | 78 ++++++++++---------------------------------------------
 1 file changed, 13 insertions(+), 65 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 8ed5788..514df67 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -66,6 +66,12 @@ strip_comments () {
 	rm "$1" && mv "$1".tmp "$1"
 }
 
+cat >.gitignore <<\EOF
+.gitignore
+expect*
+output*
+EOF
+
 test_expect_success 'status --column' '
 	cat >expect <<\EOF &&
 # On branch master
@@ -83,8 +89,8 @@ test_expect_success 'status --column' '
 # Untracked files:
 #   (use "git add <file>..." to include in what will be committed)
 #
-#	dir1/untracked dir2/untracked output
-#	dir2/modified  expect         untracked
+#	dir1/untracked dir2/untracked
+#	dir2/modified  untracked
 #
 EOF
 	COLUMNS=50 git -c status.displayCommentPrefix=true status --column="column dense" >output &&
@@ -116,8 +122,6 @@ cat >expect <<\EOF
 #	dir1/untracked
 #	dir2/modified
 #	dir2/untracked
-#	expect
-#	output
 #	untracked
 #
 EOF
@@ -167,8 +171,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 EOF
@@ -186,8 +188,6 @@ A  dir2/added
 ?? dir1/untracked
 ?? dir2/modified
 ?? dir2/untracked
-?? expect
-?? output
 ?? untracked
 EOF
 
@@ -320,7 +320,11 @@ EOF
 	test_i18ncmp expect output
 '
 
-rm -f .gitignore
+cat >.gitignore <<\EOF
+.gitignore
+expect*
+output*
+EOF
 
 cat >expect <<\EOF
 ## master
@@ -329,8 +333,6 @@ A  dir2/added
 ?? dir1/untracked
 ?? dir2/modified
 ?? dir2/untracked
-?? expect
-?? output
 ?? untracked
 EOF
 
@@ -434,8 +436,6 @@ Untracked files:
 	dir2/modified
 	dir2/untracked
 	dir3/
-	expect
-	output
 	untracked
 
 EOF
@@ -456,8 +456,6 @@ A  dir2/added
 ?? dir2/modified
 ?? dir2/untracked
 ?? dir3/
-?? expect
-?? output
 ?? untracked
 EOF
 test_expect_success 'status -s -unormal' '
@@ -493,8 +491,6 @@ Untracked files:
 	dir2/untracked
 	dir3/untracked1
 	dir3/untracked2
-	expect
-	output
 	untracked
 
 EOF
@@ -518,8 +514,6 @@ A  dir2/added
 ?? dir1/untracked
 ?? dir2/modified
 ?? dir2/untracked
-?? expect
-?? output
 ?? untracked
 EOF
 test_expect_success 'status -s -uall' '
@@ -554,8 +548,6 @@ Untracked files:
 	untracked
 	../dir2/modified
 	../dir2/untracked
-	../expect
-	../output
 	../untracked
 
 EOF
@@ -569,8 +561,6 @@ A  ../dir2/added
 ?? untracked
 ?? ../dir2/modified
 ?? ../dir2/untracked
-?? ../expect
-?? ../output
 ?? ../untracked
 EOF
 test_expect_success 'status -s with relative paths' '
@@ -586,8 +576,6 @@ A  dir2/added
 ?? dir1/untracked
 ?? dir2/modified
 ?? dir2/untracked
-?? expect
-?? output
 ?? untracked
 EOF
 
@@ -625,8 +613,6 @@ Untracked files:
 	<BLUE>dir1/untracked<RESET>
 	<BLUE>dir2/modified<RESET>
 	<BLUE>dir2/untracked<RESET>
-	<BLUE>expect<RESET>
-	<BLUE>output<RESET>
 	<BLUE>untracked<RESET>
 
 EOF
@@ -647,8 +633,6 @@ cat >expect <<\EOF
 <BLUE>??<RESET> dir1/untracked
 <BLUE>??<RESET> dir2/modified
 <BLUE>??<RESET> dir2/untracked
-<BLUE>??<RESET> expect
-<BLUE>??<RESET> output
 <BLUE>??<RESET> untracked
 EOF
 
@@ -676,8 +660,6 @@ cat >expect <<\EOF
 <BLUE>??<RESET> dir1/untracked
 <BLUE>??<RESET> dir2/modified
 <BLUE>??<RESET> dir2/untracked
-<BLUE>??<RESET> expect
-<BLUE>??<RESET> output
 <BLUE>??<RESET> untracked
 EOF
 
@@ -694,8 +676,6 @@ A  dir2/added
 ?? dir1/untracked
 ?? dir2/modified
 ?? dir2/untracked
-?? expect
-?? output
 ?? untracked
 EOF
 
@@ -755,8 +735,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 EOF
@@ -772,8 +750,6 @@ A  dir2/added
 ?? dir1/untracked
 ?? dir2/modified
 ?? dir2/untracked
-?? expect
-?? output
 ?? untracked
 EOF
 
@@ -798,8 +774,6 @@ Untracked files:
 
 	dir1/untracked
 	dir2/
-	expect
-	output
 	untracked
 
 EOF
@@ -848,8 +822,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 EOF
@@ -870,8 +842,6 @@ A  sm
 ?? dir1/untracked
 ?? dir2/modified
 ?? dir2/untracked
-?? expect
-?? output
 ?? untracked
 EOF
 test_expect_success 'status -s submodule summary is disabled by default' '
@@ -913,8 +883,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 EOF
@@ -940,8 +908,6 @@ A  sm
 ?? dir1/untracked
 ?? dir2/modified
 ?? dir2/untracked
-?? expect
-?? output
 ?? untracked
 EOF
 test_expect_success 'status -s submodule summary' '
@@ -964,8 +930,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -983,8 +947,6 @@ cat >expect <<EOF
 ?? dir1/untracked
 ?? dir2/modified
 ?? dir2/untracked
-?? expect
-?? output
 ?? untracked
 EOF
 test_expect_success 'status -s submodule summary (clean submodule)' '
@@ -1025,8 +987,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 EOF
@@ -1080,8 +1040,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 EOF
@@ -1192,8 +1150,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 EOF
@@ -1254,8 +1210,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 EOF
@@ -1336,8 +1290,6 @@ cat > expect << EOF
 ;	dir1/untracked
 ;	dir2/modified
 ;	dir2/untracked
-;	expect
-;	output
 ;	untracked
 ;
 EOF
@@ -1369,8 +1321,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -1400,8 +1350,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 EOF
-- 
2.3.1.303.g5174db1
