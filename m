Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E183853E08
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378534; cv=none; b=coBSSIX6W7jNUl4vOBivgRiVLlOWB04AIkWHHsoVvtdM89r9RburH7AJXE9j0CVoNM2FFItYDQZXCqvqQ1NXX60k9zNM6G08X9tv2kcat36FZcRD7qc1AzamgzqwADxYUkEGO/FO3e/Q6mZGC5pAHZEfF6akUNRETQvanXrW8FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378534; c=relaxed/simple;
	bh=4YmyNipfzMiGjbfGn3aJRWUVyN2csxL51w3w3P4lWGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lw8U1yymJguuIJD5eTaRP1Exw8XY5J2zWHOxfa13ltlkeTUNEu9um135MFoisFmbM9GRho+56mvFI85Xc6qY8jMGI4CJuSX0eygfSs7t5KpXmsvQw+FHbYgkS9hyDlE5nVggVwDNMaoW79Z+dkLs7/EFPOk2K5winXbwX0q3iV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XMrm7Dz3; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XMrm7Dz3"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5D431E1C3B;
	Mon, 19 Feb 2024 16:35:31 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4YmyNipfzMiGjbfGn3aJRWUVyN2csxL51w3w3P
	4lWGI=; b=XMrm7Dz3l4i7ZU8VJZ7IPssOiR+k1vU0vQjktn7KNPKJ+myql6v/Pr
	whdwy1o0MIT8PJ2E5XS9r/3QwwVUFHBy+Bvx47koPHov6Q47HvLvR0Q12PKW8eH9
	iFmkK6d2I65Rq0cHes4WLOi0cbjJ+Xu/KIhZAnU5y/mBHEVYFWyFM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E3451E1C3A;
	Mon, 19 Feb 2024 16:35:31 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7DF5E1E1C39;
	Mon, 19 Feb 2024 16:35:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Philip Peterson <philip.c.peterson@gmail.com>
Subject: Re: [PATCH 1/2] apply: add unit tests for parse_range and rename to
 parse_fragment_range
In-Reply-To: <2c60c4406d4eb1307a32f23604f3ef8e34ad56d6.1708317938.git.gitgitgadget@gmail.com>
	(Philip Peterson via GitGitGadget's message of "Mon, 19 Feb 2024
	04:45:37 +0000")
References: <pull.1677.git.git.1708317938.gitgitgadget@gmail.com>
	<2c60c4406d4eb1307a32f23604f3ef8e34ad56d6.1708317938.git.gitgitgadget@gmail.com>
Date: Mon, 19 Feb 2024 13:35:29 -0800
Message-ID: <xmqqil2k5e8u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CE0BF30E-CF6E-11EE-83B1-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philip Peterson <philip.c.peterson@gmail.com>
>
> This patchset makes the parse_range function in apply be non-internal
> linkage in order to expose to the unit testing framework. In so doing,
> because there is another function called parse_range, I gave this one a more
> specific name, parse_fragment_range. Other than that, this commit adds
> several test cases (positive and negative) for the function.

We do not write "I did this, I did that" in our proposed log
message.  In addition, guidance on the proposed commit log in a
handful of sections in Documentation/SubmittingPatches would be
helpful.

It may probably be a good idea to split this into a preliminary
patch that makes a symbol extern (and doing nothing else), and
the main patch that adds external caller(s) to the function from
a new unit test.

It certainly is better than doing nothing and just make it extern,
but I am not sure "fragment" is specific enough to make the symbol
clearly belong to "apply" API.

> diff --git a/apply.c b/apply.c
> index 7608e3301ca..199a1150df6 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1430,8 +1430,8 @@ static int parse_num(const char *line, unsigned long *p)
>  	return ptr - line;
>  }
>  
> -static int parse_range(const char *line, int len, int offset, const char *expect,
> -		       unsigned long *p1, unsigned long *p2)
> +int parse_fragment_range(const char *line, int len, int offset, const char *expect,
> +			 unsigned long *p1, unsigned long *p2)
>  {
>  	int digits, ex;

Alternatively we could do something like this to make the blast
radius of this patch smaller.

    -static int parse_range(const char *line, int len, int offset, const char *expect,
    +#define apply_parse_fragment_range parse_range
    +int parse_range(const char *line, int len, int offset, const char *expect,
                           unsigned long *p1, unsigned long *p2)

If not for unit-test, this function has no reason to be extern with
such a long name, so it is better to allow internal callers to refer
to it with the name that has been good enough for them for the past
19 years since it was introduced in fab2c257 (git-apply: make the
diffstat output happen for "--stat" only., 2005-05-26).

> diff --git a/apply.h b/apply.h
> index 7cd38b1443c..bbc5e3caeb5 100644
> --- a/apply.h
> +++ b/apply.h
> @@ -187,3 +187,7 @@ int apply_all_patches(struct apply_state *state,
>  		      int options);
>  
>  #endif
> +
> +
> +int parse_fragment_range(const char *line, int len, int offset, const char *expect,
> +		       unsigned long *p1, unsigned long *p2);

This is wrong.  The #endif is about avoiding double inclusion of
this header file and any new declaration must go before it.

> diff --git a/t/unit-tests/t-apply.c b/t/unit-tests/t-apply.c
> new file mode 100644

This should go to the next patch.
