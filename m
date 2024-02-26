Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B978712EBE9
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969749; cv=none; b=R/SiG4dxTgzOueTaIUgoonoVkQFXu/hACbi3B9vTwjNI0Xq567CK1TgzCvmw3e3wD+T1lOAtnlXnbaUmCGECL5s1u8r9VHOsNtXX40NQqtYOZ4xVavLBF3PufGjthDzDuDH6Ol6R9HVMaJYQsuMm2MHT9AhJqPdNq0o2voKXoYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969749; c=relaxed/simple;
	bh=kmYxoAy/V4uGd5eqZ7iqdFu6HEAu7W87W70iIe/9tak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t4s31UIW7NxA2mWvwQdUuvsLCjNIqCUnOIgnUFdFjzaAtSfV1Kv/ijmA5io5dvZryGOfY1hXub1QEsoRfL4IdmC4JfFnwEgsVmlP5SWJ6hXmhM0+r63EgJHRXEHGlnc1OYZpHIrg4UsrbPoGxSav+lbb/zLltDfudFuNiv1au8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=g550M3M3; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g550M3M3"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 562CA1B18A;
	Mon, 26 Feb 2024 12:49:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kmYxoAy/V4uG
	d5eqZ7iqdFu6HEAu7W87W70iIe/9tak=; b=g550M3M35sMuS7N4KbsHNZHqG3X4
	idFpVfCXSELSel+pW2aCa0tP8Ybw/BDSqhlJkM6oxRrZE0aVaYZZuicc335O4gWU
	QkrDxDwxdzT4o/wKDUj75xVeDixaa0yg1OJVNO02JDDHs47GlCh5aE5Q5zpX3fRV
	POQ1OBV19wVUz4U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E5C41B189;
	Mon, 26 Feb 2024 12:49:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E87211B188;
	Mon, 26 Feb 2024 12:49:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] upload-pack: don't send null character in abort message
 to the client
In-Reply-To: <20240225183452.1939334-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
	message of "Sun, 25 Feb 2024 19:34:52 +0100")
References: <20240225183452.1939334-1-szeder.dev@gmail.com>
Date: Mon, 26 Feb 2024 09:49:02 -0800
Message-ID: <xmqqttlvnmk1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 54B754C4-D4CF-11EE-8067-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Since 583b7ea31b (upload-pack/fetch-pack: support side-band
> communication, 2006-06-21) the abort message sent by upload-pack in
> case of possible repository corruption ends with a null character.

It is so so old that makes me wonder if it is safe to "fix" it, but
I cannot think of a sensible way to write a third-party client that
may have been working fine and would break when this fix is made.

> This can be seen in several test cases in 't5530-upload-pack-error.sh'
> where 'grep <pattern> output.err' often reports "Binary file
> output.err matches" because of that null character.
>
> The reason for this is that the abort message is defined as a string
> literal, and we pass its size to the send function as
> sizeof(abort_msg), which also counts the terminating null character.
>
> Use strlen() instead to avoid sending that terminating null character.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  upload-pack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index 2537affa90..6e0d441ef5 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -463,7 +463,7 @@ static void create_pack_file(struct upload_pack_dat=
a *pack_data,
> =20
>   fail:
>  	free(output_state);
> -	send_client_data(3, abort_msg, sizeof(abort_msg),
> +	send_client_data(3, abort_msg, strlen(abort_msg),
>  			 pack_data->use_sideband);
>  	die("git upload-pack: %s", abort_msg);
>  }
