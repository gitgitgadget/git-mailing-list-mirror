Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E53B11FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 19:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754321AbdCMTBQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 15:01:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:43347 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753829AbdCMTBP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 15:01:15 -0400
Received: (qmail 29249 invoked by uid 109); 13 Mar 2017 19:01:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 19:01:14 +0000
Received: (qmail 20636 invoked by uid 111); 13 Mar 2017 19:01:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 15:01:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Mar 2017 15:01:11 -0400
Date:   Mon, 13 Mar 2017 15:01:11 -0400
From:   Jeff King <peff@peff.net>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH 2/3] credential-cache.c: Make git use
 XDG_CACHE_HOME for credentials
Message-ID: <20170313190111.64vzo7v3b3aty2dt@sigill.intra.peff.net>
References: <20170313172232.96678-1-lehmacdj@gmail.com>
 <20170313172232.96678-3-lehmacdj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170313172232.96678-3-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 01:22:31PM -0400, Devin Lehmacher wrote:

> Subject: Re: [GSoC][PATCH 2/3] credential-cache.c: Make git use XDG_CACHE_HOME for credentials

Another subject nitpick. :)

Saying "Make git" is just extraneous. All commits make git do something.

Likewise "for credentials" doesn't say much. Perhaps "for socket" would
be more descriptive.

I'm not sure we are entirely consistent here, but I'd probably say just
"credential-cache" (not "credential-cache.c"). My rule of thumb is to
mention the C file if it's an internal thing: a cleanup, a new
function, etc. And use the command-name if it's something user-visible.

So all together:

  Subject: credential-cache: use XDG_CACHE_HOME for socket

is shorter and more descriptive (IMHO).

> git-credential-cache will now use the socket
> $XDG_CACHE_HOME/git/credential/socket if there is not already a socket
> at ~/.git-credential-cache/socket. This ensures that if another process
> already created a socket at the old location it will be used over the
> new one if it exists.

This tells us what, but not much about "why". Probably the reason is
something simple, like "using standards is better than not". But the
commit message should say that.

> +static char* get_socket_path(void) {
> +	char *home_socket;
> +
> +	home_socket = expand_user_path("~/.git_credential_cache/socket");
> +	if (home_socket)
> +		if (file_exists(home_socket))
> +			return home_socket;
> +		else
> +			free(home_socket);

Please use braces for nested ifs. I know that C resolves a dangling-else
like this as you've indented it (as opposed to attaching the else to the
outer "if"), but it is unnecessarily confusing. Just one set of braces:

  if (home_socket) {
	if (file_exists(home_socket);
		return home_socket;
	else
		free(home_socket);
  }

is sufficient.

-Peff
