Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CD2C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 20:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbiCNUTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 16:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbiCNUTk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 16:19:40 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86641AF27
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 13:18:29 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6ABBF188795;
        Mon, 14 Mar 2022 16:18:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p1CCTIfoAYeK2TMpY+Oelbp9R3y7nAjQDcc9Vb
        S6vCE=; b=LuY4KMWLszCQA9SQms7EI2KUTHfijhkaxBgHS8hbSM5vEzSGSKqR1g
        DRRdq/fCcQToyBDrjq8uGpkuMuAcEXHfb+a7YXIib5HA/wS+oDESMHiI8X/LTfXG
        SleKk4JzdoA8RRVyvEs1e8IS7LtFT79pCDH8Ad05jpRYhhJHNN+rY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 628C5188794;
        Mon, 14 Mar 2022 16:18:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E0198188793;
        Mon, 14 Mar 2022 16:18:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/9] tests: stop assuming --no-cone is the default
 mode for sparse-checkout
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
        <05dba7069c5e0c1aec1a7206f9cbea593d8d68cb.1647054681.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 20:18:26 +0000
In-Reply-To: <05dba7069c5e0c1aec1a7206f9cbea593d8d68cb.1647054681.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 12 Mar 2022
        03:11:13 +0000")
Message-ID: <xmqqfsnkqodp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E81DF2D8-A3D3-11EC-9D80-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Add an explicit --no-cone to several sparse-checkout invocations in
> preparation for changing the default to cone mode.

"several"?

After this step, wouldn't it be a bug if in t/ there still are
"sparse-checkout init" or "sparse-checkout set" invocations for a
given test repository for the first time that do not mention
"--cone" or "--no-cone"?

