Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B99C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E10D64E02
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhBJU5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 15:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbhBJU53 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 15:57:29 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955B8C061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 12:56:49 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v7so4626081eds.10
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 12:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mGBlMdQP89SoIzI+ybR05/DwSM/6yewCBYfMVa4PY5A=;
        b=e44A2aBKR6dxqn/8mYX9raPfoym5akPEfrQ/aEj2x2uJkH68cW74ZtPAkJt/1qwnct
         rVMvwPak0X0sNZ3e7y4CWzKOU2KTXdAxtOQn7u25FQ6PL1j5mM9edXzUsAHDa4/tuxIk
         FAYb7Y62pycT8HU2UllUn08siLQdemdf3VMQOjL7HB2Kfse5ZnPApoIP0uEZg/3AkeAa
         NGl6ISdugUhw5twov2wIMF1LXl4Dbmd8RMvrOWNCMmFjIyIr+3GD8JIrHxsWBDW6l06Q
         3cqdKi3TRiRORsPIDnmQZtfowRgcO+moTEMngAsVRii9HwjaAtOzHfGIAXdiquPvBkDW
         bpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mGBlMdQP89SoIzI+ybR05/DwSM/6yewCBYfMVa4PY5A=;
        b=kul0f+C7QrbbarF0OJ00F/VSZWVV0X9VfkhGYOtQ60Or98N+AMG/xDgZJoJaQHQfdN
         edwwTdfc05bpIccwifyYb8AqQFohOylKzx4L/R+Bytn1C2LvJQB7AXBIOSFWJ2htlM05
         Cc9xv0L7GDqIor4zNKi1bEYFVA/ezADbWJddeXUJAV5ZGd0JOLKPLpI8wwCC11+z1H9w
         pW6WbM71y0T2+0RlP1Xm4OiLNon4n5BJ38Q9OTvOKcXbiPmCM6j4zayRF0xXtGNAUJSv
         likXOM3Nx+NUCJ16r+lH5Tfsv0KPsIceapoW+rlYsp2J0xvh4SXDjQ7Gp7El3uSgr1/v
         gkdg==
X-Gm-Message-State: AOAM530lGcCkEZu495J69DyJE14mD9FzyGhgx4faoj8geZI2jO2vPV7j
        r+XLw00NzRv9HRFTDwBCkDRI8VhlrYY=
X-Google-Smtp-Source: ABdhPJx2PmXadSzPJrVkoWyAnGEFP08zqpVRqo93x5FwIuUP6Rd3mDYtl0L4+DslIZpKFgSoO3KvMQ==
X-Received: by 2002:a05:6402:5:: with SMTP id d5mr5054309edu.121.1612990608360;
        Wed, 10 Feb 2021 12:56:48 -0800 (PST)
Received: from szeder.dev (62-165-238-147.pool.digikabel.hu. [62.165.238.147])
        by smtp.gmail.com with ESMTPSA id x5sm2191539ejw.9.2021.02.10.12.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 12:56:47 -0800 (PST)
