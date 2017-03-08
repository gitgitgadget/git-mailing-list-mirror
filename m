Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C26D202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 18:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753913AbdCHSQn (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 13:16:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:40640 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751600AbdCHSQm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 13:16:42 -0500
Received: (qmail 32208 invoked by uid 109); 8 Mar 2017 16:29:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Mar 2017 16:29:28 +0000
Received: (qmail 13825 invoked by uid 111); 8 Mar 2017 16:29:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Mar 2017 11:29:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Mar 2017 11:29:26 -0500
Date:   Wed, 8 Mar 2017 11:29:26 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/9] Fix the early config
Message-ID: <20170308162926.mcjuterphnctfmrp@sigill.intra.peff.net>
References: <cover.1488506615.git.johannes.schindelin@gmx.de>
 <cover.1488562287.git.johannes.schindelin@gmx.de>
 <20170304073952.drfgy7jacnlm6tum@sigill.intra.peff.net>
 <alpine.DEB.2.20.1703071314180.3767@virtualbox>
 <20170308073035.pt5ysp6bzpozoqps@sigill.intra.peff.net>
 <alpine.DEB.2.20.1703081701100.3767@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1703081701100.3767@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2017 at 05:18:46PM +0100, Johannes Schindelin wrote:

> On Wed, 8 Mar 2017, Jeff King wrote:
> 
> > Another "non-gentle" thing I noticed here while looking at
> > another thread: the repository-format version check uses the config
> > parser, which will die() in certain circumstances. [...]
> 
> Yes, that is part of the reason why I was not eager to add that check to
> discover_git_directory(). The config code is die()-happy.
> 
> This is a much bigger problem, of course, and related to a constant gripe
> of mine: I *always* get the quoting wrong in my aliases. Always. And when
> I want to fix it, `git config -e` simply errors out because of an invalid
> config. Yes, Git, I know, that is the exact reason why I want to edit the
> config in the first place.
> 
> I am certain you will agree that this is a different topic, therefore
> subject to a separate patch series.

I agree that in general it is a separate issue. Technically it could
cause a regression because with your series we are more eager to call
discover_git_directory() even when the command would not otherwise need
to even look at the current git directory.

But I don't think that is the case in practice. Your new function is
only called when we would try to read the config anyway. So it would
only affect cases which were previously so broken they did not properly
read the config (like running a command without RUN_SETUP from a
subdirectory of the working tree, which was _supposed_ to respect the
config but failed to do so).

So yeah, I'm happy to leave it for now.

-Peff
