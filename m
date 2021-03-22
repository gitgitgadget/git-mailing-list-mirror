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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D61FC433E0
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 11:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021646198B
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 11:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhCVLtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhCVLtA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 07:49:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FDEC061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 04:48:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v4so16343808wrp.13
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 04:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RAlt6IxbRNIP6MK7rj5eoXA07xa1KJhdACkV3kIPtSI=;
        b=FH/XhDyKt6XyK7qOGiT60tltpyLAgoeiGLHVe+QrL9Sby8v2yHjckHas0taAb+SqLW
         9XMUEIQHmvTUqi9T7QTrEJ27XqBNzbzAKY7AkkuNNatTy/kpIGrmthhKov9Xxd+3syv4
         ItdxWfmTadYxLZiNe66PSj/kmLTscq1sW1e2hdGXVDJH4G9q0qZXsU//kBUsfmKx1dC7
         cXKUU43RYxjqFvnhg4KSLprmOYUW5npGZaFNSsxpkonMAF4JjJd0fo/c0bk56ftoWKJz
         lVQ5ymSCG3/YAH4WQxf3WHNgbLPlN5k3DXCcixzCveW7agqO6pdrYz1egun5nPfScZ2q
         KUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RAlt6IxbRNIP6MK7rj5eoXA07xa1KJhdACkV3kIPtSI=;
        b=Pn2s6WwKXLiPColJpGzbu0FBfpPOjIOyQO50i2B/nuMzTeAO2vGt1LmlbnW0MQeg+K
         InomJxy967Wr51uiBTlYK9u0CCqC5B9xiJMZnNaUZE4SZbgF15RloGhhCXUaNsTfBuNm
         EuG4/eGAaJ8rb555fmuvobqxJzTNMCGrd6jV/vgZgQrcqCI8cd46qSpZgE49Ppwd2Leb
         rwiA5Cr2cQsxmKxA/rUiVtfQvcv5mma7Dzgx3pPFYEscZmCOT625fxvHege0Xnmae9rs
         cQkFohkBuhWYLSlayizZDS0+KdKdb5PhM+4dWo7RZTDkGWc+/o0VvgxmmCrK9mDq9BJu
         VGyw==
X-Gm-Message-State: AOAM533B6vxugxFMdoK7zmDTcegZe1hiWypZygPHdH7hC2nb+tFg6Cd7
        REyOh5bG+H2r8zutlLUeM31KdmoZdG00wQ==
X-Google-Smtp-Source: ABdhPJwaRoqy8pNLrok613JAO8gp/jO3n215d5crbchr3PuwR5rXjdMen2eTmFT0JHtX1vc9CIq68Q==
X-Received: by 2002:a5d:4ac4:: with SMTP id y4mr17528698wrs.86.1616413738097;
        Mon, 22 Mar 2021 04:48:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i11sm19768945wro.53.2021.03.22.04.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:48:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] rebase tests: use test_unconfig after test_config
Date:   Mon, 22 Mar 2021 12:48:24 +0100
Message-Id: <330b33e7a8e87e528aec43c306753cdf573ed8af.1616411973.git.avarab@gmail.com>
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
rebase.rescheduleFailedExec, 2019-07-01) to reset its config after it
runs. This doesn't matter now since it's the last test in the file,
but will in a subsequent commit where I'll add new tests after this
one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3418-rebase-continue.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index fe407e63cf1..ea14ef496cb 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -283,6 +283,7 @@ test_expect_success '--reschedule-failed-exec' '
 '
 
 test_expect_success 'rebase.rescheduleFailedExec only affects `rebase -i`' '
+	test_when_finished "test_unconfig rebase.rescheduleFailedExec" &&
 	test_config rebase.rescheduleFailedExec true &&
 	test_must_fail git rebase -x false HEAD^ &&
 	grep "^exec false" .git/rebase-merge/git-rebase-todo &&
-- 
2.31.0.285.gb40d23e604f

