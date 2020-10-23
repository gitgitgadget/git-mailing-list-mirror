Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DA7C55178
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 08:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65ADC22253
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 08:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371980AbgJWICE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 04:02:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:40240 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S371865AbgJWICE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 04:02:04 -0400
Received: (qmail 26824 invoked by uid 109); 23 Oct 2020 08:02:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Oct 2020 08:02:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15175 invoked by uid 111); 23 Oct 2020 08:02:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Oct 2020 04:02:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Oct 2020 04:02:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2020, #03; Mon, 19)
Message-ID: <20201023080202.GA4012156@coredump.intra.peff.net>
References: <xmqqr1put77h.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1put77h.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 11:13:22AM -0700, Junio C Hamano wrote:

> * en/strmap (2020-10-13) 10 commits
>  - strmap: enable allocations to come from a mem_pool
>  - strmap: add a strset sub-type
>  - strmap: add functions facilitating use as a string->int map
>  - strmap: enable faster clearing and reusing of strmaps
>  - strmap: add more utility functions
>  - strmap: new utility functions
>  - hashmap: introduce a new hashmap_partial_clear()
>  - hashmap: allow re-use after hashmap_free()
>  - hashmap: adjust spacing to fix argument alignment
>  - hashmap: add usage documentation explaining hashmap_free[_entries]()
> 
>  A speciailization of hashmap that uses a string as key has been
>  introduced.  Hopefully it will see wider use over time.
> 
>  Will merge to 'next'.

I haven't gotten a chance to look at this carefully yet, but note that
the strset here sort-of conflicts with the one I added recently in
builtin/shortlog.c (already in master). I think the compiler won't
complain because they never show up in the same translation unit, but we
should avoid having two almost-the-same types in the codebase.

I suspect my "check_and_add" function could be folded into Elijah's
implementation. The other big difference is that mine uses the
FLEX_ALLOC approach, and his doesn't. I haven't digested the code and
discussion around that from Elijah's series yet.

-Peff
