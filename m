Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B2CC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 04:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77FCD61042
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 04:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhJHEME (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 00:12:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:35568 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhJHEMD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 00:12:03 -0400
Received: (qmail 2728 invoked by uid 109); 8 Oct 2021 04:10:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Oct 2021 04:10:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30558 invoked by uid 111); 8 Oct 2021 04:10:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Oct 2021 00:10:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Oct 2021 00:10:07 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #02; Wed, 6)
Message-ID: <YV/EnxkTvWWZ6xVD@coredump.intra.peff.net>
References: <xmqqfstdr8b5.fsf@gitster.g>
 <YV5aaD418SyZqS/1@coredump.intra.peff.net>
 <YV5dmkkuCqAY2qqG@coredump.intra.peff.net>
 <87sfxdgtpu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sfxdgtpu.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 07, 2021 at 09:42:11AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Interesting mix...
> [...]
> ...of curl & wget :)

Heh, yeah, I noticed that, too. This is literally cut and paste from
coverity's "here's how to automate a scan" instructions, which yes, use
both tools. I don't think it's a big deal, but we could pretty easily
swap the wget invocation for curl.

> >   - any repo which wants to use this has to set up the secret token
> >     (COVERITY_SCAN_TOKEN here). That involves creating a coverity
> >     account, and then setting the token in the GitHub web interface.
> >     Presumably we'd just bail immediately if that token isn't set, so
> >     forks aside from git/git would have to enable it independently.
> 
> I tried creating one of these now, requested access at
> https://scan.coverity.com/projects/git & it's pending.

So that isn't actually my project. ;)

That's the old dead one that Stefan used to do builds for. Now I do have
access to that and saw your request, but it's not actually receiving new
builds.

I probably _could_ upload to that one, of course, but the builds I'm
doing are of my private topics.

My thinking was that if Junio is OK with it, we'd have this in the main
tree and the git/git ones would be the main builds.

> Sounds good, I wonder if they (if contacted) provide upon request some
> community-wide keys for projects such as git, so it would Just Work for
> forks without their owners needing to sign up themselves...

I get the impression that it's a fairly hefty CPU cost for something
they're offering for free, and they really don't want everybody's random
fork doing analyses. I.e., they'd rather see open source projects set up
an analysis project for their official tree and that's it.

OTOH, another concern of theirs is that the results aren't disclosed
publicly, since they may have security implications. But they've made it
easy enough for people to submit their random GitHub repositories, which
can contain anybody's code, so it doesn't seem like much of a secret.

So I dunno. They're nice enough to offer the service for free, and I
want to respect their wishes. But I'm having a hard-time finding
documents describing exactly what's OK and what's next with respect to
forks.

They do have some limits posted here:

  https://scan.coverity.com/faq#frequency

It's on the order of 3 builds per day for a code base of our size. Which
is plenty for our integration branches, but not enough to test every
topic branch. And though we could get around that with treating forks as
separate projects, I think that's violating the spirit of the limit.

-Peff
