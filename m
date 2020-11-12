Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C4CC64E7C
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 170BA22241
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+E6j6ya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgKLWoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgKLWoR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:17 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB0FC0617A7
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:16 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 33so7679921wrl.7
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yXV1vhSKc0Jr4mgK1pJvhDUE6Gf+3aB8fHE/eLwFEsQ=;
        b=p+E6j6yalr4wlxBkiVWD8Z/moCsGlQsUitUFyPc2UQ9vmXacBqpOawkph3MqNDwvqo
         9JcyPzNz6O2LifPPfXehu/XsM9RqlJPYrPPClaP5GrEU3fA+5h+KpcG9hiF1YzoQFbDZ
         56nA/iS8wchOEEN7/XJ67GZLaCyZmY3iPfCJAh/sKA7nMUogiNAwUZhkeyCVVG0+ZNo1
         KfTUujEgMETHvNd9mvuY7QVOSAHNDqn815gJ77KjkoC5ZfXZZ3eSyCrmOjVhLeNnIK1H
         9thXQlZ45pf5JpbB76gsLwk+bYyEghqTtCErb+f9fTzaZi0JXkwQyytGz3oTyZkn/Pks
         3ptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yXV1vhSKc0Jr4mgK1pJvhDUE6Gf+3aB8fHE/eLwFEsQ=;
        b=sDEunciEqxSNrl29exw0aPqPUjXU66enh2YsIeTSLxb3zXmMeJa4elHosszi1FDtS5
         RYT2KqAA5vY/jsi2/j40Z96djybV3BJBUxGCQpGA8Bkk5D+wS+xT+7afqx8jabNWYGhD
         LVO80c+0RUqZeaf4e4MnMLFEZpRRYdPzprEbdpKposGGjbciN5byMGLoy1Qsm0vt1rsE
         XRUmkSavv6VjTn3ClLRLzwDf2aQH6A6ByBEvx8p01dGD+wUELEdCpJPNTuM1uldHJdlp
         qwZ8yRusXnyZCdVVCaMyrn6mixlLGBJSzrJF/hnbiNpVqiw8DurNQVBEKv2zMLZRj1GC
         yHbg==
X-Gm-Message-State: AOAM533Yu7vO9Rn92AEnTo+ePM46qLeZDyqqQw+lgRFLIp3wyK9CQ/Vh
        BFQu6eSCUMTle4bwia/V83em1l2pF8I=
X-Google-Smtp-Source: ABdhPJyPOvaua9kM8Md7zlKkfTvviwv2rCI4SeAVBGh1DastW8Om5w3/62nkDmo6ZS2h/cwg4fVCrA==
X-Received: by 2002:adf:ef48:: with SMTP id c8mr2090283wrp.399.1605221054400;
        Thu, 12 Nov 2020 14:44:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14sm3634014wrw.4.2020.11.12.14.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:13 -0800 (PST)
Message-Id: <dc8011e4bfec33ebbb9953ee45c4c2efd40ddae7.1605221039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:47 +0000
Subject: [PATCH 17/28] t6[0-3]*: adjust the references to the default branch
 name "main"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Carefully excluding t6300, which sees independent development elsewhere
at the time of writing, we use `main` as the default branch name in
t6[0-3]*. This trick was performed via

	$ (cd t &&
	   sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
		-e 's/Master/Main/g' -- t6[0-3]*.sh &&
	   git checkout HEAD -- t6300\*)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6000-rev-list-misc.sh                   |  2 +-
 t/t6001-rev-list-graft.sh                  |  2 +-
 t/t6004-rev-list-path-optim.sh             | 14 +++---
 t/t6006-rev-list-format.sh                 | 14 +++---
 t/t6007-rev-list-cherry-pick-file.sh       |  4 +-
 t/t6008-rev-list-submodule.sh              |  2 +-
 t/t6009-rev-list-parent.sh                 |  6 +--
 t/t6012-rev-list-simplify.sh               |  8 ++--
 t/t6013-rev-list-reverse-parents.sh        | 10 ++--
 t/t6016-rev-list-graph-simplify-history.sh |  2 +-
 t/t6017-rev-list-stdin.sh                  |  8 ++--
 t/t6018-rev-list-glob.sh                   | 50 ++++++++++----------
 t/t6019-rev-list-ancestry-path.sh          |  6 +--
 t/t6030-bisect-porcelain.sh                | 10 ++--
 t/t6040-tracking-info.sh                   | 54 +++++++++++-----------
 t/t6050-replace.sh                         | 10 ++--
 t/t6101-rev-parse-parents.sh               |  2 +-
 t/t6110-rev-list-sparse.sh                 |  2 +-
 t/t6111-rev-list-treesame.sh               |  6 +--
 t/t6112-rev-list-filters-objects.sh        | 14 +++---
 t/t6120-describe.sh                        | 20 ++++----
 t/t6200-fmt-merge-msg.sh                   | 50 ++++++++++----------
 t/t6302-for-each-ref-filter.sh             | 46 +++++++++---------
 t/test-lib.sh                              |  4 +-
 24 files changed, 173 insertions(+), 173 deletions(-)

diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index fc4d55dcb2..dc40a39fce 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -85,7 +85,7 @@ test_expect_success 'propagate uninteresting flag down correctly' '
 '
 
 test_expect_success 'symleft flag bit is propagated down from tag' '
-	git log --format="%m %s" --left-right v1.0...master >actual &&
+	git log --format="%m %s" --left-right v1.0...main >actual &&
 	cat >expect <<-\EOF &&
 	< another
 	< that
diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index 7504ba4751..4490981352 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -20,7 +20,7 @@ test_expect_success setup '
 	git commit -a -m "Third in one history." &&
 	A2=$(git rev-parse --verify HEAD) &&
 
-	rm -f .git/refs/heads/master .git/index &&
+	rm -f .git/refs/heads/main .git/index &&
 
 	echo >fileA fileA again &&
 	echo >subdir/fileB fileB again &&
diff --git a/t/t6004-rev-list-path-optim.sh b/t/t6004-rev-list-path-optim.sh
index 3e8c42ee0b..81d1b57ced 100755
--- a/t/t6004-rev-list-path-optim.sh
+++ b/t/t6004-rev-list-path-optim.sh
@@ -4,7 +4,7 @@ test_description='git rev-list trivial path optimization test
 
    d/z1
    b0                             b1
-   o------------------------*----o master
+   o------------------------*----o main
   /                        /
  o---------o----o----o----o side
  a0        c0   c1   a1   c2
@@ -55,18 +55,18 @@ test_expect_success 'further setup' '
 	git add c &&
 	test_tick &&
 	git commit -m "Side makes yet another irrelevant commit" &&
-	git checkout master &&
+	git checkout main &&
 	echo Another >b &&
 	echo Munged >d/z &&
 	git add b d/z &&
 	test_tick &&
