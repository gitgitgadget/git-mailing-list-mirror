Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97209C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 21:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 699F96146E
	for <git@archiver.kernel.org>; Mon, 10 May 2021 21:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhEJVdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 17:33:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:49766 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230248AbhEJVdU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 17:33:20 -0400
Received: (qmail 20004 invoked by uid 109); 10 May 2021 21:32:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 10 May 2021 21:32:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15396 invoked by uid 111); 10 May 2021 21:32:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 May 2021 17:32:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 May 2021 17:32:13 -0400
From:   Jeff King <peff@peff.net>
To:     Firmin Martin <firminmartin24@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v1 1/8] compat/terminal: let prompt accept input from pipe
Message-ID: <YJmmXZdwSoR+vxjw@coredump.intra.peff.net>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
 <20210506165102.123739-2-firminmartin24@gmail.com>
 <xmqqr1ijwi0i.fsf@gitster.g>
 <YJTH+sTP/O5Nxtp9@coredump.intra.peff.net>
 <875yzrgr1f.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875yzrgr1f.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 10, 2021 at 06:18:36AM +0200, Firmin Martin wrote:

> > Looking at the second patch, the motivation here seems to be to use
> > git_prompt() for another run-of-the-mill prompt. But the right answer
> > is: don't do that. In fact, we recently-ish removed a similar case in
> > 97387c8bdd (am: read interactive input from stdin, 2019-05-20) that was
> > likewise causing problems with the test suite.
> 
> I actually inspired myself from the two occurrences of git_prompt in
> builtin/bisect--helper.c introduced in 09535f056b (bisect--helper:
> reimplement `bisect_autostart` shell function in C, 2020-09-24).
> Not sure if they should also be converted to a simple fgets.

Yes, I think they should be switched.

It looks like since my earlier patches to "am" we have grown a
git_read_line_interactively() helper. See:

  https://lore.kernel.org/git/pull.755.git.git.1586374380709.gitgitgadget@gmail.com/

They should probably use that (and likewise, it would make sense for
git-am to switch to it).

> > I think we might consider renaming git_prompt(), or adding an
> > explanatory comment above it.
> 
> I would be happy to do that. A comment along the line of 97387c8bdd (am:
> read interactive input from stdin, 2019-05-20) and a "CAUTION: don't use
> it for regular prompt" would suffice ?

Yeah. You might want to point people at git_read_line_interactively() in
the same header file, too.

-Peff
