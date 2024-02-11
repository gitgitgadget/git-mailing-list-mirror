Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3785C916
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707674154; cv=none; b=JngmOS8BD8L7uvdYnrpnqEzlemWmoarlSeI1PLdiY64+SEU55Euc+gjr4yD9s6XuFv83jkzNYcM/uQt9/5Nn4+vmZxEtqvfcqUP21CShc96FlwiYHPr4Z8iJuo2q6l/U8N29iB2lirQ6BGEU1/qeiBMDT/0K8v1pbBI6wCqWQDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707674154; c=relaxed/simple;
	bh=Ugq2iQBF0v1OcTzGKKEzQPEQuk16zRpKMwZ/pvvhj2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jpxx836pTqFs+5eTSFaeH9g6IeGBN2NS4qRvHDgf1WPcMr8WU6XghG/ftczQqD0F0hVk+bT4py3FsFoPKG2GMKSxW4RzBOUqqKHjCF8643xtD2EBuUSlGWDQawuZdcUPcIS26HxaPhtV82B5F9gbBzGCa1bjG1g1Cpk+/v+KtpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=d7joA3hu; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d7joA3hu"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 44F9D1D5E1E;
	Sun, 11 Feb 2024 12:55:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ugq2iQBF0v1O
	cTzGKKEzQPEQuk16zRpKMwZ/pvvhj2Y=; b=d7joA3huk4y5oNSPWRmtW9axfhCU
	Ftabst8lXVRpYkJRUfrCfVKdG+/r3ibds9czo99t5WoKIh4vjJLtQir74t5ZCxFR
	GCrxFr0y5VNqiiC7Th5TEe+m1LXEpwAwRRK80ZW+e6IdV+O2w0NQhFcaAVEKoVk2
	F3rcYz8CeVonEdQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 397FB1D5E1D;
	Sun, 11 Feb 2024 12:55:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F1491D5E1C;
	Sun, 11 Feb 2024 12:55:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Chris Torek" <chris.torek@gmail.com>,  git@vger.kernel.org,  "Tiago
 Pascoal" <tiago@pascoal.net>
Subject: Re: [PATCH] column: disallow negative padding
In-Reply-To: <9c00311d-e31c-428b-9c66-fef7ac8bfc76@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sun, 11 Feb 2024 18:10:26 +0100")
References: <AS8P189MB21977ACC4866D9836DA29082BC4B2@AS8P189MB2197.EURP189.PROD.OUTLOOK.COM>
	<76688ed2cc20031d70823d9f5d214f42b3bd1409.1707501064.git.code@khaugsbakk.name>
	<19119aa6-9a8c-44c6-af79-0ea6a8bcb181@app.fastmail.com>
	<CAPx1GvdDvmBmvoktd7onB4mSzikKf4eWVWnrzrn8c8Y1RcRgsA@mail.gmail.com>
	<9c00311d-e31c-428b-9c66-fef7ac8bfc76@app.fastmail.com>
Date: Sun, 11 Feb 2024 09:55:49 -0800
Message-ID: <xmqqle7q997e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 CAEE316E-C906-11EE-9DA2-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Sat, Feb 10, 2024, at 10:48, Chris Torek wrote:
>> On Sat, Feb 10, 2024 at 1:46=E2=80=AFAM Kristoffer Haugsbakk
>> <code@khaugsbakk.name> wrote:
>>> I forgot tests.
>>
>> You presumably also wanted the `_` here for gettext-ing:
>>
>>> +               die("%s: argument must be a non-negative integer", "p=
adding");
>>
>> Chris
>
> Yeah, thanks. You probably saved me a v3. :)
>
> Although I failed to notice that the string I stole was just a plain
> string, not a translation string. And apparently there are no generic
> =E2=80=9Cnon-negative=E2=80=9D translation strings. So I=E2=80=99ll jus=
t make a new one.

The last time I took a look, I thought there were more than just the
single entry point you patched that can feed negative padding into
the machinery?  Don't you need to cover them as well?

Thanks.
