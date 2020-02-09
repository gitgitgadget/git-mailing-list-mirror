Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135E6C2BA83
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 23:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE822080C
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 23:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="PuVpbPIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBIXap (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 18:30:45 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36233 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgBIXap (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 18:30:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id 185so2775548pfv.3
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 15:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5l9vW95Di4Av01gPjvk2fRM//mhyflmTvfHKo02OX90=;
        b=PuVpbPIfSyYUyvzV+grjd3W3GjSqYWhF+FJK1hWzKq53BWMy2EgTCtmpolw/e+MdXZ
         FpVFp6KD7Bd2MMYxb/BbbKXQeX+Afl7Yp48WfqEnU3adiCwArKdgSkgxf1QlFsITLuwD
         K+bjysznJtKAm1UQ+rt9S6iFldaMA2kZhYzfxdC0GjhtMRcuyxyWeghi4aon+QjrsfgQ
         qydHz5pIpiacelotIQ1nwJrXMma7QE/MeqsnZfJuXDKGj5LI3wt6ASz1DmcgmEAzK7OD
         1zZ1BhdNRHSexcc47Ld0dp0IYvoA8AR8DEWvsQwfLomVNvMDaxMWPfvlabYBmkNmL1Xb
         CzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5l9vW95Di4Av01gPjvk2fRM//mhyflmTvfHKo02OX90=;
        b=hue3cFK8c6PmcrQmxSsf4erWXQ7JCpHLTTLi/r2rtGt8ybtV1aPe5iR63CyEqQ+fER
         dWxA6cIJ8ot9PW67dCJGpeI96r+kKDJJnqpMe8CSE2Z63OwmFrqg7v52L9qA2UD8b32i
         c2hojMdxGNk/YiDoCLHWGxq+BPkCIVIYkQREVm1Mq4lV/XzyQT56E5HWVvo+tUD+ZHO9
         B6RIsTcKavYxoQpx36EIiqlEuwoVZW4/1npOQ45t1TTN6YOYSKH6BsgOxOx6+EfwnUn2
         7dZinqKxqLhTGY8n9joK4zQ7ug304GO03CCE3ABGjY5ZQOWMGNRJlcxqQK0d0utrltKY
         pLzQ==
X-Gm-Message-State: APjAAAUDlUHtpwEFVUX9KupQrN7nJr7W4WqtMdRTPdLSNzXU5JQSCFpH
        0UqNeKRzmStKo88pvPDtc17z0Q==
X-Google-Smtp-Source: APXvYqxIjJv1Bw6wrWNuPAWqgA7mH9ANA3DJV7aV8ZDdUVTXCVnnLpUUdZNzA0303kfYNJQemNa4+g==
X-Received: by 2002:a63:2010:: with SMTP id g16mr11794260pgg.314.1581291043167;
        Sun, 09 Feb 2020 15:30:43 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:317f:c53e:b83c:7fcb])
        by smtp.gmail.com with ESMTPSA id o19sm19692833pjr.2.2020.02.09.15.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 15:30:42 -0800 (PST)
Date:   Sun, 9 Feb 2020 15:30:42 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] builtin/commit-graph.c: support
 '--split[=<strategy>]'
Message-ID: <20200209233042.GE4530@syl.local>
References: <cover.1580430057.git.me@ttaylorr.com>
 <cover.1580862307.git.me@ttaylorr.com>
 <3e19d50148c8d53b30f8f0036a2d3af9f4bb3499.1580862307.git.me@ttaylorr.com>
 <CAN0heSrXZd7ktBTHaYFWjhW=NcGx5gL52-unSDaC4ZoNf96HFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrXZd7ktBTHaYFWjhW=NcGx5gL52-unSDaC4ZoNf96HFA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 06, 2020 at 08:41:28PM +0100, Martin Ågren wrote:
> On Wed, 5 Feb 2020 at 01:28, Taylor Blau <me@ttaylorr.com> wrote:
> > diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> > index 28d1fee505..b7fe65ef21 100644
> > --- a/Documentation/git-commit-graph.txt
> > +++ b/Documentation/git-commit-graph.txt
> > @@ -57,11 +57,17 @@ or `--stdin-packs`.)
> >  With the `--append` option, include all commits that are present in the
> >  existing commit-graph file.
> >  +
> > -With the `--split` option, write the commit-graph as a chain of multiple
> > -commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
> > -not already in the commit-graph are added in a new "tip" file. This file
> > -is merged with the existing file if the following merge conditions are
> > -met:
> > +With the `--split[=<strategy>]` option, write the commit-graph as a
> > +chain of multiple commit-graph files stored in
> > +`<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
> > +strategy and other splitting options. The new commits not already in the
> > +commit-graph are added in a new "tip" file. This file is merged with the
> > +existing file if the following merge conditions are met:
>
> Please add a lone "+" here.

Sure, thanks for noticing.

> > +* If `--split=merge-always` is specified, then a merge is always
> > +conducted, and the remaining options are ignored. Conversely, if
> > +`--split=no-merge` is specified, a merge is never performed, and the
> > +remaining options are ignored. A bare `--split` defers to the remaining
> > +options.
> >  +
>
> Similar to this existing one here. There's some minor misrendering here
> otherwise.
>
> >  * If `--size-multiple=<X>` is not specified, let `X` equal 2. If the new
> >  tip file would have `N` commits and the previous tip has `M` commits and
>
> > -               OPT_BOOL(0, "split", &opts.split,
> > -                       N_("allow writing an incremental commit-graph file")),
> > +               OPT_CALLBACK_F(0, "split", &split_opts.flags, NULL,
> > +                       N_("allow writing an incremental commit-graph file"),
> > +                       PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
> > +                       write_option_parse_split),
>
>
> I keep getting back to this -- sorry! So this actually forbids
> "--no-split", which used to work before. Unfortunate?

Ah, I see. Yes, this definitely *does* forbid that. My thinking when I
decided to give this 'PARSE_OPT_NONEG' was that '--no-split' is
confusing for users: does it mean "don't split" or "unset any split
options"?

This probably would be ameliorated by your suggestion below, maybe of
'--split-strategy', specifically (I could probably go either way on
'--format=split', but it really depends on what Stolee has planned
long-term). Then, '--[no-]split' remains clear, as does
'--no-split-strategy' (although I suppose that you could make the
argument that '--no-split-strategy' sounds a little bit like letting the
machinery use its defaults, which may or may not be true depending on
how it's implemented.)

But, I'm not sure that it's all worth it to add another option here.
This sub-builtin has a plethora of options already, and I'm skeptical
that there are a lot of real-world uses of '--no-split' in the wild that
we'd be breaking.

> I have to ask, what is the long-term plan for the two formats (split and
> non-split)? As I understand it, and I might well be wrong, the non-split
> format came first and the split format was a user-experience
> improvement. Should we expect that `--split` becomes the default? In
> which case `--no-split` would be needed. Or might the non-split format
> go away entirely, leaving `--split` a no-op and `--split=<strategy>` a
> pretty funky way of choosing a strategy for the one-and-only file
> format?
>
> To try to be concrete, here's a suggestion: `--format=split` and
> `--split-strategy=<strategy>`.
>
> Martin

Thanks,
Taylor
