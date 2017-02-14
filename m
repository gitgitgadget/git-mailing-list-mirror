Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A21B1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 22:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbdBNWDg (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 17:03:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:55374 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751587AbdBNWDf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 17:03:35 -0500
Received: (qmail 24627 invoked by uid 109); 14 Feb 2017 22:03:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 22:03:35 +0000
Received: (qmail 7428 invoked by uid 111); 14 Feb 2017 22:03:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 17:03:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 17:03:32 -0500
Date:   Tue, 14 Feb 2017 17:03:32 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/5] A series of performance enhancements in the memihash
 and name-cache area
Message-ID: <20170214220332.753i4tgclm62er4f@sigill.intra.peff.net>
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1487071883.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 12:31:46PM +0100, Johannes Schindelin wrote:

> On Windows, calls to memihash() and maintaining the istate.name_hash and
> istate.dir_hash HashMaps take significant time on very large
> repositories. This series of changes reduces the overall time taken for
> various operations by reducing the number calls to memihash(), moving
> some of them into multi-threaded code, and etc.
> 
> Note: one commenter in https://github.com/git-for-windows/git/pull/964
> pointed out that memihash() only handles ASCII correctly. That is true.
> And fixing this is outside the purview of this patch series.

Out of curiosity, do you have numbers? Bonus points if the speedup can
be shown via a t/perf script.

We have a read-cache perf-test already, but I suspect you'd want
something more like "git status" or "ls-files -o" that calls into
read_directory().

-Peff
