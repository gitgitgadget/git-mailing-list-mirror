Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE40F1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 22:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeJCFXS (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 01:23:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:39228 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726666AbeJCFXS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 01:23:18 -0400
Received: (qmail 19844 invoked by uid 109); 2 Oct 2018 22:37:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Oct 2018 22:37:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7625 invoked by uid 111); 2 Oct 2018 22:37:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Oct 2018 18:37:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2018 18:37:38 -0400
Date:   Tue, 2 Oct 2018 18:37:38 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] commit-graph: clean up leaked memory during write
Message-ID: <20181002223738.GB5588@sigill.intra.peff.net>
References: <pull.42.git.gitgitgadget@gmail.com>
 <6906c25415eddf79cc3f71f905a77b140f2f66f0.1538492321.git.gitgitgadget@gmail.com>
 <CAN0heSomOen+mWg1CuPGUCJFgmDQUjGLtAdxpWLwrStRU4Me8g@mail.gmail.com>
 <CAGZ79kYtNnNPMv0=rB4ie=tOoYEPPZ=CmYFg4PG2_j96vjODeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYtNnNPMv0=rB4ie=tOoYEPPZ=CmYFg4PG2_j96vjODeQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 02, 2018 at 10:59:28AM -0700, Stefan Beller wrote:

> > Generally speaking, it
> > seems impossible to UNLEAK when dying, since we don't know what we have
> > allocated higher up in the call-stack.
> 
> I do not understand; I thought UNLEAK was specifically for the purpose of
> die() calls without imposing extra overhead; rereading 0e5bba53af
> (add UNLEAK annotation for reducing leak false positives, 2017-09-08)
> doesn't provide an example for prematurely die()ing, only for regular
> program exit.

I responded elsewhere, but as the author of UNLEAK, let me comment here:
it was intended only for program exit. That's why there are no such
examples. :)

If you're using it anywhere except the return from a cmd_* function, or
a static-local helper that's called from a cmd_*, you should probably
actually be freeing the memory.

-Peff
