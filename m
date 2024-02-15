Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29151369A4
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017754; cv=none; b=IsU07LgHQVXUvKyfiIFcqZJzdHhXkXirUPRmKCTHUs5L/fDQzDHO30ozEh8X01s8Zpy2Pnc75B4Jx/s9amcL2tb0VlBBDjcdTzTkbcFMKO113MzBHNXLlVnOGnqGN4dFw7jf69wk5G4g6F3DdMslV92yXCtm6gZ8pkClvsSlgEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017754; c=relaxed/simple;
	bh=GNp+BIYrzvxz5zH3JpW4iv9rbYj9C1eOmvyX1Gh/agI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RU6PdZQd6L/hSVeryxgn2LuEhqRnGZp/Z2ku4MgEJfBUlJ5HUyFJ46yukHAR+mmaVuvvPTOM9PdqfnsxdGEZO2vpq1Oh7czPxSvpWvHtkx5KoVZYC8D3/ia8UkKUeWmO57skDkwMtoS/eQ3xHlhKqpXkJpUJah0CbrAjFhLhKC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=u+1CEEnX; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u+1CEEnX"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C175283DE;
	Thu, 15 Feb 2024 12:22:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GNp+BIYrzvxz5zH3JpW4iv9rbYj9C1eOmvyX1G
	h/agI=; b=u+1CEEnX4vx7EJ6mkxUS9HxJHs9KZXFa//6DYD0f74rwxaF9T1pnRd
	lrBKmUtro4yJTMhfL2aIZCWON+ZNXItlIpBQ6aX3rAcCmJtyNkH93euINUR7C6HJ
	ak3ozStVznTdDUIYYokSJCB64UO2bPZso/gZZVkoW5dNNcfQL9/Z0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 14BFF283DC;
	Thu, 15 Feb 2024 12:22:32 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B93A6283DB;
	Thu, 15 Feb 2024 12:22:28 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Bo Anderson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Bo Anderson <mail@boanderson.me>
Subject: Re: [PATCH] t/lib-credential: clean additional credential
In-Reply-To: <20240215043900.GA2821179@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 14 Feb 2024 23:39:00 -0500")
References: <pull.1664.git.1707959036807.gitgitgadget@gmail.com>
	<20240215043900.GA2821179@coredump.intra.peff.net>
Date: Thu, 15 Feb 2024 09:22:27 -0800
Message-ID: <xmqqle7lskvg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CB5CC99E-CC26-11EE-BE68-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> On Thu, Feb 15, 2024 at 01:03:56AM +0000, Bo Anderson via GitGitGadget wrote:
>
>> From: Bo Anderson <mail@boanderson.me>
>> 
>> 71201ab0e5 (t/lib-credential.sh: ensure credential helpers handle long
>> headers, 2023-05-01) added a test which stores credentials with the host
>> victim.example.com but this was never cleaned up, leaving residual data
>> in the credential store after running the tests.
>> 
>> Add a cleanup call for this credential to resolve this issue.
>
> Good catch. The patch looks obviously correct.
>
> I'm not surprised nobody noticed until now, as I expect it is pretty
> rare for people to run t0303 against system helpers (it is not a problem
> for t0301, etc, because they only touch the internal trash directory).
>
> I wonder if we might want something like this, as well, which can catch
> leftovers:

Sounds like a good hygiene ;-).

>
> diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
> index 716bf1af9f..4183154243 100755
> --- a/t/t0302-credential-store.sh
> +++ b/t/t0302-credential-store.sh
> @@ -6,6 +6,11 @@ test_description='credential-store tests'
>  
>  helper_test store
>  
> +helper_test_clean store
> +test_expect_success 'test cleanup removes everything' '
> +	test_must_be_empty "$HOME/.git-credentials"
> +'
> +
>  test_expect_success 'when xdg file does not exist, xdg file not created' '
>  	test_path_is_missing "$HOME/.config/git/credentials" &&
>  	test -s "$HOME/.git-credentials"
>
> -Peff
