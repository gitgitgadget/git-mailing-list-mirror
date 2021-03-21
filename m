Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72178C433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 12:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3582561952
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 12:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCUMk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhCUMj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 08:39:56 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980A1C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 05:39:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p19so7947011wmq.1
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 05:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xx5pKo+A9qPnUXi7+EQGuvJamDi4qYB6HMmdkyAPxCU=;
        b=QULUvDZEAwHNxl7tU9Vk18IlH1+MXkdvTNTWrk5r8lVvUQE20jBElQ+OVMH39DBOcW
         1CfOupXcPSbfaFVd5fqVPH2daB58sTw69AaSbT3gJ80gvF6umA9ps48i043wK9pG1wIm
         OMUOqFFoqJTO3Pq1p0j7Z341etdEbn98Tl1QmxJwNBCi9uGCL6aWfLn7Ywd5N3jufXan
         nlsPeKKxZH3kwY1sAYznKg2Sxjur2GIinmTGDf4dKrgdHZrzcmz5d2K2V5rM31M61Pij
         9Ce63zuQoZDl3TQrAKszpMp7jWvIxuJKoUjPxg4fmE37umyApMp/QzVfOrY1tdYCzwj0
         QCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xx5pKo+A9qPnUXi7+EQGuvJamDi4qYB6HMmdkyAPxCU=;
        b=pEWoi+6qgIp+AZRuAxVMzpwd3ia9DGXWw53303mCEwOnbxaXq5QTUSBxiFhhcnsNSn
         cyRjO93K9ey3CguKMYlgIVq5xF44yqSxmjWQud0gePGako0s+NWsuEa7RgVRS4IAZ9K2
         mERVISsLt0JgXIK1ZqoKE4cZ3eeJ3Tg3pz1KHAEIHzbPuAItdmmSlSCOoFU2iHafSO7z
         7LqZwTKCL/LXyrIPORO20yM+MyzXvxijgkwFKQXwLXTKO5Hlb/20j+Bm+nCuPF5inIXO
         mAVlEAPDcPElhcc0DrOEnkMw1qYLy6RHSb5vG3g8ogmlSXomJ+LwaLR8YiDWUzpGOxUa
         IQuQ==
X-Gm-Message-State: AOAM530CNzHzLXgn42HdfitlJxutiGCTxIAvr+o47xEb8FVrDMBFgeD8
        o5ZgyAlb9kSVtET7zucD4lBgnhb72IeKWg==
X-Google-Smtp-Source: ABdhPJyIPc5I2puH9JtCquI3+fSle5Be/TsQ2OMv6f2qQzlCiKZ8j2A77bcCirv5A+c2IHGjscO24Q==
X-Received: by 2002:a1c:2049:: with SMTP id g70mr11754726wmg.7.1616330393859;
        Sun, 21 Mar 2021 05:39:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m17sm16633279wrx.92.2021.03.21.05.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:39:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] diff --no-index: fix test blind spots
Date:   Sun, 21 Mar 2021 13:39:21 +0100
Message-Id: <cover.1616330120.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <87wnu0r8tq.fsf@evledraar.gmail.com>
References: <87wnu0r8tq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A trivial series to add tests for "git diff --no-index"'s mode
handling, and a missing test for how --exit-code behaves in
combination with --no-index while I was at it.

This would have caught the regression I inadvertently introduced
in[1]. It's related to my much larger tree-walk.h series[2], but
applies independently of that. I wanted to split it off as there were
no conflicts or behavior changes related to canon_mode() in that
series anymore.

1. https://lore.kernel.org/git/20210316155829.31242-2-avarab@gmail.com/
2. https://lore.kernel.org/git/cover.1616282533.git.avarab@gmail.com/


Ævar Arnfjörð Bjarmason (2):
  diff --no-index tests: add test for --exit-code
  diff --no-index tests: test mode normalization

 t/t4053-diff-no-index.sh | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

-- 
2.31.0.282.gcc1ec606501

