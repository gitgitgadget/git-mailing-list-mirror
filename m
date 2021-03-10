Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-28.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6161EC433E6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 18:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F3C64DFD
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 18:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhCJSxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 13:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbhCJSwr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 13:52:47 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114B9C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 10:52:47 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 16so5563012pgo.13
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 10:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=YjUp6RQmx2wxz4762BcLSWkbHhMNKzLqy/ZGw/3IlkU=;
        b=ih1ptKcF0sbiKPviOkML1cKxZdM9y9nSm1joR4VXyzKdLc9usmZqxWiqSsJTuTBG7p
         cZI2V/9e5jih6zIgpZr9YiNCen8qSPVHov4z1ac1vsfpa8/d98S2p6lUKKFG5Akfadsq
         V1CvHY2gwHvUo4fwUuRHI8Pwh6uLhUfD9SbJn0MIXfsEMJfft8WkgbskicoKeE8FFMTs
         XDwx37I+7Ajp8l4uY/Kq+R210apHMpKLZcbsegvXa7z4DPdjz5r/ccriuhksSY7wolDq
         bTmYXucehjsDjSnZ0+IOogWQ5CWi0RsZNiuGRNLuaJi7MqEAyVU8TGuhWTKarQ0DyKCD
         XnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=YjUp6RQmx2wxz4762BcLSWkbHhMNKzLqy/ZGw/3IlkU=;
        b=cgOq7MR7wfiHcgQu5GlANS3CBMMInvSKkBS1BxZrByok3hlB5PKypWwtNf/fANKFkp
         dSya8Gss9A5+pGqSyc/TgGOln4WGREy2bnAdmr3iQDISToARMLqX6P5xmgVfn9Ev78oW
         p9g+Oy1QN36h9VXdXSbDOX9/HguZHQJIrhqh+5UlxEHY9xV2wwQBcoaP4XUgrG3SrD9G
         MA0r1eOMwyW0RB/H2eGJuxtpWk3YXJaAsiWEaco809Zj5lpscxfUKK0FNx3vaC5kATjO
         IXWDatIuMTY2S8OcQ/I5wr3n5VCzdyfkqAQF+FX3g3PgedIqtbVqVzathqRTXSyvGR59
         derQ==
X-Gm-Message-State: AOAM5339mwcOJWVDCTumD21mBRy+2wepY55MeZfsYVYSswCPWJkGUfV3
        XMdqNG99lCKX7fJ6aN81icSiWxFVwFrLUA==
X-Google-Smtp-Source: ABdhPJxPRA9TmrgvhEoDZByU5+CmCVd959NI/jVzoQcphmh8+0UMdDUBN4MSQ9P+S0sG8/YMf4Q6aw==
X-Received: by 2002:a63:e5e:: with SMTP id 30mr4072543pgo.181.1615402366323;
        Wed, 10 Mar 2021 10:52:46 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:c4cf:5d59:92e7:3736])
        by smtp.gmail.com with ESMTPSA id t5sm230463pgl.89.2021.03.10.10.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 10:52:45 -0800 (PST)
Date:   Wed, 10 Mar 2021 10:52:39 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH v3] Makefile: update 'make fuzz-all' docs to reflect
 modern clang
Message-ID: <YEkVdx6PugLSX2UF@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
References: <pull.889.v2.git.1614871707845.gitgitgadget@gmail.com>
 <pull.889.v3.git.1615223682911.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.889.v3.git.1615223682911.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.03.08 17:14, Andrzej Hunt via GitGitGadget wrote:
