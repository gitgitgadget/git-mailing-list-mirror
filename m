Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23073188
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710437048; cv=none; b=NlRjF+1Y5tTAqhYIJG8k6/q446ZYy/v3GVd+3uBjWHCUyniJef8fw6EWpmWKKMvU1PswSYouKMApGXqMcu9xSXiPc6+xxaynf6dAiOOaC6owlcTbzONOKrQghfqMMOUO0sbusageJ/vwY13zydbyGGyEGfhhalHst/wtXvis4Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710437048; c=relaxed/simple;
	bh=0WcruMAVYjkWX3cT1Ba7Ohfig+GadC7QAdo6nUpY9DQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZQXRjB3K9g7me+HY7P8xq5U5AAKX3fQImc+723zu9iLhfDwmtHrcYXPiYLCdjSD/OPPIoKcK3QkfLO+lr+7GjjgqKlrGHjCJhodZSV2rU867rubVB5zHIsCjFMjoyFdkA+ZaPIqlcGAcjWj6iwpCZoFENvfq1R+SyG6uee+uK/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x9kZyvKO; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x9kZyvKO"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 46C9B29C61;
	Thu, 14 Mar 2024 13:24:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0WcruMAVYjkWX3cT1Ba7Ohfig+GadC7QAdo6nU
	pY9DQ=; b=x9kZyvKOz1rkna1I2510YiiJu6lUCUKsC6MvdhwzGMR1GC7/tCX53A
	e9kEJmkykURlUbwIBgEgWFYd2lexnnW2+HAXVW0K2dq3ja27z/Zxi9IDE3JfmoGA
	cV/R2HE1R50g/qA2+DMLuCzOddmXUDZmW5xlZvV2VdVSYGSPB/KWg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F14329C60;
	Thu, 14 Mar 2024 13:24:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CBFA329C5F;
	Thu, 14 Mar 2024 13:24:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 4/5] checkout: cleanup --conflict=<style> parsing
In-Reply-To: <511e03d3db26b174fa6585310b9866a06ac2dff0.1710435907.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Thu, 14 Mar 2024 17:05:06
	+0000")
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
	<pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>
	<511e03d3db26b174fa6585310b9866a06ac2dff0.1710435907.git.gitgitgadget@gmail.com>
Date: Thu, 14 Mar 2024 10:24:01 -0700
Message-ID: <xmqqmsr0via6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A700D254-E227-11EE-89F1-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int parse_opt_conflict(const struct option *o, const char *arg, int unset)
> +{
> +	struct checkout_opts *opts = o->value;
> +
> +	if (unset) {
> +		opts->conflict_style = -1;
> +		return 0;
> +	}
> +	opts->conflict_style = parse_conflict_style_name(arg);
> +	if (opts->conflict_style < 0)
> +		return error(_("unknown conflict style '%s'"), arg);
> +
> +	return 0;
> +}
> +
>  static struct option *add_common_options(struct checkout_opts *opts,
>  					 struct option *prevopts)
>  {
> @@ -1628,8 +1649,9 @@ static struct option *add_common_options(struct checkout_opts *opts,
>  			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
>  		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
>  		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
> -		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
> -			   N_("conflict style (merge, diff3, or zdiff3)")),
> +		OPT_CALLBACK(0, "conflict", opts, N_("style"),
> +			     N_("conflict style (merge, diff3, or zdiff3)"),
> +			     parse_opt_conflict),
>  		OPT_END()
>  	};
>  	struct option *newopts = parse_options_concat(prevopts, options);

Looking good.
