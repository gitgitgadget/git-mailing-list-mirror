Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F12C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A684610A4
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbhIQWFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 18:05:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:50262 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234838AbhIQWFW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 18:05:22 -0400
Received: (qmail 13629 invoked by uid 109); 17 Sep 2021 22:03:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Sep 2021 22:03:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23028 invoked by uid 111); 17 Sep 2021 22:03:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Sep 2021 18:03:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Sep 2021 18:03:58 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com
Subject: Re: [PATCH 3/5] commit-graph: use parse_options_concat()
Message-ID: <YUUQzswYL5x74Tps@coredump.intra.peff.net>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <20210215184118.11306-4-avarab@gmail.com>
 <YCrCt8sEFJSPE+28@nand.local>
 <87czx1awwg.fsf@evledraar.gmail.com>
 <20210917211337.GC2118053@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210917211337.GC2118053@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 11:13:37PM +0200, SZEDER Gábor wrote:

> Worse, sometimes 'git commit-graph --progress ...' doesn't work as
> it's supposed to.  The patch below descibes the problem and fixes it,
> but on second thought I don't think that it is the right approach.
> 
> In general, even when all subcommands of a git command understand a
> particular --option, that does not mean that it's a good idea to teach
> that option to that git command.  E.g. what if we later add another
> subcommand for which that --option doesn't make any sense?  And from
> the quoted discussion above it seems that teaching 'git commit-graph'
> the '--progress' option was not intentional at all.
> 
> I'm inclined to think that '--progress' should rather be removed from
> the common 'git commit-graph' options; luckily it's not too late,
> because it hasn't been released yet.

I wasn't following this series closely, but having seen your fix below,
I'm inclined to agree with you. Just because we _can_ allow options
before or after sub-commands does not necessarily make it a good idea.

There is a distinct meaning to options before/after the command for the
base "git" command (e.g., "git -C foo branch" versus "git branch -C
foo"), and I think that has been useful overall.

>   ---  >8  ---
> 
> Subject: [PATCH] commit-graph: fix 'git commit-graph --[no-]progress ...'

This patch looks like a sensible fix if we don't simply remove the "git
commit-graph --progress write" version.

-Peff
