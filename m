Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969DDC433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 09:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiB1JlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiB1JlR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 04:41:17 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762FF657B7
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 01:40:39 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so5388504wmj.0
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 01:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=OUYHe+7MP5x0MhXufDOxlrBDSm4evkuDW3x9tLtG1cw=;
        b=fRFCgiJBD9R95ifkO8QpgwIl9oCXEdVL78Ti2eODxN1SoC2Z/DNHJ81pdjvKYx5gTf
         aZFLINocGG8tDGBFYhZj6l0TivxIGXKO7V8VhorA8Cfbg7xQ5kjDV54ikR3hW0oCKvM0
         xRPrhgT93f/rH8iJ/0MYHuAZ3VgE5OOoflW3YUTXUEjXpjAdxUDpL6HVKNegL9AHI/56
         WqNwAelIYF6J6PYg9AX6YAf/E4Y+l9gkWQuAbkF0EbGK/WRO9/Q2XOjJ+b573VwJ+Vcf
         A66SOLRkSFXWushYWRaBBFxFB0FbbX66rE/rqf24lxbC1f3iVMhs3poHbnBmG8iZG7KH
         k29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OUYHe+7MP5x0MhXufDOxlrBDSm4evkuDW3x9tLtG1cw=;
        b=11uKdoK3OzAPQGC/BBxU1MYi6cej6HH9imt6ufM0/jxs6skFhQfVw/7ybz73T64DKO
         cie9xeHQZpP/5ZKpOrwp9BmznupuacfcXn5aLdxAf2/BMabvGN9Xcu3OEsArk+QnASk8
         moZ7byTT9Ed85/Iif2aLbt6qTktDABV/YP3CtZjd4jQSPMugdqyL3sEBJ3A/GwWayzZd
         d+bgWIeLd2QlCEZiAh2IkJQPJIE3jb9JXbDYTP285tRrdMY+KEQubEqzCq7VOII/NHfF
         vQ2yVKlhVG9incNt+S0PHdkEoZfDm+MrXtixDB6UKiJ9uzqZee8JcQtVQa/vMBoXgJDB
         1pcw==
X-Gm-Message-State: AOAM5316x8XYZSmNoFTMGQrHiZj3P+6LFBS+AwLn9fAgYYNmGrlDKfj8
        R1Mb97OTaE6MhUl2Xy1Wh0/QZwAWpJE=
X-Google-Smtp-Source: ABdhPJznhq4ddkGgEScnZ38GxmZx5wj8zdtjVI6oXacFsdbJtsXr3dPcJaEPiviBFo2JXx8iakPyTA==
X-Received: by 2002:a1c:730e:0:b0:381:103f:d6d9 with SMTP id d14-20020a1c730e000000b00381103fd6d9mr12312560wmb.46.1646041237793;
        Mon, 28 Feb 2022 01:40:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm13320840wmv.31.2022.02.28.01.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 01:40:37 -0800 (PST)
Message-Id: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Feb 2022 09:40:34 +0000
Subject: [PATCH 0/2] Reduce explicit sleep calls in t7063 untracked cache tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in a recent proposed patch to t/t7519-status-fsmonitor.sh, a number
of test cases in t\t7063-status-untracked-cache.sh explicitly sleep a
second, in order to avoid the untracked cache content being invalidated by
an mtime race condition.

Even though it's only 9 seconds of sleeping that can be straightforwardly
replaced, it seems worth fixing if possible.

Replace sleep calls with backdating of filesystem changes, but first fix the
test-tool chmtime functionality to work for directories in Windows.

I do have a question to the list here: Do mingw.c changes need to be
upstreamed somewhere? I don't understand the exact relationship between this
file and the MinGW project.

Tao Klerks (2):
  t/helper/test-chmtime: update mingw to support chmtime on directories
  t7063: mtime-mangling instead of delays in untracked cache testing

 compat/mingw.c                    | 33 ++++++++++++++++++++++++++-----
 t/t7063-status-untracked-cache.sh | 29 ++++++++++++++++-----------
 2 files changed, 45 insertions(+), 17 deletions(-)


base-commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1166%2FTaoK%2Ftaok-untracked-cache-testing-remote-waits-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1166/TaoK/taok-untracked-cache-testing-remote-waits-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1166
-- 
gitgitgadget
