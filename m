Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A98731F404
	for <e@80x24.org>; Sat, 11 Aug 2018 14:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeHKQrO (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 12:47:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:50986 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727338AbeHKQrO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 12:47:14 -0400
Received: (qmail 28065 invoked by uid 109); 11 Aug 2018 14:12:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 11 Aug 2018 14:12:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27394 invoked by uid 111); 11 Aug 2018 14:12:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 11 Aug 2018 10:12:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 Aug 2018 10:12:52 -0400
Date:   Sat, 11 Aug 2018 10:12:52 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 2/8] Add delta-islands.{c,h}
Message-ID: <20180811141251.GA17649@sigill.intra.peff.net>
References: <20180809155532.26151-1-chriscool@tuxfamily.org>
 <20180809155532.26151-3-chriscool@tuxfamily.org>
 <20180811090418.26674-1-szeder.dev@gmail.com>
 <CAP8UFD0uoOKyUkNDrQgzcf6rGtnd9-Jk26swtzdyNDeCHefYJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0uoOKyUkNDrQgzcf6rGtnd9-Jk26swtzdyNDeCHefYJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 11, 2018 at 12:32:32PM +0200, Christian Couder wrote:

> Ok, I have made the following changes in the branch I will send next.
> 
> diff --git a/delta-islands.c b/delta-islands.c
> index 92137f2eca..22e4360810 100644
> --- a/delta-islands.c
> +++ b/delta-islands.c
> @@ -322,8 +322,7 @@ static int island_config_callback(const char *k,
> const char *v, void *cb)
> 
>                 if (island_regexes_nr >= island_regexes_alloc) {
>                         island_regexes_alloc = (island_regexes_alloc + 8) * 2;
> -                       island_regexes = xrealloc(island_regexes,
> -                                       island_regexes_alloc * sizeof(regex_t));
> +                       REALLOC_ARRAY(island_regexes, island_regexes_alloc);
>                 }

I think this whole block could actually be ALLOC_GROW().

-Peff
