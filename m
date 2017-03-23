Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 960E820958
	for <e@80x24.org>; Thu, 23 Mar 2017 20:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbdCWUU1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 16:20:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:50561 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751448AbdCWUU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 16:20:27 -0400
Received: (qmail 17423 invoked by uid 109); 23 Mar 2017 20:20:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 20:20:05 +0000
Received: (qmail 10777 invoked by uid 111); 23 Mar 2017 20:20:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 16:20:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Mar 2017 16:20:03 -0400
Date:   Thu, 23 Mar 2017 16:20:03 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
Message-ID: <20170323202002.lfpuglqawz4ooruw@sigill.intra.peff.net>
References: <20170322065612.18797-1-larsxschneider@gmail.com>
 <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703231716320.3767@virtualbox>
 <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net>
 <xmqqbmsrdcz4.fsf@gitster.mtv.corp.google.com>
 <20170323191721.7r5vrixtnx3cngdc@sigill.intra.peff.net>
 <FE4A3F88-0B86-4069-B141-2DFB9C4E269E@gmail.com>
 <20170323193823.gxodwqv4eshgtqbc@sigill.intra.peff.net>
 <3CC8E237-86EA-4F35-A03E-15BED5869403@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3CC8E237-86EA-4F35-A03E-15BED5869403@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 09:00:33PM +0100, Lars Schneider wrote:

> > Ah, OK, that makes sense. So we would only have to worry about our _own_
> > code accidentally disclosing it. But that should be easy to look for by
> > grepping the log (did somebody do that?).
> 
> This is how a successful Windows build would look like:
> https://travis-ci.org/larsxschneider/git/jobs/214391822
> 
> Dscho's token is not in the log.

Great, thank you for double-checking.

> >  - I have a lot of work-in-progress branches. I put "-wip" at the end
> >    of the branch name for my own scripts. It looks like I can put "[ci
> >    skip]" in the commit subject to convince Travis to skip them, but
> >    that's a little annoying. Is there any way to skip based on just the
> >    branch name? I couldn't find one.
> 
> We can blacklist these branches with a regex in the travis.yml:
> https://docs.travis-ci.com/user/customizing-the-build#Building-Specific-Branches

I had a feeling it might be something like that. So we would all need to
agree on the convention for WIP branch names. If other people like the
idea, I'm happy to make a patch, but I don't want to impose my own weird
conventions on everyone else.

> Maybe TravisCI throttles your usage somehow as you push a lot of commits?

Could be. Looking at:

  https://travis-ci.org/peff/git/branches

It seems to timeout on over half the branches (in fact, there are only a
few that passed all of the tests). My pattern is particularly spiky from
Travis's perspective, because once a day I rebase everything on top of
master and push them the whole thing in a bunch. So they 75 branches,
all at once. That seems like it would be ripe for throttling (though I
would much rather they just queue the builds and do them one at a time).

> Keep in mind, all the TravisCI compute hours are free... considering
> that I think it is quite OK :-)

I don't blame Travis at all. But if the tool does not produce reliable
results, then I will start to ignore it. And somebody on this thread
(not you) has been complaining repeatedly about developers ignoring CI
results.

-Peff
