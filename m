Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F510C433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 16:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF54611BF
	for <git@archiver.kernel.org>; Wed, 19 May 2021 16:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355246AbhESQZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 12:25:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:59186 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355226AbhESQZj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 12:25:39 -0400
Received: (qmail 23542 invoked by uid 109); 19 May 2021 16:24:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 May 2021 16:24:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21331 invoked by uid 111); 19 May 2021 16:24:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 May 2021 12:24:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 19 May 2021 12:24:18 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Subject: Re: [Broken] t5300 fails at 2.32.0-rc0
Message-ID: <YKU7sj9MvF/hu/Lc@coredump.intra.peff.net>
References: <018201d74cc7$079ad730$16d08590$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <018201d74cc7$079ad730$16d08590$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 11:52:48AM -0400, Randall S. Becker wrote:

> expecting success of 5300.2 'pack without delta':
>         packname_1=$(git pack-objects --progress --window=0 test-1 \
>                         <obj-list 2>stderr) &&
>         check_deltas stderr = 0
> 
> not ok 2 - pack without delta
> #
> #               packname_1=$(git pack-objects --progress --window=0 test-1 \
> #                               <obj-list 2>stderr) &&
> #               check_deltas stderr = 0
> #

That was one I touched recently (to add the check_deltas stuff). Can you
run with "-x"? And/or run with "-i", and show the contents of the
"stderr" file?

The check_deltas helper is supposed to complain to stderr when it fails.
So I'm guessing perhaps pack-objects itself failed, and the reason is
hidden in the stderr file.

Also, of course, bisecting the failure would be helpful (I can't
reproduce here; I tried building with NO_PTHREADS, given our recent
discussion, but it doesn't seem to matter).

-Peff
