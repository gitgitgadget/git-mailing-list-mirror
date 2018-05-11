Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D07DB1F406
	for <e@80x24.org>; Fri, 11 May 2018 17:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeEKRmk (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 13:42:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:36320 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751217AbeEKRmj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 13:42:39 -0400
Received: (qmail 15817 invoked by uid 109); 11 May 2018 17:42:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 May 2018 17:42:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7623 invoked by uid 111); 11 May 2018 17:42:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 May 2018 13:42:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 May 2018 13:42:37 -0400
Date:   Fri, 11 May 2018 13:42:37 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] fast-export: avoid NULL pointer arithmetic
Message-ID: <20180511174237.GA19670@sigill.intra.peff.net>
References: <d50a4d5d-3b99-453e-1b52-4e733453fb78@web.de>
 <99d443cd-e817-7db5-f758-bf4cf47f7c06@web.de>
 <xmqqo9hniy1v.fsf@gitster-ct.c.googlers.com>
 <654fac2a-8dca-7bee-2bab-a3986aa7e52d@web.de>
 <xmqqbmdnhr8b.fsf@gitster-ct.c.googlers.com>
 <xmqq7eoahk49.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AN4nssu1+x0x9Kmz1BB1aXO7_UBFCjpyULMeC5K-Fzvw@mail.gmail.com>
 <20180511085634.GC22086@sigill.intra.peff.net>
 <CACsJy8CnJYsgDe11tK4JzH2sDRuLwgoUz=HCso5qOhEfyZNH5Q@mail.gmail.com>
 <20180511133419.GA2170@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180511133419.GA2170@duynguyen.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 03:34:19PM +0200, Duy Nguyen wrote:

> On Fri, May 11, 2018 at 03:11:46PM +0200, Duy Nguyen wrote:
> > Back to fast-export, can we just allocate a new int on heap and point
> > it there? Allocating small pieces becomes quite cheap and fast with
> > mem-pool.h and we can avoid this storing integer in pointer business.
> 
> Something like this seems to work, but we use 4-ish more bytes per
> object, or 100MB overhead on a repo with 25M objects. I think it's a
> reasonable trade off.

I'm not sure I agree. 4 bytes per object certainly isn't the end of the
world, but what was the problem we were solving in the first place? Just
that we weren't comfortable with the round-trip from uintptr_t to void
and back? Is this actually a problem on real platforms? If not, it seems
silly to incur a run-time cost.

-Peff
