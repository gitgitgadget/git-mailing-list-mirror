Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 525FF202A5
	for <e@80x24.org>; Wed, 27 Sep 2017 06:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbdI0Gkf (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:40:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:51680 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750854AbdI0Gk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:40:28 -0400
Received: (qmail 26996 invoked by uid 109); 27 Sep 2017 06:40:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 06:40:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12043 invoked by uid 111); 27 Sep 2017 06:41:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 02:41:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 02:40:26 -0400
Date:   Wed, 27 Sep 2017 02:40:26 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] git: add --no-optional-locks option
Message-ID: <20170927064026.5xa3ydaggmknvulw@sigill.intra.peff.net>
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
 <79ed4c34-1727-7c1e-868a-1206902638ad@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79ed4c34-1727-7c1e-868a-1206902638ad@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 24, 2017 at 01:08:41PM +0530, Kaartic Sivaraam wrote:

> On Thursday 21 September 2017 10:02 AM, Jeff King wrote:
> > Some tools like IDEs or fancy editors may periodically run
> > commands like "git status" in the background to keep track
> > of the state of the repository.
> 
> I might be missing something, shouldn't the IDEs be encouraged to use
> libgit2 instead? I thought it was meant for these use cases.

GitHub Desktop, at least, has actually moved _away_ from libgit2. I
think there were a number of reasons. Some match what Dscho said
regarding Visual Studio. But I think a main one is just that libgit2
doesn't quite match regular git for feature parity or pace of
development. So you're stuck shelling out to regular Git half the time
anyway, and now you get to handle dependencies on _two_ systems. :)

> Note: I assume getting the status through libgit2 doesn't create an
> index.lock file.

I don't know if that's the case or not.

> > This patch implements the option 3.
> 
> So, if I get that correctly "git status --no-optional-locks" is a way to get
> the "current" status without updating the on disk index file?

It's actually "git --no-optional-locks status", since it's a git-wide
option (it's just that "status" is the only one who respects it for
now).

> > +`GIT_OPTIONAL_LOCKS`::
> > +	If set to `0`, Git will avoid performing any operations which
> > +	require taking a lock and which are not required to complete the
> > +	requested operation.
> 
> The above sentence seems to be a little confusing. How about,
> 
>    If set to `0`, Git will complete the requested operation without
>    performing the optional sub-operations that require taking a lock.

Yeah, my original is pretty clunky. I ended up with:

  If set to `0`, Git will complete any requested operation without
  performing any optional sub-operations that require taking a lock.

which swaps out "the" for "any".

Thanks.

-Peff
