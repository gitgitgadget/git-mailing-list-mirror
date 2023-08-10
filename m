Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFF4C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 00:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjHJATY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 20:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHJATX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 20:19:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A70E5F
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 17:19:22 -0700 (PDT)
Received: (qmail 22772 invoked by uid 109); 10 Aug 2023 00:19:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Aug 2023 00:19:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3048 invoked by uid 111); 10 Aug 2023 00:19:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Aug 2023 20:19:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Aug 2023 20:19:21 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] repack: prevent geometry struct leak
Message-ID: <20230810001921.GB795985@coredump.intra.peff.net>
References: <20230808211759.GA322409@coredump.intra.peff.net>
 <cover.1691613149.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691613149.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2023 at 04:32:36PM -0400, Taylor Blau wrote:

> This short series combines a patch from Peff and a patch from me to
> prevent leaking the 'struct pack_geometry *' pointer from the repack
> code.
> 
> The first patch free()s the heap-allocated struct, and the second
> patch moves the variable to be allocated on the stack.

Thanks for cleaning up your patch. I think Junio has the first one in
'next' already as jk/repack-leakfix, but your patch 2 can go on top.

The result looks good to me. It's a little unusual that the "init"
function expects the caller to have already initialized-to-zero and set
the split_factor field, but I think that's OK for a struct that is
limited to this one file.

-Peff
