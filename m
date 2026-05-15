Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DCD4BC032
	for <git@vger.kernel.org>; Fri, 15 May 2026 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863791; cv=none; b=QIMNhKISOIbNgqFYGufW32Nhr9dvcSLKgJZEHwAh+so6XaDVhVvhyD444y6YThkdjRsnEoanqA/QLBCqb+jNVUFvnbletIeHD8Py1z1+cDimHj6sTTDYyhi1i3x/iKa83nArZLiMvrIZ9mus13ehEWfrDsevO3qZRlUrOfRfHwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863791; c=relaxed/simple;
	bh=MdsLcF4ZQMt/MS0Dm0DIiQTXi6dAwWtQVyb0i0HAvWc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bVQYZONuPfCOmXb8x9FsntfEOzN50IoliFwKC1OQwx+zoh+8i5/iXV0nQNWCb5EAihsHfesBvjEqixR2xI0grAg5FtieKd5eZ0ipeBiCabRjOU99Dh6duZ5+PHkx2VmIk2LCz6rdXcp1257eDur7NUKCSmZ9BqCBL/70avydtCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=bWEQyAWb; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="bWEQyAWb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778863782; x=1779468582; i=l.s.r@web.de;
	bh=fXuiV8XsqU5jTwNliireb0zj/H7b1ClaSltVi4JsVXs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bWEQyAWbT5HA6gS9e5JBqROzaQv+XBvnP8d5u+h4Wcqoyh+DgiuDyps133R3f6Gn
	 ZzvGNxL7XE3GjBhL294GFdz5RlIt3HCk/Nywl8HHJ1spG8Or+WqeocpdPlw52aoPX
	 FSn1edNcTvqxCV5TXUOBn05BmRr/UVCiYSn5/851+BrFcyWwK+I8Y/3itYChhngpv
	 tW2F+0drQjOKQA8eUWUHJoBmnG7ds67OhFafUQDD68AybnIk7haBVZ3Eu3rp7ZYQi
	 Bli7kPgzCDE4n28csgOiZoCIzK67elcmCtdJrPWiglohZL+soz2j+ULjP5W6OPKWm
	 xI6CBX3kVqSMYWT+MQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0qr9-1xHplw4AJp-014FCX; Fri, 15
 May 2026 18:49:42 +0200
Message-ID: <bcd974c5-3748-442f-9f5c-5b05888e0bc8@web.de>
Date: Fri, 15 May 2026 18:49:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] use __builtin_add_overflow() in st_add() with Clang
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
 <0ded6062-f66a-4713-af24-d1b5aa654823@web.de> <xmqqjyt5g5zr.fsf@gitster.g>
 <fceded1f-60a2-48d2-91fc-5d2161272868@web.de>
Content-Language: en-US
In-Reply-To: <fceded1f-60a2-48d2-91fc-5d2161272868@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zH+JLImo7+xPcS5+V0HuT9BW2p/ES81HFrMLfmP+CcpLULz10H9
 vfksq7yB9WFKEh14e1Oj+5Q/2orgt5qbOyXAONp1gHZmAKK0sZeNK/+0DfHdkTMb7DnGhas
 isr7I6WIhHLapb8ELFJKCppF2QhmsZbu6cGEgJdFVbLLCzxVTs9YQO9w9y6OY2CaVEy+cWP
 BoXcXNr2hLOE5aIdg80kA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:htjZ7/iQf1s=;vFB4u+KgpHYY8ck9scoxYwtUepd
 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

