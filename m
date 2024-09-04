Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DF62BD0D
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466989; cv=none; b=UijXwhawFxaQMqA+corFSF2X/VRQEpSUP53JC1+Ebzib0YogcflYU7/RwPNmDlaR3b862Dcw65keODAMYgiFUWKdMHGVFkBa9pnW0R8/xVbJX+UHysY9WjdywSSrnGgainRLwMPVaDo/PuM63PVBoKT1UCAV//U5/iCeSmhMLZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466989; c=relaxed/simple;
	bh=pLGR3IahD3yC+aD/YpyhUmYkGnhCcT8N7mLJZSDcVfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dCjJaLOF41DxjTFoADzUaphgbwpI1FNO9WKxGqmPd/GZvOYAwPsvyVcguRkpdYPSJjBiv6aWt/qmQ3dRpUi23NFai5WxpG1+waFQgEBQqKPUoqjRjhc+m5/Rfyrm2nViFntAAvrnDLlLRfoEftOgsV6yrDGrebhCcHwEr0LrY5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CGjaj2dc; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CGjaj2dc"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A16136056;
	Wed,  4 Sep 2024 12:23:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pLGR3IahD3yC+aD/YpyhUmYkGnhCcT8N7mLJZS
	DcVfc=; b=CGjaj2dcoKat+TnA8MdYDtZCVwh+Ni7gQQdoRJU1+CzNX+0tU8kGgl
	+6bzKt2s6+Px3c0N55tRtI1GJWcSwGKBmnW+4NqNcSGoOBgLQvMvWytNqKgKqBe3
	8y93FkwHw08Qmhh8VYWPY3/O5Ns/oAwK25CwYqS2g3ZxssCLDDgbs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BDF7136055;
	Wed,  4 Sep 2024 12:23:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C693236054;
	Wed,  4 Sep 2024 12:23:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kevin Lyles via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Kevin Lyles
 <klyles+github@epic.com>,  Kevin Lyles <klyles@epic.com>
Subject: Re: [PATCH v4 1/2] t1092: allow run_on_* functions to use standard
 input
In-Reply-To: <73fe71abcd578316a81615feee9561015c2a1c53.1725401207.git.gitgitgadget@gmail.com>
	(Kevin Lyles via GitGitGadget's message of "Tue, 03 Sep 2024 22:06:46
	+0000")
References: <pull.1770.v3.git.git.1725386044.gitgitgadget@gmail.com>
	<pull.1770.v4.git.git.1725401207.gitgitgadget@gmail.com>
	<73fe71abcd578316a81615feee9561015c2a1c53.1725401207.git.gitgitgadget@gmail.com>
Date: Wed, 04 Sep 2024 09:23:04 -0700
Message-ID: <xmqqv7zbbd7b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F730EFBC-6AD9-11EF-A373-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"Kevin Lyles via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kevin Lyles <klyles@epic.com>
>
> The 'run_on_sparse' and 'run_on_all' functions do not work correctly for
> commands accepting standard input, because they run the same command
> multiple times and the first instance consumes it. This also indirectly
> affects 'test_all_match' and 'test_sparse_match'.
>
> ...
> -# Usage: test_sprase_checkout_set "<c1> ... <cN>" "<s1> ... <sM>"
> +# Usage: test_sparse_checkout_set "<c1> ... <cN>" "<s1> ... <sM>"
>  # Verifies that "git sparse-checkout set <c1> ... <cN>" succeeds and
>  # leaves the sparse index in a state where <s1> ... <sM> are sparse
>  # directories (and <c1> ... <cN> are not).

Reads much better.  Will queue.  Thanks.
