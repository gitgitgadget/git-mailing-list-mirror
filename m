Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CD9138488
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710815; cv=none; b=owjvh8U1pLBc7IK+zGCB0X+ZChi2dtL67xkNvGKEeosktCqb1XxrGIxQh3d/F/M2q7a5tAiPnWxtvSreDKZ0plDE7xRFsSxnTzXilAvRGzlUosHhaHYEG7CEvxUO7LmKbt5JoV/LrGl7uDcy4UUB6ZbKmJIKwSIgIsOX9ZflXL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710815; c=relaxed/simple;
	bh=0BgsX2eNlIizxdwAi6dFyUzQ3QC3DIMLrOOyLBVBMGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ai1n6Sp4f2bXwCufTDc3ypckKEUf36le5NxEoaiTvTC1OTEnMy/dDAUcYhTcaqxGituC/MHEaiHJaflMwkCXLZnCBCCXcuu8Ry3GiIdnp5fgogvPrsENU3jOsmNYlVrY92qqVt0FwSURP2sV04sDtxnublieyUnVVhEEseP5L7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kwon3zYx; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kwon3zYx"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 86E8F22AF3;
	Fri, 23 Feb 2024 12:53:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0BgsX2eNlIizxdwAi6dFyUzQ3QC3DIMLrOOyLB
	VBMGY=; b=Kwon3zYxU8yKAnInNDT4RO5ssk0Baw435JrxDFk96+fGWwn5uJN+KU
	NUBg9GNoc/7mPQovDRGDrBz0Nnt7OpcohVlYqcLZCqgoeA3VK4EXcvuKzaVAaEP6
	HJX8Sjz6AXzrs4jh4X+xN/MFCXrE33KB7tOtgUntZ41ncPAfbKMjE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7EA0A22AF2;
	Fri, 23 Feb 2024 12:53:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 790DC22AF1;
	Fri, 23 Feb 2024 12:53:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff Hostetler
 <git@jeffhostetler.com>,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 13/16] fsmonitor: trace the new invalidated
 cache-entry count
In-Reply-To: <58b36673e151ad15eb44c9ca1c03cfef51657d11.1708658300.git.gitgitgadget@gmail.com>
	(Jeff Hostetler via GitGitGadget's message of "Fri, 23 Feb 2024
	03:18:17 +0000")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<58b36673e151ad15eb44c9ca1c03cfef51657d11.1708658300.git.gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 09:53:27 -0800
Message-ID: <xmqq5xyfukx4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 73C1221C-D274-11EE-98B6-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhostetler@github.com>
>
> Consolidate the directory/non-directory calls to the refresh handler
> code.  Log the resulting count of invalidated cache-entries.

OK.  Again, there is nothing surprising in the changes in the patch.
Looking good.

> The nr_in_cone value will be used in a later commit to decide if
> we also need to try to do case-insensitive lookups.
>
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

> diff --git a/fsmonitor.c b/fsmonitor.c
> index c16ed5d8758..739ddbf7aca 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -308,16 +308,21 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
>  {
>  	int len = strlen(name);
>  	int pos = index_name_pos(istate, name, len);
> +	size_t nr_in_cone;
>  
>  	trace_printf_key(&trace_fsmonitor,
>  			 "fsmonitor_refresh_callback '%s' (pos %d)",
>  			 name, pos);
>  
> -	if (name[len - 1] == '/') {
> -		handle_path_with_trailing_slash(istate, name, pos);
> -	} else {
> -		handle_path_without_trailing_slash(istate, name, pos);
> -	}
> +	if (name[len - 1] == '/')
> +		nr_in_cone = handle_path_with_trailing_slash(istate, name, pos);
> +	else
> +		nr_in_cone = handle_path_without_trailing_slash(istate, name, pos);
> +
> +	if (nr_in_cone)
> +		trace_printf_key(&trace_fsmonitor,
> +				 "fsmonitor_refresh_callback CNT: %d",
> +				 (int)nr_in_cone);
>  }
>  
>  /*
