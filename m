Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9549720357
	for <e@80x24.org>; Tue, 11 Jul 2017 10:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755483AbdGKKlL (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 06:41:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:36836 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754028AbdGKKlL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 06:41:11 -0400
Received: (qmail 3085 invoked by uid 109); 11 Jul 2017 10:41:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 10:41:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15171 invoked by uid 111); 11 Jul 2017 10:41:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 06:41:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 06:41:08 -0400
Date:   Tue, 11 Jul 2017 06:41:08 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 6/7] tag: make git tag -l consider new config
 `pager.tag.list`
Message-ID: <20170711104108.vfkdo5vfoigcajdo@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com>
 <27ca13ea5b520d492f96ea319ae47d6f4b431e94.1499723297.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27ca13ea5b520d492f96ea319ae47d6f4b431e94.1499723297.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 11:55:19PM +0200, Martin Ågren wrote:

> diff --git a/builtin/tag.c b/builtin/tag.c
> index e0f129872..e96ef7d70 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -446,6 +446,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  
>  	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
>  
> +	if (cmdmode == 'l')
> +		setup_auto_pager("tag.list", 0);
>  	setup_auto_pager("tag", 0);

Ideally this would kick in whenever we are in list mode, even if the
user didn't say "-l". So:

  $ git tag

should probably respect the list config. Likewise, certain options like
"--contains" trigger list mode. I think the pager setup could just be
bumped a few lines down, past the "if (!cmdmode)" block that sets up
those defaults.

-Peff
