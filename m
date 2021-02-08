Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F608C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 14:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3BA764DE9
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 14:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhBHOxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 09:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhBHOxG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 09:53:06 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A270DC06178A
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 06:52:26 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v15so17457994wrx.4
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 06:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=95LPGhTEtAG3JlrcCW4kXMbvZZTLIHQVIxp+tWdnO30=;
        b=ltaL/HIXG3xoSilQesr5SVfpLABtNCOhuk9M8nQdK9KSB3CmWML94kSmZN2Krt3JUj
         BiDSYBaFUHpxy4gS6ZM4TuWbtVFxgjH6C7QhABvDKW+01yIX1u+SbfDASLpADroX88xL
         VZM2JjYpPNZGuNVwxkk5lbJjK5aZVMm9s+UO93wZjOtJK5pjBXko+z/OH4dxaLPsNErs
         EEgQtPCY12UwoUiBOVV65JzZql5wwa3VVxh6/dYbbe36oCfAWqh6NZqEFPTAj32wGNuh
         kijSRCNeezgws1BQx9tgUoDi9ARAtTewvhvnytsGtt3p5cdtRF3+9LRQv2hrwMeeVRQQ
         blFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=95LPGhTEtAG3JlrcCW4kXMbvZZTLIHQVIxp+tWdnO30=;
        b=dQI0QE2pzvjZ9QS4YKsv0PGEzfnIZVwfWjI5TxE1FTxDuR2ullwKIkEbGHl8qZQ9mf
         CXMYohYfNg45OQQMYYuVI7n54lwwPAkmRU1Kqsc7d8pq0Ykdc2pfnd94w9lkIGfJyGqH
         z8yFGlSeOMzzOC6La2QLrXtNjz7bx7QIaD1/pF8lZRXv6KpUz31Ea1GgVGfnDGr2HRl9
         xeDDpkcu3d539qWcu3JJnu9VK2gNFSQ32vkK9lB8tMbRxpgOwsK/u86GLqFoURU9E8dg
         Ja5miaiafl0jObk5D5RRSK75RF7IPy9NngSKomfAwL7gRNpVkT+kyOCXhcBVdzaOCJkw
         GXoQ==
X-Gm-Message-State: AOAM530o0rg4VsvESmK2HW9onLjuPvST/ZjFyezbgpWmU/XISl2mWwqd
        nUWqCDHjLs9e5jsMgdk5OUQ1S50Ogv0=
X-Google-Smtp-Source: ABdhPJwDzYDifiglaXH7DbZCriOhXsR/j4K3ouB4DSNJarOc2fwl52GU71O30LljL69OD+lXbovY1g==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr19793406wrp.422.1612795945160;
        Mon, 08 Feb 2021 06:52:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c11sm28311744wrs.28.2021.02.08.06.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 06:52:24 -0800 (PST)
Message-Id: <pull.871.git.1612795943.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Feb 2021 14:52:21 +0000
Subject: [PATCH 0/2] Maintenance: add pack-refs task
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sluongng@gmail.com, martin.agren@gmail.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series adds a new pack-refs task to the maintenance builtin. This
operation already happens within git gc (and hence the gc task) but it is
easy to extract. Packing refs does not delete any data, only collects loose
objects into a combined file. This makes things faster in subtle ways,
especially when a command needs to iterate through refs (especially tags).

Credit for inspiring this goes to Suolong, who asked for this to be added to
Scalar [1]. I've been waiting instead to add it directly to Git and its
background maintenance. Now is the time!

[1] https://github.com/microsoft/scalar/issues/382

I chose to add it to the incremental maintenance strategy at a weekly
cadence. I'm not sure there is significant value to the difference between
weekly and daily. It just seems to me that weekly is often enough. Feel free
to correct me if you have a different opinion.

My hope is that this patch series could be used as an example for further
extracting tasks out of the gc task and making them be full maintenance
tasks. Doing more of these extractions could be a good project for a new
contributor.

One thing that is not implemented in this series is a notion of the behavior
for the pack-refs task during git maintenance run --auto. This could be
added in the future, but I wanted to focus on getting this behavior into the
incremental maintenance schedule.

Thanks, -Stolee

Derrick Stolee (2):
  maintenance: add pack-refs task
  maintenance: incremental strategy runs pack-refs weekly

 Documentation/config/maintenance.txt |  5 +++--
 Documentation/git-maintenance.txt    |  6 ++++++
 builtin/gc.c                         | 23 +++++++++++++++++++----
 t/t7900-maintenance.sh               | 24 ++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 6 deletions(-)


base-commit: fb7fa4a1fd273f22efcafdd13c7f897814fd1eb9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-871%2Fderrickstolee%2Fmaintenance%2Fpack-refs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-871/derrickstolee/maintenance/pack-refs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/871
-- 
gitgitgadget
