Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDB0120899
	for <e@80x24.org>; Tue, 15 Aug 2017 04:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbdHOExQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 00:53:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:39078 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750924AbdHOExQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 00:53:16 -0400
Received: (qmail 15389 invoked by uid 109); 15 Aug 2017 04:53:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 04:53:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8562 invoked by uid 111); 15 Aug 2017 04:53:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 00:53:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Aug 2017 00:53:14 -0400
Date:   Tue, 15 Aug 2017 00:53:14 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: Re: [PATCH v2] commit: skip discarding the index if there is no
 pre-commit hook
Message-ID: <20170815045313.njpq5wf7iuredhoe@sigill.intra.peff.net>
References: <20170810185416.8224-1-kewillf@microsoft.com>
 <20170814215425.23784-1-kewillf@microsoft.com>
 <20170814221309.tg7wizmvx3gtzfc7@sigill.intra.peff.net>
 <DM2PR21MB004160EA994A445A89BD50F7B78D0@DM2PR21MB0041.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM2PR21MB004160EA994A445A89BD50F7B78D0@DM2PR21MB0041.namprd21.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 04:23:50AM +0000, Kevin Willford wrote:

> > This read_cache_from() should be a noop, right, because it immediately
> > sees istate->initialized is set? So it shouldn't matter that it is not
> > in the conditional with discard_cache(). Though if its only purpose is
> > to re-read the just-discarded contents, perhaps it makes sense to put it
> > there for readability.
> 
> I thought about that and didn't know if there were cases when this would be called
> and the cache has not been loaded.  It didn't look like it since it is only called from 
> cmd_commit and prepare_index is called before it.  Also if in the future this call would
> be made when it had not read the index yet so thought it was safest just to leave
> this as always being called since it is basically a noop if the istate->initialized is set.

Yeah, I agree it might be safer as you have it. And hopefully the
comment above the discard would point anybody in the right direction.

> Also based on this commit
> https://github.com/git/git/commit/2888605c649ccd423232161186d72c0e6c458a48
> it looked like the discard_cache was added independent of the read_cache_from call,
> which made me think that the two were not tied together.

Yeah, I tried to dig in the history and figure it out, but it was not
nearly as clear as I would have liked. :)

-Peff
