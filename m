Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24274C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 06:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB9E12076E
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 06:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgHEGhF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:37:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:48730 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHEGhF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 02:37:05 -0400
Received: (qmail 9094 invoked by uid 109); 5 Aug 2020 06:37:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Aug 2020 06:37:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20412 invoked by uid 111); 5 Aug 2020 06:37:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Aug 2020 02:37:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Aug 2020 02:37:04 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: avoiding fetching specific refs from a remote
Message-ID: <20200805063704.GA2690083@coredump.intra.peff.net>
References: <CA+P7+xpokJ3Z4xZ9ibCBpBO65D1v-AD6_JknprGUsEDxEvMGGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xpokJ3Z4xZ9ibCBpBO65D1v-AD6_JknprGUsEDxEvMGGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 04, 2020 at 02:53:30PM -0700, Jacob Keller wrote:

> This results in the annoying completion behavior where:
> 
> $git checkout ma<TAB>
> main
> master
> 
> Essentially, because both main and master have similar names, tab
> completion requires remembering to type one additional character than
> I am used to.

Heh, I didn't think anybody considered that implication so far; the fact
that they were similar names has generally been considered a positive. I
agree it would be annoying.

> I'd like to be able to customize my pull so that I either (a) exclude
> the reference when performing a fetch, or (b) exclude the reference
> when tab completing.

Not quite (b), but if you:

  - delete any local "master" branch, if you haven't already

  - set $GIT_COMPLETION_CHECKOUT_NO_GUESS to "1"

then it shouldn't complete "master". The second is necessary because
we'd try to complete the magic "git checkout master" that auto-creates
the branch from the remote version.

> something like adding a remote.<name>.excludeRefs which would allow
> specifying a set of references to exclude from matching the refspec..
> 
> I realize I could customize the refspec to list the set of things I
> want, but then I would miss any potential future branches until I
> updated my remote config again.

This is definitely a reasonable thing to want, and it has come up off
and on over the years. One search term for the list archive is "negative
refspecs", though it turns up a lot of useless hits when the two words
are not directly adjacent.

This old thread might be worth reading:

  https://lore.kernel.org/git/20140124090104.GA396@x4/

and there is even a patch in there:

  https://lore.kernel.org/git/20140125013433.GA22336@sigill.intra.peff.net/

but I didn't go over it carefully enough to know whether it is utter
trash, or something that could be used as a starting point.

-Peff
