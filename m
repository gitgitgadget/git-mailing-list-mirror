Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B564D20A40
	for <e@80x24.org>; Sun, 26 Nov 2017 19:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbdKZT1v (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 14:27:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:40586 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751453AbdKZT1v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 14:27:51 -0500
Received: (qmail 415 invoked by uid 109); 26 Nov 2017 19:27:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 26 Nov 2017 19:27:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29473 invoked by uid 111); 26 Nov 2017 19:28:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 26 Nov 2017 14:28:08 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Nov 2017 14:27:49 -0500
Date:   Sun, 26 Nov 2017 14:27:49 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git status always modifies index?
Message-ID: <20171126192749.GC1501@sigill>
References: <a039d139-dba5-683e-afbf-4044cd32ab1d@neulinger.org>
 <20171122153028.olssotkcf3dd6ron@LykOS.localdomain>
 <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
 <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
 <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
 <20171122202720.GD11671@aiede.mtv.corp.google.com>
 <20171122211729.GA2854@sigill>
 <20171122215635.GE11671@aiede.mtv.corp.google.com>
 <20171122220627.GE2854@sigill>
 <xmqqwp2diuki.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwp2diuki.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 26, 2017 at 12:32:13PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > What I was trying to get at is that naming it "status --no-lock-index"
> > would not be the same thing (even though with the current implementation
> > it would behave the same). IOW, can we improve the documentation of
> > "status" to point to make it easier to discover this use case.
> 
> Yeah, the name is unfortunate. 
> 
> What the end user really wants to see, I suspect, is a "--read-only"
> option that applies to any filesystem entity and to any command, in
> the context of this thread, and also in the original discussion that
> led to the introduction of that option.

I'm not sure I agree. Lockless writes are actually fine for the original
use case of --no-optional-locks (which is a process for the same user
that just happens to run in the background). I can buy the distinction
between that and "--read-only" as premature optimization, though, since
it's not common for most operations to do non-locking writes (pretty
much object writes are the only thing, and most "semantically read-only"
operations like status or diff do not write any objects).

So there's very little lost by people in the first boat saying
"--read-only".

-Peff