On 5/14/26 10:17 PM, Ren=C3=83=C2=A9 Scharfe wrote:
> On 5/14/26 9:12 PM, Junio C Hamano wrote:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> Provide a variant of st_add() that wraps __builtin_add_overflow() to
>>> help Clang optimize it.  Use it on all platforms for simplicity.
>>> ...
>>> +/* Help Clang; GCC generates the same code for both variants. */
>>> +#if defined(__clang__)
>>> +static inline size_t st_add(size_t a, size_t b)
>>> +{
>>> +	size_t sum;
>>> +	if (__builtin_add_overflow(a, b, &sum))
>>> +		die("size_t overflow: %"PRIuMAX" + %"PRIuMAX,
>>> +		    (uintmax_t)a, (uintmax_t)b);
>>> +	return sum;
>>> +}
>>> +#else
>>>  static inline size_t st_add(size_t a, size_t b)
>>>  {
>>>  	if (unsigned_add_overflows(a, b))
>>> @@ -621,6 +632,7 @@ static inline size_t st_add(size_t a, size_t b)
>>>  		    (uintmax_t)a, (uintmax_t)b);
>>>  	return a + b;
>>>  }
>>> +#endif
>>
>> Makes me wonder if we tweaked unsigned_add_overflows() to take an
>> extra *dst parameter to match __builtin_add_overflow(), which of
>> course requires us to all of 18 callsites, it might make the whole
>> thing a bit simpler.  New uses of unsigned_add_overflows(), if we
>> ever add them, would automatically benefit, right?
>=20
> Hmm.  It sounds like a lot of churn, but it would make sure that
> we use the checked result and not check a + b and then go on and
> use x + y because the code de-synced at some point.
>=20
> How to do it, though?  It needs to be generic and evaluate its
> arguments only once.  Perhaps like this?
>=20
>=20
> diff --git a/git-compat-util.h b/git-compat-util.h
> index ca89cfb0b3..27fbb622d7 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -103,6 +103,21 @@ struct strbuf;
>  #define unsigned_add_overflows(a, b) \
>      ((b) > maximum_unsigned_value_of_type(a) - (a))
> =20
> +static bool uint_add_overflow(uintmax_t a, uintmax_t b,
> +			      uintmax_t *out, size_t out_size)
> +{
> +	if (b > UINTMAX_MAX - a)
> +		return true;
> +	a +=3D b;
> +	if (a > (UINTMAX_MAX >> (bitsizeof(uintmax_t) - CHAR_BIT * out_size)))
> +		return true;
> +	*out =3D a;
> +	return false;
> +}
> +
> +#define UINT_ADD_OVERFLOW(a, b, out) \
> +	uint_add_overflow((a), (b), (out), sizeof(a))
> +
>  /*
>   * Returns true if the multiplication of "a" and "b" will
>   * overflow. The types of "a" and "b" must match and must be unsigned.
> @@ -616,10 +631,11 @@ int git_open_cloexec(const char *name, int flags);
> =20
>  static inline size_t st_add(size_t a, size_t b)
>  {
> -	if (unsigned_add_overflows(a, b))
> +	size_t ret;
> +	if (UINT_ADD_OVERFLOW(a, b, &ret))

Type mismatch of third argument: pointer to size_t given, pointer to
uintmax_t expected.

>  		die("size_t overflow: %"PRIuMAX" + %"PRIuMAX,
>  		    (uintmax_t)a, (uintmax_t)b);
> -	return a + b;
> +	return ret;
>  }
>  #define st_add3(a,b,c)   st_add(st_add((a),(b)),(c))
>  #define st_add4(a,b,c,d) st_add(st_add3((a),(b),(c)),(d))
Perhaps like this instead?


diff --git a/git-compat-util.h b/git-compat-util.h
index ae1bdc90a4..23ea42f373 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -103,6 +103,25 @@ struct strbuf;
 #define unsigned_add_overflows(a, b) \
     ((b) > maximum_unsigned_value_of_type(a) - (a))
=20
+static inline uintmax_t uint_add_overflow(uintmax_t a, uintmax_t b,
+					  uintmax_t max, bool *overflow)
+{
+	*overflow =3D a > max || b > max - a;
+	return a + b;
+}
+
+#ifdef __clang__
+#define UINT_ADD_OVERFLOW(a, b, out, overflow) \
+	(*(overflow) =3D __builtin_add_overflow((a), (b), (out)))
+#else
+#define UINT_ADD_OVERFLOW(a, b, out, overflow) ( \
+	*(out) =3D uint_add_overflow((a), (b), \
+				   maximum_unsigned_value_of_type(*(out)), \
+				   (overflow)), \
+	*(overflow) \
+)
+#endif
+
 /*
  * Returns true if the multiplication of "a" and "b" will
  * overflow. The types of "a" and "b" must match and must be unsigned.
@@ -616,10 +635,12 @@ int git_open_cloexec(const char *name, int flags);
=20
 static inline size_t st_add(size_t a, size_t b)
 {
-	if (unsigned_add_overflows(a, b))
+	bool overflow;
+	size_t ret;
+	if (UINT_ADD_OVERFLOW(a, b, &ret, &overflow))
 		die("size_t overflow: %"PRIuMAX" + %"PRIuMAX,
 		    (uintmax_t)a, (uintmax_t)b);
-	return a + b;
+	return ret;
 }
 #define st_add3(a,b,c)   st_add(st_add((a),(b)),(c))
 #define st_add4(a,b,c,d) st_add(st_add3((a),(b),(c)),(d))

