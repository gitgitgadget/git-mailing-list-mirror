Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58873C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1934264E4E
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhBCVUa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhBCVU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:20:29 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAF3C061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 13:19:48 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id r77so1210310qka.12
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 13:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MD/RafuJ2w3R1SN3wboRNyUz0w1Oq9WLlrZpU7/+XVg=;
        b=SHyWg5cvBWqv42JISFDE8sv314HpP55QNFsb2MKR0m9kOCZwxlj3Da3RfgHP9CJuzS
         9wd4rQiGkrMGcLXhtdOfs5GaVNizP/Pa86l+MMhYISCDnkaXQD/BiqwIjFqpSgR9CoXm
         CCRBazEwpbi2Nf0gMzv+FNPUo4eHTYSHzMKSZ3lPnuZ6RQh14dXc1VyBAojD5z1OMT0t
         1twqdCRCeRpG27QHGJJ2UTC7FvbJ791kGsKJf9Edj5i5HpYjOuHx4M0HmxJd4+U8qaXy
         B5ThPkvnsVoKO5LdvufKr6eupzrT9fJoHMDVwbtoHCeaLpkAXs7snXF8IpBAnsBLsmZf
         w3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MD/RafuJ2w3R1SN3wboRNyUz0w1Oq9WLlrZpU7/+XVg=;
        b=OPwSsKZEBZQGlTnKQgVsZXkokdzIGZY7gRIO3JlHvUiO0Nh7gTfIUbwN/z6trXU2Wi
         c4mJV1b0ETC9Gy++ru3qCQ5IyxbCi/6tChitE5Vq2zM3GNq6jxNJSti+Qbo0pZw7N+qi
         2USInTr2cL4wg09U/6KK/9tx05Vip5XzxiH9t7MlpRA0lcKLhowqDGzTPqVv8TpgH2Bw
         MOKUP7ZihJ//FEK+lzOrR6z6lBdqL+EZHExbCUDuBv7dAHiUdijgmjIAf5HKpaKvijzX
         uBvD7TYQ3iuD6/hZB70r/MzNFwpY3qpgohGlO6z8YTRTLueTLACwD+PCBZOUsECsahGO
         V1Pw==
X-Gm-Message-State: AOAM530xUQSIbPcT8d/6CNeodWx56GSWuqXlErwu0PLd6bjNoTsDnBUQ
        iSsCYXLyisi1rzuQN7h9LvAUNg==
X-Google-Smtp-Source: ABdhPJyIYURkqhzk6uDi3dAZeW7lkHkb83idh6IUxvfkzgMpyVXy0krGNVKmwAS8enWTeEz5b5dscg==
X-Received: by 2002:a37:a9d6:: with SMTP id s205mr4717794qke.162.1612387187975;
        Wed, 03 Feb 2021 13:19:47 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:3a5f:649:7bf7:4ac8])
        by smtp.gmail.com with ESMTPSA id y135sm3081889qkb.14.2021.02.03.13.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 13:19:47 -0800 (PST)
Date:   Wed, 3 Feb 2021 16:19:44 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 00/11] FSMonitor Preliminary Commits
Message-ID: <YBsTcDokmFcL8N1o@nand.local>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.860.git.1612216941.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Mon, Feb 01, 2021 at 10:02:09PM +0000, Jeff Hostetler via GitGitGadget wrote:
> This patch series fixes runtime errors in t/perf/p7519 on Windows and MacOS.
> It adds Trace2 logging to p7519 to make it easier to compare results when
> Watchman is enabled and disabled. And finally, it adds some Trace2 regions
> and data events around our usage of Watchman and the existing FSMonitor
> framework.

I read v2 of this series and it all looked very sane to me. I didn't
have much in the way of comments or concerns along the way, so that
version of the series has my reviewed-by.

Thanks,
Taylor
