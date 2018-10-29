Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B5391F453
	for <e@80x24.org>; Mon, 29 Oct 2018 23:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbeJ3IUT (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 04:20:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:60160 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725851AbeJ3IUT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 04:20:19 -0400
Received: (qmail 8550 invoked by uid 109); 29 Oct 2018 23:29:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 23:29:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25153 invoked by uid 111); 29 Oct 2018 23:28:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 19:28:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 19:29:19 -0400
Date:   Mon, 29 Oct 2018 19:29:19 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gerardu@amazon.com, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181029232918.GD24557@sigill.intra.peff.net>
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
 <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
 <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <xmqqbm7da88t.fsf@gitster-ct.c.googlers.com>
 <20181029213453.GA8325@amazon.com>
 <20181029222742.GB24557@sigill.intra.peff.net>
 <CAGZ79kY=G5E-eyqH3j24KzeUqpgE8Pw-hJQcD5=OqTCMwscabA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kY=G5E-eyqH3j24KzeUqpgE8Pw-hJQcD5=OqTCMwscabA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 03:35:58PM -0700, Stefan Beller wrote:

> On Mon, Oct 29, 2018 at 3:27 PM Jeff King <peff@peff.net> wrote:
> 
> > So yeah, that's the other thing I'm thinking about regarding having a
> > maximum loose cache size.
> 
> tangent:
> This preloading/caching could be used for a more precise approach
> to decide when to gc instead of using some statistical sampling
> of objects/17, eventually.

Isn't it exactly the same thing? Ideally we'd break down the cache to
the directory level, so we could fill the cache list for "17" and ask
"how full are you". Or we could just readdir objects/17 ourselves. But
either way, it's the same amount of work.

-Peff
