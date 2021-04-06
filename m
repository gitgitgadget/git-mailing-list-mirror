Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57166C433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 22:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22AD8613D2
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 22:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344099AbhDFWre (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 18:47:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:42996 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244004AbhDFWre (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 18:47:34 -0400
Received: (qmail 9612 invoked by uid 109); 6 Apr 2021 22:47:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Apr 2021 22:47:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 898 invoked by uid 111); 6 Apr 2021 22:47:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Apr 2021 18:47:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Apr 2021 18:47:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nikita Bobko <nikitabobko@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [Bug report] diff.noprefix config is ignored for interactive
 `add`
Message-ID: <YGzk/C9V3jkPr3xo@coredump.intra.peff.net>
References: <CAMJzOtyzu8y5mWdKXe3MPe8ZoJs8O=me8Xuu0t77YVdAMc7Tgg@mail.gmail.com>
 <YGzUerPL7V8jDxHo@coredump.intra.peff.net>
 <xmqqsg4313fp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsg4313fp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 06, 2021 at 02:57:46PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I imagine something like this:
> > ...
> > would work, but I didn't really test it. There's another hitch, which is
> > that this subsystem has all been re-written in C. So we'd really want to
> > implement it in the new code (possibly in both places, though maybe it
> > is time to consider cutting over from the perl script to the C one by
> > deafult?).
> >
> > But hopefully this illustrates the general idea, and gives somebody
> > interested in the feature enough to work up their own patch.
> 
> These "cosmetic appearance" configuration that would affect the
> output from diff shown to the user would not be limited to just the
> .noprefix, though.  Depending on the users, they would care just as
> deeply about any of these:
> 
> 	.context
> 	.interHunkContext
> 	.mnemonicPrefix
>         .noprefix
> 	.relative
> 	.orderFile
> 
> as Nikita does for .noprefix to send a bug report.
> 
> Luckily or unluckily, .suppressBlankEmpty and the per-filetype
> .xfuncname patterns do impact the output from the plumbing, because
> git_diff_basic_config() does read them, even though they are merely
> "cosmetic" configurations.
> 
> I am unsure how much we should cater to end-user controlled
> configuration when we are generating diff output for our own
> consumption, but if we were to tweak "add -p" and friends to
> pay attention to .noprefix, we probably should do the same for
> all the others.

Yes. We already have gone through this with other options (e.g.,
diff.algorithm). I would be happy if somebody wanted to handle the
complete set. But I am also OK with stumbling towards completeness, as
people who care about a particular option plumb it through.

-Peff
