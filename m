Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83723C56202
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 00:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4022420757
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 00:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbgKXAiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 19:38:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:39394 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729333AbgKXAiA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 19:38:00 -0500
Received: (qmail 29964 invoked by uid 109); 24 Nov 2020 00:37:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Nov 2020 00:37:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9532 invoked by uid 111); 24 Nov 2020 00:37:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Nov 2020 19:37:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Nov 2020 19:37:57 -0500
From:   Jeff King <peff@peff.net>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Pick the right default and stop warn on `git pull`
Message-ID: <X7xV5SyvCi3ojYz6@coredump.intra.peff.net>
References: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com>
 <CAMMLpeRLsE=zNDjCRKmEMFxJBYcnTOdDGxEL9cZuVhuDMF=sLg@mail.gmail.com>
 <20201123191355.GA132317@mit.edu>
 <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
 <20201123202003.GB132317@mit.edu>
 <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
 <X7wuMvHRURK1QS/Q@coredump.intra.peff.net>
 <CAMMLpeS2e2dFjPHC7N5O67QTo48cpvWEHiU8E55w9YYP4MU0MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMMLpeS2e2dFjPHC7N5O67QTo48cpvWEHiU8E55w9YYP4MU0MQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 03:03:07PM -0700, Alex Henrie wrote:

> > The default has continued to be merging. If we were going to switch that
> > to bailing out and doing nothing with a warning, I agree that doing so
> > only in the non-fast-forward case would be much better (because in that
> > case, all three modes have the same result).
> 
> I'd be fine with making fast-forward-only the default. But then again,
> some users like to set pull.ff=no, which creates a merge commit even
> when fast-forwarding is possible. The existence of that workflow might
> be a good reason to require the user to always be explicit.

Good point. I was thinking there was no option the users could set where
they'd be disappointed by a fast-forward, and for all other cases we'd
stop and ask the user to tell us more explicitly what they want. But
you're right that pull.ff=no is an exception there.

It might still be OK to allow it by default, though as we have always
allowed a fast-forward merge by default. So this would be a strict
tightening from the long-standing behavior of "if fast-forward, do that;
otherwise, merge" to "if fast-forward, do that; otherwise punt". Anybody
who wants pull.ff=no already had to configure it.

-Peff
