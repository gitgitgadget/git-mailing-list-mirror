Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973ECC636D3
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 18:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjBGSVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjBGSUf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 13:20:35 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1B93FF19
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 10:19:54 -0800 (PST)
Received: (qmail 11200 invoked by uid 109); 7 Feb 2023 18:19:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Feb 2023 18:19:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23192 invoked by uid 111); 7 Feb 2023 18:19:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Feb 2023 13:19:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Feb 2023 13:19:03 -0500
From:   Jeff King <peff@peff.net>
To:     demerphq <demerphq@gmail.com>
Cc:     "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Subject: Re: grep: fix multibyte regex handling under macOS
 (1819ad327b7a1f19540a819813b70a0e8a7f798f)
Message-ID: <Y+KWFyjTa8t5d5Q8@coredump.intra.peff.net>
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
 <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
 <Y9rv29c0dYUAYx8B@coredump.intra.peff.net>
 <CANgJU+XNLqf0E2+YC8yxtRPVh=mevc3P0eeye2_nx=ULB2iVWw@mail.gmail.com>
 <Y9098dyaTtiNk506@coredump.intra.peff.net>
 <CANgJU+UJ-p54MDmQWYTEsdh_ss-q8TUEcqHFm568Lpfsy2dU+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANgJU+UJ-p54MDmQWYTEsdh_ss-q8TUEcqHFm568Lpfsy2dU+w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 04, 2023 at 12:32:09PM +0100, demerphq wrote:

> > I think this is a perennial question for portable software: is it better
> > to be consistent across platforms (by shipping our own regex engine), or
> > consistent with other programs on the same platform (by using the system
> > regex).
> 
> Personally I think that while this seems to be an impartial reading of
> the question at hand I think it frames the debate in a way that has
> the potential to bias[1] the discussion in favour of a particular
> policy outcome[2]. It implies that all other things are equal between
> the two options presented, and frames the question as something that
> comes down to personal preference between one form of consistency and
> another.

Sorry, I didn't mean to imply one side or the other, or even that they
were equal. I more just meant: you can make arguments either way.

_I_ don't have a strong opinion there, but you have made many of those
arguments in your email. And everything you said was pretty sensible.

I did want to mention one thing, though:

> It also assumes that being consistent with other programs on
> the same platform is inherently beneficial, when that doesn't seem to
> be clearly established[2].

This isn't consistency per se, but one problem that arises when a
portable program ships its own implementation is that its implementation
sucks more than the system one. And that was the case with 1819ad327;
our compat/regex was worse than the system with respect to multi-byte
characters.

But yes, if your point is: "well, don't ship a crappy implementation",
then I agree that is a way to mitigate that problem. ;)

-Peff
