Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68DAA1FC43
	for <e@80x24.org>; Sun, 12 Mar 2017 11:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755725AbdCLLUU (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 07:20:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:42786 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755704AbdCLLUT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 07:20:19 -0400
Received: (qmail 24634 invoked by uid 109); 12 Mar 2017 11:19:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 11:19:55 +0000
Received: (qmail 12055 invoked by uid 111); 12 Mar 2017 11:20:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 07:20:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Mar 2017 07:19:52 -0400
Date:   Sun, 12 Mar 2017 07:19:52 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jake Goulding <goulding@vivisimo.com>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] tag: Implicitly supply --list given another list-like
 option
Message-ID: <20170312111952.ryhkkrgldub26qky@sigill.intra.peff.net>
References: <20170310124247.jvrmmcz2pbv4qf3o@sigill.intra.peff.net>
 <20170311120855.16756-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170311120855.16756-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 11, 2017 at 12:08:55PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Jeff King pointed out in
> <20170310124247.jvrmmcz2pbv4qf3o@sigill.intra.peff.net> in reply to
> that::
> 
>     The difference between "branch" and "tag" here is that "branch
>     --contains" implies "--list" (and the argument becomes a pattern).
>     Whereas "tag --contains" just detects the situation and complains.
> 
>     If anything, I'd think we would consider teaching "tag" to behave
>     more like "branch".
> 
> I agree. This change does that, the only tests that broke as a result
> of this were tests that were explicitly checking that this
> "branch-like" usage wasn't permitted, i.e. no actual breakages
> occurred, and I can't imagine an invocation that would negatively
> impact backwards compatibility, i.e. these invocations all just
> errored out before.

Trying to think of counter-arguments, the best I could come up with is
that the situation is potentially ambiguous, and some user could be
confused by us doing the wrong thing. I don't find that particularly
compelling, especially as the "wrong thing" is to list tags, which is
not a destructive operation.

So I think this is an improvement. As for the patch itself:

> +	/* We implicitly supply --list with --contains, --points-at,
> +	   --merged and --no-merged, just like git-branch */
> +	if (filter.with_commit || filter.points_at.nr || filter.merge_commit)
> +		cmdmode = 'l';

I was about to complain that this needs "!cmdmode", but I just looked
forward in the thread and saw that Junio already covered that in more
detail. I concur.

Thanks for working on this.

-Peff
