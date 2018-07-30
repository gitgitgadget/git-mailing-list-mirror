Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 636731F597
	for <e@80x24.org>; Mon, 30 Jul 2018 20:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbeG3W3o (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 18:29:44 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40056 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbeG3W3o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 18:29:44 -0400
Received: by mail-qk0-f194.google.com with SMTP id c126-v6so8799282qkd.7
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 13:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8I9uelhfO2JobTWZ7vsRItW3MYPctuzVoIfM2caleFM=;
        b=kCut2x7urduGbfzWoWhrXoj2sNCTkMCVdJd8HgWxq7/LXm5o4v74/ylm9hzZEKatQa
         UzzhM+AYbR21asrifs6kdCbtCigfS42gbn+hRsmL4/E0SGSMQkn+9b5YwYMT3LM9llfi
         3BrZpFT7QZykHgnb9bpI0gQMBism/GQpBC1yEIczHhkMeN7zCD/XSWr/Vyo1T6UzDUxX
         wRLcG3tW9MzDtQqLN50UIFknDGCqDjFG18QKfA7ZLKTMDpHNJUaY3Vz2Kr1EFKIhxv6F
         l/duNllbo9NxeCyXI3OmGYm2O3PmoGk8px7WIdETI68hLy5d/PGLaPGmTRPQStotSPfZ
         c0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8I9uelhfO2JobTWZ7vsRItW3MYPctuzVoIfM2caleFM=;
        b=kRS/QimqufKRHDntxrIgYj2Je4/WR5q5wzUK6ueM+2eAYCY/CHdy92NxUqmiK3Jj4j
         y1Xy48G3bHhI7UTyefnFxb2dbKEgYbqmzwQOXY8n1AfAk1jeQiImslyFZiCmaJ0Iy5Rw
         gBN18oc8TFrLgjOICuPwTooWnKRqfVvu014LUi0Nr/9Vpe8nCS5Kqn58GifjdyDOVu96
         pdFRo0G9yO+6bDuOvvGclcZGmMINrWlN+Z4m5o8Enaf1c3f4J7jrLLcoMi+lk0ZjklNr
         /nWJP/6S0p3n669vWZ3sYsJZlM7S9SWHgPYggoOAsmCxHkTvX8VoPNdTgD+YkInKllvC
         XeMg==
X-Gm-Message-State: AOUpUlF6Ob1TPNoDcGz0+Xjv8VrosevovafSTftamyo0ZOrYyAiGZqu6
        iqD6w0sLeEOW9gSxwcW8IxA=
X-Google-Smtp-Source: AAOMgpdz/Eepsjvf0Rrc3Tt1Fhhb3pL8Oh2aiNAy9mcTRtyJVKbwQwGkOIgTMtRgepZjBkVVM3YRYQ==
X-Received: by 2002:a37:88c5:: with SMTP id k188-v6mr18135630qkd.365.1532983976246;
        Mon, 30 Jul 2018 13:52:56 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id o29-v6sm13537031qkh.85.2018.07.30.13.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 13:52:55 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] unpack-trees: optimize walking same trees with
 cache-tree
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net
References: <20180727154241.GA21288@duynguyen.home>
 <20180729103306.16403-1-pclouds@gmail.com>
 <20180729103306.16403-3-pclouds@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <2b97c84e-0634-3879-18a1-8f96a7b4a30d@gmail.com>
