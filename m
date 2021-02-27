Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C8FC433DB
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 12:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 263FF64ECE
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 12:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhB0Mdk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 07:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhB0Mdj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Feb 2021 07:33:39 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9702BC06174A
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 04:32:58 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v15so11208492wrx.4
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 04:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6wINhuz5Ax7wozwtl+maaidhlZN+roe3YCW0iJcvnFM=;
        b=dmMRGLMweuOlpP4ElhU5Yp1TizSnBCJosnDdEopgQW2DT+vVds+l6pjQ+xkkWwU3Ec
         10Hlc0GZfIhq8OsJP251QxeMgG2nJO0Cd/VAi8mVTg6Nc2NPEz+SFArdY56ylczdQm8n
         pHhEYxy00AVwFNq5XjahkEsZAlXsyWIeaVhUtlbjmYcBdLDUf0lo+ZNgYv5FwLG4OZgO
         O6O9dGHdnaAR2BXNaj8wxh2v1K2dX0rX9XsxAD66qfDQISwNlqlRUXLsPhQJrE3G5OKJ
         jsCDhGJ9pWhVcAIU8dPq9dEMMeUoP4dtXMUSoU2zlEaIU+i/hFQRFbyE6gcQXavDNFg+
         rNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6wINhuz5Ax7wozwtl+maaidhlZN+roe3YCW0iJcvnFM=;
        b=mWfRn/wrGvlkcCsbRZvuT956JS67eSIYCZPNa6k0HvNU92d87o9AGT1pelPbEJNvDP
         qyFE98ohMxWaBOMCXWM9VXWh7jm44s+LeiimZRvo+rfLoPB9JTWvipPl/KwY7rrWftrU
         bbiIgae9nEPjAoEr0HxsZUcjlXOJEZYYeg3fnwO62EMYzfcompH7eFAQf84WM+xDr9zw
         SIq5VtG35B93osjdSAHikMrkFNv6rYxDGkFKiUVQGfqNHzKRgpIGqpU2x4SfKfoExZXE
         ClSk8SSIetlphq4srhtwcci6o9LnuQmAvLo48SIq0KBzrGGesxIkWBllssBB2/kiGBDn
         3dEQ==
X-Gm-Message-State: AOAM532+4ol8kXGqkjcODyFg3+62TtwvDJtX4p5gMAwRIvTnfJ9JSRwl
        nMFB5ZHHIj53EGerdKNCzU4=
X-Google-Smtp-Source: ABdhPJyxaX00GiW1urTbn+hzVcccD4kjORkm/qy6ks++xOjTCUYgrpDV95osN3TMT3sZ5dlTkz2QFA==
X-Received: by 2002:a5d:6147:: with SMTP id y7mr7917021wrt.306.1614429177361;
        Sat, 27 Feb 2021 04:32:57 -0800 (PST)
Received: from szeder.dev (92-249-246-249.pool.digikabel.hu. [92.249.246.249])
        by smtp.gmail.com with ESMTPSA id c3sm17745406wrr.29.2021.02.27.04.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 04:32:57 -0800 (PST)
