Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7489EC433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D6A560F38
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhJ3W1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 18:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhJ3W1D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 18:27:03 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C96C061714
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r8so9520267wra.7
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BxB+XLKWKsysq4SXffjXcTEKQ2tfFiFdKu1w7HG6jnM=;
        b=ZcX4sEwYjNlSBuoK6t8IZPAoO4FJKgXJXCCkNdzqZp7cw/yfXnlBt0SUN889288a51
         SaOfD2wgyxP9Z+HVmAfltzUS051ULUpQLv9uOZ9aO4Dia9IIKs4sDLZzAtRwHgXtH5zB
         vwZW1o2Y+tMBB08kaLHHfKbpSbOP+KAmTQhebk+KiUbP0nXI90D3eAiQnosJ9jqFsN/l
         s9x2/MdSiG8sEZKPZ5/6ATdF1hAyT1lrGa5xoTXrV4uJiM1XRw6y27Stl0M511SHS2fw
         TCTRkaMsf3J1pA0xc3YEN6TRk8MdBBwpJJCMtAmH5Kvdo4WEA3h08H/stD3klvZDeKyw
         mYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BxB+XLKWKsysq4SXffjXcTEKQ2tfFiFdKu1w7HG6jnM=;
        b=QRqoOuop279TXrDSjrQUl39nA4DyDLAt+jPoXTyBMrTZgXQGA6Nun88H+0fvLwrSNC
         s8VrnKmeSwKK759EsuQfDjvF48EwQLpSz+Zonqw2jwMRxr7svsHC0rVvSQfcMydccksT
         30LB4TiUJcJJU+D84FuRouHf3N3eks/Ebwh3sMn/gOq62nRuZ+h2XlmDv8klMannbVQI
         nBmteqWgGsLv15GLrX2YPYA0efLPb9QniEWSt1dSDrtD0I/OzxReX+hpUptE+kRjRKGx
         NFI35DewBQGunSzkbZlmh/xYVlqeRQ6sR75vLacoJQGBxjOsdxX77Gwv1ObouvjGQXUt
         3mdg==
X-Gm-Message-State: AOAM530j2+Cf8axYyGPa7g7o2J9om1bRjE3Edfx+XdEECitCBunjY2Vc
        jMvGg4L/JMX4BEQJ6By3d1SjLc1FzsqFJw==
X-Google-Smtp-Source: ABdhPJx/vOHrLJn/o/yHzjZTafK9MlLTrQSTOxn48sR1esxsJBaT2N8s/Oq6lTyzaJK4aVTqmSmY0A==
X-Received: by 2002:a05:6000:2c6:: with SMTP id o6mr24977386wry.321.1635632670593;
        Sat, 30 Oct 2021 15:24:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm8193399wmq.17.2021.10.30.15.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 15:24:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/15] leak tests: mark some misc tests as passing with SANITIZE=leak