Date:   Mon, 30 Jul 2018 16:52:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180729103306.16403-3-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/29/2018 6:33 AM, Nguyễn Thái Ngọc Duy wrote:
> From: Duy Nguyen <pclouds@gmail.com>
> 
> In order to merge one or many trees with the index, unpack-trees code
> walks multiple trees in parallel with the index and performs n-way
> merge. If we find out at start of a directory that all trees are the
> same (by comparing OID) and cache-tree happens to be available for
> that directory as well, we could avoid walking the trees because we
> already know what these trees contain: it's flattened in what's called
> "the index".
> 
> The upside is of course a lot less I/O since we can potentially skip
> lots of trees (think subtrees). We also save CPU because we don't have
> to inflate and the apply deltas. The downside is of course more
> fragile code since the logic in some functions are now duplicated
> elsewhere.
> 
> "checkout -" with this patch on gcc.git:
> 
>      baseline      new
>    --------------------------------------------------------------------
>      0.018239226   0.019365414 s: read cache .git/index
>      0.052541655   0.049605548 s: preload index
>      0.001537598   0.001571695 s: refresh index
>      0.168167768   0.049677212 s: unpack trees
>      0.002897186   0.002845256 s: update worktree after a merge
>      0.131661745   0.136597522 s: repair cache-tree
>      0.075389117   0.075422517 s: write index, changed mask = 2a
>      0.111702023   0.032813253 s: unpack trees
>      0.000023245   0.000022002 s: update worktree after a merge
>      0.111793866   0.032933140 s: diff-index
>      0.587933288   0.398924370 s: git command: /home/pclouds/w/git/git
> 
> This command calls unpack_trees() twice, the first time on 2way merge
> and the second 1way merge. In both times, "unpack trees" time is
> reduced to one third. Overall time reduction is not that impressive of
> course because index operations take a big chunk. And there's that
> repair cache-tree line.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   unpack-trees.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 118 insertions(+), 1 deletion(-)
> 
> diff --git a/unpack-trees.c b/unpack-trees.c
> index dc58d1f5ae..39566b28fb 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -644,6 +644,102 @@ static inline int are_same_oid(struct name_entry *name_j, struct name_entry *nam
>   	return name_j->oid && name_k->oid && !oidcmp(name_j->oid, name_k->oid);
>   }
>   
> +static int all_trees_same_as_cache_tree(int n, unsigned long dirmask,
> +					struct name_entry *names,
> +					struct traverse_info *info)
> +{
> +	struct unpack_trees_options *o = info->data;
> +	int i;
> +
> +	if (!o->merge || dirmask != ((1 << n) - 1))
> +		return 0;
> +
> +	for (i = 1; i < n; i++)
> +		if (!are_same_oid(names, names + i))
> +			return 0;
> +
> +	return cache_tree_matches_traversal(o->src_index->cache_tree, names, info);
> +}
> +
> +static int index_pos_by_traverse_info(struct name_entry *names,
> +				      struct traverse_info *info)
> +{
> +	struct unpack_trees_options *o = info->data;
> +	int len = traverse_path_len(info, names);
> +	char *name = xmalloc(len + 1 /* slash */ + 1 /* NUL */);
> +	int pos;
> +
> +	make_traverse_path(name, info, names);
> +	name[len++] = '/';
> +	name[len] = '\0';
> +	pos = index_name_pos(o->src_index, name, len);
> +	if (pos >= 0)
> +		BUG("This is a directory and should not exist in index");
> +	pos = -pos - 1;
> +	if (!starts_with(o->src_index->cache[pos]->name, name) ||
> +	    (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, name)))
> +		BUG("pos must point at the first entry in this directory");
> +	free(name);
> +	return pos;
> +}
> +
> +/*
> + * Fast path if we detect that all trees are the same as cache-tree at this
> + * path. We'll walk these trees recursively using cache-tree/index instead of
> + * ODB since already know what these trees contain.
> + */
> +static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
> +				  struct name_entry *names,
> +				  struct traverse_info *info)
> +{
> +	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
> +	struct unpack_trees_options *o = info->data;
> +	int i, d;
> +
> +	if (!o->merge)
> +		BUG("We need cache-tree to do this optimization");
> +
> +	/*
> +	 * Do what unpack_callback() and unpack_nondirectories() normally
> +	 * do. But we walk all paths recursively in just one loop instead.
> +	 *
> +	 * D/F conflicts and staged entries are not a concern because
> +	 * cache-tree would be invalidated and we would never get here
> +	 * in the first place.
> +	 */
> +	for (i = 0; i < nr_entries; i++) {
> +		struct cache_entry *tree_ce;
> +		int len, rc;
> +
> +		src[0] = o->src_index->cache[pos + i];
> +
> +		len = ce_namelen(src[0]);
> +		tree_ce = xcalloc(1, cache_entry_size(len));
> +
> +		tree_ce->ce_mode = src[0]->ce_mode;
> +		tree_ce->ce_flags = create_ce_flags(0);
> +		tree_ce->ce_namelen = len;
> +		oidcpy(&tree_ce->oid, &src[0]->oid);
> +		memcpy(tree_ce->name, src[0]->name, len + 1);
> +

I don't like the overhead of having to create an entirely new cache 
entry here but I see you clean this up in the next patch.

> +		for (d = 1; d <= nr_names; d++)
> +			src[d] = tree_ce;
> +
> +		rc = call_unpack_fn((const struct cache_entry * const *)src, o);
> +		free(tree_ce);
> +		if (rc < 0)
> +			return rc;
> +
> +		mark_ce_used(src[0], o);
> +	}
> +	if (o->debug_unpack)
> +		printf("Unpacked %d entries from %s to %s using cache-tree\n",
> +		       nr_entries,
> +		       o->src_index->cache[pos]->name,
> +		       o->src_index->cache[pos + nr_entries - 1]->name);
> +	return 0;
> +}
> +
>   static int traverse_trees_recursive(int n, unsigned long dirmask,
>   				    unsigned long df_conflicts,
>   				    struct name_entry *names,
> @@ -655,6 +751,17 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
>   	void *buf[MAX_UNPACK_TREES];
>   	struct traverse_info newinfo;
>   	struct name_entry *p;
> +	int nr_entries;
> +
> +	nr_entries = all_trees_same_as_cache_tree(n, dirmask, names, info);
> +	if (nr_entries > 0) {
> +		struct unpack_trees_options *o = info->data;
> +		int pos = index_pos_by_traverse_info(names, info);
> +
> +		if (!o->merge || df_conflicts)
> +			BUG("Wrong condition to get here buddy");
> +		return traverse_by_cache_tree(pos, nr_entries, n, names, info);
> +	}
>   
>   	p = names;
>   	while (!p->mode)
> @@ -814,6 +921,11 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info, con
>   	return ce;
>   }
>   
> +/*
> + * Note that traverse_by_cache_tree() duplicates some logic in this funciton

s/funciton/function

> + * without actually calling it. If you change the logic here you may need to
> + * check and change there as well.
> + */
>   static int unpack_nondirectories(int n, unsigned long mask,
>   				 unsigned long dirmask,
>   				 struct cache_entry **src,
> @@ -998,6 +1110,11 @@ static void debug_unpack_callback(int n,
>   		debug_name_entry(i, names + i);
>   }
>   
> +/*
> + * Note that traverse_by_cache_tree() duplicates some logic in this funciton
> + * without actually calling it. If you change the logic here you may need to
> + * check and change there as well.
> + */
>   static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
>   {
>   	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
> @@ -1280,7 +1397,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>   	uint64_t start = getnanotime();
>   
>   	if (len > MAX_UNPACK_TREES)
> -		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
> +		die(_("unpack_trees takes at most %d trees"), MAX_UNPACK_TREES);
>   

I'd like to see this get in independently of this patch series.

>   	memset(&el, 0, sizeof(el));
>   	if (!core_apply_sparse_checkout || !o->update)
> 
