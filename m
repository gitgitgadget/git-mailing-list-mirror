Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3A001F404
	for <e@80x24.org>; Wed, 20 Dec 2017 16:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754502AbdLTQnR (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 11:43:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:44272 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753538AbdLTQnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 11:43:16 -0500
Received: (qmail 23812 invoked by uid 109); 20 Dec 2017 16:43:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Dec 2017 16:43:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14459 invoked by uid 111); 20 Dec 2017 16:43:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 20 Dec 2017 11:43:41 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Dec 2017 11:43:13 -0500
Date:   Wed, 20 Dec 2017 11:43:13 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/4] Add --no-ahead-behind to status
Message-ID: <20171220164313.GA5582@sigill.intra.peff.net>
References: <20171220144245.39401-1-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171220144245.39401-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 20, 2017 at 02:42:41PM +0000, Jeff Hostetler wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> This patch series adds a "--no-ahead-behind" option to status
> to request that it avoid a possibly expensive ahead/behind
> computation for the current branch.  Instead, it just prints a
> not up to date message in place of the detailed counts.
> 
> This idea was previously discussed in [1].  Working with the
> enormous Windows repository, we found that 20+ seconds was being
> spent in the ahead/behind computation when the current branch was
> 150K commits behind the upstream branch.  (Yes, this happens and
> only took 3 weeks on the reporter's system.)

Overall this looks cleanly done. I raised a few minor points in the
individual patches, but certainly nothing that would be a show-stopper
for the general idea.

> I've only modified "git status" in this patch series.  A similar
> change could be added to "git branch -vv" and "git checkout" to
> avoid delays there too.  I avoided doing it here to keep this
> patch series focused.

I have a feeling that the same user who got annoyed by "git status" is
going to get annoyed by "git checkout" sooner or later. I'm OK with
handling the other commands separately, but I suspect we may want at
least "git checkout" support in the near future.

There is one thing that it's worth thinking about (because it will be
hard to take back later): config option naming. If your repository is so
large that ahead/behind checks are annoying, would you want to be able
to set a single config to tell Git that, rather than one for each
command? If so, then do we want to ditch "status.aheadbehind" in favor
of a more unified name?

-Peff
