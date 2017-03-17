Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ECC220951
	for <e@80x24.org>; Fri, 17 Mar 2017 13:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbdCQNpE (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 09:45:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:45893 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbdCQNpD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 09:45:03 -0400
Received: (qmail 30913 invoked by uid 109); 17 Mar 2017 13:38:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 13:38:21 +0000
Received: (qmail 2994 invoked by uid 111); 17 Mar 2017 13:38:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 09:38:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Mar 2017 09:38:17 -0400
Date:   Fri, 17 Mar 2017 09:38:17 -0400
From:   Jeff King <peff@peff.net>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [GSoC][PATCH v6 3/3] credential-cache: add tests for XDG
 functionality
Message-ID: <20170317133817.nt6s7viputaeh2cy@sigill.intra.peff.net>
References: <20170317025315.84548-3-lehmacdj@gmail.com>
 <20170317123634.10863-1-lehmacdj@gmail.com>
 <20170317123634.10863-3-lehmacdj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170317123634.10863-3-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 08:36:34AM -0400, Devin Lehmacher wrote:

> +test_expect_success 'credential-cache --socket option overrides default location' '
> +	test_when_finished "
> +		git credential-cache exit --socket \"\$HOME/dir/socket\" &&
> +		rmdir \"\$HOME/dir\"
> +	" &&
> +	check approve "cache --socket \"\$HOME/dir/socket\"" <<-\EOF &&

I wondered how this one got through the quoting/eval mess of the
"check()" function. But it works because we pass a raw unexpanded $HOME
into the config variable, and the credential subsystem then runs "cache
--socket ..." using a shell, which is where it gets expanded.

> +	mkdir -p -m 700 "$HOME/.git-credential-cache/" &&

This is our first use of "mkdir -m". It's in POSIX, so it should
probably be fine. I'm not sure if platforms without POSIXPERM would
complain, but I think in practice anything with unix sockets will handle
it just fine.

The rest of the tests look OK to me.

-Peff