-	git commit -m "Master touches b" &&
-	git tag master_b0 &&
+	git commit -m "Main touches b" &&
+	git tag main_b0 &&
 	git merge side &&
 	echo Touched >b &&
 	git add b &&
 	test_tick &&
-	git commit -m "Master touches b again"
+	git commit -m "Main touches b again"
 '
 
 test_expect_success 'path optimization 2' '
@@ -76,13 +76,13 @@ test_expect_success 'path optimization 2' '
 '
 
 test_expect_success 'pathspec with leading path' '
-	git rev-parse master^ master_b0 side_c0 initial >expected &&
+	git rev-parse main^ main_b0 side_c0 initial >expected &&
 	git rev-list HEAD -- d >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'pathspec with glob (1)' '
-	git rev-parse master^ master_b0 side_c0 initial >expected &&
+	git rev-parse main^ main_b0 side_c0 initial >expected &&
 	git rev-list HEAD -- "d/*" >actual &&
 	test_cmp expected actual
 '
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 99a1eaf332..8cc54a5a50 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -53,7 +53,7 @@ test_expect_success 'setup' '
 test_format () {
 	cat >expect.$1
 	test_expect_${3:-success} "format $1" "
-		git rev-list --pretty=format:'$2' master >output.$1 &&
+		git rev-list --pretty=format:'$2' main >output.$1 &&
 		test_cmp expect.$1 output.$1
 	"
 }
@@ -184,13 +184,13 @@ test_expect_success 'basic colors' '
 	<RED>foo<GREEN>bar<BLUE>baz<RESET>xyzzy
 	EOF
 	format="%Credfoo%Cgreenbar%Cbluebaz%Cresetxyzzy" &&
-	git rev-list --color --format="$format" -1 master >actual.raw &&
+	git rev-list --color --format="$format" -1 main >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '%S is not a placeholder for rev-list yet' '
-	git rev-list --format="%S" -1 master | grep "%S"
+	git rev-list --format="%S" -1 main | grep "%S"
 '
 
 test_expect_success 'advanced colors' '
@@ -199,7 +199,7 @@ test_expect_success 'advanced colors' '
 	<BOLD;RED;BYELLOW>foo<RESET>
 	EOF
 	format="%C(red yellow bold)foo%C(reset)" &&
-	git rev-list --color --format="$format" -1 master >actual.raw &&
+	git rev-list --color --format="$format" -1 main >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expect actual
 '
@@ -406,7 +406,7 @@ test_expect_success '%x00 shows NUL' '
 
 test_expect_success '%ad respects --date=' '
 	echo 2005-04-07 >expect.ad-short &&
-	git log -1 --date=short --pretty=tformat:%ad >output.ad-short master &&
+	git log -1 --date=short --pretty=tformat:%ad >output.ad-short main &&
 	test_cmp expect.ad-short output.ad-short
 '
 
@@ -494,8 +494,8 @@ test_expect_success '"%h %gD: %gs" is same as git-reflog (with --abbrev)' '
 '
 
 test_expect_success '%gd shortens ref name' '
-	echo "master@{0}" >expect.gd-short &&
-	git log -g -1 --format=%gd refs/heads/master >actual.gd-short &&
+	echo "main@{0}" >expect.gd-short &&
+	git log -g -1 --format=%gd refs/heads/main >actual.gd-short &&
 	test_cmp expect.gd-short actual.gd-short
 '
 
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index f0268372d2..e689959593 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -31,7 +31,7 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m "E" &&
 	git tag E &&
-	git checkout master &&
+	git checkout main &&
 	git checkout branch foo &&
 	test_tick &&
 	git commit -m "B" &&
@@ -233,7 +233,7 @@ test_expect_success '--cherry-pick with independent, but identical branches' '
 	test_tick &&
 	git commit -m "independent, too" foo &&
 	test -z "$(git rev-list --left-right --cherry-pick \
-		HEAD...master -- foo)"
+		HEAD...main -- foo)"
 '
 
 cat >expect <<EOF
diff --git a/t/t6008-rev-list-submodule.sh b/t/t6008-rev-list-submodule.sh
index c4af9ca0a7..39762aa6ff 100755
--- a/t/t6008-rev-list-submodule.sh
+++ b/t/t6008-rev-list-submodule.sh
@@ -36,7 +36,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success "Ilari's test" '
-	git rev-list --objects super master ^super^
+	git rev-list --objects super main ^super^
 '
 
 test_done
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index 916d9692bc..7dedceb472 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -45,7 +45,7 @@ test_expect_success 'setup roots, merges and octopuses' '
 	test_commit seven &&
 	git checkout -b yetanotherbranch four &&
 	test_commit eight &&
-	git checkout master &&
+	git checkout main &&
 	test_tick &&
 	git merge --allow-unrelated-histories -m normalmerge newroot &&
 	git tag normalmerge &&
@@ -56,7 +56,7 @@ test_expect_success 'setup roots, merges and octopuses' '
 	test_tick &&
 	git merge -m tetrapus sidebranch anotherbranch yetanotherbranch &&
 	git tag tetrapus &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'rev-list roots' '
@@ -123,7 +123,7 @@ test_expect_success 'dodecapus' '
 		roots="$roots root$i" ||
 		return
 	done &&
-	git checkout master &&
+	git checkout main &&
 	test_tick &&
 	git merge -m dodecapus $roots &&
 	git tag dodecapus &&
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index fd202fcb94..1b5f54a3f5 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -43,7 +43,7 @@ test_expect_success setup '
 	git add side &&
 	test_tick && git commit -m "Side root" &&
 	note J &&
-	git checkout master &&
+	git checkout main &&
 
 	echo "Hello" >file &&
 	echo "second" >lost &&
@@ -65,7 +65,7 @@ test_expect_success setup '
 	note D &&
 
 	test_tick &&
-	test_must_fail git merge -m "merge" master &&
+	test_must_fail git merge -m "merge" main &&
 	>lost && git commit -a -m "merge" &&
 	note E &&
 
@@ -74,7 +74,7 @@ test_expect_success setup '
 	test_tick && git commit -m "Irrelevant change" &&
 	note F &&
 
-	git checkout master &&
+	git checkout main &&
 	echo "Yet another" >elif &&
 	git add elif &&
 	test_tick && git commit -m "Another irrelevant change" &&
@@ -87,7 +87,7 @@ test_expect_success setup '
 	test_tick && git commit -a -m "Final change" &&
 	note I &&
 
-	git checkout master &&
+	git checkout main &&
 	test_tick && git merge --allow-unrelated-histories -m "Coolest" unrelated &&
 	note K &&
 
