Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E599320958
	for <e@80x24.org>; Thu, 23 Mar 2017 19:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754732AbdCWTif (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 15:38:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:50509 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752321AbdCWTie (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 15:38:34 -0400
Received: (qmail 14772 invoked by uid 109); 23 Mar 2017 19:38:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 19:38:25 +0000
Received: (qmail 10043 invoked by uid 111); 23 Mar 2017 19:38:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 15:38:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Mar 2017 15:38:23 -0400
Date:   Thu, 23 Mar 2017 15:38:23 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
Message-ID: <20170323193823.gxodwqv4eshgtqbc@sigill.intra.peff.net>
References: <20170322065612.18797-1-larsxschneider@gmail.com>
 <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703231716320.3767@virtualbox>
 <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net>
 <xmqqbmsrdcz4.fsf@gitster.mtv.corp.google.com>
 <20170323191721.7r5vrixtnx3cngdc@sigill.intra.peff.net>
 <FE4A3F88-0B86-4069-B141-2DFB9C4E269E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <FE4A3F88-0B86-4069-B141-2DFB9C4E269E@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 08:26:15PM +0100, Lars Schneider wrote:

> > I think we do build against PRs now. E.g.:
> > 
> >  https://travis-ci.org/git/git/builds/213896051
> > 
> > But it looks like we can turn that off.
> 
> When we add a secret variable, then TravisCI will not build Pull Requests
> for git/git anymore:
> 
> "[...] we do not provide these values to untrusted builds, 
> triggered by pull requests from another repository."
> 
> See: https://docs.travis-ci.com/user/environment-variables/#Defining-Variables-in-Repository-Settings

Ah, OK, that makes sense. So we would only have to worry about our _own_
code accidentally disclosing it. But that should be easy to look for by
grepping the log (did somebody do that?).

> However, I don't think that is a big deal because git/git doesn't
> support Pull Requests anyways. Plus, if a contributor is interested
> in TravisCI results, then the contributor can setup TravisCI for
> their own fork easily.

Yeah, agreed. It's not like we are blocking the merge button with a
failing status.

> > Hrm, it does mean that people have no way to test on Windows until the
> > branch hits pu. Which is not ideal.
> 
> I agree it's not ideal. But I think it is an improvement to check
> pu/next/master/maint continuously :-)

Oh, I agree this is a step forward from the status quo. I just wondered
if we could do even better.

As a side note, I've started having travis run on all of the topic
branches in peff/git, with the idea to get early feedback on OS X
problems (and now hopefully Windows ones). My two issues so far are:

  - I have a lot of work-in-progress branches. I put "-wip" at the end
    of the branch name for my own scripts. It looks like I can put "[ci
    skip]" in the commit subject to convince Travis to skip them, but
    that's a little annoying. Is there any way to skip based on just the
    branch name? I couldn't find one.

  - The OS X builds seem to regularly time out. That at least marks a
    "!" in the build status screen instead of an "X", but it's a lot of
    noise (and it misses the point for me, which is testing on OS X; I
    already build regularly on Linux).

-Peff
