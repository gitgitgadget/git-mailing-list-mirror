Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA6D142E7A
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597797; cv=none; b=f05CUKizFckzXo5Ih6eFI8auSmQA+pJczquXCm8XlBnLtYY55LOVrm1yoKpYPI8t47Z3sEkRtusKT6flkfhqVLf8AKhKOakKZtqVlhdsJGFvyPFqyGIJn8DSRSOva4qyt2mVQM8zrDBjQpmgBUryuutFGW1blC6fonRPkxTaP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597797; c=relaxed/simple;
	bh=TvMtypQgdjjZkuk6+qx73knD+Vcw2rH7edN+T7m6abM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G08s/Efrr9Sz/xQU2uIrzaUo6hgHf72lUAWyKkJzYO6GaA+iQQppA05GoRvCaQ9mQtQBxUnizhMTWnS7KF4OurNm/58uzYtFPe8IRrixypGHa40J7+qIixIvmdiibi/q2jugok5leSbt8IAtcB+GChXbXmhAbk5J/6GjFYffwZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RV6PJB1n; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RV6PJB1n"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 51DC61E457;
	Mon,  8 Apr 2024 13:36:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TvMtypQgdjjZ
	kuk6+qx73knD+Vcw2rH7edN+T7m6abM=; b=RV6PJB1nZ7lkfkdvZ++Lr7C1DfgB
	XGHX6A1zPXhlby31C6np6V98eqC9ilfN4viSyLDMUMsH5pOQL9x047N8UkOUgg9X
	fQQ9jRptKcQy1pmyrPeMHlm5z7ZnSJLjSb5YcreNzRYQfB/Vq/Hc4VQg4771TAm7
	eCZTxJkB4RQqe0k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B72E1E456;
	Mon,  8 Apr 2024 13:36:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CBDF51E455;
	Mon,  8 Apr 2024 13:36:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] fix a leak with excludes_file
In-Reply-To: <1323321b-554e-4b16-a814-03710c50db99@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 7 Apr 2024 19:48:48 +0200")
References: <f4af1e88-5bd9-4b3c-8691-84dbf0ca3ee2@gmail.com>
	<xmqq7chajs3e.fsf@gitster.g>
	<1323321b-554e-4b16-a814-03710c50db99@gmail.com>
Date: Mon, 08 Apr 2024 10:36:30 -0700
Message-ID: <xmqqy19nbvtt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 89C46060-F5CE-11EE-BBDA-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> It does not have to be like that.  We may no longer need the current
> and problematic git_config_pathname().  However I did not want to go
> that far in this series.

True, but that one and only true interface we will end up with MUST
NOT be strbuf based one, and that is why I said the patch as posted
will not take us into a better future.

And as a stop-gap measure, ...

>> -	if (!strcmp(var, "core.excludesfile"))
>> +	if (!strcmp(var, "core.excludesfile")) {
>> +		free((char *)excludes_file);
>
> Aaah, you prefer this :-( ...  this free is what I was referring to, in
> the message you are replying to, as the simpler fix ...

... obviously this would be much more preferrable.  And when the one
and only true interface comes, we only need to drop the cast from
around here.

Thanks.
