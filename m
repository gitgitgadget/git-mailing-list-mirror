Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA03614B06E
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531559; cv=none; b=tRRPMIQgOj1ogDe7sXKmNK+uFGkhFx2G9mMrnUIBC3QvYToemr9u/zGA1tYiHxdvnc7D3IWMEoFgWTxdIOZuF5l34zBdiS8ZorVEZhGEMO12QM2wSNHvrAbXMtuKx+a3/DTPiXKkOobJXs6DMw552GSRXtHLU1U6AxtQAbh/mRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531559; c=relaxed/simple;
	bh=V1Up0nQEk44Ye4KJucsONKoLDomeNxC/2m+O1wi/hg0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BITfJLwmX4kQAo3Sk92yHOCcMUxYTGehEs/LI2H9B0HV+sjlfPb0fknSTz8yxcRoKihlbvW5Ct4ZU6YyAh8hSYMZKd4ycfTPvBpz/KteICWcEaBTLmtOHDfFMC8LwX+JIiFMEzo6ktPzTUT6i+zmC19/6QZ9SluBHaP4LUc2IVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=NU3W4qMJ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="NU3W4qMJ"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717531554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GzQ0B4p00FVjx5jZkAKPeKVKUzDhHbg7XhV+cO8CID0=;
	b=NU3W4qMJ+NXvivL70W6XsnMINApV67NhXUWv3BYmJxvibpoN2wyA8rna3P/2pnuBY0NHwJ
	0ZX2VuBwG4WRDhWy3FU5cdLuHRL4xBCAxZpSHAYpEkMVDmDrOAs6RKHl3eIVZcvMLqQOfQ
	SF9LKKZZkMPOQEfIlcekVx59BZV9iLtrS6OTTtbMZhFVOzifjl41knBKUb6v3MDnviqsYF
	7IwOgdjAUD9rEAjcUH00VKMBj/HdMfAhuycSNj0KvDkjxAHqny0MRMazAkfrU890wZJOvB
	CRGAzUycmfeorSoW/n5m2HX0fX7Sv4ZyUSd/pixdz9TYQE0bgMRgfsdO3KWbtg==
Date: Tue, 04 Jun 2024 22:05:54 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, Git List
 <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 6/6] add-patch: introduce the command '|'
In-Reply-To: <xmqqy17kws2k.fsf@gitster.g>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
 <75a3cc89-4d23-4eae-b0ad-e52e2c8ba550@gmail.com>
 <xmqqy17kws2k.fsf@gitster.g>
Message-ID: <a3dc59f9b2178fe263df2df23e792ede@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-04 19:12, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
>> @@ -1389,6 +1390,7 @@ N_("j - leave this hunk undecided, see next 
>> undecided hunk\n"
>>     "s - split the current hunk into smaller hunks\n"
>>     "e - manually edit the current hunk\n"
>>     "p - print the current hunk\n"
>> +   "| - use pager to show the current hunk, or use |<program> to 
>> customize\n"
>>     "? - print help\n");
> 
> "to customize" strongly hints that the customization will stick, at
> least during this session.  Is that what actually happens?

Good point.  I used "customize" in the proposed wording improvement
because we previously (kind of) agreed about making "| <program>",
once selected, stick to the end of the current session.
