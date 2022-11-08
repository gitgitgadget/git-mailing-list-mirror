Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C47C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiKHSR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiKHSR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:17:57 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CFC38BD
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:17:55 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x2so23793094edd.2
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqVyxJ/yHpMF8TDwwVZiPEsLMxuGAySJrkFgEea5IDU=;
        b=Mfbrd/c0dp/T3xq/i3vLGQ8I3ALek0iMci70jE6gkqHpE8gV1atc57oahcI1x6bg7H
         FlybZEou+cZtRQBlD6x0l5Yf/2V+uYEzPXiRpiIe6TyV7Aukc1R59pps+8ROe6HB5gpF
         AuDHzjqX/83SNmxUSTbSOmNpDKaFQ7nqhE9rhuy3UWRS34Ol9bC4xhB4XOYxvxzsRuoz
         Yek1TJ+X8KJOLp2cxTuwRxYWE3T3qysH6stKBdUUXY1jd1hoNOaKadaB50nv2b6eiq/E
         OvIg8OG7ZTXk4hLpMRFAqqS+0txEGEFxoyPBeAUN9Fo6hCGCp/EnUhNNKIG8M5OPyj9Z
         2+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqVyxJ/yHpMF8TDwwVZiPEsLMxuGAySJrkFgEea5IDU=;
        b=qRNzrMi/IVFdjIGLX4yuVERGlgeAd+VQPWe8FYujM3SGH/UBqFW9Cxt82KRjToe/Z0
         sh+CNDjsjkOlgtnwK9UR/OC6LmfLJjL0bkDPne3U+4ApDZqZHQSHHcL6rA5OpBWy339I
         oT1Or0OLTUaVNDU1DWgUVetOVrE5gY26aXrJEBHWnwJeH8erfDzMDFGYZwpWGjRZhCjg
         101JPy8Ffe5OGl0D3EjdVITqTF8Wok+D5LoepdPYEfztVsKwr+ZO3imuTqW7iq/6HOKt
         XKaUxqGYi+rCTG+0gaUkBRUiLRZnf+VpHEz6t1JgfCl23AQnOdU1EUbQ4WURj9TajM+7
         ty3w==
X-Gm-Message-State: ACrzQf35J3dSbiFtb+beNQ/rJ/nI7bxY32hrDH4+TEJswyaK5WdgNgTc
        fHwM27zOOiZg3aq4CmwLbVAQJ1R9d6SEqw==
X-Google-Smtp-Source: AMsMyM4HTo08JK2pHlY6Q6+OAIsbeiLnyNVsEWaac46jALOr5eBIhtYClxb7ZIkR1MB6VPHE7vd7sQ==
X-Received: by 2002:aa7:cd58:0:b0:462:d797:483d with SMTP id v24-20020aa7cd58000000b00462d797483dmr58431389edw.343.1667931473804;
        Tue, 08 Nov 2022 10:17:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b007a62215eb4esm4994131eji.16.2022.11.08.10.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:17:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/15] tests: mark tests as passing with SANITIZE=leak
Date:   Tue,  8 Nov 2022 19:17:37 +0100
Message-Id: <patch-v2-01.15-58a02e6bb4e-20221108T172650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This marks tests that have been leak-free since various recent
commits, but which were not marked us such when the memory leak was
fixed. These were mostly discovered with the "check" mode added in
faececa53f9 (test-lib: have the "check" mode for SANITIZE=leak
consider leak logs, 2022-07-28).

Commits that fixed the last memory leak in these tests. Per narrowing
down when they started to pass under SANITIZE=leak with "bisect":

- t1022-read-tree-partial-clone.sh:
  7e2619d8ff0 (list_objects_filter_options: plug leak of filter_spec
  strings, 2022-09-08)

- t4053-diff-no-index.sh: 07a6f94a6d0 (diff-no-index: release prefixed
  filenames, 2022-09-07)

- t6415-merge-dir-to-symlink.sh: bac92b1f39f (Merge branch
  'js/ort-clean-up-after-failed-merge', 2022-08-08).

- t5554-noop-fetch-negotiator.sh:
  66eede4a37c (prepare_repo_settings(): plug leak of config values,
  2022-09-08)

- t2012-checkout-last.sh, t7504-commit-msg-hook.sh,
  t91{15,46,60}-git-svn-*.sh: The in-flight "pw/rebase-no-reflog-action"
  series, upon which this is based:
  https://lore.kernel.org/git/pull.1405.git.1667575142.gitgitgadget@gmail.com/

Let's mark all of these as passing with
"TEST_PASSES_SANITIZE_LEAK=true", to have it regression tested,
including as part of the "linux-leaks" CI job.

Additionally, let's remove the "!SANITIZE_LEAK" prerequisite from
tests that now pass, these were marked as failing in:

- 77e56d55ba6 (diff.c: fix a double-free regression in a18d66cefb,
  2022-03-17)
