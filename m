Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632C4C18E5B
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 16:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F1E206BE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 16:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsoWUrvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgCOQTi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 12:19:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42465 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgCOQTi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 12:19:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id 66so15295452otd.9
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 09:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bH6ziV17SrisyYV6kB63qbe9dKTIN2A//8mphIJwmOs=;
        b=gsoWUrvhb43/Mg6lobjOU2kbuiXk+B5Bm8/geylGvGeXCRxs+bB1ORBhMaltzQQS5D
         H5ObH56mYcbEGDsB/umw3/mc+UOcMreFb+Dh3IFFij3hHeJYWhdFTZr6KEHNCjv6XkZg
         s1XCCS5NDCUWUcnMChCB6C3O/ebBYVnxrhtLPdMLK/T5xeeKa6GgFPKfY4YAaInu49Sy
         STIbTVs+FHTI+0P/AgjHEVvng/m4QS0xWB2+Xz0YwSIUISarZR6FjVndUAqgC5s6F73M
         4+Gh3rBe2Av7QQ80ZCS0CtZ4nQiK7D5bz9PHrykvLTtUkLjnQz3sgmpUPeWHxrCuHJ1q
         vG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bH6ziV17SrisyYV6kB63qbe9dKTIN2A//8mphIJwmOs=;
        b=ezXZxcqnQPRsniyKcTSSn6HMoSltTFr+Z7HpPllma+m/oEHvf0eGoAIheVqvq0BAVS
         3L0lcZ+rdt2PO+MQcQHX9KyAc/nOvDhFsnwfe2a+mbR7vHtP49BDeCNZup0viMbXBL/P
         RzDQmmbG7HgEFGLy+mgV0a/G9iZW3sS7h1etbm2MUggIWvxk7r64Oo4JsvJcjeEnG7Td
         mu9fpLVijcMylBahvFCUp0BmhMW9A0MVHWahPRtdwLndJYAbCczc73ZQrRjluFpehg9a
         x4p46xSzNk3PTBWLIaecXNJH9I3AoQ1NkOpcWmherMDKfLWHS2LraasEqgTiMg3YynHV
         JecQ==
X-Gm-Message-State: ANhLgQ3iY3pAx/VX9XbRxMPAahvMvHdPyAnAYadjjf+gHYJ2Gdduz6AZ
        yrMNrASHscFLH/tEIOXOzeU=
X-Google-Smtp-Source: ADFU+vtTIXw2XVTlLKSSyiOdAncCXTwbtyYtDcz2e/FKlIP6bue5a5CaNDhyFH7K/QIGRKtBCjcEUg==
X-Received: by 2002:a05:6830:1db3:: with SMTP id z19mr8586729oti.270.1584289176915;
        Sun, 15 Mar 2020 09:19:36 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id r8sm3555071otc.73.2020.03.15.09.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2020 09:19:36 -0700 (PDT)
Subject: Re: [PATCH 6/7] sparse-checkout: use new update_sparsity() function
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <892933752c638a9ed938e046e466dd1e927058a6.1584169893.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1c83fb68-519a-88f2-77b9-ab443ed6b4cf@gmail.com>
Date:   Sun, 15 Mar 2020 12:19:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101
 Thunderbird/74.0
MIME-Version: 1.0
In-Reply-To: <892933752c638a9ed938e046e466dd1e927058a6.1584169893.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/14/2020 3:11 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Remove the equivalent of 'git read-tree -mu HEAD' in the sparse-checkout
> codepaths for setting the SKIP_WORKTREE bits and instead use the new
> update_sparsity() function.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/sparse-checkout.c          | 39 +++++++-----------------------
>  t/t1091-sparse-checkout-builtin.sh | 32 +++++++++++++++++-------
>  2 files changed, 32 insertions(+), 39 deletions(-)
> 
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 740da4b6d54..5d3ec2e6be9 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -97,47 +97,32 @@ static int update_working_directory(struct pattern_list *pl)
>  	int result = 0;
>  	struct unpack_trees_options o;
>  	struct lock_file lock_file = LOCK_INIT;
> -	struct object_id oid;
> -	struct tree *tree;
> -	struct tree_desc t;
>  	struct repository *r = the_repository;
>  
> -	if (repo_read_index_unmerged(r))
> -		die(_("you need to resolve your current index first"));
> -
> -	if (get_oid("HEAD", &oid))
> -		return 0;
> -
> -	tree = parse_tree_indirect(&oid);
> -	parse_tree(tree);
> -	init_tree_desc(&t, tree->buffer, tree->size);
> -
>  	memset(&o, 0, sizeof(o));
>  	o.verbose_update = isatty(2);
> -	o.merge = 1;
>  	o.update = 1;
> -	o.fn = oneway_merge;

I'm glad this is getting much simpler.

>  	o.head_idx = -1;
>  	o.src_index = r->index;
>  	o.dst_index = r->index;
>  	o.skip_sparse_checkout = 0;
>  	o.pl = pl;
> -	o.keep_pattern_list = !!pl;

I'm making a mental note to see if this is necessary or not. I'm
guessing that update_sparsity() expects a pattern list as input and
will never free it, so this option is useless.

