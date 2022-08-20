Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CCDC25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 06:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbiHTG6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 02:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245725AbiHTG6s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 02:58:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0663231EEB
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 23:58:46 -0700 (PDT)
Received: (qmail 21275 invoked by uid 109); 20 Aug 2022 06:58:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Aug 2022 06:58:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9249 invoked by uid 111); 20 Aug 2022 06:58:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 20 Aug 2022 02:58:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 20 Aug 2022 02:58:44 -0400
From:   Jeff King <peff@peff.net>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/6] xdiff: drop unused mmfile parameters from
 xdl_do_histogram_diff()
Message-ID: <YwCGJLJU2+ui+hvn@coredump.intra.peff.net>
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
 <Yv9OpXIQ9dYMQJ4B@coredump.intra.peff.net>
 <CAPoeCOa6BDsunamy7_GtaSy-gL_0r3kAwDJ7ffA_uiFUzhen9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPoeCOa6BDsunamy7_GtaSy-gL_0r3kAwDJ7ffA_uiFUzhen9w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 02:32:13PM +0100, Phillip Wood wrote:

> Thanks, I seem to have a blind spot for unused parameters (I think
> this is at least the third such fix from you for one of my commits),
> I'm really looking forward to having -Wunused-parameter enabled,
> thanks for working on it.

I think everyone does. ;) I know I couldn't have found these without
help from the compiler.

> Looking at the xpatience.c I think we can remove the mmfile_t
> parameters there as well, they are only end up being used because
> patience_diff() gets called recursively. I'm about to go off list for
> a week, but I can look at putting a patch together for that when I get
> back unless you want to.

I wondered that, too, but they also get passed in to fill_hashmap(),
which records the pointers in its "struct hashmap". It looks like those
fields are never accessed, though, and could even be removed from the
struct entirely!

So I think there is some room for cleanup.

-Peff
