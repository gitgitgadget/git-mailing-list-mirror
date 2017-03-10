Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA761FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 18:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755386AbdCJSM0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 13:12:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:42103 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755050AbdCJSMY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 13:12:24 -0500
Received: (qmail 23190 invoked by uid 109); 10 Mar 2017 18:12:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 18:12:22 +0000
Received: (qmail 16533 invoked by uid 111); 10 Mar 2017 18:12:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 13:12:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Mar 2017 13:12:20 -0500
Date:   Fri, 10 Mar 2017 13:12:20 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Makefile: detect errors in running spatch
Message-ID: <20170310181220.mmbjsmhihkd5rajl@sigill.intra.peff.net>
References: <20170310083117.cbflqx7zbe4s7cqv@sigill.intra.peff.net>
 <1fd87646-76fb-e67c-e61a-c0ccca20cf0a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fd87646-76fb-e67c-e61a-c0ccca20cf0a@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 06:03:47PM +0100, René Scharfe wrote:

> > This shell code is getting a bit unwieldy to stick inside the Makefile,
> > with all the line continuation and $-escaping.  It might be worth moving
> > it into a helper script.
> 
> There is one for the kernel (https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/scripts/coccicheck).
> It's quite big, though.

Yeah, there's a lot going on there that I don't think we care about
(though I am new to coccinelle, so maybe I would grow to appreciate the
features).

I was thinking of just moving the current Makefile snippet into a
script. That lets us avoid the irritating quoting. And we can use things
like functions, which would make the $?-handling in the loop less
tedious (because we can return straight out of the loop).

> > I don't know if that would make the patches harder to apply. The results
> > aren't full patches, so I assume you usually do some kind of munging on
> > them?
> 
> They work with patch -p0.

Hrm, you're right. I tried it earlier based on the commit message from
the original "coccicheck" commit, but I got "only garbage was found".
But now it works. I must have screwed it up (perhaps tab-completion
stopped at "copy.cocci" instead of "copy.cocci.patch").

> >   make coccicheck SPATCH='spatch --in-place'
> 
> Using SPATCH_FLAGS for adding an option in such case would be a bit simpler.

That too. :)

> We can get rid of the loop by using the spatch options --use-gitgrep and
> --dir.  I can't find the former one in the docs, though, so I'm not sure if
> it only works with certain versions or what exactly it is even doing.  It
> seems to have the side effect of producing git-style patches (applicable
> with patch -p1) at least.

I have no objections to pursuing that. But I think with my patch, it's
workable for now, so there's no rush.

-Peff
