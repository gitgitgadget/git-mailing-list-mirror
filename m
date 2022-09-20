Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32F2C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 21:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiITVyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 17:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiITVyh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 17:54:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A399D63C3
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 14:54:34 -0700 (PDT)
Received: (qmail 31616 invoked by uid 109); 20 Sep 2022 21:54:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Sep 2022 21:54:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15476 invoked by uid 111); 20 Sep 2022 21:54:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Sep 2022 17:54:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 20 Sep 2022 17:54:32 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, derrickstolee@github.com
Subject: Re: [PATCH v2 0/3] midx: use `--stdin-packs` to implement `repack`
Message-ID: <Yyo2mJZt6B0JVGwA@coredump.intra.peff.net>
References: <YyokIf%2FSd7SYztKQ@nand.local>
 <cover.1663706401.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1663706401.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 04:40:14PM -0400, Taylor Blau wrote:

> Here's a few patches that replace the existing "feed each OID
> one-by-one" approach to implement the `repack` sub-command of the
> `multi-pack-index` builtin with one that uses `pack-objects`'s
> `--stdin-packs` option.
> 
> There is an additional patch at the beginning of this series in order to
> extract the mtime-sorted list of packs to rollup from their home in
> `fill_included_packs_batch()`. There's also one more on the end to unify
> the `include_pack` array into the `repack_info` struct(s) themselves.

The first and third make sense to me, and it looks like a nice cleanup.

The middle one looks fine, modulo all of our earlier discussion about
the extra traversal being fine. I think it would be good t get a review
from Stolee as the person who invented "git multi-index-pack repack" and
would understand its intended use. Presumably this is all weird "I have
a giant Windows repository" packing strategy. :)

-Peff
