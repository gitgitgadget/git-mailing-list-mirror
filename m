Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A0DC433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D326610E7
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhDGXDR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 19:03:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65339 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDGXDR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 19:03:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C11FBD536;
        Wed,  7 Apr 2021 19:03:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=CKfgTmM6d0XsZU0uvvoqIhfFs8k=; b=k8G0uTXCK/Xc8bv/023a
        QWj98Iv2jZxZnAKqAPCAAE5k/vpYFFA9uwMoa49o2QPSRG3GZSqngyde0mVrdmSa
        h+INBMYzFmJXF2IrrfeXOCtWxWGI9JP1ApI3S612JB+Dp0TtoiHTBRZcU4WExx1X
        +TzNQFYvfMQVsmRWgZ3MVRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=kgVjmN2yYs9U6Z898D4BwbViYOMTY5KYHgR/ZyZQ/fY+z9
        r3rh5NGYJP+IfOhHyV3UCzAzF0hv1THC8aish9owU3YCGOJ3TcyeqnK3r0G8iLy9
        as0xMrDMsR7K7MxwP1ECYuxnvVofOch7lAv5SOmCHYKZUwqM+vYd9oYM14/6U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D245BD535;
        Wed,  7 Apr 2021 19:03:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D78D7BD534;
        Wed,  7 Apr 2021 19:03:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Chinmoy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Chinmoy <chinmoy12c@gmail.com>
Subject: Re: [PATCH v4] cache-tree.c: remove implicit dependency on
 the_repository
References: <pull.915.v3.git.1617465421353.gitgitgadget@gmail.com>
        <pull.915.v4.git.1617778489719.gitgitgadget@gmail.com>
Date:   Wed, 07 Apr 2021 16:03:05 -0700
Message-ID: <xmqqsg41wvdi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6993CAF4-97F5-11EB-B154-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Chinmoy via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Chinmoy Chakraborty <chinmoy12c@gmail.com>
>
> This kills the_repository dependency in cache_tree_update()
> and prime_cache_tree().
>
> Signed-off-by: Chinmoy Chakraborty <chinmoy12c@gmail.com>
> ---
>     Replace the_repository with r

Huh???

> diff --git a/cache-tree.c b/cache-tree.c
> index add1f0771317..4928a9f0f13b 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -446,10 +446,10 @@ int cache_tree_update(struct index_state *istate, int flags)
>  		istate->cache_tree = cache_tree();
>  
>  	trace_performance_enter();
> -	trace2_region_enter("cache_tree", "update", the_repository);
> +	trace2_region_enter("cache_tree", "update", istate->repo);
>  	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
>  		       "", 0, &skip, flags);
> -	trace2_region_leave("cache_tree", "update", the_repository);
> +	trace2_region_leave("cache_tree", "update", istate->repo);
>  	trace_performance_leave("cache_tree_update");
>  	if (i < 0)
>  		return i;
> @@ -746,13 +746,13 @@ void prime_cache_tree(struct repository *r,
>  		      struct index_state *istate,
>  		      struct tree *tree)
>  {
> -	trace2_region_enter("cache-tree", "prime_cache_tree", the_repository);
> +	trace2_region_enter("cache-tree", "prime_cache_tree", r);
>  	cache_tree_free(&istate->cache_tree);
>  	istate->cache_tree = cache_tree();
>  
>  	prime_cache_tree_rec(r, istate->cache_tree, tree);
>  	istate->cache_changed |= CACHE_TREE_CHANGED;
> -	trace2_region_leave("cache-tree", "prime_cache_tree", the_repository);
> +	trace2_region_leave("cache-tree", "prime_cache_tree", r);
>  }

The patch assumes that istate->repo will always set, but it does not
even try to justify why that assumption is safe to make (e.g. "the
entire codebase that leads to this function has been audited and
made sure istate at this point will always have its .repo member is
set" in the log message, if such an audit has actually been done,
may have been convincing), which I find quite troubling.
