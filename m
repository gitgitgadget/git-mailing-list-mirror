Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D36C35254
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 19:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0D72080C
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 19:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="dPZdi5eN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBJT4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:56:45 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:40954 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJT4p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 14:56:45 -0500
Received: by mail-pj1-f45.google.com with SMTP id 12so203652pjb.5
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 11:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4tfAIv7FJtj8nGeGsVedvk2NOovOhGINsBNVfHCWbxA=;
        b=dPZdi5eNb5vGWucLWLtO2SFhdsY2BDAELG58SGoiaFXlOEOnM0dpvgAPl2JDKPGc1X
         ClP6NnCuraVyIPVX7yreFD1/bnPHyDGxffeF4CgaB72V/VVAgAav4my2a2OGmqCovK5O
         xYJOljgr0GiK1u0mXNsN15Cz3heaP2RbuYn39C3C6FFHFdcifU/UZvcn9lexeG55RFQT
         ojId5oysxsN8BYhjOUWJFg/QKgXYlmvguZyywrCjLyqvQWIqEVZHTavpi/7rp0FAykYy
         Xu/4ye1VTrUpHWiVfdhrxQRNmeYxrX2PZKFWMNOmOVTLI0M6f65EN6sC9yZM14MyYeq9
         sGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4tfAIv7FJtj8nGeGsVedvk2NOovOhGINsBNVfHCWbxA=;
        b=bDkwud/aQvWhuHyupk+K5kN+no/ZDCs1u5UpKLYEV2klEEj0IekVOyNzk/NxdVyqmz
         86UFpnCK6jf4yG1yi086QPZ6457R485bep+WRT/YuVXROwagbaDqthWDaxfMbEU2ECxB
         M6jawVCrlm5kHhgZJU89K7M0ee/Uj8T6RSPokADiNovTmI4hLdSd/qeYnN1sx9C8tkNg
         RmGqkXDois/3MuMtSDX+CgAiQH3bRoGxaF4CLMGyW9qfGnarATsedLXQrS9H4IR9T/E3
         ZYhZXE4FM09KCqLEo+01+6TERT040zSjzXqs3lniQRqn78mvIAZfy+582pWyc+h8LOio
         FkbQ==
X-Gm-Message-State: APjAAAWIg4pvXNgHCVrZ08WTfx5XmX1p7QNuiGXP8I6YczPNafelpNUN
        aWLrj+503/0JDvOmBvwxz44lHFdM92K9GA08
X-Google-Smtp-Source: APXvYqwNKX7xsqFx+gpsG2cMDgwZqdke8rIztLqRtTJ7qDu2ShnenMgGMxausICCyKDCyD8caD7Uww==
X-Received: by 2002:a17:90a:c20d:: with SMTP id e13mr798497pjt.95.1581364604721;
        Mon, 10 Feb 2020 11:56:44 -0800 (PST)
Received: from localhost ([205.175.106.6])
        by smtp.gmail.com with ESMTPSA id fz21sm238321pjb.15.2020.02.10.11.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:56:44 -0800 (PST)
Date:   Mon, 10 Feb 2020 11:56:43 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Feb 2020, #01; Wed, 5)
Message-ID: <20200210195643.GC46461@syl.local>
References: <xmqqpnesfw74.fsf@gitster-ct.c.googlers.com>
 <20200206025130.GA22748@syl.local>
 <20200206085747.GA17654@szeder.dev>
 <20200206174837.GA55561@syl.local>
 <CAN0heSrcMYwy72oR0HA+ptEutLFqvs14RLF5AVE1ATJTUj=eVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrcMYwy72oR0HA+ptEutLFqvs14RLF5AVE1ATJTUj=eVw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 06, 2020 at 08:58:50PM +0100, Martin Ågren wrote:
> On Thu, 6 Feb 2020 at 18:48, Taylor Blau <me@ttaylorr.com> wrote:
> >
> > On Thu, Feb 06, 2020 at 09:57:48AM +0100, SZEDER Gábor wrote:
> > > On Wed, Feb 05, 2020 at 06:51:30PM -0800, Taylor Blau wrote:
> > > > > * tb/commit-graph-split-merge (2020-02-05) 3 commits
> > > > >  - builtin/commit-graph.c: support '--input=none'
> > > > >  - builtin/commit-graph.c: introduce '--input=<source>'
> > > > >  - builtin/commit-graph.c: support '--split[=<strategy>]'
> > > > >  (this branch uses tb/commit-graph-object-dir.)
> > > > >
> > > > >  The code to write out the commit-graph has been taught a few
> > > > >  options to control if the resulting graph chains should be merged
> > > > >  or a single new incremental graph is created.
> > > > >
> > > > >  Will merge to 'next'?
> > > >
> > > > I think that this is ready. Martin Ågren and I discussed a little bit
> > > > about the rationale behind why the new options were chosen over
> > > > alternatives, but I think we reached consensus (at least, the thread has
> > > > been quiet for a few days after sending 'v2').
> > > >
> > > > So, if you're asking whether or not this is ready to merge to 'next',
> > > > I'd say that it is, but I'd like to hear from Martin's thoughts, too.
> > > > (For what it's worth, we're *also* running this at GitHub, and without
> > > > issue).
> > >
> > > Please don't rush it, those '--input=<source>' options need more
> > > consideration.
> >
> > Of course, and I'm happy to discuss more, if that's what others discuss.
> > I thought that things had settled since the thread quieted down after
> > sending 'v2'. But, if there's more to discuss, certainly we should do
> > that before queuing this up.
> >
> > Let's wait a little while longer and see what happens there before
> > queuing this topic.
>
> I feel there's something awkward about these new options, but it's not
> like I have brilliant suggestions to offer. But I don't think it hurts
> to wait a little and see if others chime in.
>
> At a minimum, the two comments (patches 1/3 and 3/3) I just left on some
> asciidoc hickups should be fixed before this graduates (that should be
> easy). I'll be happy to test and give a thumbs-up if needed.

I have amended both of those patches (1/3 and 3/3) locally, and pushed
it to 'https://github.com/ttaylorr/git' under the branch named
'tb/commit-graph-split-merge'.

I'll wait a couple of more days or so to see if there's any more
discussion on that thread, and if there isn't, I'll send those as an
anticipated final v3.

> Martin

Thanks,
Taylor
