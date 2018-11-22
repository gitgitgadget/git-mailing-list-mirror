Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D6231F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 16:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389322AbeKWDX3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 22:23:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:48708 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728450AbeKWDX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 22:23:28 -0500
Received: (qmail 24467 invoked by uid 109); 22 Nov 2018 16:43:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Nov 2018 16:43:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23516 invoked by uid 111); 22 Nov 2018 16:42:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Nov 2018 11:42:43 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2018 11:43:18 -0500
Date:   Thu, 22 Nov 2018 11:43:18 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/3] delta-island fixes
Message-ID: <20181122164318.GG28192@sigill.intra.peff.net>
References: <20181120094451.GA21725@sigill.intra.peff.net>
 <778f1fcb-8988-de42-8264-d4394ede8540@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <778f1fcb-8988-de42-8264-d4394ede8540@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 10:06:57AM -0500, Derrick Stolee wrote:

> On 11/20/2018 4:44 AM, Jeff King wrote:
> > In cases like this I think it's often a good idea to have a perf test.
> > Those are expensive anyway, and we'd have the double benefit of
> > exercising the code and showing off the performance improvement. But the
> > delta-island code only makes sense on a very specialized repo: one where
> > you have multiple related but diverging histories.  You could simulate
> > that by picking two branches in a repository, but the effect is going to
> > be miniscule.
> 
> The changes in this series look correct. Too bad it is difficult to test.
> 
> Perhaps we should add a performance test for the --delta-islands check that
> would trigger the failure (and maybe a clone afterwards). There are lots of
> freely available forks of git.git that present interesting fork structure.
> Here are three that would suffice to make this interesting:
> 
>     https://github.com/git/git
>     https://github.com/git-for-windows/git
>     https://github.com/microsoft/git
> 
> Of course, running it on a specific repo is up to the person running the
> perf suite.

I hadn't really considered the possibility of reconstructing a fork
network repository from public repos. It probably would be possible to
include a script which does so, although:

  - I suspect it's going to be pretty expensive. We can use --reference
    to reduce the size of subsequent clones, but just the repacks you
    have to do to assemble the final shared repo can get pretty
    expensive.

  - That's 3 forks. Our real-world case has over 4000. I'm not sure of
    the size of the effects for smaller cases.

So in short, I think it's an interesting avenue to explore, but it might
turn out to be a dead-end. I'm not going to prioritize it right now, but
if somebody wants to play with it, I'd be happy to look over the
results.

-Peff
