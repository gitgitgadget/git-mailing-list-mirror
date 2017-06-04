Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 835DC1F7D2
	for <e@80x24.org>; Sun,  4 Jun 2017 08:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751288AbdFDI3X (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 04:29:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:34519 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbdFDI3V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 04:29:21 -0400
Received: (qmail 15538 invoked by uid 109); 4 Jun 2017 08:29:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 04 Jun 2017 08:29:21 +0000
Received: (qmail 7778 invoked by uid 111); 4 Jun 2017 08:30:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 04 Jun 2017 04:30:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Jun 2017 04:29:19 -0400
Date:   Sun, 4 Jun 2017 04:29:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] perf: work around the tested repo having an index.lock
Message-ID: <20170604082919.y5g34udvyjfaqtve@sigill.intra.peff.net>
References: <20170602103330.25663-1-avarab@gmail.com>
 <20170602184506.x2inwswmcwafyvfy@sigill.intra.peff.net>
 <xmqqd1amx80f.fsf@gitster.mtv.corp.google.com>
 <CACBZZX52O9Pf=5Xtq1Lg1=ZU26tm7pupvubk1ZjNJZp7kR450g@mail.gmail.com>
 <xmqqefv0wrj7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqefv0wrj7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 04, 2017 at 09:00:28AM +0900, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> >> My feeling exactly.  Diagnosing and failing upfront saying "well you
> >> made a copy but it is not suitable for testing" sounds more sensible
> >> at lesat to me.
> >
> > This change makes the repo suitable for testing when it wasn't before.
> 
> Perhaps "not suitable" was a bit too vague.
> 
> The copy you made is not in a consistent state that is good for
> testing.  This change may declare that it is now in a consistent
> state, but removal of a single *.lock file does not make it so.  We
> do not know what other transient inconsistency the resulting copy
> has; it is inherent to git-unaware copy---that is why we discouraged
> and removed rsync transport after all.

Right. What I was getting at in my original message was that this is the
tip of the iceberg if we are worried about inconsistent states. And the
right solution is probably to say "you are on your own for making sure
the repo you point to is in a sane state". Because there are so many
cases to catch, and they're so rare, it's not worth trying to catch them
all.

I don't really mind addressing this one case that much. I'm not sure
that we want to accrue a pile of band-aids here that causes a
maintenance burden and doesn't really solve the problem completely. One
way to do that is to say no to the first band-aid. But we could also
apply it and see what happens. At the very worst it's a few extra lines
of code, and we can start to get worried on the second or third
band-aid.

-Peff
