Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623FF1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 16:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbdFSQGA (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 12:06:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:44552 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750941AbdFSQF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 12:05:59 -0400
Received: (qmail 10154 invoked by uid 109); 19 Jun 2017 16:00:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Jun 2017 16:00:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28974 invoked by uid 111); 19 Jun 2017 16:05:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Jun 2017 12:05:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Jun 2017 12:05:51 -0400
Date:   Mon, 19 Jun 2017 12:05:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98yvind?= Holm <sunny@sunbase.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix a refname trimming problem in `log --bisect`
Message-ID: <20170619160551.cdw3eslu7ehiivh2@sigill.intra.peff.net>
References: <cover.1497792827.git.mhagger@alum.mit.edu>
 <20170619091654.vb7krwcmw2y22v7m@sigill.intra.peff.net>
 <xmqqo9tkt1qz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9tkt1qz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 08:51:00AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Sun, Jun 18, 2017 at 03:39:40PM +0200, Michael Haggerty wrote:
> >
> >> As before, the second patch is optional. If it is omitted, it might
> >> flush out any other bugs like this one in client code. If it is
> >> included, regressions are less likely, but we won't learn about other
> >> misuses of the API. I have no strong opinion either way.
> >
> > My feeling is still slightly towards "don't include", but I also don't
> > have a strong opinion.
> 
> I am inclined to the "don't include 2/2 and cook 1/2 alone but a bit
> longer" approach.

I don't think it helps to cook 1/2 longer. The assertion that triggered
is already in master. Patch 1 fixes one case in an obviously-correct
way. Patch 2 is just about guessing whether _other_ cases may trigger.

So if we wanted to cook longer we'd have to revert b9c8e7f2f
(prefix_ref_iterator: don't trim too much, 2017-05-22), but I don't
think that's worth doing.

-Peff
