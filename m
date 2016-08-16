Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0D171F859
	for <e@80x24.org>; Tue, 16 Aug 2016 13:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523AbcHPNMv (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 09:12:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:56191 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752516AbcHPNMn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 09:12:43 -0400
Received: (qmail 6278 invoked by uid 109); 16 Aug 2016 13:11:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 13:11:48 +0000
Received: (qmail 26227 invoked by uid 111); 16 Aug 2016 13:11:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 09:11:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2016 09:11:45 -0400
Date:	Tue, 16 Aug 2016 09:11:45 -0400
From:	Jeff King <peff@peff.net>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/3] limit the size of the packs we receive
Message-ID: <20160816131145.apq77nc2x7wb7lba@sigill.intra.peff.net>
References: <20160816081701.29949-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160816081701.29949-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 10:16:58AM +0200, Christian Couder wrote:

> Changes from previous RFC version
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>   - added documentation to all the 3 patches,

Good idea.

>   - changed strtoul() to strtoumax() in the first 2 patches, as
>     suggested by Peff,
> 
>   - changed git_config_ulong() to git_config_int64() and used PRIuMAX
>     and uintmax_t in the last patch, as suggested by Peff,

Thinking a bit, off_t is actually signed. So maybe PRIdMAX (which we
don't seem to have compat macros for) would make more sense. I dunno if
anybody actually cares. This value shouldn't be signed anyway, and
nobody should be approaching the limits of a 64-bit number anyway (there
is no point in limiting the incoming pack to the exabyte range).

So I'm inclined not to worry about it.

-Peff
