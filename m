Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC72C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 114C323976
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbgI0IZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 04:25:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:42356 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730397AbgI0IZE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 04:25:04 -0400
Received: (qmail 29065 invoked by uid 109); 27 Sep 2020 08:25:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 27 Sep 2020 08:25:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3958 invoked by uid 111); 27 Sep 2020 08:25:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Sep 2020 04:25:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 27 Sep 2020 04:25:03 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] shortlog: allow multiple groups to be specified
Message-ID: <20200927082503.GE1286220@coredump.intra.peff.net>
References: <20200925070120.GA3669667@coredump.intra.peff.net>
 <20200925070550.GH62741@coredump.intra.peff.net>
 <CAN0heSp5ssE1_-0B4VMGcuOaW63EpWXRVp4E4gy_7zVZ1rWkew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSp5ssE1_-0B4VMGcuOaW63EpWXRVp4E4gy_7zVZ1rWkew@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 26, 2020 at 02:48:44PM +0200, Martin Ågren wrote:

> On Fri, 25 Sep 2020 at 09:09, Jeff King <peff@peff.net> wrote:
> > +static inline int has_multi_bits(unsigned n)
> > +{
> > +       return (n & (n - 1)) != 0;
> > +}
> 
> There's a HAS_MULTI_BITS macro in git-compat-util.h. I like how you came
> up with the exact same name. It even makes me wonder if you are actively
> avoiding it in favor of a re-implementation, but I can't see why.

Heh. I _thought_ we had such a helper, and I even thought I remembered
the name. But when I grepped for it, I couldn't come up with it. Silly
"-i". (So I guess it's no surprise that I came up with the same
implementation, which is the only good one, and the same name, which I
did pull from the back of my mind).

I'll drop this in favor of the macro.

> >         enum {
> > -               SHORTLOG_GROUP_AUTHOR = 0,
> > -               SHORTLOG_GROUP_COMMITTER,
> > -               SHORTLOG_GROUP_TRAILER
> > -       } group;
> > +               SHORTLOG_GROUP_AUTHOR = (1 << 0),
> > +               SHORTLOG_GROUP_COMMITTER = (1 << 1),
> > +               SHORTLOG_GROUP_TRAILER = (1 << 2)
> > +       } groups;
> 
> Coming back to the comment on 2/8, adding a comma at the end wouldn't
> reduce patch noise here and now, but whenever someone touches this place
> the next time.

Agreed, will do.

> Of my comments in the last few mails, probably the only actionable one
> is the truncated sentence in the trailer iterator header file.

I agree none are big, but worth addressing since I was making a re-roll
anyway. Thanks.

-Peff
