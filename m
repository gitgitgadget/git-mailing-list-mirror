Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3093EC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F32061050
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhIUC7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348865AbhIUCYy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:24:54 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799AEC1DF511
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 11:52:22 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y197so9854010iof.11
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 11:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LYExE8wZJqOyXWcpHtFMOFXHLKBWor3VlzgHxW1Y++E=;
        b=8APxBSXdrDcu950I6AkBK36UDeeoQBuweTOYgYYFDwStQs1AZGeaageLMjXwX0VVHe
         haopeyFeENcAqn58jem0KiNGakuTwYnyNSrTnMqYM7QkEQr04oF7O95nSYCS0CmSVxm/
         ZCj4EvQk5YqZARY2a3JxpBUoWT9D2hKqsYuF/06OzvjyAHIZXFzopSnXQDesKJGpuhnu
         ASAKav8bSA03e8uLtmu1V90H5Z9+dLtDztdHk6+C2PHd7Zg2dsxidpV0T9Y6WaQKGUfB
         6jiJfSpbiJI1Gf6KcTxRE123hEfGKbq91JJrwH8sbnMeMcTGaN/foNW0cwY9ooA6qQB0
         3BCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LYExE8wZJqOyXWcpHtFMOFXHLKBWor3VlzgHxW1Y++E=;
        b=5VDkdXvo2tHLQc7Mcac7ccj8NRbmnkpv8bPlPdmxQFnoksI3CfklV8SUEmbLPYOLbM
         i7Q8VdSD0/jQlLvR20p9N76pm3OJ2ZAGqjgCBd6H0w3v3wn1nHkl8Lj6S5xtHn+b+BLv
         3Bw+dpeD+N1gUnX2508SSsjr3yumAeUFkBMjjSnkiKg0KVvnzHdW5ju535AhXal//8TF
         FCHolXqmfjCWDRoWblWb4VD2JRR6t0wQNCIYdKFFuhCLUCOA8ALQOgepIVMZe9RnNn7W
         0ReYCp6GtHBZ5vyA3C46C97kEd+esMnHJM8Mcrs04UuyC4a2eWnSxuZHh+bIZdhIsG2L
         AGgg==
X-Gm-Message-State: AOAM532wo9QAoumrzK3foh6wTK74ajqOTvmgF0tWwuXsEBxWaVCxHjG4
        DQLWCpFnscFLIXyIpt3bajY69g==
X-Google-Smtp-Source: ABdhPJxxUtUkmTodWoxwsGtBNmZ5AbcVEArR1ZHkCv66OjHc3l6kT6xwtmqdR8pwmEh9Hmgmmt2krg==
X-Received: by 2002:a02:711e:: with SMTP id n30mr20785564jac.3.1632163941874;
        Mon, 20 Sep 2021 11:52:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 67sm874555iou.4.2021.09.20.11.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:52:21 -0700 (PDT)
Date:   Mon, 20 Sep 2021 14:52:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        calbabreaker@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/3] sparse-checkout: clear patterns when switching modes
Message-ID: <YUjYZNqvvxVRctJQ@nand.local>
References: <pull.1043.git.1632160658.gitgitgadget@gmail.com>
 <450b90dad57c42e37a4edc52dac88caf98021fc6.1632160658.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <450b90dad57c42e37a4edc52dac88caf98021fc6.1632160658.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 05:57:37PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Previously, when a user runs 'git sparse-checkout init --cone', the
> existing patterns would remain, even if the patterns were not in cone
> mode. This causes confusion as to how the patterns should work when
> later 'git sparse-checkout add' commands append to the pattern list.
>
> In fact, the way these patterns were modified was not even a strict
> appending of patterns, but mutating and reordering patterns because of
> how the paths were interpreted and rewritten.
>
> As a first step, we shall start overwriting the pattern set completely
> when switching to cone mode, unless the existing patterns already match
> cone mode patterns. The 'use_cone_patterns' member is set to false if
> the patterns fail to parse using cone mode restrictions.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/sparse-checkout.c          | 13 +++++++++++--
>  t/t1091-sparse-checkout-builtin.sh |  9 ++++++++-
>  2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index b45fd97a98b..fe76c3eedda 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -348,8 +348,17 @@ static int sparse_checkout_init(int argc, const char **argv)
>
>  	/* If we already have a sparse-checkout file, use it. */
>  	if (res >= 0) {
> -		free(sparse_filename);
> -		return update_working_directory(NULL);
> +		if (pl.use_cone_patterns || !init_opts.cone_mode) {

I traced through this code beginning with sparse_checkout_init() and
right before the check on pl.use_cone_patterns, and I couldn't find
anywhere that this variable is set to a non-zero value. Could you let me
know if I'm missing something, or is the left-hand side of this or
redundant?

I guess what this check wants to be saying is "if the existing
sparse-checkout was in cone mode or we are transitioning to cone mode,
then quit now".

> +			free(sparse_filename);
> +			return update_working_directory(NULL);
> +		}
> +
> +		/*
> +		 * At this point, note that if res >= 0 but pl.use_cone_patterns
> +		 * is false, then we want to override the patterns with the
> +		 * initial set of cone mode patterns.
> +		 */
> +		clear_pattern_list(&pl);

...or otherwise, we are transitioning into cone mode from a non-cone
mode state?

If so, this may be somewhat surprising to users who have their patterns
cleared after re-initializing. I guess the command is called "init", but
it may be friendlier to have a `--reinitialize` option or similar which
indicates the user's preference to obliterate existing patterns if
necessary.

See my message at [1] for some more details about a possible suggestion
there.

>  	}
>
>  	if (get_oid("HEAD", &oid)) {
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index a429d2cc671..af0acd32bd9 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -108,7 +108,14 @@ test_expect_success 'switching to cone mode with non-cone mode patterns' '
>  	git -C bad-patterns sparse-checkout init &&
>  	git -C bad-patterns sparse-checkout add dir &&
>  	git -C bad-patterns config core.sparseCheckoutCone true &&
> -	git -C bad-patterns sparse-checkout add dir
> +	git -C bad-patterns sparse-checkout add dir &&
> +
> +	git -C bad-patterns sparse-checkout init --cone &&
> +	cat >expect <<-\EOF &&
> +	/*
> +	!/*/
> +	EOF
> +	test_cmp expect bad-patterns/.git/info/sparse-checkout


Makes sense that we have to look at the contents of
$GIT_DIR/info/sparse-checkout directly here to see the explicit '/*' and
'!/*/' patterns.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/YUi55%2F3L9nizTVyA@nand.local/
