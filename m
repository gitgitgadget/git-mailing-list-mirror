Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91271EA6F
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726870065; cv=none; b=n/NvxSnyg2satjdVaJr/ZAjI1zIsRhWV04DENFnlCGOJBKZncNAbV1I951brbdMwRRWVPYQ3WfEWZrFAc2thbWyDPLles5LcCFFQyIi5QA1rxpzIAU7zVkZN+nVT6ebH81NgJ9kBfdZfX54LaGCjIVczeb0OulC9YG38iDlW1+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726870065; c=relaxed/simple;
	bh=VoJNcxK9uxnorEWoU199BIJWtU1zzTbFUwbWiW+ZSKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sDnwKkFm7IW3ChxQY8KPHo8gDU260LBnH5seGiO7xikJiTxvMGdHbnzjvkC1m8WZ3FZzCk2o//3YdoS8ZjfNkf+/0hQdoH9KIdQyGU38Vp9NM9g5/ZGUol/+tuUQKFDiG6wf5JOSbOGYGJb8cwfNltj/+QzuawRk4jKK2PtjxxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NYqlzYsB; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NYqlzYsB"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AE00A20263;
	Fri, 20 Sep 2024 18:07:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VoJNcxK9uxnorEWoU199BIJWtU1zzTbFUwbWiW
	+ZSKo=; b=NYqlzYsBrOl4w49YgIzSWpJZP/uphUtmSbnpcBzZv0+dzvFx/DL4zu
	0wAAxtyLkFlplkDEiF1q5bwaSxjcBtXk66GNNp6a00k7thetu8qpBVO+r1a7QHIV
	rILmEYRLuxSM1zvC8IyqoOax0ovpT5MbtD1ieDdoZPppk0G+t34uQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A5C4820262;
	Fri, 20 Sep 2024 18:07:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 159D920261;
	Fri, 20 Sep 2024 18:07:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  liuzhongbo.gg@gmail.com,
  Johannes.Schindelin@gmx.de,  Derrick Stolee <stolee@gmail.com>,  Derrick
 Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/3] credential: add new interactive config option
In-Reply-To: <1e9bf2d09c17bc0cdcd0a8f8dbacab007e5c53e7.1726790424.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Fri, 20 Sep 2024
	00:00:21 +0000")
References: <pull.1798.git.1726790423.gitgitgadget@gmail.com>
	<1e9bf2d09c17bc0cdcd0a8f8dbacab007e5c53e7.1726790424.git.gitgitgadget@gmail.com>
Date: Fri, 20 Sep 2024 15:07:40 -0700
Message-ID: <xmqq7cb6dln7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C1C1A13A-779C-11EF-9604-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -501,8 +525,8 @@ void credential_fill(struct credential *c, int all_capabilities)
>  			    c->helpers.items[i].string);
>  	}
>  
> -	credential_getpass(c);
> -	if (!c->username && !c->password && !c->credential)
> +	if (credential_getpass(c) ||
> +	    (!c->username && !c->password && !c->credential))
>  		die("unable to get password from user");
>  }

This is a fallback mode after credential helpers have failed to fill
and return.  Unless these helpers pay attention to the "interactive"
configuration, they may still get stuck.  So it would be #leftoverbits
to update each credential helpers to do the right thing.

The sample credential-store backend does not have to be updated I
guess ;-)

> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 7b5ab0eae16..ceb3336a5c4 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -186,6 +186,28 @@ test_expect_success 'clone from password-protected repository' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'credential.interactive=false skips askpass' '
> +	set_askpass bogus nonsense &&
> +	(
> +		GIT_TRACE2_EVENT="$(pwd)/interactive-true" &&
> +		export GIT_TRACE2_EVENT &&
> +		test_must_fail git clone --bare "$HTTPD_URL/auth/smart/repo.git" interactive-true-dir &&
> +		test_region credential interactive interactive-true &&
> +
> +		GIT_TRACE2_EVENT="$(pwd)/interactive-false" &&
> +		export GIT_TRACE2_EVENT &&
> +		test_must_fail git -c credential.interactive=false \
> +			clone --bare "$HTTPD_URL/auth/smart/repo.git" interactive-false-dir &&
> +		test_region ! credential interactive interactive-false &&
> +
> +		GIT_TRACE2_EVENT="$(pwd)/interactive-never" &&
> +		export GIT_TRACE2_EVENT &&
> +		test_must_fail git -c credential.interactive=never \
> +			clone --bare "$HTTPD_URL/auth/smart/repo.git" interactive-never-dir &&
> +		test_region ! credential interactive interactive-never
> +	)
> +'
> +
>  test_expect_success 'clone from auth-only-for-push repository' '
>  	echo two >expect &&
>  	set_askpass wrong &&
