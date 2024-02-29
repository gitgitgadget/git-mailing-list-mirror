Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256D07D08C
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236337; cv=none; b=NwOGVt2QUEztG60eNPhGwN3fL8TpviTQCVck6ID9iPHTalyFWURAe4cKHPY/VXLT7Mjme+6/w90Fp5xVYT63CVo3aNDCwo8FqfOs+6lXOn75qImQ4a/Cn39nQiUp/iHAEO59fHa89wRP0lVum3vz0vHY5UZ0nJ0FmSKWKFSG3b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236337; c=relaxed/simple;
	bh=B2gxHT2AFrraODnyQKnrCQA0BY54yvtvqC3eIDwPuSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VTIWpLJuLIZp3YMdiU14v0Y5NBCrFVJGD96+97p0qyo0RakvRnXuOBcz4PzQewhKlrBCRPp3gTWApkz+Nmw3XTh0SDWrMR4Q/BZag2crD9z9B2plCUV1IzSPrd8kGoa3pXRMjjP3NTwA8I1lKcMyGifpsshpUcAf30b8hReCiA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=abhTbGLp; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="abhTbGLp"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BF70E1E62F3;
	Thu, 29 Feb 2024 14:52:14 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=B2gxHT2AFrraODnyQKnrCQA0BY54yvtvqC3eID
	wPuSE=; b=abhTbGLpBLZ4GyT2jy7Lf5fiHvyQ+75IYoOvxrX7vfmtb6xBhADlM3
	hNyY7HewaOYgp21Edj6cal4A46enjbhHZDB52bN8TmoH5HnDLYc2JVfKYkp0EY8D
	t+0ZwBeOqPXxpM0E2MVabh5xn7hGkDavfpwgcBkw+t8o49D+f0nM4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B6E201E62F2;
	Thu, 29 Feb 2024 14:52:14 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E42E1E62F1;
	Thu, 29 Feb 2024 14:52:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eugenio Gigante <giganteeugenio2@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  sunshine@sunshineco.com
Subject: Re: [PATCH v2 1/1] add: use unsigned type for collection of bits
In-Reply-To: <20240229194444.8499-2-giganteeugenio2@gmail.com> (Eugenio
	Gigante's message of "Thu, 29 Feb 2024 20:44:44 +0100")
References: <xmqqsf1ekf34.fsf@gitster.g>
	<20240229194444.8499-1-giganteeugenio2@gmail.com>
	<20240229194444.8499-2-giganteeugenio2@gmail.com>
Date: Thu, 29 Feb 2024 11:52:12 -0800
Message-ID: <xmqqttlrdp5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 08CD2C18-D73C-11EE-88AA-25B3960A682E-77302942!pb-smtp2.pobox.com

Eugenio Gigante <giganteeugenio2@gmail.com> writes:

> The 'refresh' function  in 'builtin/add.c'
> declares 'flags' as signed, and passes it
> as an argument to the 'refresh_index' function,
> which though expects an unsigned value.

OK.  This has become much easier to read by dropping the mention of
the header file where the callee happens to be declared.

Just FYI, in my private rewrite (that I'll discard), I made it like
so:

   builtin/add.c:refresh() declares 'flags' as signed, and uses it
   to call refresh_index() that expects an unsigned value.

> Since in this case 'flags' represents
> a bag of bits, whose MSB is not used
> in special ways, change the type
> of 'flags' to unsigned.

Good, too.

Will queue.

> Signed-off-by: Eugenio Gigante <giganteeugenio2@gmail.com>
> ---
>  builtin/add.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index ada7719561..393c10cbcf 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -115,7 +115,7 @@ static int refresh(int verbose, const struct pathspec *pathspec)
>  	int i, ret = 0;
>  	char *skip_worktree_seen = NULL;
>  	struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
> -	int flags = REFRESH_IGNORE_SKIP_WORKTREE |
> +	unsigned int flags = REFRESH_IGNORE_SKIP_WORKTREE |
>  		    (verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET);
>  
>  	seen = xcalloc(pathspec->nr, 1);
