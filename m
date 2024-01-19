Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EAB374E0
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705696673; cv=none; b=C6TlsyYAqPSyecD1aSpoyC+bvXOWSlWgnhJa10N9noP1gmaB3ijTw0LfmAUKgymoNf8u3M46WeIXceiytlPiTquSAHFCIBJtO+oPkNp2i2BG++aiRkMi/di9UHBSY8vQDoR3+BZG2Kjq3zL00RJ93tJSLCTF0IPxAH9H6FuR3fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705696673; c=relaxed/simple;
	bh=Bm1veuYvMFuL5ExTdn0fS1jvToH9/2H7r9Tjo1tm1iE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HHnzfycxY7yMX0vgW+Vd3gfqzqVq0SAjy6aXbCRTx21CkLeAY/8yfkXj7Vh50Fv0oRdhYkF5kcAUebcPnze+xSmEblviO8VkTQ2sA7Zdo0V20wnmT/44PFu+Opo+gZ6zhU4lgk/gKvfu4Wf4U7h/1LfXjjkkxPvd2riHi9MBPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=v4JyAPhv; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v4JyAPhv"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AAFA9209BD;
	Fri, 19 Jan 2024 15:37:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Bm1veuYvMFuL5ExTdn0fS1jvToH9/2H7r9Tjo1
	tm1iE=; b=v4JyAPhvm1MVOmDL9aMnIeWeiIVlO477d8iroKXVmcHzvs6sE2tj2o
	feljwz2eNOSHGoYDPeRAwZXg5gtiHi28m+Gn7Em21EajiSCqtqTjKQq7f/dd0aSX
	ljLZ61LoVExUHepZvxD7LcNw25ViArhnppHDcCW/d6cAVyZ8MMx/c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A3028209BC;
	Fri, 19 Jan 2024 15:37:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3113B209BA;
	Fri, 19 Jan 2024 15:37:48 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] refs: expose `is_pseudoref_syntax()`
In-Reply-To: <20240119142705.139374-2-karthik.188@gmail.com> (Karthik Nayak's
	message of "Fri, 19 Jan 2024 15:27:01 +0100")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240119142705.139374-2-karthik.188@gmail.com>
Date: Fri, 19 Jan 2024 12:37:46 -0800
Message-ID: <xmqq34utjbz9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9B8A7ADA-B70A-11EE-9248-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> The `is_pseudoref_syntax()` function is static, since it is only used
> within `refs.c`. In the following commit, we will use this function to
> provide an utility to add pseudorefs to the loose refs cache. So let's
> expose this function via `refs.h`.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs.c | 2 +-
>  refs.h | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 2f58a3460a..5999605230 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -827,7 +827,7 @@ int is_per_worktree_ref(const char *refname)
>  	       starts_with(refname, "refs/rewritten/");
>  }
>  
> -static int is_pseudoref_syntax(const char *refname)
> +int is_pseudoref_syntax(const char *refname)
>  {
>  	const char *c;
>  
> diff --git a/refs.h b/refs.h
> index ff113bb12a..f1bbad83fb 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -846,6 +846,12 @@ const char **hidden_refs_to_excludes(const struct strvec *hide_refs);
>  /* Is this a per-worktree ref living in the refs/ namespace? */
>  int is_per_worktree_ref(const char *refname);
>  
> +/*
> + * Check whether a refname matches the pseudoref syntax. This is a surface
> + * level check and can present false positives.
> + */

What does "false positive" mean in this context?

is_pseudoref_syntax("FOO_HEAD") says "true", and then if it is
"false positive", that would mean "FOO_HEAD" is not a pseudo ref,
right?  What can a caller of this function do to deal with a false
positive?

Or do you mean "FOO_HEAD" is still a pseudo ref, but it may not
currently exist?  That is different from "false positive".

As the check is about "does it match the pseudoref syntax?", I would
understand if what you wanted to say was something like: This only
checks the syntax, and such a pseudoref may not currently exist in
the repository---for that you'd need to call read_ref_full() or
other ref API functions.

Puzzled...

Thanks.
