Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 086E11FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 07:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933249AbeAJHyC (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 02:54:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:39740 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754151AbeAJHyC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 02:54:02 -0500
Received: (qmail 16854 invoked by uid 109); 10 Jan 2018 07:54:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Jan 2018 07:54:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13405 invoked by uid 111); 10 Jan 2018 07:54:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Jan 2018 02:54:35 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jan 2018 02:54:00 -0500
Date:   Wed, 10 Jan 2018 02:54:00 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/9] commit: avoid allocation in
 clear_commit_marks_many()
Message-ID: <20180110075359.GC16315@sigill.intra.peff.net>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
 <d37d0e0d-c703-a70c-cf0b-969e54473557@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d37d0e0d-c703-a70c-cf0b-969e54473557@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 25, 2017 at 06:43:37PM +0100, René Scharfe wrote:

> Pass the entries of the commit array directly to clear_commit_marks_1()
> instead of adding them to a commit_list first.  The function clears the
> commit and any first parent without allocation; only higher numbered
> parents are added to a list for later treatment.  This change extends
> that optimization to clear_commit_marks_many().

It took a bit of head-scratching to see that is indeed what
clear_commit_marks_1 does. I suspect this doesn't make all that big a
difference in practice (after all, we're doing an allocation for each
merge anyway, so allocating for the tips is likely to be a subset), but
it doesn't hurt to do so.

-Peff
