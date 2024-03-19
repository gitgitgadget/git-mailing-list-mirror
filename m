Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D83368
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710809902; cv=none; b=HBtHCNatyvJ8Y3vuOt8Kln7Jucq7SOa2iola/9DUhI/wJY21zHuCjYOzUTiiBMoh99Mvf0MGiKeLXXwUZlwdmCYn94ZRq5mc8jhJbuUna0QgWLvym3ZEAVfUZpITpomwp7aS+9ZD2cJ//0k6guKTQsM5eGuxnt69rMbqO+v9J/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710809902; c=relaxed/simple;
	bh=G1f+DN0/6JKDqmfZtZ5YB5rK1kqg7lFnFsKAwPlje0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JrnQPyo6a/bHXzLAjspQzQ5oEm7pGqmVdI5lIsMWennJng+ut8OPXfYiaU+4GQdP4YC6JpCl9cZRLs1uRc3ECbRHfwE6eBe3SOSSCwpIRY/niyuRDYOcHcxFyMc68fXFD0T0Fl4gjqWppvM6HslptFoWm7wUZR4mXIb3055jLTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BwH+60VP; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BwH+60VP"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2EE4F3219F;
	Mon, 18 Mar 2024 20:58:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=G1f+DN0/6JKDqmfZtZ5YB5rK1kqg7lFnFsKAwP
	lje0A=; b=BwH+60VPhWloFjwKfBMoAorUTAsFgnVbPGQ3um//TPVxK3I29fP3bx
	PkkxlvQBUBkKz0yOLCPceEq5Hj5CJpAQf0z19lmlB2ly8Wjd1QyyzRKx8fdooYfi
	sNuolvAHlkJoSf7cThNTp5FwLPcrwpgDHYgruNDtfVyELi7kfofTo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 274FB3219C;
	Mon, 18 Mar 2024 20:58:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BDD733219B;
	Mon, 18 Mar 2024 20:58:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] grep: introduce new config option to include
 untracked files
In-Reply-To: <9f70eeb4f04a874a2036e1d8c61f3b7ec130663a.1710781235.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Mon, 18 Mar 2024 18:03:24 +0100")
References: <cover.1710781235.git.dsimic@manjaro.org>
	<9f70eeb4f04a874a2036e1d8c61f3b7ec130663a.1710781235.git.dsimic@manjaro.org>
Date: Mon, 18 Mar 2024 17:58:15 -0700
Message-ID: <xmqqr0g7rqag.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C5454256-E58B-11EE-B4F8-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Add new configuration option grep.includeUntracked that enables --untracked
> option by default.  This pretty much follows the logic established by the
> already existing configuration option grep.fallbackToNoIndex, while also
> respecting the dependencies of the --untracked option.
>
> Also add a few automated tests to the t7810, to cover the new configuration

Do we have any non-automated tests in t7810?

> option by replicating the already existing tests for --untracked.
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  builtin/grep.c  | 3 +++
>  t/t7810-grep.sh | 9 +++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index af89c8b5cb19..71d94126fb6e 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1041,6 +1041,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		the_repository->settings.command_requires_full_index = 0;
>  	}
>  
> +	if (use_index && !cached)
> +		git_config_get_bool("grep.includeuntracked", &untracked);

Can this ever return an error?  E.g.

	[grep] includeuntracked = "not really"

How badly would setting this configuration variable break third
party tools that assume their "git grep" invocation without the
"--untracked" option would not yield hits from untracked files?
