Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEE8C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 02:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7064820674
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 02:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgKXCcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 21:32:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:39624 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgKXCcw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 21:32:52 -0500
Received: (qmail 30760 invoked by uid 109); 24 Nov 2020 02:32:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Nov 2020 02:32:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10533 invoked by uid 111); 24 Nov 2020 02:32:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Nov 2020 21:32:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Nov 2020 21:32:51 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alex Henrie <alexhenrie24@gmail.com>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Pick the right default and stop warn on `git pull`
Message-ID: <X7xw0xb9UnGKbS8m@coredump.intra.peff.net>
References: <20201123191355.GA132317@mit.edu>
 <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
 <20201123202003.GB132317@mit.edu>
 <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
 <X7wuMvHRURK1QS/Q@coredump.intra.peff.net>
 <CAMP44s0QOcMnYQqFFSE1jV_T6=e4=xTM0zr_06C6+aYb7oqb4A@mail.gmail.com>
 <X7xWSs3/vVqKl6sK@coredump.intra.peff.net>
 <CAMP44s1Z4tDXO4jstGMtYVOYzkQQnZMHp45pYPOimk+=jwFHcw@mail.gmail.com>
 <X7xgow4pchnhf2iY@coredump.intra.peff.net>
 <xmqqy2irjy4f.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2irjy4f.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 06:18:40PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Ah, that's what I was missing. I agree it would be nice for it to behave
> > consistently in both cases (though why one would set both pull.ff=only
> > and pull.rebase=true, I don't know).
> 
> So an obvious thing we could do, if pull.mode is too much of a
> change, is to make "pull --rebase" codepath honor pull.ff as well,
> perhaps?  I.e. those who set pull.ff=only are saying that "please
> stop me when I have any local change---I want to be notified if my
> pull on this branch results in anything but a fast-forward from the
> upstream".
> 
> And then making an unconfigured pull.ff to default to pull.ff=only
> may give a proper failure whether you merge or rebase.  I dunno.

Yeah, I would be perfectly happy with that (and it's in fact what I
_thought_ was happening before today's discussion).

I do wonder if anybody has set:

  pull.rebase=true
  pull.ff=only

which would then refuse to rebase at all, and whether they would be
annoyed. I am scratching my head over why one would do that, though. It
is meaningful only if you usually rebase, but when you say "--no-rebase"
you want to make sure you do not create a merge commit. Which seems
weird.

-Peff
