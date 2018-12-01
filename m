Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D314D211B3
	for <e@80x24.org>; Sat,  1 Dec 2018 19:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbeLBHDz (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 02:03:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:56260 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725728AbeLBHDz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 02:03:55 -0500
Received: (qmail 21433 invoked by uid 109); 1 Dec 2018 19:50:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Dec 2018 19:50:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1588 invoked by uid 111); 1 Dec 2018 19:50:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 01 Dec 2018 14:50:06 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Dec 2018 14:50:37 -0500
Date:   Sat, 1 Dec 2018 14:50:37 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>, max@max630.net,
        git@vger.kernel.org
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
Message-ID: <20181201195037.GA29120@sigill.intra.peff.net>
References: <20181119101535.16538-1-carenas@gmail.com>
 <20181119184018.GA5348@jessie.local>
 <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com>
 <20181120091107.GA30542@sigill.intra.peff.net>
 <20181128132708.GE30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181128132708.GE30222@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 28, 2018 at 02:27:08PM +0100, SZEDER Gábor wrote:

> > Curiously, the act.err file also has 54 NUL bytes before the "fatal:"
> > message.
> 
> I think those NUL bytes come from the file system.
> 
> The contents of 'act.err' from the previous test ('fetch gzipped
> empty') is usually:
> 
>   fatal: request ended in the middle of the gzip stream
>   fatal: the remote end hung up unexpectedly
> 
> Notice that the length of the first line is 54 bytes (including the
> trailing newline).  So I suspect that the following is happening:
> 
>   - http-backend in the previous test writes the first line,
>   - that test finishes and this one starts,
>   - this test truncates 'act.err',
>   - and then the still-running http-backend from the previous test
>     finally writes the second line.
> 
> So at this point 'act.err' is empty, but the offset of the fd of the
> redirection still open from the previous test is at 54, so the file
> system fills those bytes with NULs.

Right, good thinking. Thanks for the explanation!

-Peff
