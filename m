From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 7/8] contrib/subtree: Remove --annotate
Date: Mon, 18 Feb 2013 14:56:52 -0600
Message-ID: <1361221013-12756-8-git-send-email-greened@obbligato.org>
References: <1361221013-12756-1-git-send-email-greened@obbligato.org>
Cc: "David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org, Techlive Zheng <techlivezheng@gmail.com>,
	James Nylen <jnylen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:58:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7XnS-0005b4-5j
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 21:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755795Ab3BRU6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 15:58:13 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:45292 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755131Ab3BRU6K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 15:58:10 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1U7Xok-0000E4-Er; Mon, 18 Feb 2013 15:00:07 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1361221013-12756-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -2.9 (--)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: "David A. Greene" <greened@obbligato.org> Remove --annotate.
    This obviates the need for an --unannotate command. We really want a more
    generalized commit message rewrite mechanism. Signed-off-by: David A. Greene
    <greened@obbligato.org> --- contrib/subtree/git-subtree.sh | 6 +---- contrib/subtree/t/t7900-subtree.sh
    | 50 ++++++++++++++++++ 2 files changed, 26 insertions(+), 30 deletions(-)
    [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- -------------------- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216528>

From: "David A. Greene" <greened@obbligato.org>

Remove --annotate.  This obviates the need for an --unannotate
command.  We really want a more generalized commit message rewrite
mechanism.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/git-subtree.sh     |    6 +----
 contrib/subtree/t/t7900-subtree.sh |   50 ++++++++++++++++++------------------
 2 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 1b3df99..2aceadc 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -21,7 +21,6 @@ d             show debug messages
 P,prefix=     the name of the subdir to split out
 m,message=    use the given message as the commit message for the merge commit
  options for 'split'
-annotate=     add a prefix to commit message of new commits
 b,branch=     create a new branch from the split subtree
 ignore-joins  ignore prior --rejoin commits
 onto=         try connecting new tree to an existing one
@@ -43,7 +42,6 @@ command=
 onto=
 rejoin=
 ignore_joins=
-annotate=
 squash=
 message=
 
@@ -79,8 +77,6 @@ while [ $# -gt 0 ]; do
 	case "$opt" in
 		-q) quiet=1 ;;
 		-d) debug=1 ;;
-		--annotate) annotate="$1"; shift ;;
-		--no-annotate) annotate= ;;
 		-b) branch="$1"; shift ;;
 		-P) prefix="${1%/}"; shift ;;
 		-m) message="$1"; shift ;;
@@ -311,7 +307,7 @@ copy_commit()
 			GIT_COMMITTER_NAME \
 			GIT_COMMITTER_EMAIL \
 			GIT_COMMITTER_DATE
-		(echo -n "$annotate"; cat ) |
+		(echo -n ""; cat ) |
 		git commit-tree "$2" $3  # reads the rest of stdin
 	) || die "Can't copy commit $1"
 }
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 5c6c73d..fa2a6c3 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -338,8 +338,8 @@ test_expect_success 'split subdir/ with --rejoin' '
 		cd "$subtree_test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		split_hash=$(git subtree split --prefix=subdir --annotate="*") &&
-		git subtree split --prefix=subdir --annotate="*" --rejoin &&
+		split_hash=$(git subtree split --prefix=subdir) &&
+		git subtree split --prefix=subdir --rejoin &&
 		test_equal "$(last_commit_message)" "Split '\''subdir/'\'' into commit '\''$split_hash'\''"
 	)
  '
@@ -363,7 +363,7 @@ test_expect_success 'split subdir/ with --rejoin and --message' '
 		cd "$subtree_test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		git subtree split --prefix=subdir --message="Split & rejoin" --annotate="*" --rejoin &&
+		git subtree split --prefix=subdir --message="Split & rejoin" --rejoin &&
 		test_equal "$(last_commit_message)" "Split & rejoin"
 	)
 '
