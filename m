Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A61FC2BA83
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 23:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E712F2080C
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 23:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="CxeLp0hQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgBIXca (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 18:32:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41197 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgBIXca (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 18:32:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id t14so2062944plr.8
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 15:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SbI4Uca3yNixv7gB9bzc/hy05qayM15xjrITq8WkptQ=;
        b=CxeLp0hQ/lvSCFXPBhEm8Ja+GTZy4gQMfQyzraEtGuhePgsq2qVFypEIyH8Pod5uOx
         D6sO55PrFLW6p8Y5mQTcHGcq8CxC8y1IpBQj+YHf/Ji1sFaXsrYRnayQp6tPCC3GRy/1
         yq84qtlxrz+OFc6F503ANWrnsQlXm/5Y1EI5uiNHkn1aRLbx1lhQnFrTvg9+9UBqvqTx
         uP3NzutSju+rjzXWAVfKxRmI06rqE0mKgYTCjB6A/XkywUAgdIBfHbh9sduxyMeZ8jJB
         Q2yBa0QlSxbFP9FnwUB12nMg9BiuGMPIP6ValhLfdaK4ET6GHW0DI9Xv+vZq+U5jzJgj
         +FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SbI4Uca3yNixv7gB9bzc/hy05qayM15xjrITq8WkptQ=;
        b=iCipP26TGVzSbbfuqkg/mGa3GYPaIYjxwatr1j4wv2BFCS8X/JXIiGvXzY9HGHdfyw
         CQNkbmY6fPdAoWpAsFjrzBGxmPuleti1mj8k5MbbVUbYggqsvzfdAC5Yap1qLQOAJ7Z0
         uxTQXDJUSKqOV6Td/iuIIw48RcPKuBrl2PMEnDEWQN5yt991a3Llw24iYVMyHSjKikFs
         /iRXeMF6RuYIhSUSoAmHrpyJyykoIucCDQ8YWBUVzt+VOWocedgjex8H7wA5ePRj1Fug
         tZwvO9iH9zpobmj42ZnDzo/N7zYvWCOCcnb5A/hfkNUuYAb8pKlbJX2jDaYfkZB5c02t
         hfmg==
X-Gm-Message-State: APjAAAXDkC/Y2gc0T41/5A02IWjS6wf3rEp/cTU7Zz9jyqrW5kozCYDI
        ryqXjchsy5C79PFg5bEDkfslrA==
X-Google-Smtp-Source: APXvYqwyjUgreJcGkgntDwwjzVH0dJOujcpshEToDpFLKhzVaG6zaS7aaGzE+sozNGCCUqwvwYMQpA==
X-Received: by 2002:a17:902:45:: with SMTP id 63mr10190040pla.109.1581291148403;
        Sun, 09 Feb 2020 15:32:28 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:317f:c53e:b83c:7fcb])
        by smtp.gmail.com with ESMTPSA id z10sm10412664pgz.88.2020.02.09.15.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 15:32:27 -0800 (PST)
Date:   Sun, 9 Feb 2020 15:32:27 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] builtin/commit-graph.c: support
 '--split[=<strategy>]'
Message-ID: <20200209233227.GF4530@syl.local>
References: <cover.1580430057.git.me@ttaylorr.com>
 <cover.1580862307.git.me@ttaylorr.com>
 <3e19d50148c8d53b30f8f0036a2d3af9f4bb3499.1580862307.git.me@ttaylorr.com>
 <CAN0heSrXZd7ktBTHaYFWjhW=NcGx5gL52-unSDaC4ZoNf96HFA@mail.gmail.com>
 <3acac399-9476-e4ad-556e-e0138380eeb0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3acac399-9476-e4ad-556e-e0138380eeb0@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 07, 2020 at 10:48:39AM -0500, Derrick Stolee wrote:
> On 2/6/2020 2:41 PM, Martin Ågren wrote:
> > On Wed, 5 Feb 2020 at 01:28, Taylor Blau <me@ttaylorr.com> wrote:
> >>  * If `--size-multiple=<X>` is not specified, let `X` equal 2. If the new
> >>  tip file would have `N` commits and the previous tip has `M` commits and
> >
> >> -               OPT_BOOL(0, "split", &opts.split,
> >> -                       N_("allow writing an incremental commit-graph file")),
> >> +               OPT_CALLBACK_F(0, "split", &split_opts.flags, NULL,
> >> +                       N_("allow writing an incremental commit-graph file"),
> >> +                       PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
> >> +                       write_option_parse_split),
> >
> >
> > I keep getting back to this -- sorry! So this actually forbids
> > "--no-split", which used to work before. Unfortunate?
>
> That certainly is unfortunate. Hopefully no one is taking a dependence on
> this, which only means something if they had a `--split` previously in
> the command-line arguments.
>
> > I have to ask, what is the long-term plan for the two formats (split and
> > non-split)? As I understand it, and I might well be wrong, the non-split
> > format came first and the split format was a user-experience
> > improvement. Should we expect that `--split` becomes the default?
>
> In some ways, the split is now the default because that is how it is
> written during 'git fetch' using fetch.writeCommitGraph. However, I
> don't think that it will ever become the default for the commit-graph
> builtin.
>
> > In
> > which case `--no-split` would be needed. Or might the non-split format
> > go away entirely, leaving `--split` a no-op and `--split=<strategy>` a
> > pretty funky way of choosing a strategy for the one-and-only file
> > format?
>
> In some ways, the --split=merge-all is similar, except it writes a one-line
> commit-graph-chain file and puts a .graph file in
> .git/objects/info/commit-graphs instead of writing to .git/objects/commit-graph.
>
> > To try to be concrete, here's a suggestion: `--format=split` and
> > `--split-strategy=<strategy>`.
>
> Why --format=split instead of leaving it as --[no-]split? Is there a reason to
> introduce this string-based option when there are only two options right now?
>
> Perhaps using --split-strategy=<strategy> is the most backwards-compatible
> option, especially because we won't need --split="" to substitute for
> "auto-merge". However, I wonder if this is a case where we should make the
> hard choice to sacrifice a narrow backwards-compatibility in favor of a
> simplified set of options?

My preference would be the latter, which I vaguely indicated in my last
email to Martin. Like I said, I think that the number of hypothetical
cases that we're breaking is pretty small, if not zero, and so I don't
feel too worried about changing the behavior like this.

If others feel strongly that keeping '--no-split' functional in the
classical sense is worthwhile, then I'm certainly happy to introduce
'--split-strategy' as another option, but I think that we agree that the
simplicity is worth the tradeoff here.

> Thanks,
> -Stolee

Thanks,
Taylor
