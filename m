Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338911BA874
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087539; cv=none; b=EwHTMvox1fIRfr7AV6AIpPmmMCfnJKmfNARrYnRIMYKIUVeLpZ3DyHFCW2W+YynQ9gPiyWpVLD9tUMfxqxjLT5mt1ENLLD+5C0CfvgH8EW60PiMH8Atv2HN6k39g5z+8pQBJNOKBR1hprSV3A9nvx5Y9pxJgv5TuXqF6qtGgeTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087539; c=relaxed/simple;
	bh=LKq9AKEKPxoKl99bc7ZPk5OO4+ES34hyt/xpuHmf+cY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pYIPu+Z7v17IWIF6PrtB70gh16PNYvCQJZjg7SADx0b1T5wyqWovEscU9MNKI4wkBRd66ki5FvgRUGlWAXptELRM0jFgtLPfAbYP11HXVRW/Tw0QDw+lnHvSgGRjhczmJZa6r5p5q7J1OyWCxJ/Vzm8odPNTqNZQB2nxR817t1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jVTtMar1; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jVTtMar1"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CC23A1E066;
	Wed, 11 Sep 2024 16:45:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LKq9AKEKPxoKl99bc7ZPk5OO4+ES34hyt/xpuH
	mf+cY=; b=jVTtMar1cZjUOXQqfVNsw4nMFeUO23TTG+PcxJdnbzXivnkMGoqnG0
	AdbyUOEy1tEicOP3EOaUkzNjM45+n2ZQqSPVQzTLY57YAweww4m12anz+xH2XXCF
	nf/ucQdFjUPPsUmLS9Dd9OYLmvDsR6Kpd1EY2TZfuKapFS8DVlbPI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C466E1E065;
	Wed, 11 Sep 2024 16:45:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3699A1E064;
	Wed, 11 Sep 2024 16:45:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Han Jiang <jhcarl0814@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/4] remote: fix set-branches when no branches are set
In-Reply-To: <d95a07a22aadccd0c0e0e63bbb98b3a4306545d2.1726067917.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Wed, 11 Sep 2024 15:18:34
	+0000")
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
	<d95a07a22aadccd0c0e0e63bbb98b3a4306545d2.1726067917.git.gitgitgadget@gmail.com>
Date: Wed, 11 Sep 2024 13:45:33 -0700
Message-ID: <xmqq4j6l7wcy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CB65B778-707E-11EF-B287-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> To replace the list of branches to be fetched "git remote set-branches"
> first removes the fetch refspecs for the remote and then creates a new
> set of fetch refspecs based and the branches passed on the commandline.
> When deleting the existing refspecs git_config_set_multivar_gently()
> will return a non-zero result if there was nothing to delete.
> Unfortunately the calling code treats that as an error and bails out
> rather than setting up the new branches. Fix this by not treating a
> return value of CONFIG_NOTHING_SET as an error.

Makes sense.

> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 08424e878e1..cfbd6139e00 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -1131,7 +1131,9 @@ test_expect_success 'remote set-branches' '
>  	+refs/heads/next:refs/remotes/scratch/next
>  	+refs/heads/seen:refs/remotes/scratch/seen
>  	EOF
> -
> +	cat  <<-\EOF >expect.replace-missing &&
> +	+refs/heads/topic:refs/remotes/scratch/topic
> +	EOF
>  	git clone .git/ setbranches &&
>  	(
>  		cd setbranches &&
> @@ -1161,14 +1163,20 @@ test_expect_success 'remote set-branches' '
>  
>  		git remote set-branches --add scratch seen &&
>  		git config --get-all remote.scratch.fetch >config-result &&
> -		sort <config-result >../actual.respect-ffonly
> +		sort <config-result >../actual.respect-ffonly &&
> +
> +		git config --unset-all remote.scratch.fetch &&

OK, so we get rid of all "fetch" refspec elements and make sure we
can ...

> +		git remote set-branches scratch topic &&

... set a single new one like this ...

> +		git config --get-all remote.scratch.fetch \
> +					>../actual.replace-missing

and we expect the mapping to appear in the output.  For
maintainability, it would be better to also sort this one to mimick
the other one that contain multiple entries in the output, but
because we expect only one entry to be in the output, not sorting is
OK for now.

Looks good.  Thanks.
