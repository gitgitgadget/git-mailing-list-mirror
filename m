Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE84C433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 10:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiCQKOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiCQKOo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 06:14:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDFED95D6
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r7so2816753wmq.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2D+X4vDiJTH75TA+I71QjDP9xG9yjdwULbDm5vSVkno=;
        b=cqqCcir2X72gbu6azwPdQoempGmecMu2WBMNl4nOL5QDCQDUZbdy4eDsxTRCWb5t4r
         2om0VU06VQr6hZeafd440IAPde+TG0rYJMYBsuSJtexApbtjJNBYNUB/xd66PlZ0VG+y
         44TfwgYRev+TocWgVfHLoD7DaF/zvNjNRrC/h8GOssCQtIfHNWZ3J/ijqb7XA79h7GXM
         OWO6zgx9rUc5cU88Hhd9bU00ghs+b/PK4q6byZ4u9UFGwRh7TKZPVCz44OVnpoDAjh6h
         uajcwfl1wIt++GM1hngMDHKxHZxxc9HV03FH26IVtTUwcStEDIpznZmjMnyWhAcm+AFD
         TTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2D+X4vDiJTH75TA+I71QjDP9xG9yjdwULbDm5vSVkno=;
        b=7NCX/ABuljspHZwKUX3iTBhNijddSoejdK1D+nZn+U14KC1R534GbjViI5Qa93ezN4
         b/WYZOyBZDgVH2GVtTDTbbXBcA5QqUjsEglRVSWwb1D0JCuRui/FAEco51mSsjLjO4cI
         BCsOvZL9Yhs6IMOuyA7QAzYIMHiTcTE3Yc8XmOpoz5m8R3CHnZ27JEO1BjHFXpbNAjzI
         GhS+9O49n0D4yjknsqmin0WaqRBDUcGqPg29ac1eG7KRjb1N0D/Bvv2vq34AUdniYgf3
         9M777DEpP206E8LO3efs1P5Ibwk9/fecmc5dB/p4dVsaiuVbNr4AluS/X7NLKiKL5fHD
         G82Q==
X-Gm-Message-State: AOAM533GF7ycZZubrP1dEj0J+C1QET+/4BdVMZ4npPTKME87bJ8sftk5
        CtzOXJ1mukYmIQgiFAnR7c0y6D7CGL8=
X-Google-Smtp-Source: ABdhPJyiAYDW7Lfrh5Kqs6llHBiEWqoFDMOP8MuYQti6lsIq/31297JTQ5Yoh6rWLSP+gzcUDHFVNg==
X-Received: by 2002:a05:600c:4fcf:b0:389:ec8c:b427 with SMTP id o15-20020a05600c4fcf00b00389ec8cb427mr3131226wmq.152.1647512006853;
        Thu, 17 Mar 2022 03:13:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b0038bfc3ab76csm3903236wma.48.2022.03.17.03.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 03:13:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/13] tests: assume the hooks are disabled by default
Date:   Thu, 17 Mar 2022 11:13:09 +0100
Message-Id: <patch-v3-04.13-3a3289afd80-20220317T100820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop moving the .git/hooks directory out of the way, or creating it
during test setup. Instead assume that it will contain
harmless *.sample files.

That we can assume that is discussed in point #4 of
f0d4d398e28 (test-lib: split up and deprecate test_create_repo(),
2021-05-10), those parts of this could and should have been done in
that change.

Removing the "mkdir -p" here will then validate that our templates are
being used, since we'd subsequently fail to create a hook in that
directory if it didn't exist. Subsequent commits will have those hooks
created by a "test_hook" wrapper, which will then being doing that
same validation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1416-ref-transaction-hooks.sh | 1 -
 t/t5516-fetch-push.sh            | 3 +--
 t/t7519-status-fsmonitor.sh      | 2 --
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 6fca1f08d9a..085a7a46f21 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -8,7 +8,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success setup '
-	mkdir -p .git/hooks &&
 	test_commit PRE &&
 	PRE_OID=$(git rev-parse PRE) &&
 	test_commit POST &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 3137eb8d4d2..1a20e54adc1 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -28,8 +28,7 @@ mk_empty () {
 	(
 		cd "$repo_name" &&
 		git init &&
-		git config receive.denyCurrentBranch warn &&
-		mv .git/hooks .git/hooks-disabled
+		git config receive.denyCurrentBranch warn
 	)
 }
 
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 4c7c00c94f1..d4f9c6a837b 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -56,7 +56,6 @@ test_lazy_prereq UNTRACKED_CACHE '
 '
 
 test_expect_success 'setup' '
-	mkdir -p .git/hooks &&
 	: >tracked &&
 	: >modified &&
 	mkdir dir1 &&
@@ -322,7 +321,6 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 	test_create_repo dot-git &&
 	(
 		cd dot-git &&
-		mkdir -p .git/hooks &&
 		: >tracked &&
 		test-tool chmtime =-60 tracked &&
 		: >modified &&
-- 
2.35.1.1384.g7d2906948a1

