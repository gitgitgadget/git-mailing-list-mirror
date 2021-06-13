Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3888C48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 15:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C33E661245
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 15:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhFMPoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 11:44:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:53842 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231922AbhFMPoP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 11:44:15 -0400
Received: (qmail 29471 invoked by uid 109); 13 Jun 2021 15:42:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 13 Jun 2021 15:42:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26779 invoked by uid 111); 13 Jun 2021 15:42:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 13 Jun 2021 11:42:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 13 Jun 2021 11:42:13 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] xdiff: implement a zealous diff3
Message-ID: <YMYnVWSEgxvKRU9j@coredump.intra.peff.net>
References: <20210613143155.836591-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210613143155.836591-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 13, 2021 at 09:31:55AM -0500, Felipe Contreras wrote:

> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> "zdiff3" is identical to ordinary diff3, only it allows more aggressive
> compaction than diff3. This way the displayed base isn't necessary
> technically correct, but still this mode might help resolving merge
> conflicts between two near identical additions.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> 
> I'm re-sending this patch from 2013 because I do think it provides value
> and we might want to make it the default.

I take it you didn't investigate the segfault I mentioned.

Try this:

   commit=a5170794372cf1325710a3419473c91ec4af53bf
   for style in merge diff3 zdiff3; do
     git reset --hard
     git checkout $commit^1
     git -c merge.conflictstyle=$style merge $commit^2
   done

The first two are fine; the zdiff3 one segfaults within the xmerge.c
code.

-Peff
