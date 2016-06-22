Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B07EF20189
	for <e@80x24.org>; Wed, 22 Jun 2016 19:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbcFVT7f (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 15:59:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:58741 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750787AbcFVT7f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 15:59:35 -0400
Received: (qmail 8233 invoked by uid 102); 22 Jun 2016 19:59:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Jun 2016 15:59:34 -0400
Received: (qmail 5115 invoked by uid 107); 22 Jun 2016 19:59:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Jun 2016 15:59:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jun 2016 15:59:32 -0400
Date:	Wed, 22 Jun 2016 15:59:32 -0400
From:	Jeff King <peff@peff.net>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Use docker for _some_ testing?
Message-ID: <20160622195932.GC1697@sigill.intra.peff.net>
References: <20160622190154.GA17442@duynguyen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160622190154.GA17442@duynguyen>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 22, 2016 at 09:01:55PM +0200, Duy Nguyen wrote:

> Which makes me think, could we use something like this to make sure
> people (on Linux) can test more obscure cases? Sometimes there are
> featues that require some dependencies that are not always present on
> the developer's machine (http server is a big one, locales come close
> second, then there will be lmdb and watchman in future...). With this,
> said developer can do a final test run in docker covering as much as
> possible.

Neat idea. This should also cover some other distro-specific issues like
"what's your /bin/sh look like", etc. It's a lighter-weight alternative
to testing alternate distros in a VM.

But I think most of the interesting cases are more exotic than
distro-to-distro. Things like HFS+ normalization, or weird shell
toolchains on proprietary Unixes (but maybe there are docker images for
those systems?).

So I dunno if it would prove that useful for day to day use or not.

> +ROOT="$(realpath $(git rev-parse --show-cdup))"

I tried running this as contrib/docker/run.sh, which complained here,
because --show-cdup is empty.

> +test "$(docker images --format='{{.Repository}}' $IMAGE)" = $IMAGE || \
> +	build_$DISTRO

My docker complained that it doesn't know --format. I guess I might just
have an old one (it's whatever is in Debian unstable, which is 1.8.3).

Not things you need to fix, but just comments for anybody else fiddling
with it.

-Peff
