Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD9AD206A3
	for <e@80x24.org>; Wed,  9 Nov 2016 15:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753416AbcKIPhg (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 10:37:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:40723 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752922AbcKIPhg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 10:37:36 -0500
Received: (qmail 31627 invoked by uid 109); 9 Nov 2016 15:37:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Nov 2016 15:37:35 +0000
Received: (qmail 29761 invoked by uid 111); 9 Nov 2016 15:38:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Nov 2016 10:38:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Nov 2016 10:37:33 -0500
Date:   Wed, 9 Nov 2016 10:37:33 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] sequencer: shut up clang warning
Message-ID: <20161109153733.iauja57zikyb2awv@sigill.intra.peff.net>
References: <efbba4b32515fed7096c1c81dbe97eedd44083b0.1478699713.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <efbba4b32515fed7096c1c81dbe97eedd44083b0.1478699713.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2016 at 02:56:25PM +0100, Johannes Schindelin wrote:

> When comparing a value of type `enum todo_command` with a value that is
> outside the defined enum constants, clang greets the developer with this
> warning:
> 
> 	comparison of constant 2 with expression of type
> 	'const enum todo_command' is always true
> 
> While this is arguably true *iff* the value was never cast from a
> free-form int, we should keep the cautious code in place.
> 
> To shut up clang, we simply introduce an otherwise pointless enum constant
> and compare against that.

This does silence the warning.

I slightly prefer mine because:

  1. It does not carry an implicit requirement that TODO_INVALID remain
     the final enum value.

  2. It also protects the range check against a negative enum value.

But this is code that is getting changed later by you anyway, and I do
not care that strongly.

-Peff
