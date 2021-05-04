Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407AAC433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 09:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090C661168
	for <git@archiver.kernel.org>; Tue,  4 May 2021 09:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhEDJ0p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 05:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhEDJ0o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 05:26:44 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3880EC061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 02:25:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a4so8600228wrr.2
        for <git@vger.kernel.org>; Tue, 04 May 2021 02:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=f2dzI2PwjWClI2ekJTmM1Luy6n/0iuXJXPE1PiKyA3k=;
        b=R0UVjzzHlJCzl+81lTKkKY4pZ+tzmFRqgfPC1ZJpeeSMJ6zIsBw1do9gGVhqRMRe5T
         BkF8sL6fEuLpW5QerQX78JDGrl0G1Ww9Qy9KxJjGJGC15k3bQe6ZKCzbPxdEN0mMr3nj
         aKshsMDu/m9jlryB7MafIAK0P+oxMvarOe9vWy3C/GVTkeagCzA4OByDQK0vexypyf/e
         Rl7ZkXCJXtk4gKGRvd7RNE+L3lqO7L0EJrbKc+G+IPV4Eicw3kwpR7vLv97WN6F9HxO/
         9m4cLKIyneXeSVJ1Qe7EAoKMzhDtVOhT4YDP6AilnWfm+z/3WkBwuMHjpoe2hGXF7h4B
         Ue3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f2dzI2PwjWClI2ekJTmM1Luy6n/0iuXJXPE1PiKyA3k=;
        b=eCgBrYVp6u8cmw763I6lKqujWiRxD9iWI5BHL1VsBLICvXNoVK5RWoeE5Z8q/4wk4H
         erTWmSaD4HGTWp7Gi/+2TWvpK6z5uuPQ10CdijRouJkmtyWb5TBoIkY/TnwljIOGDkFG
         EEsGIbptJskNCU2y0WVbB76V4sRdWZqe1bhz1JW6So0ath9t682IGNRlmYdTEOz3oCSZ
         l+RWRThaWYaQWfgnEBP9WSOCvJMu9jIUED3pe1DCUyWY/g+LkjuuPKVxE9pEde7UWqSK
         XOGDHNWGboPGJrUsnf++stwLgmDBgjsQbGdevqjli6wuL30Ro7cTyXMW6q1kApO+P/hP
         iBhQ==
X-Gm-Message-State: AOAM532Hj4YWtJvq5y34/9cV3eFiHCh7Hpv7tyKqY/yW6v/WUMxiFNtQ
        3zOtBrpJ3HxqqyKavbO+oJ8s+eTmMrI=
X-Google-Smtp-Source: ABdhPJwCYyMKowWa3eRBq7sqX2DKg8jahSVpG2IgfXWgOQ1WlZLXrqV5yxJNAl0JWrytTUQNyAas5g==
X-Received: by 2002:adf:e0c8:: with SMTP id m8mr31096254wri.349.1620120346973;
        Tue, 04 May 2021 02:25:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17sm1870407wmh.25.2021.05.04.02.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 02:25:46 -0700 (PDT)
Message-Id: <pull.948.git.1620120345.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 May 2021 09:25:43 +0000
Subject: [PATCH 0/2] A couple of small patience diff cleanups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove some unnecessary string comparisons and an unused variable

Phillip Wood (2):
  patience diff: remove unnecessary string comparisons
  patience diff: remove unused variable

 xdiff/xpatience.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)


base-commit: 7e391989789db82983665667013a46eabc6fc570
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-948%2Fphillipwood%2Fwip%2Fpatience-diff-cleanup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-948/phillipwood/wip/patience-diff-cleanup-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/948
-- 
gitgitgadget
