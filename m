Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0DCC433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 21:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiGTVXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 17:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiGTVWc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 17:22:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102255E815
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u5so4821635wrm.4
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fvxToABIP22saqZPhvFncWfm9JI++jCEgbXh5YAfiKE=;
        b=QsGMJhImqGekacjxNLVdo4LF/COHg4nT66M2fujxFYFk5tf2FwXYQwTrbpEucLrrCm
         HbHWlOmb6KrP4LLAJeuXuyjc1PUd6+zdNOzXFEKIvV9b5fAiF5qPcEQgbYV+InKZJQ6l
         FD6h4nR6XlN0FWaoXtcy4ade+oJDsQVHv7143b+AtShMC2vYoajGfgZJDBm+sWPMAYW1
         H/rz3m+nG4lNA0Yt7n+MiZTdhUFkgrPOZ9UA6KytirLry85kdOm2oDdl1jQC+Sv+TSMb
         4z46UMX5r4Ker7uM+FrnGUFHBVRnM60OvehIjm3ihoO5a8PVDt4FP0LWzd/xdZB0zMvG
         /WAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fvxToABIP22saqZPhvFncWfm9JI++jCEgbXh5YAfiKE=;
        b=xgtTQZKVJDojs9WumMS82O0AtWZJrDVAGimlC5cXUYTtwBpTo0Oo5TtkDrbhTKXZ5V
         qNhYAYWZEq8zGwMQBGWBSUjTyN4NrYSmBKZ2t80ZqQxrLoUDYNjK2ovja4WQPSTXv5uG
         KKrMbJBRnNJMMp5hmOM80VNwKXaEFNp0VEdCuhMg7BFwLEMf6tu2vLSA06CpMeuJO2b5
         LBdLQ9LRDBEgD5hjyZ5OxQwzfD7XBJs4+CCvYSZz30Zi9KgvWqKG63Piq9LDJZflbUo0
         q65lsPxHAz34B+bQOAeAFjG5U9xV5dfq97TMoxt2z2NMgxJAvrCWvXbToQWYIY/2D0XE
         9vkg==
X-Gm-Message-State: AJIora/xyVQc3FVt2NEHCKVmq+nlWxditpszQa0EUhfra1cvRs7+ejS+
        oWmTxU+ITrS1PK/Qga+6yZC7uSUu4TyRMA==
X-Google-Smtp-Source: AGRyM1ufAiw/kWoJo063gmLJlJQRfOcByq9LE7mt0FpfVC3MWGQEVReA5v+DnxtjKF2PeBzm0s/0uQ==
X-Received: by 2002:a05:6000:10cd:b0:21e:4309:d89e with SMTP id b13-20020a05600010cd00b0021e4309d89emr6425246wrx.384.1658352141948;
        Wed, 20 Jul 2022 14:22:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003a0375c4f73sm3605441wmj.44.2022.07.20.14.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:22:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/14] leak tests: mark passing SANITIZE=leak tests as leak-free
Date:   Wed, 20 Jul 2022 23:21:50 +0200
Message-Id: <patch-v2-12.14-e3c8909207b-20220720T211221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1064.gc96144cf387
In-Reply-To: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark those remaining tests that pass when run under SANITIZE=leak with
TEST_PASSES_SANITIZE_LEAK=true, these were either omitted in
f346fcb62a0 (Merge branch 'ab/mark-leak-free-tests-even-more',
2021-12-15) and 5a4f8381b68 (Merge branch 'ab/mark-leak-free-tests',
2021-10-25), or have had their memory leaks fixed since then.

With this change there's now a a one-to-one mapping between those
tests that we have opted-in via "TEST_PASSES_SANITIZE_LEAK=true", and
those that pass with the new "check" mode:

	GIT_TEST_PASSING_SANITIZE_LEAK=check \
	GIT_TEST_SANITIZE_LEAK_LOG=true \
	make test SANITIZE=leak

Note that the "GIT_TEST_SANITIZE_LEAK_LOG=true" is needed due to the
edge cases noted in a preceding commit, i.e. in some cases we'd pass
the test itself, but still have outstanding leaks due to ignored exit
codes.

The "GIT_TEST_SANITIZE_LEAK_LOG=true" corrects for that, we're only
marking those tests as passing that really don't have any leaks,
whether that was reflected in their exit code or not.

