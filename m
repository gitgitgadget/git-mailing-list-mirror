Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6793CC433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F173238D6
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgLGTBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:01:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:55182 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgLGTBq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 14:01:46 -0500
Received: (qmail 8925 invoked by uid 109); 7 Dec 2020 19:01:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Dec 2020 19:01:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25410 invoked by uid 111); 7 Dec 2020 19:01:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Dec 2020 14:01:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 7 Dec 2020 14:01:05 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 7/9] commit-graph: drop count_distinct_commits() function
Message-ID: <X8578ZoJKcGOC5Po@coredump.intra.peff.net>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
 <X8qGTaIdnNa5mAfC@coredump.intra.peff.net>
 <87sg8lxa1b.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sg8lxa1b.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 05, 2020 at 03:26:56AM +0100, Ævar Arnfjörð Bjarmason wrote:

> On Fri, Dec 04 2020, Jeff King wrote:
> 
> > When writing a commit graph, we collect a list of object ids in an
> > array, which we'll eventually copy into an array of "struct commit"
> > pointers. Before we do that, though, we count the number of distinct
> > commit entries. There's a subtle bug in this step, though.
> > [...]
> > -	display_progress(ctx->progress, 0); /* TODO: Measure QSORT() progress */
> > -	QSORT(ctx->oids.list, ctx->oids.nr, oid_compare);
> > [...]
> > +	QSORT(ctx->oids.list, ctx->oids.nr, oid_compare);
> 
> One thing your commit messag doesn't note is the removal of this
> TODO. Theoretically we still have the issue I noted in 890226ccb57
> (commit-graph write: add itermediate progress, 2019-01-19), in practice
> I think it's fine to just forever remove this TODO.

Yeah, I don't think we can really put progress bars on everything. If
you have a dataset so large that sorting the commits by oid takes a long
time, then I think you probably just need to accept that there are going
to be some small pauses while Git works.

-Peff
