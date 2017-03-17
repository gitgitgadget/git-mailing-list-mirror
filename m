Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C61A620951
	for <e@80x24.org>; Fri, 17 Mar 2017 13:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbdCQNoF (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 09:44:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:45884 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbdCQNoD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 09:44:03 -0400
Received: (qmail 31174 invoked by uid 109); 17 Mar 2017 13:42:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 13:42:06 +0000
Received: (qmail 3022 invoked by uid 111); 17 Mar 2017 13:42:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 09:42:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Mar 2017 09:42:03 -0400
Date:   Fri, 17 Mar 2017 09:42:03 -0400
From:   Jeff King <peff@peff.net>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [GSoC][PATCH v6 2/3] credential-cache: use XDG_CACHE_HOME for
 socket
Message-ID: <20170317134203.6hqzfblyse2jrzdp@sigill.intra.peff.net>
References: <20170317025315.84548-3-lehmacdj@gmail.com>
 <20170317123634.10863-1-lehmacdj@gmail.com>
 <20170317123634.10863-2-lehmacdj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170317123634.10863-2-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 08:36:33AM -0400, Devin Lehmacher wrote:

> Make git-credential-cache follow the XDG base path specification by
> default. This increases consistency with other applications and helps
> keep clutter out of users' home directories.
> 
> Check the old socket location, ~/.git-credential-cache/, and use
> ~/.git-credential-cache/socket if that directory exists rather than
> forcing users who have used `git credential-cache` before to migrate to
> the new XDG compliant location.
> Otherwise use the socket $XDG_CACHE_HOME/git/credential/socket following
> XDG base path specification. Use the subdirectory credential/ in case
> other files are cached under $XDG_CACHE_HOME/git/ in the future and to
> make the socket's purpose clear.

Makes sense.

> +static char *get_socket_path(void)
> +{
> +	struct stat sb;
> +	char *old_dir, *socket;
> +	old_dir = expand_user_path("~/.git-credential-cache");
> +	if (old_dir && !stat(old_dir, &sb) && S_ISDIR(sb.st_mode))
> +		socket = xstrfmt("%s/socket", old_dir);
> +	else
> +		socket = xdg_cache_home("credential/socket");
> +	free(old_dir);
> +	return socket;
> +}

The implementation looks nice and clean.

-Peff