Note that the change here to "t9100-git-svn-basic.sh" is marking that
test as passing under SANITIZE=leak, we're removing a
"TEST_FAILS_SANITIZE_LEAK=true" line, not
"TEST_PASSES_SANITIZE_LEAK=true". See 7a98d9ab00d (revisions API: have
release_revisions() release "cmdline", 2022-04-13) for the
introduction of that t/lib-git-svn.sh-specific variable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0027-auto-crlf.sh                | 1 +
 t/t0032-reftable-unittest.sh        | 1 +
 t/t0033-safe-directory.sh           | 1 +
 t/t0050-filesystem.sh               | 1 +
 t/t0095-bloom.sh                    | 2 ++
 t/t1405-main-ref-store.sh           | 1 +
 t/t1407-worktree-ref-store.sh       | 1 +
 t/t1418-reflog-exists.sh            | 1 +
 t/t1701-racy-split-index.sh         | 1 +
 t/t2006-checkout-index-basic.sh     | 1 +
 t/t2023-checkout-m.sh               | 1 +
 t/t2205-add-worktree-config.sh      | 1 +
 t/t3012-ls-files-dedup.sh           | 1 +
 t/t4017-diff-retval.sh              | 1 +
 t/t4051-diff-function-context.sh    | 1 +
 t/t4057-diff-combined-paths.sh      | 1 +
 t/t4114-apply-typechange.sh         | 1 +
 t/t4301-merge-tree-write-tree.sh    | 1 +
 t/t5315-pack-objects-compression.sh | 1 +
 t/t5351-unpack-large-objects.sh     | 1 +
 t/t5402-post-merge-hook.sh          | 1 +
 t/t5503-tagfollow.sh                | 1 +
 t/t6404-recursive-merge.sh          | 1 +
 t/t6405-merge-symlinks.sh           | 1 +
 t/t6408-merge-up-to-date.sh         | 1 +
 t/t6411-merge-filemode.sh           | 1 +
 t/t6413-merge-crlf.sh               | 1 +
 t/t6415-merge-dir-to-symlink.sh     | 1 +
 t/t6425-merge-rename-delete.sh      | 1 +
 t/t6431-merge-criscross.sh          | 1 +
 t/t7060-wtstatus.sh                 | 1 +
 t/t7062-wtstatus-ignorecase.sh      | 1 +
 t/t7110-reset-merge.sh              | 1 +
 t/t7111-reset-table.sh              | 1 +
 t/t7609-mergetool--lib.sh           | 1 +
 t/t9100-git-svn-basic.sh            | 1 -
 t/t9700-perl-git.sh                 | 2 ++
 t/t9901-git-web--browse.sh          | 1 +
 38 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 7f80f463930..a22e0e1382c 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -2,6 +2,7 @@
 
 test_description='CRLF conversion all combinations'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 compare_files () {
diff --git a/t/t0032-reftable-unittest.sh b/t/t0032-reftable-unittest.sh
index 0ed14971a58..471cb37ac28 100755
--- a/t/t0032-reftable-unittest.sh
+++ b/t/t0032-reftable-unittest.sh
@@ -5,6 +5,7 @@
 
 test_description='reftable unittests'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'unittests' '
diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index 3908597d42d..7db3344092d 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -2,6 +2,7 @@
 
 test_description='verify safe.directory checks'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_ASSUME_DIFFERENT_OWNER=1
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 5c9dc90d0b0..325eb1c3cd0 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -5,6 +5,7 @@ test_description='Various filesystem issues'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 auml=$(printf '\303\244')
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index daeb4a5e3e7..b567383eb83 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='Testing the various Bloom filter computations in bloom.c'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'compute unseeded murmur3 hash for empty string' '
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 51f82916281..e4627cf1b61 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -5,6 +5,7 @@ test_description='test main ref store api'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 RUN="test-tool ref-store main"
diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index ad8006c8139..05b1881c591 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -5,6 +5,7 @@ test_description='test worktree ref store api'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 RWT="test-tool ref-store worktree:wt"
diff --git a/t/t1418-reflog-exists.sh b/t/t1418-reflog-exists.sh
index d51ecd5e925..2268bca3c11 100755
--- a/t/t1418-reflog-exists.sh
+++ b/t/t1418-reflog-exists.sh
@@ -4,6 +4,7 @@ test_description='Test reflog display routines'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1701-racy-split-index.sh b/t/t1701-racy-split-index.sh
index 5dc221ef382..d8fa489998a 100755
--- a/t/t1701-racy-split-index.sh
+++ b/t/t1701-racy-split-index.sh
@@ -5,6 +5,7 @@
 
 test_description='racy split index'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2006-checkout-index-basic.sh b/t/t2006-checkout-index-basic.sh
index 7705e3a3170..5d119871d41 100755
--- a/t/t2006-checkout-index-basic.sh
+++ b/t/t2006-checkout-index-basic.sh
@@ -3,6 +3,7 @@
 test_description='basic checkout-index tests
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'checkout-index --gobbledegook' '
diff --git a/t/t2023-checkout-m.sh b/t/t2023-checkout-m.sh
index 7b327b75449..81e772fb4eb 100755
--- a/t/t2023-checkout-m.sh
+++ b/t/t2023-checkout-m.sh
@@ -7,6 +7,7 @@ Ensures that checkout -m on a resolved file restores the conflicted file'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2205-add-worktree-config.sh b/t/t2205-add-worktree-config.sh
index 43d950de640..98265ba1b49 100755
--- a/t/t2205-add-worktree-config.sh
+++ b/t/t2205-add-worktree-config.sh
@@ -17,6 +17,7 @@ outside the repository.  Two instances for which this can occur are tested:
 	   repository can be added to the index.
 	'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success '1a: setup--config worktree' '
diff --git a/t/t3012-ls-files-dedup.sh b/t/t3012-ls-files-dedup.sh
index 2682b1f43a6..190e2f6eed7 100755
--- a/t/t3012-ls-files-dedup.sh
+++ b/t/t3012-ls-files-dedup.sh
@@ -2,6 +2,7 @@
 
 test_description='git ls-files --deduplicate test'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index ed461f481e2..5bc28ad9f04 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -5,6 +5,7 @@ test_description='Return value of diffs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index 4838a1df8b4..725278ad19c 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -2,6 +2,7 @@
 
 test_description='diff function context'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 dir="$TEST_DIRECTORY/t4051"
diff --git a/t/t4057-diff-combined-paths.sh b/t/t4057-diff-combined-paths.sh
index 04b8a1542a8..9a7505cbb8b 100755
--- a/t/t4057-diff-combined-paths.sh
+++ b/t/t4057-diff-combined-paths.sh
@@ -5,6 +5,7 @@ test_description='combined diff show only paths that are different to all parent
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # verify that diffc.expect matches output of
diff --git a/t/t4114-apply-typechange.sh b/t/t4114-apply-typechange.sh
index da3e64f8110..8ff36407667 100755
--- a/t/t4114-apply-typechange.sh
+++ b/t/t4114-apply-typechange.sh
@@ -7,6 +7,7 @@ test_description='git apply should not get confused with type changes.
 
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup repository and commits' '
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index f091259a55e..a243e3c5176 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -2,6 +2,7 @@
 
 test_description='git merge-tree --write-tree'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test is ort-specific
diff --git a/t/t5315-pack-objects-compression.sh b/t/t5315-pack-objects-compression.sh
index 8bacd96275b..c80ea9e8b71 100755
--- a/t/t5315-pack-objects-compression.sh
+++ b/t/t5315-pack-objects-compression.sh
@@ -2,6 +2,7 @@
 
 test_description='pack-object compression configuration'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5351-unpack-large-objects.sh b/t/t5351-unpack-large-objects.sh
index 8ce8aa3b147..b1703350be3 100755
--- a/t/t5351-unpack-large-objects.sh
+++ b/t/t5351-unpack-large-objects.sh
@@ -5,6 +5,7 @@
 
 test_description='git unpack-objects with large objects'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 prepare_dest () {
diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
index 915af2de95e..46ebdfbeeba 100755
--- a/t/t5402-post-merge-hook.sh
+++ b/t/t5402-post-merge-hook.sh
@@ -7,6 +7,7 @@ test_description='Test the post-merge hook.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 195fc64dd44..5ebbaa48968 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -5,6 +5,7 @@ test_description='test automatic tag following'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # End state of the repository:
diff --git a/t/t6404-recursive-merge.sh b/t/t6404-recursive-merge.sh
index b8735c6db4d..36215518b6e 100755
--- a/t/t6404-recursive-merge.sh
+++ b/t/t6404-recursive-merge.sh
@@ -4,6 +4,7 @@ test_description='Test merge without common ancestors'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This scenario is based on a real-world repository of Shawn Pearce.
diff --git a/t/t6405-merge-symlinks.sh b/t/t6405-merge-symlinks.sh
index 7435fce71e0..29e2b25ce5d 100755
--- a/t/t6405-merge-symlinks.sh
+++ b/t/t6405-merge-symlinks.sh
@@ -11,6 +11,7 @@ if core.symlinks is false.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6408-merge-up-to-date.sh b/t/t6408-merge-up-to-date.sh
index 7763c1ba980..8a1ba6d23a7 100755
--- a/t/t6408-merge-up-to-date.sh
+++ b/t/t6408-merge-up-to-date.sh
@@ -2,6 +2,7 @@
 
 test_description='merge fast-forward and up to date'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6411-merge-filemode.sh b/t/t6411-merge-filemode.sh
index 6ae2489286c..b6182723aae 100755
--- a/t/t6411-merge-filemode.sh
+++ b/t/t6411-merge-filemode.sh
@@ -4,6 +4,7 @@ test_description='merge: handle file mode'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up mode change in one branch' '
diff --git a/t/t6413-merge-crlf.sh b/t/t6413-merge-crlf.sh
index affea255fe9..b4f4a313f48 100755
--- a/t/t6413-merge-crlf.sh
+++ b/t/t6413-merge-crlf.sh
@@ -11,6 +11,7 @@ test_description='merge conflict in crlf repo
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6415-merge-dir-to-symlink.sh b/t/t6415-merge-dir-to-symlink.sh
index 2655e295f5a..ae00492c768 100755
--- a/t/t6415-merge-dir-to-symlink.sh
+++ b/t/t6415-merge-dir-to-symlink.sh
@@ -4,6 +4,7 @@ test_description='merging when a directory was replaced with a symlink'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create a commit where dir a/b changed to symlink' '
diff --git a/t/t6425-merge-rename-delete.sh b/t/t6425-merge-rename-delete.sh
index 459b431a60d..93cd2869b12 100755
--- a/t/t6425-merge-rename-delete.sh
+++ b/t/t6425-merge-rename-delete.sh
@@ -4,6 +4,7 @@ test_description='Merge-recursive rename/delete conflict message'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'rename/delete' '
diff --git a/t/t6431-merge-criscross.sh b/t/t6431-merge-criscross.sh
index 3824756a02e..3fe14cd73e8 100755
--- a/t/t6431-merge-criscross.sh
+++ b/t/t6431-merge-criscross.sh
@@ -2,6 +2,7 @@
 
 test_description='merge-recursive backend test'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 #         A      <- create some files
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 0f4344c55e6..aaeb4a53344 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -5,6 +5,7 @@ test_description='basic work tree status reporting'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7062-wtstatus-ignorecase.sh b/t/t7062-wtstatus-ignorecase.sh
index 73709dbeee2..caf372a3d42 100755
--- a/t/t7062-wtstatus-ignorecase.sh
+++ b/t/t7062-wtstatus-ignorecase.sh
@@ -2,6 +2,7 @@
 
 test_description='git-status with core.ignorecase=true'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'status with hash collisions' '
diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 3d62e10b53f..eb881be95b6 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -5,6 +5,7 @@
 
 test_description='Tests for "git reset" with "--merge" and "--keep" options'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7111-reset-table.sh b/t/t7111-reset-table.sh
index ce421ad5ac4..78f25c1c7ea 100755
--- a/t/t7111-reset-table.sh
+++ b/t/t7111-reset-table.sh
@@ -5,6 +5,7 @@
 
 test_description='Tests to check that "reset" options follow a known table'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t7609-mergetool--lib.sh b/t/t7609-mergetool--lib.sh
index 330d6d603d7..8b1c3bd39f2 100755
--- a/t/t7609-mergetool--lib.sh
+++ b/t/t7609-mergetool--lib.sh
@@ -4,6 +4,7 @@ test_description='git mergetool
 
 Testing basic merge tools options'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'mergetool --tool=vimdiff creates the expected layout' '
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 7c5b847f584..fea41b3c360 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -8,7 +8,6 @@ test_description='git svn basic tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 prepare_utf8_locale
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index a48fac6f07a..4aa5d90d328 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='perl interface (Git.pm)'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-perl.sh
 
diff --git a/t/t9901-git-web--browse.sh b/t/t9901-git-web--browse.sh
index de7152f8271..19f56e5680f 100755
--- a/t/t9901-git-web--browse.sh
+++ b/t/t9901-git-web--browse.sh
@@ -5,6 +5,7 @@ test_description='git web--browse basic tests
 
 This test checks that git web--browse can handle various valid URLs.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_web_browse () {
-- 
2.37.1.1064.gc96144cf387

