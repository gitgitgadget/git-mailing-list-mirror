Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A19091FBEC
	for <e@80x24.org>; Thu,  9 Mar 2017 07:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbdCIHfV (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 02:35:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:41089 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751355AbdCIHfU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 02:35:20 -0500
Received: (qmail 29222 invoked by uid 109); 9 Mar 2017 07:35:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 07:35:19 +0000
Received: (qmail 13824 invoked by uid 111); 9 Mar 2017 07:35:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 02:35:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Mar 2017 02:35:17 -0500
Date:   Thu, 9 Mar 2017 02:35:17 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <jeffhost@microsoft.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, markbt@efaref.net,
        benpeart@microsoft.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH 03/10] pack-objects: test for --partial-by-size
 --partial-special
Message-ID: <20170309073516.rksys3jljadupxtc@sigill.intra.peff.net>
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
 <1488994685-37403-4-git-send-email-jeffhost@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1488994685-37403-4-git-send-email-jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2017 at 05:37:58PM +0000, Jeff Hostetler wrote:

> diff --git a/t/5316-pack-objects-partial.sh b/t/5316-pack-objects-partial.sh
> [...]
> +test_expect_success 'setup' '
> +	perl -e "print \"a\" x 11;"      > a &&
> +	perl -e "print \"a\" x 1100;"    > b &&
> +	perl -e "print \"a\" x 1100000;" > c &&
> +	echo "ignored"                   > .gitignore &&
> +	git add a b c .gitignore &&
> +	git commit -m test
> +	'

A few minor style nits. We usually prefer ">a" with no space, and the
closing single-quote isn't indented.

> +test_expect_success 'special' '
> +	git pack-objects --revs --thin --stdout --partial-special >spec.pack <<-EOF &&
> +	master
> +	
> +	EOF
> +	git index-pack spec.pack &&
> +	test 1 = $(git verify-pack -v spec.pack | grep blob | wc -l)
> +	'

All of the tests make sense to me except this one. I see from the code
in pack-objects why this returns only the .gitattributes file. I'm just
not clear on whether that would ever be useful. I guess it lets you ask
"give me only the special files", but again, that seems kind of weird if
you are not otherwise limiting.

-Peff
