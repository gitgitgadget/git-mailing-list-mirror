Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548BF41C67
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 20:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718914687; cv=none; b=ozy1VjfGoSbaMKbSHbNjWyulIvTdVQIKdUtGNiyFGv/pgZmvbdOYCKHePnrR8WVLbeVkEALaso5A5BRUP6/z+2TkcBZmzafDtHFiW/fVVaZ94jguazpJjmgkUUxjS+FQs+AgJGQeOmlEi9RjatCYjph6wTqmGPN0Zq6MsmCATTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718914687; c=relaxed/simple;
	bh=CueXBsKY+Bg4EBgqFzqytg/pEUW51Yf9/3XsLdaRUQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N4IsJjNDjk03epD4sYFU8AS+QjNUGobXrvMu6ehFExUmtMC7c7efNdMo+tiTBXN6l3z8odZiWvvuLuKoqjnaP1nDqldWyg3eS7zx+QSkiGYb0CXcBH766SodRxAidNGVqUt2UJWd/fJ/BoNbX/kbF5oXGMIUgFuCG+TiPx6JaIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JtLBTWWV; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JtLBTWWV"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C85DF1E467;
	Thu, 20 Jun 2024 16:18:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CueXBsKY+Bg4EBgqFzqytg/pEUW51Yf9/3XsLd
	aRUQg=; b=JtLBTWWVzcUorB0YClWm8KVBmnUs6ms7Er86EDbXiMtgqvC1WtXAer
	euMD61MKrXTR3jf6wmlFe2m6aXLsmtMR74dVh7DZNjTGvdnzC9wL1z/HZd1N5fxX
	o7DkNsHs/l+/szDKB2jK9iKNEqoy1DahFPj5dEYhQNmjsxLfu9FLY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A36591E466;
	Thu, 20 Jun 2024 16:18:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BCBF81E465;
	Thu, 20 Jun 2024 16:18:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Patrick
 Steinhardt <ps@pks.im>,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 07/17] mktree: use read_index_info to read stdin lines
In-Reply-To: <9dc8e16a7fca886ec378d74a8e2ac61921a7f6ea.1718834285.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Wed, 19 Jun 2024 21:57:55
	+0000")
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
	<9dc8e16a7fca886ec378d74a8e2ac61921a7f6ea.1718834285.git.gitgitgadget@gmail.com>
Date: Thu, 20 Jun 2024 13:18:00 -0700
Message-ID: <xmqqbk3vtll3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 322CCE98-2F42-11EF-953E-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +INPUT FORMAT
> +------------
> +Tree entries may be specified in any of the formats compatible with the
> +`--index-info` option to linkgit:git-update-index[1]:
> +
> +include::index-info-formats.txt[]
> +
> +Note that if the `stage` of a tree entry is given, the value must be 0.
> +Higher stages represent conflicted files in an index; this information
> +cannot be represented in a tree object. The command will fail without
> +writing the tree if a higher order stage is specified for any entry.
> +
> +The order of the tree entries is normalized by `mktree` so pre-sorting the
> +input by path is not required.

Nicely done.  I was wondering how the common/shared text that was
made more generic in 04/17 would be made to fit in the new context,
and the "Note that" makes them mix very well.

The updated code is exactly as expected.
