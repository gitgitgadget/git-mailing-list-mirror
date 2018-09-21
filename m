Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09C2B1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbeIVEJZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 00:09:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:55570 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725814AbeIVEJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 00:09:25 -0400
Received: (qmail 5101 invoked by uid 109); 21 Sep 2018 22:18:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Sep 2018 22:18:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9190 invoked by uid 111); 21 Sep 2018 22:18:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 21 Sep 2018 18:18:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2018 18:18:32 -0400
Date:   Fri, 21 Sep 2018 18:18:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 3/3] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20180921221832.GC11177@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
 <6e8f65a16dc0be84234d2be93bb4a5c9a585dd57.1537555544.git.me@ttaylorr.com>
 <xmqqbm8qv9hy.fsf@gitster-ct.c.googlers.com>
 <20180921213753.GA11177@sigill.intra.peff.net>
 <xmqqtvmitsi4.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtvmitsi4.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 03:06:43PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > There's no extension necessary; these should already affect upload-pack
> > as well. I agree transport.* would cover both upload-pack and
> > receive-pack. If we extend it to check_everything_connected(), would it
> > make sense as part of transport.*, too?
> >
> > I dunno. I guess I could see an argument either way.
> 
> Sorry but I do not quite follow.  Are you saying that something that
> covers check-everything-connected would the result be too wide to
> fit inside transport.*?  or something that does not cover
> check-everything-connected falls short of transport.*?  Or something
> else?  Either way, core.* is way too wide for what this hook does, I
> would think.

I was suggesting that check_everything_connected() is not strictly
transport-related, so would be inappropriate for transport.*, and we'd
need a more generic name. And my "either way" was that I could see
an argument that it _is_ transport related, since we only call it now
when receiving a pack. But that doesn't have to be the case, and
certainly implementing it with "rev-list --alternate-refs" muddies that
considerably.

I agree that core.* is kind of a kitchen sink, but I'm not sure that's
all that bad. Is "here is how Git finds refs in an alternate" any more
or less core than "here is how Git invokes ssh"?

-Peff
