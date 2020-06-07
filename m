Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4BDC433DF
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 21:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA96206D5
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 21:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnS3gT61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgFGVp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 17:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGVp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 17:45:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755DDC08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 14:45:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u13so13506257wml.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 14:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3eZJRsvWTsmL0ZIhRRJkU746pTgnvSqhCMxYDn5Yarg=;
        b=NnS3gT61rBRWDUgeEjy5n2pre2MOixUYNUVncSLxYgdjdcim4n8ORmdhhzmOxHejqo
         GS31CrA/tH5dO4ibxbcelZ/cQpMgnC9wTZym8sjFdl3Bvicnntsctlb3SYA7TGTCrtX+
         4vsAbSdDcQy2WtvlT+XtKnWI1sEaAniWH6UnWRsJ/hRqgL9BoSX2fP3gr7Jdxrc+gmvw
         grV73Uq38Vh2V3DXg6RC+NLKRM4lGQTgl4wjTFUHOrEdK/S7spzDrQ1aGIpHuIITLmu+
         EJ6ByfUv1AducaPgnlLMEhcHV4I6Z7WAd5w29xBXhwg3s75dx+XVd4cf9zG2z1CirerN
         h04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3eZJRsvWTsmL0ZIhRRJkU746pTgnvSqhCMxYDn5Yarg=;
        b=uQB+TgmpaLXyWO5iWksO6AkhOaYTXb/BG6Ua8stJ4IvElN2qUuART0ZIt7tEc0LI4G
         bVsezvNhEjYigQyZd5B+qrS+aMOiCI/OftD/HhZE7y+JbYuLSzxnzhtVLouEywevvMjN
         azoasR2TLnk+nfxc6JaD5zdWeZ0PTw+c/G8pHBHsFSkBlN8WenSDpaMXi/BOATsF8U2P
         kwvmik3LXKeqXpV3BBvFrwqPSwPmhr48u3tdJffsdffnjL4YWb2r7i7IQzJEodg5KbJG
         SY7J4LNlnESNmqSukWFtgqcdqsbHt4ezIvSpgnplxN4dDWtkW66JZptdMpbGZxA29atd
         8TWQ==
X-Gm-Message-State: AOAM530GtuiK8zzPxEzwiCNG0RfL7jPbKcxf4iwR0uDaBDNylV7yvMIz
        lC8ZeT8eXE6aD42JaFR6Vb+83rML
X-Google-Smtp-Source: ABdhPJzDEllSt0hZZLxxcfp/C6n5DzBg63ZC+qXHlhhzAm2r2ylMwyZ80ehng/Mr8U7UpPepg69cFA==
X-Received: by 2002:a1c:1f48:: with SMTP id f69mr13630111wmf.67.1591566357181;
        Sun, 07 Jun 2020 14:45:57 -0700 (PDT)
Received: from szeder.dev (78-131-14-185.pool.digikabel.hu. [78.131.14.185])
        by smtp.gmail.com with ESMTPSA id j11sm21165866wru.69.2020.06.07.14.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 14:45:56 -0700 (PDT)
Date:   Sun, 7 Jun 2020 23:45:50 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        garimasigit@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 05/12] bloom: de-duplicate directory entries
Message-ID: <20200607214550.GA22200@szeder.dev>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
 <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
 <ba0d8c1f539751d9cfd556dac4eeda97758cf12e.1589198180.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba0d8c1f539751d9cfd556dac4eeda97758cf12e.1589198180.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 11, 2020 at 11:56:12AM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When computing a changed-path Bloom filter, we need to take the
> files that changed from the diff computation and extract the parent
> directories. That way, a directory pathspec such as "Documentation"
> could match commits that change "Documentation/git.txt".
> 
> However, the current code does a poor job of this process. The paths
> are added to a hashmap, but we do not check if an entry already
> exists with that path. This can create many duplicate entries and
> cause the filter to have a much larger length than it should. This
> means that the filter is more sparse than intended, which helps the
> false positive rate, but wastes a lot of space.
> 
> Properly use hashmap_get() before hashmap_add(). Also be sure to
> include a comparison function so these can be matched correctly.
> 
> This has an effect on a test in t0095-bloom.sh. This makes sense,
> there are ten changes inside "smallDir" so the total number of
> paths in the filter should be 11. This would result in 11 * 10 bits
> required, and with 8 bits per byte, this results in 14 bytes.

