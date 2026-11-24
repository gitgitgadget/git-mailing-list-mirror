Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795514001;
	b=XIvlEPC2PGglIVruF5hrqicM4szgWgvgtFin8iRqwKiiv2rPgKgchTNler9y+ALHILP4
	 ELhCaOb+kqe+xOmG4p3t9eItAAdColtd4hV4d2KV6p9QShVAI8KqnKn86MckLArAp8MO3
	 73t2mRrKzbF6JGqqYH4CUW6YQk+CKeiyjehhvAKdvg/7zo32hFbtMW6AYt5Yh4+fAxDkQ
	 kqoBZECqtbhynxs7+r84pQT85ffuDr6l9+T8ad03AtO2R+zJDHZ4oOdYCqvB57wtMaZAi
	 vMjpFWN5lLb1LsJXwCanHQeEc6uo2URV3eyKJjA2SWltIYrFVYswMhHqxD7BNQ9eYsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514001;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=hSK0u1FKGt6YArw5FmTnDqPWE54bKIabL16KNrFxlmI=;
	b=oBAhaJ/iy+OgllyotqVOJj2t/KljITCi7jCuKTAfhQZhB+jtMwuczrOKah6QPw9IZN81
	 vnO7AcY48Y6HqtM7JEisLyd/jfmzqd7jbl/jeShA/CxH87TnVDsF32vb9t6yV/G0xZtcx
	 O4HamWA2su3MynMBmV1/cFWtAeGPwI1wYVhMkkCB/7Ltj8Teui87om7MIxTcxtOk99AoU
	 VN05c6fn+K2ofkRunS1/L/Zy1JCVXjVWE4Ikog2RYbEnvqTZKwh5Jol4tqlNCPZt/4FvT
	 uNqTlMRFMzddn0w3OpK6XFavMQXCZKI3gUll6wqEhETMlDiJEHSIZVBNV5PLaW5TI6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b="Dm/P5rHy";
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33268606A685
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 09:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33268606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=Dm/P5rHy
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AO9r6La2373660
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 24 Nov 2026 10:53:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795513986; bh=hSK0u1FKGt6YArw5FmTnDqPWE54bKIabL16KNrFxlmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Dm/P5rHyQN5AXDkbDopqeI0gFDfOCfiIuZt/4fq+hFiWjz+eROGL1UUHtUDaXjepi
	 YSFeOpOuvm2M5BRY4+qJ0mqWUFm1NNf3ZnoqzZGX0UMPFnBXd3DOxlSOohxMF3fLTb
	 8hAjtId19PE2+6fjkdN3yLLQr8l5oiqRJSBLK5LI=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
        "Junio C Hamano <gitster@pobox.com>, Andy Koppe"
 <andy.koppe@gmail.com>
Subject: Re: [PATCH v5 3/4] utf8: respect string boundaries after skipping
 ANSI escape sequences
In-Reply-To: <xmqq1p8ba395.fsf@gitster.g>
References: <20261122-master-v5-0-313bd1bb3c45@gouders.net>
	<20261122-master-v5-3-313bd1bb3c45@gouders.net>
	<xmqq1p8ba395.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 24 Nov 2026 10:53:00 +0100
Message-ID: <ghmrqyimir.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 23 2026, Junio C Hamano wrote:

> Dirk Gouders <dirk@gouders.net> writes:
>
>> utf8_strnwidth() can skip ANSI escape sequences and it is possible
>> that such sequences end the string within the given boundary.
>>
>> Check for such situations before proceeding and calling utf8_width().
>>
>> Add tests that test such corner cases.
>
> It would become clearer if the above described externally observable
> symptom and the condition to trigger it.
>
> "such sequences end the string within the given boundary" is slightly
> imprecise, isn't it?  IIUC, the problem is that an escape sequence
> reaching orig + len would cause utf8_width() to read past len, which
> leads it to count extra columns or reading out-of-bounds memory.

Yes, even for the one who observed this it can be difficult to
reconstruct the needed imaginary after a few days.

I will try to provide an example.

> The code change looks correct, though ;-)
>
>> diff --git a/t/unit-tests/u-utf8-width.c b/t/unit-tests/u-utf8-width.c
>> index 86e09c3574..5e2b636db9 100644
>> --- a/t/unit-tests/u-utf8-width.c
>> +++ b/t/unit-tests/u-utf8-width.c
>> @@ -2,6 +2,17 @@
>>  #include "utf8.h"
>>  #include "strbuf.h"
>>  
>> +/*
>> + * Test utf8_strnwidth for strings with SGR sequences and corner case length
>> + * arguments.
>> + */
>> +void test_utf8_width__strnwidth_ansi(void)
>> +{
>> +	cl_assert_equal_i(3, utf8_strnwidth("\033[31mhello", 4, 1));
>> +	cl_assert_equal_i(0, utf8_strnwidth("\033[31mhello", 5, 1));
>> +	cl_assert_equal_i(1, utf8_strnwidth("\033[31mhello", 6, 1));
>> +}
>
> These are OK to be equal_i() for now, but I notice a TODO at the bottom
> of utf8_strnwidth().  It might be helpful to leave a comment to warn
> that this test needs to be updated when it happens?

Ok, I will leave a similar comment.

I also noticed the comment and started an .org file to note what the
callers (and theirs ...) do with the return values and what changes are
needed.  In quite some case those int's end as widths specifiers in
format strings and I concluded I'd better stay away from this task.

>> diff --git a/utf8.c b/utf8.c
>> index 009e8fee39..dfc5261619 100644
>> --- a/utf8.c
>> +++ b/utf8.c
>> @@ -230,10 +230,14 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>>  		int glyph_width;
>>  		size_t skip;
>>  
>> -		while (skip_ansi &&
>> -		       (skip = display_mode_esc_sequence_len_counted(string,
>> -							orig + len - string)) != 0)
>> -			string += skip;
>> +		if (skip_ansi) {
>> +			while ((skip = display_mode_esc_sequence_len_counted(string,
>> +					                orig + len - string)))
>> +				string += skip;
>> +
>> +			if (string >= orig + len)
>> +				break;
>> +		}
>
> Thanks.
