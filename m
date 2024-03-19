Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F158480
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858768; cv=none; b=IB0DnsiXJLlRPmMpcCDrOYKBYYcUxSZlamIFnEy2lQoM07MEJoa3QmpYhdXYnaYVcGJCZwjuFQtWQI79zE+qiWtZPMreLNZKxPQiTUyVfI93eTpm1RGKBx9DG33GLJBxTgHrgrbq1n5jqKp/oNMIEk6UVgoKU5/UciKG0MrkQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858768; c=relaxed/simple;
	bh=TvGt57AP+s5bUGfLkSWCLdyCXvjdQWiOkDKBwZ2x0ZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=quw8/TjuRzPgB242MmLzthP0H6S9IfpVYt81zc4zVRfctesJz8GTdbM88k3iZMougQYVbg+4LmImEQtzrSv+TQbs45oRbUWBRut8RNTI6wf2K6JWJ6UIYerYuyh3MXoW7P9rhjGjWINaUIDxgS5ZaL3uGglPf8r0jpwSbX63kxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xSpIrSxN; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xSpIrSxN"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D4B391D9501;
	Tue, 19 Mar 2024 10:32:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TvGt57AP+s5bUGfLkSWCLdyCXvjdQWiOkDKBwZ
	2x0ZU=; b=xSpIrSxNVCnl+y9B2Pjg2wbLW5zhUqsfbMiFl2zVcQw5uy3AbrgfqR
	MXZP9jPTksiRWg2DtaRch/WVDY42GuzGJNV6YSWVMakDG+W+N4pf23lk4J1gYlWw
	GGXXHpzuB/TX/uDJJXmH60177A3DZNnl1f/tfJ4OytReMC6IkVYLk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF8451D9500;
	Tue, 19 Mar 2024 10:32:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 180061D94FF;
	Tue, 19 Mar 2024 10:32:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] grep: introduce new config option to include
 untracked files
In-Reply-To: <923c5f84c44a195d6ba08503e28851af@manjaro.org> (Dragan Simic's
	message of "Tue, 19 Mar 2024 06:47:48 +0100")
References: <cover.1710781235.git.dsimic@manjaro.org>
	<9f70eeb4f04a874a2036e1d8c61f3b7ec130663a.1710781235.git.dsimic@manjaro.org>
	<xmqqr0g7rqag.fsf@gitster.g>
	<923c5f84c44a195d6ba08503e28851af@manjaro.org>
Date: Tue, 19 Mar 2024 07:32:41 -0700
Message-ID: <xmqqil1is35i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8BDE4888-E5FD-11EE-97EC-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>>> +	if (use_index && !cached)
>>> +		git_config_get_bool("grep.includeuntracked", &untracked);
>> Can this ever return an error?  E.g.
>> 	[grep] includeuntracked = "not really"
>
> After a brief inspection of the code in cache.c, git_config_get_bool()
> always returns either 0 or 1, so we should be fine.  Thus, any
> strangeness in a configuration file would end up not enabling
> this option.

If that were the case, then it is not "fine".

When the user triggered an operation which *requires* us to parse
and interpret the meaning of an entry in their configuration file
correctly in order to carry it out, and if that entry has a value
that we do not consider valid, we should notice and complain, before
saying "Nah, this I do not understand, so I'll do one of the two
things I would have done if the value were understandable and would
not tell the user which one I did".

What makes it fine int his case is that git_config_get_bool() dies
when the given value is not a Boolean ;-).  The returned value from
the function can be used to tell if the variable does not exist and
the caller should decide to stuff some default value to &untracked
but in this case you do not need to.
