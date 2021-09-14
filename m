Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428F1C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 18:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2190761107
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 18:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhINSjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 14:39:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:47280 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhINSjr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 14:39:47 -0400
Received: (qmail 24878 invoked by uid 109); 14 Sep 2021 18:38:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 18:38:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26443 invoked by uid 111); 14 Sep 2021 18:38:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 14:38:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 14:38:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/9] reducing memory allocations for v2 servers
Message-ID: <YUDsJNV2mvKl5g29@coredump.intra.peff.net>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
 <xmqqy27z11gn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy27z11gn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 11:00:56AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > While looking at [1], I noticed that v2 servers will read a few bits of
> > client input into strvecs. Even though we expect these to be small-ish,
> > there's nothing preventing a client from sending us a bunch of junk and
> > wasting memory.
> 
> The title of the topic says "reducing", but it smells more to me
> like this is about "limiting" allocations to protect ourselves.  Am
> I reading the series correctly?

Yeah, I think "limiting" is probably a better word. We will still
allocate for ref-prefix, of course, but we'll limit the number of
allocations. We did "reduce" the number of spots that allocate, since
capabilities no longer do so. :)

But I think your understanding of the series is correct.

-Peff
