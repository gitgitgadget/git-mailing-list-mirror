Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AA5E20248
	for <e@80x24.org>; Fri, 15 Mar 2019 03:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfCODSg (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 23:18:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:51868 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726571AbfCODSg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 23:18:36 -0400
Received: (qmail 14521 invoked by uid 109); 15 Mar 2019 03:18:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Mar 2019 03:18:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28643 invoked by uid 111); 15 Mar 2019 03:17:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Mar 2019 23:17:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Mar 2019 23:17:19 -0400
Date:   Thu, 14 Mar 2019 23:17:19 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] difftool: allow running outside Git worktrees
 with --no-index
Message-ID: <20190315031718.GC28943@sigill.intra.peff.net>
References: <pull.163.git.gitgitgadget@gmail.com>
 <pull.163.v2.git.gitgitgadget@gmail.com>
 <8cca9f800c2ce269a2ae644e4c15dc4115d3b0e2.1552562701.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8cca9f800c2ce269a2ae644e4c15dc4115d3b0e2.1552562701.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 04:25:04AM -0700, Johannes Schindelin via GitGitGadget wrote:

> @@ -714,6 +714,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
>  			    "tool returns a non - zero exit code")),
>  		OPT_STRING('x', "extcmd", &extcmd, N_("command"),
>  			   N_("specify a custom command for viewing diffs")),
> +		OPT_ARGUMENT("no-index", &no_index, N_("passed to `diff`")),
>  		OPT_END()
>  	};

Much nicer.

> +test_expect_success 'outside worktree' '
> +	echo 1 >1 &&
> +	echo 2 >2 &&
> +	test_expect_code 1 nongit git \
> +		-c diff.tool=echo -c difftool.echo.cmd="echo \$LOCAL \$REMOTE" \
> +		difftool --no-prompt --no-index ../1 ../2 >actual &&
> +	echo "../1 ../2" >expect &&
> +	test_cmp expect actual
> +'

And this fixed all of my nits from the previous version. The whole
series looks good to me.

-Peff
