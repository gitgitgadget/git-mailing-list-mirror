Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A023A59
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708734805; cv=none; b=EsbKjxtzG8XKXhE5KEPMV8117XBvjU7D+mCBXTzsrnfI5QbDL+casH0MuUaKTgzdJjt+u2Umd9Olme+BhBpngkfuxmgWIJPELH23f/jJh4nQd2f+oz/MwFpc7C1DkMdrzXSmQ4W8dPJieiEbpagvxURCEtLDVgkxXb1w8Az1BAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708734805; c=relaxed/simple;
	bh=DfGPnpFEXHtaJNh+L+qqac/3kYcMfTxzFdlLDJyQpJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KZmaDrCtXCqQYcekHUQ4Lqw25yuAnieNKMF9FVsxPIIpTNiqvjZ1eCrqp0/VrrWgRlYaZoSClUxujzkJuiXZuTf5p1VhP00s84mFx7H+ZINr3lTHmCdm3XsUaq2ADZnSvBpJt9MrDNJVXRzHlS9UdMDO7MR4yfRXP6yxYcbOqK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ray2Q4CT; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ray2Q4CT"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 52ED01E28F3;
	Fri, 23 Feb 2024 19:33:20 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DfGPnpFEXHtaJNh+L+qqac/3kYcMfTxzFdlLDJ
	yQpJM=; b=ray2Q4CTOWr+mwSFKwDgq9IeCDcWa/qkbYi7N6NOXjf6Rq7i+Wq0eS
	z7V1c6n6V72zDed0g3VgXLrrvHyr9tfkpB82PO+KWlZENvZDWIvpZHdf0PFBUmmP
	LbjjBHAq/hwbL5FedvEdkGFmRLs310yt7haDtHNTSafNju7iDTzA0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 375281E28F2;
	Fri, 23 Feb 2024 19:33:20 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CC5A1E28F1;
	Fri, 23 Feb 2024 19:33:19 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 03/11] Start reporting missing commits in
 `repo_in_merge_bases_many()`
In-Reply-To: <4dd214f91d4783f29b03908cc0034156253889a7.1708608110.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 22 Feb 2024
	13:21:42 +0000")
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
	<pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
	<4dd214f91d4783f29b03908cc0034156253889a7.1708608110.git.gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 16:33:18 -0800
Message-ID: <xmqqle7asnu9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4EF4F232-D2AC-11EE-B319-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Some functions in Git's source code follow the convention that returning
> a negative value indicates a fatal error, e.g. repository corruption.
>
> Let's use this convention in `repo_in_merge_bases()` to report when one
> of the specified commits is missing (i.e. when `repo_parse_commit()`
> reports an error).
>
> Also adjust the callers of `repo_in_merge_bases()` to handle such
> negative return values.

All of the above makes sense, but I have to wonder if this hunk
should rather want to be part of the previous step:

> @@ -486,10 +488,10 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
>  	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
>  
>  	if (repo_parse_commit(r, commit))
> -		return ret;
> +		return ignore_missing_commits ? 0 : -1;
>  	for (i = 0; i < nr_reference; i++) {
>  		if (repo_parse_commit(r, reference[i]))
> -			return ret;
> +			return ignore_missing_commits ? 0 : -1;
>  
>  		generation = commit_graph_generation(reference[i]);
>  		if (generation > max_generation)

as this hunk is not about many callers of repo_in_merge_bases() that
ignored the return values, which are all fixed by this patch, but
about returning that error signal back to the caller.

Yes, I know you wrote in [02/11] that it does not change the
behaviour, and if you move this hunk to [02/11], it might change the
behaviour, but that is changing for the better.  Besides, adding a
parameter "ignore_missing" to the function only to be ignored until
the next patch feels rather incomplete.

The other changes in this patch about its primary theme, fixing the
callers that used to ignore return values of repo_in_merge_bases(),
all looked sensible.  This hunk somehow stood out like a sore thumb
to me.