> -	resolve_undo_clear_index(r->index);
>  	setup_work_tree();
>  
> -	cache_tree_free(&r->index->cache_tree);
> -
>  	repo_hold_locked_index(r, &lock_file, LOCK_DIE_ON_ERROR);
>  
> -	core_apply_sparse_checkout = 1;
> -	result = unpack_trees(1, &t, &o);
> +	result = update_sparsity(&o);
>  
> -	if (!result) {
> -		prime_cache_tree(r, r->index, tree);
> +	if (result == 1)
I wonder if it is appropriate to return an enum in update_sparsity()
so this statement is clearer out-of-context. For example, I'm looking
at this patch before looking closely at the update_sparsity() patch
so I know how it will be used before I check its implementation.

> +		/*
> +		 * We don't do any special handling of warnings from untracked
> +		 * files in the way or dirty entries that can't be removed.
> +		 */
> +		result = 0;
> +	if (!result)
>  		write_locked_index(r->index, &lock_file, COMMIT_LOCK);
> -	} else
> +	else
>  		rollback_lock_file(&lock_file);
>  
>  	return result;
> @@ -304,8 +289,6 @@ static int sparse_checkout_init(int argc, const char **argv)
>  	};
>  
>  	repo_read_index(the_repository);
> -	require_clean_work_tree(the_repository,
> -				N_("initialize sparse-checkout"), NULL, 1, 0);
>  
>  	argc = parse_options(argc, argv, NULL,
>  			     builtin_sparse_checkout_init_options,
> @@ -560,8 +543,6 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
>  	};
>  
>  	repo_read_index(the_repository);
> -	require_clean_work_tree(the_repository,
> -				N_("set sparse-checkout patterns"), NULL, 1, 0);
>  
>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_sparse_checkout_set_options,
> @@ -577,8 +558,6 @@ static int sparse_checkout_disable(int argc, const char **argv)
>  	struct strbuf match_all = STRBUF_INIT;
>  
>  	repo_read_index(the_repository);
> -	require_clean_work_tree(the_repository,
> -				N_("disable sparse-checkout"), NULL, 1, 0);

In the three hunks above, do we still need repo_read_index()?

>  	memset(&pl, 0, sizeof(pl));
>  	hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 8607a8e6d1a..0d93d3983e0 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -277,16 +277,23 @@ test_expect_success 'cone mode: add parent path' '
>  	check_files repo a deep folder1
>  '
>  
> -test_expect_success 'revert to old sparse-checkout on bad update' '
> +test_expect_success 'not-up-to-date does not block rest of sparsification' '
>  	test_when_finished git -C repo sparse-checkout disable &&
>  	test_when_finished git -C repo reset --hard &&
>  	git -C repo sparse-checkout set deep &&
> +
>  	echo update >repo/deep/deeper2/a &&
>  	cp repo/.git/info/sparse-checkout expect &&
> -	test_must_fail git -C repo sparse-checkout set deep/deeper1 2>err &&
> -	test_i18ngrep "cannot set sparse-checkout patterns" err &&
> -	test_cmp repo/.git/info/sparse-checkout expect &&
> -	check_files repo/deep a deeper1 deeper2
> +	test_write_lines "!/deep/*/" "/deep/deeper1/" >>expect &&
> +
> +	git -C repo sparse-checkout set deep/deeper1 2>err &&
> +
> +	test_i18ngrep "Cannot update sparse checkout" err &&
> +	test_cmp expect repo/.git/info/sparse-checkout &&
> +	check_files repo/deep a deeper1 deeper2 &&
> +	check_files repo/deep/deeper1 a deepest &&
> +	check_files repo/deep/deeper1/deepest a &&
> +	check_files repo/deep/deeper2 a
>  '
>  
>  test_expect_success 'revert to old sparse-checkout on empty update' '
> @@ -316,12 +323,19 @@ test_expect_success '.gitignore should not warn about cone mode' '
>  	test_i18ngrep ! "disabling cone patterns" err
>  '
>  
> -test_expect_success 'sparse-checkout (init|set|disable) fails with dirty status' '
> +test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status' '
>  	git clone repo dirty &&
>  	echo dirty >dirty/folder1/a &&
> -	test_must_fail git -C dirty sparse-checkout init &&
> -	test_must_fail git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
> -	test_must_fail git -C dirty sparse-checkout disable &&
> +
> +	git -C dirty sparse-checkout init 2>err &&
> +	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
> +
> +	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
> +	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
> +
> +	git -C dirty sparse-checkout disable &&
> +	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
> +
>  	git -C dirty reset --hard &&
>  	git -C dirty sparse-checkout init &&
>  	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&

I like that the test changes here are limited to updating existing
tests. You mentioned adding more tests, which I would also like, but
those can come in a follow-up patch that is dedicated to all the fun
situations we can get into, and how we should respond.

Here are a few that I've tested manually:

1. Start: no sparse-checkout
  a. Get into rebase conflict in a directory.
  b. "git sparse-checkout init --cone"
  c. See that the file is on-disk with conflict markers.
  d. Resolve conflict and "git add"
  e. "git sparse-checkout set <dir-without-conflict>"
  f. Sparse-checkout is set as expected, file is not on disk, but still staged.
  g. "git rebase --continue" succeeds.

2. Start: sparse-checkout set to "dir1"
  a. Get into merge conflict in "dir2"
  b. Resolve conflict, "git add"
  c. "git sparse-checkout update" (available after next patch)
  d. dir1 gone, dir1/file staged.
  e. git merge --continue succeeds

Those are the really big ones to me, but I'm sure we will find others.
I'm really happy that this is working as we expect.

Thanks!
-Stolee
