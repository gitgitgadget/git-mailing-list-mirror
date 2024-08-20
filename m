Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B678194131
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166019; cv=none; b=cPy7AV7mp5zaXhs2ryQDy/Hnh/pFU2mIKH21+/jkkBAZNbunHfYkWDaao7D0WbISubRLU1II8pM2ODfkJSdyaCliOITbKVIHw4DzEcHigkxWDCgjekw0Q9yZzKRPYDMA1l1IX3ROU8R/CoP48mk2v4bFX6G/uoaKBhimkD3EGTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166019; c=relaxed/simple;
	bh=WVETMF5nYWGh1Aq5PI9XD2ub1jdiXWVUC3LFaOfmnS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cgZy38/EOcmtwQSNweSL6j/O9nowurt7Fc2xgKia7BMX/HoTVN+9ftAe/Ne0Gh77r6ScmpnlA3yLk4vO6vePnpENTP0oFzCpJ/lb+ScfG3mJEuuTTwE7sW5pg6UmiPaDzGMXBoQrrcJqXVXS8sZ6ARF8cVo2Z5Cuq1xIecrnzSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RRaUjC/R; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RRaUjC/R"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B09223DDA;
	Tue, 20 Aug 2024 11:00:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WVETMF5nYWGh1Aq5PI9XD2ub1jdiXWVUC3LFaO
	fmnS4=; b=RRaUjC/RXoFrZmeM6Luxm9tLPn4NhbcciCBlmJBARaFGmEkoJTRr1F
	yoPUM9bEY+bOmekDPiYN7Yx1R8gZpt6nA6u/TpC+Yd3f0UPd0LUi+RcJA5YwadfD
	8NSdIHFyedquW8sxqbWlgZK7PmFM8WDVncDk3fh5WOVbe7jEa5Dr0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 938BB23DD9;
	Tue, 20 Aug 2024 11:00:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 143EE23DD3;
	Tue, 20 Aug 2024 11:00:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2024, #07; Mon, 19)
In-Reply-To: <20240820051819.GA3020004@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 20 Aug 2024 01:18:19 -0400")
References: <xmqqa5h8c8zu.fsf@gitster.g>
	<20240820051819.GA3020004@coredump.intra.peff.net>
Date: Tue, 20 Aug 2024 08:00:12 -0700
Message-ID: <xmqq1q2jck8z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E78BDE72-5F04-11EF-A0EE-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> I did have one fixup for this series, based on feedback from Ghanshyam.
> Here it is as a separate patch on top.

Ah, I recall seeing it.  

My personal take was that calling this one via the same setup()
wrapper was just fine, which made it similar to everybody else.

But I am also fine to treat the first parameter to TEST() as just a
simple Boolean, which is the right way to think about it anyway ;-)
It is mere a happenstance that all others use the setup() thing
because they happen to share the need to perform the same set-up.

Will queue on top.  Thanks.

> -- >8 --
> Subject: [PATCH] t-hashmap: stop calling setup() for t_intern() test
>
> Commit f24a9b78a9 (t-hashmap: mark unused parameters in callback
> function, 2024-08-17) noted that the t_intern() does not need its
> hashmap parameter, but we have to keep it to conform to the function
> pointer interface of setup().
>
> But since the only thing setup() does is create and tear down the
> hashmap, we can just skip calling setup() entirely for this case, and
> drop the unused parameters. This simplifies the code a bit.
>
> Helped-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/unit-tests/t-hashmap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/t/unit-tests/t-hashmap.c b/t/unit-tests/t-hashmap.c
> index da102eb541..83b79dff39 100644
> --- a/t/unit-tests/t-hashmap.c
> +++ b/t/unit-tests/t-hashmap.c
> @@ -322,8 +322,7 @@ static void t_alloc(struct hashmap *map, unsigned int ignore_case)
>  	free(removed);
>  }
>  
> -static void t_intern(struct hashmap *map UNUSED,
> -		     unsigned int ignore_case UNUSED)
> +static void t_intern(void)
>  {
>  	const char *values[] = { "value1", "Value1", "value2", "value2" };
>  
> @@ -357,6 +356,6 @@ int cmd_main(int argc UNUSED, const char **argv UNUSED)
>  	TEST(setup(t_iterate, 0), "iterate works");
>  	TEST(setup(t_iterate, 1), "iterate (case insensitive) works");
>  	TEST(setup(t_alloc, 0), "grow / shrink works");
> -	TEST(setup(t_intern, 0), "string interning works");
> +	TEST(t_intern(), "string interning works");
>  	return test_done();
>  }
