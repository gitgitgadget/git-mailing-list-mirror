Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7211C43457
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D7B6221FC
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX3UxumR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388634AbgJSWro (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 18:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388622AbgJSWrn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 18:47:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C3CC0613D0
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:47:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e17so1432852wru.12
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YDGjg72DiBHMJo7ao0V16mKGbZgzL/e6IJE1LLIK85I=;
        b=WX3UxumRfS/gdVd/zWfsms6HmKX1ORIt1XvRYBi8pGWNGCQhBNFJik4sJMeIpjnGR3
         8Hu/PRIgC5OOc8WtRw0weVpK9CsSvDsGxGx71nzFviuk1+Kjifiy95WP+uu3zxdpvunV
         ULyFsOJ88xMiZgEhEqRyC7Q3xd+om6c1oTXPoEYF3h6zuVFxHDmRA2veWG2cN3cfjzfX
         VsViT0NO5iHXmo/G/cLcTRj55SA58rFGlTdsYLmVMEzfGZ0c1W1N3n+43cgKN35VKi9l
         ojKpT4/v7o5SQcbhumSv4cJuBPTBglYl2FFN7r+K6aUXrtqsVTJ9YmKJG7sOoRqJJNTg
         uu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YDGjg72DiBHMJo7ao0V16mKGbZgzL/e6IJE1LLIK85I=;
        b=W7bVJSYBMjUoFBdihcj7wozid9n/QDGhIi2LT/7hWJJ8Ue2jj5s89fVK0vQvXbI/S7
         DZlgrjkQM5SEOF6dsmXYXEkw/k24Lmj1w5fH5L5n6Xj8ochDheRo2v4pmyW54zttWAv8
         7+tnQzWjX+6w/DGQ2JnbawI66IgGWBIxnIjhEA/Bnx3MmO8aKayOtWDJpL4Fycw07sag
         /z7eT5tHZGE7W8JcvlNxoqfiCata8x1V3Eoxgf+fCyc5mBEzIaBgoAUpqQO6pXXQ0CM2
         Dh+O/QqVTAulmSOFiYD+rlA8qNL5hzbigwYdEhLh2dUBkHtEy8fTFyvO20p8+l5bcRex
         u1hg==
X-Gm-Message-State: AOAM532Xz8UceRhubC7CSX1DoKcnWmm2FuWgQS54hTf2w6fYOk+T6GX4
        tFeR6CJ1mYcZH8B1TgPO+3G3dVN9bgU=
X-Google-Smtp-Source: ABdhPJxR8AaFfiU4t+bN8t6dXTa3T8yHau/+xxViT3BhgqDxAkGAr2t+l+PGs4zt95geTXd6F00JXQ==
X-Received: by 2002:a5d:49cc:: with SMTP id t12mr1690335wrs.342.1603147660369;
        Mon, 19 Oct 2020 15:47:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o5sm1491544wrw.76.2020.10.19.15.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 15:47:39 -0700 (PDT)
Message-Id: <1c7876166f5d9262c44c9df0f613e7d0beb98722.1603147657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
References: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
        <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 22:47:32 +0000
Subject: [PATCH v3 2/7] t/perf/README: elaborate on output format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/perf/README b/t/perf/README
index bd649afa97..fb9127a66f 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -28,6 +28,8 @@ the tests on the current git repository.
     7810.3: grep --cached, cheap regex       3.07(3.02+0.25)
     7810.4: grep --cached, expensive regex   9.39(30.57+0.24)
 
+Output format is in seconds "Elapsed(User + System)"
+
 You can compare multiple repositories and even git revisions with the
 'run' script:
 
-- 
gitgitgadget

