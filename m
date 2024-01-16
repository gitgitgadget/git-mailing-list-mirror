Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E377560255
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 21:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705441186; cv=none; b=m8Nv7lltR5lwLqYJ0/tTEMgnrlJdHGfaO5zdvgGVprh5bgNNKRVyZRJCWq6j3fD+MPeS5763mu1UGw9Zu0hRn/vFADbFHK3wo7pENLlxjGhQGUTU1pGDxMkbzvDz3mEVFDfYVOT2fPygZ+CAYvkCdWT5LyYBq3J0GIrxeFauOds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705441186; c=relaxed/simple;
	bh=oHj/xrG7CcZmSkP+dHVPJOsAa4fg/+KA6VKBAw6H2VE=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=N6a2rlNTew+RZvg1bWlgrxSd9VkPP824G0zNRGWsbDLQ3XUfahR9HxV6t3hxK+aWaNIhotIZwoKTn7YMeNZmz5ha1xVLTlmuaCFctJY3mAzxD8vXpXOS3bX81P1bX7x7GNJ+fn2CgC73jkl1YFa78ag/0FtwwDGrYN3udPdHxHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=b8V+gf0e; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b8V+gf0e"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 836A51E7AB0;
	Tue, 16 Jan 2024 16:39:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oHj/xrG7CcZmSkP+dHVPJOsAa4fg/+KA6VKBAw
	6H2VE=; b=b8V+gf0ed6bqUeUATiOwXrWLX3RrzNSbBih562S9o4nCYT1K7SeqEd
	KVtxjPphmeCt/JcyQPCO+h/TfceW0Ewnsait2Iq8NaEt/zgtcOT1UwIuh/T1ufhR
	N8frDTpO2crNKMWB1fyderbB8IgcRDcqO5LfKIbuBgZ5/pIjx+qps=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A23F1E7AAF;
	Tue, 16 Jan 2024 16:39:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD2781E7AAE;
	Tue, 16 Jan 2024 16:39:42 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org,  ps@pks.im,  stolee@gmail.com,  Eric Sunshine
 <sunshine@sunshineco.com>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 3/4] config: factor out global config file retrieval
In-Reply-To: <32e5ec7d866ff8fd26554b325812c6e19cb65126.1705267839.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Sun, 14 Jan 2024 22:43:18 +0100")
References: <cover.1697660181.git.code@khaugsbakk.name>
	<cover.1705267839.git.code@khaugsbakk.name>
	<32e5ec7d866ff8fd26554b325812c6e19cb65126.1705267839.git.code@khaugsbakk.name>
Date: Tue, 16 Jan 2024 13:39:41 -0800
Message-ID: <xmqqcyu1yn36.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C27030B8-B4B7-11EE-BDAB-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

>  	if (use_global_config) {
> -		char *user_config, *xdg_config;
> ...
> -	else if (use_system_config) {
> +	} else if (use_system_config) {
>  		given_config_source.file = git_system_config();
>  		given_config_source.scope = CONFIG_SCOPE_SYSTEM;
>  	} else if (use_local_config) {
> diff --git a/config.c b/config.c
> index ebc6a57e1c3..3cfeb3d8bd9 100644
> --- a/config.c
> +++ b/config.c
> @@ -1987,6 +1987,26 @@ char *git_system_config(void)
>  	return system_config;
>  }
>  
> +char *git_global_config(void)
> +{
> +...
> +}
> +
>  void git_global_config_paths(char **user_out, char **xdg_out)
>  {
>  	char *user_config = xstrdup_or_null(getenv("GIT_CONFIG_GLOBAL"));

The conversion above

> diff --git a/config.h b/config.h
> index e5e523553cc..625e932b993 100644
> --- a/config.h
> +++ b/config.h
> @@ -382,6 +382,10 @@ int config_error_nonbool(const char *);
>  #endif
>  
>  char *git_system_config(void);
> +/**
> + * Returns `NULL` if is uncertain whether or not `HOME/.gitconfig` exists.
> + */

Sorry, but I am not sure what this comment wants to say.

When $HOME is not set, we do get NULL out of this function.  But
interpolate_path() that makes git_global_config_paths() to return
NULL in user_config does not do any existence check with stat() or
access(), so even when we return a string that is "~/.gitconfig"
expanded to '/home/user/.gitconfig", we are not certain if the file
exists.  So,... it is unclear what "uncertain"ty we are talking
about in this case.

> +char *git_global_config(void);
