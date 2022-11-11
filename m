Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310EEC433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 02:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbiKKCwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 21:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiKKCvy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 21:51:54 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1155B5A9
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:50:50 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id i5so1971441ilc.12
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kFrmGdB7cWc4g4NwQ8PlWVnZY3WlM9uyIvlq4J5vRzQ=;
        b=O9Z4gkr6jwp0JaLyn1G5lf1OUIPTETLvtWl9fPz0Bwu88Qui0WuU2bDrX+PxPSY8xI
         WFEVE8lyHBiz9Fjtiedyz/RDr96Yb3T/pmuudXFyl9afOMtXCKOgeBPLUAVc3Nr84tmy
         etvAXhSuCGcL2wM+gqnqsAoQ3y9a5uEHd+4UmpxndHuUk9pSWQZatXWan7He9PpZZQqM
         n7PDKmCgVLwLAIOi5DMKyJlSQn/Ota6mCyuf37gFUG4fcqL69gix1l/woyT9QFXfJcR2
         tcUZouMq1HiEcy5vVSmweP07kESHHWjZv3+dVD0xSDWa1AnPcAFpKgr3q8sf12y+4vp3
         N9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFrmGdB7cWc4g4NwQ8PlWVnZY3WlM9uyIvlq4J5vRzQ=;
        b=EEklg+y23bo+ISCCIrPkjnnETcsiS2AgndanULDL8DVc8XZ9w/aUOYkj9WGJh74aBP
         N+lJ8yHlVRVqrsExGfim0PhrP4dS7hOgwA5I0U28lwxGGzUKKGBWXeUVezTyLEWpUVTc
         cRNYJtr0hD7bZynEFYRPX22FtB8R6vq53NuhuixuRBcWpXjJHZ9M4cfrCHH2TSXpPzCt
         1hMRx05vYHSePyGAI6ZK3+934GlTFKFdVNFSt1lK0PvieImFMWMvafGy2aneLC3Beqpy
         GTsA50/WJuPEJISrhZ+4fjg/LjI0lth1apbVsMnx3OSxDqD20tufB4j3jLR6ndRWYQKB
         ueSg==
X-Gm-Message-State: ANoB5pnxfbEH8d/XKWIhaZq8lWxMwmwcJqokIk+hpuyMxg1mg99JhHpY
        2tu/gpLGaKv3K/XQ6FdZ7mrFcw==
X-Google-Smtp-Source: AA0mqf6yaMzY6JLsXgeP7d1h2Uf2xAMvv976smH8Cv5ZjzXw/VZoZ5Ya/2OCIwT0AvvKThC5oejieQ==
X-Received: by 2002:a05:6e02:60f:b0:301:fe9d:ff37 with SMTP id t15-20020a056e02060f00b00301fe9dff37mr121549ils.160.1668135049562;
        Thu, 10 Nov 2022 18:50:49 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p18-20020a92da52000000b002ff2774edecsm448873ilq.56.2022.11.10.18.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 18:50:49 -0800 (PST)
Date:   Thu, 10 Nov 2022 21:50:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        szeder.dev@gmail.com, Taylor Blau <me@ttaylorr.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v3 0/5] Skip 'cache_tree_update()' when
 'prime_cache_tree()' is called immediate after
Message-ID: <Y224iAeMiazdJspp@nand.local>
References: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
 <pull.1411.v3.git.1668107165.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1411.v3.git.1668107165.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 07:06:00PM +0000, Victoria Dye via GitGitGadget wrote:
> Changes since V2
> ================
>
>  * Cleaned up option handling & provided more informative error messages in
>    'test-tool cache-tree'. The changes don't affect any behavior in the
>    added tests & 'test-tool cache-tree' won't be used outside of
>    development, but the improvements here will help future readers avoid
>    propagating error-prone implementations.
>    * Note that the suggestion to change the "unknown subcommand" error to a
>      'usage()' error was not taken, as it would be somewhat cumbersome to
>      use a formatted string with it. This is in line with other custom
>      subcommand parsing in Git, such as in 'fsmonitor--daemon.c'.

Thanks. The range-diff confirms what you say above. So between that and
an affirmative review on the last round, I think we are ready to start
merging this one down.

Thanks,
Taylor
