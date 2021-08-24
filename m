Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1BAC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 00:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F41316124D
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 00:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhHXAXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 20:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbhHXAXL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 20:23:11 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEA0C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 17:22:28 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id j15so18858190ila.1
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 17:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZEBiQQPGZScqztpgzmhGx1JCWrszxmIvOKS3q71Q9IY=;
        b=1ie80FGSw+XBKffVDnDpZ0Kr6kcEviarrYF3wzE7qvkdarx6QxgQbV/0ZZZzRRahY7
         29dbRNnWbwc4X7S7TU5cqjf+P7xKtuhgYqdv6ZgIQ5R7g2WBLzZasnoxv8KaSg5tgDNF
         f9L3zpXvmh7N6CWO5nZFPyVI9QD72UzKV0hDvP1fEQBWPvq+nSO5DemNbtzyoVM8eQSl
         63I3C+bxGwnlX0qK7wwgsUYQUaTsvih+TxFgy1IA8PYwoCAIH5TjCjmqgmkF4cx1LKjq
         2aDGrCY2HWr5VOlDg35AAt2G+W1oPmz5lNWZ1dgXWM+lpdzzzSfrOM+ca8S61KKeNBa7
         wa5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZEBiQQPGZScqztpgzmhGx1JCWrszxmIvOKS3q71Q9IY=;
        b=Egzip64lPxnwiuUi3GhVY2hX/5P1j/FNp5kycHZ7cJ2O++pLT852mTfG2J8WXXEbZg
         VVKxIk+1eBzxE7NODkTTSrwct8weo03J2SGdBVzqiTDncEZxL5GhXwbvIuQkr91agd5r
         OwbAKLod/kOBwcj3dHVRgDkKdcEn4Oy6pDzsLgiKzajuQiZfpvaanScfstEmDqjkHIi3
         MvZp/IsR4FpiZDxZ7Ovon70dLMBANtEdmZTwjQXLBg2lwX1FjPyGZ7HgD8YG+bsHJh/x
         rEOAyTz+j4pu5zFcxkkhnP5e1xrOddxoen/ZXF0H2d3egnt0+joaqUfY0lJus/wTVpac
         3QhQ==
X-Gm-Message-State: AOAM530LeNonwTNQ6t90VYo+eO1FqCSqZ9lrvH/bRPjo5ZILBXpaRLs1
        F+mqB0ZYQ0bWsMa7rvdWYh3hhACG902DBL5j
X-Google-Smtp-Source: ABdhPJxmTvlQKBk/VshPtEm8DHVZsaC+eE1JD2m5+VVBQx7cbggLwPOaf2SIiYywbH+lagcD5wHUUg==
X-Received: by 2002:a05:6e02:e53:: with SMTP id l19mr8307961ilk.108.1629764547426;
        Mon, 23 Aug 2021 17:22:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b10sm9151151ils.13.2021.08.23.17.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 17:22:26 -0700 (PDT)
Date:   Mon, 23 Aug 2021 20:22:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] multi-pack-index: fix *.rev cleanups with --object-dir
Message-ID: <YSQ7wVKbE2HTkEz0@nand.local>
References: <20210823171011.80588-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210823171011.80588-1-johannes@sipsolutions.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 07:10:11PM +0200, Johannes Berg wrote:
> If using --object-dir to point into a repo while the current
> working dir is outside, such as
>
>   git init /repo
>   git -C /repo ... # add some objects
>   cd /non-repo
>   git multi-pack-index --object-dir /repo/.git/objects/ write
>
> the binary will segfault trying to access the object-dir via
> the repo it found, but that's not fully initialized. Fix it
> to use the object_dir properly to clean up the *.rev files,
> this avoids the crash and cleans up the *.rev files for the
> now rewritten multi-pack-index properly.

Thanks for splitting this up and clarifying the bug. This matches my
understanding, and is careful to get the "--object-dir write" vs "write
--object-dir" (where the former segfaults, and the latter triggers a
BUG()) distinction right.

This looks good to me, but I had one suggestion for an additional test
we should consider before picking this up.

> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 3d4d9f10c31b..665c6d64a0ab 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -201,6 +201,21 @@ test_expect_success 'write midx with twelve packs' '
>
>  compare_results_with_midx "twelve packs"
>
> +test_expect_success 'multi-pack-index *.rev cleanup with --object-dir' '
> +	git init objdir-test-repo &&
> +	test_when_finished "rm -rf objdir-test-repo" &&
> +	(
> +		cd objdir-test-repo &&
> +		test_commit base &&
> +		git repack -d
> +	) &&
> +	rev="objdir-test-repo/$objdir/pack/multi-pack-index-abcdef123456.rev" &&
> +	touch $rev &&

This is the only non-obvious part of the patch, but is necessary because
there's no way to trigger the MIDX code to write a reverse index
(thankfully so, since this means that we're not affecting anybody in the
wild cleaning up .rev's that we shouldn't be).

It may be worth returning to this in the future when we have support for
MIDX bitmaps (which will trigger writing a .rev file), but this is
absolutely the right thing to do in the meantime.

> +	nongit git multi-pack-index --object-dir="$(pwd)/objdir-test-repo/$objdir" write &&
> +	test_path_is_file objdir-test-repo/$objdir/pack/multi-pack-index &&
> +	test_path_is_missing $rev

Makes sense. There's no point in testing that we ignore a .rev file in
the outer repository, since we're using nongit to trigger this bug.

But it may be worth adding an additional test which doesn't use nongit,
and instead invokes 'git multi-pack-index' from a Git repository, but
points at another repo's object directory. That should give us some
confidence that we're not deleting .rev files that we shouldn't.

Thanks,
Taylor
