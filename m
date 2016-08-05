Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC6D2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 07:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756511AbcHEHmr (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 03:42:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:55125 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751620AbcHEHmq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 03:42:46 -0400
Received: (qmail 9657 invoked by uid 102); 5 Aug 2016 07:42:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 03:42:27 -0400
Received: (qmail 23884 invoked by uid 107); 5 Aug 2016 07:42:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 03:42:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Aug 2016 03:42:19 -0400
Date:	Fri, 5 Aug 2016 03:42:19 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] nedmalloc: work around overzealous GCC 6 warning
Message-ID: <20160805074219.3vvgzaqnn6kvsh3s@sigill.intra.peff.net>
References: <cover.1470326812.git.johannes.schindelin@gmx.de>
 <57360f4885bdd5c36e190bea288f1e1f7f706071.1470326812.git.johannes.schindelin@gmx.de>
 <57A3BA26.5080601@web.de>
 <xmqqk2fwyx8h.fsf@gitster.mtv.corp.google.com>
 <5ce2ec67-aa7d-0079-54fe-d73a70a46825@kdbg.org>
 <68c24062-7fcc-758f-373f-2f123c5eb78b@kdbg.org>
 <xmqq7fbvzqan.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7fbvzqan.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 11:24:32PM -0700, Junio C Hamano wrote:

> I do not know if we want to worry about st_add(1, strlen(s1))
> overflow around here, though.
> [...]
> +	size_t len = strlen(s1) + 1;

I wondered that, too, but I don't think it's possible.

To overflow the size_t with "+1", strlen() must return the maximum value
that it can hold. But such a string would need one more byte than that,
for its trailing NUL. So assuming you cannot have a string that exceeds
size_t in the first place, I think it is impossible to overflow here.

-Peff
