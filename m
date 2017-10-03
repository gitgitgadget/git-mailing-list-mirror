Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2775E2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 23:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbdJCXl4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 19:41:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:59782 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750865AbdJCXl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 19:41:56 -0400
Received: (qmail 27201 invoked by uid 109); 3 Oct 2017 23:41:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 23:41:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13090 invoked by uid 111); 3 Oct 2017 23:41:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 19:41:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 19:41:54 -0400
Date:   Tue, 3 Oct 2017 19:41:54 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] fixes for running the test suite with --valgrind
Message-ID: <20171003234153.pmslizidgbifl6en@sigill.intra.peff.net>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003195713.13395-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 08:57:10PM +0100, Thomas Gummerer wrote:

> I recently tried to run the git test suite with --valgrind.
> Unfortunately it didn't come back completely clean.  This patch series
> fixes a bunch of these errors, although unfortunately not quite all of
> them yet.

Thanks for trying that. I've largely switched to ASan over valgrind
because it runs _so_ much faster. Unfortunately it seems to miss
these uninitialized-memory cases.

I think using SANITIZE=memory would catch these, but it needs some
suppressions tuning. The weird "zlib reads uninitialized memory" error
is a problem (valgrind sees this, too, but we have suppressions).

-Peff