Date:   Wed, 10 Feb 2021 21:56:45 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/12] test-lib-functions: move function to lib-bitmap.sh
Message-ID: <20210210205645.GE1015009@szeder.dev>
References: <20210209214159.22815-1-avarab@gmail.com>
 <20210209214159.22815-8-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210209214159.22815-8-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 09, 2021 at 10:41:54PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Move a function added to test-lib-functions.sh in ea047a8eb4f (t5310:
> factor out bitmap traversal comparison, 2020-02-14) into a new
> lib-bitmap.sh.
> 
> The test-lib-functions.sh file should be for functions that are widely
> used across the test suite, if something's only used by a few tests it
> makes more sense to have it in a lib-*.sh file.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/lib-bitmap.sh                    | 26 ++++++++++++++++++++++++++
>  t/t5310-pack-bitmaps.sh            |  2 ++
>  t/t6113-rev-list-bitmap-filters.sh |  1 +
>  t/test-lib-functions.sh            | 27 ---------------------------
>  4 files changed, 29 insertions(+), 27 deletions(-)
>  create mode 100644 t/lib-bitmap.sh
> 
> diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
> new file mode 100644
> index 00000000000..fe3f98be24f
> --- /dev/null
> +++ b/t/lib-bitmap.sh
> @@ -0,0 +1,26 @@
> +# Compare a file containing rev-list bitmap traversal output to its non-bitmap
> +# counterpart. You can't just use test_cmp for this, because the two produce
> +# subtly different output:
> +#
> +#   - regular output is in traversal order, whereas bitmap is split by type,
> +#     with non-packed objects at the end
> +#
> +#   - regular output has a space and the pathname appended to non-commit
> +#     objects; bitmap output omits this
> +#
> +# This function normalizes and compares the two. The second file should
> +# always be the bitmap output.
> +test_bitmap_traversal () {
> +	if test "$1" = "--no-confirm-bitmaps"
> +	then
> +		shift
> +	elif cmp "$1" "$2"
> +	then
> +		echo >&2 "identical raw outputs; are you sure bitmaps were used?"
> +		return 1

Since you converted two 'error's to BUG earlier in this series...

This helper function was added in ea047a8eb4 (t5310: factor out bitmap
traversal comparison, 2020-02-14), and so I Cc: its author and quote
part of its commit message:

    While we're at it, let's also try to confirm that the bitmap output did
    indeed use bitmaps. Since the code internally falls back to the
    non-bitmap path in some cases, the tests are at risk of becoming trivial
    noops.
    
    This is a bit fragile, as not all outputs will differ (e.g., looking at
    only the commits from a fully-bitmapped pack will end up exactly the
    same as the normal traversal order, since it also matches the pack
    order). So we'll provide an escape hatch by which tests can disable this
    check (which should only be used after manually confirming that bitmaps
    kicked in).

Shouldn't this be a BUG as well?  I think this should be a BUG.

> +	fi &&
> +	cut -d' ' -f1 "$1" | sort >"$1.normalized" &&
> +	sort "$2" >"$2.normalized" &&
> +	test_cmp "$1.normalized" "$2.normalized" &&
> +	rm -f "$1.normalized" "$2.normalized"
> +}
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 5ba76031090..40b9f632441 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -5,6 +5,8 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-bundle.sh
> +. "$TEST_DIRECTORY"/lib-bitmap.sh
>  
>  objpath () {
>  	echo ".git/objects/$(echo "$1" | sed -e 's|\(..\)|\1/|')"
> diff --git a/t/t6113-rev-list-bitmap-filters.sh b/t/t6113-rev-list-bitmap-filters.sh
> index 2b551e6fd0c..3f889949ca1 100755
> --- a/t/t6113-rev-list-bitmap-filters.sh
> +++ b/t/t6113-rev-list-bitmap-filters.sh
> @@ -2,6 +2,7 @@
>  
>  test_description='rev-list combining bitmaps and filters'
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-bitmap.sh
>  
>  test_expect_success 'set up bitmapped repo' '
>  	# one commit will have bitmaps, the other will not
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 55d58b4a6ac..f228647c2b8 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1602,33 +1602,6 @@ test_set_port () {
>  	eval $var=$port
>  }
>  
> -# Compare a file containing rev-list bitmap traversal output to its non-bitmap
> -# counterpart. You can't just use test_cmp for this, because the two produce
> -# subtly different output:
> -#
> -#   - regular output is in traversal order, whereas bitmap is split by type,
> -#     with non-packed objects at the end
> -#
> -#   - regular output has a space and the pathname appended to non-commit
> -#     objects; bitmap output omits this
> -#
> -# This function normalizes and compares the two. The second file should
> -# always be the bitmap output.
> -test_bitmap_traversal () {
> -	if test "$1" = "--no-confirm-bitmaps"
> -	then
> -		shift
> -	elif cmp "$1" "$2"
> -	then
> -		echo >&2 "identical raw outputs; are you sure bitmaps were used?"
> -		return 1
> -	fi &&
> -	cut -d' ' -f1 "$1" | sort >"$1.normalized" &&
> -	sort "$2" >"$2.normalized" &&
> -	test_cmp "$1.normalized" "$2.normalized" &&
> -	rm -f "$1.normalized" "$2.normalized"
> -}
> -
>  # Tests for the hidden file attribute on Windows
>  test_path_is_hidden () {
>  	test_have_prereq MINGW ||
> -- 
> 2.30.0.284.gd98b1dd5eaa7
> 
