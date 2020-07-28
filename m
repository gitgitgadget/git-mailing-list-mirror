Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38BFC433E5
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08EC2065C
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="j2vig/XA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgG1UsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbgG1UsH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:48:07 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B4FC061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 13:48:07 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id e13so20111400qkg.5
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 13:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GFUuw73+LeWNIHlAZ4Je9CenLLhtR55ro4kv5v5tOX0=;
        b=j2vig/XAL7HJweCiZ1gCuOV0hxsTTTdKR6iPwlALVMQz8Npcq2NeGDi9gPgsa8Fec/
         UBzvVmxcO4xBdcZ49u6KsceG9MKuW+4RooXAU+e9+2SYwiR7N8BGE0xFV4KhkN3OyYT/
         vFv3qx1fp13j4wDI7kWMguhAN2omjaTvXt/+FbsAzp3boEtg1+z0CV8bA8uvDnxzc+rE
         f4FxI6l5whSTCNqPpxReVOiCYdSH/eL4rnvcrcsgJhKVzA6G2woSd0Dv9R+N16sgL3vp
         KvW08UwafmSGhACKrKQkhve71ZZmLewXipL51eWYhoOHx8X4ynnvk94JwtLoElh7G06D
         zBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GFUuw73+LeWNIHlAZ4Je9CenLLhtR55ro4kv5v5tOX0=;
        b=W/1NKefcf2/fkU+32deIcnLcg4eklpuGZZ0Iqyd9YOpb8gB9mkWvlBdrWqlomD95k1
         Ai9I+lhkL9+8QbI5oFGVWDFT+78dn/0fV7WlpN/s0K07nTy6TsTtvKf5OHGMKft4gNw+
         09r8ESb+/lltBTU8//dXpPE+Pq2PVIoHoMS0z2to6aakHjhZYfv9x6/RD0yWm3436hii
         GN8jvla1WoJY1szbUgS8Yo7IWrL52/r3sM1MExhbbecXANjcuE8uyt0SGO44KAdbX28i
         Vrme/zrJNeCa+xxKbe8qerl2JpSjKzprSP80ZUBJXXkrHCNSZAUO8L5GgiBgcMBTv89s
         6dIA==
X-Gm-Message-State: AOAM532ClxcFV3EOUMmUZpoCuDmXixIB8eWH75Txl5JUr43J58BPhk/S
        XvR0LWSXASOIUgtEsXmjT4vGXmbAPCcus7AR
X-Google-Smtp-Source: ABdhPJy1L8J5Km/+pOf6YAtH8+N4wy+zdiW2CjGv8j5MHE12fnBwZgyDBBhT/72rZBAvApNKqLupag==
X-Received: by 2002:a37:b206:: with SMTP id b6mr29891046qkf.22.1595969286524;
        Tue, 28 Jul 2020 13:48:06 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9c58:8530:481a:f835])
        by smtp.gmail.com with ESMTPSA id 103sm14424965qta.31.2020.07.28.13.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 13:48:05 -0700 (PDT)
Date:   Tue, 28 Jul 2020 16:48:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/2] Typo fixes
Message-ID: <20200728204804.GA94132@syl.lan>
References: <pull.824.git.git.1595969139.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.824.git.git.1595969139.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 08:45:37PM +0000, Elijah Newren via GitGitGadget wrote:
> Fix some simple typos: doubled words, and character swapping

Far be it from me--since I seem to always be making these mistakes
myself--to be an authoritative reviewer on this series, but it looks
obviously good to me ;-).

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

> Elijah Newren (2):
>   Remove doubled words in various comments
>   hashmap: fix typo in usage docs
>
>  fsmonitor.c                            | 2 +-
>  hashmap.h                              | 2 +-
>  t/t5510-fetch.sh                       | 2 +-
>  t/t6046-merge-skip-unneeded-updates.sh | 2 +-
>  t/t8014-blame-ignore-fuzzy.sh          | 2 +-
>  wt-status.c                            | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>
>
> base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-824%2Fnewren%2Ftypo-fixes-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-824/newren/typo-fixes-v1
> Pull-Request: https://github.com/git/git/pull/824
> --
> gitgitgadget

Thanks,
Taylor
