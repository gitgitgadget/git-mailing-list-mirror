Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E613E40D576
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272857; cv=none; b=osocm7KzFYJxRyCjuVtrt9Huq+4IXqja3oPn27r/swLuNlZMhz/URlR14B/qIUu1hNTRwO/lCjqImkDifHd7l31GBHIFmd1czhz3Zbr/1Ge90k+wynjVxzwCsUHWMghdJ6kpwx7FUKUwQY7wzqxLq94onLqZoSEp/eqDTxRWTVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272857; c=relaxed/simple;
	bh=EDkU8U2urNhFYfzwpuSwAs/OfTM9AQqG7kdkGOuS+2M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:To:From:
	 References:In-Reply-To; b=aL2+8Vl22NQphB1Nn0ZbGjCw3xbL7nVhRCgBk4XBf+B0ryZEUkprJfS7WkZgLrWI3pozuhV/Y+COBuQsX86ueQWvCNAlOFY0XevpvuEfuR2Q2nCPK1DqxRJZX4Z1KJR5sbjZiVwlx3pEwSvGaAUAtWde8Uxfyra25/nR7GSwxkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=HuwtTSTU; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="HuwtTSTU"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id B9E916016E
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781272854; bh=EDkU8U2urNhFYfzwpuSwAs/OfTM9AQqG7kdkGOuS+2M=;
	h=Date:Subject:To:From:References:In-Reply-To:From;
	b=HuwtTSTUU0NWhkgqBzV/rSrkC+17MfTc4FJbn+HlMZqP4t3+udjeIigAr0ZAsGXSZ
	 YCdhqB11iWMWZ0pgtSe0KVVozbql869chu5V44wfveg9D9J3qfXZplTitJyqkoCe+b
	 O9PNRuJYFok1Ie/XV0S8reVbzcO0f7YnqYfWGJq8=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 10:00:54 -0400
Message-Id: <DJ74J0G5PUXF.3DVTRHXS0GEG1@lfurio.us>
Subject: Re: [PATCH 6/7] fetch: add configuration option
 fetch.followRemoteHEAD
To: <git@vger.kernel.org>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <DJ19CI50W6UH.17QLIBNTXBWXU@lfurio.us>
 <20260612055947.1499497-1-m@lfurio.us>
 <20260612055947.1499497-7-m@lfurio.us>
In-Reply-To: <20260612055947.1499497-7-m@lfurio.us>

On Fri Jun 12, 2026 at 1:55 AM EDT, Matt Hunter wrote:
> diff --git a/Documentation/config/remote.adoc b/Documentation/config/remo=
te.adoc
> index eb9c8a3c4884..761bf4ba7d14 100644
> --- a/Documentation/config/remote.adoc
> +++ b/Documentation/config/remote.adoc
> @@ -157,15 +157,12 @@ Blank values signal to ignore all previous values, =
allowing a reset of
>  the list from broader config scenarios.
> =20
>  remote.<name>.followRemoteHEAD::
> -	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`
> -	when fetching using the configured refspecs of a remote.
> -	The default value is "create", which will create `remotes/<name>/HEAD`
> -	if it exists on the remote, but not locally; this will not touch an
> -	already existing local reference. Setting it to "warn" will print
> -	a message if the remote has a different value than the local one;
> -	in case there is no local reference, it behaves like "create".
> -	A variant on "warn" is "warn-if-not-$branch", which behaves like
> -	"warn", but if `HEAD` on the remote is `$branch` it will be silent.
> -	Setting it to "always" will silently update `remotes/<name>/HEAD` to
> -	the value on the remote.  Finally, setting it to "never" will never
> -	change or create the local reference.
> +	When fetching this remote using its default refspec, this option determ=
ines
> +	how to handle differences between the remote's `HEAD` and the local
> +	`remotes/<name>/HEAD` symbolic-ref.  Overrides the setting for
> +	`fetch.followRemoteHEAD`.  See `fetch.followRemoteHEAD` for a descripti=
on of
> +	accepted values.
> ++
> +In addition to the values supported by `fetch.followRemoteHEAD`, this op=
tion may
> +also take on the value "warn-if-not-`$branch`", which behaves like "warn=
", but
> +ignores the warning if the remote's `HEAD` is `remotes/<name>/$branch`.

In hindsight, I'm wondering if $branch ought to be stylized as <branch>
to match the rest of the docs.  Thoughts?
