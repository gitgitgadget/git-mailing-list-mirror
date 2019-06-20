Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EB4F1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 18:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfFTSZb (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 14:25:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:46260 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727655AbfFTSZa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 14:25:30 -0400
Received: (qmail 24985 invoked by uid 109); 20 Jun 2019 18:25:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 18:25:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17430 invoked by uid 111); 20 Jun 2019 18:26:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 14:26:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 14:25:28 -0400
Date:   Thu, 20 Jun 2019 14:25:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 01/17] describe: fix accidental oid/hash type-punning
Message-ID: <20190620182527.GB18704@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
 <20190620074050.GA3713@sigill.intra.peff.net>
 <xmqq7e9gp68e.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7e9gp68e.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 09:32:49AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The find_commit_name() function passes an object_id.hash as the key of a
> > hashmap. That ends up in commit_name_neq(), which then feeds it to
> > oideq(). Which means we should actually be the whole "struct object_id".
> >
> > It works anyway because pointers to the two are interchangeable. And
> > because we're going through a layer of void pointers, the compiler
> > doesn't notice the type mismatch.
> 
> Wow.  Good eyes.  I wouldn't have noticed this (and for the reasons
> you stated, it is very tricky for any clever compiler to notice it).
> 
> Impressed.

It only looks impressive in retrospect. It became very obvious when
updating the reference to sha1hash(peeled->hash) in the same line, and
then scratching my head about why this one was looking at the hash
member. But history rewriting lets me re-order it to make myself look
good. Thanks, "rebase -i"! :)

-Peff
