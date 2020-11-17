Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E56C63798
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 01:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F5624695
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 01:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgKQBtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 20:49:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:59938 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgKQBtj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 20:49:39 -0500
Received: (qmail 13150 invoked by uid 109); 17 Nov 2020 01:49:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Nov 2020 01:49:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21345 invoked by uid 111); 17 Nov 2020 01:49:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Nov 2020 20:49:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Nov 2020 20:49:37 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 00/11] Fix color handling in git add -i
Message-ID: <20201117014937.GB19433@coredump.intra.peff.net>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
 <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
 <20201111184527.GD9902@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2011121504110.18437@tvgsbejvaqbjf.bet>
 <20201112184026.GB701197@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2011160036100.18437@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2011160036100.18437@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 16, 2020 at 12:40:32AM +0100, Johannes Schindelin wrote:

> > All of which is to say that the current state is a bit of a mess, and I
> > don't consider it completely necessary to fix it before the builtin
> > version becomes the default. But:
> >
> >   - I think we should expect some possible complaints / bug reports
> >     from fringe users of the already-somewhat-broken state
> >
> >   - IMHO the parsing of the filtered version done by the builtin is
> >     going in the wrong direction (see my other mail for an elaboration)
> 
> It's a little bit of a surprise that this is the first time I hear about
> this.

Well, it is the first time I am finding out about it, too. ;)

> The way _I_ would go about fixing this is to look for a tell-tale that
> we're looking at a `diff-so-fancy` style output, e.g. by looking for that
> horizontal line, then adding special code to handle that.

IMHO that's the wrong direction. My intent with the feature was to give
filters as much flexibility as possible, and beyond having 1-to-1
correspondence of lines, we don't know or care what they produce. We
don't even know what other filters might exist out there (though I would
be surprised if there is anything more exotic than intra-line coloring;
other folks have pointed to "delta" for this use, but only in its
color-only mode).

If anybody wants to put work into it, I think a better direction is
having Git keep its own colored hunks and just present single-hunks to a
custom display command to show to the user. Then we can continue not to
care about the format of the individual filters, _and_ they can get the
opportunity to format our rewritten split-hunk headers, etc.

> But given that it does not work right now, and given that it has not been
> working for a long time, I think it does not hurt so much if it is left in
> the current state for a bit longer. I would love to focus on the patch
> series that kicked off this discussion first, getting it done, before I
> think about other `add -p` aspects.

Yeah, absolutely.

-Peff
