Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA870208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 14:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbeHFQfB (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 12:35:01 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33168 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeHFQfA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 12:35:00 -0400
Received: by mail-qk0-f196.google.com with SMTP id 27-v6so9016227qkv.0
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 07:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mISuNfD9wk2h/beUC18eAN6MMirxMEoaHVYi+y5glxg=;
        b=Lsujbuz4ustuhI1ZLvQpDDvQ5izP0TqHZIWd2FdcN8vVJ+vhHgjuyo9ugw/rC+p3lW
         f+H4hQa8CsBmHv0qCYjXubgbm9w80vMF0TRJscchlIaraWY9rW4Cldlivci8yDkMoTpe
         pZXCNJhhs6Aj//WUnHxaqXYvAHCiY6WpEhBvMcNAhMlL1jhmpFfWR/zG5xX1F4dVHgn2
         h8rISnAYQSEBuWxTn+mJFRoKX+FVY8vKKoWvP5bXNVo3sMwsJKH5QLK/0+iC+FNbcZ7s
         Q3xx4ImPTNcANIaKo1dOhN0n+HoP4S76KliM/y/630KDG3J0zQh3/36ev6cabDcZAXhS
         ke6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mISuNfD9wk2h/beUC18eAN6MMirxMEoaHVYi+y5glxg=;
        b=jWOg56EOfT6ADHgljn3brjl1Mi6z0lnfWzR1HzEoBqHxbUMOBUPFyUgZhbhnNUqSI+
         IHXsuRx6fK2qewYR9XhXOoXzN5cOczHXQqm0DRCXFAuEnUIF2oOTUbYljiAHzef+cQUt
         pGP3fSVeocf/dZILMjkajaRF4/v+w5xG2AiO7Q2CfGrfj7VYdnuU4aZjg+qGsf9ARiAQ
         cd3DdYGivEKTcV0KMF/QqyHx+25nmtcPj5JckUJTepegsO4aMzawRoIGTq0yb9Rin1UX
         WfGKtc1SxwM5/UpjREQteiVR5pppeKz95S2yZZezqts7GUophlLMDFZom6MDniotSsWN
         K19Q==
X-Gm-Message-State: AOUpUlG8JwLAyBx9CABJtjcEMbqihCtCzUZX8Hf5dGs6IM9f8OlAtAqa
        eTkxjXIXPp0mbifpw9sKOeE=
X-Google-Smtp-Source: AAOMgpcWyh66ZeKXNLCbsSRsHrZ+G5+Ve6BeomSj0tk+WKr2BatX8iqOa4nebs0sDsg5Ibj0qZpYfA==
X-Received: by 2002:a37:a704:: with SMTP id q4-v6mr13795311qke.325.1533565538596;
        Mon, 06 Aug 2018 07:25:38 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id h36-v6sm8941634qtk.72.2018.08.06.07.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 07:25:37 -0700 (PDT)
Subject: Re: [PATCH v2] checkout: optimize "git checkout -b <new_branch>"
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180724180122.29212-1-benpeart@microsoft.com>
 <20180731163909.19004-1-benpeart@microsoft.com>
 <CACsJy8DMEMsDnKZc65K-0EJcm2udXZ7OKY=xoFmX4COM0dSH=g@mail.gmail.com>
 <3900401c-4d7b-233c-2098-9771a06ec0dd@gmail.com>
 <20180803155838.GA13512@duynguyen.home>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <21ac52cb-6a23-01c7-c593-59bd86ebca52@gmail.com>
Date:   Mon, 6 Aug 2018 10:25:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180803155838.GA13512@duynguyen.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/3/2018 11:58 AM, Duy Nguyen wrote:
> On Thu, Aug 02, 2018 at 02:02:00PM -0400, Ben Peart wrote:
>>
>>

> But if you still want to push it further, this is something I have in
> mind. It probably has bugs, but at least preliminary test shows me
> that it could skip 99% work inside unpack_trees() and not need to
> write the index.
> 
> The main check to determine "checkout -b" is basically the new
> oidcmp() in merge_working_tree(). Not sure if I miss any condition in
> that check, I didn't look very closely at checkout code.
> 

Thanks Duy.  I think this is an interesting idea to pursue but... when I 
tried running this patch on a virtualized repo it started triggering 
many object downloads.  After taking a quick look, it appears that 
CE_UPDATE is set on every cache entry so check_updates() ends up calling 
checkout_entry() which writes out every file to the working tree - even 
those supposedly skipped by the skip-wortree bit.  Oops.

Not too surprising (you did say it probably has bugs :)) but it means I 
can't trivially get performance data on how much this will help.  It 
also fails a lot of tests (see below).

It experience does highlight the additional risk of this model of 
changing the underlying functions (vs the high level optimization of my 
original patch).  In addition, the new special cases in those 
lower-level functions do add additional complexity and fragility to the 
codebase.  So, like most things, to me it isn't a clear better/worse 
decision - it's just different.  While I like the idea of general 
optimizations that could apply more broadly to other commands; I do 
worry about the additional complexity, amount of code churn, and 
associated risk with the change.

