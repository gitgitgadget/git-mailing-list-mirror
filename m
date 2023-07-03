Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D320EB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 05:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjGCFQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 01:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGCFQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 01:16:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C89A7
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 22:16:26 -0700 (PDT)
Received: (qmail 4980 invoked by uid 109); 3 Jul 2023 05:16:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 05:16:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2006 invoked by uid 111); 3 Jul 2023 05:16:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 01:16:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 01:16:25 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 03/16] ref-filter: clear reachable list pointers after
 freeing
Message-ID: <20230703051625.GC3502534@coredump.intra.peff.net>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <7e6bf7766d020914af53e7d6926f5a6c4c4d0668.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e6bf7766d020914af53e7d6926f5a6c4c4d0668.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 10:21:11AM -0400, Taylor Blau wrote:

> From: Jeff King <peff@peff.net>
> 
> In reach_filter(), we pop all commits from the reachable lists, leaving
> them empty. But because we're operating on a list pointer that was
> passed by value, the original filter.reachable_from pointer is left
> dangling.

Yep. This isn't a bug (yet) because nobody looks at the now-dangling
pointer. So as with the last patch, we're future-proofing ourselves
against dangerous situations.

-Peff
