Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C81E14900D
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058546; cv=none; b=FOLwzKHN3/2mowSLbmfVF2RIJYi+ym1Nq7s2W9jWQ8DCC+mcWl7angsBSc0X8WTOk83eXmt1mj5XQWWSqYZOR5NvR1sfWDdmN17Neph7rCDamUxmjQn3rAFC4eYSiZRONoc9FMCiqyb1ppt7hkpEbL/BMa4MfeEbpC0NXRxqj8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058546; c=relaxed/simple;
	bh=QELNucRWcsHayCYW8kIdeDhusUC3J2YdlCUmQfhBKeI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JkZVr6a3n3cqvyspTTBmo9jxvEzV0HnNooo2WnCco62kNZSD0fchP+Ne6Tx4j6X3/gKnCTYAULlVyU7UYHB2bYsIK6QQvLMfvT6dX5hM5UR3i9HkyqleylNt/P914ve41j1CXUtyb00qsCEA6qadckrCPrhpck8bkO9zzDNP3yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pwCjKLE+; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pwCjKLE+"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 50CEA1D1920;
	Tue, 27 Feb 2024 13:29:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QELNucRWcsHayCYW8kIdeDhusUC3J2YdlCUmQf
	hBKeI=; b=pwCjKLE+c007G0Vq+H2mY7F4ei+A+sjk39pktUWwArR8xTyEBo5EL8
	5cxCSXvbVvuxoxjSIs9cmQ6aD/2EhlUSD20V2WSB7ylrqut7/R9XBk7u9YH0cBNP
	uZir0VjGdv4F51RfFwdS4fkREu2MSwsroqT+8GX06gQx4uhebQYUE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F16DE1D191F;
	Tue, 27 Feb 2024 13:29:02 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F5471D191E;
	Tue, 27 Feb 2024 13:29:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 06/11] merge_bases_many(): pass on errors from
 `paint_down_to_common()`
In-Reply-To: <2ae6a54dd596c3192b5be32f0e4e2605f4aac6bd.1709040499.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Tue, 27 Feb 2024
	13:28:12 +0000")
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
	<pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
	<2ae6a54dd596c3192b5be32f0e4e2605f4aac6bd.1709040499.git.gitgitgadget@gmail.com>
Date: Tue, 27 Feb 2024 10:29:01 -0800
Message-ID: <xmqqr0gxsqvm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 14ABDDB2-D59E-11EE-8D91-25B3960A682E-77302942!pb-smtp2.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `paint_down_to_common()` function was just taught to indicate
> parsing errors, and now the `merge_bases_many()` function is aware of
> that, too.
>
> One tricky aspect is that `merge_bases_many()` parses commits of its
> own, but wants to gracefully handle the scenario where NULL is passed as
> a merge head, returning the empty list of merge bases. The way this was
> handled involved calling `repo_parse_commit(NULL)` and relying on it to
> return an error. This has to be done differently now so that we can
> handle missing commits correctly by producing a fatal error.
>
> Next step: adjust the caller of `merge_bases_many()`:
> `get_merge_bases_many_0()`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  commit-reach.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)

This is the true gem of the series.  The next steps may have to be
noisy due to many callers adjusting to the new function signatures,
but split into these logical steps in a bottom-up way makes them
easier to follow.  Nice.

>
> diff --git a/commit-reach.c b/commit-reach.c
> index 9148a7dcbc0..2c74583c8e0 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -131,41 +131,49 @@ static int paint_down_to_common(struct repository *r,
>  	return 0;
>  }
>  
> -static struct commit_list *merge_bases_many(struct repository *r,
> -					    struct commit *one, int n,
> -					    struct commit **twos)
> +static int merge_bases_many(struct repository *r,
> +			    struct commit *one, int n,
> +			    struct commit **twos,
> +			    struct commit_list **result)
>  {
>  	struct commit_list *list = NULL;
> -	struct commit_list *result = NULL;
>  	int i;
>  
>  	for (i = 0; i < n; i++) {
> -		if (one == twos[i])
> +		if (one == twos[i]) {
>  			/*
>  			 * We do not mark this even with RESULT so we do not
>  			 * have to clean it up.
>  			 */
> -			return commit_list_insert(one, &result);
> +			*result = commit_list_insert(one, result);
> +			return 0;
> +		}
>  	}
>  
> +	if (!one)
> +		return 0;
>  	if (repo_parse_commit(r, one))
> -		return NULL;
> +		return error(_("could not parse commit %s"),
> +			     oid_to_hex(&one->object.oid));
>  	for (i = 0; i < n; i++) {
> +		if (!twos[i])
> +			return 0;
>  		if (repo_parse_commit(r, twos[i]))
> -			return NULL;
> +			return error(_("could not parse commit %s"),
> +				     oid_to_hex(&twos[i]->object.oid));
>  	}
>  
>  	if (paint_down_to_common(r, one, n, twos, 0, 0, &list) < 0) {
>  		free_commit_list(list);
> -		return NULL;
> +		return -1;
>  	}
>  
>  	while (list) {
>  		struct commit *commit = pop_commit(&list);
>  		if (!(commit->object.flags & STALE))
> -			commit_list_insert_by_date(commit, &result);
> +			commit_list_insert_by_date(commit, result);
>  	}
> -	return result;
> +	return 0;
>  }
>  
>  struct commit_list *get_octopus_merge_bases(struct commit_list *in)
> @@ -410,10 +418,11 @@ static struct commit_list *get_merge_bases_many_0(struct repository *r,
>  {
>  	struct commit_list *list;
>  	struct commit **rslt;
> -	struct commit_list *result;
> +	struct commit_list *result = NULL;
>  	int cnt, i;
>  
> -	result = merge_bases_many(r, one, n, twos);
> +	if (merge_bases_many(r, one, n, twos, &result) < 0)
> +		return NULL;
>  	for (i = 0; i < n; i++) {
>  		if (one == twos[i])
>  			return result;
