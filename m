Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A203201A7
	for <e@80x24.org>; Wed, 17 May 2017 13:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754199AbdEQM7w (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:59:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:53588 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754163AbdEQM7v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 08:59:51 -0400
Received: (qmail 3754 invoked by uid 109); 17 May 2017 12:59:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 12:59:50 +0000
Received: (qmail 9214 invoked by uid 111); 17 May 2017 13:00:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 09:00:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 May 2017 08:59:48 -0400
Date:   Wed, 17 May 2017 08:59:48 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 05/23] refs_ref_iterator_begin(): don't check prefixes
 redundantly
Message-ID: <20170517125947.npk4x65e2wqwqvkh@sigill.intra.peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <c9e1d561825a63630a09a2815b9b296c9e4bd1f5.1495014840.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9e1d561825a63630a09a2815b9b296c9e4bd1f5.1495014840.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 02:05:28PM +0200, Michael Haggerty wrote:

> The backend already takes care of the prefix. By passing the prefix
> again to `prefix_ref_iterator`, we were forcing that iterator to do
> redundant prefix comparisons. So set it to the empty string.

Hmm. So givne a refname like "refs/heads/foo" and a prefix like
"refs/heads/", would we trim down to "foo" and then further try to
remove "refs/heads" again?

That sounds like it's not just redundant, but a bug (albeit one that is
very unlikely to come up, unless you have "refs/heads/refs/heads/foo").

Or am I misunderstanding?

-Peff
