Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CF2C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A345A61073
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhJHUVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 16:21:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:36134 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhJHUVm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 16:21:42 -0400
Received: (qmail 6204 invoked by uid 109); 8 Oct 2021 20:19:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Oct 2021 20:19:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17021 invoked by uid 111); 8 Oct 2021 20:19:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Oct 2021 16:19:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Oct 2021 16:19:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #02; Wed, 6)
Message-ID: <YWCn4tpr9RWsRxvr@coredump.intra.peff.net>
References: <xmqqfstdr8b5.fsf@gitster.g>
 <YV5aaD418SyZqS/1@coredump.intra.peff.net>
 <YV5dmkkuCqAY2qqG@coredump.intra.peff.net>
 <87sfxdgtpu.fsf@evledraar.gmail.com>
 <YV/EnxkTvWWZ6xVD@coredump.intra.peff.net>
 <xmqqsfxbjncz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsfxbjncz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 08, 2021 at 01:03:08PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > They do have some limits posted here:
> >
> >   https://scan.coverity.com/faq#frequency
> >
> > It's on the order of 3 builds per day for a code base of our size. Which
> > is plenty for our integration branches, but not enough to test every
> > topic branch.
> 
> I usually have at least two pushout of 'seen' (one with the full set
> of 'seen' including known-to-be-broken topic integrations, the other
> with seen~$some_hopefully_small_number that I didn't see brekaage in
> my local build), and then on graduation days 'next' and 'master' are
> also updated, so 3 is cutting very close ;-)

Hmm, yeah. They say "21 builds per week", which would be plenty (you
don't push out integrations every day), but I think they may also have a
per-day limit.

I'm not sure what happens when you hit the limit. If it just silently
skips the analysis, that's fine (we'll pick up the changes the next
day). If it causes a CI failure that nags you, that is less good. But
probably something we could work around in the Actions commands.

TBH, though, I think just building "seen" would be sufficient for this
kind of analysis. Most CI is about "make sure we pass the tests and do
not graduate topics if it doesn't". This is much more about "generate a
set of possibly-bogus annotations for some human to look at". Given the
topic branch flow you use, it's pretty unlikely for a problem to
_appear_ in master or next. And even if they do, it will be detected the
next time seen is run.

-Peff
