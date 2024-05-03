Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF2315667A
	for <git@vger.kernel.org>; Fri,  3 May 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751019; cv=none; b=NGsqMyY66sAp9/Yw2TXVIo2iczLUcEB+0ybgx8juPIyaqsRu2TxvnQi1C+UvlTI3JqwuuVZ9kP14goq1UuHvXNiXQV+Ko8wTprakUpqv/s54VyT2HqCXV9Fwv6dZ9ifxcArM34p8ui4dEHWBf7IMszDToGY5IuLnIe2jna1u7X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751019; c=relaxed/simple;
	bh=UexbSVLDbEBiMnebJCXfhTrcaV+cvo/SyUVcKyUnSvU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ep0sPYDEKBmvyWMzsoRhBTWjtwEYFLL5ckZ8FkhvTD6I4wdQkAmYrgYRn+zAnOn55p08TydZmg2widkEPx0ZftfYJUVSIREMsgOEK6jMoBVHZbCHgnl5Zw26LT+AojGPESkALk42FEnMGMaFnFVCKPWNwtfm5jbrxA2E10SzM0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RnS/3HLV; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RnS/3HLV"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A25125E3C;
	Fri,  3 May 2024 11:43:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UexbSVLDbEBiMnebJCXfhTrcaV+cvo/SyUVcKy
	UnSvU=; b=RnS/3HLVAqYRkvw6+qStQbqFLi6PtiuJ2dwWCK5y2eULlJIVGLBLi1
	Vz2X9mnrQhMRYh+3sXNACT/QOUfPMA4jtgYRR3xKqKp7ooER2kMkDUgKIumoP4Lo
	1NM7LqRoYcWirYlRUNrLXaM+9CXeQU7pexRnRC57rlfIU+2E+r7Q8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 72CDE25E3B;
	Fri,  3 May 2024 11:43:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9EBC125E3A;
	Fri,  3 May 2024 11:43:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Mike Hommey <mh@glandium.org>,  git@vger.kernel.org
Subject: Re: [PATCH] Win32: Fix building with NO_UNIX_SOCKETS
In-Reply-To: <47580fe5-6934-9a76-f927-d66c6c338143@gmx.de> (Johannes
	Schindelin's message of "Fri, 3 May 2024 11:26:04 +0200 (CEST)")
References: <20240503091427.2808390-1-mh@glandium.org>
	<47580fe5-6934-9a76-f927-d66c6c338143@gmx.de>
Date: Fri, 03 May 2024 08:43:34 -0700
Message-ID: <xmqqv83uaok9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E72D138E-0963-11EF-83BD-25B3960A682E-77302942!pb-smtp2.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Mike,
>
> On Fri, 3 May 2024, Mike Hommey wrote:
>
>> After 2406bf5fc5 it fails with:
>>
>> compat/mingw.c:4160:5: error: no previous prototype for function 'mingw_have_unix_sockets' [-Werror,-Wmissing-prototypes]
>>    4160 | int mingw_have_unix_sockets(void)
>>         |     ^
>>
>> because the prototype is behind `ifndef NO_UNIX_SOCKETS`
>
> Good catch!
>
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Thank you,
> Johannes

Thanks, both.  Will queue.

>
>>
>> Signed-off-by: Mike Hommey <mh@glandium.org>
>> ---
>>  compat/mingw.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/compat/mingw.c b/compat/mingw.c
>> index 4876344b5b..6b06ea540f 100644
>> --- a/compat/mingw.c
>> +++ b/compat/mingw.c
>> @@ -3159,6 +3159,7 @@ int uname(struct utsname *buf)
>>  	return 0;
>>  }
>>
>> +#ifndef NO_UNIX_SOCKETS
>>  int mingw_have_unix_sockets(void)
>>  {
>>  	SC_HANDLE scm, srvc;
>> @@ -3177,3 +3178,4 @@ int mingw_have_unix_sockets(void)
>>  	}
>>  	return ret;
>>  }
>> +#endif
>> --
>> 2.45.0.1.ge6f3e402ce
>>
>>
