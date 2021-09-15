Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8D5C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F93F60FC0
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhIOQne (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:43:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:48150 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231715AbhIOQnO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 12:43:14 -0400
Received: (qmail 32471 invoked by uid 109); 15 Sep 2021 16:41:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 16:41:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25276 invoked by uid 111); 15 Sep 2021 16:41:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 12:41:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 12:41:54 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/9] reducing memory allocations for v2 servers
Message-ID: <YUIiUp0CiqAbMvPw@coredump.intra.peff.net>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
 <871r5qof8k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871r5qof8k.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 02:25:49AM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Tue, Sep 14 2021, Jeff King wrote:
> 
> > While looking at [1], I noticed that v2 servers will read a few bits of
> > client input into strvecs. Even though we expect these to be small-ish,
> > there's nothing preventing a client from sending us a bunch of junk and
> > wasting memory.
> 
> [...]
> 
> >
> > [1] https://lore.kernel.org/git/YT54CNYgtGcqexwq@coredump.intra.peff.net/
> 
> When I first read this I expected it to be a link to
> https://lore.kernel.org/git/YPCsDLoiiAG%2FC%2Fft@coredump.intra.peff.net/;
> i.e. that the object-info leak discussion back in July had encouraged
> you to work on this ... :)

Nope, I got terrified by the "yes | upload-pack" example I showed
earlier. :)

I was really worried it could turn into a heap overflow, but it turns
out that it cannot. But I still think tightening things up (and avoiding
any memory-consumption attacks) is worth doing.

-Peff
