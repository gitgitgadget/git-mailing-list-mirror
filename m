Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF800209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 18:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbdFFSjj (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 14:39:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:35509 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751247AbdFFSjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 14:39:16 -0400
Received: (qmail 20904 invoked by uid 109); 6 Jun 2017 18:39:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jun 2017 18:39:16 +0000
Received: (qmail 26662 invoked by uid 111); 6 Jun 2017 18:39:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jun 2017 14:39:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Jun 2017 14:39:15 -0400
Date:   Tue, 6 Jun 2017 14:39:15 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG?] gitlink without .gitmodules no longer fails recursive
 clone
Message-ID: <20170606183914.6iowfhimo5yrvmtf@sigill.intra.peff.net>
References: <20170606035650.oykbz2uc4xkr3cr2@sigill.intra.peff.net>
 <CAGZ79kY-uzardfOvrJufatYgU9bqx4XZMU_GFq5zwc-vtzM-3Q@mail.gmail.com>
 <20170606181024.GA189073@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170606181024.GA189073@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 06, 2017 at 11:10:24AM -0700, Brandon Williams wrote:

> > > This bisects to your bb62e0a99 (clone: teach --recurse-submodules to
> > > optionally take a pathspec, 2017-03-17). That patch just sets
> > > submodule.active by default, so I think the real issue is probably in
> > > a086f921a (submodule: decouple url and submodule interest, 2017-03-17).
> > 
> > It's a feature, not a bug, IMO.
> > 
> > When starting out the journey to improve submodules, one of the major
> > principle was to not interfere with gitlinks too much, as they are used in
> > ways git cannot fathom (cf git-series storing patches in gitlink form).
> > 
> > And building on that: You asked for recursing into *submodules*, not
> > into *gitlinks*. And submodules in the new Git have stronger requirements
> > w.r.t. the gitmodules file. (You have to tell us exactly how you want your
> > submodule to be treated, and we do not want to half-ass guess around
> > the shortcomings of a user not telling us about the submodule)
> 
> Just for some background on the new behavior and how this functionality
> changed: My series changed how 'submodule init' behaved if you have
> 'submodule.active' set.  Once set (like how clone --recurse does now)
> when not provided any path to a submodule, a list of 'active' submodules
> matching the 'submodule.active' pathspec will be initialized.  One of
> the requirements to be 'active' is to have an entry in the .gitmodules
> file so gitlinks without an entry in the .gitmodules file will simply be
> ignored now.

OK, thanks for the explanation. I certainly agree that treating
.gitmodules as the source of truth is consistent and easy to explain.
I'll update my test to handle the new behavior (it's a regression test
for how GitHub Pages handles some broken setups).

-Peff
