Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68C717BCD
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 23:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721692635; cv=none; b=bjshUifuj/BQSR8kJn+J+9OEMmz4tLNbR2EmmNCtmOdTh7O8YCggba4zEimhNIdid3Ar1qgNKtjkEDDupM1DZKnaezFaVUG8EbAFKKEradAaXrQh3jt0wr6AB/eBkhBtkT3XIerKwQL6QB6zPq1rXyMa+5iMsbAhdYvfdCRZd5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721692635; c=relaxed/simple;
	bh=K2mbitRa3vf8HfWEm4Nt+ZzQddSqZLRahbZzDvJDw9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VzE2KRWkN4bpftG5dxHSX++gQef7li5E9ZDpxIwck9x3znNvCwo4msIb73tbTEy0b0YvuLGaoxCAO2D7cKudiMzD4wnHYBODQcRNvU44csVEwU6IZ4EIDn8rgwXNLOVvus1/Gc4feQ9bdmJZqs/nD1GTCVoAfVDX1ZnTUE+QvZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aK0WhHkP; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aK0WhHkP"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 59C932728D;
	Mon, 22 Jul 2024 19:57:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=K2mbitRa3vf8
	HfWEm4Nt+ZzQddSqZLRahbZzDvJDw9c=; b=aK0WhHkP16rqPBzY2kWyX+Gok40a
	g1rDsai+gC3PZLjfE8ez4vBpupjxSN/oTAQMSAiikE8pFr3uFDg+unVXq6nc276e
	y5QrI2bnOrhYWpgbC55MOn6JMfHaBYVnaG7OVMqR7wcC7iYuc1780kRLno8O+Oc5
	gvT52HuxQtfGhFk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 516282728C;
	Mon, 22 Jul 2024 19:57:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A881727289;
	Mon, 22 Jul 2024 19:57:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Git List <git@vger.kernel.org>,  Dragan
 Simic <dsimic@manjaro.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t3701: avoid one-shot export for shell functions
In-Reply-To: <xmqqsew16lg9.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	22 Jul 2024 16:44:38 -0700")
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
	<ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
	<efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
	<1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com>
	<xmqqttgqyzwa.fsf@gitster.g>
	<2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
	<88f9256e-04ba-4799-8048-406863054106@gmail.com>
	<a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com>
	<xmqqv80xcpe5.fsf@gitster.g>
	<079901fe-7889-4e1f-bb91-610e1eae25d3@gmail.com>
	<xmqq7cdd9l0m.fsf@gitster.g>
	<43e045e5-4c92-4c5f-b183-d63c5b510023@gmail.com>
	<5536b336-5122-47fd-be57-42c299abe60c@gmail.com>
	<xmqqsew16lg9.fsf@gitster.g>
Date: Mon, 22 Jul 2024 16:57:07 -0700
Message-ID: <xmqqa5i96kvg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 1AF81B12-4886-11EF-ACA1-9625FCCAB05B-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Rub=C3=A9n Justo <rjusto@gmail.com> writes:
>
>> The common construct:
>>
>>     VAR=3DVAL command args
>>
>> it's a common way to define one-shot variables within the scope of
>> executing a "command".
>
> "it's a" -> "is a".
> "define" -> "set and export".
>
>> However, when "command" is a function which in turn executes the
>> "command", the behavior varies depending on the shell:
>>
>>  ** Bash 5.2.21 **
>>
>>     $ f () { bash -c 'echo A=3D$A'; }
>>     $ A=3D1 f
>>     A=3D1
>>
>>  ** dash 0.5.12-9 **
>>
>>     $ f () { bash -c 'echo A=3D$A'; }
>>     $ A=3D1 f
>>     A=3D1
>>
>>  ** dash 0.5.10.2-6 **
>>
>>     $ f () { bash -c 'echo A=3D$A'; }
>>     $ A=3D1 f
>>     A=3D

Another thing.  Let's insert a paragraph perhaps like this here.

    Note that POSIX explicitly says the effect of this construct
    used on a shell function is unspecified.

>> One of our CI jobs on GitHub Actions uses Ubuntu 20.04 running dash
>> 0.5.10.2-6, so we failed the test t3701:51;  the "git add -p" being
>> tested did not get our custom GIT_PAGER, which broke the test.
>>
>> Work it around by explicitly exporting the variable in a subshell.

That way, we won't give a wrong impression that we can safely start
using the construct in future once dash 0.5.10.2-6 goes away.

