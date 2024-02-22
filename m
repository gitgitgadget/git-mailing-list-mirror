Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D8F155A43
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624822; cv=none; b=B1ywAQCzaD/aJbGqLVfdC1XC6h4jtKgHPIwT7EDIZeeneonCndy3Bzh8tgL0xUr+b+1tVrctEGN89SN8Xkj8MA5O/Ta9RoY8jdsVaFgbfpGzF08A0KySwxD6IDhCwDeDAExK22tgNHahfh1V/R20tOUdBxO0BoTQZSiXv52U/jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624822; c=relaxed/simple;
	bh=vaDLXXwg9hwhjACLTVv1Jj+cRFzRY+up1bgcxRZjAts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G7jZgzP4qG/hRFMoQbr+CQt59FT4H2yyEfYjvuj7sHnMHfVb95HioFL/5satbfLiPv2skLG5BgOauVELGDypyTQl6fQNRySeIvhPtNovyje1eS2tspW/5MhVH1NV3LWc04f0KuEpOkqKye1GwErb8Izou81E439uqdrk55XqSQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=g4O7diqd; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g4O7diqd"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E9B61D6672;
	Thu, 22 Feb 2024 13:00:19 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vaDLXXwg9hwhjACLTVv1Jj+cRFzRY+up1bgcxR
	ZjAts=; b=g4O7diqd+gXJsyQxCv1pIG3siYvf0kKLY0mkn+iTG4qXyX83J8KgQj
	YV3xG4YLqdfHefj+DHfP8H4afkVCC3EdZ1i4OIs8rq/USYKvJ8WMxTUyCLrtnLCI
	LJaZc/+WVgvyNm6OCbYOxl806aqgPsHc1+iTZ1KlhFNPVvRVOafOY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BC7E1D6671;
	Thu, 22 Feb 2024 13:00:19 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E1A881D6670;
	Thu, 22 Feb 2024 13:00:18 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 5/5] cache-tree: avoid an unnecessary check
In-Reply-To: <91dc4ccd04e3a6cc50ed389edb6814e1e7a0c4dc.1708612605.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 22 Feb 2024
	14:36:45 +0000")
References: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
	<pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
	<91dc4ccd04e3a6cc50ed389edb6814e1e7a0c4dc.1708612605.git.gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 10:00:17 -0800
Message-ID: <xmqqle7ce5vy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3D61E706-D1AC-11EE-AFE8-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The first thing the `parse_tree()` function does is to return early if
> the tree has already been parsed. Therefore we do not need to guard the
> `parse_tree()` call behind a check of that flag.
>
> As of time of writing, there are no other instances of this in Git's
> code bases: whenever the `parsed` flag guards a `parse_tree()` call, it
> guards more than just that call.
>
> Suggested-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  cache-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index c6508b64a5c..78d6ba92853 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -779,7 +779,7 @@ static void prime_cache_tree_rec(struct repository *r,
>  			struct cache_tree_sub *sub;
>  			struct tree *subtree = lookup_tree(r, &entry.oid);
>  
> -			if (!subtree->object.parsed && parse_tree(subtree) < 0)
> +			if (parse_tree(subtree) < 0)
>  				exit(128);
>  			sub = cache_tree_sub(it, entry.path);
>  			sub->cache_tree = cache_tree();

Obviously makes sense.
I see no need for further comments.  Will queue.

Thanks.