diff --git a/t/t6013-rev-list-reverse-parents.sh b/t/t6013-rev-list-reverse-parents.sh
index 89458d370f..e6caf80d7e 100755
--- a/t/t6013-rev-list-reverse-parents.sh
+++ b/t/t6013-rev-list-reverse-parents.sh
@@ -18,24 +18,24 @@ test_expect_success 'set up --reverse example' '
 	commit two &&
 	git checkout -b side HEAD^ &&
 	commit three &&
-	git checkout master &&
+	git checkout main &&
 	git merge -s ours side &&
 	commit five
 	'
 
 test_expect_success '--reverse --parents --full-history combines correctly' '
-	git rev-list --parents --full-history master -- foo |
+	git rev-list --parents --full-history main -- foo |
 		perl -e "print reverse <>" > expected &&
-	git rev-list --reverse --parents --full-history master -- foo \
+	git rev-list --reverse --parents --full-history main -- foo \
 		> actual &&
 	test_cmp expected actual
 	'
 
 test_expect_success '--boundary does too' '
-	git rev-list --boundary --parents --full-history master ^root -- foo |
+	git rev-list --boundary --parents --full-history main ^root -- foo |
 		perl -e "print reverse <>" > expected &&
 	git rev-list --boundary --reverse --parents --full-history \
-		master ^root -- foo > actual &&
+		main ^root -- foo > actual &&
 	test_cmp expected actual
 	'
 
diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
index f5e6e92f5b..c341e6ecb4 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -14,7 +14,7 @@ test_expect_success 'set up rev-list --graph test' '
 	test_commit A1 foo.txt &&
 	test_commit A2 bar.txt &&
 	test_commit A3 bar.txt &&
-	git branch -m master A &&
+	git branch -m main A &&
 
 	# 2 commits on branch B, started from A1
 	git checkout -b B A1 &&
diff --git a/t/t6017-rev-list-stdin.sh b/t/t6017-rev-list-stdin.sh
index 667b37564e..6b72f100cb 100755
--- a/t/t6017-rev-list-stdin.sh
+++ b/t/t6017-rev-list-stdin.sh
@@ -40,7 +40,7 @@ test_expect_success setup '
 		done &&
 		for i in $them
 		do
-			git checkout -b side-$i master~$i &&
+			git checkout -b side-$i main~$i &&
 			echo updated $i >file-$i &&
 			git add file-$i &&
 			test_tick &&
@@ -49,7 +49,7 @@ test_expect_success setup '
 	)
 '
 
-check master
+check main
 check side-1 ^side-4
 check side-1 ^side-7 --
 check side-1 ^side-7 -- file-1
@@ -66,11 +66,11 @@ test_expect_success 'not only --stdin' '
 	file-2
 	EOF
 	cat >input <<-EOF &&
-	^master^
+	^main^
 	--
 	file-2
 	EOF
-	git log --pretty=tformat:%s --name-only --stdin master -- file-1 \
+	git log --pretty=tformat:%s --name-only --stdin main -- file-1 \
 		<input >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index fe2f3cec3d..ac030b9a7c 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -20,22 +20,22 @@ compare () {
 
 test_expect_success 'setup' '
 
-	commit master &&
-	git checkout -b subspace/one master &&
+	commit main &&
+	git checkout -b subspace/one main &&
 	commit one &&
-	git checkout -b subspace/two master &&
+	git checkout -b subspace/two main &&
 	commit two &&
-	git checkout -b subspace-x master &&
+	git checkout -b subspace-x main &&
 	commit subspace-x &&
-	git checkout -b other/three master &&
+	git checkout -b other/three main &&
 	commit three &&
-	git checkout -b someref master &&
+	git checkout -b someref main &&
 	commit some &&
-	git checkout master &&
+	git checkout main &&
 	commit topic_2 &&
-	git tag foo/bar master &&
+	git tag foo/bar main &&
 	commit topic_3 &&
-	git update-ref refs/remotes/foo/baz master &&
+	git update-ref refs/remotes/foo/baz main &&
 	commit topic_4 &&
 	git update-ref refs/remotes/upstream/one subspace/one &&
 	git update-ref refs/remotes/upstream/two subspace/two &&
@@ -83,7 +83,7 @@ test_expect_failure 'rev-parse accepts --glob as detached option' '
 
 test_expect_failure 'rev-parse is not confused by option-like glob' '
 
-	compare rev-parse "master" "--glob --symbolic master"
+	compare rev-parse "main" "--glob --symbolic main"
 
 '
 
@@ -111,15 +111,15 @@ test_expect_success 'rev-parse --glob=heads/subspace/* --glob=heads/other/*' '
 
 '
 
-test_expect_success 'rev-parse --glob=heads/someref/* master' '
+test_expect_success 'rev-parse --glob=heads/someref/* main' '
 
-	compare rev-parse "master" "--glob=heads/someref/* master"
+	compare rev-parse "main" "--glob=heads/someref/* main"
 
 '
 
 test_expect_success 'rev-parse --glob=heads/*' '
 
-	compare rev-parse "master other/three someref subspace-x subspace/one subspace/two" "--glob=heads/*"
+	compare rev-parse "main other/three someref subspace-x subspace/one subspace/two" "--glob=heads/*"
 
 '
 
@@ -136,7 +136,7 @@ test_expect_success 'rev-parse --remotes=foo' '
 '
 
 test_expect_success 'rev-parse --exclude with --branches' '
-	compare rev-parse "--exclude=*/* --branches" "master someref subspace-x"
+	compare rev-parse "--exclude=*/* --branches" "main someref subspace-x"
 '
 
 test_expect_success 'rev-parse --exclude with --all' '
@@ -221,7 +221,7 @@ test_expect_success 'rev-list --glob refs/heads/subspace/*' '
 
 test_expect_success 'rev-list not confused by option-like --glob arg' '
 
-	compare rev-list "master" "--glob -0 master"
+	compare rev-list "main" "--glob -0 main"
 
 '
 
@@ -269,13 +269,13 @@ test_expect_success 'rev-list --branches=subspace' '
 
 test_expect_success 'rev-list --branches' '
 
-	compare rev-list "master subspace-x someref other/three subspace/one subspace/two" "--branches"
+	compare rev-list "main subspace-x someref other/three subspace/one subspace/two" "--branches"
 
 '
 
-test_expect_success 'rev-list --glob=heads/someref/* master' '
+test_expect_success 'rev-list --glob=heads/someref/* main' '
 
-	compare rev-list "master" "--glob=heads/someref/* master"
+	compare rev-list "main" "--glob=heads/someref/* main"
 
 '
 
@@ -287,7 +287,7 @@ test_expect_success 'rev-list --glob=heads/subspace/* --glob=heads/other/*' '
 
 test_expect_success 'rev-list --glob=heads/*' '
 
-	compare rev-list "master other/three someref subspace-x subspace/one subspace/two" "--glob=heads/*"
+	compare rev-list "main other/three someref subspace-x subspace/one subspace/two" "--glob=heads/*"
 
 '
 
@@ -310,7 +310,7 @@ test_expect_success 'rev-list --remotes=foo' '
 '
 
 test_expect_success 'rev-list --exclude with --branches' '
-	compare rev-list "--exclude=*/* --branches" "master someref subspace-x"
+	compare rev-list "--exclude=*/* --branches" "main someref subspace-x"
 '
 
 test_expect_success 'rev-list --exclude with --all' '
@@ -354,13 +354,13 @@ test_expect_success 'shortlog accepts --glob/--tags/--remotes' '
 
 	compare shortlog "subspace/one subspace/two" --branches=subspace &&
 	compare shortlog \
-	  "master subspace-x someref other/three subspace/one subspace/two" \
+	  "main subspace-x someref other/three subspace/one subspace/two" \
 	  --branches &&
-	compare shortlog master "--glob=heads/someref/* master" &&
+	compare shortlog main "--glob=heads/someref/* main" &&
 	compare shortlog "subspace/one subspace/two other/three" \
 	  "--glob=heads/subspace/* --glob=heads/other/*" &&
 	compare shortlog \
-	  "master other/three someref subspace-x subspace/one subspace/two" \
+	  "main other/three someref subspace-x subspace/one subspace/two" \
 	  "--glob=heads/*" &&
 	compare shortlog foo/bar --tags=foo &&
 	compare shortlog "foo/bar qux/one qux/two qux/x" --tags &&
@@ -371,14 +371,14 @@ test_expect_success 'shortlog accepts --glob/--tags/--remotes' '
 test_expect_failure 'shortlog accepts --glob as detached option' '
 
 	compare shortlog \
-	  "master other/three someref subspace-x subspace/one subspace/two" \
+	  "main other/three someref subspace-x subspace/one subspace/two" \
 	  "--glob heads/*"
 
 '
 
 test_expect_failure 'shortlog --glob is not confused by option-like argument' '
 
-	compare shortlog master "--glob -e master"
+	compare shortlog main "--glob -e main"
 
 '
 
diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index 353f84313f..c664d66773 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -128,15 +128,15 @@ test_expect_success 'setup criss-cross' '
 	(cd criss-cross &&
 	 git init &&
 	 test_commit A &&
-	 git checkout -b xb master &&
+	 git checkout -b xb main &&
 	 test_commit B &&
-	 git checkout -b xc master &&
+	 git checkout -b xc main &&
 	 test_commit C &&
 	 git checkout -b xbc xb -- &&
 	 git merge xc &&
 	 git checkout -b xcb xc -- &&
 	 git merge xb &&
-	 git checkout master)
+	 git checkout main)
 '
 
 # no commits in bc descend from cb
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index aa226381be..386841f7b7 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -89,9 +89,9 @@ test_expect_success 'bisect start without -- takes unknown arg as pathspec' '
 	grep bar ".git/BISECT_NAMES"
 '
 
