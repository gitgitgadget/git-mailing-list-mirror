Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D4AD1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 15:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeHVSmX (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 14:42:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:51642 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728687AbeHVSmX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 14:42:23 -0400
Received: (qmail 18427 invoked by uid 109); 22 Aug 2018 15:17:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Aug 2018 15:17:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 402 invoked by uid 111); 22 Aug 2018 15:17:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 11:17:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 11:17:04 -0400
Date:   Wed, 22 Aug 2018 11:17:04 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180822151703.GB32630@sigill.intra.peff.net>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <20180822053626.GB535143@genre.crustytoothpaste.net>
 <20180822060735.GA13195@sigill.intra.peff.net>
 <CACBZZX7Cmp8d=UKF2nk36fL7mR+umdKwKZAKNZSkyP0NXvquhw@mail.gmail.com>
 <d1fafc75-d6e4-d363-d600-579c200aca43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1fafc75-d6e4-d363-d600-579c200aca43@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 07:14:42AM -0400, Derrick Stolee wrote:

> The other thing I was going to recommend (and I'll try to test this out
> myself later) is to see if 'the_hash_algo->rawsz' is being treated as a
> volatile variable, since it is being referenced through a pointer. Perhaps
> storing the value locally and then casing on it would help?

I tried various sprinkling of "const" around the declarations to make it
clear that the values wouldn't change once we saw them. But I couldn't
detect any difference. At most I think that would let us hoist the "if"
out of the loop, but gcc still seems unwilling to expand the memcmp when
there are other branches.

I think if that's the thing we want to have happen, we really do need to
just write it out on that branch rather than saying "memcmp".

-Peff
