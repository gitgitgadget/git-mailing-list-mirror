Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1056C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 04:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA7A60F93
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 04:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhJVEWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 00:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhJVEWN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 00:22:13 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120D3C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 21:19:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u6so1871465ple.2
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 21:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U80JbOrLJ3yzZYZ6UzF+V3VhgYhCEyK2YFB1rIzSCYc=;
        b=j5zV2MbvLdlLnjZnNW2Eu6uDIXmunCRAMEhSEdvAjmX89Qb9TIAJgDImZ01GD1x/HS
         z57ECmBWtsawV5xXPnYNjuMsaGtn1qLqR3l0p9jsRXTM1hxSzKVbRnngfbXw16Rag9TK
         ePBxRxqv2o2kHuir+/VRAzS1LVlL+XNffyzACrc65qnKpJuxak3FdZSDpqySiXUoytsb
         JSISoLgypsyXuMm1iIY9f0F549/bW2uS7gmi+2/2ACfSt6xXbT2xQmGulCkwHidqYPz/
         ImQA8CaRhJXrk1sO546ISnLx9WR4nJMqYFMHUWTAC4xkV8vXIX3nOgvfPuEKRAwtRgN/
         nDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U80JbOrLJ3yzZYZ6UzF+V3VhgYhCEyK2YFB1rIzSCYc=;
        b=dEdttJSUH1FAGQ15k8PEOf3UY9O7PUbDiOusUH1R/osTDYXS5v8UU9hQE5iodY0fYM
         D7mn4dAGJCJizOzEKNLV9GzBTyBb89Z4qjRIBVvSbN0gWE+cWBMRREhGpQ4/XgFNlveP
         5CuZVT11iEjg0RYLYC2072OBvo6iyFbNpOBUtLjxCKsXbSIw01NLYN2euGA6uUge9kyH
         yepW2ZfvmZqFoU6H8rTHZI+tGJuorlvffOyA2BkRQlj9dV7tVqAODXn7/c1ZiOMs+U42
         UGrn5oworxgeR3WVmF4SaR3awjRpUqFNUsqx6yRyOqiRRoh5HzoyQ1TWN66BNzejC00/
         5ayw==
X-Gm-Message-State: AOAM532e5FK6iwHfv256kD+ILD5vzdG9nbcFd2lyL+1ZykUcZ2g7w4Up
        N0QpIjT8UjIjmgP1oGbet22ORg==
X-Google-Smtp-Source: ABdhPJxHO7PsKmBKV3CcqnVy6+norTq0yrwLdBbKJaoZtkYognKhiIofDElhYq0q/KbRcp1lxSsx6w==
X-Received: by 2002:a17:903:244f:b0:140:122e:c2a7 with SMTP id l15-20020a170903244f00b00140122ec2a7mr3100068pls.85.1634876396076;
        Thu, 21 Oct 2021 21:19:56 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3866:91e2:ded9:17f2])
        by smtp.gmail.com with ESMTPSA id b19sm6811528pgs.33.2021.10.21.21.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 21:19:55 -0700 (PDT)
Date:   Thu, 21 Oct 2021 21:19:50 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        newren@gmail.com, Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v4 2/8] reset: preserve skip-worktree bit in mixed reset
Message-ID: <YXI75uFLdk2mnP7g@google.com>
References: <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
 <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
 <bd72bd175da52a167c27bfba1310e050d9e33a50.1633984222.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd72bd175da52a167c27bfba1310e050d9e33a50.1633984222.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 11, 2021 at 08:30:16PM +0000, Victoria Dye via GitGitGadget wrote:
> diff --git a/builtin/reset.c b/builtin/reset.c
> index d3695ce43c4..e441b6601b9 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -25,6 +25,7 @@
>  #include "cache-tree.h"
>  #include "submodule.h"
>  #include "submodule-config.h"
> +#include "dir.h"
>  
>  #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
>  
> @@ -141,6 +143,18 @@ static void update_index_from_diff(struct diff_queue_struct *q,
>  
>  		ce = make_cache_entry(&the_index, one->mode, &one->oid, one->path,
>  				      0, 0);
> +
> +		/*
> +		 * If the file 1) corresponds to an existing index entry with
> +		 * skip-worktree set, or 2) does not exist in the index but is
> +		 * outside the sparse checkout definition, add a skip-worktree bit
> +		 * to the new index entry.
> +		 */
> +		pos = cache_name_pos(one->path, strlen(one->path));
> +		if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) ||
> +		    (pos < 0 && !path_in_sparse_checkout(one->path, &the_index)))
> +			ce->ce_flags |= CE_SKIP_WORKTREE;

