Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC61859167
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718917413; cv=none; b=GE7coUcaBslJX8glbec1Bcy0qTXov81TakRrNeoVg4YhhfyXvSxTajwpDWbQxXdy1G0/uhPO806ulPRAbpGfVFMuQ7vT55Na4z6x3PYKcoKQuxXGEC2k9W/+qAW9Vid65NugXrwdUj0VNABhzT3OCBP4/jPkhI0vAb482cZ61hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718917413; c=relaxed/simple;
	bh=fxMaWrMXE0Lrnz5wxgcxh5EVvVesLU9/qmd6tNrzQGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H97wRxc/M9LCGxZeFE+pMyilXcIyq1uQcODE0TvFg9Fn5WeEFvhXtgFPKbb2eI5cDij7olIPfePs3uOmA1p1JxgRXOqfhca8oJNLUtP9ciQPmT3/wd4r+8OwdiW4Lot6tM5SSxiMcvqdY9ulw08UOMdCVoQvzIVsGxsNGLksi8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kg2htk5l; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kg2htk5l"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 34A8C1AA9B;
	Thu, 20 Jun 2024 17:03:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fxMaWrMXE0Lr
	nz5wxgcxh5EVvVesLU9/qmd6tNrzQGU=; b=kg2htk5lHZH5rDARN3OtTbKejemQ
	wWqih/GOB2ApHZ/4ZPoQTRwp2VjNmgpr77f5vb6z6OuwJAzPHKzhom6g/3XrvYac
	Y2SkxK9Weruey1gW2YfWdOjK8V5gTvQL8z6/GXzzmQxejtZGsMaEjA9ID5+hJn0P
	hOV1fVxrFlhtqd8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2AAC51AA9A;
	Thu, 20 Jun 2024 17:03:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B7241AA99;
	Thu, 20 Jun 2024 17:03:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Jeff King <peff@peff.net>,  Johannes
 Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] pager: die when paging to non-existing command
In-Reply-To: <73b9a923-c3d6-46e8-b050-e8a93b9757a2@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Thu, 20 Jun 2024 22:22:30 +0200")
References: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>
	<xmqqsex7tp0c.fsf@gitster.g>
	<73b9a923-c3d6-46e8-b050-e8a93b9757a2@gmail.com>
Date: Thu, 20 Jun 2024 14:03:26 -0700
Message-ID: <xmqq34p7tjhd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8A519742-2F48-11EF-AC7B-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> On Thu, Jun 20, 2024 at 12:04:03PM -0700, Junio C Hamano wrote:
>
>> > +		die("unable to start the pager: '%s'", pager);
>>=20
>> If this error string is not used elsewhere, it probably is a good
>> idea to "revert" to the original error message lost by ea27a18c,
>> which was:
>>=20
>> 		die("unable to execute pager '%s'", pager);
>
> Makes sense.  Let me know if you need me to reroll.
>
>> Just in case there is a reason why we should instead silently return
>> on MinGW, I'll Cc the author of bfdd9ffd, though.
>
> Yup.  I did notice the MINGW conditions in t7006 but, to be honest, I
> hadn't thought about this.  Thank you for considering it and seeking
> confirmation.

After these questions are answered satisfactory, can you send an
updated version to conclude the topic?

Thanks.
