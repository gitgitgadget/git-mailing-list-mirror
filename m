Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A10EC8750
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 19:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbjIGTAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 15:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjIGTAp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 15:00:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B18A90
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 12:00:41 -0700 (PDT)
Received: (qmail 26984 invoked by uid 109); 7 Sep 2023 07:54:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Sep 2023 07:54:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24354 invoked by uid 111); 7 Sep 2023 07:54:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Sep 2023 03:54:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Sep 2023 03:54:00 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/8] builtin/repack.c: extract structure to store
 existing packs
Message-ID: <20230907075400.GA1260718@coredump.intra.peff.net>
References: <cover.1693946195.git.me@ttaylorr.com>
 <5b48b7e3cc03c83465a3dcecaa98b9d2e9667084.1693946195.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b48b7e3cc03c83465a3dcecaa98b9d2e9667084.1693946195.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2023 at 04:36:40PM -0400, Taylor Blau wrote:

> The repack machinery needs to keep track of which packfiles were present
> in the repository at the beginning of a repack, segmented by whether or
> not each pack is marked as kept.
> 
> The names of these packs are stored in two `string_list`s, corresponding
> to kept- and non-kept packs, respectively. As a consequence, many
> functions within the repack code need to take both `string_list`s as
> arguments, leading to code like this:
> 
>     ret = write_cruft_pack(&cruft_po_args, packtmp, pack_prefix,
>                            cruft_expiration, &names,
>                            &existing_nonkept_packs, /* <- */
>                            &existing_kept_packs);   /* <- */
> 
> Wrap up this pair of `string_list`s into a single structure that stores
> both. This saves us from having to pass both string lists separately,
> and prepares for adding additional fields to this structure.

Makes sense. Even without any additional fields, the grouping makes the
code a bit easier to follow.

Patch is noisy, but looks correct. :)

-Peff