This is the first patch where the chunk format and the specs are in
sync and the Bloom filters are as large as promised, so it would have
been nice to see how the false positive rate, the runtime of
pathspec-limited revision walks, and the size of the Bloom filters
chunk or the commit-graph file turned out...

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  bloom.c          | 35 ++++++++++++++++++++++++++---------
>  t/t0095-bloom.sh |  4 ++--
>  2 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/bloom.c b/bloom.c
> index 96792782719..196cda0a1bd 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -158,6 +158,19 @@ void init_bloom_filters(void)
>  	init_bloom_filter_slab(&bloom_filters);
>  }
>  
> +static int pathmap_cmp(const void *hashmap_cmp_fn_data,
> +		       const struct hashmap_entry *eptr,
> +		       const struct hashmap_entry *entry_or_key,
> +		       const void *keydata)
> +{
> +	const struct pathmap_hash_entry *e1, *e2;
> +
> +	e1 = container_of(eptr, const struct pathmap_hash_entry, entry);
> +	e2 = container_of(entry_or_key, const struct pathmap_hash_entry, entry);
> +
> +	return strcmp(e1->path, e2->path);
> +}
> +
>  struct bloom_filter *get_bloom_filter(struct repository *r,
>  				      struct commit *c,
>  				      int compute_if_not_present)
> @@ -206,25 +219,29 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
>  		struct hashmap pathmap;
>  		struct pathmap_hash_entry *e;
>  		struct hashmap_iter iter;
> -		hashmap_init(&pathmap, NULL, NULL, 0);
> +		hashmap_init(&pathmap, pathmap_cmp, NULL, 0);
>  
>  		for (i = 0; i < diff_queued_diff.nr; i++) {
>  			const char *path = diff_queued_diff.queue[i]->two->path;
>  
>  			/*
> -			* Add each leading directory of the changed file, i.e. for
> -			* 'dir/subdir/file' add 'dir' and 'dir/subdir' as well, so
> -			* the Bloom filter could be used to speed up commands like
> -			* 'git log dir/subdir', too.
> -			*
> -			* Note that directories are added without the trailing '/'.
> -			*/
> +			 * Add each leading directory of the changed file, i.e. for
> +			 * 'dir/subdir/file' add 'dir' and 'dir/subdir' as well, so
> +			 * the Bloom filter could be used to speed up commands like
> +			 * 'git log dir/subdir', too.
> +			 *
> +			 * Note that directories are added without the trailing '/'.
> +			 */
>  			do {
>  				char *last_slash = strrchr(path, '/');
>  
>  				FLEX_ALLOC_STR(e, path, path);

Allocating a hashmap entry each time we query whether a path is
already present in the hashmap has some overhead.  It's cheaper to
create an entry on the stack just for the query and allocate an entry
on the heap only if the path isn't in the map.

Deduplicating without a hashmap is faster still.

>  				hashmap_entry_init(&e->entry, strhash(path));
> -				hashmap_add(&pathmap, &e->entry);
> +
> +				if (!hashmap_get(&pathmap, &e->entry, NULL))
> +					hashmap_add(&pathmap, &e->entry);
> +				else
> +					free(e);
>  
>  				if (!last_slash)
>  					last_slash = (char*)path;
> diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
> index 8f9eef116dc..6defeb544f1 100755
> --- a/t/t0095-bloom.sh
> +++ b/t/t0095-bloom.sh
> @@ -89,8 +89,8 @@ test_expect_success 'get bloom filter for commit with 10 changes' '
>  	git add smallDir &&
>  	git commit -m "commit with 10 changes" &&
>  	cat >expect <<-\EOF &&
> -	Filter_Length:25
> -	Filter_Data:82|a0|65|47|0c|92|90|c0|a1|40|02|a0|e2|40|e0|04|0a|9a|66|cf|80|19|85|42|23|
> +	Filter_Length:14
> +	Filter_Data:02|b3|c4|a0|34|e7|fe|eb|cb|47|fe|a0|e8|72|
>  	EOF
>  	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
>  	test_cmp expect actual
> -- 
> gitgitgadget
> 
