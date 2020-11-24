Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CC2C63777
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 08:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE321206D9
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 08:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgKXIHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 03:07:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:39952 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbgKXIHW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 03:07:22 -0500
Received: (qmail 365 invoked by uid 109); 24 Nov 2020 08:07:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Nov 2020 08:07:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12363 invoked by uid 111); 24 Nov 2020 08:07:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Nov 2020 03:07:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Nov 2020 03:07:21 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alex Henrie <alexhenrie24@gmail.com>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Pick the right default and stop warn on `git pull`
Message-ID: <X7y/OdcoVnBeEVju@coredump.intra.peff.net>
References: <X7wuMvHRURK1QS/Q@coredump.intra.peff.net>
 <CAMP44s0QOcMnYQqFFSE1jV_T6=e4=xTM0zr_06C6+aYb7oqb4A@mail.gmail.com>
 <X7xWSs3/vVqKl6sK@coredump.intra.peff.net>
 <CAMP44s1Z4tDXO4jstGMtYVOYzkQQnZMHp45pYPOimk+=jwFHcw@mail.gmail.com>
 <X7xgow4pchnhf2iY@coredump.intra.peff.net>
 <xmqqy2irjy4f.fsf@gitster.c.googlers.com>
 <X7xw0xb9UnGKbS8m@coredump.intra.peff.net>
 <CAMP44s08mEyYqbjOeTeS46CngrbQMqP2=cMr1dtRLLk_BLAq3w@mail.gmail.com>
 <X7y0GbBQa0a5Alh0@coredump.intra.peff.net>
 <CAMP44s31OqnRnMO3bcO43VyUCP27o8UGPA5ognGi1s8Se+CRiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s31OqnRnMO3bcO43VyUCP27o8UGPA5ognGi1s8Se+CRiw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 01:48:56AM -0600, Felipe Contreras wrote:

> > Yep. After reading the first half of your mail, I started to respond
> > with the exact same thing. The key thing is letting the command-line
> > options override all of the related config. But I guess after reading to
> > the end that you don't actually like this. ;)
> 
> Yes, the command-line options should override the configuration, and
> the configuration should override the default.
> 
> I'm not sure what makes you think I wouldn't like that.

I think it's obvious that "--rebase" should override "pull.rebase". But
what I thought you were suggesting (and which I think is reasonable) is
for "--rebase" to affect pull.ff, as well. That's less clear (and
doesn't happen now), but I think could produce sensible semantics.

But it sounded like you thought that was too complicated.

> > I do agree it would be more clear in the long run with a single option
> > (config and command-line) that makes it clear the values are mutually
> > exclusive. I'm just not sure if it's painful to get there without
> > breaking compatibility or introducing confusion in the meantime.
> 
> I think it is possible. I did the patches several years ago. And I'm
> working on the patches right now. We'll see.

OK. Then I'm happy to wait and see.

> Well, in git-pull there's a callback called: parse_opt_rebase(), and
> if no argument is passed, then it returns REBASE_FALSE (0).
> 
> The rest of the code assumes 0 is no-rebase (i.e. merge).
> 
> There's no REBASE_UNSET.

Right, I meant that you would add one. But if you are pursuing the other
option, we can see how that goes.

-Peff
