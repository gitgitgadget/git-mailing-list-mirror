Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48944C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 04:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DF964F41
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 04:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhBCEhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 23:37:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:45642 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230085AbhBCEhE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 23:37:04 -0500
Received: (qmail 17552 invoked by uid 109); 3 Feb 2021 04:36:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Feb 2021 04:36:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12062 invoked by uid 111); 3 Feb 2021 04:36:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Feb 2021 23:36:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Feb 2021 23:36:21 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 09/14] simple-ipc: add t/helper/test-simple-ipc and
 t0052
Message-ID: <YBooReQcjsi41VsA@coredump.intra.peff.net>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <f0bebf1cdb31f94cb111df100b3bcb5e2d93a91e.1612208747.git.gitgitgadget@gmail.com>
 <20210202213523.GD2091@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210202213523.GD2091@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 02, 2021 at 10:35:23PM +0100, SZEDER Gábor wrote:

> > +test_expect_success 'start simple command server' '
> > +	{ test-tool simple-ipc daemon --threads=8 & } &&
> > +	SIMPLE_IPC_PID=$! &&
> > +	test_atexit stop_simple_IPC_server &&
> > +
> > +	sleep 1 &&
> 
> This will certainly lead to occasional failures when the daemon takes
> longer than that mere 1 second delay under heavy load or in CI jobs.

Yeah. The robust thing is to have the server indicate when it's ready to
receive requests. There's some prior art in t/lib-git-daemon.sh using a
fifo to get a line to the caller. It's ugly, but AFAIK pretty
bulletproof.

-Peff
