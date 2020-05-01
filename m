Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B951C47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 23:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71528208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 23:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="mjajcLxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgEAXGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 19:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAXGf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 19:06:35 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00333C061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 16:06:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t7so4161909plr.0
        for <git@vger.kernel.org>; Fri, 01 May 2020 16:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yReG/qE4lnMuppF8Tubt7vMKbcs2HHd+mtiATnhZ9GU=;
        b=mjajcLxccgNnc0AzcJoXYXSA2KrZ7sasxICqsxTNmRQ1lNjI/kSbwiswVM+Wxz63EL
         jawbPalrcI3KV1Yd7I0iwdQozj9yVhBWaukP7SjAGA7gC37fAsRrxylw/16kl6A+mL7w
         t0+lM6iyuyxtGMP/1trU7UvnxtMOJW4uEF20khptKFt+9YGlWrfeVGTa9jEbXXW6GjlX
         Wle1cgVJ1atH3U5tJ+DYX6VZho1EsFZU2BczHEBVn2jXWrG8vCkGb/xgF0ys/RuZ8+aA
         vLmVg3oyC9z/vGrx4tB/53GLloPbzwGI7gpXLxyTxQvLntW39c3CdNfKLS879COaOlTP
         IP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yReG/qE4lnMuppF8Tubt7vMKbcs2HHd+mtiATnhZ9GU=;
        b=O+kVHKvAy2p3IdPqNzmXVPX+Ys283RrMC1xAR1bFpfEZ/KeIlc5nuMbgcMsqtdcdsA
         hcXSY6M5BxZh41xz4KLoK/KcPjMm+HmY7rP/lpiOGN++CbcCsJARz8NYi+QxU7Fr3n2d
         Yz18fyJMWjCGMaBTHOEOFbJAbcn4ljnxb8Ebf08zCtzE7K6HFd6qmGM2V23Ye+b8JC3T
         cHJQrRaoN4BSpExWXx9X8H5FogVi3AjbVCis3gFoa3dvtyx9BRvjswSdGA+Q7gw/p3NF
         0OYsbGn2zMbqMnW5ZwP7kcHLYN3ftRR2K9yHGvD/WxUcekoKQy191UaQoKxlfoVk2MNf
         IxGg==
X-Gm-Message-State: AGi0PuYYtSY+U0O9CuSUX0kLHCW8mO+O4+uUtY1xDuO8QHhX/GpVJYtp
        1vXg18+Sv0KlxCTwMtmrxPhK8A==
X-Google-Smtp-Source: APiQypJ6iiPjeJUr9ABBShEQRYkf1YYtStvqnBcQ2ovj86m9qWdQPZuUlG8wVQEIfJOjl6YqgF4plw==
X-Received: by 2002:a17:90a:2949:: with SMTP id x9mr2398056pjf.33.1588374394136;
        Fri, 01 May 2020 16:06:34 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id v94sm578769pjb.39.2020.05.01.16.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 16:06:33 -0700 (PDT)
Date:   Fri, 1 May 2020 17:06:31 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        garimasigit@gmail.com, szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 04/12] bloom: de-duplicate directory entries
Message-ID: <20200501230631.GA46422@syl.local>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
 <07d0a25f1c438f02d71918e4ca05f2901eb802be.1588347029.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07d0a25f1c438f02d71918e4ca05f2901eb802be.1588347029.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 03:30:21PM +0000, Derrick Stolee via GitGitGadget wrote:
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
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  bloom.c          | 35 ++++++++++++++++++++++++++---------
>  t/t0095-bloom.sh |  4 ++--
>  2 files changed, 28 insertions(+), 11 deletions(-)
>
> diff --git a/bloom.c b/bloom.c
> index 2e3e0f5037b..eb08571c628 100644
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
> @@ -203,25 +216,29 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
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
>  				hashmap_entry_init(&e->entry, strhash(path));
> -				hashmap_add(&pathmap, &e->entry);
> +
> +				if (!hashmap_get(&pathmap, &e->entry, NULL))
> +					hashmap_add(&pathmap, &e->entry);
> +				else
> +					free(e);

Yep; this seems right on: if we have a match in the hashmap already,
there's no need to add another one. In fact, it's much better not to, as
you point out.

In the case that we didn't need to add one, we can free up the
corresponding resources (I had to double-check that 'free()' would
appropriately discard the flex array, but that's fine).

Nice find!

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

Makes sense, I figured that there'd be a little bit of test-fallout
here.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
