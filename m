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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6542BC433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 03:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D719224B1
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 03:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbhARDY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 22:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbhARDYV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 22:24:21 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8EFC061573
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 19:23:39 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id s24so4197459wmj.0
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 19:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=PHqdR9tCKvi4R00w4RjFeG5mLuGNP/Z3qb3sAz3fNeE=;
        b=NwhLKLF8z2F6kTrhULzaePgRbj9TVWcHvioJmzLAy1F0buUVdpoEVDDZj9d9iQvMfn
         L3cDfRyjNIS5fyoYrkDd6irM10t8CyCr3NUwuaDrxjOa2qmQCLu61gA1m8XU1Imp3LuD
         NPwEIOCuhq/vLo2cwl60HTzlpHLrH9EgL6bk52p9mhvQr4n1VpI0VFCLqUolx+vquZUf
         1frdzCl2yxjQvM2KvpdWAEwbGGA/fUwrNWxXjvEhu16MjVa0xHBWzYHZL4EM2IlZ2QKl
         KJ4Lm6WqsaHqJI463WlXsRHviSL4gjmr+C2lCTAwrT1N7egnKKHRSPMImETPx31h4hE2
         Pd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PHqdR9tCKvi4R00w4RjFeG5mLuGNP/Z3qb3sAz3fNeE=;
        b=eKcF0siFv+KbbOpmfJNtWdOnZhALz/ElBYaFfpoSzt5Et6Bvsx5NDRDOCu56wfgwdI
         WHZkn+rEDuGP02CNxDnyuGMEmN3zb2RVX1WBH5zSd4F8+QAA25Q0DrZ68LB3WJ/0Ytnd
         vh0YQTRKa+yHnkzUvwIPyh3xfZjuel43zpPgS1eACGDHwM0bnwrWa+ms90E4xjnME1mY
         SFE3pjVsq8BOVqupJqWXr10XQpA14eNlEOjh4wRI8FonKp7+tRBysWeyBrjUa0Wr2Zdj
         9BfrPN2YK8qNc+CwoISRTDey4+vtfwhRTqFD2M/nC3N5x8GYl469o278FWThxIq0cH/0
         S1uQ==
X-Gm-Message-State: AOAM531FZozTMy5qTqmRd0L9xr+ddX721Xd8QanaSmgKbLHMpn+n4M2k
        yRVsDIF2SJ5O+sFAU1bb6T+IMmB5dA8=
X-Google-Smtp-Source: ABdhPJz3qY3t9OtxMhjwJMkf3qiT8+NQIzEVkEtyrEAJPEPFqwJu/Egqft1wAIe3W2xqMHT0gVaBTg==
X-Received: by 2002:a1c:1bcc:: with SMTP id b195mr18909899wmb.131.1610940218208;
        Sun, 17 Jan 2021 19:23:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s25sm28639037wrs.49.2021.01.17.19.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 19:23:37 -0800 (PST)
Message-Id: <pull.838.git.1610940216.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Jan 2021 03:23:34 +0000
Subject: [PATCH 0/2] Two cleanups around 'prefetch' refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Eric Sunshine <sunshine@sunshineco.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are a couple things that caught my eye during a recent evaluation of
the maintenance feature:

 1. 'refs/prefetch/' refs show up in 'git log' decorations. Auto-hide these.
 2. t7900-maintenance.sh had some scary warnings that end up being
    unimportant.

This is based on 'master' at 66e871b (The third batch, 2021-01-15).

Thanks, -Stolee

Derrick Stolee (2):
  maintenance: set log.excludeDecoration durin prefetch
  t7900: clean up some broken refs

 builtin/gc.c           |  6 ++++++
 t/t7900-maintenance.sh | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)


base-commit: 66e871b6647ffea61a77a0f82c7ef3415f1ee79c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-838%2Fderrickstolee%2Fprefetch-refs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-838/derrickstolee/prefetch-refs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/838
-- 
gitgitgadget
