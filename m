Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C16C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 02:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E29B220728
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 02:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgKXCiY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 21:38:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:39642 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgKXCiY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 21:38:24 -0500
Received: (qmail 30797 invoked by uid 109); 24 Nov 2020 02:38:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Nov 2020 02:38:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10567 invoked by uid 111); 24 Nov 2020 02:38:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Nov 2020 21:38:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Nov 2020 21:38:23 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/7] t1300: test "set all" mode with value_regex
Message-ID: <X7xyHyFMU2E8cBCE@coredump.intra.peff.net>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <2da2131114eb47e70ccaf8fb9c51bf7fb5b173b0.1605801143.git.gitgitgadget@gmail.com>
 <xmqqo8jtvvby.fsf@gitster.c.googlers.com>
 <20201120183903.GA320614@coredump.intra.peff.net>
 <20201121222734.GG389879@camp.crustytoothpaste.net>
 <xmqqlfeuqd8d.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfeuqd8d.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 21, 2020 at 07:31:14PM -0800, Junio C Hamano wrote:

> >> So that got a bit off-track, but I think:
> >> 
> >>   - t1300 already is very much like this, so it's not a new thing
> >> 
> >>   - but I would be happy not to see it go further in that direction,
> >>     even if it means inconsistency with the rest of the script
> >
> > I agree we shouldn't make things worse.
> 
> I started looking at early parts of t1300 and here is how far I
> managed to get before I can no longer keep staring the existing
> tests without vomitting.

I think my similar gastric reaction is what caused me to stop looking at
it long ago. But it may also have been the test brian mentioned that
explicitly checks that this case works (and for which he had to set SHA1
prereq).

> I am reasonably happy with the "let's keep the vanilla untouched one
> in .git/config-initial, refrain from using [core] and other sections
> that MUST be in the initial configuration for testing, and use a
> wrapper that reads expected addition to the initial one from the
> standard input for validation" approach I came up with, but I am not
> happy with the name 'compare_expect'; 'validate_config_result' might
> be a better name.

IMHO this is worse than just using "config --file" in most of the tests.
It's more steps to remember to deal with. And most tests do not care at
all what the source file is. There are a few that check the order of
lookup with respect to system and user files, but they could probably be
run what non-destructive changes.

That said, most of the effort is in the tedium of switching each
individual test. I am happy for whoever volunteers to do that work to
have the final say in the approach.

-Peff
