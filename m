Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3170202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750929AbdJBFIN (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:08:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:57008 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750763AbdJBFIN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:08:13 -0400
Received: (qmail 5655 invoked by uid 109); 2 Oct 2017 05:08:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 05:08:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25045 invoked by uid 111); 2 Oct 2017 05:08:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 01:08:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 01:08:11 -0400
Date:   Mon, 2 Oct 2017 01:08:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: avoid NULL pointer arithmetic
Message-ID: <20171002050810.ryj4nv3nwqp7gb7p@sigill.intra.peff.net>
References: <99e56671-bdf9-a59f-ae7b-758f1b7a8f14@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99e56671-bdf9-a59f-ae7b-758f1b7a8f14@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 04:45:13PM +0200, René Scharfe wrote:

> lookup_blob() etc. can return NULL if the referenced object isn't of the
> expected type.  In theory it's wrong to reference the object member in
> that case.  In practice it's OK because it's located at offset 0 for all
> types, so the pointer arithmetic (NULL + 0) is optimized out by the
> compiler.  The issue is reported by Clang's AddressSanitizer, though.
> 
> Avoid the ASan error by casting the results of the lookup functions to
> struct object pointers.  That works fine with NULL pointers as well.  We
> already rely on the object member being first in all object types in
> other places in the code.

Out of curiosity, did you have to do anything to coax this out of ASan
(e.g., a specific version)?  I've been running it pretty regularly and
didn't see this one (I did switch from clang to gcc a month or two ago,
but this code is pretty old, I think).

-Peff
