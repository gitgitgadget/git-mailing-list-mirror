Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB055786B
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 22:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710195316; cv=none; b=Ox1GO6ICD+R+kNWK7EqIrkjXY+Ax7kRhJvC7CDb25CtLSVEIZbYfiboL4mqusDck6V4FmxhF68OP/CE4N/RHwSQaQy3tCM2DQ3WwckRfAIsMPRyF3ZhEYtrK3lQMcSyzWJ7YmgXb92id3OTYKSZnevw29RmCgcvL05N61awz4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710195316; c=relaxed/simple;
	bh=ajXOE9fVX7OgTGnNi2rWEqOvV/rlExQzxA++t3aRNz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NhA8kM0vSFO1NP6NK6gtmVGtH0jjTsjpRiFAD+AdWJszTsqTUdQs67JOU6OMWHvHkuAlDIKXcgm0f+NbwK9zxFAbEsz2LEB1btaIMksHfwImPQdwjt67LVCrzL7rIQyDGIZP6sOKjetqf04MVxtturiL4CAAjzbnFoJKWmhTd/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nHjPUyOl; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nHjPUyOl"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 051741FF1E1;
	Mon, 11 Mar 2024 18:15:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ajXOE9fVX7OgTGnNi2rWEqOvV/rlExQzxA++t3
	aRNz0=; b=nHjPUyOl4OQiWKLstRBwKI/UcdF6bAZmBm69mnOVCuUOZhisEnawhL
	NlKtg4Pn6liFcKJKtzkFeDgwJbO52QQD0LAA/10kr3toiIMz2K07N588ycvbKzAc
	uiLonmF+GreY++O99IZkvlxSLoLQDjNWW3rLpIGvWwibMY9Z+qnD4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC8AB1FF1DF;
	Mon, 11 Mar 2024 18:15:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 111C01FF1DE;
	Mon, 11 Mar 2024 18:15:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>,
  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/3] cat-file: add %(objectmode) atom
In-Reply-To: <b836bc64ddc06069d1722ae89ca049e9dfce7eec.1710183362.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Mon, 11 Mar 2024 18:56:01
	+0000")
References: <pull.1689.git.1710183362.gitgitgadget@gmail.com>
	<b836bc64ddc06069d1722ae89ca049e9dfce7eec.1710183362.git.gitgitgadget@gmail.com>
Date: Mon, 11 Mar 2024 15:15:05 -0700
Message-ID: <xmqq34swo1p2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D14BC008-DFF4-11EE-A7B3-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index bbf851138ec..73bd78c0b63 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -272,6 +272,7 @@ struct expand_data {
>  	struct object_id oid;
>  	enum object_type type;
>  	unsigned long size;
> +	unsigned short mode;
>  	off_t disk_size;

We are not saving the storage used in this structure by using
"unsigned short" due to alignment, so I got curious where the choice
came from, but I do not think of any sensible explanation.

Let's to be consistent with the remainder of the system, like how
the mode is stored in the in-core index (ce_mode) and in the in-core
tree entry (name_entry.mode) and use "unsigned int" instead here.

> +#define EXPAND_DATA_INIT  { .mode = S_IFINVALID }

Thanks for knowing about and choosing to use the INVALID thing (I
would have naively chosen 0 without looking around enough and made
things inconsistent).

> +	} else if (is_atom("objectmode", atom, len)) {
> +		if (!data->mark_query && !(S_IFINVALID == data->mode))
> +			strbuf_addf(sb, "%06o", data->mode);

Nit.  I think

		if (!data->mark_query && data->mode != S_IFINVALID)

would be a more common way to write the same thing.

> @@ -766,7 +772,7 @@ static int batch_objects(struct batch_options *opt)
>  {
>  	struct strbuf input = STRBUF_INIT;
>  	struct strbuf output = STRBUF_INIT;
> -	struct expand_data data;
> +	struct expand_data data = EXPAND_DATA_INIT;
>  	int save_warning;
>  	int retval = 0;
>  
> @@ -775,7 +781,6 @@ static int batch_objects(struct batch_options *opt)
>  	 * object_info to be handed to oid_object_info_extended for each
>  	 * object.
>  	 */
> -	memset(&data, 0, sizeof(data));

Nice to see this go with the _INIT thing.

> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index ac1f754ee32..6f25cc20ec6 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -114,9 +114,10 @@ run_tests () {
>      type=$1
>      object_name=$2
>      oid=$(git rev-parse --verify $object_name)
> -    size=$3
> -    content=$4
> -    pretty_content=$5
> +    mode=$3
> +    size=$4
> +    content=$5
> +    pretty_content=$6
>  
>      batch_output="$oid $type $size
>  $content"

I wonder if appending $mode as an optional thing at the end would
have made the patch less noisy?  After all, the expectation above
that does not have $mode, and the tests that are expected to produce
output that match the expectation, do not have to change.  And the
existing invocation of run_tests that do not care about $mode do not
have to change.

But I guess if the damage is only with the above 7-lines (which
would become just 1 if we made mode the $6 last tthing), it is not a
huge deal either way?
