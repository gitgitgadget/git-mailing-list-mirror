Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6BFC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB09664E91
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhBBDI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 22:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhBBDI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 22:08:59 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80B1C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 19:08:18 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id u20so5239175qvx.7
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 19:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fFYwMkbdgJ9YlTjvM24Be/kYHqM4Ls7RucD54zFUbe4=;
        b=uiZkpJ1EKUoKjPfppneh72DGIuLxhe7UAFtmvYwu0JaOmsZyg/xQS8tX75rS6CkN2W
         W6ttXlExG2cS4FwmGbUWE6l1Mu3Hx9OPvGaNcWTufhjFMkcp9EXm9deBLWXYiMiFPLZI
         +0GQQ3go6zc63v6N7s7JzzEk4QiEr45JkAcPAsuzOTD4vzWcQ3VSMq1tFHxG/L/f3nPH
         6sUdi9H1fpLodGBr2ozGYBCWQosjX2RmRz505zFkCgLN9tJCmmTDdaY0y7raXIVomza8
         g7snLAtqupg2xeddxPujE+/RrXATjxTOAAtse7lLsOnLT3uaV2tgCjLwlzBkuMmENef1
         VTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fFYwMkbdgJ9YlTjvM24Be/kYHqM4Ls7RucD54zFUbe4=;
        b=jVVVdIKL9G8OwNVjPC/7+6gss4JmO0ofCvPxQ4/UMa1iwSZbR+uVA0JFRrxopwle5U
         wbAOU6oyjr5hxz5ZWFKzax5pgUHMRrQXac+8PU/re2jyICQSY0/UfjqxBtn6s33TRKks
         NeKAwkDkDEpED/8b/mrI9gRuqA6ayEWDlqho+f5Zf29/pFtgqD0wQp9mD8e/acu4B6n2
         bULYzZsAPYiwo9Xhz0PDVsfkHNwjtKiZMMIkfbVg2kRsffUshDHyfgTjjT3hj5t1y06L
         eNEneYrrVkEdfOWPTepdeLpLf/Kpkrm6xoYiCYIzLzELqnyIMCUzDOfZyWNutfEeL7tV
         qpBA==
X-Gm-Message-State: AOAM533D0tu3n0IXKSm9ByxPlQ8aiJhyp4wN5xI+FgzLwZeZHIbWHn86
        TX+qV6GX3hCnGLgj+S90F1UZUQ==
X-Google-Smtp-Source: ABdhPJwONfvB5JpJZiDTiM/RM0o8B4/DMXTb4ENZ9ObUo5pQ2o8I5XaPJi7qXVb0nodhriX8vc32tw==
X-Received: by 2002:ad4:4047:: with SMTP id r7mr18198320qvp.0.1612235298109;
        Mon, 01 Feb 2021 19:08:18 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:8bd2:a84b:ef4c:2356])
        by smtp.gmail.com with ESMTPSA id p188sm15483487qkf.40.2021.02.01.19.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 19:08:17 -0800 (PST)
Date:   Mon, 1 Feb 2021 22:08:15 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        gitster@pobox.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/6] Generation Number v2: Fix a tricky split graph bug
Message-ID: <YBjCHxaMCYyUZ2t5@nand.local>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
 <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 02, 2021 at 03:01:17AM +0000, Derrick Stolee via GitGitGadget wrote:
> Updates in v2
> =============
>
>  * Fixed some typos or other clarifications in commit messages.
>
>  * The loop assigning read_generation_data is skipped if they already all
>    agree with value 1.
>
>  * I split compute_generation_numbers into two methods. This essentially
>    splits the previous patch 4 into patches 4 & 5 here. The new patch 4 just
>    splits the logic as-is, then the new patch 5 does the re-initialization
>    of generation values when in the upgrade scenario.

Thanks for addressing my nits. I'm much happier with patch 5 as a result
of your changes, so I think this series was a positive step forward not
only for fixing a correctness bug, but also for improving the
readability of commit-graph.c.

Both the range-diff and the new patches look good to me, so this series
has my:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>


Thanks,
Taylor