-test_expect_success 'bisect reset: back in the master branch' '
+test_expect_success 'bisect reset: back in the main branch' '
 	git bisect reset &&
-	echo "* master" > branch.expect &&
+	echo "* main" > branch.expect &&
 	git branch > branch.output &&
 	cmp branch.expect branch.output
 '
@@ -102,7 +102,7 @@ test_expect_success 'bisect reset: back in another branch' '
 	git bisect good $HASH1 &&
 	git bisect bad $HASH3 &&
 	git bisect reset &&
-	echo "  master" > branch.expect &&
+	echo "  main" > branch.expect &&
 	echo "* other" >> branch.expect &&
 	git branch > branch.output &&
 	cmp branch.expect branch.output
@@ -348,7 +348,7 @@ test_expect_success 'bisect skip many ranges' '
 
 test_expect_success 'bisect starting with a detached HEAD' '
 	git bisect reset &&
-	git checkout master^ &&
+	git checkout main^ &&
 	HEAD=$(git rev-parse --verify HEAD) &&
 	git bisect start &&
 	test $HEAD = $(cat .git/BISECT_START) &&
@@ -716,7 +716,7 @@ test_expect_success 'bisect: --no-checkout - target after breakage' '
 test_expect_success 'bisect: demonstrate identification of damage boundary' "
 	git bisect reset &&
 	git checkout broken &&
-	git bisect start broken master --no-checkout &&
+	git bisect start broken main --no-checkout &&
 	test_must_fail git bisect run \"\$SHELL_PATH\" -c '
 		GOOD=\$(git for-each-ref \"--format=%(objectname)\" refs/bisect/good-*) &&
 		git rev-list --objects BISECT_HEAD --not \$GOOD >tmp.\$\$ &&
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 50a934e1b2..8ad1390511 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -34,7 +34,7 @@ test_expect_success setup '
 		git branch -d brokenbase &&
 		git checkout -b b6 origin
 	) &&
-	git checkout -b follower --track master &&
+	git checkout -b follower --track main &&
 	advance h
 '
 
@@ -58,12 +58,12 @@ test_expect_success 'branch -v' '
 '
 
 cat >expect <<\EOF
-b1 [origin/master: ahead 1, behind 1] d
-b2 [origin/master: ahead 1, behind 1] d
-b3 [origin/master: behind 1] b
-b4 [origin/master: ahead 2] f
+b1 [origin/main: ahead 1, behind 1] d
+b2 [origin/main: ahead 1, behind 1] d
+b3 [origin/main: behind 1] b
+b4 [origin/main: ahead 2] f
 b5 [brokenbase: gone] g
-b6 [origin/master] c
+b6 [origin/main] c
 EOF
 
 test_expect_success 'branch -vv' '
@@ -83,7 +83,7 @@ test_expect_success 'checkout (diverged from upstream)' '
 '
 
 test_expect_success 'checkout with local tracked branch' '
-	git checkout master &&
+	git checkout main &&
 	git checkout follower >actual &&
 	test_i18ngrep "is ahead of" actual
 '
@@ -100,7 +100,7 @@ test_expect_success 'checkout (up-to-date with upstream)' '
 	(
 		cd test && git checkout b6
 	) >actual &&
-	test_i18ngrep "Your branch is up to date with .origin/master" actual
+	test_i18ngrep "Your branch is up to date with .origin/main" actual
 '
 
 test_expect_success 'status (diverged from upstream)' '
@@ -130,11 +130,11 @@ test_expect_success 'status (up-to-date with upstream)' '
 		# reports nothing to commit
 		test_must_fail git commit --dry-run
 	) >actual &&
-	test_i18ngrep "Your branch is up to date with .origin/master" actual
+	test_i18ngrep "Your branch is up to date with .origin/main" actual
 '
 
 cat >expect <<\EOF
-## b1...origin/master [ahead 1, behind 1]
+## b1...origin/main [ahead 1, behind 1]
 EOF
 
 test_expect_success 'status -s -b (diverged from upstream)' '
