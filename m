Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFE3520195
	for <e@80x24.org>; Sun, 17 Jul 2016 06:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbcGQGpT (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 02:45:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:46100 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750892AbcGQGpR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 02:45:17 -0400
Received: (qmail 32357 invoked by uid 102); 17 Jul 2016 06:45:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 17 Jul 2016 02:45:18 -0400
Received: (qmail 29639 invoked by uid 107); 17 Jul 2016 06:45:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 17 Jul 2016 02:45:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Jul 2016 02:45:13 -0400
Date:	Sun, 17 Jul 2016 02:45:13 -0400
From:	Jeff King <peff@peff.net>
To:	mappu <mappu04@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: proposal: allow git clone for http-hosted bundles
Message-ID: <20160717064513.GA2049@sigill.intra.peff.net>
References: <2841ce89-9c46-c3f2-53d8-afef6e1e5b01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2841ce89-9c46-c3f2-53d8-afef6e1e5b01@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 17, 2016 at 04:41:54PM +1200, mappu wrote:

> Right now it's possible to git clone a repository over http, and git clone a
> bundle from the local filesystem, but it's not possible to git clone a
> bundle hosted on http.
> 
> Would it be possible to allow this in the future? Hopefully it's only a
> minor refactor in `builtin/clone.c`.

It's a bit more than a minor refactor. Long ago, I submitted

  http://thread.gmane.org/gmane.comp.version-control.git/185196

The tricky thing is having the http code handle the case that we get a
bundle when accessing the repository.

I think I got stalled in a "perfect is the enemy of the good" situation.
I wanted to clean up the patches to avoid spooling the bundle to disk
(because it means we temporarily required 2x disk space). But in
retrospect, it would be fine to start there, and if somebody wants to
take on resumable index-pack, that can be a separate topic.

So I never ended up getting back to it. And somehow almost 5 years have
passed yikes.

If anybody is interested in working on it, they can start from those
patches, or from the jk/bundle-fetch-wip branch at
https://github.com/peff/git. The latter has been continually rebased on
master for the past 5 years, _but_ in a fairly blind manner. I resolve
conflicts, but anything with "-wip" in the title is not part of my
regular build. So it has not been compiled nor had its tests run in all
that time. Caveat emptor.

> (Back story: I'm stuck with a git frontend that only ever calls `git clone
> ${target}` - that's Golang's `go get` - but bundles are a bit better fit for
> my request patterns than raw repositories).

You might do better to stick a shim script in your $PATH to just
intercept the calls to git. Hacky, but it would probably solve your
problem with a minimal amount of code.

-Peff
