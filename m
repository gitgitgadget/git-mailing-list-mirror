Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B83208CD
	for <e@80x24.org>; Thu,  7 Sep 2017 10:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755117AbdIGKL3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 06:11:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:59542 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755104AbdIGKL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 06:11:28 -0400
Received: (qmail 15337 invoked by uid 109); 7 Sep 2017 10:11:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 10:11:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30244 invoked by uid 111); 7 Sep 2017 10:12:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 06:12:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Sep 2017 06:11:26 -0400
Date:   Thu, 7 Sep 2017 06:11:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UGF3ZcWC?= Marczewski <pwmarcz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Strange behavior of git rev-list
Message-ID: <20170907101126.u574pr7l5odff6zo@sigill.intra.peff.net>
References: <CACNsYJ-UeEONZ+mDgg6x5Bi+D3VmS=5eGCYq1gEPHVsMEJGojA@mail.gmail.com>
 <20170907094718.b6kuzp2uhvkmwcso@sigill.intra.peff.net>
 <CACNsYJ8rRSf5gNtnPS05CnYCYGmoBymbgH7UumuOuBz1jp6RBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACNsYJ8rRSf5gNtnPS05CnYCYGmoBymbgH7UumuOuBz1jp6RBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 07, 2017 at 11:50:25AM +0200, Paweł Marczewski wrote:

> Thanks. Any plans to fix that? Or is there a way to turn off this heuristic?

I don't think there's a way to turn it off for `rev-list`. Merge-base
computations are more careful, so you could determine the correct
endpoints that way. But when you fed them to `rev-list`, it would hit
the same run of skewed commits.

We've discussed storing true generation numbers in the past, which would
make this optimization more robust, as well as allow us to speed up many
other traversals (e.g., the "tag --contains"). It's something I'd like
to revisit, but it's not at the top of the pile.

In the meantime, it would probably be possible to write a patch that
conditionally disables the optimization. But it would mean all of your
rev-lists run a _lot_ slower.

-Peff
