Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35ABC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 16:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBIQeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 11:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBIQeF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 11:34:05 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556FB5CBD0
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 08:34:03 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id f10so2581689qtv.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 08:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uSNswOQLF6E1/WD28Ro5ft4sVncIjy6hOWW2GOBT/Pg=;
        b=olD3n6KK6RI2ljj9fZTr4evcCMFPsi0WkGqrxF2wYhj6jJosFRHZmIR5uuMI1a99Zx
         D5TRktXIrO/okp1SCEngYtuTVyhqqg/SnZI7S/R+bI+a/yY2YBRI40pKFWMdcs+yk+zN
         /z9IyVxDpq1ULUW8eHjIVpxLdBhmwCZDaH0upbtSkSC17aHb1xmUxZZc3MJOmXAHVvlA
         LOTpNcKN8JLQVkBtpMwZC+FwaTUnc6f0ObERm4LafkxBIGfGv0nX3ae69QtZoheiRxUs
         xADX8qnYe0oe+ALPeiLBTCNmlNWityjtej9D8jax+T17kLVvBzfH+xjFMT3ne/UTP7JR
         2U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSNswOQLF6E1/WD28Ro5ft4sVncIjy6hOWW2GOBT/Pg=;
        b=AuclRV33Cynipl7YTFjIWf2mHnAFWGK2Z/L31feNLkpKEsgKuUJdm7yIBi/yg03ESM
         O0pVm1zeXc0xBdlBh2npwOaLFbkS8hjcR7MwYTVyNy0RO+JXooQL/+YoT59s9mASqI+x
         EY2kZWs+9nhVA/tFETh6kidCnVe22mGrQiOie+0UWdd4GlAtWSVD865bA5XW7ykjFQPS
         Mfniw4X2yjZZJbbxT+nsuD0fWpNZ6X5e1TDm2SJpFvYMlWFlR35IbU0Qe2U/vp5Aiz02
         +sq0tRmsHNyHvqrq83Zsw01uV0bd09qvPCFePpFfKh1So1OCE3fcX/+P5w1Cy5bCrn/8
         3Gvw==
X-Gm-Message-State: AO0yUKVK3TEvikJPv16M8tR4y3vs8pbVGBLI+MaJCh+riZY0A4bLsEV1
        9tsYfnGXaAMpf9RH9mZZmC9RmpVBrNk=
X-Google-Smtp-Source: AK7set/++nfe9xzG68n137xgemduELSNtoKY3a+2C3FLTEBq1gruJT8ACsIuJEOePGnt+E0E6Xm5RA==
X-Received: by 2002:a05:622a:1a93:b0:3bb:7875:1bc1 with SMTP id s19-20020a05622a1a9300b003bb78751bc1mr10268441qtc.4.1675960442309;
        Thu, 09 Feb 2023 08:34:02 -0800 (PST)
Received: from localhost (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id b2-20020ac85402000000b003b9b8ec742csm1596576qtq.14.2023.02.09.08.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 08:34:01 -0800 (PST)
Date:   Thu, 9 Feb 2023 11:34:00 -0500
From:   John Cai <johncai86@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Message-ID: <20230209163400.xi7j3ivd4k6gqoc7@jcai-ubuntu>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <Y+KQtqNPews3vBS8@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+KQtqNPews3vBS8@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/02/07 12:56PM, Jeff King wrote:
> On Sun, Feb 05, 2023 at 03:46:21AM +0000, John Cai via GitGitGadget wrote:
> 
> > +`diff-algorithm`
> > +^^^^^^^^^^^^^^^^
> > +
> > +The attribute `diff-algorithm` affects which algorithm Git uses to generate
> > +diffs. This allows defining diff algorithms per file extension. Precedence rules
> > +are as follows, in order from highest to lowest:
> > +
> > +*Command line option*
> > +
> > +Pass in the `--diff-algorithm` command line option int git-diff(1)
> > +
> > +*Git attributes*
> > +
> > +------------------------
> > +*.json	diff-algorithm=histogram
> > +------------------------
> > +
> > +*Git config*
> > +
> > +----------------------------------------------------------------
> > +[diff]
> > +	algorithm = histogram
> > +----------------------------------------------------------------
> 
> From the user's perspective, this is weirdly inconsistent with the
> existing diff attributes, which would be more like:
> 
>   # in .gitattributes
>   *.json diff=json 
> 
>   # in config
>   [diff "json"]
>   algorithm = histogram

Thanks for this suggestion, Peff. What I like about this is that it builds off
of the existing diff.<driver> scheme rather than inventing another one.
Additionally, we won't get hit with a performance penalty since we already read
gitattrbitues to see if a driver has been set or not.

Thinking out loud, if we add "algorithm" as a key for diff.<driver>, it would be
mutually exclusive with "command" where "command" takes precedence, correct?

> 
> I know why one might choose the scheme you did; it kicks in if the repo
> sets the algorithm, without users having to set up any extra config.
> Which is sort of nice, if we assume that malicious actors don't have any
> incentive to pick the algorithm. In theory they don't, though I saw Ævar
> mention possible DoS elsewhere in the thread.
> 
>   Side note: It's also possible that algorithm selection could be
>   required to trigger a separate security bug (say, a buffer overflow in
>   the patience code or something), so restricting that works in a
>   belt-and-suspenders way. But that somehow feels like like the wrong
>   side of the paranoia-vs-feature line.
> 
> So I dunno. I recognize that this scheme fulfills your immediate needs
> better, but I fear that we'll be stuck with a weird split between "diff"
> and "diff-*" attributes forever. In the long run, having a way for the
> repo to say "and here is some config I recommend to you" would give you
> the best of both, but that is a challenging topic that has been
> discussed and punted on for many years.
> 
> -Peff
