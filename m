Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF76C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 09:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbhLJJfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 04:35:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:48570 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231384AbhLJJfn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 04:35:43 -0500
Received: (qmail 18080 invoked by uid 109); 10 Dec 2021 09:32:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 09:32:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28490 invoked by uid 111); 10 Dec 2021 09:32:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Dec 2021 04:32:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Dec 2021 04:32:07 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 13/19] tests: apply modern idiom for signaling test
 failure
Message-ID: <YbMel5UZm9ESM5Jr@coredump.intra.peff.net>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <20211209051115.52629-14-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211209051115.52629-14-sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 09, 2021 at 12:11:09AM -0500, Eric Sunshine wrote:

> Simplify the way these tests signal failure by employing the modern
> idiom of making the `if` or `case` statement resolve to false when an
> error is detected.

Yeah, these are pretty non-idiomatic, but...

> diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
> index cfde68f193..7e46f4ca85 100755
> --- a/t/t3402-rebase-merge.sh
> +++ b/t/t3402-rebase-merge.sh
> @@ -68,7 +68,7 @@ test_expect_success 'merge and rebase should match' '
>  	if test -s difference
>  	then
>  		cat difference
> -		(exit 1)
> +		false
>  	else
>  		echo happy
>  	fi

...I'd have said the idiom here is just:

  git diff-tree -r test-rebase test-merge >difference &&
  test -s difference

The extra "cat" and "happy" are verbose output that we usually skip in
favor of letting "-x" logging do the talking (and leaving the failed
state so you can "cat difference" yourself).

That said, I'm OK with this minimal change in the name of keeping creep
out of the series.

-Peff
