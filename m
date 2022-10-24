Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7DFC67871
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 01:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiJYBDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 21:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiJYBCg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 21:02:36 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AE0EC1F3
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 16:59:22 -0700 (PDT)
Received: (qmail 4611 invoked by uid 109); 24 Oct 2022 23:59:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Oct 2022 23:59:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12612 invoked by uid 111); 24 Oct 2022 23:59:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Oct 2022 19:59:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Oct 2022 19:59:21 -0400
From:   Jeff King <peff@peff.net>
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] docs: clarify that credential discards unrecognised
 attributes
Message-ID: <Y1cm2a3qy9aowwNh@coredump.intra.peff.net>
References: <pull.1393.git.1666598268697.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1393.git.1666598268697.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 24, 2022 at 07:57:48AM +0000, M Hickford via GitGitGadget wrote:

> It was previously unclear how unrecognised attributes are handled.

Yeah, this was always part of the intended behavior, but I agree we did
not say it very explicitly (aside from an in-code comment!). Both the
intent and content of your patch look good to me.

We did discuss patches a long time ago that would let Git carry
arbitrary keys between helpers, even if Git itself didn't understand it.
One of the intended uses was to let helpers talk to each other about
TTLs. So if you had say:

  [credential]
  helper = generate-some-token
  helper = cache

where the first helper generates a token, and the second caches it, the
first one could shove a "ttl" or "expiration" key into the protocol,
which the cache could then learn to respect.

But we never merged such a thing, and in practice I think people would
just implement both parts as a single helper for simplicity. And anyway,
even if we did want to do that, such a patch would want to modify the
documentation to explain the new behavior. :)

-Peff
