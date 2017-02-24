Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A746201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 20:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbdBXUra (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 15:47:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:33594 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbdBXUr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 15:47:28 -0500
Received: (qmail 11486 invoked by uid 109); 24 Feb 2017 20:47:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 20:47:28 +0000
Received: (qmail 24408 invoked by uid 111); 24 Feb 2017 20:47:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 15:47:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2017 15:47:25 -0500
Date:   Fri, 24 Feb 2017 15:47:25 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] refs: parse_hide_refs_config to use parse_config_key
Message-ID: <20170224204725.6dq3zmazugzv2y6o@sigill.intra.peff.net>
References: <20170224203940.hbmfsouw5k67l3h3@sigill.intra.peff.net>
 <20170224204335.10652-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170224204335.10652-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 12:43:35PM -0800, Stefan Beller wrote:

> parse_config_key was introduced in 1b86bbb0ade (config: add helper
> function for parsing key names, 2013-01-22), the NEEDSWORK that is removed
> in this patch was introduced at daebaa7813 (upload/receive-pack: allow
> hiding ref hierarchies, 2013-01-18), which is only a couple days apart,
> so presumably the code replaced in this patch was only introduced due
> to not wanting to wait on the proper helper function being available.
> 
> Make the condition easier to read by using parse_config_key.
> [...]
>  	if (!strcmp("transfer.hiderefs", var) ||
> -	    /* NEEDSWORK: use parse_config_key() once both are merged */
> -	    (starts_with(var, section) && var[strlen(section)] == '.' &&
> -	     !strcmp(var + strlen(section), ".hiderefs"))) {
> +	    (!parse_config_key(var, section, &subsection, &subsection_len, &key)
> +	    && !subsection && !strcmp(key, "hiderefs"))) {

Yeah, this one looks fine.

-Peff
