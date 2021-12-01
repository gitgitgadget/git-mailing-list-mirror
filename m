Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C79FC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 19:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbhLATtc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 14:49:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:41352 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230157AbhLATtb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 14:49:31 -0500
Received: (qmail 17420 invoked by uid 109); 1 Dec 2021 19:46:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Dec 2021 19:46:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9848 invoked by uid 111); 1 Dec 2021 19:46:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Dec 2021 14:46:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Dec 2021 14:46:08 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        me@ttaylorr.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/2] Set GIT_TRACE2_EVENT_NESTING in test-lib.sh
Message-ID: <YafRACXUuVLs5kX4@coredump.intra.peff.net>
References: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
 <YaUegEGxfAf72O9Z@coredump.intra.peff.net>
 <86555f24-e7c4-64cb-a55c-7e2580e895f2@gmail.com>
 <8c80be3d-7151-272c-dc42-377380bf9754@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c80be3d-7151-272c-dc42-377380bf9754@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 05:43:28PM -0500, Jeff Hostetler wrote:

> and yes, the addition of trace2 calls inside the progress code
> complicates the nesting.  I'm wondering if the progress code should
> always emit the trace2 events, regardless of whether the progress msg
> itself appears on the user's console.  That way we have consistent
> logging -- the whole point of adding the region in the progress
> code was to bracket the time spent doing the thing that needed
> progress messaging after all.  the fact that you don't have a console
> doesn't change the fact that there's an expensive computation there.

Yeah, that would at least make these things deterministic, and we'd
notice a nesting problem in the tests.

I do think bumping the default nesting level a few notches may be worth
it. Even if we didn't get rid of it entirely (and I am sympathetic to
the notion that recursive operations could produce gigantic logs), that
would give some headroom for reasonable levels of logging.

-Peff