@@ -147,7 +147,7 @@ test_expect_success 'status -s -b (diverged from upstream)' '
 '
 
 cat >expect <<\EOF
-## b1...origin/master [different]
+## b1...origin/main [different]
 EOF
 
 test_expect_success 'status -s -b --no-ahead-behind (diverged from upstream)' '
@@ -160,7 +160,7 @@ test_expect_success 'status -s -b --no-ahead-behind (diverged from upstream)' '
 '
 
 cat >expect <<\EOF
-## b1...origin/master [different]
+## b1...origin/main [different]
 EOF
 
 test_expect_success 'status.aheadbehind=false status -s -b (diverged from upstream)' '
@@ -174,7 +174,7 @@ test_expect_success 'status.aheadbehind=false status -s -b (diverged from upstre
 
 cat >expect <<\EOF
 On branch b1
-Your branch and 'origin/master' have diverged,
+Your branch and 'origin/main' have diverged,
 and have 1 and 1 different commits each, respectively.
 EOF
 
@@ -198,7 +198,7 @@ test_expect_success 'status --long --branch' '
 
 cat >expect <<\EOF
 On branch b1
-Your branch and 'origin/master' refer to different commits.
+Your branch and 'origin/main' refer to different commits.
 EOF
 
 test_expect_success 'status --long --branch --no-ahead-behind' '
@@ -233,7 +233,7 @@ test_expect_success 'status -s -b (upstream is gone)' '
 '
 
 cat >expect <<\EOF
-## b6...origin/master
+## b6...origin/main
 EOF
 
 test_expect_success 'status -s -b (up-to-date with upstream)' '
@@ -246,7 +246,7 @@ test_expect_success 'status -s -b (up-to-date with upstream)' '
 '
 
 test_expect_success 'fail to track lightweight tags' '
-	git checkout master &&
+	git checkout main &&
 	git tag light &&
 	test_must_fail git branch --track lighttrack light >actual &&
 	test_i18ngrep ! "set up to track" actual &&
@@ -254,7 +254,7 @@ test_expect_success 'fail to track lightweight tags' '
 '
 
 test_expect_success 'fail to track annotated tags' '
-	git checkout master &&
+	git checkout main &&
 	git tag -m heavy heavy &&
 	test_must_fail git branch --track heavytrack heavy >actual &&
 	test_i18ngrep ! "set up to track" actual &&
@@ -262,17 +262,17 @@ test_expect_success 'fail to track annotated tags' '
 '
 
 test_expect_success '--set-upstream-to does not change branch' '
-	git branch from-master master &&
-	git branch --set-upstream-to master from-master &&
-	git branch from-topic_2 master &&
+	git branch from-main main &&
+	git branch --set-upstream-to main from-main &&
+	git branch from-topic_2 main &&
 	test_must_fail git config branch.from-topic_2.merge > actual &&
 	git rev-list from-topic_2 &&
 	git update-ref refs/heads/from-topic_2 from-topic_2^ &&
 	git rev-parse from-topic_2 >expect2 &&
-	git branch --set-upstream-to master from-topic_2 &&
-	git config branch.from-master.merge > actual &&
+	git branch --set-upstream-to main from-topic_2 &&
+	git config branch.from-main.merge > actual &&
 	git rev-parse from-topic_2 >actual2 &&
-	grep -q "^refs/heads/master$" actual &&
+	grep -q "^refs/heads/main$" actual &&
 	cmp expect2 actual2
 '
 
@@ -280,11 +280,11 @@ test_expect_success '--set-upstream-to @{-1}' '
 	git checkout follower &&
 	git checkout from-topic_2 &&
 	git config branch.from-topic_2.merge > expect2 &&
-	git branch --set-upstream-to @{-1} from-master &&
-	git config branch.from-master.merge > actual &&
+	git branch --set-upstream-to @{-1} from-main &&
+	git config branch.from-main.merge > actual &&
 	git config branch.from-topic_2.merge > actual2 &&
-	git branch --set-upstream-to follower from-master &&
-	git config branch.from-master.merge > expect &&
+	git branch --set-upstream-to follower from-main &&
+	git config branch.from-main.merge > expect &&
 	test_cmp expect2 actual2 &&
 	test_cmp expect actual
 '
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c80dc10b8f..56cf4ceb90 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -133,9 +133,9 @@ test_expect_success 'tag replaced commit' '
 '
 
 test_expect_success '"git fsck" works' '
-     git fsck master >fsck_master.out &&
-     test_i18ngrep "dangling commit $R" fsck_master.out &&
-     test_i18ngrep "dangling tag $(git show-ref -s refs/tags/mytag)" fsck_master.out &&
+     git fsck main >fsck_main.out &&
+     test_i18ngrep "dangling commit $R" fsck_main.out &&
+     test_i18ngrep "dangling tag $(git show-ref -s refs/tags/mytag)" fsck_main.out &&
      test -z "$(git fsck)"
 '
 
@@ -218,7 +218,7 @@ test_expect_success 'create parallel branch without the bug' '
      git cherry-pick $HASH6 &&
      PARA6=$(git rev-parse --verify HEAD) &&
      git replace $HASH6 $PARA6 &&
-     git checkout master &&
+     git checkout main &&
      cur=$(git rev-parse --verify HEAD) &&
      test "$cur" = "$HASH7" &&
      git log --pretty=oneline | grep $PARA2 &&
@@ -461,7 +461,7 @@ test_expect_success GPG 'set up a merge commit with a mergetag' '
 	git commit -m "hello: 2 more lines from a test branch" &&
 	HASH9=$(git rev-parse --verify HEAD) &&
 	git tag -s -m "tag for testing with a mergetag" test_tag HEAD &&
-	git checkout master &&
+	git checkout main &&
 	git merge -s ours test_tag &&
 	HASH10=$(git rev-parse --verify HEAD) &&
 	git cat-file commit $HASH10 | grep "^mergetag object"
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 7531262a5e..288a75c02b 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -18,7 +18,7 @@ test_expect_success 'setup' '
 	test_commit second &&
 	git checkout --orphan tmp &&
 	test_commit start2 &&
-	git checkout master &&
+	git checkout main &&
 	git merge -m next --allow-unrelated-histories start2 &&
 	test_commit final &&
 
diff --git a/t/t6110-rev-list-sparse.sh b/t/t6110-rev-list-sparse.sh
index 656ac7fe9d..093536fd85 100755
--- a/t/t6110-rev-list-sparse.sh
+++ b/t/t6110-rev-list-sparse.sh
@@ -10,7 +10,7 @@ test_expect_success setup '
 	git checkout -b side HEAD^ &&
 	test_commit D &&
 	test_commit E &&
-	git merge master
+	git merge main
 '
 
 test_expect_success 'rev-list --first-parent --boundary' '
diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index 4244638285..90c8630e34 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -33,13 +33,13 @@ test_expect_success setup '
 	git checkout other-branch &&
 	test_commit "Added other" other "Hello" C &&
 
