Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF26AC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242646AbiCWUlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiCWUlG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:41:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C6774600
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:39:35 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so6143212wmj.0
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cYNHey/Q07xCjuko2nRT8DCgtZO8gs+BLYd7ILXv8jU=;
        b=EYgvOEh6w8R1ZpGgVT2g5OvIYJT1S2RQD0QeE8GV/OFpV8KQji+loh7A8BOZf66BPA
         vGaKJZw2MFAvjhsKGN60SYkk2dff2DRJ2J9m/8ZXCKx4TTizjkJaj10sA8L4A68OrLSP
         zukEhOQsSkTslivsKXFyoyt67ajB29L0TdWAsXGQwBPJyWe1OrpjcafNNtUHtv1bH3S3
         hsZLt5eVUSqUO0FgKn/ixnUBmW42gnbmqM9ZdYM7XQk86w5O4zgKQh1TJMJI4wmfDtvw
         2o0WhV/hnhw18ZYdT8k1f6m6XtuC7zKGG+J8Y+VA9ITmFIZjT0+o/JYttRiZZTpy6wt0
         fCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cYNHey/Q07xCjuko2nRT8DCgtZO8gs+BLYd7ILXv8jU=;
        b=WpdSBgh1Qk1M55VhI+Vfw4NI4zy+6Pv7wpvYQq3ojehYKlCmFNrPSPGKSg+gF0K6Fr
         n50atGaXfuEpPTw4SW6EG4sXczAu7ayn9ySGkSixhd9bbQ1An9I1RJeJ14vn+YVdwSkt
         2PWutcr+e0M+n+KoSmfzdRpHw/Y+QElkWydbIpO9fjO7eSQPVM/rP2B+hY0jfXKSROKV
         lTuXZ67BETAxtvPsK0WZVrPrNEG1GJ8OgnZWlVp/NeYek89n2mMWC6UTjSgLbFm+N0Rg
         RW2eQelez6+Ua7H7VyMLm7KpPWRV7+Primg3fBZUVSXwpYTvld9asnFFKCOSSBe7usVL
         SJuA==
X-Gm-Message-State: AOAM530Bdcy3OApqa4FcuedaOOY9Je6PO0AoDNrqHkpMdyez61m+mmDy
        DC+/UicENAAoOKtP/8/tiqMYbJChVPRBag==
X-Google-Smtp-Source: ABdhPJwke6drVKGjQMpnRLE2PdCCBok7qRM1+sLCupzv9xleljkoP65ZbCH/K8ez4neMh44GV8cWCA==
X-Received: by 2002:a05:600c:a03:b0:37b:daff:6146 with SMTP id z3-20020a05600c0a0300b0037bdaff6146mr11130129wmp.85.1648067973699;
        Wed, 23 Mar 2022 13:39:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c1c0f00b0038cabc63721sm653634wms.30.2022.03.23.13.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:39:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] leak tests: mark passing SANITIZE=leak tests as leak-free
Date:   Wed, 23 Mar 2022 21:39:31 +0100
Message-Id: <patch-1.1-45f76fbd8c5-20220323T203725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
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

With this change there's almost a 1=1 mapping between those tests that
are marked to run with "GIT_TEST_PASSING_SANITIZE_LEAK=true", and
those that we have opted-in via "TEST_PASSES_SANITIZE_LEAK=true".

The few exceptions to that are due to "false positive" passes having
to do with us reporting the tests as passing, but them having
unreported memory leaks for various reasons (exit codes not being
retained). Those will be addressed in follow-up work, for now let's
opt-in the straightforward cases.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

A straightforward change to opt-in various tests that currently aren't
run under the SANITIZE=leak CI mode for whatever reason.

To the extent that opting-tests in has been painful, it's about to
become a lot easier due to my parallel series to add a
revisions_release():
https://lore.kernel.org/git/cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com/

