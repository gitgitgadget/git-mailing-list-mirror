Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7263AC4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 22:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbiK2WO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 17:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbiK2WOY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 17:14:24 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE9924F0C
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 14:14:24 -0800 (PST)
Received: (qmail 14828 invoked by uid 109); 29 Nov 2022 22:14:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Nov 2022 22:14:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24335 invoked by uid 111); 29 Nov 2022 22:14:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Nov 2022 17:14:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Nov 2022 17:14:22 -0500
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git port to Debian SH4 may have trouble
Message-ID: <Y4aEPpQsS8QxBYly@coredump.intra.peff.net>
References: <CAH8yC8niurChnXPrZSeBa7g1z5AF3PqYdf1X0Rm03rDanec6Gw@mail.gmail.com>
 <Y4ZXRx4mf0UMk4H6@coredump.intra.peff.net>
 <CAH8yC8=zv30qNKVGZcT02hfTWgn4x1RCEUioB=jG9yq9X_Qp=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8=zv30qNKVGZcT02hfTWgn4x1RCEUioB=jG9yq9X_Qp=g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2022 at 04:49:30PM -0500, Jeffrey Walton wrote:

> > Just a hunch, but does:
> >
> >   git config --global pack.threads 1
> >
> > help? The delta resolution is multi-threaded, but nothing else in the
> > clone should be.
> 
> Yes, `git config --global pack.threads 1` allowed things to continue.
> The check-out was successful.

OK, that narrows it down. The question then is why threads don't work.
Is there something broken with threading or luck primitives on that
platform? Or are we doing something sketchy with concurrency that
happens to work on Intel but not elsewhere, and we end up in some kind
of deadlock?

I suspect if we want to know more, you'd need to use gdb to grab a
backtrace for each of the threads during the hang to see what they're
trying to do.

-Peff
