Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE6FECAAD3
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 18:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiIKSbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 14:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiIKSbe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 14:31:34 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA5226578
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 11:31:32 -0700 (PDT)
Received: (qmail 22808 invoked by uid 109); 11 Sep 2022 18:31:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 11 Sep 2022 18:31:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5117 invoked by uid 111); 11 Sep 2022 18:31:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Sep 2022 14:31:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Sep 2022 14:31:31 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/18] make test "linting" more comprehensive
Message-ID: <Yx4pg2t6JXR+lsd4@coredump.intra.peff.net>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <Yx1x5lme2SGBjfia@coredump.intra.peff.net>
 <CAPig+cRJVn-mbA6-jOmNfDJtK_nX4ZTw+OcNShvvz8zcQYbCHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRJVn-mbA6-jOmNfDJtK_nX4ZTw+OcNShvvz8zcQYbCHQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 11, 2022 at 03:01:41AM -0400, Eric Sunshine wrote:

> > I wonder if color output for "# chainlint" and "?!" annotations would
> > help, too. It looks like that may be tricky, though, because the
> > annotations re-parsed internally in some cases.
> 
> I had the exact same thought about coloring the "# chainlint:" lines
> and "?!FOO?!" annotations, and how helpful that could be to anyone
> (not just newcomers). Aside from not having much free time these days,
> a big reason I didn't tackle it was because doing so properly probably
> means relying upon some third-party Perl module, and I intentionally
> wanted to keep the linter independent of add-on modules. Even without
> a "coloring" module of some sort, if Perl had a standard `curses`
> module (which it doesn't), then it would have been easy enough to ask
> `curses` for the proper color codes and apply them as needed. I'm
> old-school, so it doesn't appeal to me, but an alternative would be to
> assume it's safe to use ANSI color codes, but even that may have to be
> done carefully (i.e. checking TERM and accepting only some whitelisted
> entries, and worrying about about Windows consoles).

We're pretty happy to just use ANSI in the rest of Git, but there is a
complication on Windows. See compat/winansi.c where we decode those
internally into SetConsoleTextAttribute() calls.

I think we can live with it as-is for now and see how people react. If
lots of people are getting confused by the output, then that motivates
finding a solution. If not, then it's probably not worth the time.

-Peff
