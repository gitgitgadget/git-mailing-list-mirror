Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376D1C636D3
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 18:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjBGSYo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjBGSY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 13:24:29 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA423EC65
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 10:23:27 -0800 (PST)
Received: (qmail 11211 invoked by uid 109); 7 Feb 2023 18:23:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Feb 2023 18:23:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23258 invoked by uid 111); 7 Feb 2023 18:23:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Feb 2023 13:23:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Feb 2023 13:23:07 -0500
From:   Jeff King <peff@peff.net>
To:     "D. Ben Knoble" <ben.knoble@gmail.com>
Cc:     demerphq <demerphq@gmail.com>, git@vger.kernel.org
Subject: Re: grep: fix multibyte regex handling under macOS
 (1819ad327b7a1f19540a819813b70a0e8a7f798f)
Message-ID: <Y+KXC5b0qUg2/nxt@coredump.intra.peff.net>
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
 <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
 <Y9rv29c0dYUAYx8B@coredump.intra.peff.net>
 <CANgJU+XNLqf0E2+YC8yxtRPVh=mevc3P0eeye2_nx=ULB2iVWw@mail.gmail.com>
 <Y9098dyaTtiNk506@coredump.intra.peff.net>
 <CANgJU+UJ-p54MDmQWYTEsdh_ss-q8TUEcqHFm568Lpfsy2dU+w@mail.gmail.com>
 <CALnO6CC2w5LUAjXVw7CWKAVobjFMc7M7jm7HuuGT1SO0q5cYbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALnO6CC2w5LUAjXVw7CWKAVobjFMc7M7jm7HuuGT1SO0q5cYbA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 05, 2023 at 02:51:05PM -0500, D. Ben Knoble wrote:

> Any thoughts on some sort of stop-gap measure to fix --word-diff while
> Git decides how to handle the regex engine incompatibilities? How
> important is the sequence of bytes at the end of --word-diff regexes
> in userdiff.c?

It comes from 664d44ee7f (userdiff: simplify word-diff safeguard,
2011-01-11). So presumably we'd want to figure out a way to accomplish
the same thing in a portable way. I'm not sure that's possible, though,
without making assumptions about the regex engine.

There's a little more discussion in the original thread:

  https://lore.kernel.org/git/561247.22837.qm@web110707.mail.gq1.yahoo.com/

but I didn't read it very carefully.

It may also be possible to play tricks with LC_CTYPE (either not setting
it, or resetting before/after a regex), but that feels pretty hacky.

-Peff
