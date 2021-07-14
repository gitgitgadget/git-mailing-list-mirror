Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD87C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707C0613C5
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbhGNQqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 12:46:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:49514 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238976AbhGNQqe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 12:46:34 -0400
Received: (qmail 28837 invoked by uid 109); 14 Jul 2021 16:43:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jul 2021 16:43:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25762 invoked by uid 111); 14 Jul 2021 16:43:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jul 2021 12:43:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Jul 2021 12:43:42 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 4/4] Bump rename limit defaults (yet again)
Message-ID: <YO8UPtFr4wRhVTXE@coredump.intra.peff.net>
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
 <8f1deb6dd16a0c0d88cf594d2019b3096dbe5383.1626225154.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f1deb6dd16a0c0d88cf594d2019b3096dbe5383.1626225154.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 01:12:33AM +0000, Elijah Newren via GitGitGadget wrote:

> The combined effect of the above is that the file size used in past
> calculations was likely about 5x too large.  Combine that with a CPU
> performance improvement of ~30%, and we can increase the limits by
> a factor of sqrt(5/(1-.3)) = 2.67, while keeping the original stated
> time limits.

It's slightly sad that we only got a 30% CPU improvement in the past 10
years. Are you just counting clock speed as a short-hand here? I think
that doesn't tell the whole story. But all of this is a side-note
anyway.  What I care about is your actual timings. :)

(It also seems like this rename detection is ripe for parallelization,
 but obviously that's a totally separate topic).

> Using the original time limit of 2s for diff.renameLimit, and bumping
> merge.renameLimit from 10s to 60s, I found the following timings using
> the simple script at the end of this commit message (on an AWS c5.xlarge
> which reports as "Intel(R) Xeon(R) Platinum 8124M CPU @ 3.00GHz"):
> 
>       N   Timing
>    1300    1.995s
>    7100   59.973s
> 
> So let's round down to nice even numbers and bump the limits from
> 400->1000, and from 1000->7000.

Sounds good. Thanks for thoroughly measuring and updating.

-Peff
