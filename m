Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF01BC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C8361050
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhIUC70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349313AbhIUCZr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:25:47 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602D9C0A88E5
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 11:59:30 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id a15so23506950iot.2
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HRAlZa9cDahb551d04MT8UVF/WAfK4UBWUP+/NwdHUY=;
        b=7pY5pKTaE/Ig2aXZ16oJfmxGHpQlTDB06CvBtBcajQ2fIrtA9uSE+W3yyP1H2KvEvu
         zFTbZf8jkKaTnBh3ZmE/fbB7peajns/D73hHuyQuEEXqzU9Y1W9l73pkhUIskHKoqFik
         88dkJ0dkkTn9hINZ2EZ2W3B+VePVVVQ2oKTYxPzgq7K/jEDjTGivcPApnT0i8NDA+IGh
         PPIz62oqBxe23OhNM5JRuSZdMEFrskXL/1RWiJVfknGr+QtG1stKBByy4xzGf9FXXYAq
         aBBRFvCEbYw8mC2kpuqhxm0jOTYYSRxXakCKk9lb+fAk8f7G8kdvCf53GG1E02xQiS0l
         TlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HRAlZa9cDahb551d04MT8UVF/WAfK4UBWUP+/NwdHUY=;
        b=495I4oi7LhTBgPtwm6hzA5FQyNhnLS2cD8zxs/+jJpfHJ1F+QP3bcgBXavg3CwSm4O
         qWB2yTAJWVYMzAZ6/IxQjWaJRPN+qdsrIuiYfaWCQxwW8NiW3gVyROtHyrFVo3/uVDw2
         paSbQwTlwP7sXAzaLZAMq2S9dobxKhSg+YdB7XkCz9n4HWCvagq9nXyVihJo+P4SBAi/
         uFhdAHlJaXz256zxZdUUiTFxdCInkbp3Po0YYDqFdgZ57eUJMsVbr/B1xC361dOrsEGe
         hXn6AqQ1beyQ0ED1583VI1VtRYMWmziD4OdqP93kTB/g4K4BIclSx40PWK7jd/mrr5bp
         +oqw==
X-Gm-Message-State: AOAM533Efp2qTrkJI0P7P+0NL2eJmvmm2SBtLmoN37BXnN4nB46QFZiz
        NwvxSXtwOqLX9nGAJJvzvtHcqw==
X-Google-Smtp-Source: ABdhPJyV35Ns5DEUYCeGNCpVA1uruPi+Fnfk0mcLxQ2Zj2MybuJmw6RqiKdTR6jpAPSU61eEQt+3AA==
X-Received: by 2002:a5d:80cc:: with SMTP id h12mr6672181ior.57.1632164369777;
        Mon, 20 Sep 2021 11:59:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r16sm9188637ilj.77.2021.09.20.11.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:59:29 -0700 (PDT)
Date:   Mon, 20 Sep 2021 14:59:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        calbabreaker@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/3] sparse-checkout: refuse to add to bad patterns
Message-ID: <YUjaEGtts6R6b/wK@nand.local>
References: <pull.1043.git.1632160658.gitgitgadget@gmail.com>
 <d513b28b75189d066f9c66de44a1a578cbc38139.1632160658.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d513b28b75189d066f9c66de44a1a578cbc38139.1632160658.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 05:57:38PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When in cone mode sparse-checkout, it is unclear how 'git
> sparse-checkout add <dir1> ...' should behave if the existing
> sparse-checkout file does not match the cone mode patterns. Change the
> behavior to fail with an error message about the existing patterns.
>
> Also, all cone mode patterns start with a '/' character, so add that
> restriction. This is necessary for our example test 'cone mode: warn on
> bad pattern', but also requires modifying the example sparse-checkout
> file we use to test the warnings related to recognizing cone mode
> patterns.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/sparse-checkout.c          |  3 +++
>  dir.c                              |  2 +-
>  t/t1091-sparse-checkout-builtin.sh | 11 +++++++----
>  3 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index fe76c3eedda..2492ae828a9 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -513,6 +513,9 @@ static void add_patterns_cone_mode(int argc, const char **argv,
>  		die(_("unable to load existing sparse-checkout patterns"));
>  	free(sparse_filename);
>
> +	if (!existing.use_cone_patterns)
> +		die(_("existing sparse-checkout patterns do not use cone mode"));
> +

Makes sense.

>  	hashmap_for_each_entry(&existing.recursive_hashmap, &iter, pe, ent) {
>  		if (!hashmap_contains_parent(&pl->recursive_hashmap,
>  					pe->pattern, &buffer) ||
> diff --git a/dir.c b/dir.c
> index 03c4d212672..93136442103 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -727,7 +727,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
>  	}
>
>  	if (given->patternlen < 2 ||
> -	    *given->pattern == '*' ||
> +	    *given->pattern != '/' ||

Makes sense that we require cone-mode patterns to start with '/', which
necessarily means we want to drop the other arm `*given->pattern == '*'`.

>  	    strstr(given->pattern, "**")) {
>  		/* Not a cone pattern. */
>  		warning(_("unrecognized pattern: '%s'"), given->pattern);
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index af0acd32bd9..780c6a1aaae 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -108,14 +108,17 @@ test_expect_success 'switching to cone mode with non-cone mode patterns' '
>  	git -C bad-patterns sparse-checkout init &&
>  	git -C bad-patterns sparse-checkout add dir &&
>  	git -C bad-patterns config core.sparseCheckoutCone true &&
> -	git -C bad-patterns sparse-checkout add dir &&
> +
> +	test_must_fail git -C bad-patterns sparse-checkout add dir 2>err &&
> +	grep "existing sparse-checkout patterns do not use cone mode" err &&
>
>  	git -C bad-patterns sparse-checkout init --cone &&
>  	cat >expect <<-\EOF &&
>  	/*
>  	!/*/
>  	EOF
> -	test_cmp expect bad-patterns/.git/info/sparse-checkout
> +	test_cmp expect bad-patterns/.git/info/sparse-checkout &&
> +	git -C bad-patterns sparse-checkout add dir

Good thinking to make sure that we can add `dir` after clearing. But
let's check the contents of the sparse-checkout file to make sure that
it was added in cone mode.

>  '
>
>  test_expect_success 'interaction with clone --no-checkout (unborn index)' '
> @@ -182,9 +185,9 @@ test_expect_success 'set sparse-checkout using --stdin' '
>  test_expect_success 'add to sparse-checkout' '
>  	cat repo/.git/info/sparse-checkout >expect &&
>  	cat >add <<-\EOF &&
> -	pattern1
> +	/pattern1
>  	/folder1/
> -	pattern2
> +	/pattern2
>  	EOF
>  	cat add >>expect &&
>  	git -C repo sparse-checkout add --stdin <add &&

Hmm. Does this new restriction apply to patterns given over the
command-line? (It looks like we handle the two slightly differently, so
I wonder if we are expecting users to write "git sparse-checkout add
/foo" instead of "... add foo" as a consequence).

Thanks,
Taylor
