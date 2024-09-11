Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833219992A
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726088903; cv=none; b=cC7aOmf8ZGgAMjRk6oa683dBZuPDGYqSsC1tgfeCL15gZXj+iWWO8E2UJa+HzSbLkbiUIn01LrqE4lgE/65moPeCMc3v7KQMjJlforPBTXmFSSM1eorpXL9rv2vnSUIUDTnx5bN8mLR3laKVMA33mcXv/LrxwN8Ocb8d/dHy+RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726088903; c=relaxed/simple;
	bh=QqLu6vd8b8ResIwpOAneVJcRtNv1EvIqRmnD2rM1HZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LJ/K3IyyeXznN9bujpQFWl5bjoKYpUOYCUAfN2DBbDRrgykjflR78rp3wwlNoBmatAQh+fOmiD5hwpeDVyuEKHiOh5zXKL7nF3hwGUI8YA6qL32I65r4k8zWGxYrh+wRj5NBFWKg69VDrBYX7GGIDUzI9naLzZ83fRumUJSmJXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=s/T70L1G; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s/T70L1G"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B963825172;
	Wed, 11 Sep 2024 17:08:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QqLu6vd8b8ResIwpOAneVJcRtNv1EvIqRmnD2r
	M1HZ0=; b=s/T70L1Gx3YltNXsrrQpyIfhSGF9mnjQQ8YBi51zYzVmoyeoaHwx7B
	xwGkACOI8ha06CXhfzmrStQrKi/i4Bo5LDDEWrCV1Fcuf/WIGXEMCmEsnmWEJSdx
	KfqoCpYCYuzIhlDB6OTigTstv0l/rK40bq+NsY41G1gHYb4Vvgk20=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AEF7C25171;
	Wed, 11 Sep 2024 17:08:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CEC1525170;
	Wed, 11 Sep 2024 17:08:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  John Cai
 <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/3] builtin: add a repository parameter for builtin
 functions
In-Reply-To: <xmqqed5rdw61.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	10 Sep 2024 14:40:54 -0700")
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
	<pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com>
	<9aaf966254493678d3e25b93cb11017c814d3087.1726001961.git.gitgitgadget@gmail.com>
	<xmqqed5rdw61.fsf@gitster.g>
Date: Wed, 11 Sep 2024 14:08:17 -0700
Message-ID: <xmqqfrq56gqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F82EA910-7081-11EF-8D5E-9B0F950A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>  git.c                              |  12 +-
>>  help.c                             |   3 +-
>>  stkOs5Qh                           | Bin 0 -> 10485768 bytes
>
> WTH is this file?

It turns out to be an "ar" archive full of *.o files.  Perhaps
creation of libgit.a was interrupted, then later somebody said
"git add .", and the file somehow ended up as a part of Git.

I've applied the series after removing the cruft.

The overall thrust to pass the repository found by the setup step to
builtins as a parameter is a very good one, as most of the Git
commands are designed to work in a repository.

With this, can commands that are marked with RUN_SETUP_GENTLY rely
on the NULL-ness of repo parameter to decide if they are in a
repository or running outside a repository?

The "nongit?" status returned from setup_git_directory_gently() call
made by git.c:run_builtin() is thrown away and not passed to the
builtin functions at all, so some of them currently may be doing
another discovery themselves, and if we can replace such a wasteful
setup_git_directory_gently() call, it would be nice, and passing the
discovered repository instance to builtin commands is a good first
step to go there.

Thanks.
