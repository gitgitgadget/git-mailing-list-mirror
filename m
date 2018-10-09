Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5D701F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 03:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbeJIK0D (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 06:26:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:46898 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725783AbeJIK0D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 06:26:03 -0400
Received: (qmail 7699 invoked by uid 109); 9 Oct 2018 03:11:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Oct 2018 03:11:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10424 invoked by uid 111); 9 Oct 2018 03:10:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 08 Oct 2018 23:10:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Oct 2018 23:11:16 -0400
Date:   Mon, 8 Oct 2018 23:11:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v3] coccicheck: process every source file at once
Message-ID: <20181009031116.GC6250@sigill.intra.peff.net>
References: <20181002200710.15721-1-jacob.e.keller@intel.com>
 <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
 <CA+P7+xo=cY2nSHk99CETvba-nZ_jOan5YgpDUjaD=cpTs2ub3A@mail.gmail.com>
 <20181005124048.GT23446@localhost>
 <20181005162517.GB11254@sigill.intra.peff.net>
 <02874ECE860811409154E81DA85FBB5884CCBED2@ORSMSX115.amr.corp.intel.com>
 <20181005165901.GE11254@sigill.intra.peff.net>
 <20181005185050.GW23446@localhost>
 <20181005190045.GA17482@sigill.intra.peff.net>
 <8b51c4c0-df51-7639-07fe-74d6ca3b5944@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b51c4c0-df51-7639-07fe-74d6ca3b5944@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 06, 2018 at 10:42:57AM +0200, René Scharfe wrote:

> > That's OK, too, assuming people would actually want to use it. I'm also
> > OK shipping this (with the "make -j" fix you suggested) and seeing if
> > anybody actually complains. I assume there are only a handful of people
> > running coccicheck in the first place.
> 
> FWIW, my development environment is a virtual machine with 1200MB RAM
> and 900MB swap space.  coccicheck takes almost eight minutes
> sequentially, and four and a half minutes with -j4.
> 
> Unsurprisingly, it fails after almost three minutes with the patch,
> reporting that it ran out of memory.  With 2900MB it fails after almost
> two minutes, with 3000MB it succeeds after a good two minutes.
> 
> time(1) says (for -j1):
> 
> 433.30user 36.17system 7:49.84elapsed 99%CPU (0avgtext+0avgdata 108212maxresident)k
> 192inputs+1512outputs (0major+16409056minor)pagefaults 0swaps
> 
> 129.74user 2.06system 2:13.27elapsed 98%CPU (0avgtext+0avgdata 1884568maxresident)k
> 236896inputs+1096outputs (795major+462129minor)pagefaults 0swaps
> 
> So with the patch it's more than three times faster, but needs more
> than seventeen times more memory.  And I need a bigger VM. :-/

Yuck. :) So if we want to take this as a complaint, then I guess we can
jump straight to implementing the fallback to the existing behavior
(though it may be worth it for you to expand your VM to get the
decreased CPU time).

I'm still puzzled by Gábor's counter-intuitive CI numbers, though.

-Peff
