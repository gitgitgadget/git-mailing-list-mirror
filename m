Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB1F5380D
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705696117; cv=none; b=mbF8fU0T27Q6EgQ7Kuckjl0YLBW6ZUBUMmWEKyZBFVeMEfjGvvQJtctpDLLqDywb+VKNreAZG2+iAYpsOFBlzWAA+dJyf+L5fkd2vYOUO6MpzLOiic9pduJsBNVljDE5dQDOmF6uJuvDMmu5KM7BwEKIB/F1NpVP3R4O/4Ge3D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705696117; c=relaxed/simple;
	bh=iDQ2Y3vulZBdh+toXfSW95CE4Dl4UBPIdYJNLM9TZN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z+6YUMdrQe03stve/RC7b1pbHuNcfJ1wyJCRiz7LzUEQManGdUJhr8V2+WGUIniUcBhw7A4o+JXqHFp/CBNdrxexPgjQj+ipTqpjazMY41yts0Akyzi39iqpKWaShSvhmzfxHKSdEjCjd8fAr8Ds+eIwKJ6sX0HFcvtKlXynSmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=r4sXqqf/; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r4sXqqf/"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EE47120921;
	Fri, 19 Jan 2024 15:28:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iDQ2Y3vulZBdh+toXfSW95CE4Dl4UBPIdYJNLM
	9TZN8=; b=r4sXqqf/8Ya+J+dqCe3A6T9pmxGqdvChGTPIAtTQsGGXLnFXmAGncm
	u//AKnxriXQIkuFV+13YyGyDmsvsuKsSCxDmL6+UJl2HRsKrMDt2xhz3MegaqKE4
	e3gGDL1s5bO+AYBWndfKCQHfg2nC2dz2gdu7BX0u2E3Wx/NOC8jfU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E568120920;
	Fri, 19 Jan 2024 15:28:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 801822091F;
	Fri, 19 Jan 2024 15:28:31 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/7] refs: redefine special refs
In-Reply-To: <a4b4dd51f81fdf65f79b9afc3bd85109817ea128.1705659748.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 19 Jan 2024 11:40:24 +0100")
References: <cover.1705659748.git.ps@pks.im>
	<a4b4dd51f81fdf65f79b9afc3bd85109817ea128.1705659748.git.ps@pks.im>
Date: Fri, 19 Jan 2024 12:28:29 -0800
Message-ID: <xmqq7ck5jceq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4FBC6EAC-B709-11EE-AFA9-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Now that our list of special refs really only contains refs which have
> actually-special semantics, let's redefine what makes a special ref.

Yay.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c | 33 +++++++--------------------------
>  1 file changed, 7 insertions(+), 26 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 047c81b1c1..08a900a047 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1839,13 +1839,10 @@ static int refs_read_special_head(struct ref_store *ref_store,
>  static int is_special_ref(const char *refname)
>  {
>  	/*
> -	 * Special references get written and read directly via the filesystem
> -	 * by the subsystems that create them. Thus, they must not go through
> -	 * the reference backend but must instead be read directly. It is
> -	 * arguable whether this behaviour is sensible, or whether it's simply
> -	 * a leaky abstraction enabled by us only having a single reference
> -	 * backend implementation. But at least for a subset of references it
> -	 * indeed does make sense to treat them specially:
> +	 * Special references are refs that have different semantics compared
> +	 * to "normal" refs. These refs can thus not be stored in the ref
> +	 * backend, but must always be accessed via the filesystem. The
> +	 * following refs are special:
>  	 *
>  	 * - FETCH_HEAD may contain multiple object IDs, and each one of them
>  	 *   carries additional metadata like where it came from.
> @@ -1853,25 +1850,9 @@ static int is_special_ref(const char *refname)
>  	 * - MERGE_HEAD may contain multiple object IDs when merging multiple
>  	 *   heads.
>  	 *
> -	 * There are some exceptions that you might expect to see on this list
> -	 * but which are handled exclusively via the reference backend:
> -	 *
> -	 * - BISECT_EXPECTED_REV
> -	 *
> -	 * - CHERRY_PICK_HEAD
> -	 *
> -	 * - HEAD
> -	 *
> -	 * - ORIG_HEAD
> -	 *
> -	 * - "rebase-apply/" and "rebase-merge/" contain all of the state for
> -	 *   rebases, including some reference-like files. These are
> -	 *   exclusively read and written via the filesystem and never go
> -	 *   through the refdb.
> -	 *
> -	 * Writing or deleting references must consistently go either through
> -	 * the filesystem (special refs) or through the reference backend
> -	 * (normal ones).
> +	 * Reading, writing or deleting references must consistently go either
> +	 * through the filesystem (special refs) or through the reference
> +	 * backend (normal ones).
>  	 */
>  	static const char * const special_refs[] = {
>  		"FETCH_HEAD",
