Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6EDC2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 23:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BE72465B
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 23:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgA0XAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:00:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:45766 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726164AbgA0XAl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 18:00:41 -0500
Received: (qmail 4510 invoked by uid 109); 27 Jan 2020 23:00:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Jan 2020 23:00:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1778 invoked by uid 111); 27 Jan 2020 23:08:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Jan 2020 18:08:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Jan 2020 18:00:39 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: teach --single-branch and --branch during
 --recurse
Message-ID: <20200127230039.GA19360@coredump.intra.peff.net>
References: <20200108231900.192476-1-emilyshaffer@google.com>
 <20200109081150.GC3978837@coredump.intra.peff.net>
 <20200116223800.GM181522@google.com>
 <20200117210319.GA15460@coredump.intra.peff.net>
 <20200127222019.GA233139@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200127222019.GA233139@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 02:20:19PM -0800, Emily Shaffer wrote:

> > It would make more sense to me to either (or both):
> > 
> >   - make sure that .gitmodules has enough information about which branch
> >     to use for each submodule
> 
> Hum. I don't work with them day to day, but aren't we already in that
> state? Is that not what the 'branch' option for each submodule means?

Probably? :) I've never used the feature myself, but it does seem like
the right thing (and should definitely take precedence over any "-b"
option passed to the superproject).

> >   - offer an extra option for the default branch to use for any
> >     submodules. This is still not general enough to cover all situations
> >     (e.g., the bar/baz you showed above), but it at least makes it
> >     relatively easy to cover the simple cases, without breaking any
> >     existing ones.
> 
> Yeah, this is sort of the direction my mind went too - "not
> --branch recursively, but --submodule-branch". But that breaks down when you've
> got a nontrivial number of submodules, at which point you're gonna have
> a hard time unless you've got the .gitmodules configured correctly.

Right. Probably the right answer for that bar/baz case is to complain to
the superproject owner that they didn't put branch fields into their
.gitmodules. So...

> Well, as for this patch, let me try it with just --single-branch and see
> whether that works for the case the user reported. I can head back to
> the drawing board if not.

Yeah, that makes perfect sense to me.

-Peff
