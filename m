Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07167C4332F
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D5160E94
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbhJLN7J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbhJLN66 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:58:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB56C061762
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:56:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e3so33609248wrc.11
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cv+h3lVrZST3rwjjXDw4M6hw314+ZIHhnkGxQS8R03Y=;
        b=hV8b1iPwkx7QSB7xTIW39TKYBA4URbzHLpC8SP3ZR9kdv0M3LGMgd/JP20C6lcs7Ai
         ouMMOQX3TN+87BbIuY5T/MXqGKnGjsIJEwdhMroSEO75zazuSM+FquO1hhNCTD1WowY4
         KPUMY7zHHU85FRPCejDY8cYNgf4t6c+6ygSjUzafxTZ4Cv85cgl8Qx8mmc0jm/DvB6ku
         7LsjVKbN929N1OR70XLDKme7jkLdrfyswWD7wUAligXF7bBbV/aztqa0fV4rT/UCBIa0
         Wvv76YRqNsip3r8Xx1Pz+KTxgyC6QaP7DVnbhFiD/xI1rgcQ1EsbzpCbFoz/wkdcDf+l
         OwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cv+h3lVrZST3rwjjXDw4M6hw314+ZIHhnkGxQS8R03Y=;
        b=0L/H8werDeRM4tWyPiTHlyXbeEdEPhCziTgPvaip4bWGZmZGQv2JUGIFS19ytXFU0s
         fN+s13mJTpKvMYlrHh7TqJsltz6cjS9FWKF+27t3l16G+RreUWzLBzntS258xd7yXHMO
         rLyikE6gLL8G6KpbPGLttwZzKr1Y6UxX+/JjjH3wL+Z2WtxaVcMmttJ+f5VxJfSnf6Pf
         qUGxJPszxFN2ujHd3/49NLiUENaBx/aIUty1LiFl3p8IUD5LZPyOGLq7B2nhxgr8u/q9
         ihBr3VRL1HafWZVuVmiR0qDmPXOEADylt90RAy2DzZzHnri+a26I3KKaeI+qT9PXi2x9
         P5ow==
X-Gm-Message-State: AOAM530puh3n/lwjbt8YjkOgwO6QPmPswkmG2mdRaiY4dAdQFWywTatw
        srUOeAEb6R0FBc2Dd7QOVijt3XB9KB5O+w==
X-Google-Smtp-Source: ABdhPJyPvA85F1Z8hn/fJoZZaw8RIQsU/fxtlY39YYwW/CxIYXod06ztVveteQMqAsRYZDIEmdEUSA==
X-Received: by 2002:a05:6000:551:: with SMTP id b17mr32046408wrf.18.1634047014894;
        Tue, 12 Oct 2021 06:56:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm4031950wmp.1.2021.10.12.06.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:56:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/9] leak tests: mark various "generic" tests as passing with SANITIZE=leak
Date:   Tue, 12 Oct 2021 15:56:44 +0200
Message-Id: <patch-v2-8.9-a4843f35004-20211012T135343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark various "generic" tests as passing when git is compiled with
SANITIZE=leak. These tests were subjectively picked from the lists of
passing tests since they're all small, and test some generic feature
such as wildmatch(), commonly used environment variables, ident
parsing etc.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1430-bad-ref-name.sh       | 1 +
 t/t1504-ceiling-dirs.sh       | 2 ++
 t/t1510-repo-setup.sh         | 1 +
 t/t2050-git-dir-relative.sh   | 1 +
 t/t2300-cd-to-toplevel.sh     | 1 +
 t/t3070-wildmatch.sh          | 1 +
 t/t3205-branch-color.sh       | 1 +
 t/t3211-peel-ref.sh           | 1 +
 t/t3300-funny-names.sh        | 1 +
 t/t3902-quoted.sh             | 1 +
 t/t4026-color.sh              | 2 ++
 t/t5580-unc-paths.sh          | 1 +
 t/t5615-alternate-env.sh      | 2 ++
 t/t7518-ident-corner-cases.sh | 2 ++
 14 files changed, 18 insertions(+)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index fa3aeb80f2c..4c77cf89a6c 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -4,6 +4,7 @@ test_description='Test handling of ref names that check-ref-format rejects'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