Date:   Sun, 31 Oct 2021 00:24:13 +0200
Message-Id: <patch-04.15-ab9f891a3fe-20211030T221945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As in 7ff24785cb7 (leak tests: mark some misc tests as passing with
SANITIZE=leak, 2021-10-12) continue marking various miscellaneous
tests as passing when git is compiled with SANITIZE=leak. They'll now
be listed as running under the "GIT_TEST_PASSING_SANITIZE_LEAK=true"
test mode (the "linux-leaks" CI target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1420-lost-found.sh                       | 2 ++
 t/t1600-index.sh                            | 1 +
 t/t2000-conflict-when-checking-files-out.sh | 1 +
 t/t2100-update-cache-badpath.sh             | 1 +
 t/t3908-stash-in-worktree.sh                | 1 +
 t/t4007-rename-3.sh                         | 2 ++
 t/t5002-archive-attr-pattern.sh             | 1 +
 t/t5200-update-server-info.sh               | 1 +
 t/t5307-pack-missing-commit.sh              | 1 +
 t/t5555-http-smart-common.sh                | 1 +
 t/t5701-git-serve.sh                        | 1 +
 t/t5704-protocol-violations.sh              | 2 ++
 t/t6136-pathspec-in-bare.sh                 | 1 +
 t/t7101-reset-empty-subdirs.sh              | 2 ++
 t/t7103-reset-bare.sh                       | 2 ++
 t/t7525-status-rename.sh                    | 1 +
 t/t7526-commit-pathspec-file.sh             | 1 +
 17 files changed, 22 insertions(+)

diff --git a/t/t1420-lost-found.sh b/t/t1420-lost-found.sh
index dc9e402c555..dbe15a0be10 100755
--- a/t/t1420-lost-found.sh
+++ b/t/t1420-lost-found.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='Test fsck --lost-found'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 46329c488b1..010989f90e6 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -2,6 +2,7 @@
 
 test_description='index file specific tests'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 sane_unset GIT_TEST_SPLIT_INDEX
diff --git a/t/t2000-conflict-when-checking-files-out.sh b/t/t2000-conflict-when-checking-files-out.sh
index f18616ad2be..79fc97f1d7e 100755
--- a/t/t2000-conflict-when-checking-files-out.sh
+++ b/t/t2000-conflict-when-checking-files-out.sh
@@ -21,6 +21,7 @@ test_description='git conflicts when checking files out test.'
 # path1 is occupied by a non-directory.  With "-f" flag, it should remove
 # the conflicting paths and succeed.
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 show_files() {
diff --git a/t/t2100-update-cache-badpath.sh b/t/t2100-update-cache-badpath.sh
index 2df3fdde8bf..7915e7b8211 100755
--- a/t/t2100-update-cache-badpath.sh
+++ b/t/t2100-update-cache-badpath.sh
@@ -22,6 +22,7 @@ and tries to git update-index --add the following:
 All of the attempts should fail.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 mkdir path2 path3
diff --git a/t/t3908-stash-in-worktree.sh b/t/t3908-stash-in-worktree.sh
index 2b2b366ef94..347a89b030b 100755
--- a/t/t3908-stash-in-worktree.sh
+++ b/t/t3908-stash-in-worktree.sh
@@ -5,6 +5,7 @@
 
 test_description='Test git stash in a worktree'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
index c634653b5be..b86165cbac5 100755
--- a/t/t4007-rename-3.sh
+++ b/t/t4007-rename-3.sh
@@ -6,6 +6,8 @@
 test_description='Rename interaction with pathspec.
 
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t5002-archive-attr-pattern.sh b/t/t5002-archive-attr-pattern.sh
index bda6d7d7e9e..a66b5ba27e8 100755
--- a/t/t5002-archive-attr-pattern.sh
+++ b/t/t5002-archive-attr-pattern.sh
@@ -2,6 +2,7 @@
 
 test_description='git archive attribute pattern tests'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_exists() {
diff --git a/t/t5200-update-server-info.sh b/t/t5200-update-server-info.sh
index 21a58eecb9b..ed9dfd624c7 100755
--- a/t/t5200-update-server-info.sh
+++ b/t/t5200-update-server-info.sh
@@ -2,6 +2,7 @@
 
 test_description='Test git update-server-info'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' 'test_commit file'
diff --git a/t/t5307-pack-missing-commit.sh b/t/t5307-pack-missing-commit.sh
index f4338abb78a..d3482ab279c 100755
--- a/t/t5307-pack-missing-commit.sh
+++ b/t/t5307-pack-missing-commit.sh
@@ -2,6 +2,7 @@
 
 test_description='pack should notice missing commit objects'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
index 49faf5e283b..b1cfe8b7dba 100755
--- a/t/t5555-http-smart-common.sh
+++ b/t/t5555-http-smart-common.sh
@@ -2,6 +2,7 @@
 
 test_description='test functionality common to smart fetch & push'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index aa1827d841d..1896f671cb3 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -5,6 +5,7 @@ test_description='test protocol v2 server commands'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'test capability advertisement' '
diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
index bc393d7c319..ae1a00afb09 100755
--- a/t/t5704-protocol-violations.sh
+++ b/t/t5704-protocol-violations.sh
@@ -4,6 +4,8 @@ test_description='Test responses to violations of the network protocol. In most
 of these cases it will generally be acceptable for one side to break off
 communications if the other side says something unexpected. We are mostly
 making sure that we do not segfault or otherwise behave badly.'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'extra delim packet in v2 ls-refs args' '
diff --git a/t/t6136-pathspec-in-bare.sh b/t/t6136-pathspec-in-bare.sh
index b117251366d..ae8b5379e24 100755
--- a/t/t6136-pathspec-in-bare.sh
+++ b/t/t6136-pathspec-in-bare.sh
@@ -2,6 +2,7 @@
 
 test_description='diagnosing out-of-scope pathspec'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a bare and non-bare repository' '
diff --git a/t/t7101-reset-empty-subdirs.sh b/t/t7101-reset-empty-subdirs.sh
index 5530651eea4..638bb04e217 100755
--- a/t/t7101-reset-empty-subdirs.sh
+++ b/t/t7101-reset-empty-subdirs.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='git reset should cull empty subdirs'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-data.sh
 
diff --git a/t/t7103-reset-bare.sh b/t/t7103-reset-bare.sh
index afe36a533c4..0de83e36199 100755
--- a/t/t7103-reset-bare.sh
+++ b/t/t7103-reset-bare.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git reset in a bare repository'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup non-bare' '
diff --git a/t/t7525-status-rename.sh b/t/t7525-status-rename.sh
index a62736dce09..22bf5c7e5dc 100755
--- a/t/t7525-status-rename.sh
+++ b/t/t7525-status-rename.sh
@@ -2,6 +2,7 @@
 
 test_description='git status rename detection options'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
index 5fbe47ebcd0..dca62fc48e5 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -2,6 +2,7 @@
 
 test_description='commit --pathspec-from-file'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
-- 
2.33.1.1570.g069344fdd45

