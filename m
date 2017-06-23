Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B043A20282
	for <e@80x24.org>; Fri, 23 Jun 2017 19:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754867AbdFWT6x (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 15:58:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:51154 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754781AbdFWT6x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 15:58:53 -0400
Received: (qmail 14829 invoked by uid 109); 23 Jun 2017 19:58:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Jun 2017 19:58:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18635 invoked by uid 111); 23 Jun 2017 19:58:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 15:58:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 15:58:46 -0400
Date:   Fri, 23 Jun 2017 15:58:46 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 29/29] read_packed_refs(): die if `packed-refs`
 contains bogus data
Message-ID: <20170623195845.pz7rdyqocjqu5edp@sigill.intra.peff.net>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
 <1e08748aa5a6dc05003b08207a9a4bc344758ca2.1498200513.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e08748aa5a6dc05003b08207a9a4bc344758ca2.1498200513.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 09:01:47AM +0200, Michael Haggerty wrote:

> The old code ignored any lines that it didn't understand. This is
> dangerous. Instead, `die()` if the `packed-refs` file contains any
> lines that we don't know how to handle.

This seems like a big improvement. Is it worth adding a test for a
corrupted file?

I assume this isn't something you saw in the wild, but just a deficiency
you noticed while reading the code.

I suspect this laxness may have been what allowed us to add the optional
peeled values long ago. But I think I'd rather see us be more strict and
notice corruption or nonsense rather than quietly ignoring (especially
because an operation like "git pack-refs" would then overwrite it,
dropping whatever entries we didn't understand).

-Peff
