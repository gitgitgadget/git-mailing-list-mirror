Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE69C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A25D611CB
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhECUYs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 16:24:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:43448 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhECUYs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 16:24:48 -0400
Received: (qmail 7407 invoked by uid 109); 3 May 2021 20:23:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 May 2021 20:23:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7140 invoked by uid 111); 3 May 2021 20:23:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 May 2021 16:23:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 May 2021 16:23:54 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/9] fsck_tree(): wrap some long lines
Message-ID: <YJBb2k4yUipefmzM@coredump.intra.peff.net>
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
 <YI12t5gzfzIxvZs3@coredump.intra.peff.net>
 <87v980vz2f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v980vz2f.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 03, 2021 at 01:22:13PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Sat, May 01 2021, Jeff King wrote:
> 
> > Many calls to report() in fsck_tree() are kept on a single line and are
> > quite long. Most were pretty big to begin with, but have gotten even
> > longer over the years as we've added more parameters. Let's accept the
> > churn of wrapping them in order to conform to our usual line limits.
> 
> If we're going to have the churn I'd say just wrap the rest of the file
> as well, now it's mostly-consistent in having these long lines.
> 
> FWIW I think having the long lines makes things more readable in this
> case, but the inconsistency is worse.

I'm not sure I agree. It depends on how big a chunk you consider for
consistency: a function, a file, or the whole project.

fsck_tree() was already inconsistent, so this is making that function
totally consistent. Since that was the function I was working in, that
seemed like the limit of "while I'm here", and I'd prefer to keep it
there for the series.

I certainly don't mind extra clean up on top, though.

As far as preferring the long lines, I don't mind lines a _little_ long,
but some of these are 120+ characters. They wrap awkwardly even on my
extra-wide terminals. ;) I guess we can have a discussion on whether
long lines are OK, but it should probably center on what we put into
CodingGuidelines, and not these particular lines.

> I wonder if this whole thing wouldn't be better by declaring the format
> in the msg_id_info struct. I.e. add this to fsck.h, but that's an even
> bigger change...

I think it gets tricky, as not all of the strings have the same number
and type of format specifiers (most don't have any, but verify_headers()
for example uses %ld).

-Peff
