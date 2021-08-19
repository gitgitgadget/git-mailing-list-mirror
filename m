Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AD8C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 19:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6698260F39
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 19:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhHSTZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 15:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhHSTZR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 15:25:17 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30391C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 12:24:41 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id x5so7087412ill.3
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 12:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u7Oky9qHSGhmDB44mZKTYODzqNyAMb/oahwMJflqlgw=;
        b=lgM/RM6CXbtqGWGI5/b//v3HAj9miGW8mzALrJUc4sBB/Aq74ygy92lnBJkxhRnFIq
         zRbpDM4bUMP+EBE983ROLqWCxInrD+Rs/6VP7LEWEmxAfn0JkpvGIagm9nWUOV06pwB3
         7YFREEaFzPLjGpbGULcrqNRtD1Uro0BTtywFVGkomKIqmAq/Q/nsY3H25S4WxCEsTs5P
         W7mBiuZg9M1+MH0M6mAmsJ7bc44QdtqswrAZCaf/rdrmFJv1ByBGfEvtV8gMMVeJtPjE
         AIh8xwHUOaQ9B58RUUeT+HXhRlBrSfj8DoDhuKUWzNtomvcCyq2poo2BOYTilSR0SBms
         mbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u7Oky9qHSGhmDB44mZKTYODzqNyAMb/oahwMJflqlgw=;
        b=aOeK3Dxiy9Gz86ZEUUUsYM7DSj83NppapDAipC83j4QoGyCxXRsrUUi0neaHmFko2G
         8Dcmlee0nsFDf1Ev5y//bnmEvyb5QiN8zN4pteU+Sqs/LLH1ksPbRGC2/kDI+ld+MWvU
         i3DPV5PfXlLwErORuzF7g89Ypy4rKUDaRd5MQoGtN2ouM0xPshxncWAhrS6OAXRM/jVQ
         OZKNMG57bcBsgO1ke7ngCwBlzIExw3r5ZCDA/3YSRvRQkx1MxLMO3FrlZppIv8rjJ61T
         Af47UVqGPVRI8HLCUaAGR2FktAO4vOMd9rUYx5y/ip42drZni/i9YISud9vcwz5Cc2Sy
         evrw==
X-Gm-Message-State: AOAM531SfP9GYH4Xt61f+EfKusBdmUUkh5uujWqQbgIvHC9qZC6V9vF6
        b8w++kJrRolmhlmvwNXNzYivBA==
X-Google-Smtp-Source: ABdhPJxuPhVhzRs0/h0A0eMt69GRz2Im7XOG37Gc3DsR5Mz/tTk+SrdMgujd+6sH/mC/w2/SfRO9nQ==
X-Received: by 2002:a92:d94c:: with SMTP id l12mr10677464ilq.101.1629401080627;
        Thu, 19 Aug 2021 12:24:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a6sm1949643ilb.59.2021.08.19.12.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 12:24:40 -0700 (PDT)
Date:   Thu, 19 Aug 2021 15:24:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 2/2] test-lib-functions: use user's TERM and HOME for
 'debug'
Message-ID: <YR6v9yu3jpmRCZvy@nand.local>
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
 <d51d0db6e250c118b2d0f6eff571e1a7642da00e.1629393395.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d51d0db6e250c118b2d0f6eff571e1a7642da00e.1629393395.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 05:16:35PM +0000, Philippe Blain via GitGitGadget wrote:
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  t/test-lib-functions.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 662cfc4c3e0..86680b1177d 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -163,7 +163,7 @@ debug () {
>  		GIT_DEBUGGER=1
>  		;;
>  	esac &&
> -	GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7
> +	TERM="$USER_TERM" HOME="$USER_HOME" GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7

I also share some concerns about setting $HOME here (though less than in
test_pause), but forwarding $USER_TERM down would be so nice. I have a
muscle memory of 'tui enable' for anything besides absolutely trivial
debugging, and it's always so frustrating to see:

    (gdb) tui enable
    Cannot enable the TUI: terminal doesn't support cursor addressing [TERM=dumb]

So I would welcome even just that part of this change.

Thanks,
Taylor
