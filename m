Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82978C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 01:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhLIBwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbhLIBwt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 20:52:49 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE72FC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 17:49:16 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so5147416pjj.0
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 17:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1KV+z5OUUxRYpBZtxt1wCx48Vbq4givohFXoD+a1Zo0=;
        b=CrdYM1KyNGcUJFbm0Elsh6Q/tpBBZzNzf1C0NNDoo1T1nqOw3ScPjr9rt8mzM1a2qz
         Oh9ldydYFWABsCEHRCzAhLLsN/MAhVTEVjI+yKA61wvX6AHhpQ5Yr8qKVQBkxz92I3NX
         T73pNIcztx/U0XggSiTDCB6t35kMJnVEtEU+L9TJUWYIs//Whbc5WprEszu428C2TRwU
         Dt/u6suji/Vk4lZT2vMcHrfV66l+Bmn4RNkILefDLaUxRJ+qhMLnFwvOEZfovhwbR61B
         b3P9OZpoyK8r5vx58QoX+0JNxA14JrlpaE7lJJKmrGWsJENpOxbmYPh0x4kyNgg86MMe
         Zv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1KV+z5OUUxRYpBZtxt1wCx48Vbq4givohFXoD+a1Zo0=;
        b=npbAzFxnaxSPmh1foRKyzNR8XmGsShaeAeqAh4XANdzcc8jgCGNaVunmlHe1g5O52d
         A/umgfDWOy06oI1JzUUcZ3Cp+iQZ6Rw0ZnxVSUwIHQeKfCiHUnM5hwTikwnRLY6cPg6K
         aeHH6WWKkEzCCnHeG1NFk9UPm88WJEkGrKNq2GEUDzk9muLiw3/WwQrTGJ5WFdR/+d6M
         xucJ/3l635selmsgvAefoQmenoFDDEMh3eCvlhT04FLNzwMSJgcLFPTpoFf0V3mbDGBA
         hUhzdGP1N0cdYDajKi/Lr+H+EeeE+S3eha2WbjjR/TFOrIOprZea8wO6m8qd6HJW0DAv
         azUg==
X-Gm-Message-State: AOAM530YTF3qUaA1OZyf3XPdPPMa0c3vv8J9zQuhcGMX7obWj8gf76b/
        U3GsB06PcfB1egb8aOSF5js=
X-Google-Smtp-Source: ABdhPJx6lQPORColVm3Man9kcoCHCcw9D3dKITVujjfSA7WOT6MJatdW+TERrvFCT/H+kke8oMlU4Q==
X-Received: by 2002:a17:90b:388f:: with SMTP id mu15mr11845254pjb.30.1639014556435;
        Wed, 08 Dec 2021 17:49:16 -0800 (PST)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id a22sm4701036pfh.111.2021.12.08.17.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 17:49:15 -0800 (PST)
Date:   Wed, 8 Dec 2021 17:49:13 -0800
From:   Neeraj Singh <nksingh85@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Neeraj Singh <neerajsi@microsoft.com>, rsbecker@nexbridge.com,
        git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] git-compat-util(msvc): C11 does not imply support for
 zero-sized arrays
Message-ID: <20211209014913.GA15497@neerajsi-x1.localdomain>
References: <pull.1094.git.1638823724410.gitgitgadget@gmail.com>
 <xmqqee6mv9no.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqee6mv9no.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 08, 2021 at 05:39:39PM -0800, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This seems to be required to define `FLEX_ARRAY` in a manner that MSVC
> > in C11 mode accepts. Without this fix, building Git for Windows'
> > experimental FSCache code would fail thusly:
> 
> So, what's the final verdict on this one, after a few back and forth
> to clarify the "seems to be required" above?
> 
> In the meantime, I am tempted to queue the following as a pure
> clean-up.
> 
> Thoughts?
> 
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: [PATCH] flex-array: simplify compiler-specific workaround
> 
> We use "type array[];" syntax for the flex-array member at the end
> of a struct under C99 or later, except when we are building with
> older SUNPRO_C compilers.  As we find more vendor compilers that
> claim to grok C99 but not understand  ts flex-array syntax, the
> existing "If we are using C99, but not with these compilers..."
> conditional will keep growing.
> 
> Make it more manageable by listing vendor-specific exceptions
> earlier, with the expectation that new exceptions will not be
> combined into existing ones to make the condition longer, and
> instead will be implemented as a new "#elif" in the cascade of
> #if/#elif/#else/#endif.  E.g. if MSC is found to have a quirk
> similar to old SUNPRO_C, we can just add a single line 
> 
>     #elif defined(_MSC_VER)
> 
> immediately before "#elif defined(__GNUC__)" to cause us to fallback
> to the safer but a bit wasteful version.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  git-compat-util.h | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git c/git-compat-util.h w/git-compat-util.h
> index c6bd2a84e5..9ba047a58e 100644
> --- c/git-compat-util.h
> +++ w/git-compat-util.h
> @@ -33,14 +33,23 @@
>  /*
>   * See if our compiler is known to support flexible array members.
>   */
> -#if defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L) && (!defined(__SUNPRO_C) || (__SUNPRO_C > 0x580))
> -# define FLEX_ARRAY /* empty */
> +
> +/*
> + * Check vendor specific quirks first, before checking the
> + * __STDC_VERSION__, as vendor compilers can lie and we need to be
> + * able to work them around.  Note that by not defining FLEX_ARRAY
> + * here, we can fall back to use the "safer but a bit wasteful" one
> + * later.
> + */
> +#if defined(__SUNPRO_C) && (__SUNPRO_C <= 0x580)
>  #elif defined(__GNUC__)
>  # if (__GNUC__ >= 3)
>  #  define FLEX_ARRAY /* empty */
>  # else
>  #  define FLEX_ARRAY 0 /* older GNU extension */
>  # endif
> +#elif defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)
> +# define FLEX_ARRAY /* empty */
>  #endif
>  
>  /*
> 
> 

Your change is an improvement that should be easier to read and avoid conflicts when adding quirks for compilers.

LGTM.

I hope on Dscho's side that they change the fscache code to use the union, since I don't believe the current code
is C-standards compliant and at least in this case MSVC is not actually broken.

-Neeraj
