Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CDDC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44960613C1
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhGNRgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhGNRgA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 13:36:00 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74610C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:33:08 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id v32-20020a0568300920b02904b90fde9029so3300262ott.7
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N0sRSCbu5B84eGamlFhhimg1fGKSGpgNyPYodZfC9zI=;
        b=EbkvU7k3om5KQdJ/fMKd8otcNRkuiEvLDhxydG1md7T0K+ZpaB868EmyUM3uW5qACz
         UjudnFlMe4M2LkxQNitHr/8qJ6k0JmFH+DSy9yqWrwN6/95eA7G8oPrm3EOaUvjFzRkE
         u+hUeR7AGYKr44OoKRK7XmryYOORJ81OkvJ/H8gTdFWh0yhLxQExaZrTAbGGTuneue2L
         h+sEazpNx896+pk2ZJpoPaJqUcnCx6Z9SPp/rcRsCUn72R5Pk1S3+FTSt6U4rywHI5tg
         nCbYp/Zx32oZYwDtElhEfBbxQaeS8PtKFKs8pCcwLcXLms85HC9bN1rZwjgEqnr4v6hs
         tkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N0sRSCbu5B84eGamlFhhimg1fGKSGpgNyPYodZfC9zI=;
        b=oYAxQBeC+KI3zVV69KrGlH3d6HzjcOtPSE0joZqWvr0ZhVlrkTpUltJTuz09QZ4yug
         1jbOK3HBuNImUedMiI/lB+ur5TGXIea7el8H6LDFuKXpkhdckKf/AllT6C6k91t8x24P
         1JDgCP0yr7nTBTVOx7Uknsd9mSnYuAfZi0ISXkE+25uLIgpC1O+hQz5amEOVy4bY8R/u
         9H3T9dOdIs3o4F2JTDobLPXsrcqbxRCKLxE2dHIoFqkXeVf70sUtJAMYGOXZRuwYcQ4B
         OFKPwnyRu5FGch3HbPLarKBUNx62yOlpBIHAeABij/SkpzPBnXqe4ovukJaCWN/eDzm3
         Jzkw==
X-Gm-Message-State: AOAM531iGUV1PZA5uiaLIIrUxqXSyyWPOwsNTBGtMjPQdJ1b469+9Rew
        zb+y4wvs4R/+WIoQJGAuoiqI06g69mVFHxfuigg=
X-Google-Smtp-Source: ABdhPJw7Yj84bR3MKQEbdcDA3T+6eC9c5FP3tSoKuP1d/XBoQ/kD4cGN7cy8wOEZQM/x9skcrQsbI7Sc866FPzI2iY8=
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr9106652otd.345.1626283987802;
 Wed, 14 Jul 2021 10:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com> <8f1deb6dd16a0c0d88cf594d2019b3096dbe5383.1626225154.git.gitgitgadget@gmail.com>
 <YO8UPtFr4wRhVTXE@coredump.intra.peff.net>
In-Reply-To: <YO8UPtFr4wRhVTXE@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Jul 2021 10:32:56 -0700
Message-ID: <CABPp-BG7T2QP+6uP57NuE1Htr-vBzozL-aDxU4FsyQO+ELQ9Uw@mail.gmail.com>
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

On Wed, Jul 14, 2021 at 9:43 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jul 14, 2021 at 01:12:33AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > The combined effect of the above is that the file size used in past
> > calculations was likely about 5x too large.  Combine that with a CPU
> > performance improvement of ~30%, and we can increase the limits by
> > a factor of sqrt(5/(1-.3)) = 2.67, while keeping the original stated
> > time limits.
>
> It's slightly sad that we only got a 30% CPU improvement in the past 10
> years. Are you just counting clock speed as a short-hand here? I think
> that doesn't tell the whole story. But all of this is a side-note
> anyway.  What I care about is your actual timings. :)

I'm using shorthand when discussing file sizes above (though I used
actual measurements when picking new values below).  But the 30% came
from measuring the timings with the exact same sample file as you and
using a lightly modified version of your original script (tweaked to
also change file basenames) on an AWS c5xlarge instance.  My timings
showed they were only about 30% faster than what you got when you last
bumped the limits.

All my laptops and even my work machine are pretty old, so I picked an
AWS c5xlarge instance hoping it'd represent a relatively new machine
(since your benchmarks when you bumped were using a new machine at the
time).  Maybe the stock c5xlarge instance I picked wasn't a good
choice (wasn't new enough? had a low relative clock speed? affected by
Spectre patches? had slow disks? something else?).  Or maybe single
processor speed really did just hit up against Moore's law and nearly
all gains have shifted to having more cores available which don't
benefit us here since our algorithm is serial.

> (It also seems like this rename detection is ripe for parallelization,
>  but obviously that's a totally separate topic).

True.

> > Using the original time limit of 2s for diff.renameLimit, and bumping
> > merge.renameLimit from 10s to 60s, I found the following timings using
> > the simple script at the end of this commit message (on an AWS c5.xlarge
> > which reports as "Intel(R) Xeon(R) Platinum 8124M CPU @ 3.00GHz"):
> >
> >       N   Timing
> >    1300    1.995s
> >    7100   59.973s
> >
> > So let's round down to nice even numbers and bump the limits from
> > 400->1000, and from 1000->7000.
>
> Sounds good. Thanks for thoroughly measuring and updating.
