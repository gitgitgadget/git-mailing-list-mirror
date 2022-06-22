Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D33DC433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 16:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357869AbiFVQzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 12:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376947AbiFVQyz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 12:54:55 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDB127FF1
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 09:54:53 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id n15so21981237qvh.12
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 09:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IKLUDNpDvP78dYJfNieP2j3/GNeI2dfkKpSDD6Qk/qQ=;
        b=8Jy2RrbAtHVKhovZDnlA1aeoFIjCafLo5PaSRlufPZqezurX+/jPFKLMb7PaVig90O
         J+tidU5iz4vb8zmUlcWjavtTCO6eJYBPzJQhMiFu3xUu09OOiAvm8Xoy0ba79Ythn4Q/
         VfpI4bwP0tWrphbtRDlfaMFoS+mEJoU1xBTIGqwlpcj7S4ZuWi8XzP+RnwfiWw1EtgI2
         xn7t2ekhn8BKqoAvEpT/O854D6Xs/MwKnopM7kCtGSA6wj6i/3NlulRmgHQNHBpsx76A
         0osj0yJvo5jRMut2bvO75MpmY5aDxyh5fXym3+wCLLMDbsktEGGqvbYrZbAHyKqDakEi
         vHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IKLUDNpDvP78dYJfNieP2j3/GNeI2dfkKpSDD6Qk/qQ=;
        b=Nxj+WMG0CmMHLxIYK0J802zwbzyUN5FrbgzFmeGgVaZs/j7Vv6/SgEyhrGqrQ/dD2K
         LTwqgIvYS3SJ3vBb/FcXbKTVnf1+WRvLaWSDE/kzRO/ampBCIueRxvfvBpFGHeCN+0ES
         F/4guYYCo/mf1+gY+54gUxS5XDHMYAVmBc4dnVVyCFRqBBWMb1NDPIw2diNyDoOkWn1X
         FfNlvjwf/MR7q1s25YO/g1PimRzHew3TSPT3JLx8fIbeYY7wFc66vI2SVijhsM6dkRfG
         At/c8L2v60Td2kxQAFJe0m+LDSl2wz2YLFt9EOS9PwTL7l8DMb20a5aI6wQVqHU7nFP6
         Q2cg==
X-Gm-Message-State: AJIora+P+E3oMSGsagbiuOIqNCqFkTy5ncS9jSKei5+ySoMWSpHga+P6
        QfkkagyYBNq4BaHzs/uihgY1PA==
X-Google-Smtp-Source: AGRyM1vk1/R92fJ0Iltjzl4us4cEzp1LAE1hECVJieNPZ7SP9YLOBG+57U1R+LUeRuavw7e7OCR/jg==
X-Received: by 2002:ac8:5d87:0:b0:305:bbf:cd85 with SMTP id d7-20020ac85d87000000b003050bbfcd85mr3907901qtx.618.1655916892846;
        Wed, 22 Jun 2022 09:54:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r10-20020ae9d60a000000b006a73cb957dasm16741217qkk.20.2022.06.22.09.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 09:54:52 -0700 (PDT)
Date:   Wed, 22 Jun 2022 12:54:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 5/6] bitmap-commit-table: add tests for the bitmap lookup
 table
Message-ID: <YrNJW00QuHbfi090@nand.local>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <a404779a30f767f7a05926fb99f354ea7958ab4b.1655728395.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a404779a30f767f7a05926fb99f354ea7958ab4b.1655728395.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 20, 2022 at 12:33:13PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> Add tests to check the working of the newly implemented lookup table.
>
> Mentored-by: Taylor Blau <ttaylorr@github.com>
> Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
>  t/t5310-pack-bitmaps.sh       | 14 ++++++++++++++
>  t/t5326-multi-pack-bitmaps.sh | 19 +++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index f775fc1ce69..f05d3e6ace7 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -43,6 +43,20 @@ test_expect_success 'full repack creates bitmaps' '
>
>  basic_bitmap_tests
>
> +test_expect_success 'using lookup table does not affect basic bitmap tests' '
> +	test_config pack.writeBitmapLookupTable true &&
> +	git repack -adb
> +'

Whether or not we end up making pack.writeBitmapLookupTable be "true" by
default, I wonder if we should just set it to "true" whenever we write a
bitmap in this file, and then adjust whether or not we *read* the lookup
table with the GIT_TEST_ environment variable you introduced a few
commits back.

Thinking on it more, though, I don't think it makes a huge practical
difference for the code here in "t", since these repositories are tiny
and repacking them or rewriting their bitmaps is cheap.

But in the performance tests it probably makes a bigger difference.

> +basic_bitmap_tests
> +
> +test_expect_success 'using lookup table does not let each entries to be parsed one by one' '
> +	test_config pack.writeBitmapLookupTable true &&
> +	git repack -adb &&
> +	git rev-list --test-bitmap HEAD 2>out &&
> +	grep "Found bitmap for" out &&
> +	! grep "Bitmap v1 test "
> +'
> +
>  test_expect_success 'incremental repack fails when bitmaps are requested' '
>  	test_commit more-1 &&
>  	test_must_fail git repack -d 2>err &&
> diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
> index 4fe57414c13..85fbdf5e4bb 100755
> --- a/t/t5326-multi-pack-bitmaps.sh
> +++ b/t/t5326-multi-pack-bitmaps.sh
> @@ -306,5 +306,24 @@ test_expect_success 'graceful fallback when missing reverse index' '
>  		! grep "ignoring extra bitmap file" err
>  	)
>  '
> +test_expect_success 'multi-pack-index write --bitmap writes lookup table if enabled' '
> +	rm -fr repo &&
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&
> +	(
> +		cd repo &&
> +		test_commit_bulk 106 &&

Is there a reason we need to write this many commits? I think this is
copied from a test further up which deals explicitly with a case where
there are too many commits to write bitmaps for all of them (hence we
need to write more commits than 100 or so).

But I think for our purposes here we just need a single commit, written
into a single pack, which is covered with a MIDX.

So it should suffice to do something like:

    test_commit base &&
    git repack -ad &&
    git config pack.writeBitmapLookupTable true &&
    git multi-pack-index write --bitmap &&
    [...]

instead of what's written here.

Thanks,
Taylor
