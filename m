Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A913C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 12:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbiHIM4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 08:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243332AbiHIMz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 08:55:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BBCC18
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 05:55:54 -0700 (PDT)
Received: (qmail 30680 invoked by uid 109); 9 Aug 2022 12:55:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Aug 2022 12:55:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2027 invoked by uid 111); 9 Aug 2022 12:55:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Aug 2022 08:55:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Aug 2022 08:55:53 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Noneman <emily.noneman@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Paul Horn <git@knutwalker.engineer>
Subject: Re: [PATCH] revision.c: set-up "index_state.repo", don't segfault in
 pack-objects
Message-ID: <YvJZWUVULB5Y8zih@coredump.intra.peff.net>
References: <CAKvVO18RVye=PkBRv=trj2GHh8ccGKL5j0mMq2eHQ1SX=wsr8A@mail.gmail.com>
 <patch-1.1-3ff17707481-20220805T141816Z-avarab@gmail.com>
 <b6299f8a-f75a-0e96-a6a6-55a7280584bf@github.com>
 <Yu02dOo4G8sy8tI6@coredump.intra.peff.net>
 <xmqqo7wyzlpm.fsf@gitster.g>
 <CAKvVO18Du5M6broAJ6WqTAk6C4jxtqbXoS=9x03JgSdJAak80Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKvVO18Du5M6broAJ6WqTAk6C4jxtqbXoS=9x03JgSdJAak80Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 08, 2022 at 02:15:21PM -0400, Emily Noneman wrote:

> The latest changes seem to have resolved the issue for me. My repo was
> a bit different than Pauls, it's a big corporate repo with a partial
> checkout and a worktree. What's confusing is that I do see an "index"
> file in worktrees/NetLedger_GitRepo , but git 2.37.1 exhibits the
> crash. 2.37.1.377.g679aad9e82 works just fine.

Thanks for testing. It is odd that you see an "index" file, since the
code change is definitely focused around getting ENOENT from open() on
the index. Is it possible that you have another worktree (even the
initial one) without an index in it?

-Peff
