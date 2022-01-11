Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FBEC433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 18:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344803AbiAKSaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242661AbiAKSaP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 13:30:15 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7855BC06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:30:15 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id q3so195945qvc.7
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/H9JQ8jHn8LysbWavrkT70VbuRIYA/q9wlS0YoFSdmc=;
        b=e0imZ/NGS1n6IRg+xP02GznWsDf9/srkZRiO2g55yYy2KdovYwhUFxD/VxQfyt+CHJ
         9CuORvpLVjaL1NU1W76bM6IYPwzjarTYmvj3gY5Am7uapYdV81t7a/33Izq3wIwB8bq5
         TpPapy+IGDFACvrtSwpr1BCvqNWl617Za/FTJrw1O1QsgaacV9CtS++zQ00Nd1FRvJ8P
         bfjyfs8in0JOb0fmF8RNVljPT5VbZpVNhfrD5RMC+mdGDR4qJG+eAH5FKCFqWEgFJTbR
         dz/6pog5WyZ6Wtinh+fcoKyl81ZjOkFSU5tGjb2CBebk7eofhxe6PADiGZRSZ9ZqgGsq
         15jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/H9JQ8jHn8LysbWavrkT70VbuRIYA/q9wlS0YoFSdmc=;
        b=NF2sYPSeemeOi+du501S9jLsGMtvCJVmD09mLF+BW82cJEj1EafqYxCqo3JQRjeWWQ
         BQ0PtuEan3GhXFCCvdI4wy28qXEDgxpphC31BijasmF2jNfai6Lr1wG3j0Qky4JOjSSy
         GEP8SELido/hP8Q5QQgAm8qKYtwSfSEmCTuHw5Pa+eJsc7p8Q84v3KfcTaDgspG4Q8KP
         88/a1A590wkyieFvbm+HrghJLEF9jPGWqznXmiX6MAf/MNw8sM59lU4G0QFHvrzprG2X
         zdcAmWebz0RWqLDtGdSiwLYzxMc4DNQfWhpgmgeZncWx9cKLTT4gkt2LF4q7bQzd6Gh9
         QGtw==
X-Gm-Message-State: AOAM533i95qcfOkEerl/H23p2N6cs9YMWNifMVZ7N1bfoxRJBXFF2POI
        2405D+/lXALUU00FTUYBS3Fx
X-Google-Smtp-Source: ABdhPJzG4uItxIqRaiL8YD0Vk3bVqloERQC9d3/AEjMuyEKvBDvz+YBL9mqDMSxpWoOWYLZ02F/ZVA==
X-Received: by 2002:a05:6214:23c9:: with SMTP id hr9mr4974956qvb.16.1641925814609;
        Tue, 11 Jan 2022 10:30:14 -0800 (PST)
Received: from [192.168.0.102] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id t3sm7840089qtc.7.2022.01.11.10.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 10:30:14 -0800 (PST)
Message-ID: <950da537-941f-dfb4-460a-1aa4c68e0750@github.com>
Date:   Tue, 11 Jan 2022 13:30:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [RFC PATCH 5/5] Accelerate
 ensure_skip_worktree_means_skip_worktree by caching
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
References: <20220109045732.2497526-1-newren@gmail.com>
 <20220109045732.2497526-6-newren@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220109045732.2497526-6-newren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> Rather than lstat()'ing every SKIP_WORKTREE path, take advantage of the
