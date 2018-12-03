Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F131211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 21:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbeLCVbh (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 16:31:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:57672 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725903AbeLCVbh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 16:31:37 -0500
Received: (qmail 3190 invoked by uid 109); 3 Dec 2018 21:31:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Dec 2018 21:31:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14075 invoked by uid 111); 3 Dec 2018 21:31:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 03 Dec 2018 16:31:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2018 16:31:35 -0500
Date:   Mon, 3 Dec 2018 16:31:35 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Paul Morelle <paul.morelle@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] rebase -i: introduce the 'test' command
Message-ID: <20181203213134.GD8700@sigill.intra.peff.net>
References: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com>
 <nycvar.QRO.7.76.6.1811281600240.41@tvgsbejvaqbjf.bet>
 <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com>
 <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet>
 <20181201200209.GC29120@sigill.intra.peff.net>
 <20181203172743.kq5zfbfnvjadeikj@ltop.local>
 <nycvar.QRO.7.76.6.1812031957060.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1812031957060.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 03, 2018 at 08:01:44PM +0100, Johannes Schindelin wrote:

> > In this sort of situation, I often whish to be able to do nested rebases.
> > Even more because it happen relatively often that I forget that I'm
> > working in a rebase and not on the head, and then it's quite natural
> > to me to type things like 'git rebase -i @^^^' while already rebasing.
> > But I suppose this has already been discussed.
> 
> Varieties of this have been discussed, but no, not nested rebases.
> 
> The closest we thought about was re-scheduling the latest <n> commits,
> which is now harder because of the `--rebase-merges` mode.
> 
> But I think it would be doable. Your idea of a "nested" rebase actually
> opens that door quite nicely. It would not *really* be a nested rebase,
> and it would still only be possible in interactive mode, but I could
> totally see
> 
> 	git rebase --nested -i HEAD~3
> 
> to generate and prepend the following lines to the `git-rebase-todo` file:
> 
> 	reset abcdef01 # This is HEAD~3
> 	pick abcdef02 # This is HEAD~2
> 	pick abcdef03 # This is HEAD~
> 	pick abcdef04 # This is HEAD
> 
> (assuming that the latest 3 commits were non-merge commits; It would look
> quite a bit more complicated in other situations.)

Yeah, I would probably use that if it existed.

It would be nicer to have real nested sequencer operations, I think, for
other situations. E.g., cherry-picking a sequence of commits while
you're in the middle of a rebase.

But I suspect getting that right would be _loads_ more work, and
probably would involve some funky UI corner cases to handle the stack of
operations (so truly aborting a rebase may mean an arbitrary number of
"rebase --abort" calls to pop the stack). Your suggestion is probably a
reasonable trick in the meantime.

-Peff
