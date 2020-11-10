Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF00C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 19:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63FF2206D8
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 19:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbgKJTwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 14:52:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:53248 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgKJTwU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 14:52:20 -0500
Received: (qmail 8966 invoked by uid 109); 10 Nov 2020 19:52:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 19:52:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4482 invoked by uid 111); 10 Nov 2020 19:52:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Nov 2020 14:52:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Nov 2020 14:52:19 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Anders Waldenborg <anders@0x63.nu>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 05/21] trailer: rename 'free_all' to
 'free_all_trailer_items'
Message-ID: <20201110195219.GB1987088@coredump.intra.peff.net>
References: <20201025212652.3003036-1-anders@0x63.nu>
 <20201025212652.3003036-6-anders@0x63.nu>
 <CAP8UFD0Fpkj_xc-UBCeayw2C_4eXCx7Kan90PCvoM-KUMVEGDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0Fpkj_xc-UBCeayw2C_4eXCx7Kan90PCvoM-KUMVEGDA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 01:42:25PM +0100, Christian Couder wrote:

> > No functional change intended.
> 
> This doesn't explain much why renaming 'free_all' to
> 'free_all_trailer_items' is a good idea. Is the function specific to
> trailer items or is it generic enough to be useful on other 'struct
> list_head *head'?

It can't be generic, because list_head needs to use the expected
containing type to find the containing pointer. So free_all() is quite a
bad name, even within trailer.c, because the compiler won't even tell
you if you pass a different list to it.

I do agree this should be spelled out in the commit message, though. :)

-Peff
