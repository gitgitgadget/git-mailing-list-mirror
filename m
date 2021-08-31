Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18461C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEBF760462
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbhHaNgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbhHaNgr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 09:36:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601BCC061760
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:35:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id j14-20020a1c230e000000b002e748b9a48bso1918719wmj.0
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fMIUUqpRmcOIVsAmoPZUiQSn77rxtiKG7esDDCKFh4U=;
        b=aaof8rew+9gMVlY97agn7BZ31Wcl/SWE2YEtQjZ+XSw6AFADJJRdDKlPbbsFvf8hQS
         JxWGY6DRiI8bL/5rZYP3UEMF9rX+B7Sr2MZwkucfBv3pE0nhTo2+kIyWbqMdSd32TVwV
         9GyWqY5WEqaE6bl+KqqZDHoZC57icQe2xHDNkRs5+y9+4YdUtCxAp1eRZPBiyZwbaKUN
         4rH4tL3cezxOcwOhbk+vkntaqY2CmD2d0RNwEHStxTNt+IIXkSX4Tnd5QgdK4enT6J1e
         h/q4X9dhk8UaTHtJvi7Ba5i5ML0GM4e5tHXfRVvUV04xuX3e8N4UC5xohG9gRktikkvA
         aPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fMIUUqpRmcOIVsAmoPZUiQSn77rxtiKG7esDDCKFh4U=;
        b=XDmQVrMM4vV2VDVqYbV6vOSVjV6x6SNfobv1OsQ8Y1Xbo5TCahz75YysNgAMb/+d+W
         mJBoPVz7ZLZYam8wAi90m/z83P5DTAZLVst/MjoJ8X9k0lUeBldKpGYAC1eCfww6+9lS
         xDtSM6OVfUbD93tyd8Rg1SgHdvhk0JigugOsaF/WmuMwGHgvpn0MHJabEP+/reARuc6F
         3Z3jFmqevX+C5Lm84B2B1g6aH92wWlTRyU7+u2egs5Q9fZCcY/7U0Xt8sNRa4Y7f7nlI
         8SUqaDeGoma22mnOUJY3VzywCErfdgsBVrNMJ4VhwwWuVa+5H6RKuZ6+309PEdLDYr/v
         Xhvg==
X-Gm-Message-State: AOAM532OwHIEMy03CnxtY3yE81TFlfdav16LsOlXhYiOKjsW0aMBc0E0
        6QBPNnvhmjdl5ugqWqham6AFL3eVMuUDWQ==
X-Google-Smtp-Source: ABdhPJzR3BznlUSWfDle/Vkxz1YIXY8lrBMA32Q3QPXTk18Nz4gKt2TJ/X1b8ukKy8G5g7rSOY3GXQ==
X-Received: by 2002:a05:600c:a05:: with SMTP id z5mr4404677wmp.73.1630416950702;
        Tue, 31 Aug 2021 06:35:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u27sm19073451wru.2.2021.08.31.06.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:35:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/8] tests: annotate t000*.sh with TEST_PASSES_SANITIZE_LEAK=true
Date:   Tue, 31 Aug 2021 15:35:38 +0200
Message-Id: <patch-v3-4.8-0cd14d64165-20210831T132607Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.805.g739b16c2189
In-Reply-To: <cover-v3-0.8-00000000000-20210831T132607Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20210831T132607Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Annotate the t000*.sh tests that pass under SANITIZE=leak, these tests
now pass under GIT_TEST_PASSING_SANITIZE_LEAK=true. We skip
t0006-date.sh and t0009-prio-queue.sh due to outstanding memory leaks.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0001-init.sh       | 1 +
 t/t0002-gitfile.sh    | 1 +
 t/t0003-attributes.sh | 1 +
 t/t0004-unwritable.sh | 1 +
 t/t0005-signals.sh    | 2 ++
 t/t0007-git-var.sh    | 2 ++
 t/t0008-ignores.sh    | 1 +
 7 files changed, 9 insertions(+)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index df544bb321f..8ce04bcabd2 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -2,6 +2,7 @@
 
 test_description='git init'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 check_config () {
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 8440e6add12..3dcb3d16944 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -7,6 +7,7 @@ Verify that plumbing commands work when .git is a file
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 objpath() {
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 1e4c672b84a..4ef24a35ab5 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -2,6 +2,7 @@
 
 test_description=gitattributes
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 attr_check_basic () {
diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index fbdcb926b3a..35571947ec5 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -2,6 +2,7 @@
 
 test_description='detect unwritable repository and fail correctly'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index 4c214bd11c4..cd3ecf403e0 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='signals work as we expect'
+
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 cat >expect <<EOF
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 88b9ae81588..bb8353e6d32 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='basic sanity checks for git var'
+
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success 'get GIT_AUTHOR_IDENT' '
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index a594b4aa7d0..6daa7ce529e 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -2,6 +2,7 @@
 
 test_description=check-ignore
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 init_vars () {
-- 
2.33.0.805.g739b16c2189

