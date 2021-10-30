Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3BEC433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 929C6603E9
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhJ3W1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 18:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhJ3W1F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 18:27:05 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E72CC061764
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o14so22234100wra.12
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NvZkmphmVgULyROCZR3AO3QK+1y9tir/OrDqju0ISzs=;
        b=D+To9xJiFoW0sHWSAJA0wnAyn5OEOnic3g/4BFlHJkuNoIrsQFmgtww+q4RONQZLhp
         JJEaukaLCqegS+3q14dzzWnww6P/H4WtwjewAgQ2XS1kjqWrVoDXvZvQcSIFQLmUlcBp
         zQonJYGeRrOvGFLcHkjTvc1OP7LMEnK+kPzjvHMJYmUb9fDBTANdfr44yJCDR49xW+vS
         whZvb2ABTlWwzCUgnCg5vx4QuE9gs+sK9ByOEZMxk3rJtKHc0ji6ihCVe3KIIxHpa/Kc
         eKVKXSOiVrUqXIdeb1/PvDDZRibbnkj4GR++fxKRLX6qeEKtXdgzND0rruzxJUFwRNU+
         7JDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NvZkmphmVgULyROCZR3AO3QK+1y9tir/OrDqju0ISzs=;
        b=2uG/SzUObYQuoMOBSVOeTn4Y9xBFsdM/9K2/b4h6XmpPJSfo2UvS/WuhAblOigcI7H
         lF/pebfNHdbgf1t7RP9Vb3NBov4DGOzMg8xVGadESPv4UmE0tFnCtzJncCFeWOao3NsV
         vGml0mk07Ksdl7Of7lpgA0Qs0TydJyiuqwTE4PxpUSVSKR4dIfsqsAwb8SB4GLJ2Znn3
         FxEEGTEb8eLDwLX7AUO/2pAbG0qgLxWvTrHhE2HHDIZLMgKrdjOW6kBg3KwEtrykDWLB
         3Z9MsxhSi63ksoUKt36jr29aJEdMM2OyaaPkfT/ZxJyXipqBKIjb4ydfFtV2by2e3hpE
         1I8A==
X-Gm-Message-State: AOAM532X9/RVjYGwob7ZnLE5LsEEpDFuRwKY1AU0zrarjQyjU73MwyS/
        gf+oHr8IaiiOI+iw5dWyYHOXhUwFms7V4w==
X-Google-Smtp-Source: ABdhPJyUf/FMh+RjfDjWFcQ4j9z4SUjP44SK3vtlvJn4vySL8+8FxLgpMfbNWCshxSM1UGb3sOOqBw==
X-Received: by 2002:a05:6000:1a45:: with SMTP id t5mr13326463wry.306.1635632672754;
        Sat, 30 Oct 2021 15:24:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm8193399wmq.17.2021.10.30.15.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 15:24:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/15] leak tests: mark some update-index tests as passing with SANITIZE=leak
Date:   Sun, 31 Oct 2021 00:24:16 +0200
Message-Id: <patch-07.15-7e254eb6357-20211030T221945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark some tests that match "*update-index*" as passing when git is compiled
with SANITIZE=leak. They'll now be listed as running under the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t2101-update-index-reupdate.sh       | 1 +
 t/t2102-update-index-symlinks.sh       | 1 +
 t/t2103-update-index-ignore-missing.sh | 1 +
 t/t2104-update-index-skip-worktree.sh  | 1 +
 t/t2105-update-index-gitfile.sh        | 1 +
 5 files changed, 5 insertions(+)

diff --git a/t/t2101-update-index-reupdate.sh b/t/t2101-update-index-reupdate.sh
index 6c32d42c8c6..e3c7acdbf91 100755
--- a/t/t2101-update-index-reupdate.sh
+++ b/t/t2101-update-index-reupdate.sh
@@ -6,6 +6,7 @@
 test_description='git update-index --again test.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'update-index --add' '
diff --git a/t/t2102-update-index-symlinks.sh b/t/t2102-update-index-symlinks.sh
index 22f2c730ae8..d7a3485582d 100755
--- a/t/t2102-update-index-symlinks.sh
+++ b/t/t2102-update-index-symlinks.sh
@@ -8,6 +8,7 @@ test_description='git update-index on filesystem w/o symlinks test.
 This tests that git update-index keeps the symbolic link property
 even if a plain file is in the working tree if core.symlinks is false.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t2103-update-index-ignore-missing.sh b/t/t2103-update-index-ignore-missing.sh
index 0114f052280..b304714fdb1 100755
--- a/t/t2103-update-index-ignore-missing.sh
+++ b/t/t2103-update-index-ignore-missing.sh
@@ -2,6 +2,7 @@
 
 test_description='update-index with options'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success basics '
diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-index-skip-worktree.sh
index 30666fc70d2..b8686aabd38 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -5,6 +5,7 @@
 
 test_description='skip-worktree bit test'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 sane_unset GIT_TEST_SPLIT_INDEX
diff --git a/t/t2105-update-index-gitfile.sh b/t/t2105-update-index-gitfile.sh
index a7f3d47aec2..963ebe77eb6 100755
--- a/t/t2105-update-index-gitfile.sh
+++ b/t/t2105-update-index-gitfile.sh
@@ -6,6 +6,7 @@
 test_description='git update-index for gitlink to .git file.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'submodule with absolute .git file' '
-- 
2.33.1.1570.g069344fdd45

