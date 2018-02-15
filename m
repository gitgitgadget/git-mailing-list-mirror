Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD21D1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 22:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164431AbeBOWSk (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 17:18:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:54540 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1164322AbeBOWSk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 17:18:40 -0500
Received: (qmail 18787 invoked by uid 109); 15 Feb 2018 22:18:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Feb 2018 22:18:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14897 invoked by uid 111); 15 Feb 2018 22:19:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Feb 2018 17:19:24 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Feb 2018 17:18:37 -0500
Date:   Thu, 15 Feb 2018 17:18:37 -0500
From:   Jeff King <peff@peff.net>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] grep: avoid one strdup() per file
Message-ID: <20180215221837.GC23970@sigill.intra.peff.net>
References: <20180215215615.21208-1-rv@rasmusvillemoes.dk>
 <20180215215615.21208-4-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180215215615.21208-4-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 15, 2018 at 10:56:15PM +0100, Rasmus Villemoes wrote:

> There is only one instance of grep_source_init(GREP_SOURCE_FILE), and in
> that case the path and identifier arguments are equal - not just as
> strings, but the same pointer is passed. So we can save some time and
> memory by reusing the gs->path = xstrdup_or_null(path) we have already
> done as gs->identifier, and changing grep_source_clear accordingly
> to avoid a double free.

IMHO this special case is not really worth it, unless we can show that
those few bytes saved somehow make a measurable difference in either
peak memory or execution speed.

-Peff
