Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED562070F
	for <e@80x24.org>; Thu,  8 Sep 2016 08:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757941AbcIHINJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 04:13:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:40059 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1757915AbcIHINI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 04:13:08 -0400
Received: (qmail 3381 invoked by uid 109); 8 Sep 2016 08:13:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 08:13:07 +0000
Received: (qmail 13041 invoked by uid 111); 8 Sep 2016 08:13:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 04:13:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2016 04:13:05 -0400
Date:   Thu, 8 Sep 2016 04:13:05 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] Fix a segfault caused by regexec() being called
 on mmap()ed data
Message-ID: <20160908081305.yhzodcjjsobq4spo@sigill.intra.peff.net>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
 <cover.1473319844.git.johannes.schindelin@gmx.de>
 <alpine.DEB.2.20.1609080931250.129229@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1609080931250.129229@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2016 at 09:33:29AM +0200, Johannes Schindelin wrote:

> On Thu, 8 Sep 2016, Johannes Schindelin wrote:
> 
> > We solve this by introducing a helper, regexec_buf(), that takes a
> > pointer and a length instead of a NUL-terminated string.
> 
> BTW I should have clarified why I decided on another name than regexecn()
> (I had considered this even before reading Peff's proposed patch): the <n>
> in string functions suggest a limiting of NUL-terminated strings. In other
> words, if n = 100 and the provided pointer points to a NUL-terminated
> string of length 3, the *n function will treat it as a string of length 3.
> 
> That is not what regexec_buf() does: it ignores the NUL. Hence the
> different name.

I agree that is a better name (this was the exact thing I wondered about
with REG_STARTEND, but certainly what we _want_ is true "_buf"
semantics).

I guess an argument that REG_STARTEND does what we want everywhere is
that the GNU implementation does what we want, and since it has been
around for over a decade presumably _somebody_ would have complained if
it did not match the NetBSD behavior.

-Peff