> From: Andrzej Hunt <ajrhunt@google.com>
> 
> Clang no longer produces a libFuzzer.a. Instead, you can include
> libFuzzer by using -fsanitize=fuzzer. Therefore we should use that in
> the example command for building fuzzers.
> 
> We also add -fsanitize=fuzzer-no-link to the CFLAGS to ensure that all
> the required instrumentation is added when compiling git [1], and remove
>  -fsanitize-coverage=trace-pc-guard as it is deprecated.
> 
> I happen to have tested with LLVM 11 - however -fsanitize=fuzzer appears
> to work in a wide range of reasonably modern clangs.
> 
> (On my system: what used to be libFuzzer.a now lives under the following
>  path, which is tricky albeit not impossible for a novice such as myself
>  to find:
> /usr/lib64/clang/11.0.0/lib/linux/libclang_rt.fuzzer-x86_64.a )
> 
> [1] https://releases.llvm.org/11.0.0/docs/LibFuzzer.html#fuzzer-usage
> 
> Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
> ---
>     Update 'make fuzz-all' docs to reflect modern clang
>     
>     This version of the patch fixes the commit message as per Junio's
>     feedback. Thank you!
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-889%2Fahunt%2Ffuzz-docs-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-889/ahunt/fuzz-docs-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/889
> 
> Range-diff vs v2:
> 
>  1:  f5b5a11966ca ! 1:  bc0d8b615410 Update 'make fuzz-all' docs to reflect modern clang
>      @@ Metadata
>       Author: Andrzej Hunt <ajrhunt@google.com>
>       
>        ## Commit message ##
>      -    Update 'make fuzz-all' docs to reflect modern clang
>      +    Makefile: update 'make fuzz-all' docs to reflect modern clang
>       
>      -    Clang no longer produces a libFuzzer.a, instead you can include
>      -    libFuzzer by using -fsanitize=fuzzer. Therefore we should use
>      -    that in the example command for building fuzzers.
>      +    Clang no longer produces a libFuzzer.a. Instead, you can include
>      +    libFuzzer by using -fsanitize=fuzzer. Therefore we should use that in
>      +    the example command for building fuzzers.
>       
>      -    We also add -fsanitize=fuzzer-no-link to ensure that all the required
>      -    instrumentation is added when compiling git [1], and remove
>      +    We also add -fsanitize=fuzzer-no-link to the CFLAGS to ensure that all
>      +    the required instrumentation is added when compiling git [1], and remove
>            -fsanitize-coverage=trace-pc-guard as it is deprecated.
>       
>      -    I happen to have tested with LLVM 11 - however -fsanitize=fuzzer appears to
>      -    work in a wide range of reasonably modern clangs.
>      +    I happen to have tested with LLVM 11 - however -fsanitize=fuzzer appears
>      +    to work in a wide range of reasonably modern clangs.
>       
>      -    (On my system: what used to be libFuzzer.a now lives under the following path,
>      -     which is tricky albeit not impossible for a novice such as myself to find:
>      +    (On my system: what used to be libFuzzer.a now lives under the following
>      +     path, which is tricky albeit not impossible for a novice such as myself
>      +     to find:
>           /usr/lib64/clang/11.0.0/lib/linux/libclang_rt.fuzzer-x86_64.a )
>       
>           [1] https://releases.llvm.org/11.0.0/docs/LibFuzzer.html#fuzzer-usage
> 
> 
>  Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index dfb0f1000fa3..f3dc2178324e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3299,11 +3299,11 @@ cover_db_html: cover_db
>  # are not necessarily appropriate for general builds, and that vary greatly
>  # depending on the compiler version used.
>  #
> -# An example command to build against libFuzzer from LLVM 4.0.0:
> +# An example command to build against libFuzzer from LLVM 11.0.0:
>  #
>  # make CC=clang CXX=clang++ \
> -#      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
> -#      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
> +#      CFLAGS="-fsanitize=fuzzer-no-link,address" \
> +#      LIB_FUZZING_ENGINE="-fsanitize=fuzzer" \
>  #      fuzz-all
>  #
>  FUZZ_CXXFLAGS ?= $(CFLAGS)
> 
> base-commit: be7935ed8bff19f481b033d0d242c5d5f239ed50
> -- 
> gitgitgadget

This version looks good to me, although you may also want to make the
changes Junio suggested regarding LIB_FUZZING_ENGINE.

Thanks!