Date:   Sat, 27 Feb 2021 13:32:53 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        pclouds@gmail.com, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 17/20] sparse-checkout: disable sparse-index
Message-ID: <20210227123253.GC3590451@szeder.dev>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <bcf960ef2362e32e2f8d7e06a31a925936f62bc1.1614111270.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bcf960ef2362e32e2f8d7e06a31a925936f62bc1.1614111270.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 08:14:26PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> We use 'git sparse-checkout init --cone --sparse-index' to toggle the
> sparse-index feature. It makes sense to also disable it when running
> 'git sparse-checkout disable'. This is particularly important because it
> removes the extensions.sparseIndex config option, allowing other tools
> to use this Git repository again.
> 
> This does mean that 'git sparse-checkout init' will not re-enable the
> sparse-index feature, even if it was previously enabled.
> 
> While testing this feature, I noticed that the sparse-index was not
> being written on the first run, but by a second. This was caught by the
> call to 'test-tool read-cache --table'. This requires adjusting some
> assignments to core_apply_sparse_checkout and pl.use_cone_patterns in
> the sparse_checkout_init() logic.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/sparse-checkout.c          | 10 +++++++++-
>  t/t1091-sparse-checkout-builtin.sh | 13 +++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index ca63e2c64e95..585343fa1972 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -280,6 +280,9 @@ static int set_config(enum sparse_checkout_mode mode)
>  				      "core.sparseCheckoutCone",
>  				      mode == MODE_CONE_PATTERNS ? "true" : NULL);
>  
> +	if (mode == MODE_NO_PATTERNS)
> +		set_sparse_index_config(the_repository, 0);
> +
>  	return 0;
>  }
>  
> @@ -341,10 +344,11 @@ static int sparse_checkout_init(int argc, const char **argv)
>  		the_repository->index->updated_workdir = 1;
>  	}
>  
> +	core_apply_sparse_checkout = 1;
> +
>  	/* If we already have a sparse-checkout file, use it. */
>  	if (res >= 0) {
>  		free(sparse_filename);
> -		core_apply_sparse_checkout = 1;
>  		return update_working_directory(NULL);
>  	}
>  
> @@ -366,6 +370,7 @@ static int sparse_checkout_init(int argc, const char **argv)
>  	add_pattern(strbuf_detach(&pattern, NULL), empty_base, 0, &pl, 0);
>  	strbuf_addstr(&pattern, "!/*/");
>  	add_pattern(strbuf_detach(&pattern, NULL), empty_base, 0, &pl, 0);
> +	pl.use_cone_patterns = init_opts.cone_mode;
>  
>  	return write_patterns_and_update(&pl);
>  }
> @@ -632,6 +637,9 @@ static int sparse_checkout_disable(int argc, const char **argv)
>  	strbuf_addstr(&match_all, "/*");
>  	add_pattern(strbuf_detach(&match_all, NULL), empty_base, 0, &pl, 0);
>  
> +	prepare_repo_settings(the_repository);
> +	the_repository->settings.sparse_index = 0;
> +
>  	if (update_working_directory(&pl))
>  		die(_("error while refreshing working directory"));
>  
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index fc64e9ed99f4..ff1ad570a255 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -205,6 +205,19 @@ test_expect_success 'sparse-checkout disable' '
>  	check_files repo a deep folder1 folder2
>  '
>  
> +test_expect_success 'sparse-index enabled and disabled' '
> +	git -C repo sparse-checkout init --cone --sparse-index &&
> +	test_cmp_config -C repo true extensions.sparseIndex &&
> +	test-tool -C repo read-cache --table >cache &&
> +	grep " tree " cache &&
> +
> +	git -C repo sparse-checkout disable &&
> +	test-tool -C repo read-cache --table >cache &&
> +	! grep " tree " cache &&
> +	git -C repo config --list >config &&
> +	! grep extensions.sparseindex config
> +'

This test passes with GIT_TEST_SPLIT_INDEX=1 at the moment, because,
unfortunately, GIT_TEST_SPLIT_INDEX has been broken for the past two
years.  However, if I run it with my WIP fixes for that issue [1],
then it will fail:

  +git -C repo sparse-checkout init --cone --sparse-index
  +test_cmp_config -C repo true extensions.sparseIndex
  +test-tool -C repo read-cache --table
  +grep  tree  cache
  error: last command exited with $?=1
  not ok 16 - sparse-index enabled and disabled

https://travis-ci.com/github/szeder/git-cooking-topics-for-travis-ci/jobs/486702444#L2594

[1] Try to run it with:

      https://github.com/szeder/git split-index-fixes

    The code is, I believe, close to final, the commit messages,
    however, are far from being finished.


> +
>  test_expect_success 'cone mode: init and set' '
>  	git -C repo sparse-checkout init --cone &&
>  	git -C repo config --list >config &&
> -- 
> gitgitgadget
> 