When I have cycles, I'll take a look at how to fix this bug and get some 
performance data.  I just wanted to give you a heads up that I'm not 
ignoring your patch, just that it is going to take additional time and 
effort before I can properly evaluate how much impact it will have.


Test Summary Report
-------------------
./t1011-read-tree-sparse-checkout.sh               (Wstat: 256 Tests: 21 
Failed: 1)
   Failed test:  20
   Non-zero exit status: 1
./t1400-update-ref.sh                              (Wstat: 256 Tests: 
170 Failed: 73)
   Failed tests:  40, 42-45, 55-59, 70, 72, 82, 85, 87-88
                 90-100, 103-110, 113-119, 127, 129-130
                 132-133, 136-137, 140-147, 150-157, 160-166
                 170
   Non-zero exit status: 1
./t2011-checkout-invalid-head.sh                   (Wstat: 256 Tests: 10 
Failed: 5)
   Failed tests:  3, 6-7, 9-10
   Non-zero exit status: 1
./t2015-checkout-unborn.sh                         (Wstat: 256 Tests: 6 
Failed: 3)
   Failed tests:  2-4
   Non-zero exit status: 1
./t2017-checkout-orphan.sh                         (Wstat: 256 Tests: 13 
Failed: 7)
   Failed tests:  7-13
   Non-zero exit status: 1
./t3033-merge-toplevel.sh                          (Wstat: 256 Tests: 13 
Failed: 11)
   Failed tests:  3-13
   Non-zero exit status: 1
./t3200-branch.sh                                  (Wstat: 256 Tests: 
139 Failed: 2)
   Failed tests:  137-138
   Non-zero exit status: 1
./t5616-partial-clone.sh                           (Wstat: 256 Tests: 13 
Failed: 1)
   Failed test:  4
   Non-zero exit status: 1
./t5516-fetch-push.sh                              (Wstat: 256 Tests: 90 
Failed: 1)
   Failed test:  34
   Non-zero exit status: 1
./t6300-for-each-ref.sh                            (Wstat: 256 Tests: 
205 Failed: 9)
   Failed tests:  189-196, 199
   Non-zero exit status: 1
./t7114-reset-sparse-checkout.sh                   (Wstat: 256 Tests: 3 
Failed: 2)
   Failed tests:  2-3
   Non-zero exit status: 1
./t7063-status-untracked-cache.sh                  (Wstat: 256 Tests: 50 
Failed: 1)
   Failed test:  23
   Non-zero exit status: 1
./t7201-co.sh                                      (Wstat: 256 Tests: 38 
Failed: 33)
   Failed tests:  4, 6-27, 29-38
   Non-zero exit status: 1
./t7409-submodule-detached-work-tree.sh            (Wstat: 256 Tests: 2 
Failed: 1)
   Failed test:  1
   Non-zero exit status: 1
./t9350-fast-export.sh                             (Wstat: 256 Tests: 37 
Failed: 1)
   Failed test:  12
   Non-zero exit status: 1
./t9903-bash-prompt.sh                             (Wstat: 256 Tests: 65 
Failed: 52)
   Failed tests:  4, 6-10, 14-34, 36, 39-51, 53-62, 65
   Non-zero exit status: 1
Files=834, Tests=19658, 2081 wallclock secs (10.42 usr 15.09 sys + 
1082.56 cusr 3530.46 csys = 4638.53 CPU)
Result: FAIL


