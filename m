Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF2A11F45F
	for <e@80x24.org>; Wed,  8 May 2019 08:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfEHIj3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 8 May 2019 04:39:29 -0400
Received: from mx1.volatile.bz ([185.163.46.97]:36566 "EHLO mx1.volatile.bz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfEHIj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 04:39:29 -0400
Received: from clamav.local (unknown [198.18.45.2])
        by mx1.volatile.bz (Postfix) with ESMTPSA id 56F692986;
        Wed,  8 May 2019 08:39:26 +0000 (UTC)
Date:   Wed, 8 May 2019 08:39:17 +0000
From:   opal hart <opal@wowana.me>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Cannot access git-scm.com with Tor
Message-ID: <20190508083917.50f2cf59@clamav.local>
In-Reply-To: <20190507073322.GD28060@sigill.intra.peff.net>
References: <20190507070028.54c291af@clamav.local>
        <20190507073322.GD28060@sigill.intra.peff.net>
Organization: Volatile
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-alpine-linux-musl)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MC-Transport: 185.163.46.97 to 209.132.180.67 on Wed May  8 11:39:29 2019 +0300 (EEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 7 May 2019 03:33:22 -0400
Jeff King <peff@peff.net> wrote:

> The "security settings" toggle for the site on Cloudflare is already set
> to "low", and there are no other restrictions. Is it actually blocking?
> Or is it asking for a CAPTCHA?

Sorry, it is indeed asking for a CAPTCHA. Google reCAPTCHA does not do
a great job at accomodating Tor users; it effectively blocks us with an
endless barrage of puzzles unless we log in to a Google account.

> I can drop it to "essentially off". I don't think the site is very high
> risk.  The site is _basically_[1] serving up static content (which isn't
> to say there couldn't be some attack against the rails infrastructure,
> but it's not like people are logging in, or that there's any non-public
> data on the site).

> Using Cloudflare or some other caching layer is a necessity. We serve
> about 50-60GB of traffic daily, over 98% of which is cached.

That's fine to use it as a CDN/cache; setting the site protection to
"essentially off" should indeed help. For whatever reason, Cloudflare
still isn't smart enough to allow greylisted IP addresses during times
of low/no abuse -- either that or a lot of people use CF with the
misconception that it's for anti-spam on blogs and forums, so it's
easier to just block Tor. CF representatives have been involved in
public discussions elsewhere, claiming they are working to improve the
experience for Tor Browser users, but these discussions have been going
on for years now, so I wouldn't hold my breath. That's why I have to
make webmasters aware of this, because not everyone realises how
inaccessible the web becomes for people who use Tor. Personally I use
it although I'm in a relatively free country, but there are others who
use it to escape censorship. And when services like Cloudflare
inadvertently act as censors, it defeats the purpose of Tor for this
group of people.

> The load
> was quite high when the caching was all done at the Rails layer (though
> I wouldn't rule out that there are ways to configure Rails to make this
> more optimal; none of the people active in maintaining the site is
> particularly knowledgeable there).

Yeah, if caching *is* handled directly on git-scm's side, I would
recommend something more suited for caching such as Varnish or
memcached (depending on the type of caching you're doing). Personally I
use memcached on a Tor hidden service I host and it seems to cut down
on server pressure from bot requests. This is why I even suggest to
webmasters to reconsider their use of CF; I'm not naïve and I do have
some experience with handling webserver abuse. But again, I won't argue
if the site genuinely benefits from using CF as a CDN.

> [1] It actually could be a static site entirely; there was some push in
>     that direction a while ago, but there's a lot of tedious work that
>     never got finished. Of course, we'd still need a caching layer.

It is indeed a lot of effort to change a site's inner workings. I'm
glad that this possibility is at least considered and I hope it's an
accomplishable goal in the future. It'd be nice to see the web revert
to its more static, sustainable days.

-- 
wowaname <https://wowana.me/pgp>
