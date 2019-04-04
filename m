Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E8D220248
	for <e@80x24.org>; Thu,  4 Apr 2019 12:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfDDMOS (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 08:14:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:46636 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727039AbfDDMOS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 08:14:18 -0400
Received: (qmail 26931 invoked by uid 109); 4 Apr 2019 12:14:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 12:14:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16159 invoked by uid 111); 4 Apr 2019 12:14:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Apr 2019 08:14:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2019 08:14:16 -0400
Date:   Thu, 4 Apr 2019 08:14:16 -0400
From:   Jeff King <peff@peff.net>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Junio C Hamano <gitster@pobox.com>,
        Joe Perches <joe@perches.com>, git@vger.kernel.org
Subject: Re: [PATCH] send-email: don't cc *-by lines with '-' prefix
Message-ID: <20190404121416.GC22324@sigill.intra.peff.net>
References: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il>
 <bc20070b-437a-9875-efd0-b4cad1413233@rasmusvillemoes.dk>
 <604795fe60991f22273cbb652eeeedc17985bc65.camel@perches.com>
 <xmqqh8c03dcz.fsf@gitster-ct.c.googlers.com>
 <874l7ekynt.fsf@tarshish>
 <xmqqk1gaf7oe.fsf@gitster-ct.c.googlers.com>
 <87zhp6jf2o.fsf@tarshish>
 <dd8160f8-0e5e-1024-53c1-1a9f23423af5@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd8160f8-0e5e-1024-53c1-1a9f23423af5@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 04, 2019 at 11:42:23AM +0200, Rasmus Villemoes wrote:

> My ack for Baruch's original patch, which AFAICT is identical with
> Junio's suggestion, still stands. FWIW, I'm against Joe's suggestion of
> stopping at a line matching /^---/, since it's not unlikely somebody
> does something like
> 
> ---- dmesg output ----
> bla bla
> ----
> 
> in the commit message.

Keep in mind that on the receiving end, we are going to stop reading the
commit message at a triple-dash, too, which is done as (from
mailinfo.c's patchbreak()):

  /^---( [^\s]|\s*$)/

So it might make sense to use the same rule here. That said:

> Since all lines (except for some of the diff header lines) in the patch
> part begin with space, - or +, insisting on a the line starting with a
> letter should be sufficient for excluding any random Foo-by lines that
> may appear in the patch part.

Yeah, I think this mostly makes it a non-issue, unless we care about
efficiency (and I doubt it is even measurable).

Technically you could have other cruft after the diff, too. But I think
putting "signed-off-by: somebody" in your email sig is a case of "if it
hurts, don't do it".

-Peff
