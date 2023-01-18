Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2BFC38159
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjARMqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjARMpa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:45:30 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C954B2BF06
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:36 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hw16so70863732ejc.10
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79enDUK9Un78iCLGnZFE0UeOMxA4gUH483+8+cNxVqk=;
        b=Tbk+16/HJbcFB9RQEbpYut523z+0zUPeYxj4WyZKCi324RSDGqg20UdLvj1R9QX/lX
         na1zriIy/E5rP75mL9FGlui7Ukj+GmDv+QsHeE6VpcVPnvinlf9+ObzkYn2LDZcChRgH
         GbVnQJRXr304yTOlRRoWc9tIYWQafUyrTQQADieEkFsrtKqgA2HTIyDiBaCdSCNb53rm
         TxtZS9LktxkiRwXah+JGrgqnPh4Q3C4wOR8D/YRIaHHA8nehzo50QDBVBX+U6cXfnbD3
         1puwUTAAcWmVmvSd6DClGQ+9qE/z4NGmdnn9IqiCWG6B8I+66j8QWV4IMPcT9nZD2GDo
         9XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79enDUK9Un78iCLGnZFE0UeOMxA4gUH483+8+cNxVqk=;
        b=CLka7tTFhARun4zQ9bua3k8hfTZjaZSZeDvLAANveK2I7aIjq+8VrAWbnh+m86FbP1
         gY4Hsyo4KQDV+RCg8mIzLqlHogZO13l/sWYWwcWUA8J5ppCNfMWU90vdLRFPFLMiOJEL
         4CisV/QiV++L+ZxuiyHWOCfWkRju4VGE7M8RO07+0+hej7UxbNg8E/vI7d3+uEXqkDQl
         B81iuXgYRWNW9lBBFKt7A8+WjQSmtmg+m9VbrYaLGz+IP8cwedfh7kXKhcekn5YqSdTX
         ud0x0xvTF3khEPjxH9Fx77zndfK/dkmPrEv0qMQ6iwLV9ZQNJ3R8z2xePASZG4dw1dze
         1b5Q==
X-Gm-Message-State: AFqh2koQNG7nsVe8mifJ+w0xAqDqwlh/Qdqh6Y6ofS736SLnkzjYscz/
        0VL9oBk7eAiyBGs22jSu0xDieQU80QuX5g==
X-Google-Smtp-Source: AMrXdXtuEMIvzg3GmF0XZONKhlL9olicOcjJzQyEqeHf9Yii/NT0XyqAoSqUWdRjWFwoupFkM01NUQ==
X-Received: by 2002:a17:906:6454:b0:7c1:277:cb00 with SMTP id l20-20020a170906645400b007c10277cb00mr6567128ejn.23.1674043715142;
        Wed, 18 Jan 2023 04:08:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14120053edt.8.2023.01.18.04.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:08:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 01/19] tests: mark tests as passing with SANITIZE=leak
Date:   Wed, 18 Jan 2023 13:08:14 +0100
Message-Id: <patch-v5-01.19-c47fc0fb637-20230118T120334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com> <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
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
2.39.0.1225.g30a3d88132d

