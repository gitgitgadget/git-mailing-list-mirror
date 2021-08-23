Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FDEC432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 16:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0B8613CD
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 16:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhHWQQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 12:16:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:56674 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhHWQQV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 12:16:21 -0400
Received: (qmail 11930 invoked by uid 109); 23 Aug 2021 16:15:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Aug 2021 16:15:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30114 invoked by uid 111); 23 Aug 2021 16:15:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Aug 2021 12:15:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Aug 2021 12:15:37 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] compat: let git_mmap use malloc(3) directly
Message-ID: <YSPJqc3vVa7ZX63m@coredump.intra.peff.net>
References: <9c2fe5de-be23-3e66-6edf-3c2edfb804f3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c2fe5de-be23-3e66-6edf-3c2edfb804f3@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 21, 2021 at 02:52:40PM +0200, René Scharfe wrote:

> xmalloc() dies on error, allows zero-sized allocations and enforces
> GIT_ALLOC_LIMIT for testing.  Our mmap replacement doesn't need any of
> that.  Let's cut out the wrapper, reject zero-sized requests as required
> by POSIX and use malloc(3) directly.  Allocation errors were needlessly
> handled by git_mmap() before; this code becomes reachable now.

Thanks, this is a good idea. As you note, the function was already
expecting a possible NULL return. And I think in general it's good for
our compat/ wrappers to stay as close to the OS-level functions they're
emulating as possible.

-Peff
