Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C89C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 07:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbhK3Hgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 02:36:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:39992 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232892AbhK3Hgp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 02:36:45 -0500
Received: (qmail 11905 invoked by uid 109); 30 Nov 2021 07:33:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Nov 2021 07:33:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12518 invoked by uid 111); 30 Nov 2021 07:33:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Nov 2021 02:33:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Nov 2021 02:33:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: jk/loosen-urlmatch, was What's cooking in git.git (Nov 2021, #07;
 Mon, 29)
Message-ID: <YaXTxTW9ihC1/deN@coredump.intra.peff.net>
References: <xmqqzgpm2xrd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgpm2xrd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 06:16:54PM -0800, Junio C Hamano wrote:

> --------------------------------------------------
> [Graduated to 'master']
>
> [...]
> * jk/loosen-urlmatch (2021-10-12) 1 commit
>   (merged to 'next' on 2021-10-25 at f66ca39ebe)
>  + urlmatch: add underscore to URL_HOST_CHARS
> 
>  Treat "_" as any other URL-valid characters in an URL when matching
>  the per-URL configuration variable names.

Sorry, I hadn't noticed that this one had even made it to 'next', and
was surprised to see it graduate.

I think brian corrected my assertion in the commit message that RFC 1738
says that underscores are OK. They are for URIs in general, but not the
specific case of hostnames in HTTP schemes.

Now that isn't strictly a reason to drop the patch. Even though
underscores aren't allowed, they do work in some limited circumstances,
and curl is happy to take them. So in some sense this is harmonizing our
urlmatch behavior with curl for an iffy-but-workable practice, and there
may be value in that. But it does take us further away from the
standards, which could possibly have surprising consequences down the
road.

I don't have a strong feeling either way on reverting it at this point.
But I wanted to make sure that if we kept it in, we were doing so
consciously, and not just because folks involved in the discussion
didn't realize it was still working its way through the process.

I.e., if brian is likewise surprised and wants to object, this is now
the time. :)

-Peff
