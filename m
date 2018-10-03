Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74E771F453
	for <e@80x24.org>; Wed,  3 Oct 2018 02:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeJCJLY (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 05:11:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:39412 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726304AbeJCJLX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 05:11:23 -0400
Received: (qmail 28931 invoked by uid 109); 3 Oct 2018 02:25:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Oct 2018 02:25:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8763 invoked by uid 111); 3 Oct 2018 02:24:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Oct 2018 22:24:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2018 22:25:03 -0400
Date:   Tue, 2 Oct 2018 22:25:03 -0400
From:   Jeff King <peff@peff.net>
To:     Paul Wratt <paul.wratt@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: wrong output on fail
Message-ID: <20181003022502.GD20553@sigill.intra.peff.net>
References: <CA+zYZ3-CS1ZP_LXdWPMVoOvcU+4QimJH2A0WgQ2yT5dFkO5F3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+zYZ3-CS1ZP_LXdWPMVoOvcU+4QimJH2A0WgQ2yT5dFkO5F3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 03:30:21PM +1200, Paul Wratt wrote:

> --------------
> ...
> Total 21 (delta 8), reused 0 (delta 0)
> error: RPC failed; result=56, HTTP code = 0
> fatal: The remote end hung up unexpectedly
> fatal: The remote end hung up unexpectedly
> Everything up-to-date
> --------------
> 
> I am getting the above from "git push".
> 
> I am having intermittent HTTPS connection failures with my ISP
> (Vodafone NZ, mobile), although HTTP works fine. It may even be a
> peering issue.
> 
> The failures above are accounted for, but that last line is definitely wrong

Yes, that's unfortunate. Usually we'd complain if the connection drops,
but I wonder if this has to do with the extra trip through
git-remote-https. I.e., that program sees the failure and dies, but we
don't manage to pass back the error code to the main git-push process.

It sounds like this is repeatable? If so, can you try with GIT_TRACE=1
and GIT_TRANSPORT_HELPER_DEBUG=1 set in the environment?

-Peff
