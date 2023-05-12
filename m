Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AACC77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 21:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbjELVqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 17:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbjELVqU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 17:46:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0770C6A4F
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:46:19 -0700 (PDT)
Received: (qmail 14589 invoked by uid 109); 12 May 2023 21:46:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 May 2023 21:46:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26367 invoked by uid 111); 12 May 2023 21:46:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 May 2023 17:46:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 12 May 2023 17:46:18 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] builtin/pack-objects.c: introduce
 `pack.recentObjectsHook`
Message-ID: <20230512214618.GC2495860@coredump.intra.peff.net>
References: <cover.1683847221.git.me@ttaylorr.com>
 <2ce8a79fa4bf98947728da4e6e22304a2f203fac.1683847221.git.me@ttaylorr.com>
 <20230512212456.GA2495860@coredump.intra.peff.net>
 <ZF6xT34/Zq5pT9fG@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZF6xT34/Zq5pT9fG@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2023 at 05:36:15PM -0400, Taylor Blau wrote:

> > I suspect both could be fixed by having git-prune trigger the same
> > add_unseen_recent_objects_to_traversal() call either as part of
> > the perform_reachability_traversal() walk, or maybe in its own walk (I
> > think maybe it has to be its own because the second walk should avoid
> > complaining about missing objects).
> 
> I might be missing something, but I think we already (kind of) do the
> right thing here.
> 
> AFAICT, the path is:
> 
>   - cmd_prune()
>   - for_each_loose_file_in_objdir()
>   - prune_object() (as a callback to the above)
>   - is_object_reachable()
>   - perform_reachability_traversal()
>   - mark_reachable_objects()
>   - add_unseen_recent_objects_to_traversal()
> 
> That only happens when `mark_recent != 0`, though.

Yeah, I'm sorry, I was totally wrong here. See the mail I just sent that
crossed paths with yours.

-Peff
