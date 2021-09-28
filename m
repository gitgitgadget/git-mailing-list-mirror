Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2895BC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 05:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A8F6113E
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 05:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbhI1FoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 01:44:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:56222 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234243AbhI1FoK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 01:44:10 -0400
Received: (qmail 8661 invoked by uid 109); 28 Sep 2021 05:42:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Sep 2021 05:42:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26208 invoked by uid 111); 28 Sep 2021 05:42:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Sep 2021 01:42:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Sep 2021 01:42:30 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        The Grey Wolf <greywolf@starwolf.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] config: add an includeIf.env{Exists,Bool,Is,Match}
Message-ID: <YVKrRooSIN7OeLy9@coredump.intra.peff.net>
References: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
 <patch-1.1-1fe6f60d2bf-20210924T005553Z-avarab@gmail.com>
 <YU49+Y+nRhl1mgof@coredump.intra.peff.net>
 <xmqqa6k1slxe.fsf@gitster.g>
 <YU5KOpGkS5sH4iFJ@coredump.intra.peff.net>
 <xmqqo88eq8um.fsf@gitster.g>
 <YVImeFHxY7hmb3wY@coredump.intra.peff.net>
 <87lf3hzhkr.fsf@evledraar.gmail.com>
 <YVJkx2HMf9WlPx6G@coredump.intra.peff.net>
 <878rzhz9yw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878rzhz9yw.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 04:42:51AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > A perhaps more subtle but less awkward to type version is to just
> > require two arguments, like:
> >
> >   git --config <key> <value> ...
> 
> I suppose --config would work like that, you can'd to it with "-c". I
> think it's more confusing to have a "-c" and "--config" which unlike
> most other things don't follow the obvious long and short option names
> working the same way.

Yeah, probably "--config-pair" or something might be less confusing.
Anyway...

> > but I'd just as soon continue to leave it un-implemented if nobody has
> > actually needed it in practice.
> 
> *nod*. I do think it's bad design to introduce an "env" inclusion
> feature that relies on "=" though while we don't have something like
> that, i.e.
> 
> I think we should probably not add that --config-{key,value}, but
> avoiding the arbitrary limitation of not being able to specify certain
> config keys seems prudent in that case, and since the "=" v.s. ":" is
> only an aesthetic preference I think being able to compose things
> without limitations wins out.

I don't really agree with that. Whatever syntax we use now, we'll be
stuck with forever. It seems a shame to predicate that choice only on
the "-c doesn't support =" thing that nobody has actually run across in
practice (and I don't think is something people will run into with
this).

> We do have the "=" key limitation now, but I don't think it's there for
> any key we currently define, except things like "url.<base>.insteadOf"
> if the "<base> has a "=" in it (and maybe just that one).

It's really a potential problem for any 3-level config key. So urls,
branch names, remote names, various tool names, filter/diff drivers,
existing includeIf conditions. This might be the first one where we
really _encourage_ the use of "=" signs, but it still strikes me as
weird that you'd want to do so on the command-line in practice.

-Peff