-	git checkout master &&
+	git checkout main &&
 	test_merge D other-branch &&
 
 	git checkout third-branch &&
 	test_commit "Third file" third "Nothing" E &&
 
-	git checkout master &&
+	git checkout main &&
 	test_commit "file=Blah" file "Blah" F &&
 
 	test_tick && git merge --no-commit third-branch &&
@@ -56,7 +56,7 @@ test_expect_success setup '
 
 	test_tick && git revert I && note J &&
 
-	git checkout master &&
+	git checkout main &&
 	test_tick && git merge --no-ff fiddler-branch &&
 	note K &&
 
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index de0e5a5d36..c6729320ea 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -223,7 +223,7 @@ test_expect_success 'verify sparse:oid=oid-ish omits top-level files' '
 	sort >expected &&
 
 	git -C r3 rev-list --quiet --objects --filter-print-omitted \
-		--filter=sparse:oid=master:pattern HEAD >revs &&
+		--filter=sparse:oid=main:pattern HEAD >revs &&
 	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
@@ -436,7 +436,7 @@ test_expect_success 'add sparse pattern blobs whose paths have reserved chars' '
 
 test_expect_success 'combine:... with more than two sub-filters' '
 	git -C r3 rev-list --objects \
-		--filter=combine:tree:3+blob:limit=40+sparse:oid=master:pattern \
+		--filter=combine:tree:3+blob:limit=40+sparse:oid=main:pattern \
 		HEAD >actual &&
 
 	expect_has HEAD "" &&
@@ -454,7 +454,7 @@ test_expect_success 'combine:... with more than two sub-filters' '
 	cp actual expect &&
 
 	git -C r3 rev-list --objects \
-		--filter=combine:tree:3+blob:limit=40+sparse:oid=master:pattern1%2brenamed%25 \
+		--filter=combine:tree:3+blob:limit=40+sparse:oid=main:pattern1%2brenamed%25 \
 		HEAD >actual &&
 	test_cmp expect actual &&
 
@@ -464,23 +464,23 @@ test_expect_success 'combine:... with more than two sub-filters' '
 	test_when_finished "rm -f trace1" &&
 	GIT_TRACE=$(pwd)/trace1 git -C r3 rev-list --objects \
 		--filter=tree:3 --filter=blob:limit=40 \
-		--filter=sparse:oid="master:p;at%ter+n" \
+		--filter=sparse:oid="main:p;at%ter+n" \
 		HEAD >actual &&
 
 	test_cmp expect actual &&
-	grep "Add to combine filter-spec: sparse:oid=master:p%3bat%25ter%2bn" \
+	grep "Add to combine filter-spec: sparse:oid=main:p%3bat%25ter%2bn" \
 		trace1 &&
 
 	# Repeat the above test, but this time, the characters to encode are in
 	# the LHS of the combined filter.
 	test_when_finished "rm -f trace2" &&
 	GIT_TRACE=$(pwd)/trace2 git -C r3 rev-list --objects \
-		--filter=sparse:oid=master:^~pattern \
+		--filter=sparse:oid=main:^~pattern \
 		--filter=tree:3 --filter=blob:limit=40 \
 		HEAD >actual &&
 
 	test_cmp expect actual &&
-	grep "Add to combine filter-spec: sparse:oid=master:%5e%7epattern" \
+	grep "Add to combine filter-spec: sparse:oid=main:%5e%7epattern" \
 		trace2
 '
 
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index f822d5d328..53617c9da9 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -102,7 +102,7 @@ check_describe c-* --tags HEAD^^2
 check_describe B --tags HEAD^^2^
 check_describe e --tags HEAD^^^
 
-check_describe heads/master --all HEAD
+check_describe heads/main --all HEAD
 check_describe tags/c-* --all HEAD^
 check_describe tags/e --all HEAD^^^
 
@@ -403,15 +403,15 @@ test_expect_success ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
 	i=1 &&
 	while test $i -lt 8000
 	do
-		echo "commit refs/heads/master
+		echo "commit refs/heads/main
 committer A U Thor <author@example.com> $((1000000000 + $i * 100)) +0200
 data <<EOF
 commit #$i
 EOF"
-		test $i = 1 && echo "from refs/heads/master^0"
+		test $i = 1 && echo "from refs/heads/main^0"
 		i=$(($i + 1))
 	done | git fast-import &&
-	git checkout master &&
+	git checkout main &&
 	git tag far-far-away HEAD^ &&
 	echo "HEAD~4000 tags/far-far-away~3999" >expect &&
 	git name-rev HEAD~4000 >actual &&
@@ -442,7 +442,7 @@ test_expect_success 'describe complains about missing object' '
 '
 
 test_expect_success 'name-rev a rev shortly after epoch' '
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 
 	git checkout --orphan no-timestamp-underflow &&
 	# Any date closer to epoch than the CUTOFF_DATE_SLOP constant
@@ -456,7 +456,7 @@ test_expect_success 'name-rev a rev shortly after epoch' '
 	test_cmp expect actual
 '
 
-# A--------------master
+# A--------------main
 #  \            /
 #   \----------M2
 #    \        /
@@ -487,10 +487,10 @@ test_expect_success 'name-rev covers all conditions while looking at parents' '
 		git checkout $A &&
 		git merge --no-ff HEAD@{1} && # M2
 
-		git checkout master &&
+		git checkout main &&
 		git merge --no-ff HEAD@{1} &&
 
-		echo "$B master^2^2~1^2" >expect &&
+		echo "$B main^2^2~1^2" >expect &&
 		git name-rev $B >actual &&
 
 		test_cmp expect actual
@@ -516,7 +516,7 @@ test_expect_success 'describe commits with disjoint bases' '
 		git checkout --orphan branch && rm file &&
 		echo B > file2 && git add file2 && git commit -m B &&
 		git tag B -a -m B &&
-		git merge --no-ff --allow-unrelated-histories master -m x &&
+		git merge --no-ff --allow-unrelated-histories main -m x &&
 
 		check_describe "A-3-*" HEAD
 	)
@@ -542,7 +542,7 @@ test_expect_success 'describe commits with disjoint bases 2' '
 		echo o >> file2 && git add file2 && GIT_COMMITTER_DATE="2020-01-01 15:01" git commit -m o &&
 		echo B >> file2 && git add file2 && GIT_COMMITTER_DATE="2020-01-01 15:02" git commit -m B &&
 		git tag B -a -m B &&
-		git merge --no-ff --allow-unrelated-histories master -m x &&
+		git merge --no-ff --allow-unrelated-histories main -m x &&
 
 		check_describe "B-3-*" HEAD
 	)
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index f3e66eaf9b..8be07ce902 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -81,7 +81,7 @@ test_expect_success GPG 'set up a signed tag' '
 test_expect_success 'message for merging local branch' '
 	echo "Merge branch ${apos}left${apos}" >expected &&
 
