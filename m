Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0547DC433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 19:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C33602086A
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 19:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgHGTA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:00:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:52114 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHGTA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 15:00:26 -0400
Received: (qmail 1296 invoked by uid 109); 7 Aug 2020 19:00:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 Aug 2020 19:00:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16415 invoked by uid 111); 7 Aug 2020 19:00:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Aug 2020 15:00:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 Aug 2020 15:00:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] refs: fix interleaving hook calls with
 reference-transaction hook
Message-ID: <20200807190024.GA1307861@coredump.intra.peff.net>
References: <63fb363375b515b903ed1269d10124b727c1d1cc.1596783732.git.ps@pks.im>
 <20200807075837.GA32344@coredump.intra.peff.net>
 <20200807090412.GA1407904@tanuki.pks.im>
 <20200807093239.GA1228157@coredump.intra.peff.net>
 <20200807094946.GA1758126@tanuki.pks.im>
 <xmqqpn82gy51.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpn82gy51.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 07, 2020 at 10:32:26AM -0700, Junio C Hamano wrote:

> >> Test                         HEAD^             HEAD
> >> --------------------------------------------------------------------
> >> 1400.2: update-ref           1.93(1.57+0.42)   1.91(1.55+0.42) -1.0%
> >> 1400.3: update-ref --stdin   0.07(0.02+0.05)   0.07(0.02+0.05) +0.0%
> >> 
> >> Running it a second time gets me +0.5%. :)
> >
> > Yeah, it's also been my take that OS-level overhead is probably going to
> > matter more than those access calls, and I argued such back when I
> > proposed the hook. So I'm perfectly happy to see this caching mechanism
> > go.
> 
> Is the above about negative cache?  IOW, does the above demonstrate
> that one extra access() to make sure there is no hook does not hurt
> us anything?

Yes, those numbers are with no cache at all, and without a hook. So they
are measuring the cost of access() only.

-Peff
