Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1D6C202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 15:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752371AbdIVPEm (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 11:04:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:46882 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752020AbdIVPEl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 11:04:41 -0400
Received: (qmail 22803 invoked by uid 109); 22 Sep 2017 15:04:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 15:04:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3338 invoked by uid 111); 22 Sep 2017 15:05:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 11:05:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Sep 2017 11:04:38 -0400
Date:   Fri, 22 Sep 2017 11:04:38 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] git: add --no-optional-locks option
Message-ID: <20170922150438.whslnn4qkamdhewr@sigill.intra.peff.net>
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
 <7a2d895c-df8c-1305-234f-7f8e2b271ec2@kdbg.org>
 <20170922042539.fs37bauiabfqcjx5@sigill.intra.peff.net>
 <dcd542e9-ba92-4dc8-6929-2d0f02bd6307@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcd542e9-ba92-4dc8-6929-2d0f02bd6307@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2017 at 07:22:28AM -0400, Jeff Hostetler wrote:

> > > I don't think we should pass this environment variable to remote
> > > repositories. It should be listed in local_repo_env[] in environment.c.
> > 
> > I'm not sure I agree. This is really about the context in which the
> > command is executing, not anything about the particular repository
> > you're operating on.
> > 
> > For fetch/push operations that touch a remote, I doubt it would matter
> > either way (and anyway, those often cross network boundaries that don't
> > propagate environment variables anyway).
> > 
> > But imagine that "git status" learns to recurse into submodules and run
> > "git status" inside them. Surely we would want the submodule repos to
> > also avoid taking any unnecessary locks?
> > 
> > -Peff
> > 
> 
> https://github.com/git-for-windows/git/commit/ff63b51c22389139a864eb2e565c6cdc5a30f061
> 
> https://github.com/git-for-windows/git/pull/1004/commits/45bad66192352481acbc826f11d90c8928b39a7a
> 
> We should compare this with what we did in Git for Windows last fall.
> I guess those commits didn't get pushed upstream.

Right. I think you missed the initial message in the thread that
explains how this is an expanded version of ff63b51c22. :)

I didn't know about the environment thing in 45bad66192, though[1]. That
makes me even more confident that this is the right approach.

-Peff

[1] Sorry for not doing my homework more carefully on the existing
    solution.  GitHub Desktop ran into the same situation and pointed me
    at ff63b51c22. I extrapolated the rest of it on my own. ;)
