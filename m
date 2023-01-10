Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC03FC46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjAJFoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjAJFn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:43:56 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5C641030
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:43:53 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id fy8so25712994ejc.13
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUFNrE5ScwRZvZyjH826mqXEiUIPSBGT0JzARFu1/xU=;
        b=GG0HTMrRc39a39GzR8eCKnjOCp9Kmh1ZdMMx+znMUqv9jJH2Kiw6sxBKdk1TRMTyhK
         +D1djbV1gIak7ev+guGmZSgjmt1L2o792TeFuNm6/bQ8s9RnRO/+AGFYYkR1VAvOOXrp
         JwZjvgGgRL6oTw77RVq2nMz17rD55JpXcT3ovHbQS57DQhSRKhyVhuvzzUImCs+FCRLB
         aC11Z9i6JuYEup7nXS770z9U1MbK3ztEEB3OAVPo5Zvs8n3kMgP1QNL9P9LImj467occ
         Aks0Am7EYRcDrFzvaygaXwH+jhxr0p/h0Cg8lQSOMQiqFl+peFAmI4+UbZ6gi0u3xpj8
         fVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUFNrE5ScwRZvZyjH826mqXEiUIPSBGT0JzARFu1/xU=;
        b=ZAoLzm5ysiWpZs/zThIPtt5SUJArQBLVRhcxbHQStIIewIe2pqOoOGSHWq7HfbcKZ2
         zu8owiAt1UI1imaTl2r+qLU+1xPVSIgEnkZq+uWGflavFwrzBiUbnLAvVGHQF53MUhz4
         Bkblsda8iQAiBt9wBK4NNSxWjhSFEhdOBpWKYBZM15ObVhAt4MGHXLsqwJJ6gms6I7M/
         jw1EZs+v99UxmadURw2DbATG3uiiOT3iDz7+rNsNC6bfQyNEHvh+tzQh9nrzcDKORLiu
         yolhvW9Z/9bgYqvFaD5dbQ5O1sZipgSdemGFAKKk0p6q87elCFpaRgudXAHinVmvlc/d
         SElA==
X-Gm-Message-State: AFqh2kr0kFFDA2mULC8CibHJ5EsTOqroRcTevqMKAbXZ/NyearXK6EKT
        j40AJsOTdLRqIyKSucQILvaM9O6xsTE=
X-Google-Smtp-Source: AMrXdXtlwjTPPECdn51xQNlRR/m1A1Ej2n1CpTLQ0ttWmPTy2JDLnUhAY2GnYLR3Dx9vw4UvLwBbng==
X-Received: by 2002:a17:907:b686:b0:7c1:7c3a:ffba with SMTP id vm6-20020a170907b68600b007c17c3affbamr63209222ejc.35.1673329431438;
        Mon, 09 Jan 2023 21:43:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:43:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/19] tests: mark tests as passing with SANITIZE=leak
Date:   Tue, 10 Jan 2023 06:43:21 +0100
Message-Id: <patch-v3-01.19-f5b67f44e2d-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com> <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "ab/various-leak-fixes" topic was merged in [1] only t6021
would fail if the tests were run in the
"GIT_TEST_PASSING_SANITIZE_LEAK=check" mode, i.e. to check whether we
marked all leak-free tests with "TEST_PASSES_SANITIZE_LEAK=true".

Since then we've had various tests starting to pass under
SANITIZE=leak. Let's mark those as passing, this is when they started
to pass, narrowed down with "git bisect":

- t5317-pack-objects-filter-objects.sh: In
  faebba436e6 (list-objects-filter: plug pattern_list leak, 2022-12-01).

- t3210-pack-refs.sh, t5613-info-alternate.sh,
  t7403-submodule-sync.sh: In 189e97bc4ba (diff: remove parseopts member
  from struct diff_options, 2022-12-01).

- t1408-packed-refs.sh: In ab91f6b7c42 (Merge branch
  'rs/diff-parseopts', 2022-12-19).

- t0023-crlf-am.sh, t4152-am-subjects.sh, t4254-am-corrupt.sh,
  t4256-am-format-flowed.sh, t4257-am-interactive.sh,
  t5403-post-checkout-hook.sh: In a658e881c13 (am: don't pass strvec to
  apply_parse_options(), 2022-12-13)

- t1301-shared-repo.sh, t1302-repo-version.sh: In b07a819c05f (reflog:
  clear leftovers in reflog_expiry_cleanup(), 2022-12-13).

- t1304-default-acl.sh, t1410-reflog.sh,
  t5330-no-lazy-fetch-with-commit-graph.sh, t5502-quickfetch.sh,
  t5604-clone-reference.sh, t6014-rev-list-all.sh,
  t7701-repack-unpack-unreachable.sh: In b0c61be3209 (Merge branch
  'rs/reflog-expiry-cleanup', 2022-12-26)

1. 9ea1378d046 (Merge branch 'ab/various-leak-fixes', 2022-12-14)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0023-crlf-am.sh                         | 1 +
 t/t1301-shared-repo.sh                     | 1 +
 t/t1302-repo-version.sh                    | 1 +
 t/t1304-default-acl.sh                     | 1 +
 t/t1408-packed-refs.sh                     | 1 +
 t/t1410-reflog.sh                          | 1 +
 t/t3210-pack-refs.sh                       | 1 +
 t/t4152-am-subjects.sh                     | 2 ++
 t/t4254-am-corrupt.sh                      | 2 ++
 t/t4256-am-format-flowed.sh                | 1 +
 t/t4257-am-interactive.sh                  | 2 ++
 t/t5317-pack-objects-filter-objects.sh     | 1 +
 t/t5330-no-lazy-fetch-with-commit-graph.sh | 1 +
 t/t5403-post-checkout-hook.sh              | 1 +
 t/t5502-quickfetch.sh                      | 1 +
 t/t5604-clone-reference.sh                 | 1 +
 t/t5613-info-alternate.sh                  | 2 ++
 t/t6014-rev-list-all.sh                    | 1 +
 t/t6021-rev-list-exclude-hidden.sh         | 1 +
 t/t7403-submodule-sync.sh                  | 1 +
 t/t7701-repack-unpack-unreachable.sh       | 1 +
 21 files changed, 25 insertions(+)

