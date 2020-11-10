Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF6CC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 18:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 500D020797
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 18:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgKJSBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 13:01:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:53080 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgKJSBx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 13:01:53 -0500
Received: (qmail 8515 invoked by uid 109); 10 Nov 2020 18:01:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 18:01:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3483 invoked by uid 111); 10 Nov 2020 18:01:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Nov 2020 13:01:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Nov 2020 13:01:51 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: ["BUG"] builtin add-interactive does not honor 'color.diff. frag'
Message-ID: <20201110180151.GA1362803@coredump.intra.peff.net>
References: <313B8999-1E99-4695-A20D-E48840C30879@gmail.com>
 <20201106170345.GA174555@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2011101653330.18437@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2011101653330.18437@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 10, 2020 at 05:06:59PM +0100, Johannes Schindelin wrote:

> > but that is missing another thing: for historical reasons we allow both
> > color.diff.frag and diff.color.frag. TBH, I wouldn't be too sad to see
> > us drop support for the historical versions in this setting. But it
> > makes me wonder if we could be reusing the parsing from
> > git_diff_basic_config(), which handles both cases.
> 
> Hmm. The Perl version uses the Git.pm's `get_color()` function, which in
> turn invokes `git config --get-color` with the exact keys I pasted above.
> 
> All along the way to `builtin/config.c`'s `git_get_color_config()`, I fail
> to see any `color.diff`/`diff.color` munging. So I believe that `git add
> --interactive` _never_ looked at the `diff.color` section to begin with.

Yeah, I think you're right. And I'm not too surprised. The same "I
wouldn't be too sad" probably applied back then, too.

Yep: https://lore.kernel.org/git/20071122122540.GH12913@sigill.intra.peff.net/

> > I'm not entirely clear on how add-interactive.c invokes the diff, and
> > whether it would be unhappy to pick up diff config. But it seems like
> > this:
> [...]
> 
> Hmm. I don't like it. So far, we were very careful to keep respecting
> `struct repository *r` in the built-in interactive add command. This would
> go the exact opposite way.
> 
> Combined with the fact that we never supported `diff.color.*` in the
> interactive add command anyway, I would rather continue with the first
> variant you presented.

Yeah, that seems quite sensible to me.

-Peff
