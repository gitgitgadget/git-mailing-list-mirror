Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30C23208CD
	for <e@80x24.org>; Thu,  7 Sep 2017 14:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932218AbdIGOya (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 10:54:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:59770 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755421AbdIGOyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 10:54:25 -0400
Received: (qmail 945 invoked by uid 109); 7 Sep 2017 14:54:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 14:54:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 502 invoked by uid 111); 7 Sep 2017 14:54:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 10:54:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Sep 2017 10:54:23 -0400
Date:   Thu, 7 Sep 2017 10:54:23 -0400
From:   Jeff King <peff@peff.net>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Test name-rev with small stack
Message-ID: <20170907145423.wz3iqxxz2yvxq5lm@sigill.intra.peff.net>
References: <c1cb526d-a567-b598-d980-5dbe695b7d6a@grubix.eu>
 <cover.1504792601.git.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1504792601.git.git@grubix.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 07, 2017 at 04:02:19PM +0200, Michael J Gruber wrote:

> name-rev segfaults for me in emacs.git with the typical 8102 stack size.
> The reason is the recursive walk that name-rev uses.
> 
> This series adds a test to mark this as known failure, after some
> clean-ups.

These all look reasonable to me. The size of the test case in the final
one is presumably arbitrary and just copied from t7004. I don't know if
it's worth trying to shrink it. It could shorten a rather expensive
test. OTOH, if we shorten it too much then we might get a false pass
(e.g., if the algorithm remains recursive but has a smaller stack
footprint).

> Michael J Gruber (4):
>   t7004: move limited stack prereq to test-lib
>   t6120: test name-rev --all and --stdin
>   t6120: clean up state after breaking repo
>   t6120: test describe and name-rev with deep repos

Now comes the hard part: rewriting the C code. :)

-Peff
