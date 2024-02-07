Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9F127B5F
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339346; cv=none; b=dNhWxpTdHdn7Qb/ZQX2hD6nsArmU1R0veHGCS/HmHjLCPrjC2U1jG5FdY+zLxkvzKgzi85Qen87OIKPw/wQD6yjvk+xScLj+T/UTGiVXeVQXyPGgYR2+Rtnl7q2ek1XNY/0BHWYBaTmK1CA95M3qkHdL2UlqajZk8XJ+5CzM6jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339346; c=relaxed/simple;
	bh=WGXw1btXwW5KRC+OU3II2UtViDqgnxK7WgbuirbkNUo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lMWt3eOARgENFptdZx0eKj6GOyIUHli4VAT5DhixYyt/KXgrY+28i/f9TtEcIf4GFvvzbSghgf7Oc/MQA5latYGYUydzMN6aXaxn1mJ0HV1inDm7QDy1W0PyjrBvjL63VubriwAagwSNwL9FGrM9qWQStSK42Gc5bL1XcmF0Xz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LugqsIHM; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LugqsIHM"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 910F82EC5C;
	Wed,  7 Feb 2024 15:55:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WGXw1btXwW5KRC+OU3II2UtViDqgnxK7Wgbuir
	bkNUo=; b=LugqsIHMEbq5PIwsPF6C2MZU0UDeECWtGbY8PY0SXRl0ZLLwiyYxmg
	+gNCJrHAapSlLlwq7WeSxBcB6GAB7fQJNsQid/RPRIkLFhuu5fZ/txhy+YcNgfLo
	9TbqdQSP3nFJar9t2VWRjlGP5YpxL2GzR8VOO62rPEmRlb6oxPoq8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 885512EC5B;
	Wed,  7 Feb 2024 15:55:44 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3D37E2EC5A;
	Wed,  7 Feb 2024 15:55:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 3/6] test-tool run-command testsuite: remove
 hardcoded filter
In-Reply-To: <e1b89ae93e930cd902d1527955d588c3d0c15490.1706921262.git.steadmon@google.com>
	(Josh Steadmon's message of "Fri, 2 Feb 2024 16:50:28 -0800")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1706921262.git.steadmon@google.com>
	<e1b89ae93e930cd902d1527955d588c3d0c15490.1706921262.git.steadmon@google.com>
Date: Wed, 07 Feb 2024 12:55:39 -0800
Message-ID: <xmqqeddo6lkk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 40FA4762-C5FB-11EE-8A7D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> `test-tool run-command testsuite` currently assumes that it will only be
> running the shell test suite, and therefore filters out anything that
> does not match a hardcoded pattern of "t[0-9][0-9][0-9][0-9]-*.sh".
>
> Later in this series, we'll adapt `test-tool run-command testsuite` to
> also support unit tests, which do not follow the same naming conventions
> as the shell tests, so this hardcoded pattern is inconvenient.

Makes sense to explain what future steps this prepares the codebase
for like this.

> Since `testsuite` also allows specifying patterns on the command-line,
> let's just remove this pattern. As noted in [1], there are no longer any
> uses of `testsuite` in our codebase, it should be OK to break backwards
> compatibility in this case. We also add a new filter to avoid trying to
> execute "." and "..", so that users who wish to execute every test in a
> directory can do so without specifying a pattern.

As we discussed in Peff's Makefile change that enumerates "which are
the unit-test programs?" Generally, $(wildcard) and readdir() to
slurp everything in a directory, including stuff that is an
untracked cruft, is not an excellent idea.

This is not an end-user facing program and we are in full control of
its input (most notably, "which ones should we be running?"), I do
not think it would be a huge issue, though.

> [1] https://lore.kernel.org/git/850ea42c-f103-68d5-896b-9120e2628686@gmx.de/
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  t/helper/test-run-command.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index a41a54d9cb..e6bd792274 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -175,9 +175,7 @@ static int testsuite(int argc, const char **argv)
>  	while ((d = readdir(dir))) {
>  		const char *p = d->d_name;
>  
> -		if (*p != 't' || !isdigit(p[1]) || !isdigit(p[2]) ||
> -		    !isdigit(p[3]) || !isdigit(p[4]) || p[5] != '-' ||
> -		    !ends_with(p, ".sh"))
> +		if (!strcmp(p, ".") || !strcmp(p, ".."))
>  			continue;
>  
>  		/* No pattern: match all */
