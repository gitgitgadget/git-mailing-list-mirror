Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38ADC1F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 18:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756612AbcIFSnY (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 14:43:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:38969 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755486AbcIFSnX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 14:43:23 -0400
Received: (qmail 24863 invoked by uid 109); 6 Sep 2016 18:43:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 18:43:23 +0000
Received: (qmail 28937 invoked by uid 111); 6 Sep 2016 18:43:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 14:43:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Sep 2016 14:43:20 -0400
Date:   Tue, 6 Sep 2016 14:43:20 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Demonstrate a problem: our pickaxe code assumes
 NUL-terminated buffers
Message-ID: <20160906184320.lzg5jizpw2kbzf72@sigill.intra.peff.net>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
 <ca678535c64570add58cfff95709c3c67384139d.1473090278.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca678535c64570add58cfff95709c3c67384139d.1473090278.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 05, 2016 at 05:45:02PM +0200, Johannes Schindelin wrote:

> Typically, on Linux the test passes. On Windows, it fails virtually
> every time due to an access violation (that's a segmentation fault for
> you Unix-y people out there). And Windows would be correct: the
> regexec() call wants to operate on a regular, NUL-terminated string,
> there is no NUL in the mmap()ed memory range, and it is undefined
> whether the next byte is even legal to access.
> 
> When run with --valgrind it demonstrates quite clearly the breakage, of
> course.
> 
> So we simply mark it with `test_expect_success` for now.

I'd prefer if this were marked as expect_failure. It fails reliably for
me on Linux, even without --valgrind. But even if that were not so,
there is no reason to hurt bisectability of somebody running with
"--valgrind" (not when it costs so little to mark it correctly).

-Peff
