Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAF718657
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622885; cv=none; b=uIQd0l/zanBMqwsyFQsF6Xmmvku3p+zeeBksFOAv+hh9oDL49evGZCs+6reAKzFA1X7TxkQKrGjO0cMQfvHVW1ZVNJkzBuCxNgIlI2KQhFgzw+CTFmOafwAH+z0kqGuqmaCgp0eZgePy+spQt1jrEfHOblLdYjp4fmCaPsuZRdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622885; c=relaxed/simple;
	bh=VjyslXf5R6Y+kozktvc0GNoCL+YfhN+4TrMduwpp5m8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lg0x0bEe5r6T51mLO2SG7cI3WZuIFAaVvoGN2pQcDTsOkqW71lw2OSUnSnzV9mGm9NOmGP/H224zyCLYzluS7X1ws+tGb1sK8tZ40yqYUCtE/UN5X11U2QokGvvTKu3o4Rz8LBfwhFeLgBEoxCLBuEi7OgqV+kf+sJlEiiPZbeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lO8bCeWN; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lO8bCeWN"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A82C11A043;
	Thu, 22 Feb 2024 12:28:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VjyslXf5R6Y+kozktvc0GNoCL+YfhN+4TrMduw
	pp5m8=; b=lO8bCeWNb2O5DPHTu0ozn9DgzffNCbQa05GkBR39DvyHgHgQc7ac3M
	8ae+ZxKC3vmnXGeLBIrwwZz2j86hXlThBkd5wbDFDtcTLl2bXbHqPqHw87ge3n9r
	jJaZm+U9ArqbBPJS84pD4FBg2tiPIrxrin5vNuNzTgM4sCZ5j0QyQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A034C1A042;
	Thu, 22 Feb 2024 12:28:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 348F91A03F;
	Thu, 22 Feb 2024 12:28:00 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 3/5] t4301: verify that merge-tree fails on missing
 blob objects
In-Reply-To: <e82fdf7fbcbf12fffdf4a720927c2f4f006068f8.1708612605.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 22 Feb 2024
	14:36:43 +0000")
References: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
	<pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
	<e82fdf7fbcbf12fffdf4a720927c2f4f006068f8.1708612605.git.gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 09:27:58 -0800
Message-ID: <xmqqttm0fly9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B9D1DB5C-D1A7-11EE-9536-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We just fixed a problem where `merge-tree` would not fail on missing
> tree objects. Let's ensure that that problem does not occur with blob
> objects (and won't, in the future, either).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t4301-merge-tree-write-tree.sh | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
> index 908c9b540c8..d4463a45706 100755
> --- a/t/t4301-merge-tree-write-tree.sh
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -962,4 +962,20 @@ test_expect_success 'error out on missing tree objects' '
>  	test_must_be_empty actual
>  '
>  
> +test_expect_success 'error out on missing blob objects' '
> +	echo 1 | git hash-object -w --stdin >blob1 &&
> +	echo 2 | git hash-object -w --stdin >blob2 &&
> +	echo 3 | git hash-object -w --stdin >blob3 &&
> +	printf "100644 blob $(cat blob1)\tblob\n" | git mktree >tree1 &&
> +	printf "100644 blob $(cat blob2)\tblob\n" | git mktree >tree2 &&
> +	printf "100644 blob $(cat blob3)\tblob\n" | git mktree >tree3 &&
> +	git init --bare missing-blob.git &&
> +	cat blob1 blob3 tree1 tree2 tree3 |
> +	git pack-objects missing-blob.git/objects/pack/side1-whatever-is-missing &&
> +	test_must_fail git --git-dir=missing-blob.git >actual 2>err \
> +		merge-tree --merge-base=$(cat tree1) $(cat tree2) $(cat tree3) &&
> +	test_grep "unable to read blob object $(cat blob2)" err &&
> +	test_must_be_empty actual
> +'

It would have been even easier to see that blob2 is what we expect
to be complained about, if you listed all objects and filtered blob2
out, but the number of objects involved here is so small, a "cat" of
all objects we want to keep is OK here.

Again, I very much love the way the test repository/object store
that lack certain objects are constructed without making our hands
dirty.

I see no need for further comments.  Looking very good.
