Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1D1C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F391064E3C
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbhBIXCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 18:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbhBIW1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:27:43 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BBAC03C048
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 13:42:18 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m1so74212wml.2
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 13:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OxIDX2t9E6vAJFLQHjAWinm2/AuckMw/I/VnyOJ6sQg=;
        b=CFgQPxeOFYskZzyyA03pgeCKmmlENXShFd62igsZZOwoYt05eWsIRoc/ykuh+eD0dZ
         TGGEHoO9MmBin+YiMgvmttXBI5HBYPbDn6xolvSmAR5d72YnsLSLWXy42AcAbWcr9tUA
         LWvDa3tFr/fFS0DIzQKTOt9/3+mMLexKYNW8l771/SBIQDyMxTa3zJwwdDkLuCw635bZ
         dQED4CuHdpJDqf1FnN0B/0o5aH467IQgjv3p/xmpBburuTOiDCNK0NJ4f/Nm9mDevl+5
         VdFW/qe5LD1w2sb2rqnFnjMYLU0ZPO3aKOHaatTC26z7s0+GK08uACRfyBBQBmj+DrMS
         2tTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OxIDX2t9E6vAJFLQHjAWinm2/AuckMw/I/VnyOJ6sQg=;
        b=az6D5B69kEeFEkSoHcywdjNy8diCyB6hSCtWmRX6A2EJ2j+dVXFo+NHqmsZg0Mjcs/
         JDtbdSmAqkbqlV4X1t3Vvw9UYiOiqI7zzjQGuxhe+f0ACqwd2NZ5YMLWjGzntzaIRw+B
         jG4Dr/mubO4Cr4VQuzDl4K4E16QlPpl/xys4lQx13p7fEbrVj0Eb/dthqoFY6Tr+7qe6
         pjY4KACbzycTlaA4PHOOmJNivnKfDtGHc7BCor9CvmdAeBZa0na+ZGFYltwz+gi3vPWB
         8ReaLjv4meAD4EpYDa17mJm0qWLgBI7g+isrSyuIC712YBd1dtDHyHB5vp9h2YhqR6uw
         slcQ==
X-Gm-Message-State: AOAM530uysGU5r9/wpJiSFePt0TwfbBpM/3ikoQ7wW04EZajhKYYB4rM
        RwCWe7xW3ChHdcfVxRaYUMbQeLMlKpTBQA==
X-Google-Smtp-Source: ABdhPJykle5aEVrIQSDLU/foMLkoqm7eCpfjv0vaFLEFpcSThV9eRobZRhXLOf8moWfjDBioZbE8cQ==
X-Received: by 2002:a1c:ab57:: with SMTP id u84mr93352wme.115.1612906937340;
        Tue, 09 Feb 2021 13:42:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m205sm38710wmf.40.2021.02.09.13.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:42:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/12] test libs: rename bundle helper to "lib-bundle.sh"
Date:   Tue,  9 Feb 2021 22:41:52 +0100
Message-Id: <20210209214159.22815-6-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210209214159.22815-1-avarab@gmail.com>
References: <20210209214159.22815-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the recently introduced test-bundle-functions.sh to be
consistent with other lib-*.sh files, which is the convention for
these sorts of shared test library functions.

The new test-bundle-functions.sh was introduced in 9901164d81d (test:
add helper functions for git-bundle, 2021-01-11). It was the only
test-*.sh of this nature.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/{test-bundle-functions.sh => lib-bundle.sh} | 0
 t/t5510-fetch.sh                              | 2 +-
 t/t6020-bundle-misc.sh                        | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename t/{test-bundle-functions.sh => lib-bundle.sh} (100%)

diff --git a/t/test-bundle-functions.sh b/t/lib-bundle.sh
similarity index 100%
rename from t/test-bundle-functions.sh
rename to t/lib-bundle.sh
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 42f55030047..c1e0eb39231 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -9,7 +9,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/test-bundle-functions.sh
+. "$TEST_DIRECTORY"/lib-bundle.sh
 
 D=$(pwd)
 
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 6249420a806..da5fe1ba6de 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -9,7 +9,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/test-bundle-functions.sh
+. "$TEST_DIRECTORY"/lib-bundle.sh
 
 # Create a commit or tag and set the variable with the object ID.
 test_commit_setvar () {
-- 
2.30.0.284.gd98b1dd5eaa7