-	git checkout master &&
+	git checkout main &&
 	git fetch . left &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
@@ -89,7 +89,7 @@ test_expect_success 'message for merging local branch' '
 '
 
 test_expect_success GPG 'message for merging local tag signed by good key' '
-	git checkout master &&
+	git checkout main &&
 	git fetch . signed-good-tag &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
 	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
@@ -98,7 +98,7 @@ test_expect_success GPG 'message for merging local tag signed by good key' '
 '
 
 test_expect_success GPG 'message for merging local tag signed by unknown key' '
-	git checkout master &&
+	git checkout main &&
 	git fetch . signed-good-tag &&
 	GNUPGHOME=. git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
 	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
@@ -109,7 +109,7 @@ test_expect_success GPG 'message for merging local tag signed by unknown key' '
 test_expect_success 'message for merging external branch' '
 	echo "Merge branch ${apos}left${apos} of $(pwd)" >expected &&
 
-	git checkout master &&
+	git checkout main &&
 	git fetch "$(pwd)" left &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
@@ -133,7 +133,7 @@ test_expect_success '[merge] summary/log configuration' '
 	test_config merge.log true &&
 	test_unconfig merge.summary &&
 
-	git checkout master &&
+	git checkout main &&
 	test_tick &&
 	git fetch . left &&
 
@@ -142,7 +142,7 @@ test_expect_success '[merge] summary/log configuration' '
 	test_unconfig merge.log &&
 	test_config merge.summary true &&
 
-	git checkout master &&
+	git checkout main &&
 	test_tick &&
 	git fetch . left &&
 
@@ -153,7 +153,7 @@ test_expect_success '[merge] summary/log configuration' '
 '
 
 test_expect_success 'setup FETCH_HEAD' '
-	git checkout master &&
+	git checkout main &&
 	test_tick &&
 	git fetch . left
 '
@@ -281,7 +281,7 @@ test_expect_success 'fmt-merge-msg -m' '
 
 	test_unconfig merge.log &&
 	test_unconfig merge.summary &&
-	git checkout master &&
+	git checkout main &&
 	git fetch "$(pwd)" left &&
 	git fmt-merge-msg -m "Sync with left" <.git/FETCH_HEAD >actual &&
 	git fmt-merge-msg --log -m "Sync with left" \
@@ -323,28 +323,28 @@ test_expect_success 'setup: expected shortlog for two branches' '
 test_expect_success 'shortlog for two branches' '
 	test_config merge.log true &&
 	test_unconfig merge.summary &&
-	git checkout master &&
+	git checkout main &&
 	test_tick &&
 	git fetch . left right &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual1 &&
 
 	test_unconfig merge.log &&
 	test_config merge.summary true &&
-	git checkout master &&
+	git checkout main &&
 	test_tick &&
 	git fetch . left right &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual2 &&
 
 	test_config merge.log yes &&
 	test_unconfig merge.summary &&
-	git checkout master &&
+	git checkout main &&
 	test_tick &&
 	git fetch . left right &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual3 &&
 
 	test_unconfig merge.log &&
 	test_config merge.summary yes &&
-	git checkout master &&
+	git checkout main &&
 	test_tick &&
 	git fetch . left right &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual4 &&
@@ -358,7 +358,7 @@ test_expect_success 'shortlog for two branches' '
 test_expect_success 'merge-msg -F' '
 	test_unconfig merge.log &&
 	test_config merge.summary yes &&
-	git checkout master &&
+	git checkout main &&
 	test_tick &&
 	git fetch . left right &&
 	git fmt-merge-msg -F .git/FETCH_HEAD >actual &&
@@ -368,7 +368,7 @@ test_expect_success 'merge-msg -F' '
 test_expect_success 'merge-msg -F in subdirectory' '
 	test_unconfig merge.log &&
 	test_config merge.summary yes &&
-	git checkout master &&
+	git checkout main &&
 	test_tick &&
 	git fetch . left right &&
 	mkdir sub &&
@@ -408,7 +408,7 @@ test_expect_success 'merge-msg tag' '
 	test_unconfig merge.log &&
 	test_config merge.summary yes &&
 
-	git checkout master &&
+	git checkout main &&
 	test_tick &&
 	git fetch . tag tag-r3 &&
 
@@ -438,7 +438,7 @@ test_expect_success 'merge-msg two tags' '
 	test_unconfig merge.log &&
 	test_config merge.summary yes &&
 
-	git checkout master &&
+	git checkout main &&
 	test_tick &&
 	git fetch . tag tag-r3 tag tag-l5 &&
 
@@ -468,7 +468,7 @@ test_expect_success 'merge-msg tag and branch' '
 	test_unconfig merge.log &&
 	test_config merge.summary yes &&
 
-	git checkout master &&
+	git checkout main &&
 	test_tick &&
 	git fetch . tag tag-r3 left &&
 
@@ -495,7 +495,7 @@ test_expect_success 'merge-msg lots of commits' '
 
 	test_config merge.summary yes &&
 
-	git checkout master &&
+	git checkout main &&
 	test_tick &&
 	git fetch . long &&
 
@@ -506,11 +506,11 @@ test_expect_success 'merge-msg lots of commits' '
 test_expect_success 'merge-msg with "merging" an annotated tag' '
 	test_config merge.log true &&
 
-	git checkout master^0 &&
+	git checkout main^0 &&
 	git commit --allow-empty -m "One step ahead" &&
 	git tag -a -m "An annotated one" annote HEAD &&
 
-	git checkout master &&
+	git checkout main &&
 	git fetch . annote &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
@@ -543,23 +543,23 @@ test_expect_success 'merge-msg with "merging" an annotated tag' '
 '
 
 test_expect_success 'merge.suppressDest configuration' '
-	git checkout -B side master &&
+	git checkout -B side main &&
 	git commit --allow-empty -m "One step ahead" &&
-	git checkout master &&
+	git checkout main &&
 	git fetch . side &&
 
 	git -c merge.suppressDest="" fmt-merge-msg <.git/FETCH_HEAD >full.1 &&
 	head -n1 full.1 >actual &&
-	grep -e "Merge branch .side. into master" actual &&
+	grep -e "Merge branch .side. into main" actual &&
 
 	git -c merge.suppressDest="mast" fmt-merge-msg <.git/FETCH_HEAD >full.2 &&
 	head -n1 full.2 >actual &&
-	grep -e "Merge branch .side. into master$" actual &&
+	grep -e "Merge branch .side. into main$" actual &&
 
 	git -c merge.suppressDest="ma?*[rn]" fmt-merge-msg <.git/FETCH_HEAD >full.3 &&
 	head -n1 full.3 >actual &&
 	grep -e "Merge branch .side." actual &&
