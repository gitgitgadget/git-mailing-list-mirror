Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273CE1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 22:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391439AbfJRWMM (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:12:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42909 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390067AbfJRWKY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:10:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14so4067630pgi.9
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UX+VZk0QQaKTngJZjkzDxOa8HNh61474k9NXQNCELQY=;
        b=dwSamf8OvRchljafoRfpoTvXu1DlRd+iw1Jwy7ZTaVqHIl9kZzT3KVH1pnmxbJ29P5
         OGKcrC0XIgEV3rJfbrL6Ud1ngyNZHELsHgzcXpAb0xNAklEQdYifgADAoU0KetxtNurR
         DBFvhnCoOHXRnBMvtM4Yq2RQ6eQKfiM56yLuouXeB9fQgCtoOdc7vpeCT3yXeZlnD7jX
         gmGD2onLTmt5hvXT5PK/dro9TjdIyPNErW2do3ZgUGf4ikDnCmn68Jun7phjuUSqvHlz
         WTu8WQ51UJPuY0gTO8ktr5++zOEG6IIo/WFLuAeHfcVQenVUMtkmKgzl5y58RqzslCT0
         XVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UX+VZk0QQaKTngJZjkzDxOa8HNh61474k9NXQNCELQY=;
        b=dNhRT3fADo32ebHDTevXV0R4CDrWfjLYTlzYDSRJ+A/fvFboooUVni58jmHEWiSu5G
         +uDMDQN6mVjIr2vjh0sde64rqb9MBQEGNl8Iz6OQyTZaXSPk/cZqUC7XiuSh5ODL6iLX
         6DA7JwPiFYcUe+6xF0HIhiwCHYVGdiAdP2oENoxj8wc1wkm0abnv3/KHXUTPjtdYlsxj
         GjsNoQGkULIT9EK4g1XYFyWgXcrEqovx/QE3ShYt5v6BibCWd8w9NwS3F2OUv4GJXDzW
         o3x9ikW0mwlJmR8ZNXLrp5qNKQcuvEbD/sO41GpbGF+KzX/SFDAUZJmgv+gaZhSKaRZE
         AEbQ==
X-Gm-Message-State: APjAAAUNN4yY0VOb1TxqVUXQ10XFhfxnop9wooVP73y/YnlqmaC2rjXw
        EYlZOklPp3/o1397Obv/6Z6eNvAP
X-Google-Smtp-Source: APXvYqyJZCLM8lO/3WbiuZ5mT+rHJsE3mQs+YrQVmEjb4afnrb29kg79cHOiIIqLNdJ1NgYfZPx+zw==
X-Received: by 2002:aa7:955a:: with SMTP id w26mr9569314pfq.193.1571436623595;
        Fri, 18 Oct 2019 15:10:23 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id o64sm15771698pjb.24.2019.10.18.15.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:10:22 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:10:21 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 02/15] t: teach test_cmp_rev to accept ! for not-equals
Message-ID: <417e808466ee3e61a1719faa319fe0e796d5d271.1571435195.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
 <cover.1571435195.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571435195.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, in the case where we are using test_cmp_rev() to report
not-equals, we write `! test_cmp_rev`. However, since test_cmp_rev()
contains

	r1=$(git rev-parse --verify "$1") &&
	r2=$(git rev-parse --verify "$2") &&

In the case where `git rev-parse` segfaults and dies unexpectedly, the
failure will be ignored.

Rewrite test_cmp_rev() to optionally accept "!" as the first argument to
do a not-equals comparison. Rewrite `! test_cmp_rev` to `test_cmp_rev !`
in all tests to take advantage of this new functionality.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2400-worktree-add.sh             |  4 ++--
 t/t3400-rebase.sh                   |  2 +-
 t/t3421-rebase-topology-linear.sh   |  6 +++---
 t/t3430-rebase-merges.sh            |  2 +-
 t/t3432-rebase-fast-forward.sh      |  2 +-
 t/t3501-revert-cherry-pick.sh       |  2 +-
 t/t3508-cherry-pick-many-commits.sh |  2 +-
 t/test-lib-functions.sh             | 13 +++++++++++--
 8 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index e819ba741e..52d476979b 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -438,7 +438,7 @@ test_expect_success 'git worktree add does not match remote' '
 		cd foo &&
 		test_must_fail git config "branch.foo.remote" &&
 		test_must_fail git config "branch.foo.merge" &&
-		! test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
+		test_cmp_rev ! refs/remotes/repo_a/foo refs/heads/foo
 	)
 '
 
@@ -483,7 +483,7 @@ test_expect_success 'git worktree --no-guess-remote option overrides config' '
 		cd foo &&
 		test_must_fail git config "branch.foo.remote" &&
 		test_must_fail git config "branch.foo.merge" &&
