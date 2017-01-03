Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C72C1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 19:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752744AbdACT5a (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 14:57:30 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36460 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965822AbdACT52 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 14:57:28 -0500
Received: by mail-pg0-f67.google.com with SMTP id n5so34476022pgh.3
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 11:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZuNS+JYneFj2VhWsRcJn5yB9pOLnSv/m1nJgDEfvN5g=;
        b=mjvCN5sCqvV+y4sZTabgDaJ3tx0uA90S3DdH7/okemL6PtsA2QjeVzBkDMRpI+5phd
         6YC7qzau7ajPCLfvjPBJf2xsdVqvCpVCU9aoOmjygQCFRCUz/NbNclYy/kP6WGJbq94O
         Ee5yMUG5n4r62RiqhO+s19pDm2ZrezmIsZCBkRl0CPjj/X9J71X/b/PqQeaXi5S6nFUt
         RlDXLRJDD/LhunBchRP7xN945bIUrn212ySxkrbtCC7WQyGgHtSGsZfH81DiD2dt6Bsi
         7+mdpenSjFq6Psg+8lbLK5uGyp5GizPPGCn37Pv1hhay3/A7X2MsIrKFICr4jkC24ny/
         8XyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZuNS+JYneFj2VhWsRcJn5yB9pOLnSv/m1nJgDEfvN5g=;
        b=Bok9qaA9owEsFgeUQOMYtKWP/Z3AbBtaXJVlRzuPQa+g2n8XhsST4ZeVd0hXvHrFW9
         gmIhzB7g8Mx3Rp5knF6X40uU/5UbeF2WrBtqeYyLWfZ0MAxwBvjHGCoqUNzfy7hUPlse
         /3aAYLjaTXQdZtme0pjYfNkiHsNfQ84J5nBooU4/S3JjRK0mMdRsXvtH5e08eSgJP+1X
         HK1aHcsdngESfb+CYDDVSX8OppVdLgNAhS4qdo0YKvKCu/ncbn+p/2JMEmzp3l4SzK6t
         Rd1N05OJCFB9B7Knp1WcUDZMH0b/xEkmo+/NcpIvXDtd/5MiQlRtf1ijebk9rkoxeAys
         1r7g==
X-Gm-Message-State: AIkVDXLufqeK7xXWzZxq3iQ82wH8KaZUq++2m24jp82t/Mk8otEDtGIFmh3MOjJIhHd0uQ==
X-Received: by 10.98.11.198 with SMTP id 67mr58617747pfl.90.1483473447840;
        Tue, 03 Jan 2017 11:57:27 -0800 (PST)
Received: from localhost.localdomain ([103.57.70.69])
        by smtp.gmail.com with ESMTPSA id d1sm141708387pfb.76.2017.01.03.11.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 11:57:26 -0800 (PST)
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Cc:     luke@diamand.org, sbeller@google.com, j6t@kdbg.org,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v3 1/2] don't use test_must_fail with grep
Date:   Wed,  4 Jan 2017 01:27:07 +0530
Message-Id: <20170103195708.15157-1-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170102184536.10488-1-pranit.bauva@gmail.com>
References: <20170102184536.10488-1-pranit.bauva@gmail.com>
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

