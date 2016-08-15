Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 313F91F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 12:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbcHOMby (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 08:31:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:55370 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752768AbcHOMbx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 08:31:53 -0400
Received: (qmail 14075 invoked by uid 109); 15 Aug 2016 12:31:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 12:31:52 +0000
Received: (qmail 14096 invoked by uid 111); 15 Aug 2016 12:31:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 08:31:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2016 08:31:50 -0400
Date:	Mon, 15 Aug 2016 08:31:50 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	ryenus <ryenus@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] make rebase respect core.hooksPath if set
Message-ID: <20160815123150.nmgch55wzzcv5oue@sigill.intra.peff.net>
References: <CAKkAvaxWk6SK4EYPaWXHQoVBh9qLgHoEqAh9+dgOrjncsi5QyA@mail.gmail.com>
 <alpine.DEB.2.20.1608151422210.4924@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608151422210.4924@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 02:24:59PM +0200, Johannes Schindelin wrote:

> > when looking for pre-rebase and post-rewrite hooks, git-rebase
> > only looks for hooks dir using `git rev-parse --git-path hooks`,
> > which didn't consider the path overridden by core.hooksPath.
> 
> Would it not be more appropriate to teach --git-path hooks to respect the
> core.hooksPath variable? This would be in line with --git-path objects
> respecting the GIT_OBJECT_DIRECTORY environment variable.

Good idea. I think that logic is all in path.c:adjust_git_path().

And then I suspect the manual handling of git_hooks_path in find_hook()
could go away (because strbuf_git_path would just do the right thing
automatically).

-Peff
