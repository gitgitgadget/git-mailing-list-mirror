Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8458020248
	for <e@80x24.org>; Tue, 26 Feb 2019 17:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfBZRq5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 12:46:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:58744 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727416AbfBZRq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 12:46:57 -0500
Received: (qmail 1099 invoked by uid 109); 26 Feb 2019 17:46:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Feb 2019 17:46:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30861 invoked by uid 111); 26 Feb 2019 17:47:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Feb 2019 12:47:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Feb 2019 12:46:55 -0500
Date:   Tue, 26 Feb 2019 12:46:55 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 2/2] setup: fix memory leaks with `struct
 repository_format`
Message-ID: <20190226174655.GE19606@sigill.intra.peff.net>
References: <CAN0heSq0Nb-WdhDFpdwgjUMrkJNbviAtietn=B5nJg-rDgcR_g@mail.gmail.com>
 <cover.1548186510.git.martin.agren@gmail.com>
 <f8b021033b887923662eb9fa63f6df1677ebbbb5.1548186510.git.martin.agren@gmail.com>
 <20190123055704.GA19601@sigill.intra.peff.net>
 <CAN0heSoNvTVfC6A8fFK83u4TBX3sLaTJ_NqKwkCZORiCKdVwcA@mail.gmail.com>
 <20190125195107.GA6520@sigill.intra.peff.net>
 <CAN0heSq=0=B-FoPWcuRxp0oJ6capo3Pu4txZZOP2uDeNn5N1Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSq=0=B-FoPWcuRxp0oJ6capo3Pu4txZZOP2uDeNn5N1Og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 25, 2019 at 08:21:07PM +0100, Martin Ågren wrote:

> It's time to resurrect this thread. I've reworked this patch to avoid
> the compound literal when re-initing a struct, and I've been going back
> and forth on this point about having to initialize to `..._INIT` or risk
> crashing. And I keep coming back to thinking that it's not *that*
> different from how `STRBUF_INIT` works.
> 
> There's the obvious difference that there aren't as many functions to
> call, so there's certainly a difference in scale. And you'd think that
> you'll always start with `read_...()`, but another potential first
> function to call is `clear_...()` (see builtin/init-db.c), in which case
> you better have used `..._INIT` first.
> 
> I'm tempted to address this point by documenting as good as I can in the
> .h-file that one has to use this initializer macro. I'll obviously
> convert all users, so copy-paste programming should work fine...
> 
> How does that sound to you?

It sounds pretty good.

-Peff