@@ -387,8 +387,8 @@ test_expect_success 'split subdir/ with --branch' '
 		cd "$subtree_test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		split_hash=$(git subtree split --prefix=subdir --annotate="*") &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br &&
+		split_hash=$(git subtree split --prefix=subdir) &&
+		git subtree split --prefix=subdir --branch subproj-br &&
 		test_equal "$(git rev-parse subproj-br)" "$split_hash"
 	)
  '
@@ -413,8 +413,8 @@ test_expect_success 'split subdir/ with --branch for an existing branch' '
 		cd "$subtree_test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		split_hash=$(git subtree split --prefix=subdir --annotate="*") &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br &&
+		split_hash=$(git subtree split --prefix=subdir) &&
+		git subtree split --prefix=subdir --branch subproj-br &&
 		test_equal "$(git rev-parse subproj-br)" "$split_hash"
 	)
 '
@@ -466,7 +466,7 @@ test_expect_success 'make sure exactly the right set of files ends up in the sub
 		cd "$subtree_test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count/subproj" sub3 &&
 	test_create_commit "$subtree_test_count" subdir/main-sub3 &&
@@ -477,12 +477,12 @@ test_expect_success 'make sure exactly the right set of files ends up in the sub
 	test_create_commit "$subtree_test_count/subproj" sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count" subdir/main-sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	(
 		cd "$subtree_test_count/subproj" &&
@@ -517,7 +517,7 @@ test_expect_success 'make sure the subproj *only* contains commits that affect t
 		cd "$subtree_test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count/subproj" sub3 &&
 	test_create_commit "$subtree_test_count" subdir/main-sub3 &&
@@ -528,12 +528,12 @@ test_expect_success 'make sure the subproj *only* contains commits that affect t
 	test_create_commit "$subtree_test_count/subproj" sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count" subdir/main-sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	(
 		cd "$subtree_test_count/subproj" &&
@@ -568,7 +568,7 @@ test_expect_success 'make sure exactly the right set of files ends up in the mai
 		cd "$subtree_test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count/subproj" sub3 &&
 	test_create_commit "$subtree_test_count" subdir/main-sub3 &&
@@ -579,12 +579,12 @@ test_expect_success 'make sure exactly the right set of files ends up in the mai
 	test_create_commit "$subtree_test_count/subproj" sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count" subdir/main-sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	(
 		cd "$subtree_test_count/subproj" &&
@@ -623,7 +623,7 @@ test_expect_success 'make sure each filename changed exactly once in the entire
 		cd "$subtree_test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count/subproj" sub3 &&
 	test_create_commit "$subtree_test_count" subdir/main-sub3 &&
@@ -634,12 +634,12 @@ test_expect_success 'make sure each filename changed exactly once in the entire
 	test_create_commit "$subtree_test_count/subproj" sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count" subdir/main-sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	(
 		cd "$subtree_test_count/subproj" &&
@@ -682,7 +682,7 @@ test_expect_success 'make sure the --rejoin commits never make it into subproj'
 		cd "$subtree_test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count/subproj" sub3 &&
 	test_create_commit "$subtree_test_count" subdir/main-sub3 &&
@@ -693,12 +693,12 @@ test_expect_success 'make sure the --rejoin commits never make it into subproj'
 	test_create_commit "$subtree_test_count/subproj" sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count" subdir/main-sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	(
 		cd "$subtree_test_count/subproj" &&
@@ -731,7 +731,7 @@ test_expect_success 'make sure no "git subtree" tagged commits make it into subp
 		cd "$subtree_test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count/subproj" sub3 &&
 	test_create_commit "$subtree_test_count" subdir/main-sub3 &&
@@ -742,12 +742,12 @@ test_expect_success 'make sure no "git subtree" tagged commits make it into subp
 	test_create_commit "$subtree_test_count/subproj" sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count" subdir/main-sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	(
 		cd "$subtree_test_count/subproj" &&
-- 
1.7.10.4
