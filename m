Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0292139D4
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611430; cv=none; b=k7B4fGQVPdrBYyjEG4mSKOmx2zJv3nzGNkjNVLDvn6J1+iSxcrUTHvxfI8lPtmFdfxLiJAZ0gWpdlgko1ytWx5Oj8J/q4xqb7cgT6FwGsZ6Ukh0giB5OoOUE+8jeE8WhGAlRSy8ltmBRsQyTsqyeZFFr05o+/m0rsXbjhssZcBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611430; c=relaxed/simple;
	bh=ENW4uNMoyTmvrvruW0xlmFaXqjK0MF4CnUQKXUxMcv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HZgt3tl4AwHmdlXqcYXsemAxWzlRiLQ/+j4is8cagPEJ5GBHsdg9VC2bSDn77S7fBuumkaKE2nthBbCEzjwOvk5naxugyY9PmHL/vtuPhq/kDyCOBfpo8ACyhr7n9U+1OLWrKoYb6iJGTvuaJ0ZQmDHSkB+ekBDSCk408FBJ8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mSZQfrde; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mSZQfrde"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A38F26560;
	Fri,  2 Aug 2024 11:10:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ENW4uNMoyTmvrvruW0xlmFaXqjK0MF4CnUQKXU
	xMcv0=; b=mSZQfrdeGQiUWQKWw2OMhmFbTUVPftWz5VNyXQIgYUvl9Bt2QFUBWJ
	kbsaslo5y8fn++KvvxbZcaew051Xc8z+fZl20+ykCzIzEMHi2EhV5Ob/2LK65Lja
	0Wt4lP1re7Jgt0GIRhDHln/7qbGVKAQ2P/kp7q6FqpgwwdmBeeUmo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 129032655F;
	Fri,  2 Aug 2024 11:10:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 751F92655E;
	Fri,  2 Aug 2024 11:10:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH 2/3] strbuf: set errno to 0 after strbuf_getcwd
In-Reply-To: <0ed09e9abb85e73a80d044c1ddaed303517752ac.1722571853.git.gitgitgadget@gmail.com>
	(Kyle Lippincott via GitGitGadget's message of "Fri, 02 Aug 2024
	04:10:52 +0000")
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
	<0ed09e9abb85e73a80d044c1ddaed303517752ac.1722571853.git.gitgitgadget@gmail.com>
Date: Fri, 02 Aug 2024 08:10:26 -0700
Message-ID: <xmqqv80jeza5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 59B9F13C-50E1-11EF-9F30-BAC1940A682E-77302942!pb-smtp2.pobox.com

"Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Set `errno = 0;` prior to exiting from `strbuf_getcwd` successfully.
> This matches the behavior in functions like `run_transaction_hook`
> (refs.c:2176) and `read_ref_internal` (refs/files-backend.c:564).

This deep in the call chain, there is nothing that assures us that
the caller of this function does not care about the error before
entering this function, so I feel a bit uneasy about the approach,
and my initial reaction was "wouldn't it be safer to do the usual

	int saved_errno = errno;

	for (guessed_len = 128;; guessed_len *= 2) {
		... do things ...
		if (...) {
			... happy ...
			errno = saved_errno;
			return 0;
		}
	}

pattern.

Who calls this function, and inspects errno when this function
returns 0?  I do not mind adding the "save and restore" fix to this
function, but if there is a caller that looks at errno from a call
that returns success, that caller may also have to be looked at and
fixed if necessary.

Thanks.

> Signed-off-by: Kyle Lippincott <spectral@google.com>
> ---
>  strbuf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/strbuf.c b/strbuf.c
> index 3d2189a7f64..b94ef040ab0 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -601,6 +601,7 @@ int strbuf_getcwd(struct strbuf *sb)
>  		strbuf_grow(sb, guessed_len);
>  		if (getcwd(sb->buf, sb->alloc)) {
>  			strbuf_setlen(sb, strlen(sb->buf));
> +			errno = 0;
>  			return 0;
>  		}