> fact that entire directories will often be missing, especially for cone
> mode and even more so ever since commit 55dfcf9591 ("sparse-checkout:
> clear tracked sparse dirs", 2021-09-08).  If we have already determined
> that the parent directory of a file (or any other previous ancestor)
> does not exist, then we already know the file cannot exist and do not
> need to lstat() it separately.
> 
> Granted, the cost of ensure_skip_worktree_means_skip_worktree() might
> be considered a bit high for non-cone mode since it might now lstat()
> every SKIP_WORKTREE path when the index is loaded (an O(N) cost, with
> N the number of SKIP_WORKTREE paths), but non-cone mode users already
> have to deal with the O(N*M) cost (with N=the number of tracked files
> and M=the number of sparsity patterns), so this should be reasonable.
> 

Did you write/run any performance tests to see how this optimization changed
the execution time? If not, running the `p2000` performance tests against
the patch series base, [3/5], and [5/5] would provide some really helpful
insight into the cost of `ensure_skip_worktree_means_skip_worktree`, then
how much this optimization improves it.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  sparse-index.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 103 insertions(+), 2 deletions(-)
> 
> diff --git a/sparse-index.c b/sparse-index.c
> index 79d50e444c..608782e255 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -341,18 +341,117 @@ void ensure_correct_sparsity(struct index_state *istate)
>  		ensure_full_index(istate);
>  }
>  
> +struct path_cache_entry {
> +	struct hashmap_entry ent;
> +	const char *path;
> +	int path_length;
> +	int is_present;
> +};
> +
> +static int path_cache_cmp(const void *unused,
> +			  const struct hashmap_entry *entry1,
> +			  const struct hashmap_entry *entry2,
> +			  const void *also_unused)
> +{
> +	const struct path_cache_entry *e1, *e2;
> +
> +	e1 = container_of(entry1, const struct path_cache_entry, ent);
> +	e2 = container_of(entry2, const struct path_cache_entry, ent);
> +	if (e1->path_length != e2->path_length)
> +		return e1->path_length - e2->path_length;
> +	return memcmp(e1->path, e2->path, e1->path_length);
> +}
> +
> +static struct path_cache_entry *find_path_cache_entry(struct hashmap *map,
> +						      const char *str,
> +						      int str_length)
> +{
> +	struct path_cache_entry entry;
> +	hashmap_entry_init(&entry.ent, memhash(str, str_length));
> +	entry.path = str;
> +	entry.path_length = str_length;
> +	return hashmap_get_entry(map, &entry, ent, NULL);
> +}
> +
> +static void record(struct hashmap *path_cache,
> +		   struct mem_pool *pool,
> +		   const char *path,
> +		   int path_length,
> +		   int found)
> +{
> +	struct path_cache_entry *entry;
> +
> +	entry = mem_pool_alloc(pool, sizeof(*entry));
> +	hashmap_entry_init(&entry->ent, memhash(path, path_length));
> +	entry->path = path;
> +	entry->path_length = path_length;
> +	entry->is_present = found;
> +	hashmap_add(path_cache, &entry->ent);
> +}
> +
> +static int path_found(struct hashmap *path_cache, struct mem_pool *pool,
> +		      const char *path, int path_length)
> +{
> +	struct stat st;
> +	int found;
> +	const char *dirsep = path + path_length - 1;
> +	const char *tmp;
> +
> +	/* Find directory separator; memrchr is sadly glibc-specific */
> +	while (dirsep > path && *dirsep != '/')
> +		dirsep--;
> +
> +	/* If parent of path doesn't exist, no point lstat'ing path... */
> +	if (dirsep > path) {
> +		struct path_cache_entry *entry;
> +		int new_length, parent_found;
> +
> +		/* First, check if path's parent's existence was cached */
> +		new_length = dirsep - path;
> +		entry = find_path_cache_entry(path_cache, path, new_length);
> +		if (entry)
> +			parent_found = entry->is_present;
> +		else
> +			parent_found = path_found(path_cache, pool,
> +						  path, new_length);
> +
> +		if (!parent_found) {
> +			/* path can't exist if parent dir doesn't */
> +			record(path_cache, pool, path, path_length, 0);
> +			return 0;
> +		} /* else parent was found so must check path itself too... */
> +	}
> +
> +	/* Okay, parent dir exists, so we have to check original path */
> +
> +	/* Make sure we have a NUL-terminated string to pass to lstat */
> +	tmp = path;
> +	if (path[path_length])
> +		tmp = mem_pool_strndup(pool, path, path_length);
> +	/* Determine if path exists */
> +	found = !lstat(tmp, &st);
> +
> +	record(path_cache, pool, path, path_length, found);
> +	return found;
> +}
> +
>  void ensure_skip_worktree_means_skip_worktree(struct index_state *istate)
>  {
> +	struct hashmap path_cache = HASHMAP_INIT(path_cache_cmp, NULL);
> +	struct mem_pool pool;
> +
>  	int i;
> +
>  	if (!core_apply_sparse_checkout)
>  		return;
>  
> +	mem_pool_init(&pool, 32*1024);
>  restart:
>  	for (i = 0; i < istate->cache_nr; i++) {
>  		struct cache_entry *ce = istate->cache[i];
> -		struct stat st;
>  
> -		if (ce_skip_worktree(ce) && !lstat(ce->name, &st)) {
> +		if (ce_skip_worktree(ce) &&
> +		    path_found(&path_cache, &pool, ce->name, strlen(ce->name))) {
>  			if (S_ISSPARSEDIR(ce->ce_mode)) {
>  				ensure_full_index(istate);
>  				goto restart;
> @@ -360,6 +459,8 @@ void ensure_skip_worktree_means_skip_worktree(struct index_state *istate)
>  			ce->ce_flags &= ~CE_SKIP_WORKTREE;
>  		}
>  	}
> +	hashmap_clear(&path_cache);
> +	mem_pool_discard(&pool, 0);
>  }
>  
>  

