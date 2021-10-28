Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1677C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E1260F9C
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhJ1TTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 15:19:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:49090 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhJ1TTk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 15:19:40 -0400
Received: (qmail 17372 invoked by uid 109); 28 Oct 2021 19:17:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Oct 2021 19:17:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7970 invoked by uid 111); 28 Oct 2021 19:17:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Oct 2021 15:17:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Oct 2021 15:17:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: pre-v2.34.0-rc0 regressions: 'git log' has a noisy iconv()
 warning
Message-ID: <YXr3OPU8YWUKp42V@coredump.intra.peff.net>
References: <xmqq5ytkzbt7.fsf@gitster.g>
 <211026.86y26gyqui.gmgdl@evledraar.gmail.com>
 <YXk0hAgaSJbLUgeB@coredump.intra.peff.net>
 <xmqqmtmuwdh9.fsf@gitster.g>
 <YXreMYZrTCUkpHXz@coredump.intra.peff.net>
 <xmqqzgqtq8g0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgqtq8g0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 28, 2021 at 12:02:23PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> I am all for making it convenient to squelch, but it would be sad to
> >> lose the convenient way to notice possible misencoding in recent
> >> commits.  Or can we have a command line option and pass it through
> >> the callchain, or would that be too involved?
> >
> > Do you mean a command-line option to squelch the warnings? I think it
> > would not be too hard to do it as a config option (which is probably
> > what you'd want anyway, since historical commits would come up over and
> > over again).
> 
> Adding a "git -c please.be.verbose.on.encoding.errors=true" is
> sufficient for those who want to diagnose, but that is not very
> discoverable.  Swapping the polarity and making it verbose by
> default, with a knob to squelch, may be more practical from that
> point of view.

Right, it definitely has to be on by default or it will accomplish
nothing. I was just asking about "config versus command-line".

And I suppose that does not really make implementation that much easier
or harder. What makes it easy is if we accept a big global variable and
do not have to pass it down through the call-stack.

-Peff
