Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F58C433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1CE76044F
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhJ3W13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 18:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbhJ3W1R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 18:27:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C87DC06120C
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:39 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b12so17882785wrh.4
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TrE5NxZbmEnLaWyCJxtgsSYNbDm9Wlz8qkrU8xVvAAk=;
        b=Ni+RwhUKEnKuLtBbGdz4dGmV4iXiQSbyEjkZ7JYuPwJMNJZnDZFcGW3IxH+NFHKrhE
         nGqrNoXgfxJT5wH0MMdXzT58+XcHsf4SBvMTsj/JsY1iQ3umv1obr4o5EeQqA4TvTY8I
         f71Ypoo/1XJ1PKHn753r2QyAtfdfDh00OmVbVL7SxloLK6+SzKtOq1D+bSkx0vKFbZ2z
         JYEjfk7hvD9XXJgWKvz8wt76S7jPGcHa1QP7MpF/RA80uy8N+dphA7ixtRXPsB4tJmIV
         b64h91gWDyqadAvyfANbRqltJcjmplXlPMhGxDtqAzx/QIPEgV8X3LuyHC90n5AnQPJv
         oXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TrE5NxZbmEnLaWyCJxtgsSYNbDm9Wlz8qkrU8xVvAAk=;
        b=qLjLThwQyruEjmfKn7CHV8Gvv1oDj1NzlwapRRdgDCxEIwJyTq57UqHThjzbAF//U5
         xe21V1O16xIznS3Ly8Lo8rd0g4t3Vix2SjqkS9brVybQwBJekOgmydpXIpUlK43TQKCM
         V3vwU/91asQ7+wiIQfhXrISY5t5JnjuOeZwaIrN/fFwH7JCz5m6R2Lv6bW3P/5uw1inR
         qM73/h26gXEpzxr2uXGxLM2TOhwoQiTd+EProb+zq4Livm8ZceOyjEKTwg4bn3+rK5tZ
         qM6lKboDRUYJADR+DH+o28DuRAkema/qi4qM3g3ebP/tPfuSJ0Xk8nDUpY/ntNrF5Tfn
         mNqw==
X-Gm-Message-State: AOAM532zbvSS0QVqJJjYr17A+dBjnkUCi0Usb8LK/hCMQegx9KKTr2Il
        TCTWMD9SfL76WTv3yaSa4OYT8HdWDVGvsA==
X-Google-Smtp-Source: ABdhPJxQYpXvqg+QFY8sUTs9ohM4E4cPkHMzoA/saI1fiDSd3HyBxKlcQpYClzFDsRqJKJ7K5Ayv+Q==
X-Received: by 2002:adf:e9c5:: with SMTP id l5mr7079420wrn.218.1635632677727;
        Sat, 30 Oct 2021 15:24:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm8193399wmq.17.2021.10.30.15.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 15:24:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/15] leak tests: mark some config tests as passing with SANITIZE=leak
Date:   Sun, 31 Oct 2021 00:24:23 +0200
Message-Id: <patch-14.15-9902e353dda-20211030T221945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark some tests that match "*config*" as passing when git is compiled
with SANITIZE=leak. They'll now be listed as running under the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1300-config.sh          | 1 +
 t/t1303-wacky-config.sh    | 2 ++
 t/t1307-config-blob.sh     | 2 ++
 t/t1308-config-set.sh      | 1 +
 t/t1309-early-config.sh    | 1 +
 t/t1310-config-default.sh  | 1 +
 t/t2404-worktree-config.sh | 1 +
 7 files changed, 9 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9ff46f3b047..f8031afaaf9 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -8,6 +8,7 @@ test_description='Test git config in different settings'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'clear default config' '
diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
index 0000e664e7b..0506f3d6bba 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='Test wacky input to git config'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Leaving off the newline is intentional!
diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
index 930dce06f0f..0a7099d6f52 100755
--- a/t/t1307-config-blob.sh
+++ b/t/t1307-config-blob.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='support for reading config from a blob'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create config blob' '
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 88b119a0a35..b38e158d3b2 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -2,6 +2,7 @@
 
 test_description='Test git config-set API in different settings'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # 'check_config get_* section.key value' verifies that the entry for
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index b4a9158307f..537435b90ae 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -2,6 +2,7 @@
 
 test_description='Test read_early_config()'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'read early config' '
diff --git a/t/t1310-config-default.sh b/t/t1310-config-default.sh
index 6049d917081..09b10c144ba 100755
--- a/t/t1310-config-default.sh
+++ b/t/t1310-config-default.sh
@@ -2,6 +2,7 @@
 
 test_description='Test git config in different settings (with --default)'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'uses --default when entry missing' '
diff --git a/t/t2404-worktree-config.sh b/t/t2404-worktree-config.sh
index 9536d109195..842937bfb9a 100755
--- a/t/t2404-worktree-config.sh
+++ b/t/t2404-worktree-config.sh
@@ -2,6 +2,7 @@
 
 test_description="config file in multi worktree"
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.33.1.1570.g069344fdd45

