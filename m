Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE13C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 21:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 079ED206D4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 21:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbgKWVgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 16:36:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:39056 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730902AbgKWVgq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 16:36:46 -0500
Received: (qmail 28928 invoked by uid 109); 23 Nov 2020 21:36:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Nov 2020 21:36:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7732 invoked by uid 111); 23 Nov 2020 21:36:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Nov 2020 16:36:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Nov 2020 16:36:44 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mktag: don't check SHA-1 object length under SHA-256
Message-ID: <X7wrbI/pefHJsfdY@coredump.intra.peff.net>
References: <20190826014344.16008-11-sandals@crustytoothpaste.net>
 <20201123120111.13567-1-avarab@gmail.com>
 <xmqqlferoq1m.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlferoq1m.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 11:01:57AM -0800, Junio C Hamano wrote:

> > @@ -58,7 +68,7 @@ static int verify_tag(char *buffer, unsigned long size)
> >  		return error("char%d: does not start with \"object \"", 0);
> >  
> >  	if (parse_oid_hex(object + 7, &oid, &p))
> > -		return error("char%d: could not get SHA1 hash", 7);
> > +		return error("char%d: expected object ID, got garbage", 7);
> 
> Here you say object ID, which is better than <hash> or <sha>.  Let's
> be consistent (I'd say "object name" if I were choosing which to
> use).

It might just be me, but "object name" makes me think we'd take any name
(e.g., a refname that resolves to an object), whereas "object id" would
mean the object's hash specifically. And in this instance we only allow
the latter.

I agree very much with your other comments that if we are changing
these, we should get away from <sha> completely.

-Peff
