Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C478AC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 13:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242147AbiCBNXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242138AbiCBNXW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 08:23:22 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C499F10A6
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 05:22:38 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so1229550wmp.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 05:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=59QAL6uD0ZwwSFvb/G4QuJN+OGihBCcNKvMvlH8MtZw=;
        b=l2q+JPpSnrjAabrE4CBkPBDpi4yvxi8uctoBHeyVlnZ+7LicXxoDinR1u2Ob/dX7eA
         po2iDs9IvCVfdv7tjg8p0/395CQdXE1p9pUV+UiERTqDFaoUF2FJDRJShzdm3yTWPQ//
         SQlZmSXYwIjiyUTaizwGWfsMqccbb+rFm1GaxD2xAOWJwsX8+B5s5NEHghW3v796mWLv
         yxyGvrprUrCNK6wsbBJlaofwqQplUKbdsBcpb99D9VGYCjnK9DtU7UJuJGTvcxU0hLoK
         qHPMrHAi7VuDLdMFkQyHiVIlhrSVQ9hmx72V56qivaO3V7x83i3nHw2Ot8bDXJx4DmUv
         5gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59QAL6uD0ZwwSFvb/G4QuJN+OGihBCcNKvMvlH8MtZw=;
        b=yUHyOXME/0BpLWaDXfoQu6plLzEsaE8H3+wV6uW0GQ1pk/t/uWE7oSme99faX9oZTK
         jA02zM78NYgZIuhwzdDuh+nxQVZ7b2bm0FdykOnpwsxg+a/qLbkF/zBrv3XRjuJHtS0m
         9Frk2qiJ8Ypaynb7XdmXs77NrwKbhe5RI9pVIicaeLOQBe0vl30Ii/JOXIn3ns3JxceF
         YFbDfJYnNv95ll4TbnnYJoj3A5rwzo2jBIzqlvkikg9w0wNK0afnXwO+unnEaaobNR+G
         8NPJDR/IX/QuTCFT6vt08bj1vbwWK19OMi5a1vWXEzJcMl12Rph7Fb8oDY1wqfIr4edm
         1q4A==
X-Gm-Message-State: AOAM532iMWDrtUI97X4+rHvPl/WtNwPJ/Kvz4cJch4m/fQr77VfcmnVD
        1tjanGWnLpqJmV+e8HiPdMst+vP8RAwxJg==
X-Google-Smtp-Source: ABdhPJwMcIIVzMDgIAJl6N9N1IQLSGgphxPat89hyth4MaJMMxWO7QYOm3e8VaBm0CUALRqF04Q8LA==
X-Received: by 2002:a05:600c:35d1:b0:37c:d45c:af57 with SMTP id r17-20020a05600c35d100b0037cd45caf57mr20926189wmq.149.1646227357101;
        Wed, 02 Mar 2022 05:22:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d648d000000b001efd62a840dsm10814197wri.111.2022.03.02.05.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:22:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/10] tests: assume the hooks are disabled by default
Date:   Wed,  2 Mar 2022 14:22:22 +0100
Message-Id: <patch-03.10-0519102edeb-20220302T131859Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
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
2021-05-10).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1416-ref-transaction-hooks.sh | 1 -
 t/t5516-fetch-push.sh            | 3 +--
 t/t7519-status-fsmonitor.sh      | 2 --
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 4e1e84a91f3..d21dd5e5df0 100755
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
index a6308acf006..63a0f609866 100755
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
 		: >modified &&
 		mkdir dir1 &&
-- 
2.35.1.1228.g56895c6ee86

