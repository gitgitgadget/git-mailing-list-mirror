Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5836320285
	for <e@80x24.org>; Tue, 29 Aug 2017 08:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbdH2IR4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 04:17:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:51610 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750758AbdH2IRz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 04:17:55 -0400
Received: (qmail 4916 invoked by uid 109); 29 Aug 2017 08:17:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 08:17:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7647 invoked by uid 111); 29 Aug 2017 08:18:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 04:18:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Aug 2017 04:17:52 -0400
Date:   Tue, 29 Aug 2017 04:17:52 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/3] merge-recursive: remove return value from
 get_files_dirs
Message-ID: <20170829081752.nq5r776rjyf2amzh@sigill.intra.peff.net>
References: <20170828202829.3056-1-kewillf@microsoft.com>
 <20170828202829.3056-3-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170828202829.3056-3-kewillf@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 28, 2017 at 02:28:28PM -0600, Kevin Willford wrote:

> The return value of the get_files_dirs call is never being used.
> Looking at the history of the file and it was originally only
> being used for debug output statements.  Also when
> read_tree_recursive return value is non zero it is changed to
> zero.  This leads me to believe that it doesn't matter if
> read_tree_recursive gets an error.

Or that the function is buggy. :)

I'm tempted to say that we should probably die() when
read_tree_recursive fails. This should only happen if we fail to parse
the tree, or if our callback (save_files_dirs here) returns failure, and
the latter looks like it never happens.

> Since the debug output has been removed and the caller isn't
> checking the return value there is no reason to keep calulating
> and returning a value.

Agreed, and I'm happy to see dead code go.

Minor nit: s/calulating/calculating/ in your commit message.

-Peff
