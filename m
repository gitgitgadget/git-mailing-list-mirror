Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB8961F453
	for <e@80x24.org>; Fri, 28 Sep 2018 01:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeI1H0V (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 03:26:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:34588 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726060AbeI1H0V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 03:26:21 -0400
Received: (qmail 21994 invoked by uid 109); 28 Sep 2018 01:05:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Sep 2018 01:05:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8382 invoked by uid 111); 28 Sep 2018 01:04:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Sep 2018 21:04:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2018 21:05:14 -0400
Date:   Thu, 27 Sep 2018 21:05:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>,
        Nickolai Belakovski <nbelakovski@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] branch: colorize branches checked out in a linked
 working tree the same way as the current branch is colorized
Message-ID: <20180928010514.GB11281@sigill.intra.peff.net>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20180927181708.GA2468@sigill.intra.peff.net>
 <20180927192804.GA27163@rigel>
 <20180927193559.GB6950@sigill.intra.peff.net>
 <20180927194150.GA7452@sigill.intra.peff.net>
 <xmqqo9cifxee.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9cifxee.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 02:22:49PM -0700, Junio C Hamano wrote:

> The only comment I have is that I strongly suspect we will regret if
> we used an overly bland "worktree" to a rather narrrow "is this ref
> checked out in any worktree?" when we notice we want to learn other
> things that are related to "worktree".  Other than that, very nicely
> done.

Yeah, I should have mentioned that. %(worktree) was just a placeholder.
Perhaps something like %(worktree-HEAD) would make more sense (the idea
is that it is an extension of the existing %(HEAD) placeholder).

Alternatively, %(HEAD) could return "*" or "+" depending on whether it's
the current worktree head. That would mildly break an existing format
like:

  %(if)%(HEAD)%(then) *%(color:green)%(end)%(refname)

since it would start coloring worktree HEADs the same way. It would be
rewritten as:

  %(if:equals=*)%(HEAD)%(then)...real HEAD...
  %(else)%(if:equals=+)%(HEAD)%(then)...worktree HEAD...
  %(else)...regular ref...
  %(end)%(end)

I think that's perhaps nicer, but I'm not sure we want even such a minor
regression.

-Peff
