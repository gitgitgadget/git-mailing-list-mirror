Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04670C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94AFC20878
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393424AbgJPUGn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 16:06:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:34760 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393421AbgJPUGn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 16:06:43 -0400
Received: (qmail 31570 invoked by uid 109); 16 Oct 2020 20:06:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Oct 2020 20:06:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12310 invoked by uid 111); 16 Oct 2020 20:06:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Oct 2020 16:06:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Oct 2020 16:06:42 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by
 substring/regex with --run
Message-ID: <20201016200642.GB3355643@coredump.intra.peff.net>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
 <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
 <20201014170413.GB21687@coredump.intra.peff.net>
 <xmqq1rhzihqa.fsf@gitster.c.googlers.com>
 <20201015194648.GB1490964@coredump.intra.peff.net>
 <xmqq7drrfe15.fsf@gitster.c.googlers.com>
 <20201016003847.GB2932796@coredump.intra.peff.net>
 <xmqq7drqdu2u.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7drqdu2u.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 16, 2020 at 09:16:57AM -0700, Junio C Hamano wrote:

> > I'm not sure where he suggests worse names. I'd think if anything we'd
> > have better names, because they'd be even more meaningful (if people
> > start using them for test selectors). FWIW, I also grep like that when
> > looking for scripts.
> 
> I didn't mean Jonathan suggested worse names.  Unlike "I don't tend
> to discover test scripts based on their filename", which was what
> Jonathan said, I do look for tests based on their filename, so
> having a good name matters (on the other hand, if you are the kind
> of person who does not look for them by name, the naming may not
> matter to you).

Ah, I misunderstood. Thanks for clarifying (and I am very much in your
camp that the names are useful).

> As long as it is known that "filesystem" and "update-ref" can serve
> as tokens to uniquely identify these two tests, it would be fine for
> my purpose.  But 0050 (under the rule that numbering must be unique)
> would give me such an assurance much better without having to look
> at any other test file.
> 
> The word "filesystem"?  Unless we have a rule that we can use each
> unique word in test names only once (which of course is impractical)
> I am not sure I can use it in place of 0050 without checking names
> of other tests first.

With your follow-up response:

> So if the rule is to always spell out the full name if I wanted
> uniqueness, then it would work.

I think we are on the same page, and my intent was to match full names.

So now you get "t0050" from some failed-test output (prove, or just the
output from make failing), and you copy it into the command-line to use
with "--test". And instead you'd just copy the full text name. It's a
little less convenient because t1234 is short enough that I'd type it,
and I'd probably cut-and-paste the text name. But other than that, I'd
expect the procedure to be the same.

The substring matches added by Elijah's series make sense for individual
test snippets within a script, I think. And I think we could even add
script-name matching now[1], without getting rid of the numbers. But if
we do so, we should be careful to introduce it as an anchored match and
not a substring match, to avoid having to switch it later.

-Peff

[1] And by "now" I don't mean we should hold up Elijah's patches for this
    feature, but that anybody who wishes to build it on top is free to
    do so without us having to make a decision on ditching the numbers
    entirely.
