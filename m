Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB425BAF7
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585349; cv=none; b=IA51zYD+TJ84cMaWGSBCPHnAtQdW0GVkV30NejTURNshojVGQJmLDn99+ksvTUSeipGU8wJvbNhMCj7Is6zIyx0IIecnp0jd5gvVXmtfrJIg+eItzzftWv9YfH0jm9pEZ7/FIaNNVcjsr+PApK33WXzSNGYyHonZbRN05X+NZ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585349; c=relaxed/simple;
	bh=UV/LdpTY6NV4e7OYQBDvz2V4GPnnvrbMUB20uWvFuzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F9mTwGBry4lIF2bjGqH1mFoSWSe5z5DNuVZnIT8wgsra7cdrv8BqpJnTk6j122DNlucCCIBbSSLkL0gNhE1edJIVtOMcBnEqDd6Wzuf0HMtZzA60rspUgxDig3XMCU3PKi91Qttj9uP9qL6LIuViJY3teka8DAFUAMl2W/24AWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RaIwmtwE; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RaIwmtwE"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D70B21CC9B8;
	Sat, 10 Feb 2024 12:15:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UV/LdpTY6NV4e7OYQBDvz2V4GPnnvrbMUB20uW
	vFuzY=; b=RaIwmtwEgVGPzUNvoenNlP8gdtOwC9mh6tgBoa9p5jJ/GRin1pwmCT
	4gecbc28a60cn5ogR0dbXFcLArVIwU6IyFlvyvYtj5s0XWZpCDJBOygynQC/3w2q
	OusM449EeAWBwRaVy7AgdeDLiUoPGJNxGcHwUTvHgyYW95W+zZ+zg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CD97C1CC9B7;
	Sat, 10 Feb 2024 12:15:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 385AB1CC9B6;
	Sat, 10 Feb 2024 12:15:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Philippe Blain via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 3/5] completion: add and use
 __git_compute_first_level_config_vars_for_section
In-Reply-To: <e8642ad8-bdc9-00d6-39b5-81dd399e60ec@gmail.com> (Philippe
	Blain's message of "Sat, 10 Feb 2024 11:06:23 -0500")
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
	<pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
	<838aabf2858b73361be8e8579bc80826e1cfd4c3.1706534882.git.gitgitgadget@gmail.com>
	<ZcSF1mJ-JXQLmoZ5@tanuki>
	<e8642ad8-bdc9-00d6-39b5-81dd399e60ec@gmail.com>
Date: Sat, 10 Feb 2024 09:15:43 -0800
Message-ID: <xmqqwmrcb5q8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 06C73D22-C838-11EE-9C23-25B3960A682E-77302942!pb-smtp2.pobox.com

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>>> +	__git_compute_config_vars
>>> +	local this_section="__git_first_level_config_vars_for_section_${section}"
>>> +	test -n "${!this_section}" ||
>>> +	printf -v "__git_first_level_config_vars_for_section_${section}" %s "$(echo "$__git_config_vars" | grep -E "^${section}\.[a-z]" | awk -F. '{print $2}')"
>>> +}

A silly question (primarily because I do not much use the indirect
reference construct ${!name}).  Does the assignment with printf need
to spell out the long variable name with "_${section}"?  Can it be

    printf -v "$this_section" ...

instead, as we already have the short-hand for it?

> finds also others. I think the idea is to cache these lists to avoid 
> computing them everytime they are needed (probably most useful on Windows 
> where process creation is longer). I'll mention that in the 
> commit message.

Yup, as long as the contents of the list stays stable (e.g., list of
Git subcommands, list of options a Git subcommand takes, list of
configuration variable names that do not have end-user customization
part, etc.), it is a viable optimization technique.  The available
<slot> for color.branch.<slot> and color.diff.<slot> do not change
(unless you talk about new version of Git adding support for more
slots) and is a good idea to cache.  remote.<name>.url takes its
<name> component out of an unbound set of end-user controlled names,
so unless we somehow have a method to invalidate cached values, the
list can go stale as remotes are added and removed.

Thanks.



