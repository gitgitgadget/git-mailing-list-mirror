Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DA5C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 07:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiGLHT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 03:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiGLHTY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 03:19:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274FAE093
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 00:19:24 -0700 (PDT)
Received: (qmail 10548 invoked by uid 109); 12 Jul 2022 07:19:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jul 2022 07:19:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27926 invoked by uid 111); 12 Jul 2022 07:19:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jul 2022 03:19:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jul 2022 03:19:22 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] xdiff: introduce XDL_ALLOC_GROW()
Message-ID: <Ys0gerokoiLC9llA@coredump.intra.peff.net>
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
 <pull.1272.v2.git.1657297519.gitgitgadget@gmail.com>
 <8c24cd7737b29d461788b71f6a94eb74c468ad33.1657297520.git.gitgitgadget@gmail.com>
 <220709.86v8s78chj.gmgdl@evledraar.gmail.com>
 <bb1c85e4-50be-04a5-3c9f-f4c4dab6a50e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb1c85e4-50be-04a5-3c9f-f4c4dab6a50e@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 11, 2022 at 11:00:06AM +0100, Phillip Wood wrote:

> > But you've also changed every single callsite anyway.
> > 
> > So why not just change:
> > 
> >      if (XDL_ALLOC_GROW(recs, ...))
> > 
> > To:
> > 
> >      XDL_ALLOC_GROW(recs, ...);
> >      if (!recs)
> 
> Because I think it's ugly, we'd never define a function as void(int* result,
> args...) and I don't think we should do that for a macro where we can avoid
> it. The existing ALLOC_* macros make sense as statements because they die on
> failure.

Those macros are already unlike functions, though. They take a variable
_name_, not a pointer to a variable, and assign to it. A version which
looked like a function would have to be:

  if (XDL_ALLOC_GROW(&recs, ...))

So in my head I read them as assignment statements already, making the
expression-like form a bit jarring.

Just my two cents. I don't care _too_ much either way, but I'd probably
be swayed if one implementation is much simpler than the other.

-Peff
