Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DEEC433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 09:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3F720772
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 09:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgHKJCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:02:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:54922 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbgHKJCq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 05:02:46 -0400
Received: (qmail 28473 invoked by uid 109); 11 Aug 2020 09:02:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Aug 2020 09:02:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14217 invoked by uid 111); 11 Aug 2020 09:02:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Aug 2020 05:02:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Aug 2020 05:02:45 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] init: disallow --separate-git-dir with bare repository
Message-ID: <20200811090245.GA2050353@coredump.intra.peff.net>
References: <20200809225316.19503-1-sunshine@sunshineco.com>
 <20200810095648.GA37030@coredump.intra.peff.net>
 <CAPig+cSMzEuMYNnHhMGwqGFgjWfX0+j1KoOSK8V7Wav97p+UVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSMzEuMYNnHhMGwqGFgjWfX0+j1KoOSK8V7Wav97p+UVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 01:44:00AM -0400, Eric Sunshine wrote:

> > I agree that it seems like nonsense. I'm a little curious what it
> > happens to do today, just because I'd wonder if it could possibly be of
> > any use to somebody.
> 
> The current behavior does some goofy stuff which I can't imagine being
> useful to anyone. For instance:
> [...]

OK, that's sufficiently brain-dead that I agree nobody will be sad to
see it go. Thanks for indulging me. :)

> > I think we'd clean up that detritus with our atexit handler, but I like
> > the extra check here. It lets us give a slightly more specific message
> > when we can catch it early ("these two options are incompatible").
> 
> With only the latter (after-the-fact) check:
> 
>     % git init --bare --separate-git-dir bar.git foo.git
>     fatal: --separate-git-dir incompatible with bare repository
>     % ls -1
>     foo.git
>     % ls -A foo.git/
>     %
> 
> It leaves the directory "foo.git" around, though the directory is
> empty. With the earlier check in place, it avoids leaving that empty
> directory.

Ah, right. git-clone has some magic auto-cleanup for signals/atexit, but
git-init does not.  It might be worth adding that, but it's definitely
outside the scope of your patch.

-Peff
