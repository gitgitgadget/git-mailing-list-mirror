Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 955FE1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 16:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbdFSQK7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 12:10:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:44582 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752170AbdFSQK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 12:10:58 -0400
Received: (qmail 10433 invoked by uid 109); 19 Jun 2017 16:05:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Jun 2017 16:05:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29047 invoked by uid 111); 19 Jun 2017 16:10:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Jun 2017 12:10:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Jun 2017 12:10:51 -0400
Date:   Mon, 19 Jun 2017 12:10:51 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Liam Beguin <liambeguin@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 08/10] rebase -i: skip unnecessary picks using the
 rebase--helper
Message-ID: <20170619161051.silyrlwrnjjspoxe@sigill.intra.peff.net>
References: <cover.1497444257.git.johannes.schindelin@gmx.de>
 <72bbfcae2abcb14f6b1288051a244faadbee29e0.1497444257.git.johannes.schindelin@gmx.de>
 <a12767b9-a947-e0a2-fc82-fc25992fd0d1@gmail.com>
 <alpine.DEB.2.21.1.1706161551030.4200@virtualbox>
 <529f6cc7-ab2b-72bb-bc51-f4cca4e98652@gmail.com>
 <alpine.DEB.2.21.1.1706191127450.57822@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706191127450.57822@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 11:45:50AM +0200, Johannes Schindelin wrote:

> The reason for this suggestion is that one of the revision machinery's
> implementation details is an ugly little semi-secret: the pretty-printing
> machinery uses a global state, and that is why we need the "pretty_given"
> flag in the first place.

I think that's mis-stating Junio's complaint. The point is not the
pretty_given flag itself, which we know about and can work around. The
point is that we don't know what other similar problems we have or will
have due to future changes in the revision code.

In other words, there are two APIs: the one where C code manipulates
rev_info directly, and the one where revision.c responds to string
arguments. From a maintenance perspective, it is easy for somebody make
a change that works for the latter but not the former.

I do agree that the lack of compile-time safety for obvious mistakes
like "--pertty" is a downside, though. On the other hand, there are
strong run-time checks there, so the tests would catch it.

I do not have a strong opinion myself in either direction.

-Peff
