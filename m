Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4AB71F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 19:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeJFCAt (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 22:00:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:43516 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728044AbeJFCAs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 22:00:48 -0400
Received: (qmail 24143 invoked by uid 109); 5 Oct 2018 19:00:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Oct 2018 19:00:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14888 invoked by uid 111); 5 Oct 2018 19:00:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Oct 2018 15:00:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2018 15:00:45 -0400
Date:   Fri, 5 Oct 2018 15:00:45 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v3] coccicheck: process every source file at once
Message-ID: <20181005190045.GA17482@sigill.intra.peff.net>
References: <20181002200710.15721-1-jacob.e.keller@intel.com>
 <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
 <CA+P7+xo=cY2nSHk99CETvba-nZ_jOan5YgpDUjaD=cpTs2ub3A@mail.gmail.com>
 <20181005124048.GT23446@localhost>
 <20181005162517.GB11254@sigill.intra.peff.net>
 <02874ECE860811409154E81DA85FBB5884CCBED2@ORSMSX115.amr.corp.intel.com>
 <20181005165901.GE11254@sigill.intra.peff.net>
 <20181005185050.GW23446@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181005185050.GW23446@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 08:50:50PM +0200, SZEDER Gábor wrote:

> On Fri, Oct 05, 2018 at 12:59:01PM -0400, Jeff King wrote:
> > On Fri, Oct 05, 2018 at 04:53:35PM +0000, Keller, Jacob E wrote:
> > 
> > > > Are we OK with saying 1.3-1.8GB is necessary to run coccicheck? That
> > > > doesn't feel like an exorbitant request for a developer-only tool these
> > > > days, but I have noticed some people on the list tend to have lousier
> > > > machines than I do. ;)
> > > > 
> > > > -Peff
> > > 
> > > It's probably not worth trying to make this more complicated and scale
> > > up how many files we do at once based on the amount of available
> > > memory on the system...
> > 
> > Yeah, that sounds too complicated. At most I'd give a Makefile knob to
> > say "spatch in batches of $(N)". But I'd prefer to avoid even that
> > complexity if we can.
> 
> But perhaps one more if-else, e.g.:
> 
>   if test -n "$(COCCICHECK_ALL_AT_ONCE)"; then \
>       <all at once from Jacob>
>   else
>       <old for loop>
>   fi
> 
> would be an acceptable compromise?  Dunno.

That's OK, too, assuming people would actually want to use it. I'm also
OK shipping this (with the "make -j" fix you suggested) and seeing if
anybody actually complains. I assume there are only a handful of people
running coccicheck in the first place.

-Peff