index 3d51615e42d..0fafcf9dde3 100755
--- a/t/t1504-ceiling-dirs.sh
+++ b/t/t1504-ceiling-dirs.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test GIT_CEILING_DIRECTORIES'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_prefix() {
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index bbfe05b8e4a..591505a39c0 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -43,6 +43,7 @@ A few rules for repo setup:
 # This test heavily relies on the standard error of nested function calls.
 test_untraceable=UnfortunatelyYes
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 here=$(pwd)
diff --git a/t/t2050-git-dir-relative.sh b/t/t2050-git-dir-relative.sh
index 21f4659a9d1..1f193cde965 100755
--- a/t/t2050-git-dir-relative.sh
+++ b/t/t2050-git-dir-relative.sh
@@ -12,6 +12,7 @@ into the subdir while keeping the worktree location,
 and tries commits from the top and the subdir, checking
 that the commit-hook still gets called.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 COMMIT_FILE="$(pwd)/output"
diff --git a/t/t2300-cd-to-toplevel.sh b/t/t2300-cd-to-toplevel.sh
index c8de6d8a190..b40eeb263fe 100755
--- a/t/t2300-cd-to-toplevel.sh
+++ b/t/t2300-cd-to-toplevel.sh
@@ -2,6 +2,7 @@
 
 test_description='cd_to_toplevel'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 EXEC_PATH="$(git --exec-path)"
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 56ea4bda133..72d5b014d82 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -2,6 +2,7 @@
 
 test_description='wildmatch tests'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Disable expensive chain-lint tests; all of the tests in this script
diff --git a/t/t3205-branch-color.sh b/t/t3205-branch-color.sh
index 08bd906173b..6a521c1a3e5 100755
--- a/t/t3205-branch-color.sh
+++ b/t/t3205-branch-color.sh
@@ -4,6 +4,7 @@ test_description='basic branch output coloring'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up some sample branches' '
diff --git a/t/t3211-peel-ref.sh b/t/t3211-peel-ref.sh
index 37b9d26f4b6..9cbc34fc583 100755
--- a/t/t3211-peel-ref.sh
+++ b/t/t3211-peel-ref.sh
@@ -4,6 +4,7 @@ test_description='tests for the peel_ref optimization of packed-refs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create annotated tag in refs/tags' '
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index f5bf16abcd8..d3ac826283e 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -9,6 +9,7 @@ This test tries pathnames with funny characters in the working
 tree, index, and tree objects.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 HT='	'
diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index f528008c363..72a5a565e97 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -5,6 +5,7 @@
 
 test_description='quoted output'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 FN='濱野'
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index c0b642c1ab0..cc73161b466 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='Test diff/status color escape codes'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 ESC=$(printf '\033')
diff --git a/t/t5580-unc-paths.sh b/t/t5580-unc-paths.sh
index cd803ae8bf1..cd7604fff93 100755
--- a/t/t5580-unc-paths.sh
+++ b/t/t5580-unc-paths.sh
@@ -4,6 +4,7 @@ test_description='various Windows-only path tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if test_have_prereq CYGWIN
diff --git a/t/t5615-alternate-env.sh b/t/t5615-alternate-env.sh
index b4905b822c0..83513e46a35 100755
--- a/t/t5615-alternate-env.sh
+++ b/t/t5615-alternate-env.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='handling of alternates in environment variables'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_obj () {
diff --git a/t/t7518-ident-corner-cases.sh b/t/t7518-ident-corner-cases.sh
index 905957bd0a1..fffdb6ff2e7 100755
--- a/t/t7518-ident-corner-cases.sh
+++ b/t/t7518-ident-corner-cases.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='corner cases in ident strings'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # confirm that we do not segfault _and_ that we do not say "(null)", as
-- 
2.33.0.1567.g7b23ce7ed9e

