Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61CAC433FE
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 19:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345071AbiALTUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242603AbiALTTm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 14:19:42 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205FEC06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 11:19:42 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id i82so5123902ioa.8
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 11:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XQIvVs1Dmb1gM9FgstPs0MYOhdKJ1LZVcKxtnhcgYSM=;
        b=IFHt77HfuO7EZ3RWzbdEHHQ6sYm0H3bZ27DF5py+FftF8PEG1pzP6eZ+lUnYKk8r61
         9Own2RfjHKVZGEb2K/E52Xlyc21frveYQAJ9PTVQ7dwFtlqTZADTs2nHA5UuK0Cy0hPz
         pKBjlEF3pxHxGwtjT2CLOr2eW++aAR8mtmzAOsEtyS/cvGh4W9uATiyqn7Iv9b9Y6iG3
         JqE0L8lmzoU26DmZLo4P9xpuRjBefcyR5EkSs9gX5vJOkoYnGj6lF5ajWORoQ0EgA4HF
         vW9hEvRDTYhlU6XvEkJf/bi39w4bugpvvFUH+3/pRjjMS12e+NPWIYUByL/wIJvP6Os7
         34Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XQIvVs1Dmb1gM9FgstPs0MYOhdKJ1LZVcKxtnhcgYSM=;
        b=Q+eDNl3o1TGeoOwVkIUMLR3+OhQmg6y7sro6mkjHv99ZumrWPRziEuG9541XERwcrP
         QszSMg2PvO4m2ItxJyUcemoxY6xWLWRIkyRIV0zvw9qgN5hVMRnRU8sLWXJece1xzL+i
         8SvR1nBEKpPX7ogoUKDk4sjIz6UVM34eKSuzXhl7OPlSoNLxZRFnLpPzGDECHzu1PPfy
         TXnxlyhD1shIAAxnOy2hkBXNS6C2DAoPmydRHA9nKsobhB+NJLpP968/MQ0hV5D9Pmkf
         /EDFQX4JOSEc8M1Q1t5lmsKBpFWrL4Q55XzNrou60/yVIX98mv1J1l+ZHUJ7LbgSsWsB
         jyqw==
X-Gm-Message-State: AOAM5327VXYvsOtigmI+vSVzSbLAY75LhvALoxAApvqvmA6P12DRa1Fd
        mEystJV81pvPzjoeY2Y7Jtl92fF9B1PvfQ==
X-Google-Smtp-Source: ABdhPJxi+0Kaw8iouJGNiUD5NTz0dCiW/vbaPFTTSwA7rExjf6uRY1BnMak1vJ/L4UxdzOPNqYFFQw==
X-Received: by 2002:a05:6638:4090:: with SMTP id m16mr600799jam.67.1642015181495;
        Wed, 12 Jan 2022 11:19:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g1sm430124ila.26.2022.01.12.11.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 11:19:41 -0800 (PST)
Date:   Wed, 12 Jan 2022 14:19:40 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 2/3] reftable: remove unreachable "return" statements
Message-ID: <Yd8pzOh1HLvDWSPg@nand.local>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
 <patch-2.3-7a6a69314b5-20220111T163908Z-avarab@gmail.com>
 <Yd3XpLaZ3qc25PzQ@nand.local>
 <220112.865yqpxge2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220112.865yqpxge2.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12, 2022 at 01:47:40PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >> ---
> >>  reftable/refname.c | 1 -
> >>  reftable/writer.c  | 1 -
> >>  2 files changed, 2 deletions(-)
> >>
> >> diff --git a/reftable/refname.c b/reftable/refname.c
> >> index 95734969324..136001bc2c7 100644
> >> --- a/reftable/refname.c
> >> +++ b/reftable/refname.c
> >> @@ -132,7 +132,6 @@ static int validate_refname(const char *name)
> >>  			return REFTABLE_REFNAME_ERROR;
> >>  		name = next + 1;
> >>  	}
> >> -	return 0;
> >>  }
> >
> > In this case the loop inside of validate_refname() should always
> > terminate the function within the loop body. But removing this return
> > statement here relies on the compiler to determine that fact.
> >
> > I could well imagine on the other end of the spectrum there exists a
> > compiler which _doesn't_ make this inference pass, and would complain
> > about the opposite thing as you're reporting from SunCC (i.e., that this
> > function which returns something other than void does not have a return
> > statement outside of the loop).
> >
> > So in that sense, I disagree with the guidance of SunCC's warning. In
> > other words: by quelching this warning under one compiler, are we
> > introducing a new warning under a different/less advanced compiler?
>
> I'd think that any compiler who'd warn about this sort of thing at all
> would be able to spot constructs like this one, which are basically:
>
>     while (1) {
>     	...
>         if (x)
>         	return;
> 	...
>     }
>     return; /* unreachable */
>
> Where the elided code contains no "break", "goto" or other mechanism for
> exiting the for-loop.
>
> I.e. GCC and Clang don't bother to note the unreachable code, but I
> don't think the reverse will be true, that a compiler will say that a
> "return" is missing there. Having a function be just a loop body that
> returns an some point is a common pattern.

Right, but I'm more concerned about a less advanced compiler that would
complain about the absence of a `return` statement as the last
instruction in a non-void function.

This is probably all academic, anyway, since less advanced compilers
probably have other issues compiling Git as it stands today, but
fundamentally I think that SunCC's warnings here are at the very least
inconsiderate of less advanced compilers.

To me, the safest thing to do would be to leave the code as-is and drop
this patch.

Thanks,
Taylor
