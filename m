Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38B51A08CE
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727123263; cv=none; b=AElEBcd0hCpd3gej6wrXwwLl3RO+7rB0kwbjOlLKMFUxp+Q1pwDIMIdCz4jbltR4vqiTXRkqc6Fdwe7kq339oM0TWu81gnWMFE6jAHkIGGXfsDXepxEelPfnU+s+yQ8pyggaWHfX33Vw2EnTJuUhPOUzSHJKRY4jlrwgbMCOEPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727123263; c=relaxed/simple;
	bh=q3dM6ydI2+SB2YJD5NzZ1O3oIwwaeTU7jSsyieAq1+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CekIdtxrT4ZGX44/9yNtwq8mkJTNsuch9X9lR4zE0cu8/zrB/Ny6hEPr+fibQQcRb/rTw92Y5QIUvanktiHbqoWgias+PC0g22UFZ2S/O4pJLBSKEQFpv/Y/uMRMayLNRewb5OFDwfrmPPLmqiMby7smBLfJ7MUBUcExxTNVoyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=diZnbd2m; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="diZnbd2m"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 872D3255E3;
	Mon, 23 Sep 2024 16:27:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=q3dM6ydI2+SB2YJD5NzZ1O3oIwwaeTU7jSsyie
	Aq1+Y=; b=diZnbd2mSJ5B+TLVqWJ7yV9uEei48aTTyIRWsziLE5czm8X5+pYV3n
	Ljn6FZG1UK6Seh3THKCVLeYfTUwy3jUPW3niqpNBQesE/shWLoj3ByQ7/Y6JScyf
	TRCHgLb30CRXXIe0YdgeTlipx8H7GvwY3wC7S74d7Xa5Ix8JqVxR8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D9E9255DF;
	Mon, 23 Sep 2024 16:27:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDA60255D8;
	Mon, 23 Sep 2024 16:27:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] sparse-checkout: disable advice in 'disable'
In-Reply-To: <pull.1800.git.1727119882901.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Mon, 23 Sep 2024 19:31:22
	+0000")
References: <pull.1800.git.1727119882901.gitgitgadget@gmail.com>
Date: Mon, 23 Sep 2024 13:27:38 -0700
Message-ID: <xmqqr09ayv2d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 476A3474-79EA-11EF-A85B-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> When running 'git sparse-checkout disable' with the sparse index
> enabled, Git is expected to expand the index into a full index. However,
> it currently outputs the advice message saying that that is unexpected
> and likely due to an issue with the working directory.
> ...
> +	/*
> +	 * Disable the advice message for expanding a sparse index, as we
> +	 * are expecting to do that when disabling sparse-checkout.
> +	 */
> +	give_advice_on_expansion = 0;
>  	repo_read_index(the_repository);

Sounds sensible.

> +/*
> + * If performing an operation where the index is supposed to expand to a
> + * full index, then disable the advice message by setting this global to
> + * zero.
> + */
> +extern int give_advice_on_expansion;
> +
>  struct index_state;
>  #define SPARSE_INDEX_MEMORY_ONLY (1 << 0)
>  int is_sparse_index_allowed(struct index_state *istate, int flags);
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index eb32da2a7f2..6e230b54876 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2355,7 +2355,10 @@ test_expect_success 'advice.sparseIndexExpanded' '
>  	mkdir -p sparse-index/deep/deeper2/deepest &&
>  	touch sparse-index/deep/deeper2/deepest/bogus &&
>  	git -C sparse-index status 2>err &&
> -	grep "The sparse index is expanding to a full index" err
> +	grep "The sparse index is expanding to a full index" err &&
> +
> +	git -C sparse-index sparse-checkout disable 2>err &&
> +	test_line_count = 0 err

I am not a huge fun of insisting that other code in the code path in
which I got rid of an unwanted error message must stay silent.  As
we are expanding to full, we are presumably rehydrating all the
directories that was sparsified, so it might be reasonable if we
want to see a progress output during this operation, for example [*].
Would it make more sense to look for the lack of specific advice
message instead?


[Footnote]

 * A mere example to illustrate the principle.  "We disable progress
   during test", or "this is so small that progress won't trigger"
   may both be a good reaction to the example, but the general point
   still stands.
