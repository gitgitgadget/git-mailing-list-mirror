Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB721D6BD
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705441947; cv=none; b=QGDu3j8+DU5/Bze5ZbhZkDuDp9NAhaIrIdwpSfvZZy0peHYSgFaJ5YR6obfTWhP2hcTyPxGxTp90UlU2r+4tMXLsMPiOspX+3O2Dqr3FrllNQvp+/4aY6aPYaV1Fpn4C+NYbePOrq+WBkGVvxpIpTlMPXDUvX9/rbzCUZ/s6NuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705441947; c=relaxed/simple;
	bh=Wb2xDckJz7xzFj/pTSikY53GQWfclPjEmljc1MBWEgk=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=cZgCK/LvKPlqIjxn2GyVr5B2so6l0dBCwTGFeUfzlmP27Iyr37KhtUkI8bxoxeHPzYZsASbhwN0YO0EgiiSq+1ns8DSlsg0fEImOpXnPXt2eDg/TRzt5KwgvYlDCsQ2+vcoV+caBDDiZqPf+FhdLImekE/r1UCFV5Sb3fWQcYJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SbzaEz16; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SbzaEz16"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5F34D27682;
	Tue, 16 Jan 2024 16:52:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Wb2xDckJz7xzFj/pTSikY53GQWfclPjEmljc1M
	BWEgk=; b=SbzaEz16matnMWLXENc1xk9llBvTlHkwM9s94k2SmjDEMslI37aGXr
	6uI6WyCwTYjTCs52F/oHGnjCyHY0l0Q8HjK6pz0slLSdqtzgPdW+2KRUEgt0MlgU
	QZu2fqm4Vy3TLfnzxyOOOWR0xCDAUg2dmTyQof8BUkEhrog5sKAWg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 57A802767F;
	Tue, 16 Jan 2024 16:52:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B5E312767E;
	Tue, 16 Jan 2024 16:52:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org,  ps@pks.im,  stolee@gmail.com,  Eric Sunshine
 <sunshine@sunshineco.com>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 4/4] maintenance: use XDG config if it exists
In-Reply-To: <8bd67c5bf01ca10fbf575dfa2cf88f8c88b48276.1705267839.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Sun, 14 Jan 2024 22:43:19 +0100")
References: <cover.1697660181.git.code@khaugsbakk.name>
	<cover.1705267839.git.code@khaugsbakk.name>
	<8bd67c5bf01ca10fbf575dfa2cf88f8c88b48276.1705267839.git.code@khaugsbakk.name>
Date: Tue, 16 Jan 2024 13:52:20 -0800
Message-ID: <xmqq7ck9ymi3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 86BDE752-B4B9-11EE-BE78-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> diff --git a/builtin/gc.c b/builtin/gc.c
> index c078751824c..cb80ced6cb5 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1543,19 +1543,18 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
>  
>  	if (!found) {
>  		int rc;
> -		char *user_config = NULL, *xdg_config = NULL;
> +		char *global_config_file = NULL;
>  
>  		if (!config_file) {
> -			git_global_config_paths(&user_config, &xdg_config);
> -			config_file = user_config;
> -			if (!user_config)
> -				die(_("$HOME not set"));
> +			global_config_file = git_global_config();
> +			config_file = global_config_file;
>  		}
> +		if (!config_file)
> +			die(_("$HOME not set"));
>  		rc = git_config_set_multivar_in_file_gently(
>  			config_file, "maintenance.repo", maintpath,
>  			CONFIG_REGEX_NONE, 0);

OK.  We used to ask for both user and xdg and without using xdg at
all, as long as $HOME is set, we used $HOME/.gitconfig even if it
did not exist.

What we want to happen is we pick XDG is XDG exists *and* $HOME/.gitconfig
does not.  And that is exactly what git_global_config() gives us.

Nicely done.

> @@ -1612,18 +1611,18 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
>  
>  	if (found) {
>  		int rc;
> -		char *user_config = NULL, *xdg_config = NULL;
> +		char *global_config_file = NULL;
> +
>  		if (!config_file) {
> -			git_global_config_paths(&user_config, &xdg_config);
> -			config_file = user_config;
> -			if (!user_config)
> -				die(_("$HOME not set"));
> +			global_config_file = git_global_config();
> +			config_file = global_config_file;
>  		}
> +		if (!config_file)
> +			die(_("$HOME not set"));
>  		rc = git_config_set_multivar_in_file_gently(
>  			config_file, key, NULL, maintpath,
>  			CONFIG_FLAGS_MULTI_REPLACE | CONFIG_FLAGS_FIXED_VALUE);

Ditto.
