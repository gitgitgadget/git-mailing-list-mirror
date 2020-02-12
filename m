Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11990C352A4
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 20:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1F321739
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 20:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="qqRx5aC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgBLUub (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:50:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45244 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBLUub (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 15:50:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22so1393840pls.12
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 12:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=m7vJ84Jq3WLHwIZQfIkniiZFqye6bDiypRpNVQT7mYs=;
        b=qqRx5aC+Vg8oiCTJDTJma+v1AoIjy+XPiDQFBN8e0CrH/i53J3k2owL4ZNVp7pBFSk
         yeySh8mwIlJ+r+6FAjnMYSebK2f+t+lCXtjGDWMC0CdAPVdglPl3yU1g7KXMkKpwA17I
         26h8XoEico0BtIM1HBrJyu/tqre7bgoRSSwfOLv0H+Ln0wLMRIr08tp+OrVKteyGUMZT
         ARsVMXNRX/ITjlwsb+e34zOYWyTcZK2CPE5IXE2SlWY9dnHyvkvTNVUWFS5IsdLMNdSa
         uQM9VA6falFoNo96AvJbPzws+cDB/0KGyEHPL75jU0EMwHzgBi62EWsrOSiAu5RresX9
         KpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=m7vJ84Jq3WLHwIZQfIkniiZFqye6bDiypRpNVQT7mYs=;
        b=jNe0m4d+2vY9w9aMCdhRishzpIlCK74p3hMChLzPn/floIntAjJJD23Y4bhYzk98qc
         X476XH9I4hITtrIALcwUOGRYCouMkZ1bNOjc7v8goFvyCO1flU+R/kJ61mkj47M5coW2
         xsRNN7QmN6yJF2yXbBiiqHSFjI/QCvTH727K3spR7UEPtZT7r5fogDat2XA7B0IPwD3R
         5mPszdR80bjrgqseiSGFb9ScFXAZq3jIk8LPNf1a6TE6oh9rGUHB2KJdHWAi3BPCWzLJ
         wDUuaxASYYVLHr4YxR0Q4nNL4rVZZuQ7tlYVONxi05ZMacGBI1ws5P0aw/1seWz41oqv
         9lXw==
X-Gm-Message-State: APjAAAWPf24URSLX/GqxLCsUMJlZYe6RbV16O1ykyW79tqF4NKOpZpCs
        I3l9Xi8JYdH9kNqQ+EedsBc5jw==
X-Google-Smtp-Source: APXvYqwX39SsMec9vprFMtV2Bp2C2isMYOK2spWCeoCdaWLyKayibpJ71bSEirOB+W0uigttoU+XNg==
X-Received: by 2002:a17:902:b498:: with SMTP id y24mr9986453plr.343.1581540630441;
        Wed, 12 Feb 2020 12:50:30 -0800 (PST)
Received: from localhost ([205.175.106.8])
        by smtp.gmail.com with ESMTPSA id 144sm142524pfc.45.2020.02.12.12.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 12:50:29 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:50:28 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] builtin/commit-graph.c: support
 '--split[=<strategy>]'
Message-ID: <20200212205028.GE4364@syl.local>
References: <cover.1580430057.git.me@ttaylorr.com>
 <cover.1580862307.git.me@ttaylorr.com>
 <3e19d50148c8d53b30f8f0036a2d3af9f4bb3499.1580862307.git.me@ttaylorr.com>
 <CAN0heSrXZd7ktBTHaYFWjhW=NcGx5gL52-unSDaC4ZoNf96HFA@mail.gmail.com>
 <3acac399-9476-e4ad-556e-e0138380eeb0@gmail.com>
 <CAN0heSrNJ5XdJ=w=xgNQORAyprOD6xudivveroXV-OJwO6nBvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrNJ5XdJ=w=xgNQORAyprOD6xudivveroXV-OJwO6nBvg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 12, 2020 at 07:03:46AM +0100, Martin Ågren wrote:
> On Fri, 7 Feb 2020 at 16:48, Derrick Stolee <stolee@gmail.com> wrote:
> >
> > On 2/6/2020 2:41 PM, Martin Ågren wrote:
> > > On Wed, 5 Feb 2020 at 01:28, Taylor Blau <me@ttaylorr.com> wrote:
> > >> -               OPT_BOOL(0, "split", &opts.split,
> > >> -                       N_("allow writing an incremental commit-graph file")),
> > >> +               OPT_CALLBACK_F(0, "split", &split_opts.flags, NULL,
> > >> +                       N_("allow writing an incremental commit-graph file"),
> > >> +                       PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
> > >> +                       write_option_parse_split),
> > >
> > >
> > > I keep getting back to this -- sorry! So this actually forbids
> > > "--no-split", which used to work before. Unfortunate?
> >
> > That certainly is unfortunate. Hopefully no one is taking a dependence on
> > this, which only means something if they had a `--split` previously in
> > the command-line arguments.
> >
> > > I have to ask, what is the long-term plan for the two formats (split and
> > > non-split)? As I understand it, and I might well be wrong, the non-split
> > > format came first and the split format was a user-experience
> > > improvement. Should we expect that `--split` becomes the default?
> >
> > In some ways, the split is now the default because that is how it is
> > written during 'git fetch' using fetch.writeCommitGraph. However, I
> > don't think that it will ever become the default for the commit-graph
> > builtin.
>
> Thanks for giving this piece of background.
>
> > > To try to be concrete, here's a suggestion: `--format=split` and
> > > `--split-strategy=<strategy>`.
> >
> > Why --format=split instead of leaving it as --[no-]split? Is there a reason to
> > introduce this string-based option when there are only two options right now?
>
> My thinking was, if my concern is "--split" being overloaded, what would
> it look like to "unload" it entirely? From "--split" it isn't obvious
> whether it's a verb or an adjective (shall we split, or shall we do
> things the split way?). Having "--format=split" would help avoid *that*,
> possibly leaving a cleaner field for the issue of "do we
> allow/force/forbid the 'merging' to happen?". But I'm happy to accept
> "--split=<strategy>" and move on. :-)
>
> I see that Taylor juuust posted a v3. I'll try to find time to look it
> over, but I won't be raising this point again.

It looks like we raced :-). Sorry about that. I didn't see your email
until after I sent, and I certainly would have waited if I knew that you
were writing an email to the same thread as I was working in at the same
time.

I'm still fairly happy with the '--split[=<strategy>]' approach that is
implemented in all versions of this patch series, although I do
understand your suggestions.

My preference would be to see if anybody else feels like the trade-off
*is* worth it (I explained earlier in the thread some reasons why I feel
that the trade-off is *not* worth it), but I'd be happy to move this
series forward as-is unless others echo this idea.

> Martin

Thanks,
Taylor
