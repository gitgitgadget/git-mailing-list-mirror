Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68572EB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjGCG14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjGCG1v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:27:51 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A95C4
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:27:50 -0700 (PDT)
Received: (qmail 12268 invoked by uid 109); 3 Jul 2023 06:27:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:27:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2483 invoked by uid 111); 3 Jul 2023 06:27:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:27:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:27:48 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 16/16] ls-refs.c: avoid enumerating hidden refs where
 possible
Message-ID: <20230703062748.GJ3502534@coredump.intra.peff.net>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <ea6cbaf292f59c96bedc304c74a36fe1c53c1c6d.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea6cbaf292f59c96bedc304c74a36fe1c53c1c6d.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 10:22:22AM -0400, Taylor Blau wrote:

> In a similar fashion as in previous commits, teach `ls-refs` to avoid
> enumerating hidden references where possible.
> 
> As before, this is linux.git with one hidden reference per commit.
> 
>     $ hyperfine -L v ,.compile 'git{v} -c protocol.version=2 ls-remote .'
>     Benchmark 1: git -c protocol.version=2 ls-remote .
>       Time (mean ± σ):      89.8 ms ±   0.6 ms    [User: 84.3 ms, System: 5.7 ms]
>       Range (min … max):    88.8 ms …  91.3 ms    32 runs
> 
>     Benchmark 2: git.compile -c protocol.version=2 ls-remote .
>       Time (mean ± σ):       6.5 ms ±   0.1 ms    [User: 2.4 ms, System: 4.3 ms]
>       Range (min … max):     6.2 ms …   8.3 ms    397 runs

Very nice. I think this may have big real-world consequences for certain
repositories on forges (where they may accrue a large number of hidden
metadata like refs/pull).

-Peff
