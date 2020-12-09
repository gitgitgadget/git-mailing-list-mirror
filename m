Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A98C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 23:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8770239D1
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 23:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgLIXCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 18:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgLIXCB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 18:02:01 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C428EC0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 15:01:20 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id y24so3104528otk.3
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 15:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m8RVKVgmHx1QuwEVob5aIUrShfHEtZjVYO9ux69lGKA=;
        b=f0sOW1KKIuPD59k6zdgvtTZ8uyo349mFBFRuCaD8TJgYxq5Gjq0VuGygAlaBuNPqnF
         1VTz/r9lckGBO59RNoSf4ccbxrjkf2ClOECurA3t7vnuZf87kIqIc3YkUjDdxQZkh/Sx
         +UYaIG3oRKfqfFBuvt1Rp8i3CopFe+k8Qwk2kXaJoshNxsClbwm3I2uOsSsJjsDjJtls
         KHgn4etp2Cg9WZ7odm4KUmaKXf32rVi2lyhLYfmS1sQeoEKgP17KStK67U2DGdMHZuSS
         0mTujieYn4JrxxtU7BJLrSwtL82c/GIDrSKdFB4tQdU0XDAMQIbqaKMVt/kl05i1WPo2
         dRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m8RVKVgmHx1QuwEVob5aIUrShfHEtZjVYO9ux69lGKA=;
        b=Qrw2xMY5oQC05ifsOnHhqpie+6qfPRLWTF7X60KjMeuVhB9lj/0EW9xW0CZEAHD2e8
         aBRQDDdo91qrcd4ktu0aRA6iIzsvFo1fSEp+HXUEu0nrWrpVXMPjnLY6KLsejDTN7CW6
         +K/Jq3RAq2odCttZXk5Qf6T0n6mhY0EdhIUtHOC3yPTV3OegE1nU8B+5PdC/09C82cRs
         ywry5D7O5foKIg1mDXKU5btmZM+692VmvIcyJ+ILq9hJbBJgqran7N/uw1uSnwUQDs/p
         tD8WhlCDFuQSRNVJPeyodXkqVPMnklZsd/qFoI9I0EwC71BJVbbczVeVddOHfpd75zpr
         rwqg==
X-Gm-Message-State: AOAM532hIiQd7tvR02R2lYkFZwhKDX3hBdzMP7QIUO1CEbRV7r+l+Ud1
        kUeQJx8B1/pwA0lcf5PrT2sQpA==
X-Google-Smtp-Source: ABdhPJxJmJk3rBGeaQOFjU1J3I5iKtcQhGXrGwnxiJL4koFtTUjMaAazj95sgIfYg2q7y79keJjf0g==
X-Received: by 2002:a9d:12c:: with SMTP id 41mr3769907otu.77.1607554880150;
        Wed, 09 Dec 2020 15:01:20 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 100sm738856otm.27.2020.12.09.15.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 15:01:19 -0800 (PST)
Date:   Wed, 9 Dec 2020 18:01:16 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 7/7] Accelerate rename_dst setup
Message-ID: <X9FXPHUZJAZKSset@nand.local>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
 <3e83b51628b6f3aeb71c5e637eca03dd63f9e95f.1607223276.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e83b51628b6f3aeb71c5e637eca03dd63f9e95f.1607223276.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 06, 2020 at 02:54:36AM +0000, Elijah Newren via GitGitGadget wrote:
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 816d2fbac44..fb3c2817c6b 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -5,67 +5,64 @@
>  #include "cache.h"
>  #include "diff.h"
>  #include "diffcore.h"
> -#include "object-store.h"
>  #include "hashmap.h"
> +#include "object-store.h"

Shuffling around this object-store.h include looks like noise to me, but
maybe there's a good reason for doing it.

