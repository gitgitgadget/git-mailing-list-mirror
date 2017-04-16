Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A676720D09
	for <e@80x24.org>; Sun, 16 Apr 2017 15:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756020AbdDPPbb (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 11:31:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:34417 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755760AbdDPPbb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 11:31:31 -0400
Received: (qmail 10896 invoked by uid 109); 16 Apr 2017 15:31:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Apr 2017 15:31:30 +0000
Received: (qmail 16908 invoked by uid 111); 16 Apr 2017 15:31:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Apr 2017 11:31:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Apr 2017 11:31:28 -0400
Date:   Sun, 16 Apr 2017 11:31:28 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        bert.wesarg@googlemail.com
Subject: Re: [PATCH 1/2] config: prepare to pass more info in
 git_config_with_options()
Message-ID: <20170416153127.f227kdbfctgrumh4@sigill.intra.peff.net>
References: <20170416045004.2ghhiv7jzgroejgw@sigill.intra.peff.net>
 <20170416104125.15300-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170416104125.15300-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 16, 2017 at 05:41:24PM +0700, Nguyễn Thái Ngọc Duy wrote:

> So far we can only pass one flag, respect_includes, to thie function. We
> need to pass some more (non-flag even), so let's make it accept a struct
> instead of an integer.

Yeah, this makes sense. But...

> diff --git a/builtin/config.c b/builtin/config.c
> index 4f49a0edb9..5de4a36146 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -26,7 +26,8 @@ static int use_global_config, use_system_config, use_local_config;
>  static struct git_config_source given_config_source;
>  static int actions, types;
>  static int end_null;
> -static int respect_includes = -1;
> +static int respect_includes_opt;
> +static struct config_options config_options;

It fails all the git-config "include" tests because respect_includes_opt
is missing the initialization to "-1".

-Peff
