From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 13/13] contrib/subtree: Remove --annotate
Date: Mon,  4 Feb 2013 22:06:13 -0600
Message-ID: <1360037173-23291-14-git-send-email-greened@obbligato.org>
References: <1360037173-23291-1-git-send-email-greened@obbligato.org>
Cc: "David A. Greene" <greened@obbligato.org>
To: James Nylen <jnylen@gmail.com>, git@vger.kernel.org,
	Techlive Zheng <techlivezheng@gmail.com>,
	Wayne Walter <wayne@tickzoom.com>,
	"Avery Pennarun \"" <apenwarr@gmail.com>,
	Jakub Suder <jakub.suder@gmail.com>,
	John Yani <vanuan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 05:37:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2aI9-0001tY-PI
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 05:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985Ab3BEEhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 23:37:35 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:38055 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753882Ab3BEEhe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 23:37:34 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1U2Zq8-0003ZD-Rk; Mon, 04 Feb 2013 22:09:02 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1360037173-23291-1-git-send-email-greened@obbligato.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215453>

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
index 0493e47..888a191 100755
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
index 1afd544..59889f1 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -318,8 +318,8 @@ test_expect_success 'split subdir/ with --rejoin' '
 		cd "$test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		split_hash=$(git subtree split --prefix=subdir --annotate="*") &&
-		git subtree split --prefix=subdir --annotate="*" --rejoin &&
+		split_hash=$(git subtree split --prefix=subdir) &&
+		git subtree split --prefix=subdir --rejoin &&
 		test_equal "$(last_commit_message)" "Split '\''subdir/'\'' into commit '\''$split_hash'\''"
 	)
  '
@@ -342,7 +342,7 @@ test_expect_success 'split subdir/ with --rejoin and --message' '
 		cd "$test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		git subtree split --prefix=subdir --message="Split & rejoin" --annotate="*" --rejoin &&
+		git subtree split --prefix=subdir --message="Split & rejoin" --rejoin &&
 		test_equal "$(last_commit_message)" "Split & rejoin"
 	)
 '
@@ -365,8 +365,8 @@ test_expect_success 'split subdir/ with --branch' '
 		cd "$test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		split_hash=$(git subtree split --prefix=subdir --annotate="*") &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br &&
+		split_hash=$(git subtree split --prefix=subdir) &&
+		git subtree split --prefix=subdir --branch subproj-br &&
 		test_equal "$(git rev-parse subproj-br)" "$split_hash"
 	)
  '
@@ -390,8 +390,8 @@ test_expect_success 'split subdir/ with --branch for an existing branch' '
 		cd "$test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		split_hash=$(git subtree split --prefix=subdir --annotate="*") &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br &&
+		split_hash=$(git subtree split --prefix=subdir) &&
+		git subtree split --prefix=subdir --branch subproj-br &&
 		test_equal "$(git rev-parse subproj-br)" "$split_hash"
 	)
 '
@@ -441,7 +441,7 @@ test_expect_success 'make sure exactly the right set of files ends up in the sub
 		cd "$test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$test_count/subproj" sub3 &&
 	test_create_commit "$test_count" subdir/main-sub3 &&
@@ -452,12 +452,12 @@ test_expect_success 'make sure exactly the right set of files ends up in the sub
 	test_create_commit "$test_count/subproj" sub4 &&
 	(
 		cd "$test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$test_count" subdir/main-sub4 &&
 	(
 		cd "$test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	(
 		cd "$test_count/subproj" &&
@@ -491,7 +491,7 @@ test_expect_success 'make sure the subproj *only* contains commits that affect t
 		cd "$test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$test_count/subproj" sub3 &&
 	test_create_commit "$test_count" subdir/main-sub3 &&
@@ -502,12 +502,12 @@ test_expect_success 'make sure the subproj *only* contains commits that affect t
 	test_create_commit "$test_count/subproj" sub4 &&
 	(
 		cd "$test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$test_count" subdir/main-sub4 &&
 	(
 		cd "$test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	(
 		cd "$test_count/subproj" &&
@@ -541,7 +541,7 @@ test_expect_success 'make sure exactly the right set of files ends up in the mai
 		cd "$test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$test_count/subproj" sub3 &&
 	test_create_commit "$test_count" subdir/main-sub3 &&
@@ -552,12 +552,12 @@ test_expect_success 'make sure exactly the right set of files ends up in the mai
 	test_create_commit "$test_count/subproj" sub4 &&
 	(
 		cd "$test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$test_count" subdir/main-sub4 &&
 	(
 		cd "$test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	(
 		cd "$test_count/subproj" &&
@@ -595,7 +595,7 @@ test_expect_success 'make sure each filename changed exactly once in the entire
 		cd "$test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$test_count/subproj" sub3 &&
 	test_create_commit "$test_count" subdir/main-sub3 &&
@@ -606,12 +606,12 @@ test_expect_success 'make sure each filename changed exactly once in the entire
 	test_create_commit "$test_count/subproj" sub4 &&
 	(
 		cd "$test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$test_count" subdir/main-sub4 &&
 	(
 		cd "$test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	(
 		cd "$test_count/subproj" &&
@@ -653,7 +653,7 @@ test_expect_success 'make sure the --rejoin commits never make it into subproj'
 		cd "$test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$test_count/subproj" sub3 &&
 	test_create_commit "$test_count" subdir/main-sub3 &&
@@ -664,12 +664,12 @@ test_expect_success 'make sure the --rejoin commits never make it into subproj'
 	test_create_commit "$test_count/subproj" sub4 &&
 	(
 		cd "$test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$test_count" subdir/main-sub4 &&
 	(
 		cd "$test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	(
 		cd "$test_count/subproj" &&
@@ -701,7 +701,7 @@ test_expect_success 'make sure no "git subtree" tagged commits make it into subp
 		cd "$test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$test_count/subproj" sub3 &&
 	test_create_commit "$test_count" subdir/main-sub3 &&
@@ -712,12 +712,12 @@ test_expect_success 'make sure no "git subtree" tagged commits make it into subp
 	test_create_commit "$test_count/subproj" sub4 &&
 	(
 		cd "$test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$test_count" subdir/main-sub4 &&
 	(
 		cd "$test_count" &&
-		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix=subdir --branch subproj-br --rejoin
 	) &&
 	(
 		cd "$test_count/subproj" &&
-- 
1.7.10.4
