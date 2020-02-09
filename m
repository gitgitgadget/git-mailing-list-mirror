Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500BBC2BA83
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 23:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1347A2080C
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 23:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="xq38aUfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgBIX1F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 18:27:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42997 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgBIX1E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 18:27:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id w21so2893145pgl.9
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 15:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mGaqB+DjUZjvIDJcs092PalgW/8QjHMeqkHnArbHfNc=;
        b=xq38aUfUjxYgTUwRcWOHW4XZce9s/UJwblDbC2UcnTRy0+On9lhvcp79MW3SDTLXvV
         BeLzJQMZncA1TsOBq/ZSmxEu69Qqot5nYR8f9Obi4u9ML9NwCQmOpJGTCTrhPNNJ+hPw
         Fon6KC4/zFZgmnd8VzepSxo/cncwrUgVIiNdhAuS7OPhY3p2GgBI0v1CgAOdsGIqj2AW
         7mtrViZPStRBe5VaK9HZolnF8BJUK7ywsUNXGhLhd6jg1LzDMxZvO5RqsyRua3IHohLD
         QCWPU9vTLizC1kSIE0y/1B7Kywc7/DjGXskANDnAXe+vJckEvyymB4D222M8FB4BN/wC
         1jYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mGaqB+DjUZjvIDJcs092PalgW/8QjHMeqkHnArbHfNc=;
        b=BCunG+e8+3j0Rx4tVp81YU0vnFP4OHLPnSmtk/J1Sudhjo2L5Eg26reoAohP/1Tnyr
         2NPIPP+6Y3q50C3ljJw806YtQqwidemmhsUjm7ScuVC0auGP61f+n0kDTvfKnXEO0W9O
         pK00Rxz+WUDlSk34oCMj73rhcPEQAIM/h2N+Hb3ijTzBdN5rolmh5qNgy7GJvocgzEHc
         aANHdPr0xOZc4LgymGoP8Z83+oo5eVpnhgsaKdSb5vPLDN+2i2lxiKul+Lp+1JivcXwK
         4rlI0iMmYmaNFoottWaz+C+/ySH+EGCWo6CWBN/Ic6xeaZZCTcmYN+k8YyNzPhJcBeaj
         KcMQ==
X-Gm-Message-State: APjAAAUPbz4/LIf8lWoqq9gup681FIVKvGQSiphbv9Rw7yi/kOQYZP8F
        g9p8bJcmNoJ+BOhSarNPBeG1tQ==
X-Google-Smtp-Source: APXvYqyHEzGZAw3l6I4SReR1PpXRLcKOp0RFPUuOozeZ3++YB2rCFi2mKYwFl0wIwA7qRb8d4AOukw==
X-Received: by 2002:a63:34cc:: with SMTP id b195mr11838348pga.268.1581290824164;
        Sun, 09 Feb 2020 15:27:04 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:317f:c53e:b83c:7fcb])
        by smtp.gmail.com with ESMTPSA id gx2sm9347869pjb.18.2020.02.09.15.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 15:27:03 -0800 (PST)
Date:   Sun, 9 Feb 2020 15:27:02 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] builtin/commit-graph.c: support
 '--split[=<strategy>]'
Message-ID: <20200209232702.GD4530@syl.local>
References: <cover.1580430057.git.me@ttaylorr.com>
 <4f5bc19903f8a1f5b153b5665de378e743e12744.1580430057.git.me@ttaylorr.com>
 <CAN0heSo29+sf1352EfGv=qFsir-e=Ompja445bh5z3vpOfkaJA@mail.gmail.com>
 <20200204040628.GE5790@syl.local>
 <CAN0heSpg6i7m9tT6LM-8C+cOMGOtDYMdpsuGn-weUo23jgJOTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpg6i7m9tT6LM-8C+cOMGOtDYMdpsuGn-weUo23jgJOTQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 06, 2020 at 08:15:03PM +0100, Martin Ågren wrote:
> On Tue, 4 Feb 2020 at 05:06, Taylor Blau <me@ttaylorr.com> wrote:
> >
> > > Or can you convince me otherwise? From which angle should I look at
> > > this?
> >
> > Heh. This is all very reminiscent of an off-list discussion that I had
> > with Peff and Stolee before sending this upstream. Originally, I had
> > implemented this as:
> >
> >   $ git commit-graph write --split --[no-]merge
> >
> > but we decided that this '--merge' and '--no-merge' requiring '--split'
> > seemed to indicate that this was better off as an argument to '--split'.
> > Of course, there's no getting around that it is... odd to say
> > '--split=no-merge' for exactly the reason you suggest.
> >
> > Here's another way of looking at it: the presence of '--split' means
> > "work with split graph files" and the '[no-]merge' argument means:
> > "always/never condense multiple layers".
> >
> > For me, this not only makes the new option language jive, but makes it
> > clearer to me than the combination of '--split', '--split --no-merge'
> > and '--split --merge', where the third one is truly bizarre. At least
> > condensing the second '--' and making 'merge' an argument to 'split'
> > makes it clear that the two work together somehow.
>
> Yes, "--split --merge" sounds no better. :-)

:-).

> > If you have a different suggestion, I'd certainly love to hear about it
> > and discuss. But, at least as far as our internal discussions have gone,
> > this is by far the best option that we have been able to come up with.
>
> I can't come up with anything better, so please feel free to carry on
> (as you already have).

Sounds good. It looks like you might have had some further thoughts a
little bit lower down in the thread, so I'll respond to those shortly
just to make sure that I didn't miss anything before readying a 'v3' for
submission.

>
> > > > -               OPT_BOOL(0, "split", &opts.split,
> > > > -                       N_("allow writing an incremental commit-graph file")),
> > > > +               OPT_CALLBACK_F(0, "split", &split_opts.flags, NULL,
> > > > +                       N_("allow writing an incremental commit-graph file"),
> > >
> > > This still sounds very boolean. Cramming in the "strategy" might be hard
> > > -- is this an argument in favor of having two separate options? ;-)
> >
> > Heh. Exactly how we started these patches when I originally wrote
> > them...
>
> You left this as-is in v2. I don't have any immediate improvements to
> offer. I could see shortening the original to "use the 'split' file
> format", in which case maybe one could allude to a strategy here. (I
> don't think "allow" is really needed, right? Maybe it tries to cover for
> the situation where there's no commit graph yet, so you might say we
> wouldn't write an "incremental" one, but the format would still be the
> same, AFAIU. Anyway, that's outside the scope of this patch.)

Yeah, I agree that the use of "allow" is a little funny for these
reasons. That said, I don't think that it's in dire need of changing,
and so since we agree that it's outside the scope of this series, I'm
happy to ignore it for now.

> Martin

Thanks,
Taylor
