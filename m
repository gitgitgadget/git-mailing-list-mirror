Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B2A823CD
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414253; cv=none; b=mdwatqeK9Sta0h76zZzCsvUWPICDgzajYyxGpXi2eeYzuGZupTr1jBLBcrT5ofLeeYcrWpOeR2AcusNZlk+NATl6krhwAWvGNZdm0Wa3mWvRqiYJxyshZWXy2tYGBfFPnvfOyY/7m8Dxl/knbGAcx1j3me8zDz3fSs6ixQrAjeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414253; c=relaxed/simple;
	bh=t54G1Emw1JJs1LyB1DS0hwHV5mGWgu13f7QRTOvu6Tk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bY+Sq4sJ+wjCeUxKLLG320SqWgvTMXP+LrboatZOd8ROTKiSh43PTNULivEaQcHlDxQrL/FG1PF/n0VRViEKoiZoo7a9H2D6StqyXnkRouKq0d4a6URdM81VNidXTZF+odcjVU9+orAlPgNxZnnD0PLCSUhgljhH57oWoEWwP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=S9c1hgl6; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S9c1hgl6"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D1931E7B1D;
	Thu,  8 Feb 2024 12:44:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=t54G1Emw1JJs1LyB1DS0hwHV5mGWgu13f7QRTO
	vu6Tk=; b=S9c1hgl6Y9yJ3rHY8hwzN4PWcTTZ49M/PWxwmRW/uX/SQtgsDnp/Tv
	DdiqzpDe7RnScssIlPLngWxztxhcevIX7/M8tVn4y+/IoBLi1X3Zr44HQxB+3AcQ
	zEuwD+gPWwO8EjDSrcwJ/Z0j1MbNDRFzxGPHBU/n1c8zPLFMygVjc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 528001E7B1C;
	Thu,  8 Feb 2024 12:44:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BC8E71E7B1B;
	Thu,  8 Feb 2024 12:44:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  John Cai
 <johncai86@gmail.com>,  Linus Arver <linusa@google.com>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 4/4] rev-list: allow missing tips with
 --missing=[print|allow*]
In-Reply-To: <20240208135055.2705260-5-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 8 Feb 2024 14:50:55 +0100")
References: <20240208135055.2705260-1-christian.couder@gmail.com>
	<20240208135055.2705260-5-christian.couder@gmail.com>
Date: Thu, 08 Feb 2024 09:44:07 -0800
Message-ID: <xmqqeddmonq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A9EF504C-C6A9-11EE-8E5F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

>  The form '--missing=print' is like 'allow-any', but will also print a
>  list of the missing objects.  Object IDs are prefixed with a ``?'' character.
> ++
> +If some tips passed to the traversal are missing, they will be
> +considered as missing too, and the traversal will ignore them. In case
> +we cannot get their Object ID though, an error will be raised.

Makes sense.

> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index b3f4783858..ec9556f135 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -545,6 +545,15 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  	 *
>  	 * Let "--missing" to conditionally set fetch_if_missing.
>  	 */
> +	/*
> +	 * NEEDSWORK: These dump loops to look for some options early
> +	 * are ugly. We really need setup_revisions() to have a

I would drop the "dump" and "ugly" from here.  It OK to make value
judgement with such words in casual conversations on a proposed
patch, but when we make a request to future developers to fix our
mess, we should be more objective and stick to the techincal facts,
so that they have better understanding on why we think this area
needs more work.

Perhaps something like:

    These loops that attempt to find presence of options without
    understanding what the options they are skipping are broken
    (e.g., it would not know "--grep --exclude-promisor-objects" is
    not triggering "--exclude-promisor-objects" option).

Everything after "We really need" is good (modulo possible grammos),
I think.  Thanks for writing it.

> +	 * mechanism to allow and disallow some sets of options for
> +	 * different commands (like rev-list, replay, etc). Such
> +	 * mechanism should do an early parsing of option and be able
> +	 * to manage the `--exclude-promisor-objects` and `--missing=...`
> +	 * options below.
> +	 */
>  	for (i = 1; i < argc; i++) {
>  		const char *arg = argv[i];
>  		if (!strcmp(arg, "--exclude-promisor-objects")) {
> @@ -753,8 +762,12 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  
>  	if (arg_print_omitted)
>  		oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
> -	if (arg_missing_action == MA_PRINT)
> +	if (arg_missing_action == MA_PRINT) {
>  		oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
> +		/* Already add missing tips */
> +		oidset_insert_from_set(&missing_objects, &revs.missing_commits);
> +		oidset_clear(&revs.missing_commits);
> +	}

It is unclear what "already" here refers to, at least to me.

Thanks.
