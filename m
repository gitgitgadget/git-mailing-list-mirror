Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E17E154C18
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622010; cv=none; b=YtemvC9GULWIpMNt4I71jOeM2ZTH1x5Vj7JhCthyXUSQBjQRRfobsLQ8WmL1GkI9cvnYR6PFCDK5lo0+cWiMLO2RXXtk6AH8sz0BfulxunSH0hkntfENu8ktDr1i1GLiXlGcYouPLPK3IJv7ogKdZ8GrFkmDtONaKKGLP1Zfs3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622010; c=relaxed/simple;
	bh=a1bWMKTvQVTed+P++8wSrd0rjm/1oXL3DfSAziw4x7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QA6T9pne6/dNdB+ye05wcvqMneFF836KZ8OFegb9irONMQeGESoEIHMZ2HDn1ubQUyBspO14SsWi6yabUB05XGq6kbE6XemhES19oQ/2mMi9bPfkW3M4bcdQ8rDVq3/pdn6ZDxL99hXLIoWReJwxpB5BXltZu9GAQzRUfm5gV/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oIXirhsB; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oIXirhsB"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EE11E19F90;
	Thu, 22 Feb 2024 12:13:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=a1bWMKTvQVTed+P++8wSrd0rjm/1oXL3DfSAzi
	w4x7U=; b=oIXirhsB4W4cY7MqRT62wugmyMT+qqvHDSIWoyKQlIHQ1J1mzN+E6P
	EWshahlzq6nQkotcf/EXy1Sy4griebeIB1T81StHQa/unDJE9u6SEhERRLEkc76B
	fNYJGxAHD2+VE2nt/a4wT55Yc2KQiYEPJAhP8yC4OT0d5vUZv/bWs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E7BA219F8F;
	Thu, 22 Feb 2024 12:13:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 818F319F8E;
	Thu, 22 Feb 2024 12:13:24 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 1/5] merge-tree: fail with a non-zero exit code on
 missing tree objects
In-Reply-To: <11b9cd8c5da5e6792ce940ea29d2e93e57731555.1708612605.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 22 Feb 2024
	14:36:41 +0000")
References: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
	<pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
	<11b9cd8c5da5e6792ce940ea29d2e93e57731555.1708612605.git.gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 09:13:22 -0800
Message-ID: <xmqq4je0h171.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AFDE5ADC-D1A5-11EE-ABC9-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> -	parse_tree(merge_base);
> -	parse_tree(side1);
> -	parse_tree(side2);
> +	if (parse_tree(merge_base) < 0 ||
> +	    parse_tree(side1) < 0 ||
> +	    parse_tree(side2) < 0)
> +		return -1;

Obviously good.

> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
> index 7d0fa74da74..908c9b540c8 100755
> --- a/t/t4301-merge-tree-write-tree.sh
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -951,4 +951,15 @@ test_expect_success '--merge-base with tree OIDs' '
>  	test_cmp with-commits with-trees
>  '
>  
> +test_expect_success 'error out on missing tree objects' '
> +	git init --bare missing-tree.git &&
> +	git rev-list side3 >list &&
> +	git rev-parse side3^: >>list &&
> +	git pack-objects missing-tree.git/objects/pack/side3-tree-is-missing <list &&
> +	side3=$(git rev-parse side3) &&
> +	test_must_fail git --git-dir=missing-tree.git merge-tree $side3^ $side3 >actual 2>err &&
> +	test_grep "Could not read $(git rev-parse $side3:)" err &&
> +	test_must_be_empty actual
> +'

I very much like the way this test emulates an operation in a
repository that lack certaion objects so cleanly, and wish we
had used this pattern instead of poking at loose object files
in hundreds of existing tests (#leftoverbits obviously).

It also justifies why a silent "return -1" in the patch is
sufficient ;-)

Thanks.