>  #include "progress.h"
>  #include "promisor-remote.h"
> +#include "strmap.h"
>
>  /* Table of rename/copy destinations */
>
>  static struct diff_rename_dst {
> -	struct diff_filespec *two;
> -	struct diff_filepair *pair;
> +	struct diff_filepair *p;
> +	struct diff_filespec *filespec_to_free;
> +	int is_rename; /* false -> just a create; true -> rename or copy */
>  } *rename_dst;
>  static int rename_dst_nr, rename_dst_alloc;
> +/* Mapping from break source pathname to break destination index */
> +static struct strintmap *break_idx = NULL;
>
> -static int find_rename_dst(struct diff_filespec *two)
> -{
> -	int first, last;
> -
> -	first = 0;
> -	last = rename_dst_nr;
> -	while (last > first) {
> -		int next = first + ((last - first) >> 1);
> -		struct diff_rename_dst *dst = &(rename_dst[next]);
> -		int cmp = strcmp(two->path, dst->two->path);
> -		if (!cmp)
> -			return next;
> -		if (cmp < 0) {
> -			last = next;
> -			continue;
> -		}
> -		first = next+1;
> -	}
> -	return -first - 1;
> -}
> -
> -static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two)
> +static struct diff_rename_dst *locate_rename_dst(struct diff_filepair *p)
>  {
> -	int ofs = find_rename_dst(two);
> -	return ofs < 0 ? NULL : &rename_dst[ofs];
> +	/* Lookup by p->ONE->path */
> +	int idx = break_idx ? strintmap_get(break_idx, p->one->path) : -1;

I had to lookup the behavior of strintmap_get() to realize that it
returns the map's "default value" to figure out why this double
ternary was necessary, but I think that it is.

Ideally, if break_idx is non-NULL, then we ought to be able to immediately
return NULL, but it's possible that break_idx is non-NULL and simply
doesn't contain p->one->path, in which case we also want to return NULL.

So, I think this is as clear as it can be.

> +	return (idx == -1) ? NULL : &rename_dst[idx];
>  }
>
>  /*
>   * Returns 0 on success, -1 if we found a duplicate.
>   */
> -static int add_rename_dst(struct diff_filespec *two)
> +static int add_rename_dst(struct diff_filepair *p)
>  {
> -	int first = find_rename_dst(two);
> -
> -	if (first >= 0)
> +	/*
> +	 * See t4058; trees might have duplicate entries.  I think
> +	 * trees with duplicate entries should be ignored and we
> +	 * should just leave rename detection on; while the results
> +	 * may be slightly harder to understand, that's merely a
> +	 * result of the underlying tree making no sense.  But I
> +	 * believe everything still works fine, the results do still
> +	 * make sense, and the extra overhead of doing this checking
> +	 * for a few historical weird trees from long ago seems like
> +	 * the dog wagging the tail to me.
> +	 *
> +	 * However: I don't feel like fighting that battle right now.
> +	 * For now, to keep the regression test passing, we have to
> +	 * detect it.  Since the diff machinery passes these to us in
> +	 * adjacent pairs, we just need to check to see if our name
> +	 * matches the previous one.
> +	 *
> +	 * TODO: Dispense with this test, rip out the test in t4058, and
> +	 * lobby folks for the change.
> +	 */
> +	if (rename_dst_nr > 0 &&
> +	    !strcmp(rename_dst[rename_dst_nr-1].p->two->path, p->two->path))
>  		return -1;
> -	first = -first - 1;
>
> -	/* insert to make it at "first" */
>  	ALLOC_GROW(rename_dst, rename_dst_nr + 1, rename_dst_alloc);
> +	rename_dst[rename_dst_nr].p = p;
> +	rename_dst[rename_dst_nr].filespec_to_free = NULL;
> +	rename_dst[rename_dst_nr].is_rename = 0;
>  	rename_dst_nr++;
> -	if (first < rename_dst_nr)
> -		MOVE_ARRAY(rename_dst + first + 1, rename_dst + first,
> -			   rename_dst_nr - first - 1);
> -	rename_dst[first].two = alloc_filespec(two->path);
> -	fill_filespec(rename_dst[first].two, &two->oid, two->oid_valid,
> -		      two->mode);
> -	rename_dst[first].pair = NULL;
>  	return 0;

Very nice, this is much simpler than what was here before.

> @@ -78,6 +75,14 @@ static int rename_src_nr, rename_src_alloc;
>
>  static void register_rename_src(struct diff_filepair *p)
>  {
> +	if (p->broken_pair) {
> +		if (!break_idx) {
> +			break_idx = xmalloc(sizeof(*break_idx));
> +			strintmap_init(break_idx, -1);
> +		}
> +		strintmap_set(break_idx, p->one->path, rename_dst_nr);
> +	}
> +

Makes sense.

> @@ -664,8 +653,9 @@ void diffcore_rename(struct diff_options *options)
>  			 */
>  			if (DIFF_PAIR_BROKEN(p)) {
>  				/* broken delete */
> -				struct diff_rename_dst *dst = locate_rename_dst(p->one);
> -				if (dst && dst->pair)
> +				struct diff_rename_dst *dst = locate_rename_dst(p);
> +				assert(dst);

You're not hurting anything, but I'm not convinced that this assert() is
buying you anything that the line immediately below it isn't already
doing.

The rest of the patch looks good to me.

Thanks,
Taylor