-	! grep -e " into master$" actual
+	! grep -e " into main$" actual
 '
 
 test_done
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 0a21669f56..f5a55c1991 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -26,17 +26,17 @@ test_expect_success 'setup some history and refs' '
 	git tag $sign -m "A signed tag" signed-tag &&
 	git tag $sign -m "Signed doubly" doubly-signed-tag signed-tag &&
 
-	git checkout master &&
-	git update-ref refs/odd/spot master
+	git checkout main &&
+	git update-ref refs/odd/spot main
 '
 
 test_expect_success 'filtering with --points-at' '
 	cat >expect <<-\EOF &&
-	refs/heads/master
+	refs/heads/main
 	refs/odd/spot
 	refs/tags/three
 	EOF
-	git for-each-ref --format="%(refname)" --points-at=master >actual &&
+	git for-each-ref --format="%(refname)" --points-at=main >actual &&
 	test_cmp expect actual
 '
 
@@ -53,13 +53,13 @@ test_expect_success 'check signed tags with --points-at' '
 
 test_expect_success 'filtering with --merged' '
 	cat >expect <<-\EOF &&
-	refs/heads/master
+	refs/heads/main
 	refs/odd/spot
 	refs/tags/one
 	refs/tags/three
 	refs/tags/two
 	EOF
-	git for-each-ref --format="%(refname)" --merged=master >actual &&
+	git for-each-ref --format="%(refname)" --merged=main >actual &&
 	test_cmp expect actual
 '
 
@@ -72,13 +72,13 @@ test_expect_success 'filtering with --no-merged' '
 	refs/tags/four
 	refs/tags/signed-tag
 	EOF
-	git for-each-ref --format="%(refname)" --no-merged=master >actual &&
+	git for-each-ref --format="%(refname)" --no-merged=main >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'filtering with --contains' '
 	cat >expect <<-\EOF &&
-	refs/heads/master
+	refs/heads/main
 	refs/heads/side
 	refs/odd/spot
 	refs/tags/annotated-tag
@@ -251,7 +251,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'nested alignment with quote formatt
 
 test_expect_success 'check `%(contents:lines=1)`' '
 	cat >expect <<-\EOF &&
-	master |three
+	main |three
 	side |four
 	odd/spot |three
 	annotated-tag |An annotated tag
@@ -269,7 +269,7 @@ test_expect_success 'check `%(contents:lines=1)`' '
 
 test_expect_success 'check `%(contents:lines=0)`' '
 	cat >expect <<-\EOF &&
-	master |
+	main |
 	side |
 	odd/spot |
 	annotated-tag |
@@ -287,7 +287,7 @@ test_expect_success 'check `%(contents:lines=0)`' '
 
 test_expect_success 'check `%(contents:lines=99999)`' '
 	cat >expect <<-\EOF &&
-	master |three
+	main |three
 	side |four
 	odd/spot |three
 	annotated-tag |An annotated tag
@@ -360,7 +360,7 @@ test_expect_success 'improper usage of %(if), %(then), %(else) and %(end) atoms'
 test_expect_success 'check %(if)...%(then)...%(end) atoms' '
 	git for-each-ref --format="%(refname)%(if)%(authorname)%(then) Author: %(authorname)%(end)" >actual &&
 	cat >expect <<-\EOF &&
-	refs/heads/master Author: A U Thor
+	refs/heads/main Author: A U Thor
 	refs/heads/side Author: A U Thor
 	refs/odd/spot Author: A U Thor
 	refs/tags/annotated-tag
@@ -381,7 +381,7 @@ test_expect_success 'check %(if)...%(then)...%(end) atoms' '
 test_expect_success 'check %(if)...%(then)...%(else)...%(end) atoms' '
 	git for-each-ref --format="%(if)%(authorname)%(then)%(authorname)%(else)No author%(end): %(refname)" >actual &&
 	cat >expect <<-\EOF &&
-	A U Thor: refs/heads/master
+	A U Thor: refs/heads/main
 	A U Thor: refs/heads/side
 	A U Thor: refs/odd/spot
 	No author: refs/tags/annotated-tag
@@ -401,7 +401,7 @@ test_expect_success 'check %(if)...%(then)...%(else)...%(end) atoms' '
 test_expect_success 'ignore spaces in %(if) atom usage' '
 	git for-each-ref --format="%(refname:short): %(if)%(HEAD)%(then)Head ref%(else)Not Head ref%(end)" >actual &&
 	cat >expect <<-\EOF &&
-	master: Head ref
+	main: Head ref
 	side: Not Head ref
 	odd/spot: Not Head ref
 	annotated-tag: Not Head ref
@@ -420,19 +420,19 @@ test_expect_success 'ignore spaces in %(if) atom usage' '
 '
 
 test_expect_success 'check %(if:equals=<string>)' '
-	git for-each-ref --format="%(if:equals=master)%(refname:short)%(then)Found master%(else)Not master%(end)" refs/heads/ >actual &&
+	git for-each-ref --format="%(if:equals=main)%(refname:short)%(then)Found main%(else)Not main%(end)" refs/heads/ >actual &&
 	cat >expect <<-\EOF &&
-	Found master
-	Not master
+	Found main
+	Not main
 	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'check %(if:notequals=<string>)' '
-	git for-each-ref --format="%(if:notequals=master)%(refname:short)%(then)Not master%(else)Found master%(end)" refs/heads/ >actual &&
+	git for-each-ref --format="%(if:notequals=main)%(refname:short)%(then)Not main%(else)Found main%(end)" refs/heads/ >actual &&
 	cat >expect <<-\EOF &&
-	Found master
-	Not master
+	Found main
+	Not main
 	EOF
 	test_cmp expect actual
 '
@@ -443,11 +443,11 @@ test_expect_success '--merged is compatible with --no-merged' '
 
 test_expect_success 'validate worktree atom' '
 	cat >expect <<-EOF &&
-	master: $(pwd)
-	master_worktree: $(pwd)/worktree_dir
+	main: $(pwd)
+	main_worktree: $(pwd)/worktree_dir
 	side: not checked out
 	EOF
-	git worktree add -b master_worktree worktree_dir master &&
+	git worktree add -b main_worktree worktree_dir main &&
 	git for-each-ref --format="%(refname:short): %(if)%(worktreepath)%(then)%(worktreepath)%(else)not checked out%(end)" refs/heads/ >actual &&
 	rm -r worktree_dir &&
 	git worktree prune &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a78ff1e57e..307b75eafe 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -257,13 +257,13 @@ case "$TRASH_DIRECTORY" in
 esac
 
 case "$TEST_NUMBER" in
-3404|4013|5310)
+3404|4013|5310|6300)
 	# Avoid conflicts with patch series that are cooking at the same time
 	# as the patch series changing the default of `init.defaultBranch`.
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-[0-5]*)
+[0-5]*|6[0-3]*)
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-- 
gitgitgadget