- c4d1d526312 (tests: change some 'test $(git) = "x"' to test_cmp,
  2022-03-07)

These were not spotted with the new "check" mode, but manually, it
doesn't cover these sort of prerequisites. There's few enough that we
shouldn't bother to automate it. They'll be going away sooner than
later.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1022-read-tree-partial-clone.sh       | 2 +-
 t/t2012-checkout-last.sh                 | 1 +
 t/t4015-diff-whitespace.sh               | 4 ++--
 t/t4053-diff-no-index.sh                 | 1 +
 t/t5554-noop-fetch-negotiator.sh         | 2 ++
 t/t6415-merge-dir-to-symlink.sh          | 1 +
 t/t7103-reset-bare.sh                    | 2 +-
 t/t7504-commit-msg-hook.sh               | 1 +
 t/t9115-git-svn-dcommit-funky-renames.sh | 1 -
 t/t9146-git-svn-empty-dirs.sh            | 1 -
 t/t9160-git-svn-preserve-empty-dirs.sh   | 1 -
 11 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/t/t1022-read-tree-partial-clone.sh b/t/t1022-read-tree-partial-clone.sh
index a9953b6a71c..d08563de5c9 100755
--- a/t/t1022-read-tree-partial-clone.sh
+++ b/t/t1022-read-tree-partial-clone.sh
@@ -3,7 +3,7 @@
 test_description='git read-tree in partial clones'
 
 TEST_NO_CREATE_REPO=1
-
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'read-tree in partial clone prefetches in one batch' '
diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index 1f6c4ed0428..4b6372f4c3e 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -5,6 +5,7 @@ test_description='checkout can switch to last branch and merge base'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index f3e20dd5bba..b298f220e01 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1638,7 +1638,7 @@ test_expect_success 'no effect on diff from --color-moved with --word-diff' '
 	test_cmp expect actual
 '
 
-test_expect_success !SANITIZE_LEAK 'no effect on show from --color-moved with --word-diff' '
+test_expect_success 'no effect on show from --color-moved with --word-diff' '
 	git show --color-moved --word-diff >actual &&
 	git show --word-diff >expect &&
 	test_cmp expect actual
@@ -2024,7 +2024,7 @@ test_expect_success '--color-moved rewinds for MIN_ALNUM_COUNT' '
 	test_cmp expected actual
 '
 
-test_expect_success !SANITIZE_LEAK 'move detection with submodules' '
+test_expect_success 'move detection with submodules' '
 	test_create_repo bananas &&
 	echo ripe >bananas/recipe &&
 	git -C bananas add recipe &&
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 3feadf0e359..4e9fa0403d3 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -2,6 +2,7 @@
 
 test_description='diff --no-index'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5554-noop-fetch-negotiator.sh b/t/t5554-noop-fetch-negotiator.sh
index 2ac7b5859e7..06991e8e8aa 100755
--- a/t/t5554-noop-fetch-negotiator.sh
+++ b/t/t5554-noop-fetch-negotiator.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test noop fetch negotiator'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'noop negotiator does not emit any "have"' '
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
diff --git a/t/t7103-reset-bare.sh b/t/t7103-reset-bare.sh
index a60153f9f32..18bbd9975eb 100755
--- a/t/t7103-reset-bare.sh
+++ b/t/t7103-reset-bare.sh
@@ -63,7 +63,7 @@ test_expect_success '"mixed" reset is not allowed in bare' '
 	test_must_fail git reset --mixed HEAD^
 '
 
-test_expect_success !SANITIZE_LEAK '"soft" reset is allowed in bare' '
+test_expect_success '"soft" reset is allowed in bare' '
 	git reset --soft HEAD^ &&
 	git show --pretty=format:%s >out &&
 	echo one >expect &&
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index a39de8c1126..07ca46fb0d5 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -5,6 +5,7 @@ test_description='commit-msg hook'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'with no hook' '
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 419f055721d..743fbe1fe46 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -5,7 +5,6 @@
 
 test_description='git svn dcommit can commit renames of files with ugly names'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'load repository with strange names' '
diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs.sh
index 79c26ed69c1..09606f1b3cf 100755
--- a/t/t9146-git-svn-empty-dirs.sh
+++ b/t/t9146-git-svn-empty-dirs.sh
@@ -4,7 +4,6 @@
 
 test_description='git svn creates empty directories'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'initialize repo' '
diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
index 9cf7a1427ab..36c6b1a12ff 100755
--- a/t/t9160-git-svn-preserve-empty-dirs.sh
+++ b/t/t9160-git-svn-preserve-empty-dirs.sh
@@ -9,7 +9,6 @@ This test uses git to clone a Subversion repository that contains empty
 directories, and checks that corresponding directories are created in the
 local Git repository with placeholder files.'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 GIT_REPO=git-svn-repo
-- 
2.38.0.1467.g709fbdff1a9

