Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0503C433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 23:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B27F160240
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 23:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345713AbhCAXco (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 18:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344105AbhCAWkY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 17:40:24 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE97EC061788
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 14:39:43 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d8so416218plg.10
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 14:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=NR3TWREDSGjqf3hOHpDt0VDZTyPpsjyAqciOVPtc1EY=;
        b=TqeQFWRjo60R4Aal7M88blBM8mdpCt1yOCOczB2TqMz1RVGJD13SnEh3ralE+56S2m
         X+t0Q+jsRy55l0R6/Zz6j+3lh2t74YT2pu654ThZ5fEXlW7GCi8ZI8xLA8KmqCy/Azez
         tWMtKUN28tLuCgt5QdnEbcUKVfdvqQFgf9MNLTx7NNLGTjZlH3DYSHfXIrPDFMrbgfMw
         qeo+kegg59PYppSEFpOAp+57s0MhA3TtLHq4sNC2pMLY+S2ceCJsDmddnm7QIFFsa2W9
         HAttKO50LoWnDS0MwpM/EG+2httXhjGKyf40lVG+vlonuauhNM4Nx+9dOM6ND3xnwkx5
         0szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=NR3TWREDSGjqf3hOHpDt0VDZTyPpsjyAqciOVPtc1EY=;
        b=EsST13PHr5zk0alNuJo5BAIxx+K+g+6dcWO10WFn1hNs1kCa/CzWSq+Ad0qjizQChC
         5QOJir9rjA7XWZZXuoZiFXZuYoRdmyPiXUf/D4dHQF8Lj7qqi/aL0ohTLJThEfCfxIqP
         58KjiQVKKaCHqKZOI5c4Tl3stBUB/643qxZMCQpNwUSjPv9N2/ECs/X4WfHHwbLOnjuL
         EmdYOK5FEd8qOd+Xallp6SB3C4vs4APrCMgBakn7tWf3SQw1YT0DTjwm5LO91+8WLc5K
         pcJuBCr3LjRFMytlHDyEmNsmxpCiOAJLo3fAtP83Fv2YggySiTlWXsF+SuSed0TAXkot
         uvuA==
X-Gm-Message-State: AOAM533/r9D8Ckka4B7cSDjpSiCgGCRMMngIWORIf4yZ0Yb5Y6+qK/le
        XU1HF2K8Lq48IZdAKNZLnSleUkgR1obMyg==
X-Google-Smtp-Source: ABdhPJy47RSrQyDn1+/0nh2hrrSeDGjeysOtugT8w+gKFHjf0LLUmqPtkk6Bf6OVBbNuOgC4Nq6JsQ==
X-Received: by 2002:a17:902:eccb:b029:e3:b2e3:a21b with SMTP id a11-20020a170902eccbb02900e3b2e3a21bmr826640plh.41.1614638382556;
        Mon, 01 Mar 2021 14:39:42 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a91d:b949:8971:7c22])
        by smtp.gmail.com with ESMTPSA id w27sm18363844pfq.105.2021.03.01.14.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 14:39:41 -0800 (PST)
Date:   Mon, 1 Mar 2021 14:39:34 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH] Update 'make fuzz-all' docs to reflect modern clang
Message-ID: <YD1tJlY/mqZOmTNm@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
References: <pull.889.git.1614514959347.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.889.git.1614514959347.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.02.28 12:22, Andrzej Hunt via GitGitGadget wrote:
> From: Andrzej Hunt <ajrhunt@google.com>
> 
> Clang no longer produces a libFuzzer.a, instead you can include
> libFuzzer by using -fsanitize=fuzzer. Therefore we should use
> that in the example command for building fuzzers.
> 
> I happen to have tested with LLVM 11 - however -fsanitize=fuzzer appears to
> work in a wide range of reasonably modern clangs.
> 
> (On my system what used to be libFuzzer.a now lives under the following path,
>  which is tricky albeit not impossible for a novice such as myself to find:
> /usr/lib64/clang/11.0.0/lib/linux/libclang_rt.fuzzer-x86_64.a )
> 
> Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
> ---
>     Update 'make fuzz-all' docs to reflect modern clang
>     
>     I would like to update the examples for 'make fuzz-all' to make it
>     easier to build fuzzers locally.
>     
>     This change should make it easier for the uninitiated to build fuzzers
>     locally without first having to figure out what LIB_FUZZING_ENGINE is
>     for.
>     
>     ATB, Andrzej

Thanks for taking a look at this! This looked correct to me, but when I
tried to run the fuzzers I got an error about
"-fsanitize-coverage=trace-pc-guard" not being supported any longer.
Looking at the LLVM 11.0.0 docs [1], I see that it recommends using
"-fsanitize=fuzzer-no-link" instead (the "-no-link" is because we're
also building executables that have their own main()).

So we'd also want to change CFLAGS to
"-fsanitize=fuzzer-no-link,address".

[1]: https://releases.llvm.org/11.0.0/docs/LibFuzzer.html#fuzzer-usage