I am mostly asking for the criteria for reviewers to decide if they
spotted a bug or if it is expected omission when they spot, say,
"sparse-checkout init" without either.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t1091-sparse-checkout-builtin.sh | 15 ++++++++-------
>  t/t3602-rm-sparse-checkout.sh      |  6 +++---
>  t/t3705-add-sparse-checkout.sh     |  4 ++--
>  t/t6428-merge-conflicts-sparse.sh  |  4 ++--
>  t/t7002-mv-sparse-checkout.sh      |  2 +-
>  t/t7012-skip-worktree-writing.sh   |  2 +-
>  6 files changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 9a900310186..de1ec89007d 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -72,7 +72,7 @@ test_expect_success 'git sparse-checkout list (populated)' '
>  '
>  
>  test_expect_success 'git sparse-checkout init' '
> -	git -C repo sparse-checkout init &&
> +	git -C repo sparse-checkout init --no-cone &&
>  	cat >expect <<-\EOF &&
>  	/*
>  	!/*/
> @@ -111,6 +111,7 @@ test_expect_success 'init with existing sparse-checkout' '
>  
>  test_expect_success 'clone --sparse' '
>  	git clone --sparse "file://$(pwd)/repo" clone &&
> +	git -C clone sparse-checkout reapply --no-cone &&
>  	git -C clone sparse-checkout list >actual &&
>  	cat >expect <<-\EOF &&
>  	/*
> @@ -124,7 +125,7 @@ test_expect_success 'switching to cone mode with non-cone mode patterns' '
>  	git init bad-patterns &&
>  	(
>  		cd bad-patterns &&
> -		git sparse-checkout init &&
> +		git sparse-checkout init --no-cone &&
>  		git sparse-checkout add dir &&
>  		git config --worktree core.sparseCheckoutCone true &&
>  		test_must_fail git sparse-checkout add dir 2>err &&
> @@ -402,7 +403,7 @@ test_expect_success 'revert to old sparse-checkout on empty update' '
>  		git sparse-checkout set nothing 2>err &&
>  		test_i18ngrep ! "Sparse checkout leaves no entry on working directory" err &&
>  		test_i18ngrep ! ".git/index.lock" err &&
> -		git sparse-checkout set file
> +		git sparse-checkout set --no-cone file
>  	)
>  '
>  
> @@ -424,7 +425,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status'
>  	git clone repo dirty &&
>  	echo dirty >dirty/folder1/a &&
>  
> -	git -C dirty sparse-checkout init 2>err &&
> +	git -C dirty sparse-checkout init --no-cone 2>err &&
>  	test_i18ngrep "warning.*The following paths are not up to date" err &&
>  
>  	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* 2>err &&
> @@ -435,7 +436,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status'
>  	test_must_be_empty err &&
>  
>  	git -C dirty reset --hard &&
> -	git -C dirty sparse-checkout init &&
> +	git -C dirty sparse-checkout init --no-cone &&
>  	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
>  	test_path_is_missing dirty/folder1/a &&
>  	git -C dirty sparse-checkout disable &&
> @@ -451,7 +452,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with unmerged stat
>  	EOF
>  	git -C unmerged update-index --index-info <input &&
>  
> -	git -C unmerged sparse-checkout init 2>err &&
> +	git -C unmerged sparse-checkout init --no-cone 2>err &&
>  	test_i18ngrep "warning.*The following paths are unmerged" err &&
>  
>  	git -C unmerged sparse-checkout set /folder2/* /deep/deeper1/* 2>err &&
> @@ -462,7 +463,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with unmerged stat
>  	test_i18ngrep "warning.*The following paths are unmerged" err &&
>  
>  	git -C unmerged reset --hard &&
> -	git -C unmerged sparse-checkout init &&
> +	git -C unmerged sparse-checkout init --no-cone &&
>  	git -C unmerged sparse-checkout set /folder2/* /deep/deeper1/* &&
>  	git -C unmerged sparse-checkout disable
>  '
> diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
> index 034ec010910..08580fd3dcc 100755
> --- a/t/t3602-rm-sparse-checkout.sh
> +++ b/t/t3602-rm-sparse-checkout.sh
> @@ -30,7 +30,7 @@ test_expect_success 'setup' "
>  for opt in "" -f --dry-run
>  do
>  	test_expect_success "rm${opt:+ $opt} does not remove sparse entries" '
> -		git sparse-checkout set a &&
> +		git sparse-checkout set --no-cone a &&
>  		test_must_fail git rm $opt b 2>stderr &&
>  		test_cmp b_error_and_hint stderr &&
>  		git ls-files --error-unmatch b
> @@ -118,7 +118,7 @@ test_expect_success 'can remove files from non-sparse dir' '
>  	test_commit w/f &&
>  	test_commit x/y/f &&
>  
> -	git sparse-checkout set w !/x y/ &&
> +	git sparse-checkout set --no-cone w !/x y/ &&
>  	git rm w/f.t x/y/f.t 2>stderr &&
>  	test_must_be_empty stderr
>  '
> @@ -128,7 +128,7 @@ test_expect_success 'refuse to remove non-skip-worktree file from sparse dir' '
>  	git sparse-checkout disable &&
>  	mkdir -p x/y/z &&
>  	test_commit x/y/z/f &&
> -	git sparse-checkout set !/x y/ !x/y/z &&
> +	git sparse-checkout set --no-cone !/x y/ !x/y/z &&
>  
>  	git update-index --no-skip-worktree x/y/z/f.t &&
>  	test_must_fail git rm x/y/z/f.t 2>stderr &&
> diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
> index 95609046c61..2bade9e804f 100755
> --- a/t/t3705-add-sparse-checkout.sh
> +++ b/t/t3705-add-sparse-checkout.sh
> @@ -166,7 +166,7 @@ test_expect_success 'do not warn when pathspec matches dense entries' '
>  test_expect_success 'git add fails outside of sparse-checkout definition' '
>  	test_when_finished git sparse-checkout disable &&
>  	test_commit a &&
> -	git sparse-checkout init &&
> +	git sparse-checkout init --no-cone &&
>  	git sparse-checkout set a &&
>  	echo >>sparse_entry &&
>  
> @@ -208,7 +208,7 @@ test_expect_success 'add obeys advice.updateSparsePath' '
>  '
>  
>  test_expect_success 'add allows sparse entries with --sparse' '
> -	git sparse-checkout set a &&
> +	git sparse-checkout set --no-cone a &&
>  	echo modified >sparse_entry &&
>  	test_must_fail git add sparse_entry &&
>  	test_sparse_entry_unchanged &&
> diff --git a/t/t6428-merge-conflicts-sparse.sh b/t/t6428-merge-conflicts-sparse.sh
> index 142c9aaabc5..064be1b629e 100755
> --- a/t/t6428-merge-conflicts-sparse.sh
> +++ b/t/t6428-merge-conflicts-sparse.sh
> @@ -87,7 +87,7 @@ test_expect_success 'conflicting entries written to worktree even if sparse' '
>  		test_path_is_file numerals &&
>  
>  		git sparse-checkout init &&
> -		git sparse-checkout set README &&
> +		git sparse-checkout set --no-cone README &&
>  
>  		test_path_is_file README &&
>  		test_path_is_missing numerals &&
> @@ -123,7 +123,7 @@ test_expect_success 'present-despite-SKIP_WORKTREE handled reasonably' '
>  		test_path_is_file numerals &&
>  
>  		git sparse-checkout init &&
> -		git sparse-checkout set README &&
> +		git sparse-checkout set --no-cone README &&
>  
>  		test_path_is_file README &&
>  		test_path_is_missing numerals &&
> diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
> index 1d3d2aca21c..f0f7cbfcdb7 100755
> --- a/t/t7002-mv-sparse-checkout.sh
> +++ b/t/t7002-mv-sparse-checkout.sh
> @@ -27,7 +27,7 @@ test_expect_success 'setup' "
>  test_expect_success 'mv refuses to move sparse-to-sparse' '
>  	test_when_finished rm -f e &&
>  	git reset --hard &&
> -	git sparse-checkout set a &&
> +	git sparse-checkout set --no-cone a &&
>  	touch b &&
>  	test_must_fail git mv b e 2>stderr &&
>  	cat sparse_error_header >expect &&
> diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
> index cb9f1a6981e..cd5c20fe51b 100755
> --- a/t/t7012-skip-worktree-writing.sh
> +++ b/t/t7012-skip-worktree-writing.sh
> @@ -151,7 +151,7 @@ test_expect_success 'stash restore in sparse checkout' '
>  
>  		git stash push &&
>  
> -		git sparse-checkout set subdir &&
> +		git sparse-checkout set --no-cone subdir &&
>  
>  		# Ensure after sparse-checkout we only have expected files
>  		cat >expect <<-EOF &&