To put it another way and check my understanding (because I'm not
familiar with the sparse-index yet): if the file exists in the index but
we didn't care about the worktree anyway, then skip it; if the file
doesn't exist in the index but it also isn't in the sparse-checkout
cone, then also skip it, because we don't care about the file anyway.

I was going to ask if we could check ce_skip_worktree() without checking
pos first, but I suppose a negative pos would make the array deref
pretty unhappy. Ok.

> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 886e78715fe..889079f55b8 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -459,26 +459,17 @@ test_expect_failure 'blame with pathspec outside sparse definition' '
>  	test_all_match git blame deep/deeper2/deepest/a
>  '
>  
> -# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
> -# in this scenario, but it shouldn't.
> -test_expect_failure 'checkout and reset (mixed)' '
> +test_expect_success 'checkout and reset (mixed)' '

Ooh ooh, we can start using these tests :) Always exciting.

>  	init_repos &&
>  
>  	test_all_match git checkout -b reset-test update-deep &&
>  	test_all_match git reset deepest &&
> -	test_all_match git reset update-folder1 &&
> -	test_all_match git reset update-folder2
> -'
> -
> -# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
> -# in this scenario, but it shouldn't.
> -test_expect_success 'checkout and reset (mixed) [sparse]' '
> -	init_repos &&
>  
> -	test_sparse_match git checkout -b reset-test update-deep &&
> -	test_sparse_match git reset deepest &&
> +	# Because skip-worktree is preserved, resetting to update-folder1
> +	# will show worktree changes for full-checkout that are not present
> +	# in sparse-checkout or sparse-index.

This doesn't really have anything to do with your patch. But I'm having
a very hard time understanding what each branch you're switching between
and basing on is for; this entire test suite is a little miserly with
comments. I *think* your comment is saying that you're not bothering to
check test_all_match because you know that the full-checkout tree won't
match? But I also don't see that being asserted; test_sparse_match looks
to compare sparse-checkout and sparse-index trees but doesn't say
anything at all about the full-checkout tree, right?

>  	test_sparse_match git reset update-folder1 &&
> -	test_sparse_match git reset update-folder2
> +	run_on_sparse test_path_is_missing folder1
>  '
>  
>  test_expect_success 'merge, cherry-pick, and rebase' '
> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index 601b2bf97f0..d05426062ec 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> @@ -472,6 +472,23 @@ test_expect_success '--mixed refreshes the index' '
>  	test_cmp expect output
>  '
>  
> +test_expect_success '--mixed preserves skip-worktree' '
> +	echo 123 >>file2 &&

file2 is just in the worktree...

> +	git add file2 &&

...and now it's in the index...

> +	git update-index --skip-worktree file2 &&

...and now we're asking Git to ignore worktree changes to file2...

> +	git reset --mixed HEAD >output &&

But now I'm a little confused, maybe because of 'git reset' syntax. I'd
expect this to say "ah yes, the index is different from HEAD, it's got
this file2 thingie" and still reset the index; I'm surprised that
--skip-worktree, which sounds like it's saying only "don't consider
what's going on in the worktree". So I would expect this to still delete
file2 from the index. But instead I guess it is keeping file2 in the
index with the "who cares what happened in the wt" marker?

> +	test_must_be_empty output &&
> +
> +	cat >expect <<-\EOF &&
> +	Unstaged changes after reset:
> +	M	file2
> +	EOF
> +	git update-index --no-skip-worktree file2 &&
> +	git add file2 &&
> +	git reset --mixed HEAD >output &&
> +	test_cmp expect output
> +'
> +
>  test_expect_success 'resetting specific path that is unmerged' '
>  	git rm --cached file2 &&
>  	F1=$(git rev-parse HEAD:file1) &&
> -- 
> gitgitgadget
> 
