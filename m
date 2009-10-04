Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-0.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 11002 invoked by uid 107); 4 Oct 2009 13:38:33 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 09:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128AbZJDNeM (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 09:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755951AbZJDNeM
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 09:34:12 -0400
Received: from peff.net ([208.65.91.99]:50756 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754113AbZJDNeL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 09:34:11 -0400
Received: (qmail 10990 invoked by uid 107); 4 Oct 2009 13:37:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 04 Oct 2009 09:37:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Oct 2009 09:33:33 -0400
Date:	Sun, 4 Oct 2009 09:33:33 -0400
From:	Jeff King <peff@peff.net>
To:	Petter Urkedal <urkedal@nbi.dk>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] Reserve a slot for argv[0] in default_arg.
Message-ID: <20091004133333.GA13894@sigill.intra.peff.net>
References: <1254576571-29274-1-git-send-email-urkedal@nbi.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1254576571-29274-1-git-send-email-urkedal@nbi.dk>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Oct 03, 2009 at 03:29:31PM +0200, Petter Urkedal wrote:

> Setting "av" to one slot before the allocated "default_arg" array causes
> glibc abort with "free(): invalid next size (normal)" in some
> configurations (Gentoo, glibc-2.9_p20081201-r2, gcc-5.3.2 with PIE).

Thanks, your fix looks sane. But I am curious about whether we are
triggering some glibc pickiness that is in your setup, or if we are
somehow violating the assumption that we only ever look at
default_arg[1] and beyond.

What show-branch command did you issue to hit this? I was hoping to run
it under valgrind.

Also:

> +			if (!default_num)
> +			    /* One unused position for argv[0]. */
> +			    default_arg[default_num++] = NULL;

I don't know if we have a style rule for comments on single line
conditionals, but I had to read this a few times to make sure it wasn't
missing braces.

> -		ac = default_num + 1;
> -		av = default_arg - 1; /* ick; we would not address av[0] */
> +		ac = default_num;
> +		av = default_arg;

Any time you can remove a comment with "ick" in it is probably a good
thing.  ;)

-Peff
