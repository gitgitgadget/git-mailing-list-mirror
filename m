Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477A2259C
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441481; cv=none; b=lxbtSdp47hHGSxz5JPoxpWUzNtdYvlMKxxjKZaXtLPr5F65/uqLzoKoYRF8d/riDLO/rf6EMNSaXHOgeQeKdGmk9GjYmYa04c4KvW/Bfm46SrGzza2GURROC8iNPDrL/0+WEcuIxx890guSMDJ9ZMzt6Zq6Te0b0hL8MaPAXOlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441481; c=relaxed/simple;
	bh=AHKR2E81gg1EPoCkxyOiztINkPUnTd7psg6vNEJW278=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jC50cqgf89JcuMEOaCMS6ZH0umSAdJsGyL0Vy4gphlu1MALorhSokk0XVcAmxdfrPin22HbORwb0RP8B9hCtIcuHCDdU1HXBOQoxLFTDMdSqxtkVafj/Hx1jEVhutTi13mLvTyvsX9ML7XOPzilbVTRvyd9eN+XcP7bL34+FQUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y6hd0DKw; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y6hd0DKw"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 234E52D782;
	Mon,  3 Jun 2024 15:04:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AHKR2E81gg1E
	PoCkxyOiztINkPUnTd7psg6vNEJW278=; b=Y6hd0DKwPjCkbV2ziLOzTWbMC9p+
	0SSSsY/xM6n8M89jJ59g8Iz+V5CwDJoij1gTuSxe/IBYXEhW+00mAv6PA4CA5qh4
	1oAnkrnAhxMYj5Xqegrnguy/CN/ihsi3xAsneC8G9HMaOfvUuTL8NR0A5MIfEL3D
	64YkbWOV/Aq/w6A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1AB592D781;
	Mon,  3 Jun 2024 15:04:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D2952D780;
	Mon,  3 Jun 2024 15:04:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 15/27] compat/win32: fix const-correctness with
 string constants
In-Reply-To: <CAPig+cTC83ZE2kGy=epeRFJ7a3jjRQXsvUYzB6jdOYfmy0yVOg@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 3 Jun 2024 12:57:45 -0400")
References: <cover.1716983704.git.ps@pks.im> <cover.1717402403.git.ps@pks.im>
	<3d92528125ee419aefdac790dc1a4106be632c60.1717402403.git.ps@pks.im>
	<CAPig+cTC83ZE2kGy=epeRFJ7a3jjRQXsvUYzB6jdOYfmy0yVOg@mail.gmail.com>
Date: Mon, 03 Jun 2024 12:04:37 -0700
Message-ID: <xmqq4ja93l16.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 2002535A-21DC-11EF-895A-6488940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Jun 3, 2024 at 5:46=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
>> Adjust various places in our Win32 compatibility layer where we are no=
t
>> assigning string constants to `const char *` variables.
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>> diff --git a/compat/basename.c b/compat/basename.c
>> @@ -1,6 +1,8 @@
>> +static char current_directory[] =3D ".";
>> @@ -10,7 +12,13 @@ char *gitbasename (char *path)
>>         if (!path || !*path)
>> -               return ".";
>> +               /*
>> +                * basename(3P) is mis-specified because it returns a
>> +                * non-constant pointer even though it is specified to=
 return a
>> +                * pointer to internal memory at times. The cast is a =
result of
>> +                * that.
>> +                */
>> +               return (char *) "";
>
> The change from returning "." to returning "" is unexplained by the
> commit message. Did you mean to return the newly-introduced
> `current_directory` instead?

I suspect that these places wanted to return (char *) "." instead,
without introducing a new variable.