But this small patch is orthagonal to that, and can proceed
independently.

 t/t0027-auto-crlf.sh                 | 1 +
 t/t0032-reftable-unittest.sh         | 1 +
 t/t0050-filesystem.sh                | 1 +
 t/t1405-main-ref-store.sh            | 1 +
 t/t2006-checkout-index-basic.sh      | 1 +
 t/t2023-checkout-m.sh                | 1 +
 t/t3012-ls-files-dedup.sh            | 1 +
 t/t4017-diff-retval.sh               | 1 +
 t/t4021-format-patch-numbered.sh     | 1 +
 t/t4028-format-patch-mime-headers.sh | 2 ++
 t/t4036-format-patch-signer-mime.sh  | 1 +
 t/t4057-diff-combined-paths.sh       | 1 +
 t/t4122-apply-symlink-inside.sh      | 1 +
 t/t5315-pack-objects-compression.sh  | 1 +
 t/t5402-post-merge-hook.sh           | 1 +
 t/t6404-recursive-merge.sh           | 1 +
 t/t6405-merge-symlinks.sh            | 1 +
 t/t6408-merge-up-to-date.sh          | 1 +
 t/t6411-merge-filemode.sh            | 1 +
 t/t6413-merge-crlf.sh                | 1 +
 t/t6415-merge-dir-to-symlink.sh      | 1 +
 t/t6425-merge-rename-delete.sh       | 1 +
 t/t6431-merge-criscross.sh           | 1 +
 t/t7060-wtstatus.sh                  | 1 +
 t/t7062-wtstatus-ignorecase.sh       | 1 +
 t/t7110-reset-merge.sh               | 1 +
 t/t7111-reset-table.sh               | 1 +
 t/t9001-send-email.sh                | 1 +
 t/t9901-git-web--browse.sh           | 1 +
 29 files changed, 30 insertions(+)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index c5f7ac63b0a..38815f48acd 100755
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
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index afc343cf9bb..24f0075233f 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -5,6 +5,7 @@ test_description='Various filesystem issues'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 auml=$(printf '\303\244')
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
diff --git a/t/t4021-format-patch-numbered.sh b/t/t4021-format-patch-numbered.sh
index 9be65fd4440..1219aa226dc 100755
--- a/t/t4021-format-patch-numbered.sh
+++ b/t/t4021-format-patch-numbered.sh
@@ -5,6 +5,7 @@
 
 test_description='Format-patch numbering options'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4028-format-patch-mime-headers.sh b/t/t4028-format-patch-mime-headers.sh
index 204ba673cb5..60cb819c42e 100755
--- a/t/t4028-format-patch-mime-headers.sh
+++ b/t/t4028-format-patch-mime-headers.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='format-patch mime headers and extra headers do not conflict'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create commit with utf-8 body' '
diff --git a/t/t4036-format-patch-signer-mime.sh b/t/t4036-format-patch-signer-mime.sh
index 98d9713d8b2..48655bcc789 100755
--- a/t/t4036-format-patch-signer-mime.sh
+++ b/t/t4036-format-patch-signer-mime.sh
@@ -2,6 +2,7 @@
 
 test_description='format-patch -s should force MIME encoding as needed'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
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
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
index aa52de401b9..96965373036 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -4,6 +4,7 @@ test_description='apply to deeper directory without getting fooled with symlink'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5315-pack-objects-compression.sh b/t/t5315-pack-objects-compression.sh
index 8bacd96275b..c80ea9e8b71 100755
--- a/t/t5315-pack-objects-compression.sh
+++ b/t/t5315-pack-objects-compression.sh
@@ -2,6 +2,7 @@
 
 test_description='pack-object compression configuration'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
index 3e5e19c7191..8697154983f 100755
--- a/t/t5402-post-merge-hook.sh
+++ b/t/t5402-post-merge-hook.sh
@@ -7,6 +7,7 @@ test_description='Test the post-merge hook.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
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
 
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 84d0f40d76a..dfa6b20f7a6 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -4,6 +4,7 @@ test_description='git send-email'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # May be altered later in the test
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
2.35.1.1452.ga7cfc89151f

