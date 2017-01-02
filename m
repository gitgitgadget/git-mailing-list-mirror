Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FECB205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 18:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933196AbdABSqM (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 13:46:12 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36609 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933118AbdABSqH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 13:46:07 -0500
Received: by mail-pg0-f65.google.com with SMTP id n5so31113459pgh.3
        for <git@vger.kernel.org>; Mon, 02 Jan 2017 10:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZuNS+JYneFj2VhWsRcJn5yB9pOLnSv/m1nJgDEfvN5g=;
        b=R8SvHJtRbHIO2FFua05em+Njy/HPF2+1gvpIThYBZVRkYImsbLR0PXpUkPF+K7jb6X
         cYeg2EJspsJtpnVGm3lo8BiWtgYFjworV6roabdHdD6AZfm2u6LdrcPy6HgKYO1U9BSK
         FqLgL4/ANzmDqy6CcUL+xINnjKjUBmvafow8l4OC46t88LfPiSdiqJyfvIfPU37tOk7+
         a0WGhvMAV9gn86avbeFAA8top8gj161Lmds0QVijfKqpxtmlq60OKcogQy0i+iNdBULK
         8D9znibvejPUtemix0RBvmY1BtPiF5MyXDwB8WPjbJmPeFsLMNkvgjboUG/mmRj+fYfV
         4jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZuNS+JYneFj2VhWsRcJn5yB9pOLnSv/m1nJgDEfvN5g=;
        b=FTsubDHrSRjNRPq94geybPGwkjf+jFNn/ZtPStmdidRyBITCcihyKj6VjU9mHRvk7o
         VuRl3rc76wzk8hHHm3BIRFVUiOM0lynglqxWEF9JZIuQUhtKHfqL875N3yHdKgzxuh0m
         oA3i0gbyfKpzAmYmbP56YUm5wSTET/MFNmqg7e21GGp9q0UW5b8Oni+0yXyQpHrneoOD
         G7jJ6N2C1N7xkGIzHQitqq85/svk/gheBQ7hb/AdayjcyJLviuBrJwbI8PxtoraEyUwF
         NHKXWdK3J+yhVFYGCjBfv9yzkLtHrowQZdode1im/25vnhGpWcqBEziv3WK6i77hRdUW
         ab6g==
X-Gm-Message-State: AIkVDXIESVP+C9W8W6P0mOvqTdeuLsUH+3gHb5uvmg0Y0u7cgtp/SRmMmKoyaHUcSS3www==
X-Received: by 10.98.195.10 with SMTP id v10mr55104527pfg.158.1483382766694;
        Mon, 02 Jan 2017 10:46:06 -0800 (PST)
Received: from localhost.localdomain ([103.57.70.91])
        by smtp.gmail.com with ESMTPSA id y6sm135020535pge.16.2017.01.02.10.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jan 2017 10:46:06 -0800 (PST)
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, luke@diamond.org, j6t@kdbg.org,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v2 1/2] don't use test_must_fail with grep
Date:   Tue,  3 Jan 2017 00:15:35 +0530
Message-Id: <20170102184536.10488-1-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20161231114412.23439-1-pranit.bauva@gmail.com>
References: <20161231114412.23439-1-pranit.bauva@gmail.com>
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
index 372307c21..0acf4b146 100755
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
index 9b19cff72..49d3621a9 100755
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
index 26b2cafc4..0fc5a7c59 100755
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
index a43339420..4241ea5b3 100755
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
index 5e5370feb..8c2c6eaef 100755
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
index 63d36fb28..0fe7e58cf 100755
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
index 3dc4a3454..0f398dd16 100755
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
index 69a675052..044f65e91 100755
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
index 0fe231280..798bf2b67 100755
--- a/t/t9813-git-p4-preserve-users.sh
+++ b/t/t9813-git-p4-preserve-users.sh
@@ -126,13 +126,13 @@ test_expect_success 'not preserving user with mixed authorship' '
 		grep "git author charlie@example.com does not match" &&
 
 		make_change_by_user usernamefile3 alice alice@example.com &&
-		git p4 commit |\
-		test_must_fail grep "git author.*does not match" &&
+		git p4 commit >actual 2>&1 &&
+		! grep "git author.*does not match" actual &&
 
 		git config git-p4.skipUserNameCheck true &&
 		make_change_by_user usernamefile3 Charlie charlie@example.com &&
-		git p4 commit |\
-		test_must_fail grep "git author.*does not match" &&
+		git p4 commit >actual 2>&1 &&
+		! grep "git author.*does not match" actual &&
 
 		p4_check_commit_author usernamefile3 alice
 	)
diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index c89992cf9..e7e0268e9 100755
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
2.11.0

