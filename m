Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF0519D063
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109793; cv=none; b=Wu+nKMV95C0NzBECWRKBNbM7g8sN7EvHaYpbTgz7TXvzym7LpqtcYYvuH2YS5pHjzXjodXE2gd1XXakCJf9ZLlhczs2bxTFwb5JFfnw5o3eVJEuKty5jAxBUR0guUFJygkc58rzB+lf4uZcmjH7IoObzri+es925xxJ2KKqZFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109793; c=relaxed/simple;
	bh=2COGd49lmzt97i7/rYn4dG8izKp7ZaZvFLAd/qJC2w8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jEbAXfzmiC6DZKDdGEPcaIQcEdgO0gPNuy99zoJz0OsV18hMQtaZU4MtLrel7nBiSv0wrXsmN8W8a/9J+nDuBgu6xEI3STH/vS4Djo9WqV73hN1JepAm8rKS+J0eF79oWtJM9LwxGNsSGi9LEiAPLS9jPRhfMD149HVi5NYF0fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pX6KecDG; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pX6KecDG"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EDBE121FFF;
	Mon, 23 Sep 2024 12:43:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2COGd49lmzt9
	7i7/rYn4dG8izKp7ZaZvFLAd/qJC2w8=; b=pX6KecDGLg32LRkRm4kEBghvJkbT
	1acmKJuIZh7by3JCMsU5WUQffkygIpTtsCRIMl9Ys478D7GjPezuD6JBfNSyJMeV
	R72i55x/PtOk6U69nradtthPazNGHZmxkVa/PcMIupwU9uQDv30X343tpdoTzTRW
	SCHbaimP+SZRtnk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E521E21FFE;
	Mon, 23 Sep 2024 12:43:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5675A21FFD;
	Mon, 23 Sep 2024 12:43:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Ruffalo Lavoisier" <ruffalolavoisier@gmail.com>,  "Stephan Beyer"
 <s-beyer@gmx.net>,  "Jeff King" <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH] am: fix condition check on fseek
In-Reply-To: <7601dcef-e256-4e20-bbd4-75955e5a45d5@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sat, 21 Sep 2024 21:52:50 +0200")
References: <20240921150855.31574-1-RuffaloLavoisier@gmail.com>
	<7601dcef-e256-4e20-bbd4-75955e5a45d5@app.fastmail.com>
Date: Mon, 23 Sep 2024 09:43:09 -0700
Message-ID: <xmqqcyku48yq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 EAEFBA80-79CA-11EF-9532-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Sat, Sep 21, 2024, at 17:08, Ruffalo Lavoisier wrote:
>> if fseek() is success, return value is 0
>>
>> Signed-off-by: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
>> ---
>>  builtin/am.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/am.c b/builtin/am.c
>> index d8875ad402..a7727fd4ea 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -589,7 +589,7 @@ static int is_mail(FILE *fp)
>>  	regex_t regex;
>>  	int ret =3D 1;
>>
>> -	if (fseek(fp, 0L, SEEK_SET))
>> +	if (!fseek(fp, 0L, SEEK_SET))
>>  		die_errno(_("fseek failed"));
>>
>>  	if (regcomp(&regex, header_regex, REG_NOSUB | REG_EXTENDED))
>> --
>> 2.46.1
>
> I don=E2=80=99t get this change? The function returns false on success.=
 true if
> it fails (not zero). You want the program to die if it returns non-zero=
.
>
> It=E2=80=99s hard to wrap my head around=E2=80=A6 =E2=80=9Cfalse must m=
ean =E2=80=9Cno errors=E2=80=9D =E2=80=9D
>
> If the original code has a bug then I don=E2=80=99t see how git-am(1) c=
ould work
> considering it presumably always checks =E2=80=98is_mail=E2=80=99.

Yeah, the proposed log message states a correct fact, but it is
unclear how that justifies the change in the patch part of the
message.
