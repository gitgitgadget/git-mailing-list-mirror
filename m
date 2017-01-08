Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4254A205C9
	for <e@80x24.org>; Sun,  8 Jan 2017 16:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754421AbdAHQzY (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 11:55:24 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:42198
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753032AbdAHQzW (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jan 2017 11:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1483894520;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=U3OrqZKHbaM7f6OgRjJxWo5plcjFM6coqSZZixl5wIU=;
        b=dwI+AEQPG604TOnQXPJV8VqOGCY+pR0+imID0kOi5zz2jXdteyvcG/V2Fl0BJzkl
        QVCxjVL4NCB9OEvyUgdGLwarl+Old3bMpJ6je/WzNI/Go9EyOWhR6lOhEWIe4bAhdez
        y/lz3tiA7GVy8Y8gEGM5e8V5Ut4zubCc8rABPt54=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201597f017978-356bf9e9-ee78-498b-926b-5c00466b1d9e-000000@eu-west-1.amazonses.com>
In-Reply-To: <20170103195708.15157-1-pranit.bauva@gmail.com>
References: <20170103195708.15157-1-pranit.bauva@gmail.com>
Subject: [PATCH v4 1/2] don't use test_must_fail with grep
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sun, 8 Jan 2017 16:55:20 +0000
X-SES-Outgoing: 2017.01.08-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test_must_fail should only be used for testing git commands. To test the
failure of other commands use `!`.

Reported-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t3510-cherry-pick-sequence.sh  |  6 +++---
 t/t5504-fetch-receive-strict.sh  |  2 +-
 t/t5516-fetch-push.sh            |  2 +-
 t/t5601-clone.sh                 |  2 +-
 t/t6030-bisect-porcelain.sh      |  2 +-
 t/t7610-mergetool.sh             |  2 +-
 t/t9001-send-email.sh            |  2 +-
 t/t9117-git-svn-init-clone.sh    | 12 ++++++------
 t/t9813-git-p4-preserve-users.sh |  8 ++++----
 t/t9814-git-p4-rename.sh         |  6 +++---
 10 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 372307c..0acf4b1 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -385,7 +385,7 @@ test_expect_success '--continue respects opts' '
 	git cat-file commit HEAD~1 >picked_msg &&
 	git cat-file commit HEAD~2 >unrelatedpick_msg &&
 	git cat-file commit HEAD~3 >initial_msg &&
-	test_must_fail grep "cherry picked from" initial_msg &&
+	! grep "cherry picked from" initial_msg &&
 	grep "cherry picked from" unrelatedpick_msg &&
 	grep "cherry picked from" picked_msg &&
 	grep "cherry picked from" anotherpick_msg
@@ -426,9 +426,9 @@ test_expect_failure '--signoff is automatically propagated to resolved conflict'
 	git cat-file commit HEAD~1 >picked_msg &&
 	git cat-file commit HEAD~2 >unrelatedpick_msg &&
 	git cat-file commit HEAD~3 >initial_msg &&
-	test_must_fail grep "Signed-off-by:" initial_msg &&
+	! grep "Signed-off-by:" initial_msg &&
 	grep "Signed-off-by:" unrelatedpick_msg &&
-	test_must_fail grep "Signed-off-by:" picked_msg &&
+	! grep "Signed-off-by:" picked_msg &&
 	grep "Signed-off-by:" anotherpick_msg
 '
 
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 9b19cff..49d3621 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -152,7 +152,7 @@ test_expect_success 'push with receive.fsck.missingEmail=warn' '
 	git --git-dir=dst/.git config --add \
 		receive.fsck.badDate warn &&
 	git push --porcelain dst bogus >act 2>&1 &&
-	test_must_fail grep "missingEmail" act
+	! grep "missingEmail" act
 '
 
 test_expect_success \
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 26b2caf..0fc5a7c 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1004,7 +1004,7 @@ test_expect_success 'push --porcelain' '
 test_expect_success 'push --porcelain bad url' '
 	mk_empty testrepo &&
 	test_must_fail git push >.git/bar --porcelain asdfasdfasd refs/heads/master:refs/remotes/origin/master &&
-	test_must_fail grep -q Done .git/bar
+	! grep -q Done .git/bar
 '
 
 test_expect_success 'push --porcelain rejected' '
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index a433394..4241ea5 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -151,7 +151,7 @@ test_expect_success 'clone --mirror does not repeat tags' '
 	git clone --mirror src mirror2 &&
 	(cd mirror2 &&
 	 git show-ref 2> clone.err > clone.out) &&
-	test_must_fail grep Duplicate mirror2/clone.err &&
+	! grep Duplicate mirror2/clone.err &&
 	grep some-tag mirror2/clone.out
 
 '
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 5e5370f..8c2c6ea 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -407,7 +407,7 @@ test_expect_success 'good merge base when good and bad are siblings' '
 	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
 	grep $HASH4 my_bisect_log.txt &&
 	git bisect good > my_bisect_log.txt &&
-	test_must_fail grep "merge base must be tested" my_bisect_log.txt &&
+	! grep "merge base must be tested" my_bisect_log.txt &&
 	grep $HASH6 my_bisect_log.txt &&
 	git bisect reset
 '
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 63d36fb..0fe7e58 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -602,7 +602,7 @@ test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToT
 	test_config mergetool.myecho.trustExitCode true &&
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool myecho -- both >actual &&
-	test_must_fail grep ^\./both_LOCAL_ actual >/dev/null &&
+	! grep ^\./both_LOCAL_ actual >/dev/null &&
 	grep /both_LOCAL_ actual >/dev/null &&
 	git reset --hard master >/dev/null 2>&1
 '
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 3dc4a34..0f398dd 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -50,7 +50,7 @@ test_no_confirm () {
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$@ \
 		$patches >stdout &&
-		test_must_fail grep "Send this email" stdout &&
+		! grep "Send this email" stdout &&
 		>no_confirm_okay
 }
 
diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
index 69a6750..044f65e 100755
--- a/t/t9117-git-svn-init-clone.sh
+++ b/t/t9117-git-svn-init-clone.sh
@@ -55,7 +55,7 @@ test_expect_success 'clone to target directory with --stdlayout' '
 test_expect_success 'init without -s/-T/-b/-t does not warn' '
 	test ! -d trunk &&
 	git svn init "$svnrepo"/project/trunk trunk 2>warning &&
-	test_must_fail grep -q prefix warning &&
+	! grep -q prefix warning &&
 	rm -rf trunk &&
 	rm -f warning
 	'
@@ -63,7 +63,7 @@ test_expect_success 'init without -s/-T/-b/-t does not warn' '
 test_expect_success 'clone without -s/-T/-b/-t does not warn' '
 	test ! -d trunk &&
 	git svn clone "$svnrepo"/project/trunk 2>warning &&
-	test_must_fail grep -q prefix warning &&
+	! grep -q prefix warning &&
 	rm -rf trunk &&
 	rm -f warning
 	'
@@ -86,7 +86,7 @@ EOF
 test_expect_success 'init with -s/-T/-b/-t assumes --prefix=origin/' '
 	test ! -d project &&
 	git svn init -s "$svnrepo"/project project 2>warning &&
-	test_must_fail grep -q prefix warning &&
+	! grep -q prefix warning &&
 	test_svn_configured_prefix "origin/" &&
 	rm -rf project &&
 	rm -f warning
@@ -95,7 +95,7 @@ test_expect_success 'init with -s/-T/-b/-t assumes --prefix=origin/' '
 test_expect_success 'clone with -s/-T/-b/-t assumes --prefix=origin/' '
 	test ! -d project &&
 	git svn clone -s "$svnrepo"/project 2>warning &&
-	test_must_fail grep -q prefix warning &&
+	! grep -q prefix warning &&
 	test_svn_configured_prefix "origin/" &&
 	rm -rf project &&
 	rm -f warning
@@ -104,7 +104,7 @@ test_expect_success 'clone with -s/-T/-b/-t assumes --prefix=origin/' '
 test_expect_success 'init with -s/-T/-b/-t and --prefix "" still works' '
 	test ! -d project &&
 	git svn init -s "$svnrepo"/project project --prefix "" 2>warning &&
-	test_must_fail grep -q prefix warning &&
+	! grep -q prefix warning &&
 	test_svn_configured_prefix "" &&
 	rm -rf project &&
 	rm -f warning
@@ -113,7 +113,7 @@ test_expect_success 'init with -s/-T/-b/-t and --prefix "" still works' '
 test_expect_success 'clone with -s/-T/-b/-t and --prefix "" still works' '
 	test ! -d project &&
 	git svn clone -s "$svnrepo"/project --prefix "" 2>warning &&
-	test_must_fail grep -q prefix warning &&
+	! grep -q prefix warning &&
 	test_svn_configured_prefix "" &&
 	rm -rf project &&
 	rm -f warning
diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
index 0fe2312..76004a5 100755
--- a/t/t9813-git-p4-preserve-users.sh
+++ b/t/t9813-git-p4-preserve-users.sh
@@ -126,13 +126,13 @@ test_expect_success 'not preserving user with mixed authorship' '
 		grep "git author charlie@example.com does not match" &&
 
 		make_change_by_user usernamefile3 alice alice@example.com &&
-		git p4 commit |\
-		test_must_fail grep "git author.*does not match" &&
+		git p4 commit >actual &&
+		! grep "git author.*does not match" actual &&
 
 		git config git-p4.skipUserNameCheck true &&
 		make_change_by_user usernamefile3 Charlie charlie@example.com &&
-		git p4 commit |\
-		test_must_fail grep "git author.*does not match" &&
+		git p4 commit >actual &&
+		! grep "git author.*does not match" actual &&
 
 		p4_check_commit_author usernamefile3 alice
 	)
diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index c89992c..e7e0268 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -141,7 +141,7 @@ test_expect_success 'detect copies' '
 		git diff-tree -r -C HEAD &&
 		git p4 submit &&
 		p4 filelog //depot/file8 &&
-		p4 filelog //depot/file8 | test_must_fail grep -q "branch from" &&
+		! p4 filelog //depot/file8 | grep -q "branch from" &&
 
 		echo "file9" >>file2 &&
 		git commit -a -m "Differentiate file2" &&
@@ -154,7 +154,7 @@ test_expect_success 'detect copies' '
 		git config git-p4.detectCopies true &&
 		git p4 submit &&
 		p4 filelog //depot/file9 &&
-		p4 filelog //depot/file9 | test_must_fail grep -q "branch from" &&
+		! p4 filelog //depot/file9 | grep -q "branch from" &&
 
 		echo "file10" >>file2 &&
 		git commit -a -m "Differentiate file2" &&
@@ -202,7 +202,7 @@ test_expect_success 'detect copies' '
 		git config git-p4.detectCopies $(($level + 2)) &&
 		git p4 submit &&
 		p4 filelog //depot/file12 &&
-		p4 filelog //depot/file12 | test_must_fail grep -q "branch from" &&
+		! p4 filelog //depot/file12 | grep -q "branch from" &&
 
 		echo "file13" >>file2 &&
 		git commit -a -m "Differentiate file2" &&

--
https://github.com/git/git/pull/314
