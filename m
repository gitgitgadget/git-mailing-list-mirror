Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315054207B
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173693; cv=none; b=ffatcbMGkgLpEgLLlug2+9fPXW6QWa/Dv9kUAYwaecvtkOt4OcKP9WGAotWN4QNpvTJkH7b4rg8YpRSGZG1IUIKxa/4CKyXZis/vc3vIJWG2pUxNo/7NLUNV9GPqGbQ7gL1fgQhbhe6aRtBMMnp21wZLdygg8S1UYt8HaUS80zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173693; c=relaxed/simple;
	bh=ueLV2OnTwGhTqQpMEbovaL39aTIDbO4B4w5RAqobDSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GzNV0pcgvoAMvRNnyGRIQj82OZsfee07iQ1+OUPxZ7rMHbuCfqsznWE9NH9/LWly3w6H8v7S1c/BLtXjr47sCd+erofioSei/rH5yr7OR8m2YQpQ7XlOiNhDH9HUtlGGmZoPnRrLiUEahpvFkoUiVnPEVBoXVne89ee3Yf/z2XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Okxx0jHS; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Okxx0jHS"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B1FB22C9CF;
	Mon, 11 Mar 2024 12:14:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ueLV2OnTwGhTqQpMEbovaL39aTIDbO4B4w5RAq
	obDSU=; b=Okxx0jHSQlzVU8KEAq+1IS1kuheC1/UBRrHxYO0QpKGUTCdJfrseFK
	HXO45lf1E6ANSkGXfbU7Wt7vgd5wpZEtzGFd+JegW1S4DtPT+i+nwycyKcf2/r8o
	N0mCPzzHnkc+Zm6E/FacG3XnQKcXER0HOt5McC8q0Vi2uYS8Wp2hg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AB2862C9CE;
	Mon, 11 Mar 2024 12:14:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 51ED72C9CD;
	Mon, 11 Mar 2024 12:14:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Aryan Gupta <garyan447@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC][PATCH 1/1] add zero count optimization in ewah_bitmap.c
In-Reply-To: <20240310162614.62691-2-garyan447@gmail.com> (Aryan Gupta's
	message of "Sun, 10 Mar 2024 17:26:14 +0100")
References: <20240310162614.62691-1-garyan447@gmail.com>
	<20240310162614.62691-2-garyan447@gmail.com>
Date: Mon, 11 Mar 2024 09:14:46 -0700
Message-ID: <xmqqzfv4u4nd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7B7D5F6A-DFC2-11EE-AF08-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Aryan Gupta <garyan447@gmail.com> writes:

> Signed-off-by: Aryan Gupta <garyan447@gmail.com>
> ---
>  ewah/ewah_bitmap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
> index 8785cbc54a..9056829572 100644
> --- a/ewah/ewah_bitmap.c
> +++ b/ewah/ewah_bitmap.c
> @@ -257,10 +257,11 @@ void ewah_each_bit(struct ewah_bitmap *self, void (*callback)(size_t, void*), vo
>  		for (k = 0; k < rlw_get_literal_words(word); ++k) {
>  			int c;
>  
> -			/* todo: zero count optimization */
> -			for (c = 0; c < BITS_IN_EWORD; ++c, ++pos) {
> -				if ((self->buffer[pointer] & ((eword_t)1 << c)) != 0)
> -					callback(pos, payload);
> +			if(self->buffer[pointer]) {
> +				for (c = 0; c < BITS_IN_EWORD; ++c, ++pos) {
> +					if (((eword_t)1 << c) != 0)
> +						callback(pos, payload);
> +				}
>  			}

When self->buffer[pointer] (let's call it the eword) is zero, both
your rewritten version and the original version does the same thing
and will not call the callback at all, but in all other cases,
doesn't your rewrite change the behavior?

Imagine the eword is 01.  The original starts the loop with c==0,
notices that the LSB is on by masking the eword in the bitmap with
((eword_t)1<<c), and calls the callback function.  Your version
notices that the eword is not zero and enters the loop.  Because
((eword_t)1<<c) for all values of c between 0 and BITS_IN_EWORD are
by definition not zero, you end up calling the callback function for
every bit in the word, whether it is on in the eword, no?
