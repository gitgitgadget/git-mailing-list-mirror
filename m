Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0815FC2D0E4
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 01:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B882220B
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 01:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgKRBZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 20:25:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:33302 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgKRBZp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 20:25:45 -0500
Received: (qmail 19948 invoked by uid 109); 18 Nov 2020 01:25:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Nov 2020 01:25:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7095 invoked by uid 111); 18 Nov 2020 01:25:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Nov 2020 20:25:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Nov 2020 20:25:44 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/28] Use main as default branch name
Message-ID: <20201118012544.GC650959@coredump.intra.peff.net>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org>
 <CAMP44s2VJOd3N2zaj8YPv0iLOqTF7vWyZ=zPd9vd0+qO1DbEVA@mail.gmail.com>
 <20201117233313.GB642410@coredump.intra.peff.net>
 <xmqqr1or4jen.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1or4jen.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 04:07:28PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think Eric's suggestion of using the directory name as a default was
> > not previously mentioned. I'm not sure I would like that myself (I find
> > value in having a consistent "this is the main branch" name across
> > different repositories, at least for my workflows). And it creates all
> > of the same "every tutorial is now out of date" issues. But it is
> > neutral. I wouldn't be opposed to seeing it as a configurable option.
> 
> I actually recall hearing it from Eric, not on this list, directly
> back in the timeframe of these previous dicsussions.  I somehow
> thought I relayed it to the community, perhaps #git-devel on
> freenode, but apparently not to this list.

Could be. I don't keep up with the irc logs.

> Yes, init.defaultBranchName is defined to be a string, so it is a
> bit tricky to introduce special values that mean "no, not a
> hardcoded value but derive dynamically based on X".  Perhaps use a
> prefix that is not allowed in a refname, perhaps like this update to
> the function that uses the value read from the init.defaultBranch
> configuration variable.

Yeah, I restrained myself from getting too far into thinking about
syntax, but I agree we'd want something like that. It might also be OK
to use something that's extremely unlikely to be a default branch name
(like BASENAME), but the ":" syntax you have here isn't bad. Yet another
option is a separate variable (that if set means we do not look at
init.defaultBranch at all).

IMHO, though, all of this is orthogonal to question of what the default
is. Unless we are thinking the basename thing would work as a default,
but I don't think that resolves any of the backwards-compatibility
concerns.

-Peff
