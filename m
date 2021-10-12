Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC77C433FE
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07CA060EBB
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbhJLN7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbhJLN65 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:58:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01626C061753
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:56:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r10so67303347wra.12
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y9lNttF25u9nUOJm6npdBcYz4McJD2llzc//dDCF+sA=;
        b=o66iomydv5aYEThmcekRx61GOusUS2xNjuleMRIAnYf3k32Y0AbrlkL458FLkw6Hu+
         6TMJtMUdCglHB0Oly8ryXIrCY0MGK6ZfR42yflangI4sU8+/SNLeU4sJqmky2YrA+TiK
         M6vhlT8wuR6fUsrn2RDBlDJfIj4QD2EJo2HPkRh/DZKYemNZ8WWCAOYUVEZXrssfl8yN
         gw2fg1HDF/oSa1Ko0kr3zEulap8gFsel1UkYULjiAKACbKOQoW20v5IprscXpL/TGuyo
         o4n6+DAQgRkDz+RZAkktk8MDNmA+5iBixG11XE0fVOQH4dBjAqFvkiIDwfrIbDAOExCx
         eVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y9lNttF25u9nUOJm6npdBcYz4McJD2llzc//dDCF+sA=;
        b=Qr846AYQ/v6AZKSZGMQHAVg3RgNfS6dglbP0qCRngBW6crpfTOowxxgiZNU0r9qCuN
         rlO+R120bCkhUGEa1OQdqMbYpx21jH/wrnwrW9xg0e431+qe2aTNJ//Njume6hyLhBUT
         JXDlzgYhYkdlYCO3PHEyWdDEcy8Gar4kJIU59M41X2Qg3cP69xO/hzwjvDeglHBWHN2w
         bEPfmuZueIyVqTrxUbKS4UOzW8y9rOAsd0GJFne51p4NDTZAH4P/oonkM1rL22h90P3A
         tR94zHg7tVIfHIuGzcr4Wx/u4JbS9+tMF3785KrqCD/COJytrCKfeynpsL18lSPQpXCl
         wbeQ==
X-Gm-Message-State: AOAM5303D9vxgCm6Ko7E65uwybMesizQyam9lEVGMMBrNGNUjqeCMrvy
        pDMtuW6phJOMaPHlRF5EoMSe9EfaaNapBg==
X-Google-Smtp-Source: ABdhPJx0qlDkraay+4O2sf5wckCwPpRp5KCyExqRYc89EAgO+ZgT87M7nk8pOV6lejkgOkgKFjGGIw==
X-Received: by 2002:a05:600c:3b82:: with SMTP id n2mr5666626wms.46.1634047013897;
        Tue, 12 Oct 2021 06:56:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm4031950wmp.1.2021.10.12.06.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:56:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/9] leak tests: mark some read-tree tests as passing with SANITIZE=leak
Date:   Tue, 12 Oct 2021 15:56:43 +0200
Message-Id: <patch-v2-7.9-889e7227abf-20211012T135343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark some tests that match "*read-tree*" as passing when git is
compiled with SANITIZE=leak. They'll now be listed as running under
the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks"
CI target). We still have around half the tests that match
"*read-tree*" failing, but let's whitelist those that don't.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1000-read-tree-m-3way.sh    | 2 ++
 t/t1003-read-tree-prefix.sh    | 1 +
 t/t1009-read-tree-new-index.sh | 1 +
 t/t1012-read-tree-df.sh        | 1 +
 t/t1014-read-tree-confusing.sh | 2 ++
 5 files changed, 7 insertions(+)

diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index 013c5a7bc32..0e8c0dfbbee 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -71,6 +71,8 @@ In addition:
  DF: a special case, where A makes a directory and B makes a file.
 
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 . "$TEST_DIRECTORY"/lib-read-tree-m-3way.sh
diff --git a/t/t1003-read-tree-prefix.sh b/t/t1003-read-tree-prefix.sh
index b6111cd150f..e0db2066f31 100755
--- a/t/t1003-read-tree-prefix.sh
+++ b/t/t1003-read-tree-prefix.sh
@@ -6,6 +6,7 @@
 test_description='git read-tree --prefix test.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1009-read-tree-new-index.sh b/t/t1009-read-tree-new-index.sh
index 2935f68f8d2..fc179ac5dd6 100755
--- a/t/t1009-read-tree-new-index.sh
+++ b/t/t1009-read-tree-new-index.sh
@@ -5,6 +5,7 @@ test_description='test read-tree into a fresh index file'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1012-read-tree-df.sh b/t/t1012-read-tree-df.sh
index 57f0770df14..cde93d22cde 100755
--- a/t/t1012-read-tree-df.sh
+++ b/t/t1012-read-tree-df.sh
@@ -2,6 +2,7 @@
 
 test_description='read-tree D/F conflict corner cases'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1014-read-tree-confusing.sh b/t/t1014-read-tree-confusing.sh
index da3376b3bb2..8ea8d36818b 100755
--- a/t/t1014-read-tree-confusing.sh
+++ b/t/t1014-read-tree-confusing.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='check that read-tree rejects confusing paths'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create base tree' '
-- 
2.33.0.1567.g7b23ce7ed9e

