Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828613D553
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951972; cv=none; b=b+BQfKqcFdUYL3/+r/11k+MJlzvSrBXyLLGqDK0ZXHmEn6dl8566jz6MZ4RaQlOeFf73IPpfF5fP2aSzwuCgVnuLj3kK3anmY/WaW3lqCBJWqxIDfqpUW3NNjB+gfmABdqn8JoIwvfFHTD0ri/XnnsAQs/KiT+XeA339S2kXnBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951972; c=relaxed/simple;
	bh=P9hHVUGN5x8LYUMv5ttIyPvatSJ30IjrBdkTSFR+XEQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T+bZwhxls8qKpw9I46iM33/dQCrkeFvYYU/9jRn7r2WXQjQLaq4fH1tuzmYfO1VkaaLFw0wCZRa23s9HYiIHWSINyzjwvUT9IddSlCIR8jHoYPCe3VnuSxQ6ruscFGxQxmIkZJ+/g1biCMHBhWxemvhA0f08i26SR2IsD432yCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DDy/GBuC; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DDy/GBuC"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B511532E6B;
	Mon, 22 Jan 2024 14:32:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=P9hHVUGN5x8LYUMv5ttIyPvatSJ30IjrBdkTSF
	R+XEQ=; b=DDy/GBuCkDExhnT9VAs8/RbXOGSN2XIZztDc5e8MdPBMWWmApiOcu9
	SbckfNKn6UL8Mymds3VqWKzd56yCgljsH9mcjW+Rb6LwGcMO1/+gC/RN0M9p76W9
	BnRhkEHelYcomz+ND4xGICtDKONJmEbrKvNzTcmqnwSurcnkdljlM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id ADB3632E6A;
	Mon, 22 Jan 2024 14:32:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 38FCF32E69;
	Mon, 22 Jan 2024 14:32:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Mohit Marathe <mohitmarathe@proton.me>,  Mohit
 Marathe <mohitmarathe23@gmail.com>
Subject: Re: [PATCH 2/2] patch-id: replace `atoi()` with `strtol_i2()`
In-Reply-To: <1ece724b1ca7f71542bfef42795fce798563ecde.1705913519.git.gitgitgadget@gmail.com>
	(Mohit Marathe via GitGitGadget's message of "Mon, 22 Jan 2024
	08:51:59 +0000")
References: <pull.1646.git.1705913519.gitgitgadget@gmail.com>
	<1ece724b1ca7f71542bfef42795fce798563ecde.1705913519.git.gitgitgadget@gmail.com>
Date: Mon, 22 Jan 2024 11:32:36 -0800
Message-ID: <xmqq8r4htb8r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 00424B8E-B95D-11EE-B382-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	static const char digits[] = "0123456789";
>  	const char *q, *r;
> +	char *endp;
>  	int n;
>  
>  	q = p + 4;
>  	n = strspn(q, digits);
>  	if (q[n] == ',') {
>  		q += n + 1;
> -		*p_before = atoi(q);
> +		if (strtol_i2(q, 10, p_before, &endp) != 0)
> +			return 0;
>  		n = strspn(q, digits);
>  	} else {
>  		*p_before = 1;
>  	}

Looking at this code again, because we upfront run strspn() to make
sure q[] begins with a run of digits *and* followed by a comma
(which is not a digit), I think it is safe to use atoi() and assume
it would slurp all the digits.  So the lack of another check the use
of new helper allows us to do, namely

		if (endp != q + n)
			return 0;

is probably OK, but that is one of the two reasons why you would
favor the use of new helper over atoi(), so the upside of this
change is not all that great as I originally hoped for X-<.

Not your fault, of course.  We would still catch when the digit
string that starts q[] is too large to fit in an int, which is an
upside.

> -	if (n == 0 || q[n] != ' ' || q[n+1] != '+')
> +	if (q[n] != ' ' || q[n+1] != '+')
>  		return 0;

When we saw q[] that begins with ',' upon entry to this function, we
used to say *p_before = 1 and then saw n==0 and realized it is not a
good input and returned 0 from the function.

Now we instead peek q[0] and the check says q[0] is not SP so we
will return 0 the same way so there is no behaviour change from the
upper hunk?  The conversion may be correct, but it wasn't explained
in the proposed commit log message.

How are the change to stop caring about n==0 here ...

>  	r = q + n + 2;
>  	n = strspn(r, digits);
>  	if (r[n] == ',') {
>  		r += n + 1;
> -		*p_after = atoi(r);
> -		n = strspn(r, digits);
> +		if (strtol_i2(r, 10, p_after, &endp) != 0)
> +			return 0;
>  	} else {
>  		*p_after = 1;
>  	}
> -	if (n == 0)
> -		return 0;

... and this change here, linked to the switch from atoi() to
strtul_i2()[*]?

It looks like an unrelated behaviour change that is left
unexplained.

>  	return 1;
>  }

Thanks for working on this one.


[Footnote]

 * by the way, what a horrible name for a public function.  Yuck.