> -- 8< --
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 28627650cd..912e565acc 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -478,6 +478,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   {
>   	int ret;
>   	struct lock_file lock_file = LOCK_INIT;
> +	int skip_cache_tree_update = 0;
>   
>   	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
>   	if (read_cache_preload(NULL) < 0)
> @@ -493,6 +494,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   		struct tree_desc trees[2];
>   		struct tree *tree;
>   		struct unpack_trees_options topts;
> +		int nr_trees;
>   
>   		memset(&topts, 0, sizeof(topts));
>   		topts.head_idx = -1;
> @@ -514,20 +516,45 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   		topts.merge = 1;
>   		topts.gently = opts->merge && old_branch_info->commit;
>   		topts.verbose_update = opts->show_progress;
> -		topts.fn = twoway_merge;
> +		/*
> +		 * We repair cache-tree explicitly in this function,
> +		 * no point in doing it again inside unpack_trees()
> +		 */
> +		topts.skip_cache_tree_update = 1;
>   		if (opts->overwrite_ignore) {
>   			topts.dir = xcalloc(1, sizeof(*topts.dir));
>   			topts.dir->flags |= DIR_SHOW_IGNORED;
>   			setup_standard_excludes(topts.dir);
>   		}
> -		tree = parse_tree_indirect(old_branch_info->commit ?
> -					   &old_branch_info->commit->object.oid :
> -					   the_hash_algo->empty_tree);
> -		init_tree_desc(&trees[0], tree->buffer, tree->size);
> -		tree = parse_tree_indirect(&new_branch_info->commit->object.oid);
> -		init_tree_desc(&trees[1], tree->buffer, tree->size);
> -
> -		ret = unpack_trees(2, trees, &topts);
> +		if (!oidcmp(&old_branch_info->commit->object.oid,
> +			    &new_branch_info->commit->object.oid)) {
> +			/*
> +			 * Skip 2-way merge because we know the end
> +			 * result would be the same anyway (to double
> +			 * check).
> +			 */
> +			topts.fn = noop_merge;
> +			nr_trees = 0;
> +			/*
> +			 * Repairing cache-tree is an optional optimization
> +			 * and could be safely skipped. Maybe have some
> +			 * heuristics based on the_index->cache_nr to
> +			 * determine if updating cache-tree could be too
> +			 * costly (including index writing cost) and skip it
> +			 * instead.
> +			 */
> +			skip_cache_tree_update = 1;
> +		} else {
> +			topts.fn = twoway_merge;
> +			tree = parse_tree_indirect(old_branch_info->commit ?
> +						   &old_branch_info->commit->object.oid :
> +						   the_hash_algo->empty_tree);
> +			init_tree_desc(&trees[0], tree->buffer, tree->size);
> +			tree = parse_tree_indirect(&new_branch_info->commit->object.oid);
> +			init_tree_desc(&trees[1], tree->buffer, tree->size);
> +			nr_trees = 2;
> +		}
> +		ret = unpack_trees(nr_trees, trees, &topts);
>   		clear_unpack_trees_porcelain(&topts);
>   		if (ret == -1) {
>   			/*
> @@ -597,13 +624,15 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   		}
>   	}
>   
> -	if (!active_cache_tree)
> -		active_cache_tree = cache_tree();
> +	if (!skip_cache_tree_update) {
> +		if (!active_cache_tree)
> +			active_cache_tree = cache_tree();
>   
> -	if (!cache_tree_fully_valid(active_cache_tree))
> -		cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
> +		if (!cache_tree_fully_valid(active_cache_tree))
> +			cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
> +	}
>   
> -	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
> +	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK | SKIP_IF_UNCHANGED))
>   		die(_("unable to write new index file"));
>   
>   	if (!opts->force && !opts->quiet)
> diff --git a/unpack-trees.c b/unpack-trees.c
> index cd0680f11e..007d6662f2 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1275,6 +1275,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>   	int i, ret;
>   	static struct cache_entry *dfc;
>   	struct exclude_list el;
> +	int result_is_actually_src = 0;
>   
>   	if (len > MAX_UNPACK_TREES)
>   		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
> @@ -1353,6 +1354,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>   
>   		if (traverse_trees(len, t, &info) < 0)
>   			goto return_failed;
> +	} else if (o->fn == noop_merge) {
> +		o->result = *o->src_index;
> +		o->cache_bottom = o->src_index->cache_nr;
> +		result_is_actually_src = 1;
>   	}
>   
>   	/* Any left-over entries in the index? */
> @@ -1426,7 +1431,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>   
>   	ret = check_updates(o) ? (-2) : 0;
>   	if (o->dst_index) {
> -		if (!ret) {
> +		if (!ret &&!o->skip_cache_tree_update) {
>   			if (!o->result.cache_tree)
>   				o->result.cache_tree = cache_tree();
>   			if (!cache_tree_fully_valid(o->result.cache_tree))
> @@ -1435,7 +1440,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>   						  WRITE_TREE_REPAIR);
>   		}
>   		move_index_extensions(&o->result, o->src_index);
> -		discard_index(o->dst_index);
> +		if (result_is_actually_src && o->dst_index == o->src_index)
> +			; /* no discarding */
> +		else
> +			discard_index(o->dst_index);
>   		*o->dst_index = o->result;
>   	} else {
>   		discard_index(&o->result);
> @@ -2193,3 +2201,9 @@ int oneway_merge(const struct cache_entry * const *src,
>   	}
>   	return merged_entry(a, old, o);
>   }
> +
> +int noop_merge(const struct cache_entry * const *src,
> +	       struct unpack_trees_options *o)
> +{
> +	BUG("This is basically a flag and not supposed to be called");
> +}
> diff --git a/unpack-trees.h b/unpack-trees.h
> index c2b434c606..3e5bce19a1 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -52,6 +52,7 @@ struct unpack_trees_options {
>   		     diff_index_cached,
>   		     debug_unpack,
>   		     skip_sparse_checkout,
> +		     skip_cache_tree_update,
>   		     gently,
>   		     exiting_early,
>   		     show_all_errors,
> @@ -96,5 +97,7 @@ int bind_merge(const struct cache_entry * const *src,
>   	       struct unpack_trees_options *o);
>   int oneway_merge(const struct cache_entry * const *src,
>   		 struct unpack_trees_options *o);
> +int noop_merge(const struct cache_entry * const *src,
> +	       struct unpack_trees_options *o);
>   
>   #endif
> -- 8< --
> 
> --
> Duy
> 
