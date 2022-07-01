Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58750C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 18:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiGASYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 14:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiGASYP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 14:24:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B581FCC2
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 11:24:14 -0700 (PDT)
Received: (qmail 9853 invoked by uid 109); 1 Jul 2022 18:24:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Jul 2022 18:24:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27686 invoked by uid 111); 1 Jul 2022 18:24:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Jul 2022 14:24:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Jul 2022 14:24:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/2] branch: drop unused worktrees variable
Message-ID: <Yr87zb6TBTYlwCrw@coredump.intra.peff.net>
References: <Yq6deQf96g8M5wdg@coredump.intra.peff.net>
 <Yq6eJFUPPTv/zc0o@coredump.intra.peff.net>
 <220620.865ykvw2l4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220620.865ykvw2l4.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 20, 2022 at 09:09:27PM +0200, Ævar Arnfjörð Bjarmason wrote:

> I.e. if we had a "foo(worktrees)" line before the "worktrees =
> get_worktrees()" we'd still remove these lines, but we don't want
> that. It just needs to do the appropriate cocci for "don't match it if
> you see this variable, unless the line matches...".
> 
> Of coures that only helps after your 1/2, so maybe there's not much
> value in it for your case, i.e. it won't be reaching across functions.

The cases that reach across functions are actually easier to find,
because the compiler knows that the function does not even look at its
parameter. And so you can remove it, and then remove it from the caller,
and so on.

Of course, that requires us to squash all of the -Wunused-parameter
noise. I've done that, but it's like 100 ugly patches. I haven't had the
time to polish it all up, but perhaps I'll at least send the start of
the transition soon.

-Peff
