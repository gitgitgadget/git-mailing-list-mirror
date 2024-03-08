Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0077F17745
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914524; cv=none; b=VSmAIn0tuJhlkjcTiZ1R6P4MqJxzedQ3mcjokbPH9/fe7b/e4F8yR3g3su8QfZEMLZEs+nIHlWl5sRcdUz1711yZ93upIGoAOdOpLcs+xJ6kTLysE3oVbI6a1dfqxMP4aQE61Y+ETrHMsm5SrRBYmjesvcHZE0nKzDqBI5EbSJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914524; c=relaxed/simple;
	bh=M42i678o3pwp2Sj5jyZjV0pPJ93DqU3IQGy4zrL2+ic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TxBhnsDTJJmW8voku+uv/MVK7B1cZh+h8bfBRovgiqgHYigvCsZdIHc8uSJIv6K8wrg6cj9/+JgsYInj39gbTZLMtbZZcnh7CQszdZiM92JhtcCqHT/8wp+Nk/X+pRbHVApCF6XYA5EMCRfrPKlegN646eFiRrA2unfpB1OXN0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dAf3EruD; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dAf3EruD"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 52492305D0;
	Fri,  8 Mar 2024 11:15:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=M42i678o3pwp2Sj5jyZjV0pPJ93DqU3IQGy4zr
	L2+ic=; b=dAf3EruDxVFdsBfZL6Zl7jqDZEjh0N4oBJq0QHeP0tzfS4pLFzvyTb
	F2dRt1/nftE7Df5s3hDOjhYC/5T95vNdKjqWCsSPxm9dJg92FlV6BLvTpz219wpq
	kKQ32x8db61ETZggglnYUF6kbebD/408KdMG/4G/K1IeOGGPSGrDA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4AD58305CE;
	Fri,  8 Mar 2024 11:15:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A5C9C305CD;
	Fri,  8 Mar 2024 11:15:16 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 4/4] checkout: cleanup --conflict=<style> parsing
In-Reply-To: <317bb7a70d023278087f4370b843d7f28f9ee2f6.1709907271.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Fri, 08 Mar 2024 14:14:30
	+0000")
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
	<317bb7a70d023278087f4370b843d7f28f9ee2f6.1709907271.git.gitgitgadget@gmail.com>
Date: Fri, 08 Mar 2024 08:15:14 -0800
Message-ID: <xmqq1q8khf8t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0D24CF7E-DD67-11EE-8798-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -91,7 +91,8 @@ struct checkout_opts {
>  	int new_branch_log;
>  	enum branch_track track;
>  	struct diff_options diff_options;
> -	char *conflict_style;
> +	char *conflict_style_name;
> +	int conflict_style;

Does the conflict_style_name need to be a member of this struct?

> @@ -1628,7 +1635,7 @@ static struct option *add_common_options(struct checkout_opts *opts,
>  			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
>  		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
>  		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
> -		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
> +		OPT_STRING(0, "conflict", &opts->conflict_style_name, N_("style"),
>  			   N_("conflict style (merge, diff3, or zdiff3)")),
>  		OPT_END()
>  	};

Ah, the options[] definition is not in the same scope as where the
parse_options() is called, and that is the reason why we need to
carry the extra member that we do not need after we are done with
parsing (we use "int conflict_style") in the struct.  Otherwise we
would have just received OPT_STRING() into a local variable, called
parse_options(), and post-processed the string into
opts->conflict_style.

Yucky.  I do not care much about wasted 8 bytes in the structure,
but I find it disturbing that those functions called later with this
struct has to know that conflict_style_name is a useless member and
they are supposed to use conflict_style exclusively.

We could use OPT_CALLBACK() to accept the incoming string, parse it
and store it in opts->conflict_style and that would be a way to
avoid the extra member.

> +		opts->conflict_style =
> +			parse_conflict_style(opts->conflict_style_name);

When I saw the change to xdiff-interface in an earlier step, I
thought parse_conflict_style() was a potentially confusing name.
You can imagine a function that is fed a file with conflict markers
and say "ah, this uses diff3 style with common ancestor version" vs
"this uses merge style with only two sides" to have such a name.

parse_conflict_style_name() that takes a name and returns
conflict_style enumeration constant would not risk such a confusion,
I guess.

Thanks.
