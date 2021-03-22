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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12770C433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 11:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A6A61993
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 11:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhCVLti (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhCVLs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 07:48:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3A7C061756
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 04:48:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id 61so16328567wrm.12
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 04:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+mDlYLMSjpoFVZ97kXmRHLzzXi0CGl+E0bD1S68SCAA=;
        b=BIi+t3NHxQhw6dQikEjwuIauv/oS9MMyy+/ZOrere6ohxab1Jy5ztllMV54oUI7l2+
         axQNcLB0TuARdqkv/sqd6vbPF+nV8rcjh1QBV5EN2qVnTeQbsF4PVQ8aPr2fQQ4jRISr
         XLa3vyj9t7N6/zpqL8rcBPOIRqrJSHMDv7kr8lorcd7AuFtnmTwdg5MWX6uLl2fUhWGa
         Wye5VubZR2uMc6ij5BYsaXBQfglaSKM9n1QYnCu1MLvxdgLqa/krQp1jpWbQUGpyVtI4
         13hPbrEvCP3K3ucB13WgoetEhwzr70R6iLJaGvVwScRPjZqhiO76B192Em1vQ2syfM2d
         rqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+mDlYLMSjpoFVZ97kXmRHLzzXi0CGl+E0bD1S68SCAA=;
        b=aM1iJL++mz7AAOyIia9kTfhF8YXY7ZQIomCJcWWgVAZpcuaovT5Z8gY2ROKQYB+7Du
         6MClEd1g8o2ZFRbGFgFVIQ9yoCdSct+gLlzOhAzAIB+kYBFGCbQxjEASP2JfFqbqmkTA
         HPRtPPypC3B+Yn7LCMZvoodVAx4kYj1njC/sETCb0Xap66/HUkJEAZWuZzxdTRUpaK1u
         G86omYX1wydR/+1x9+hMN5wutzWmK/YIXcKoKygWxzyRwPCbYAs7VxffNDcdfMs2hIaS
         HtlgfQn0lOy6rY12S+LVgZHnaYe7lkNV4ERLdzbV6zLuJK3fSIfkyGhYFrIJ0SKIvoB3
         Dxlg==
X-Gm-Message-State: AOAM532HaBp0Ka+M0ehdMqgvMwsITZoLfqeYuWTUtMLCS5L00NNDZ4gv
        A9yGwQYnsadDAv3FbqWD0f0+JQukRDGWhg==
X-Google-Smtp-Source: ABdhPJwTfTEVqJY+0HdQ6D3rvsQFSygPzCvpp63tGPT1d4vOu+vId3s+SEUcHooJOIpQTFfuZ32W7w==
X-Received: by 2002:adf:f704:: with SMTP id r4mr9174415wrp.158.1616413737218;
        Mon, 22 Mar 2021 04:48:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i11sm19768945wro.53.2021.03.22.04.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:48:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] rebase tests: camel-case rebase.rescheduleFailedExec consistently
Date:   Mon, 22 Mar 2021 12:48:23 +0100
Message-Id: <002dc72ee72dc31a6d756c762f9fc1150ab88142.1616411973.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.285.gb40d23e604f
In-Reply-To: <cover.1616411973.git.avarab@gmail.com>
References: <873d1fda948855510b07f9cb75d374c03d60a94e.1544468695.git.gitgitgadget@gmail.com> <cover.1616411973.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a test added in 906b63942ac (rebase --am: ignore
rebase.rescheduleFailedExec, 2019-07-01) to camel-case the
configuration variable. This doesn't change the behavior of the test,
it's merely to help its human readers.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3418-rebase-continue.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 0838f4e798a..fe407e63cf1 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -282,8 +282,8 @@ test_expect_success '--reschedule-failed-exec' '
 	test_i18ngrep "has been rescheduled" err
 '
 
-test_expect_success 'rebase.reschedulefailedexec only affects `rebase -i`' '
-	test_config rebase.reschedulefailedexec true &&
+test_expect_success 'rebase.rescheduleFailedExec only affects `rebase -i`' '
+	test_config rebase.rescheduleFailedExec true &&
 	test_must_fail git rebase -x false HEAD^ &&
 	grep "^exec false" .git/rebase-merge/git-rebase-todo &&
 	git rebase --abort &&
-- 
2.31.0.285.gb40d23e604f