diff --git a/t/t0023-crlf-am.sh b/t/t0023-crlf-am.sh
index f9bbb91f64e..575805513a3 100755
--- a/t/t0023-crlf-am.sh
+++ b/t/t0023-crlf-am.sh
@@ -2,6 +2,7 @@
 
 test_description='Test am with auto.crlf'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >patchfile <<\EOF
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 93a2f91f8a5..a1251f65100 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -8,6 +8,7 @@ test_description='Test shared repository initialization'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Remove a default ACL from the test dir if possible.
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 7cf80bf66a6..70389fa2ebb 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -5,6 +5,7 @@
 
 test_description='Test repository version check'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index c69ae41306c..31b89dd9693 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -9,6 +9,7 @@ test_description='Test repository with default ACL'
 # => this must come before . ./test-lib.sh
 umask 077
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We need an arbitrary other user give permission to using ACLs. root
diff --git a/t/t1408-packed-refs.sh b/t/t1408-packed-refs.sh
index 41ba1f1d7fc..9469c79a585 100755
--- a/t/t1408-packed-refs.sh
+++ b/t/t1408-packed-refs.sh
@@ -5,6 +5,7 @@ test_description='packed-refs entries are covered by loose refs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index aa59954f6c5..6c45965b1e4 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -7,6 +7,7 @@ test_description='Test prune and reflog expiration'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_have () {
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 577f32dc71f..07a0ff93def 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -12,6 +12,7 @@ semantic is still the same.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'enable reflogs' '
diff --git a/t/t4152-am-subjects.sh b/t/t4152-am-subjects.sh
index 4c68245acad..9f2edba1f83 100755
--- a/t/t4152-am-subjects.sh
+++ b/t/t4152-am-subjects.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test subject preservation with format-patch | am'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 make_patches() {
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index 54be7da1611..45f1d4f95e5 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git am with corrupt input'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 make_mbox_with_nul () {
diff --git a/t/t4256-am-format-flowed.sh b/t/t4256-am-format-flowed.sh
index 2369c4e17ad..1015273bc82 100755
--- a/t/t4256-am-format-flowed.sh
+++ b/t/t4256-am-format-flowed.sh
@@ -2,6 +2,7 @@
 
 test_description='test format=flowed support of git am'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4257-am-interactive.sh b/t/t4257-am-interactive.sh
index aed8f4de3d6..f26d7fd2dbd 100755
--- a/t/t4257-am-interactive.sh
+++ b/t/t4257-am-interactive.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='am --interactive tests'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up patches to apply' '
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 5b707d911b5..b26d476c646 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -5,6 +5,7 @@ test_description='git pack-objects using object filtering'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test blob:none filter.
diff --git a/t/t5330-no-lazy-fetch-with-commit-graph.sh b/t/t5330-no-lazy-fetch-with-commit-graph.sh
index 2cc7fd7a476..5eb28f0512d 100755
--- a/t/t5330-no-lazy-fetch-with-commit-graph.sh
+++ b/t/t5330-no-lazy-fetch-with-commit-graph.sh
@@ -2,6 +2,7 @@
 
 test_description='test for no lazy fetch with the commit-graph'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: prepare a repository with a commit' '
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 978f240cdac..cfaae547398 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -7,6 +7,7 @@ test_description='Test the post-checkout hook.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5502-quickfetch.sh b/t/t5502-quickfetch.sh
index b160f8b7fb7..7b3ff21b984 100755
--- a/t/t5502-quickfetch.sh
+++ b/t/t5502-quickfetch.sh
@@ -5,6 +5,7 @@ test_description='test quickfetch from local'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 2734e37e880..dc86dea1333 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -7,6 +7,7 @@ test_description='test clone --reference'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 base_dir=$(pwd)
diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
index 895f46bb911..7708cbafa98 100755
--- a/t/t5613-info-alternate.sh
+++ b/t/t5613-info-alternate.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='test transitive info/alternate entries'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'preparing first repository' '
diff --git a/t/t6014-rev-list-all.sh b/t/t6014-rev-list-all.sh
index c9bedd29cba..16b8bd1d090 100755
--- a/t/t6014-rev-list-all.sh
+++ b/t/t6014-rev-list-all.sh
@@ -2,6 +2,7 @@
 
 test_description='--all includes detached HEADs'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t6021-rev-list-exclude-hidden.sh b/t/t6021-rev-list-exclude-hidden.sh
index 32b2b094138..11c50b7c0dd 100755
--- a/t/t6021-rev-list-exclude-hidden.sh
+++ b/t/t6021-rev-list-exclude-hidden.sh
@@ -2,6 +2,7 @@
 
 test_description='git rev-list --exclude-hidden test'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index ea92ef52a5e..ff09443a0a4 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -11,6 +11,7 @@ These tests exercise the "git submodule sync" subcommand.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index b7ac4f598a8..ebb267855fe 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -5,6 +5,7 @@ test_description='git repack works correctly'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 fsha1=
-- 
2.39.0.1195.gabc92c078c4

