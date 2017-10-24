Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47CA51FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 19:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbdJXTtY (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 15:49:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:34660 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751299AbdJXTtX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 15:49:23 -0400
Received: (qmail 30026 invoked by uid 109); 24 Oct 2017 19:49:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Oct 2017 19:49:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14964 invoked by uid 111); 24 Oct 2017 19:49:29 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Oct 2017 15:49:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Oct 2017 12:49:21 -0700
Date:   Tue, 24 Oct 2017 12:49:21 -0700
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] files_transaction_prepare(): fix handling of ref
 lock failure
Message-ID: <20171024194921.mnrx3sxsd3w3pe3v@sigill.intra.peff.net>
References: <cover.1508856679.git.mhagger@alum.mit.edu>
 <6214107e1232a7fe7ca4b7440733ff496f07e537.1508856679.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6214107e1232a7fe7ca4b7440733ff496f07e537.1508856679.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 05:16:25PM +0200, Michael Haggerty wrote:

> The fix is simple: instead of just breaking out of the loop, jump
> directly to the cleanup code. This fixes some tests in t1404 that were
> added in the previous commit.

Nicely explained.

I think that fix makes sense, and matches how the rest of the function
behaved. The other option would be to switch the recently-added code to:

  if (!ret && packed_transaction)
     ...

but it seems like the "goto" means one less thing for new code to
remember if it gets added.

-Peff
