Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F23482021B
	for <e@80x24.org>; Tue, 21 Feb 2017 07:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbdBUHIG (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 02:08:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:59118 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751018AbdBUHG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 02:06:57 -0500
Received: (qmail 12648 invoked by uid 109); 21 Feb 2017 07:06:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 07:06:55 +0000
Received: (qmail 2892 invoked by uid 111); 21 Feb 2017 07:06:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 02:06:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Feb 2017 02:06:54 -0500
Date:   Tue, 21 Feb 2017 02:06:54 -0500
From:   Jeff King <peff@peff.net>
To:     Toolforger <toolforger@durchholz.org>
Cc:     git@vger.kernel.org
Subject: Re: url.<base>.insteadOf vs. submodules
Message-ID: <20170221070653.65ho2anbp55uzjeu@sigill.intra.peff.net>
References: <84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org>
 <20170220090115.6kfzwl62opj4q7k7@sigill.intra.peff.net>
 <404d109f-e5a7-85a3-e64c-ab1b21c3045d@durchholz.org>
 <20170220205243.lynnmxouwq7jelld@sigill.intra.peff.net>
 <28fb85d4-89cd-1f32-3063-2f48d8b935be@durchholz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28fb85d4-89cd-1f32-3063-2f48d8b935be@durchholz.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 06:11:51AM +0100, Toolforger wrote:

> > I'm not sure I understand. You have a project policy to use certain
> > URLs. But you, the user, want to override that. Why isn't the
> > user-specific config file the right place to put that?
> 
> Ah right, I mistook ~/ for "project root" instead of "home dir".
> Sorry for the confusion.

Ah, OK, that makes more sense.

> > (I think there _is_ a mismatch, in that the change is specific not just
> > to your user, but to the repo. So you would not want to rewrite other
> > references to the same URL in other repos.
> 
> Indeed, and that's actually a problem.
> 
> The setup I'm aiming for is
>   github -> local bare repo -> local clones with worktrees
> 
> If I place insteadOf rules in ~/.gitconfig, I will be unable to pull from
> github to my local bare repos.
> Mmm... I could try to undo the insteadOf configuration from ~/.gitconfig in
> the local bare repos. Not sure whether I have to redirect from the github
> URL to itself.

Yeah, I think you would probably have to do a redirect-to-self to
override the global one.

At one point we discussed having conditional-config that would kick in
based on path-matching. I think it would be another way to do what you
want, but there's nothing merged.

I think anything involving ~/.gitconfig is basically a hack, though.
What you really want is for submodules to better support your
URL-rewriting case, and that's not an unreasonable thing to want.

We'll see if the submodule folks have any ideas on how to implement
that.

-Peff
