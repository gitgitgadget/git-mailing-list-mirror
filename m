Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A31C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiLLVV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiLLVV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:21:28 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ED3F23
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:21:27 -0800 (PST)
Received: (qmail 6694 invoked by uid 109); 12 Dec 2022 21:21:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Dec 2022 21:21:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29885 invoked by uid 111); 12 Dec 2022 21:20:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Dec 2022 16:20:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Dec 2022 16:20:11 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v4 3/4] object-file: emit corruption errors when detected
Message-ID: <Y5ebC1qwJi5VwnCh@coredump.intra.peff.net>
References: <Y5eT6jodUdNr6hK6@coredump.intra.peff.net>
 <20221212205955.956380-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221212205955.956380-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2022 at 12:59:55PM -0800, Jonathan Tan wrote:

> > And possibly put a comment above open_loose_object() that "path"
> > is only guaranteed to point to something sensible when a non-negative
> > value is returned.
> 
> Junio made a point that there could, for example, be no path when the
> odb list is empty (maybe in the future) so I don't think this would be
> sufficient. But there is already a comment there pointing to a comment
> in another function that states "path ... (if any)" so this is something
> that callers should already take care of. In my changes, I'll initialize
> it to NULL and whenever I use it, I'll check for non-NULL first.

If we return a non-negative value, then we opened something, so by
definition, don't we have a path of the thing we opened?

I think the case Junio mentioned was if we for some reason didn't look
at _any_ path. In which case we'd be returning an error.

-Peff
