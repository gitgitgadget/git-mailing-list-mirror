Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E398205C9
	for <e@80x24.org>; Fri,  6 Jan 2017 06:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939550AbdAFGSi (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 01:18:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:35844 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S939540AbdAFGSf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 01:18:35 -0500
Received: (qmail 20964 invoked by uid 109); 6 Jan 2017 06:18:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 06:18:35 +0000
Received: (qmail 14838 invoked by uid 111); 6 Jan 2017 06:19:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 01:19:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2017 01:18:32 -0500
Date:   Fri, 6 Jan 2017 01:18:32 -0500
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch_get_push: do not segfault when HEAD is detached
Message-ID: <20170106061832.o465olp3drnsont3@sigill.intra.peff.net>
References: <20170106045623.21118-1-kyle@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170106045623.21118-1-kyle@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 05, 2017 at 11:56:23PM -0500, Kyle Meyer wrote:

> Move the detached HEAD check from branch_get_push_1() to
> branch_get_push() to avoid setting branch->push_tracking_ref when
> branch is NULL.

Yep, I think this is the right fix.

> diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
> index 7214f5b33..90c639ae1 100755
> --- a/t/t1514-rev-parse-push.sh
> +++ b/t/t1514-rev-parse-push.sh
> @@ -60,4 +60,10 @@ test_expect_success '@{push} with push refspecs' '
>  	resolve topic@{push} refs/remotes/origin/magic/topic
>  '
>  
> +test_expect_success 'resolving @{push} fails with a detached HEAD' '
> +	git checkout HEAD^{} &&
> +	test_when_finished "git checkout -" &&
> +	test_must_fail git rev-parse @{push}
> +'

Looks good. Thanks.

-Peff

PS Looks like this is your first patch. Welcome. :)
