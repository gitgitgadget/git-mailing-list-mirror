Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E9961F403
	for <e@80x24.org>; Thu, 14 Jun 2018 18:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755516AbeFNSaX (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 14:30:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:44816 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755514AbeFNSaV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 14:30:21 -0400
Received: (qmail 25560 invoked by uid 109); 14 Jun 2018 18:30:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Jun 2018 18:30:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14375 invoked by uid 111); 14 Jun 2018 18:30:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Jun 2018 14:30:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jun 2018 14:30:19 -0400
Date:   Thu, 14 Jun 2018 14:30:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Brandon Williams <bmwill@google.com>,
        Ben Humphreys <behumphreys@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
Message-ID: <20180614183018.GA1911@sigill.intra.peff.net>
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
 <CAGyf7-FQp4q2vvH1ponQvmVDTu0hiMSK1JKytQZ4O1i0MCnz7g@mail.gmail.com>
 <20180103053516.GB87855@aiede.mtv.corp.google.com>
 <20180608045028.GA17528@sigill.intra.peff.net>
 <xmqqzi009deu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzi009deu.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 09:29:13AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > To be honest, I could easily see an argument that I _should_ be setting
> > GIT_SSH_VARIANT to explain what my wrapper is expecting, even though it
> > happened to work before.
> 
> The way I read that message is that the patch proposed in
> 
>   https://public-inbox.org/git/20180103050730.GA87855@aiede.mtv.corp.google.com
> 
> is "lesser of two evils" in that it is still evil because somebody
> still has to be asked to explicitly set "variant" anyway but the
> changing what 'simple' means in the middle would mean those who did
> not have to set it now have to.  So, you should be setting it, even
> if we adopt the patch, right? ;-)

No, my wrapper _isn't_ simple. It passes most options to openssh, but
just doesn't understand the "-G" probing.  So if the default was
openssh-like instead of "simple", then that would work fine without me
setting anything, just like it did before.

Which I thought was where the discussion ended up, but perhaps I'm
misunderstanding.

> My impression is that regression "fix" does not exist---rather, it
> was a proposal (and it may make a better tradeoff than the status
> quo) to help users of older OpenSSH by inconveniencing users of
> different implementations that do -4/6/p differently from OpenSSH.

Right. That fixes the regression for openssh users, at the cost of not
help people on other implementations automatically. But those people
have to set the flag anyway, since the current behavior is "whoops, we
don't know how to support you, set the flag".

To be clear, I've already fixed my setup, and it wasn't that big a deal.
And I doubt all that many people would be affected either way. My use
case here was literally instrumenting the ssh calls of the git client as
part of a regression test suite. How many git test suites could there
possibly be? :)

So I'm OK if we just leave it as-is. It's mostly that I dug into the
thread and was left with the impression that it was an unfinished
leftover that we meant to do.

> In any case, from where I sit, I am still waiting for this offer
> by Jonathan
> 
> > It's good you caught this flaw in the detection.  Would something like
> > the following make sense?  If so, I can resend with a commit message
> > and tests tomorrow or the day after.
> 
> to be followed up ;-)

Yes, that was the part that left the impression. :)

-Peff