-		! test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
+		test_cmp_rev ! refs/remotes/repo_a/foo refs/heads/foo
 	)
 '
 
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index ab18ac5f28..f267f6cd54 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -64,7 +64,7 @@ test_expect_success 'rebase sets ORIG_HEAD to pre-rebase state' '
 	pre="$(git rev-parse --verify HEAD)" &&
 	git rebase master &&
 	test_cmp_rev "$pre" ORIG_HEAD &&
-	! test_cmp_rev "$pre" HEAD
+	test_cmp_rev ! "$pre" HEAD
 '
 
 test_expect_success 'rebase, with <onto> and <upstream> specified as :/quuxery' '
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index b847064f91..325072b0a3 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -61,7 +61,7 @@ test_run_rebase () {
 	test_expect_$result "rebase $* -f rewrites even if upstream is an ancestor" "
 		reset_rebase &&
 		git rebase $* -f b e &&
-		! test_cmp_rev e HEAD &&
+		test_cmp_rev ! e HEAD &&
 		test_cmp_rev b HEAD~2 &&
 		test_linear_range 'd e' b..
 	"
@@ -78,7 +78,7 @@ test_run_rebase () {
 	test_expect_$result "rebase $* -f rewrites even if remote upstream is an ancestor" "
 		reset_rebase &&
 		git rebase $* -f branch-b branch-e &&
-		! test_cmp_rev branch-e origin/branch-e &&
+		test_cmp_rev ! branch-e origin/branch-e &&
 		test_cmp_rev branch-b HEAD~2 &&
 		test_linear_range 'd e' branch-b..
 	"
@@ -368,7 +368,7 @@ test_run_rebase () {
 	test_expect_$result "rebase $* -f --root on linear history causes re-write" "
 		reset_rebase &&
 		git rebase $* -f --root c &&
-		! test_cmp_rev a HEAD~2 &&
+		test_cmp_rev ! a HEAD~2 &&
 		test_linear_range 'a b c' HEAD
 	"
 }
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 9efcf4808a..abbdc26b1b 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -346,7 +346,7 @@ test_expect_success 'A root commit can be a cousin, treat it that way' '
 	git merge --allow-unrelated-histories khnum &&
 	test_tick &&
 	git rebase -f -r HEAD^ &&
-	! test_cmp_rev HEAD^2 khnum &&
+	test_cmp_rev ! HEAD^2 khnum &&
 	test_cmp_graph HEAD^.. <<-\EOF &&
 	*   Merge branch '\''khnum'\'' into asherah
 	|\
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 034ffc7e76..92f95b57da 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -64,7 +64,7 @@ test_rebase_same_head_ () {
 			test_cmp_rev \$oldhead \$newhead
 		elif test $cmp = diff
 		then
-			! test_cmp_rev \$oldhead \$newhead
+			test_cmp_rev ! \$oldhead \$newhead
 		fi
 	"
 }
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index d1c68af8c5..1c51a9131d 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -106,7 +106,7 @@ test_expect_success 'cherry-pick on unborn branch' '
 	rm -rf * &&
 	git cherry-pick initial &&
 	git diff --quiet initial &&
-	! test_cmp_rev initial HEAD
+	test_cmp_rev ! initial HEAD
 '
 
 test_expect_success 'cherry-pick "-" to pick from previous branch' '
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index b457333e18..23070a7b73 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -5,7 +5,7 @@ test_description='test cherry-picking many commits'
 . ./test-lib.sh
 
 check_head_differs_from() {
-	! test_cmp_rev HEAD "$1"
+	test_cmp_rev ! HEAD "$1"
 }
 
 check_head_equals() {
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b299ecc326..76dce5f8ee 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1012,8 +1012,17 @@ test_must_be_empty () {
 	fi
 }
 
-# Tests that its two parameters refer to the same revision
+# Tests that its two parameters refer to the same revision, or if '!' is
+# provided first, that its other two parameters refer to different
+# revisions.
 test_cmp_rev () {
+	local inverted_op
+	inverted_op='!='
+	if test $# -ge 1 && test "x$1" = 'x!'
+	then
+	    inverted_op='='
+	    shift
+	fi
 	if test $# != 2
 	then
 		error "bug in the test script: test_cmp_rev requires two revisions, but got $#"
@@ -1021,7 +1030,7 @@ test_cmp_rev () {
 		local r1 r2
 		r1=$(git rev-parse --verify "$1") &&
 		r2=$(git rev-parse --verify "$2") &&
-		if test "$r1" != "$r2"
+		if test "$r1" "$inverted_op" "$r2"
 		then
 			cat >&4 <<-EOF
 			error: two revisions point to different objects:
-- 
2.23.0.897.g0a19638b1e

