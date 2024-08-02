Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E226749634
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 21:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634871; cv=none; b=m/ye04QLkdOTBXD39CFsTmf66N5N4yQxCUSNLf4dMmhcCEV0BLlkSmVcYk5EQGZc67Gcz0aNUlSI9URG48lAgN6Pu0zfCKy1dEbMKz8Mh/QS/jDBsN0oqZviImPmPd90cdYCi/nf737ZVMq/BCJqA55YrIaF96hVDRhdba1eU9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634871; c=relaxed/simple;
	bh=3dxRk6QeDU8c553P1ajwg8hsXdlguR1btg7WKkfeosk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hG7s8i7Wi0vN1ealbBN86OZG22syWF5qYU3y6OgByW8N/Q0ZFXsdQGgS1kRIZFlZ81lpUV/HlkU+kTio/Nv6OYXRdhOPMejLR2cu6gX1wzZ9oiXoHuKPbA/8oDvOwovR8HAtVdIMJWP+41VQFCf5ue2unzHRaAKzB81manK6fm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=o3uCTHO9; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o3uCTHO9"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DD7F1295BD;
	Fri,  2 Aug 2024 17:41:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3dxRk6QeDU8c553P1ajwg8hsXdlguR1btg7WKk
	feosk=; b=o3uCTHO9lE0M6Y/+Wflh9VDcAjxfiqy4azaOoHEN0WHmQ++NMowMwb
	lEtMlX6Yau8DzhWYGHpWwN0n6Q+lhXdAV91h1FKj7cxvAkcPxV9cC92YOo78edfh
	stkEXKuBubYPNI2asCrCG8rFbxraVyedR3pIK7/DtGu4LrRGyygLc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D481B295BC;
	Fri,  2 Aug 2024 17:41:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26F0E295BB;
	Fri,  2 Aug 2024 17:41:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kyle Lippincott
 <spectral@google.com>
Subject: Re: [PATCH v2 3/3] t6421: fix test to work when repo dir contains d0
In-Reply-To: <818dc9e6b3e8a4d449cb9dbce689bfadb95099ff.1722632287.git.gitgitgadget@gmail.com>
	(Kyle Lippincott via GitGitGadget's message of "Fri, 02 Aug 2024
	20:58:07 +0000")
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
	<pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com>
	<818dc9e6b3e8a4d449cb9dbce689bfadb95099ff.1722632287.git.gitgitgadget@gmail.com>
Date: Fri, 02 Aug 2024 14:41:06 -0700
Message-ID: <xmqqr0b6a9hp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ED760268-5117-11EF-8A95-BAC1940A682E-77302942!pb-smtp2.pobox.com

"Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kyle Lippincott <spectral@google.com>
>
> The `grep` statement in this test looks for `d0.*<string>`, attempting
> to filter to only show lines that had tabular output where the 2nd
> column had `d0` and the final column had a substring of
> [`git -c `]`fetch.negotiationAlgorithm`. These lines also have
> `child_start` in the 4th column, but this isn't part of the condition.
>
> A subsequent line will have `d1` in the 2nd column, `start` in the 4th
> column, and `/path/to/git/git -c fetch.negotiationAlgorihm` in the final
> column. If `/path/to/git/git` contains the substring `d0`, then this
> line is included by `grep` as well as the desired line, leading to an
> effective doubling of the number of lines, and test failures.
>
> Tighten the grep expression to require `d0` to be surrounded by spaces,
> and to have the `child_start` label.

OK.

I think I actually misinterpreted what you meant with these changes.
It is not what the patterns are picking.  It is some _other_ trace
entry we do not necessarily care about, like label:do_write_index
that has the path to the .git/index.lock file, that can accidentally
contain d0, that can be picked up with a pattern that is too loose.
So it really didn't have to clarify what it is looking for, as it
would not help seeing what false positives the patterns are designed
to avoid matching.  Sorry about that.

Will queue.


