Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9210420A40
	for <e@80x24.org>; Sun, 26 Nov 2017 19:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbdKZTZL (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 14:25:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:40566 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751785AbdKZTZK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 14:25:10 -0500
Received: (qmail 32729 invoked by uid 109); 26 Nov 2017 19:25:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 26 Nov 2017 19:25:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29452 invoked by uid 111); 26 Nov 2017 19:25:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 26 Nov 2017 14:25:27 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Nov 2017 14:25:08 -0500
Date:   Sun, 26 Nov 2017 14:25:08 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
Subject: Re: git status always modifies index?
Message-ID: <20171126192508.GB1501@sigill>
References: <a039d139-dba5-683e-afbf-4044cd32ab1d@neulinger.org>
 <20171122153028.olssotkcf3dd6ron@LykOS.localdomain>
 <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
 <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
 <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
 <20171122202720.GD11671@aiede.mtv.corp.google.com>
 <20171122211729.GA2854@sigill>
 <20171122215635.GE11671@aiede.mtv.corp.google.com>
 <20171122220627.GE2854@sigill>
 <alpine.DEB.2.21.1.1711252240300.6482@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1711252240300.6482@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 25, 2017 at 10:55:25PM +0100, Johannes Schindelin wrote:

> > Right, I went a little off track of your original point.
> > 
> > What I was trying to get at is that naming it "status --no-lock-index"
> > would not be the same thing (even though with the current implementation
> > it would behave the same). IOW, can we improve the documentation of
> > "status" to point to make it easier to discover this use case.
> 
> I had the hunch that renaming the option (and moving it away from `git
> status`, even if it is currently only affecting `git status` and even if
> it will most likely be desirable to have the option to really only prevent
> `git status` from writing .lock files) was an unfortunate decision (and
> made my life as Git for Windows quite a bit harder than really necessary,
> it cost me over one workday of a bug hunt, mainly due to a false flag
> indicating `git rebase` to be the culprit). And I hinted at it, too.

I remain unconvinced that we have actually uncovered a serious problem.
Somebody asked if Git could do a thing, and people pointed him to the
right option. That option is new in the latest release. So it is
entirely plausible to me that the new option is just fine and:

  1. We could adjust the documentation to cross-reference from
     git-status.

  2. Now that the new option exists, informal documentation will start
     to mention it. Including this thread in the mailing list archive,
     and the stack overflow thread that was linked.

> I really never understood why --no-optional-locks had to be introduced
> when it did exactly the same as --no-lock-index, and when the latter has a
> right to exist in the first place, even in the purely hypothetical case
> that we teach --no-optional-locks to handle more cases than just `git
> status`' writing of the index (and in essence, it looks like premature
> optimization): it is a very concrete use case that a user may want `git
> status` to refrain from even trying to write any file, as this thread
> shows very eloquently.

Besides potentially handling more than just "git status", it differs in
one other way: it can be triggered via and is carried through the
environment.

> Maybe it is time to reintroduce --no-lock-index, and make
> --no-optional-locks' functionality a true superset of --no-lock-index'.

I'm not against having a separate option for "never write to the
repository". I think it's potentially different than "don't lock", as I
mentioned earlier. Frankly I don't see much value in "--no-lock-index"
if we already have "--no-optional-locks". But I figured you would carry
"status --no-lock-index" forever in Git for Windows anyway (after all,
if you remove it now, you're breaking compatibility for existing users).

-Peff
