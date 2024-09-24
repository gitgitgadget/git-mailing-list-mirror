Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2645C1B85D6
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194675; cv=none; b=VI+l4YIzLMPjbhX++HWdMePniGlgib/4w2On6YfaXD1Y8Vu0FpGiYTGXfS+irMboe5FW9wUxJbE+o4q+zdXjX9CBHHTtcbhAGTTSeWQ3uPTzn9HbjSGgZQEQp2Yd/fffAo4rHWcdLIVmBtLu67LMalTrJAaFUZZ6yLeH0WZCthg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194675; c=relaxed/simple;
	bh=hFFDb65h37mC+eGoiX4QJzKuJZhgSXpiP2dafl+Xf0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KFqLkByJw4AKCsT2R2PtzAN3GbXCfuDPhwb+w6QpUgz1Bb4TI58y49NFPAZAgUtv4wpFxD6JmKwux6JNop+Lk52jQ70kysBfcDmXyUSuC9fsjstoHhge73FMwzcgyXpBE0o1C7iHSkMy4tbdMNlwkn8N8y5qnAi4c1c/xvxVZG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qhs4Ksfr; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qhs4Ksfr"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D1D219709;
	Tue, 24 Sep 2024 12:17:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hFFDb65h37mC+eGoiX4QJzKuJZhgSXpiP2dafl
	+Xf0o=; b=qhs4Ksfrc1ti3uvg+7OVGB0NYpP7YnKMfn3Sw7WDkr1MK+9nw8sLOn
	+WHniJu7HCHFR5dXFc0pOGZW1ndSD12+q4nPRJb/c9wysUVp1Ec7uzWv2oHGL4OW
	qdIUabmtgYkHLJovwGdqZwcBZep6nT/3zRXEIDXUXAS0Iyl/QKPjA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 546C819708;
	Tue, 24 Sep 2024 12:17:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A944E19707;
	Tue, 24 Sep 2024 12:17:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Ronan Pigott <ronan@rjp.ie>,  shejialuo
 <shejialuo@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 2/2] config: fix evaluating "onbranch" with nonexistent
 git dir
In-Reply-To: <535d0d07506e8248e47f90c1a7581679fc297b3d.1727171197.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 24 Sep 2024 12:05:46 +0200")
References: <1b9fb3f3fde62594b9ac999ffb69e6c4fb9f6fd6@rjp.ie>
	<cover.1727171197.git.ps@pks.im>
	<535d0d07506e8248e47f90c1a7581679fc297b3d.1727171197.git.ps@pks.im>
Date: Tue, 24 Sep 2024 09:17:45 -0700
Message-ID: <xmqq7cb1vxee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 892D85FE-7A90-11EF-8023-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> As the quoted comment mentions, we'd ideally refactor the code to not
> set up `gitdir` with an invalid value in the first place, but that may
> be a bigger undertaking. Instead, refactor the code to use the ref
> storage format as an indicator of whether or not the ref store has been
> set up to fix the bug.
>
> Reported-by: Ronan Pigott <ronan@rjp.ie>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> ...
> -	const char *refname = (!data->repo || !data->repo->gitdir) ?
> -		NULL : refs_resolve_ref_unsafe(get_main_ref_store(data->repo),
> -					       "HEAD", 0, NULL, &flags);
> -	const char *shortname;
> +	const char *refname, *shortname;
>  
> -	if (!refname || !(flags & REF_ISSYMREF)	||
> -			!skip_prefix(refname, "refs/heads/", &shortname))
> +	if (!data->repo || data->repo->ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
> +		return 0;

OK.  A very direct check to see what we really care about.

