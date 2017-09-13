Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC13120A21
	for <e@80x24.org>; Wed, 13 Sep 2017 18:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbdIMSLa (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 14:11:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:37364 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751106AbdIMSLa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 14:11:30 -0400
Received: (qmail 26619 invoked by uid 109); 13 Sep 2017 18:11:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 18:11:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18259 invoked by uid 111); 13 Sep 2017 18:12:04 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 14:12:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 14:11:27 -0400
Date:   Wed, 13 Sep 2017 14:11:27 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/7] config: avoid "write_in_full(fd, buf, len) < len"
 pattern
Message-ID: <20170913181127.rl2kfqkw7basp6kb@sigill.intra.peff.net>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171104.yu7ags4aq2zdwz6r@sigill.intra.peff.net>
 <20170913174728.GB27425@aiede.mtv.corp.google.com>
 <20170913175338.tsq4hmgmmybp43dw@sigill.intra.peff.net>
 <20170913175930.GD27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913175930.GD27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 10:59:30AM -0700, Jonathan Nieder wrote:

> I can confidentally say the intent in C99 in that passage is to
> describe the type of the expression, not just the type of a variable
> that can hold it.

Doh. The problem is that I'm a moron. The copy_begin and copy_end values
are _not_ pointers, they're size_t. That's why we have to use:

  contents + copy_begin

as the buffer. So there is no ptrdiff_t involved at all, just a size_t.

-Peff
