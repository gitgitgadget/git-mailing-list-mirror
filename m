Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E83C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA5B61166
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbhJFJwu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbhJFJwk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 05:52:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148CAC061766
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 02:50:48 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id dj4so7644793edb.5
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 02:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4mCLllGZFVkljRSaqyUpFIFUrGKWN99Brgoo0UtMfgo=;
        b=ONnCM+gfvdl5Ip0lwmq3mqzMKtlhh2+D4TRPznwmH3pZoWirIkscqD2A+luGbdreNG
         PBQC1ef2ikzKeJStTpqtpRDvgHXtZx6Rai67lOtc0tcO1CQJJBr2iP7ZTYgrLIWEm2I2
         xXZ2l//gxGt7Y+yFoa77LnbFwGCsA+phD8hHrso1AP+N4q3PITlD94b7YaGiuW16eGsW
         QJUuzRyslmAXKurNhZZOmbfg7p4Sjj7NNQifZFLzPQ1mym3k7ouYjqPOgtdGJHczxW7C
         YqD5Bkb3sqy44SilvNL9mo6nwfu5dDT51rl4qFM0jzUUKsHxrjyCzy54ZTL7IquSv5lf
         o4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4mCLllGZFVkljRSaqyUpFIFUrGKWN99Brgoo0UtMfgo=;
        b=x+hznvdSp8wjfagWETPs2UKcqO9nnGmMdTTJGEb1jX3V7klqG/1IFa4NY6gv42EuST
         O1oM//iVnfAN+qqygO+IY528uo/hVMaQZjrA0iJNgBt3FsFZfzdEsM0OGgEwpVSDDEyO
         Euv0o7Wwdk/dsxqYqzPy6gkGTRl89VJXZ8YWxYtMuDDTT6nWy0rp7yXCn5w9xhrdM1mf
         LziRXG0tGWQ6uPzUQEGm9J0EyS0Fxz87zV4HyFIIaCq2VAq12tVkwO/YU3sFs0Df2UES
         ixgojj0Miia1pKcMss5UoGYsti1mbfyr6KSu6zFR5lQGYLeMNbLkbLmdBIfD4zH4nKVp
         WbEw==
X-Gm-Message-State: AOAM531NNfB/FgYbgvwURzA3e64MWpb93INa4CzTQW28sVIjP0CgmFpg
        uWZnQM9aGgpgcv7Dao/kyxdBx75QRIneSA==
X-Google-Smtp-Source: ABdhPJx40vR4PodW3cUkcQrJk018he4J8ZQjPg/Ad4hM78Geiot8KB89D3+ly55MOyLp1gd1egU64Q==
X-Received: by 2002:a17:907:77c8:: with SMTP id kz8mr26005931ejc.406.1633513846422;
        Wed, 06 Oct 2021 02:50:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2sm9886243edu.48.2021.10.06.02.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:50:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/10] leak tests: mark various "generic" tests as passing with SANITIZE=leak
Date:   Wed,  6 Oct 2021 11:50:36 +0200
Message-Id: <patch-09.10-9299634b932-20211006T094705Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
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
index b1839e08771..90b7b350a53 100755
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
2.33.0.1441.gbbcdb4c3c66

