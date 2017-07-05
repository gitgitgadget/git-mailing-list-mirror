Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31CA202AB
	for <e@80x24.org>; Wed,  5 Jul 2017 08:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbdGEIUl (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 04:20:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:59852 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752378AbdGEIUj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 04:20:39 -0400
Received: (qmail 22559 invoked by uid 109); 5 Jul 2017 08:20:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 08:20:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5836 invoked by uid 111); 5 Jul 2017 08:20:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 04:20:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jul 2017 04:20:27 -0400
Date:   Wed, 5 Jul 2017 04:20:27 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Flurries of 'git reflog expire'
Message-ID: <20170705082027.ujddejajjlvto7bp@sigill.intra.peff.net>
References: <20170704075758.GA22249@inner.h.apk.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170704075758.GA22249@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 04, 2017 at 09:57:58AM +0200, Andreas Krey wrote:

> Questions:
> 
> What can be done about this? Cronjob 'git reflog expire' at midnight,
> so the heuristic don't trigger during the day? (The relnotes don't
> mention anything after 2.4.0, so I suppose a git upgrade won't help.)
> 
> What is the actual cause? Bad heuristics in git itself, or does
> bitbucket run them too often (improbable)?

If it's using --expire-unreachable (which a default "git gc" does), that
means the we have to traverse the entire history to see what is
reachable and what is not. Added on to a normal git-gc, that's usually
not a big deal (it has to do that traversal and much more for the
repack). But if bitbucket is triggering it for other operations, that
could be related (I don't think anything but gc should ever run it
otherwise).

I seem to recall that using --stale-fix is also extremely expensive,
too. What do the command line arguments for the slow commands look like?
And what does the process tree look like?

-Peff
