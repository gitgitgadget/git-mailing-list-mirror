Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF94C43216
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA0E6103D
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbhHaNg5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbhHaNgw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 09:36:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859EBC0613A3
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:35:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u15so11270275wmj.1
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=joLoA6cd3bdp+72HkYlzf+FNL7NMFefZp1UABiSPpWE=;
        b=Dp9cmu3xTX0pt3f+Jmj7mee/773RJEy5SKNtgXYNnsrU+qjUOiqcF9PUtd6QFRcgXt
         7g53IP1cn40RW4ta1B8wynM5mzraIonzX54mXgwGI3TM37cO58UnymGlyXhaR7bEoDDA
         ZIF7sfadjg7FDQp95VNpV6HXkopY6MNppM61Tkfw1nTonB6Pv+jjCyxMxCgHQEGRRhns
         d6Mz0K4PnMdDa74S8+cx+u6uQ0VV3qD+8jYA84WEjmjXg8cF6vp+DqwrRwAGWZKK8u4M
         ZFeOktC5mp+M/0uKT1hK9zhQaA3eTIHH07bK5w9Mhdup5wUnEjYURZzPJwc3rpSOFH9y
         4ChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=joLoA6cd3bdp+72HkYlzf+FNL7NMFefZp1UABiSPpWE=;
        b=JJutF4Ps7fGSxwJe4uNmkNziuUsSbVTwGPGWDVXvG+fsFFK7cBwabs0ABdMu/yZHn4
         oNrOtEnCCetPkPLZD9rMqrJDyEqf6PRRcvEDgcRGAs6o2sr3jVDDXed3io+ZUz6UN/W3
         7vQI49X2fOfV29Dd54/Kzxu2taGdpHDUGBaeEOWeP78Kv8RSxXrijShKQArnVOsqpVSp
         5NujuubonDu7lehBfmaax3Ld8fs4NtLALzkPfrTy5h3cUx1NMJkICb7FkiAOOPwGgMrX
         k8ch0+rfaIgGpyXgkZRs0oX49D5uemy/WmgCQwbKCrhAe8q8T4RKwONo9NQUZfG5hrWp
         QVfw==
X-Gm-Message-State: AOAM53325VbbtaAlBQvQUa2ORiUI6F/yonTNhfaUXb+7MTYxedOhQFPv
        XUNOvH5LSkBilKVTi5lX+Q0UiY/mI0Oi3Q==
X-Google-Smtp-Source: ABdhPJzKh8rT6+uqP9Fu8+izJCSZ6QQIdG888igj/FebiskTDeRTqzr5wUiVOeyK3y3cMrNaexg7Sg==
X-Received: by 2002:a1c:7506:: with SMTP id o6mr4481927wmc.112.1630416954885;
        Tue, 31 Aug 2021 06:35:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u27sm19073451wru.2.2021.08.31.06.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:35:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 8/8] tests: annotate select t*.sh with TEST_PASSES_SANITIZE_LEAK=true
Date:   Tue, 31 Aug 2021 15:35:42 +0200
Message-Id: <patch-v3-8.8-e611d2c23d9-20210831T132607Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.805.g739b16c2189
In-Reply-To: <cover-v3-0.8-00000000000-20210831T132607Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20210831T132607Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Annotate a few t*.sh tests that pass with SANITIZE=leak, these tests
now pass under GIT_TEST_PASSING_SANITIZE_LEAK=true. These aren't all
of the ones in t*.sh that pass, I'm selecting a few arbitrary passing
ones that stress a few common commands and APIs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1010-mktree.sh                       | 1 +
 t/t1100-commit-tree-options.sh          | 1 +
 t/t1308-config-set.sh                   | 1 +
 t/t1309-early-config.sh                 | 1 +
 t/t1420-lost-found.sh                   | 1 +
 t/t1430-bad-ref-name.sh                 | 1 +
 t/t1509-root-work-tree.sh               | 1 +
 t/t2002-checkout-cache-u.sh             | 1 +
 t/t2050-git-dir-relative.sh             | 1 +
 t/t2081-parallel-checkout-collisions.sh | 1 +
 t/t2100-update-cache-badpath.sh         | 1 +
 t/t2200-add-update.sh                   | 1 +
 t/t2201-add-update-typechange.sh        | 1 +
 t/t2202-add-addremove.sh                | 1 +
 t/t2204-add-ignored.sh                  | 1 +
 t/t2300-cd-to-toplevel.sh               | 1 +
 t/t3000-ls-files-others.sh              | 1 +
 t/t3004-ls-files-basic.sh               | 1 +
 t/t3006-ls-files-long.sh                | 1 +
 t/t3008-ls-files-lazy-init-name-hash.sh | 1 +
 t/t3100-ls-tree-restrict.sh             | 1 +
 t/t3101-ls-tree-dirname.sh              | 1 +
 t/t3102-ls-tree-wildcards.sh            | 1 +
 t/t3103-ls-tree-misc.sh                 | 1 +
 t/t3205-branch-color.sh                 | 1 +
 t/t3211-peel-ref.sh                     | 1 +
 t/t3300-funny-names.sh                  | 1 +
 t/t3902-quoted.sh                       | 1 +
 t/t4002-diff-basic.sh                   | 1 +
 t/t4026-color.sh                        | 1 +
 t/t4300-merge-tree.sh                   | 1 +
 31 files changed, 31 insertions(+)

diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index b946f876864..3912625cfad 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -2,6 +2,7 @@
 
 test_description='git mktree'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
index ae66ba5babf..d603d9a8544 100755
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -12,6 +12,7 @@ Also make sure that command line parser understands the normal
 "flags first and then non flag arguments" command line.
 '
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 cat >expected <<EOF
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 88b119a0a35..06d384369df 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -2,6 +2,7 @@
 
 test_description='Test git config-set API in different settings'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 # 'check_config get_* section.key value' verifies that the entry for
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index b4a9158307f..8556ec2ac23 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -2,6 +2,7 @@
 
 test_description='Test read_early_config()'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success 'read early config' '
diff --git a/t/t1420-lost-found.sh b/t/t1420-lost-found.sh
index dc9e402c555..0c137b047ae 100755
--- a/t/t1420-lost-found.sh
+++ b/t/t1420-lost-found.sh
@@ -4,6 +4,7 @@
 #
 
 test_description='Test fsck --lost-found'
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index b1839e08771..c49e336bf2e 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -4,6 +4,7 @@ test_description='Test handling of ref names that check-ref-format rejects'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1509-root-work-tree.sh b/t/t1509-root-work-tree.sh
index 553a3f601ba..3410b53d6a4 100755
--- a/t/t1509-root-work-tree.sh
+++ b/t/t1509-root-work-tree.sh
@@ -9,6 +9,7 @@ Script t1509/prepare-chroot.sh may help you setup chroot, then you
 can chroot in and execute this test from there.
 '
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_cmp_val() {
diff --git a/t/t2002-checkout-cache-u.sh b/t/t2002-checkout-cache-u.sh
index 70361c806e1..b45cc0dff41 100755
--- a/t/t2002-checkout-cache-u.sh
+++ b/t/t2002-checkout-cache-u.sh
@@ -8,6 +8,7 @@ test_description='git checkout-index -u test.
 With -u flag, git checkout-index internally runs the equivalent of
 git update-index --refresh on the checked out entry.'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t2050-git-dir-relative.sh b/t/t2050-git-dir-relative.sh
index 21f4659a9d1..8bc80f0d969 100755
--- a/t/t2050-git-dir-relative.sh
+++ b/t/t2050-git-dir-relative.sh
@@ -12,6 +12,7 @@ into the subdir while keeping the worktree location,
 and tries commits from the top and the subdir, checking
 that the commit-hook still gets called.'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 COMMIT_FILE="$(pwd)/output"
diff --git a/t/t2081-parallel-checkout-collisions.sh b/t/t2081-parallel-checkout-collisions.sh
index f6fcfc0c1e4..f717709db3d 100755
--- a/t/t2081-parallel-checkout-collisions.sh
+++ b/t/t2081-parallel-checkout-collisions.sh
@@ -11,6 +11,7 @@ The tests in this file exercise parallel checkout's collision detection code in
 both these mechanics.
 "
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-parallel-checkout.sh"
 
diff --git a/t/t2100-update-cache-badpath.sh b/t/t2100-update-cache-badpath.sh
index 2df3fdde8bf..c700b6ee0ae 100755
--- a/t/t2100-update-cache-badpath.sh
+++ b/t/t2100-update-cache-badpath.sh
@@ -22,6 +22,7 @@ and tries to git update-index --add the following:
 All of the attempts should fail.
 '
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 mkdir path2 path3
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 45ca35d60ac..81a53420813 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -14,6 +14,7 @@ only the updates to dir/sub.
 Also tested are "git add -u" without limiting, and "git add -u"
 without contents changes, and other conditions'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2201-add-update-typechange.sh b/t/t2201-add-update-typechange.sh
index a4eec0a3465..78593dc7451 100755
--- a/t/t2201-add-update-typechange.sh
+++ b/t/t2201-add-update-typechange.sh
@@ -2,6 +2,7 @@
 
 test_description='more git add -u'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2202-add-addremove.sh b/t/t2202-add-addremove.sh
index 9ee659098c4..cd0bbf96525 100755
--- a/t/t2202-add-addremove.sh
+++ b/t/t2202-add-addremove.sh
@@ -2,6 +2,7 @@
 
 test_description='git add --all'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2204-add-ignored.sh b/t/t2204-add-ignored.sh
index 2e07365bbb0..efb973d688f 100755
--- a/t/t2204-add-ignored.sh
+++ b/t/t2204-add-ignored.sh
@@ -2,6 +2,7 @@
 
 test_description='giving ignored paths to git add'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2300-cd-to-toplevel.sh b/t/t2300-cd-to-toplevel.sh
index c8de6d8a190..52794afe14b 100755
--- a/t/t2300-cd-to-toplevel.sh
+++ b/t/t2300-cd-to-toplevel.sh
@@ -2,6 +2,7 @@
 
 test_description='cd_to_toplevel'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 EXEC_PATH="$(git --exec-path)"
diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index 740ce56eab5..0a7a07ab99f 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -15,6 +15,7 @@ filesystem.
     path3/file3 - a file in a directory
     path4       - an empty directory
 '
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success 'setup ' '
diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index 9fd5a1f188a..2a69a12e0f0 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -6,6 +6,7 @@ This test runs git ls-files with various unusual or malformed
 command-line arguments.
 '
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success 'ls-files in empty repository' '
diff --git a/t/t3006-ls-files-long.sh b/t/t3006-ls-files-long.sh
index e109c3fbfb5..bfb70e0b11d 100755
--- a/t/t3006-ls-files-long.sh
+++ b/t/t3006-ls-files-long.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 
 test_description='overly long paths'
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3008-ls-files-lazy-init-name-hash.sh b/t/t3008-ls-files-lazy-init-name-hash.sh
index 85f37049587..fce9e4c44cf 100755
--- a/t/t3008-ls-files-lazy-init-name-hash.sh
+++ b/t/t3008-ls-files-lazy-init-name-hash.sh
@@ -2,6 +2,7 @@
 
 test_description='Test the lazy init name hash with various folder structures'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 if test 1 -eq $(test-tool online-cpus)
diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
index 18baf49a49c..0562998120f 100755
--- a/t/t3100-ls-tree-restrict.sh
+++ b/t/t3100-ls-tree-restrict.sh
@@ -16,6 +16,7 @@ This test runs git ls-tree with the following in a tree.
 The new path restriction code should do the right thing for path2 and
 path2/baz.  Also path0/ should snow nothing.
 '
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 12bf31022a8..57df6c7548b 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -19,6 +19,7 @@ This test runs git ls-tree with the following in a tree.
 Test the handling of multiple directories which have matching file
 entries.  Also test odd filename and missing entries handling.
 '
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3102-ls-tree-wildcards.sh b/t/t3102-ls-tree-wildcards.sh
index 1e16c6b8ea6..47070e60428 100755
--- a/t/t3102-ls-tree-wildcards.sh
+++ b/t/t3102-ls-tree-wildcards.sh
@@ -2,6 +2,7 @@
 
 test_description='ls-tree with(out) globs'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index 14520913afc..552c9e16574 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -7,6 +7,7 @@ Miscellaneous tests for git ls-tree.
 
 '
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3205-branch-color.sh b/t/t3205-branch-color.sh
index 08bd906173b..624abb51c1b 100755
--- a/t/t3205-branch-color.sh
+++ b/t/t3205-branch-color.sh
@@ -4,6 +4,7 @@ test_description='basic branch output coloring'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success 'set up some sample branches' '
diff --git a/t/t3211-peel-ref.sh b/t/t3211-peel-ref.sh
index 37b9d26f4b6..ac4db4fcf51 100755
--- a/t/t3211-peel-ref.sh
+++ b/t/t3211-peel-ref.sh
@@ -4,6 +4,7 @@ test_description='tests for the peel_ref optimization of packed-refs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success 'create annotated tag in refs/tags' '
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index f5bf16abcd8..2d562b407fe 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -9,6 +9,7 @@ This test tries pathnames with funny characters in the working
 tree, index, and tree objects.
 '
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 HT='	'
diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index f528008c363..1720fe73686 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -5,6 +5,7 @@
 
 test_description='quoted output'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 FN='濱野'
diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index 6a9f010197c..46964db1ceb 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -6,6 +6,7 @@
 test_description='Test diff raw-output.
 
 '
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-read-tree-m-3way.sh
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index c0b642c1ab0..8b4b1e01734 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -4,6 +4,7 @@
 #
 
 test_description='Test diff/status color escape codes'
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 ESC=$(printf '\033')
diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index e59601e5fe9..2527749aeff 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -4,6 +4,7 @@
 #
 
 test_description='git merge-tree'
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success setup '
-- 
2.33.0.805.g739b16c2189

