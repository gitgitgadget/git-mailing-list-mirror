Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37C052082E
	for <e@80x24.org>; Fri, 23 Jun 2017 19:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754748AbdFWTM1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 15:12:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:50940 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754327AbdFWTM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 15:12:26 -0400
Received: (qmail 11281 invoked by uid 109); 23 Jun 2017 19:12:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Jun 2017 19:12:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18037 invoked by uid 111); 23 Jun 2017 19:12:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 15:12:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 15:12:24 -0400
Date:   Fri, 23 Jun 2017 15:12:24 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 17/29] packed_ref_store: support iteration
Message-ID: <20170623191224.s5rkaruv6npbds7q@sigill.intra.peff.net>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
 <4171c4ea8b0280fa2c8cee9f1799933f66894f74.1498200513.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4171c4ea8b0280fa2c8cee9f1799933f66894f74.1498200513.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 09:01:35AM +0200, Michael Haggerty wrote:

> +static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
> +{
> +	struct packed_ref_iterator *iter =
> +		(struct packed_ref_iterator *)ref_iterator;

I thought had some kind of safe downcasting mechanism for iterators, but
I think I was just thinking of files_downcast() for the ref-store.

I don't mind not having that kind of safety. It seems like an uncommon
error to call the packed-ref iterator function on the wrong type,
especially as it's static here and only accessible as a virtual function
for a packed_ref_iterator.

But something to think about, I guess, as we add more polymorphism.

-Peff
