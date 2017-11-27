Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0897F20A40
	for <e@80x24.org>; Mon, 27 Nov 2017 05:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750838AbdK0FYr (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 00:24:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:41124 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750773AbdK0FYq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 00:24:46 -0500
Received: (qmail 27485 invoked by uid 109); 27 Nov 2017 05:24:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Nov 2017 05:24:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 550 invoked by uid 111); 27 Nov 2017 05:25:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 27 Nov 2017 00:25:03 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Nov 2017 00:24:44 -0500
Date:   Mon, 27 Nov 2017 00:24:44 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
Subject: Re: git status always modifies index?
Message-ID: <20171127052443.GB5946@sigill>
References: <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
 <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
 <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
 <20171122202720.GD11671@aiede.mtv.corp.google.com>
 <20171122211729.GA2854@sigill>
 <20171122215635.GE11671@aiede.mtv.corp.google.com>
 <20171122220627.GE2854@sigill>
 <alpine.DEB.2.21.1.1711252240300.6482@virtualbox>
 <20171126192508.GB1501@sigill>
 <alpine.DEB.2.21.1.1711262231250.6482@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1711262231250.6482@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 26, 2017 at 10:55:01PM +0100, Johannes Schindelin wrote:

> > I remain unconvinced that we have actually uncovered a serious problem.
> 
> You did not. A colleague of mine did. And it was a problem in Git for
> Windows only, caused by the changes necessitated by yours (which even used
> my tests, which made it easy for my conflict resolution to do the wrong
> thing by removing my --no-lock-index test in favor of your
> --no-optional-locks test, breaking --no-lock-index).
> 
> It cost me almost two work days, and a lot of hair. And all I meant by "I
> hinted at it, too" was that I felt that something like that was coming
> when I saw your variation of my patches making it into git/git's master.

I was confused by your mention of a problem, since this was the first I
heard about it. Looking at the GfW repo, I assume you mean the bits
touched by 45538830baf.

If so, then yes, I'm sad that the combination of the features caused
extra work for you. But I also don't think that is a compelling reason
to say that "--no-optional-locks" is the wrong approach.

It _does_ argue for trying to take features intact between the two
codebases. But I am not sure I buy that argument. The original feature
got no review on the list, and in fact most of us weren't even aware of
it until encountering the problem independently. IMHO it argues for GfW
trying to land patches upstream first, and then having them trickle in
as you merge upstream releases.

I suspect you are going to say "but I am busy and don't have time for
that". And I know it takes time. I maintain the fork that GitHub runs on
its servers, and I have a backlog of features to upstream. Some of them
end up quite different when I do that, and it's a huge pain. But
ultimately I've forked the upstream project, and that's the price I pay.
Upstream doesn't care about my fork's problems.

I dunno. Maybe you do not see Git for Windows as such a fork. But
speaking as somebody who works on git.git, that is my perception of it
(that GfW is downstream). So I'm sympathetic, but I don't like the idea
of taking non-Windows-specific patches wholesale and skipping the list
review and design process.

> > Somebody asked if Git could do a thing, and people pointed him to the
> > right option.
> 
> If people have to ask on the mailing list even after reading the man
> pages, that's a strong indicator that we could do better.

Sure. That's why I suggested improving the documentation in my last
email. But in all the discussion, I haven't seen any patch to that
effect.

> In Git, yes. In Git for Windows, no. And it worked beautifully in Git for
> Windows before v2.15.0.

It didn't in git.git, because it wasn't there. ;)

> > But I figured you would carry "status --no-lock-index" forever in Git
> > for Windows anyway (after all, if you remove it now, you're breaking
> > compatibility for existing users).
> 
> I will not carry it forever. Most definitely not. It was marked as
> experimental for a reason: I suspected that major changes would be
> required to get it accepted into git.git (even if I disagree from a purely
> practicial point of view that those changes are required, but that's what
> you have to accept when working in Open Source, that you sometimes have to
> change something solely to please the person who can reject your patches).

Yes, I saw just now that you continue to recognize it and give a
deprecation warning, which seems like quite a reasonable thing to do.

> Sure, I am breaking compatibility for existing users, but that is more the
> fault of --no-optional-locks being introduced than anything else.

Hopefully the text at the start of this mail explains why I disagree on
the "fault" here.

> I am pretty much done talking about this subject at this point. I only
> started talking about it because I wanted you to understand that I will
> insist on my hunches more forcefully in the future, and I hope you will
> see why I do that. But then, you may not even see the problems caused by
> the renaming (and forced broader scope for currently no good reason) of
> --no-lock-index, so maybe you disagree that acting on my hunch would have
> prevented those problems.

Again, maybe the bit above explains my viewpoint a bit more. I'm
certainly sympathetic to the pain of upstreaming.

I do disagree with the "no good reason" for this particular patch.

Certainly you should feel free to present your hunches. I'd expect you
to as part of the review (I'm pretty sure I even solicited your opinion
when I sent the original patch). But I also think it's important for
patches sent upstream to get thorough review (both for code and design).
The patches having been in another fork (and thus presumably being
stable) is one point in their favor, but I don't think it should trumps
all other discussion.

-Peff
