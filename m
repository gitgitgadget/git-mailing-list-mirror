Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4A9C433E6
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A7D64DED
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhA1QZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 11:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbhA1QZi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 11:25:38 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC05C061573
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 08:24:57 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id y187so5055336wmd.3
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 08:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=yzBck/GmgPKFOUVESKDevD3ElZVNL2y3OXT2sT4FOfE=;
        b=YzhAoYxEsh//TM+xOxYV5O/Q1Q24QTBz3cnkNpPJbx1CP6K1s9OB2AVcgWVT+EBIJ5
         +PdPifh1i8FO877yEAw5yQrMAZ0/IT5JRJJrGTIuzt7vWhiWEICO1TBUHNdUgk+iMd9c
         7vpMNsP35w9Pn+HNh5cvfCsyO88kdrGVq1fGsDdxGELrMVQtTyWcyECiPDcO/9WjvnaA
         spkqGfe3mHlfQI75FzubJ4Sp+gieREEYBGxUUrEyMV/inE6FkBO9YgIGHa01mDYeF0px
         37H+1SRDOAiZkyNuQOVipNyV97BYpJzYPQ9OUXEcpAVVe1Lj3A44CpRcKzGl8HfhSVZE
         8jVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yzBck/GmgPKFOUVESKDevD3ElZVNL2y3OXT2sT4FOfE=;
        b=b/8ueMZiLLxRH3lU6kq15QNr/qYIFS3OgFqRlt3JtFbBtLtLW7z2NNeiI5SlmqbYfn
         HXYY6l4UAW8CjHw6IBx38+kDRZXEEw2xiFpLLEHAoL4XfOcUnpvkDq5izbMK1heEFBcU
         0s82S6D3jX4DXckZSOZmVtttonpmIy+2ah9qpAjmsNJpQE2MQ//3simOJbDAY1u/uFcj
         oNGyI92gXig4PBzQ8IABzNVsl1z7EpXfTw7hB0nbI78ShtanVLxewYvJKpsVWxxYyklX
         lY1jpsGtBV2oBuTIJKr4lfmWB9KvR1KzVgMAdfZVeocshOUUFHfZTD/LkxtQIKL+5leI
         nr6w==
X-Gm-Message-State: AOAM530HzZG7g0OxGJOhVEtOmdcslZeKp/Cj5P77tAfJUQ2dtMTGTmai
        6L+vAr37XosZdLW7Q9b5y37q08z15ac=
X-Google-Smtp-Source: ABdhPJyUwUln925f5eBciS6rmQ8A1AdQhmtcERBE3t3Qh0Yl9kReWfFFNiWvkh+Hjs5m5MRfTsmkeQ==
X-Received: by 2002:a1c:4d13:: with SMTP id o19mr50500wmh.134.1611851096067;
        Thu, 28 Jan 2021 08:24:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm7507758wrx.82.2021.01.28.08.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 08:24:55 -0800 (PST)
Message-Id: <pull.852.git.1611851095.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Jan 2021 16:24:51 +0000
Subject: [PATCH 0/3] Speed up remove_redundant()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, me@ttaylorr.com,
        peff@peff.net, gitster@pobox.net,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty pointed out that git merge-base --independent is quite slow
when many commits are provided in the input. This boils down to some
quadratic behavior in remove_redundant() because it calls
paint_down_to_common() in a loop.

This series avoids that by using a single commit walk, pushing a flag that
means "this commit is reachable from a parent of a commit in the list." At
the end of the walk, the input commits without that flag are independent.

There is an extra performance enhancement using the first-parent history as
a heuristic. This helps only when there is a single independent result, as
we can short circuit the walk when all other inputs are found to be
reachable from the top one.

My tests were on the Linux kernel repository, testing this command:

  git merge-base --independent $(git for-each-ref refs/tags --format="%(refname)")

       Before: 16.4s
After Patch 1:  1.1s
After Patch 2:  0.1s

This does not change the correctness of the function. It is tested carefully
in t6600-test-reach.c, among existing merge-base tests.

Thanks, -Stolee

Derrick Stolee (3):
  commit-reach: use one walk in remove_redundant()
  commit-reach: move compare_commits_by_gen
  commit-reach: use heuristic in remove_redundant()

 commit-reach.c | 178 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 120 insertions(+), 58 deletions(-)


base-commit: 5a3b130cad0d5c770f766e3af6d32b41766374c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-852%2Fderrickstolee%2Fmerge-independent-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-852/derrickstolee/merge-independent-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/852
-- 
gitgitgadget
