Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63E7820365
	for <e@80x24.org>; Tue,  3 Oct 2017 07:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750846AbdJCHQZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 03:16:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:58724 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750787AbdJCHQY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 03:16:24 -0400
Received: (qmail 11324 invoked by uid 109); 3 Oct 2017 07:16:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 07:16:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5683 invoked by uid 111); 3 Oct 2017 07:16:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 03:16:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 03:16:22 -0400
Date:   Tue, 3 Oct 2017 03:16:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
Message-ID: <20171003071622.el6zqibfyrjc2mra@sigill.intra.peff.net>
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
 <20171002230017.GT19555@aiede.mtv.corp.google.com>
 <xmqqpoa5kp0c.fsf@gitster.mtv.corp.google.com>
 <xmqqinfxklw7.fsf@gitster.mtv.corp.google.com>
 <20171003061515.72l35fpvcf63vsf6@sigill.intra.peff.net>
 <xmqqinfwiu5n.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqinfwiu5n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 04:10:12PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'd prefer not to revert. I think setting any of the color config to
> > "always" in an on-disk file is basically a broken config. It was
> > exacerbated by 4c7f1819b, but it was already broken for scripts that
> > call "git log" or "git diff", or even just something as simple as piping
> > those programs on the command line.
> 
> I actually disagree with that reasoning.
> 
> We've promised that plumbing commands were safe to use in scripts,
> and 4c7f1819 ("make color.ui default to 'auto'", 2013-06-10) got it
> closer to breaking it (but not quite), and 136c8c8b finally broke
> it.  Setting ui.color=always and shooting themselves in the foot by
> seeing ANSI escapes in "git log >file" output is totally user's
> choice.  Breaking scripts that carefully chose to use plumbing,
> believing our earlier promise, and blaming user's ui.color=always
> does not sound quite like the same thing, at least to me.

I agree it's not quite the same thing, and I agree the problem was made
much worse by 4c7f1819b.  But I still think color.ui=always is
inherently a foot-gun, and in either case it is the user that sets it
that is harmed (and they are the ones who have the power to fix it).

At any rate, I think you only need to agree with that reason to buy into
my "do nothing" option.

Option 2 would make everybody happy, I think (I'm working up a patch,
though note that it isn't quite trivial because of some abuses of the
color system in the test scripts).

-Peff
