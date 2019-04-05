Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 610E720248
	for <e@80x24.org>; Fri,  5 Apr 2019 22:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfDEWVD (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 18:21:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:49272 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725973AbfDEWVC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 18:21:02 -0400
Received: (qmail 19712 invoked by uid 109); 5 Apr 2019 22:21:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 22:21:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30726 invoked by uid 111); 5 Apr 2019 22:21:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 18:21:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 18:21:00 -0400
Date:   Fri, 5 Apr 2019 18:21:00 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git <git@vger.kernel.org>
Subject: Re: Feature request: Add --no-edit to git tag command
Message-ID: <20190405222100.GA10787@sigill.intra.peff.net>
References: <CAHd499BM6M+=zRE1WFVXr7b+VhJHFeDind5xLqXcwZLv7QeDvw@mail.gmail.com>
 <20190404015744.GF4409@sigill.intra.peff.net>
 <20190404032606.GA39148@Taylors-MBP.hsd1.wa.comcast.net>
 <20190404120613.GB22324@sigill.intra.peff.net>
 <CAHd499CUCoShsQHYZotFqprfDUf_owg_Urbt29fkNRV6LhFc3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499CUCoShsQHYZotFqprfDUf_owg_Urbt29fkNRV6LhFc3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 04, 2019 at 08:56:16AM -0500, Robert Dailey wrote:

> > I was thinking it was just the --no-edit fix. :) Even with the "--amend"
> > thing, though, it's probably a little light for a 3-month-long GSoC
> > project. :)
> 
> I apologize for the confusion. I'm not fully aware of any per-option
> philosophies in Git, so I may be unaware of the misunderstanding my
> request is causing. Let me attempt to clarify.

I think most of the confusion was just bad reading on my part. :)

> My goal as a user is to correct a tag. If I point a tag at the wrong
> commit, I simply want to move that tag to point to another commit. At
> the moment, the only way I know to do this is the -f option, which I
> just treat as a "move" for the tag. I realize that may not be its
> intent in the implementation, but from a user perspective that's the
> end result I get.
> 
> So if I treat -f as a "move this tag", I also want to say "reuse the
> existing commit message". So again, in my mind, that means -f
> --no-edit. Which means "I'm moving this tag and I want to keep the
> previous commit message".
> 
> I hope this makes more sense. If getting this means not using -f or
> --no-edit at all, and is instead a whole different set of options, I'm
> OK with that as long as the end result is achievable. It's impossible
> to write a script to "move" (-f) a bunch of annotated tags without an
> editor prompting me on each one. So this "--no-edit" addition would
> assist in automation, and also making sure that we simply want to
> correct a tag, but not alter the message.

Yeah, I think what you want to do is perfectly reasonable. The only
reason not to use "-f" is because it already means other things, and we
don't want to overload it.  Calling it "--amend" would make perfect
sense (and then fixing "--no-edit" so it lets you avoid opening the
editor). So I think there are two bits of work:

  1. Add an "--amend" option, which allows overwriting an existing tag
     and pre-populates the message with the existing tag's message.

  2. Make --no-edit work like the patch I showed earlier (assuming that
     your --amend still opens an editor by default).

-Peff
