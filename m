Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952FDC433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7506960EE3
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhJ3W1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 18:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbhJ3W1I (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 18:27:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9CDC061714
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r8so9520415wra.7
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=apBcaFmjsFgUDothGBqdIvxplCIbP3Tr3xJ0v8D9/3c=;
        b=XlEEsOvMiNQx7c3UZUeCZ2X+HqOyxQgkhxSwHP3yxZYEF87FNyjwpbC3ZEghv7Xmvp
         Mj/VwYtxNisJcxlPI8UQDWhGZ64bVQReGuAgUckq9z22Wmo1g+5QD5RV3f316mJcdQ/Z
         xeni6hO+TOVEAGutqFnCHjnNUalNxmlGrB4ExYLD/ULGl4Q4M8sLrxaRpU/2iUvLnJwX
         9sS814sq9sLxFUV5Eob+96ab4igk/+ePpEJzu2f5Sylz0sDtH/KuCANWx2kdIzWgIoY+
         1lE3SwdykAdtsqPEwbYsCTmM++9n3DYyjFZKrLWViqdKKCYARurSYXEoWf1zYFVo5FjM
         Bl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=apBcaFmjsFgUDothGBqdIvxplCIbP3Tr3xJ0v8D9/3c=;
        b=Ya0b+B6yCcPJsY/uezxaNR/WDEegFaC43FKAyEU0pmgk4RpoOcxEe0wFLY12y0QhkE
         Z7b+SLlXLbXGpFPXvi6A/Ze0BL8Iu96+A+8cpNMS77vOXa6Gz1UBM1WLEKE48t/oM6x7
         WlJmhH/wrkdwutfTOMzB0UgK+Z4oAFSHKSxFknWAmCi+LPpWQx3aZwfLdVIyEgT1/mxN
         25ySnyqh7KQGYrteGbJntlyn0DNl8dbHjfW65gAGrkxZeBb3F6vU8y80J+tseAsCtOeG
         KnLS5VgktEyxxrVQ/XdK9CcizfZW59sAuTWZPMF5fRkEk6hGYdxCLqJQ63ZFCbvLU43L
         l93A==
X-Gm-Message-State: AOAM531H42+UJ3RHqD+bdrPEBeJqFlBr3zbedJ8/EoUDTinDJo41G6HG
        ecXdiCx8inBjNmEqOzGUiBen2k8iZqY+TQ==
X-Google-Smtp-Source: ABdhPJyaa3M9kAqEDtiB6Fi/hCBV386ZBHxiRhWVegv7/igUB9vcaGo+Eb8k0C5EBZjOkEnC0A5l9g==
X-Received: by 2002:a05:6000:2c2:: with SMTP id o2mr25468531wry.194.1635632675643;
        Sat, 30 Oct 2021 15:24:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm8193399wmq.17.2021.10.30.15.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 15:24:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/15] leak tests: mark some add tests as passing with SANITIZE=leak
Date:   Sun, 31 Oct 2021 00:24:20 +0200
Message-Id: <patch-11.15-8ea9d93c4ff-20211030T221945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark some tests that match "*add*" as passing when git is compiled
with SANITIZE=leak. They'll now be listed as running under the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t2200-add-update.sh            | 1 +
 t/t2201-add-update-typechange.sh | 1 +
 t/t2202-add-addremove.sh         | 1 +
 t/t2204-add-ignored.sh           | 1 +
 t/t3702-add-edit.sh              | 2 ++
 t/t3703-add-magic-pathspec.sh    | 1 +
 t/t3704-add-pathspec-file.sh     | 1 +
 7 files changed, 8 insertions(+)

diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 94c4cb06721..a8297c29434 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -14,6 +14,7 @@ only the updates to dir/sub.
 Also tested are "git add -u" without limiting, and "git add -u"
 without contents changes, and other conditions'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2201-add-update-typechange.sh b/t/t2201-add-update-typechange.sh
index a4eec0a3465..c6876b120f8 100755
--- a/t/t2201-add-update-typechange.sh
+++ b/t/t2201-add-update-typechange.sh
@@ -2,6 +2,7 @@
 
 test_description='more git add -u'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2202-add-addremove.sh b/t/t2202-add-addremove.sh
index 9ee659098c4..24c60bfd790 100755
--- a/t/t2202-add-addremove.sh
+++ b/t/t2202-add-addremove.sh
@@ -2,6 +2,7 @@
 
 test_description='git add --all'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2204-add-ignored.sh b/t/t2204-add-ignored.sh
index 2e07365bbb0..89424abccd1 100755
--- a/t/t2204-add-ignored.sh
+++ b/t/t2204-add-ignored.sh
@@ -2,6 +2,7 @@
 
 test_description='giving ignored paths to git add'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3702-add-edit.sh b/t/t3702-add-edit.sh
index 6c676645d83..a1801a8cbd4 100755
--- a/t/t3702-add-edit.sh
+++ b/t/t3702-add-edit.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='add -e basic tests'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t3703-add-magic-pathspec.sh b/t/t3703-add-magic-pathspec.sh
index 3ef525a559d..d84071038e0 100755
--- a/t/t3703-add-magic-pathspec.sh
+++ b/t/t3703-add-magic-pathspec.sh
@@ -2,6 +2,7 @@
 
 test_description='magic pathspec tests using git-add'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3704-add-pathspec-file.sh b/t/t3704-add-pathspec-file.sh
index 9e35c1fbca6..5d5164d1fc6 100755
--- a/t/t3704-add-pathspec-file.sh
+++ b/t/t3704-add-pathspec-file.sh
@@ -2,6 +2,7 @@
 
 test_description='add --pathspec-from-file'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
-- 
2.33.1.1570.g069344fdd45

