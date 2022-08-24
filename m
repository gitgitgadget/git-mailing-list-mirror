Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B855EC00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 08:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiHXIcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 04:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiHXIco (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 04:32:44 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F036AE4B
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 01:32:43 -0700 (PDT)
Received: (qmail 8185 invoked by uid 109); 24 Aug 2022 08:32:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Aug 2022 08:32:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17211 invoked by uid 111); 24 Aug 2022 08:32:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Aug 2022 04:32:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Aug 2022 04:32:41 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] promisor-remote: fix xcalloc() argument order
Message-ID: <YwXiKXONiTt+fIdi@coredump.intra.peff.net>
References: <20220822213408.662482-1-szeder.dev@gmail.com>
 <20220823095733.58685-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220823095733.58685-1-szeder.dev@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2022 at 11:57:33AM +0200, SZEDER Gábor wrote:

> Pass the number of elements first and their size second, as expected
> by xcalloc().
> 
> Patch generated with:
> 
>   make SPATCH_FLAGS=--recursive-includes contrib/coccinelle/xcalloc.cocci.patch

Thanks for digging here. I think it probably explains a lot of "wait,
why did this result change" head-scratching I did back when we started
batching a few years ago.

Is there any reason we wouldn't want --recursive-includes to be added to
the default SPATCH_FLAGS?

I suspect we'd still want to leave --all-includes there to get as much
type information as possible. If I understand correctly, the two are
orthogonal (one is "follow includes of includes" and the other is
"follow system includes in angle brackets").

Doing so doesn't seem to find any other missed entries in the current
codebase, but I'm pretty sure there are some it would have caught in a
less mysterious fashion over the years.

-Peff
