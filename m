Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2675C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 05:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC792072D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 05:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgCTFw0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:52:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:44760 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726030AbgCTFw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 01:52:26 -0400
Received: (qmail 31065 invoked by uid 109); 20 Mar 2020 05:52:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Mar 2020 05:52:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3137 invoked by uid 111); 20 Mar 2020 06:02:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Mar 2020 02:02:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Mar 2020 01:52:25 -0400
From:   Jeff King <peff@peff.net>
To:     Adrian Wijaya <adrianwijaya100@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSOC][PATCH 2/2] t1300: replace "test -f" into
 "test_path_is_file"
Message-ID: <20200320055225.GG499858@coredump.intra.peff.net>
References: <20200319234723.6504-1-adrianwijaya100@gmail.com>
 <20200319234723.6504-2-adrianwijaya100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200319234723.6504-2-adrianwijaya100@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 20, 2020 at 06:47:23AM +0700, Adrian Wijaya wrote:

> [...]

Thanks, and welcome to the Git community. The patch looks pretty good to
me. A few minor nits:

> Subject: Re: [GSOC][PATCH 2/2] t1300: replace "test -f" into "test_path_is_file"

The subject says 2/2, but I think there is only one patch. :) Looks like
you used send-email; the --cover-letter option is probably what you
wanted to generate the first message. Though for a single-patch series,
I'd generally suggest just sending one email total, and putting any
comments below the "---" line (which would then not be included in the
commit message).

The general form of the subject line looks good, and follows our
conventions.

I'd suggest s/into/with/ in the subject line as a minor English fixup.
We'd often assume the maintainer will just fix up something small like
that while applying (or if he doesn't, that it's not too big a deal).
But since the point of the microproject is to get comfortable with the
patch submission process, maybe it would be good practice for you to fix
it up yourself (using "commit --amend" or "rebase -i") and re-send (try
git-send-email's "-v" option).

> Replace "test -f" into "test_path_is_file" to give more verbose
> test output.

Same s/into/with/ here, too (or perhaps s/Replace/Convert/).

Maybe worth saying "to give more verbose test output on failure", though
now I am really nit-picking (sorry, you avoided so many of the usual
first-time-patch pitfalls I have to stretch :) ).

> Signed-off-by: Adrian Wijaya <adrianwijaya100@gmail.com>
> ---

You remembered your signoff. Good.

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 97ebfe1f9d..d74554fc09 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1020,11 +1020,11 @@ test_expect_success SYMLINKS 'symlinked configuration' '
>  	ln -s notyet myconfig &&
>  	git config --file=myconfig test.frotz nitfol &&
>  	test -h myconfig &&
> -	test -f notyet &&
> +	test_path_is_file notyet &&

And the patch itself looks obviously correct.

The "test -h" in the context sticks out now, but we don't have a
test_path_is_symlink(). I think adding it goes beyond the scope of this
patch, and beyond what's needed for a microproject. But if you or
anybody wants to add it (modeled after test_path_is_file), it seems like
a reasonable thing for us to have.

-Peff
