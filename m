Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A71920437
	for <e@80x24.org>; Tue, 10 Oct 2017 19:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbdJJThc (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 15:37:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:48832 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751701AbdJJThc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 15:37:32 -0400
Received: (qmail 27626 invoked by uid 109); 10 Oct 2017 19:37:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Oct 2017 19:37:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30138 invoked by uid 111); 10 Oct 2017 19:37:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Oct 2017 15:37:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Oct 2017 15:37:30 -0400
Date:   Tue, 10 Oct 2017 15:37:30 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nazri Ramliy <ayiehere@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What happened to "git status --color=(always|auto|never)"?
Message-ID: <20171010193729.nrx7cgifsmpd4c2e@sigill.intra.peff.net>
References: <CAEY4ZpO2G-kTmuReE5gwKpftFqLfAqdpQwCK4R+qYbogCgGtUA@mail.gmail.com>
 <20171010001619.GL19555@aiede.mtv.corp.google.com>
 <CAEY4ZpPj3=+gL_wBW548qzAuS=aC=qswuPx-4H9DS=X10iJWVw@mail.gmail.com>
 <20171010005942.GO19555@aiede.mtv.corp.google.com>
 <CAEY4ZpMKE6yf2baaJt+x6c_esorFnyWvLZ=_KS1iRs6XbL42hw@mail.gmail.com>
 <20171010102509.e7ucbyon6ka6722l@sigill.intra.peff.net>
 <xmqqfuarp3mt.fsf@gitster.mtv.corp.google.com>
 <20171010130602.ivhsbu2ymnzt7gko@sigill.intra.peff.net>
 <20171010190314.GW19555@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171010190314.GW19555@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2017 at 12:03:14PM -0700, Jonathan Nieder wrote:

> > I do wonder if people would end up seeing some corner cases as
> > regressions, though. Right now "diff-tree" _does_ color the output by
> > default, and it would stop doing so under your scheme. That's the right
> > thing to do by the plumbing/porcelain distinction, but users with
> > scripts that use diff-tree (or other plumbing) to generate user-visible
> > output may unexpectedly lose their color, until the calling script is
> > fixed to add back in a --color option[1].
> 
> I think it's better for the calling script to be fixed to use "git
> diff", since it is producing output for the sake of the user instead
> of for machine parsing.  That way, the script gets the benefit of
> other changes like --decorate automatically.
> 
> So I don't see that as a regression.

I agree that may be the best way for those scripts to do it. But it's
still a regression to them, if their script used to do what they wanted
and now it doesn't.

It may be one we don't want to care about because the script is doing
something we don't want to support. But then, think we are still
deciding whether "color.always" in your ~/.gitconfig is in the same
boat.

> Where I worry is about commands where the line between porcelain and
> plumbing blur, like "git log --format=raw".  I actually still prefer
> the approach where "color.ui=always" becomes impossible to express in
> config and each command takes a --color option.
> 
> If we want to be extra fancy, we could make git take a --color option
> instead of requiring each command to do it.
> 
> To support existing scripts, we could treat "-c color.ui=always" as a
> historical synonym for --color=always, either temporarily or
> indefinitely.  Making it clear that this is only there for historical
> reasons would make it less likely that other options make the same
> mistake in the future.

So that's basically my (2), with the twist that we claim it's only
horrible and inconsistent for historical reasons. :)

Is that the direction we want to go?

-Peff
