Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92D41FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 06:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbdFJGlF (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 02:41:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:37468 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbdFJGlF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 02:41:05 -0400
Received: (qmail 29381 invoked by uid 109); 10 Jun 2017 06:41:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 06:41:04 +0000
Received: (qmail 29000 invoked by uid 111); 10 Jun 2017 06:41:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 02:41:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 02:41:02 -0400
Date:   Sat, 10 Jun 2017 02:41:02 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCHv2 1/5] revision.h: turn rev_info.early_output back into
 an unsigned int
Message-ID: <20170610064102.w4kp6omxdznfe7fa@sigill.intra.peff.net>
References: <20170602201143.6avkhp224no3dukb@sigill.intra.peff.net>
 <20170609181733.6793-1-szeder.dev@gmail.com>
 <20170609181733.6793-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170609181733.6793-2-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 09, 2017 at 08:17:29PM +0200, SZEDER Gábor wrote:

> rev_info.early_output started out as an unsigned int in cdcefbc97 (Add
> "--early-output" log flag for interactive GUI use, 2007-11-03), but
> later it was turned into a single bit in a bit field in cc243c3ce
> (show: --ignore-missing, 2011-05-18) without explanation, though its
> users still expect it to be a regular integer type.  Consequently, any
> even number given via '--early-output=<N>' effectively disabled the
> feature.
> 
> Turn it back into an unsigned int, restoring its original data type.

This confused me for a moment, as on my first read it seems like the
obvious solution is to normalize the input to a bit-field, like:

  revs->early_output = !!atoi(optarg);

But the "users still expect" bit was a bit subtle to me, as I thought
you meant users of Git. But you mean that the feature itself is not a
boolean, but rather an integer count of how much early output to show.

I'm not sure if I was just being thick or if that point (and the fact
that --early-output has basically been a noop since 2011!) should be
made more explicit.

Given that nobody noticed, I kind of wonder if we should consider
ripping the feature out entirely.

-Peff
