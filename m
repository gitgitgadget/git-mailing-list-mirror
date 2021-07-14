Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6130CC47E4D
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C762613C0
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhGNULc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244219AbhGNULD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 16:11:03 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2456C09CE66
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 13:03:54 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id e11so624802oii.9
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 13:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4qzze5X150n1lSjjVtKPittKmZmQiKpQK75YZoLWtE=;
        b=n8Gxns4lDFI+po1M0O5O/f3R9CXltlTRB4sadYK+jMtChGHyTBuZffJ9NNEVpCqav3
         QVAAeaJY1Nwnm/GjcnFft9/q3y8HmJyHsfI14YA5nqwrN+UqwLa9WMtn0moRlqdEezp4
         oh4olJU+FvmFsAjqxSBPqXJWSI2i3Zl3fbSKJIabI9iMlu+ciZSsZRRQfyZOq2XnWerq
         GTTwKcuOiCxaIVQHwWgxBSHd/5WRYjCK7WzsZbXJpHfJjbukthTCfC+mHP0wh6JP3EB+
         Pmf4sINylhjkos4Iw4dEqjHgsVvYnoNK6Bqbu3mX9ZccMczcqzNFp8x3AQaVw2AQb8GH
         U0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4qzze5X150n1lSjjVtKPittKmZmQiKpQK75YZoLWtE=;
        b=Tw4/EgjLe8Ef8kiV/L9CZlsKgVHI2S86hW0IBtBqhJf4FFHWqGGBUtYqrIdn+BXWt0
         R7ZWCeA0yyXCW7AZdCYzXUcwL+gU/tWlnasOI34YYf51SOJY2YISVAFPZ4yfMaGd64Qe
         ly1annhXSI4DxeiN0USLicegJGh4mo2Av8qThq9Uy6rGEuFmr588zYcAUvXDiBJCKnLk
         CjVHEdKiTj3iNk8IWlEPI/yqzgF69jr5P2JAomWYuyhlClxGmltZBa/f4NB9cPGqiozD
         eecGVI7STrKgI/nWG7EZLitMEH0jCqUQeDqg66eLVnTbNawcyKiXEu1YkXG8lB3oeCZP
         u2LQ==
X-Gm-Message-State: AOAM531PWSAhFC65A+2T7P8WlCcprW4pBOSgDv6Zpnn5ffyQ2Iz/ca1U
        cxiiKw0DpCfcCdjff0d5AplWvIVNCuBEvWYJM94ir7ZDNLk9MQ==
X-Google-Smtp-Source: ABdhPJwSUGdert6muADvzkIHrKqCS2uD3XAvS2BTehYHfbLsJuj5OV7Ezkcd01OF9tKNXSwYnPK0LDST4Rj/1Tfpiz8=
X-Received: by 2002:aca:acc5:: with SMTP id v188mr4087914oie.167.1626293034069;
 Wed, 14 Jul 2021 13:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com> <8f1deb6dd16a0c0d88cf594d2019b3096dbe5383.1626225154.git.gitgitgadget@gmail.com>
 <YO8UPtFr4wRhVTXE@coredump.intra.peff.net> <CABPp-BG7T2QP+6uP57NuE1Htr-vBzozL-aDxU4FsyQO+ELQ9Uw@mail.gmail.com>
 <YO8lgYa5/RlL1zGp@coredump.intra.peff.net>
In-Reply-To: <YO8lgYa5/RlL1zGp@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Jul 2021 13:03:43 -0700
Message-ID: <CABPp-BE=Ghkm=sZ05=A=1vC1zscbVk7qXgeEjpA5gHxsfTGAyg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Bump rename limit defaults (yet again)
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 10:57 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jul 14, 2021 at 10:32:56AM -0700, Elijah Newren wrote:
>
> > > It's slightly sad that we only got a 30% CPU improvement in the past 10
> > > years. Are you just counting clock speed as a short-hand here? I think
> > > that doesn't tell the whole story. But all of this is a side-note
> > > anyway.  What I care about is your actual timings. :)
> >
> > I'm using shorthand when discussing file sizes above (though I used
> > actual measurements when picking new values below).  But the 30% came
> > from measuring the timings with the exact same sample file as you and
> > using a lightly modified version of your original script (tweaked to
> > also change file basenames) on an AWS c5xlarge instance.  My timings
> > showed they were only about 30% faster than what you got when you last
> > bumped the limits.
>
> Interesting. My timings are much faster. With a 20k file, I get (on my
> laptop, which is an i9-9880H):
>
>      N     CPU (2008)    CPU (now)
>     10          0.43s       0.007s
>    100          0.44s       0.071s
>    200          1.40s       0.226s
>    400          4.87s       0.788s
>    800         18.08s       2.887s
>   1000         27.82s       4.431s
>
> The 2008 timings are from the old email you linked in your commit
> message, and the new one is from running the revised script you showed.
> The savings seem like more than 30%. I don't know if that's all CPU or
> if something changed in the code.

I was using the script you wrote in 2008, but comparing to your
reported numbers in 2011[1].  When you bumped in 2011, you said you
picked the limits of 400 & 1000 in order to give rough timings of 2s
and 10s.  So the table looks more like:

   N  CPU (2008)  CPU (2011)  c5xlarge  CPU (yours)
 400    4.87s         ~2s      1.106s      0.788s
1000   27.82s        ~10s      6.350s      4.431s

So, 2011->c5xlarge on these (just recomputed now numbers) show
improvements of ~45% and ~36%.  Maybe I had an outlier run earlier
that was in the upper 6s range for N=1000 and I rounded off to 30% for
the commit message?  Don't know, those numbers are on a laptop that
died in the last few days.

But yeah, you are seeing a bigger improvement than I did; 2011->your
current laptop shows roughly 56% - 60% improvement.

[1] https://lore.kernel.org/git/20110219102128.GB22508@sigill.intra.peff.net/

> Using a 3k file (the median for ls-tree), numbers are similar, but a
> little smaller (my n=1300 is about 1.4s).  So I think we're both in the
> same ballpark (and certainly an AWS machine is a perfectly fine
> representative sample of where people might run Git).

Yeah, dividing any of the timings I get by the ones you get seem to be
giving a value somewhere around 1.4, so that seems reassuring on the
consistency front.  That doesn't fix my jealousy of your faster CPU,
but that's a separate problem.  :-)
