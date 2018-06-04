Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8197C1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 03:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbeFDDj6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 23:39:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:32884 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751211AbeFDDj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 23:39:58 -0400
Received: (qmail 349 invoked by uid 109); 4 Jun 2018 03:39:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Jun 2018 03:39:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11370 invoked by uid 111); 4 Jun 2018 03:40:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 03 Jun 2018 23:40:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Jun 2018 23:39:55 -0400
Date:   Sun, 3 Jun 2018 23:39:55 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] update-ref --stdin: use skip_prefix()
Message-ID: <20180604033955.GB14451@sigill.intra.peff.net>
References: <20180603143651.6844-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180603143651.6844-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 03, 2018 at 04:36:51PM +0200, SZEDER Gábor wrote:

> Use skip_prefix() instead of starts_with() and strcmp() when parsing
> 'git update-ref's stdin to avoid a couple of magic numbers.

I was coincidentally looking at this the other day also noticed these.
Thanks for cleaning it up (and your patch looks obviously correct).

I also found it funny that we read the whole input into a buffer and
parse from there, rather than using strbuf_getline(). But that's
intentional due to e23d84350a (update-ref --stdin: read the whole input
at once, 2014-04-07). I think the line-oriented protocol actually can be
easily read like that, but the "-z" format ends up having to do awkward
reads.

Anyway, sort of a tangent, but I didn't want anybody else looking at
this having to dig down the same hole I did. ;)

-Peff
