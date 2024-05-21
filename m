Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8D2148820
	for <git@vger.kernel.org>; Tue, 21 May 2024 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325047; cv=none; b=NwTYNti+lnyLK+aBJ0jSTyPaJMC3SmzIWtZ6YqPJvgWnNAQlcRmvXiUV1tdD0GtZBzh250F901Tls/YRBdW5KWrf6Ytsy122X/eJxpPDcCga8YrpAbT5/4E5Lq41KIa8rWWQ2ibRB60jPJ2yE+8IneBBMzPcEqR0KoRdPobcM/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325047; c=relaxed/simple;
	bh=jeN5N6RnetE+lFdQKcMi2//R8dAtnwVHWTZG7Oqv6nQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FG0+hAjwDgRsYE2/pyvteISe1S5O5iIZ3YfAUn1Sy1rrwQTZJOI28RHy+o3gp9Fc2So9/QN1YgfN6A+o6fns8OSqSVdc+5KuAiAjX6EqrqLI2eHSKxAODFWLLwThUYi0rqYcZ4iwFY8ovE9t7OPZPuqBvJu8Z9vmKueGaI6zo1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hP7NzEI1; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hP7NzEI1"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 79A072E234;
	Tue, 21 May 2024 16:57:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jeN5N6RnetE+
	lFdQKcMi2//R8dAtnwVHWTZG7Oqv6nQ=; b=hP7NzEI1Zgb64jMfh66gNiC/9Cgf
	VS9jdqoKyaK7hZ+Qgvd4iGQ4oYUZUcBEbfGxXM/uBR0iDOFRgy7SkQo8eTAQv5Ys
	o6YHh4F6JgJO2wlfKJnKwPrm+S6n/fwSNt8CVeZxUPYDElBVYjOZYgT0rsN16ujP
	D21v/pQd8FvZrtk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 721022E233;
	Tue, 21 May 2024 16:57:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6EDEF2E231;
	Tue, 21 May 2024 16:57:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/5] pager: do not close fd 2 unnecessarily
In-Reply-To: <a9f199d8-bb06-479f-88c2-63d80338a4e9@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 21 May 2024 00:33:46 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<80f15223-246e-4cfb-a139-e47af829c938@gmail.com>
	<xmqqo790fg8z.fsf@gitster.g>
	<a9f199d8-bb06-479f-88c2-63d80338a4e9@gmail.com>
Date: Tue, 21 May 2024 13:57:19 -0700
Message-ID: <xmqqwmnm993k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 B7A9EBA0-17B4-11EF-95C3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> >  static struct child_process pager_process;
>> >  static const char *pager_program;
>> > +static int old_fd2 =3D -1;
>>=20
>> What does the magic number "-1" mean?
>
> Invalid fd.
>
>> We often use it to signal
>> "uninitialized", but then what are concrete "initialized" values
>> mean?  "We dup2()'ed something else to stderr/fd #2 but before doing
>> so we saved the original fd #2 away to this variable, so that we can
>> restore fd #2 by another dup2() of the value of this variable when
>> we declare that we are done with the standard error stream"?
>>=20
>> But that does not look like what is happening here.
>>  ....
>> Equally unclear magic number "1" is used here.
>>=20
>> This value is different from pager_process.in, and my earlier "we
>> are saving away" does not apply, either.
>
> It applies, in 3/5.

We need to be prepared to see a series chomped at an early stage and
it should still make sense.  If the series does not make sense when
you stop before applying patch 3, it is a strong sign that this step
and the next step can be separated and structured better.

Or perhaps if they are made into a single patch it makes more sense
and becomes easier to explain?

