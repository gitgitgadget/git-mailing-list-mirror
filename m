Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9DC14F9C6
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712952654; cv=none; b=gEM7XdTtGMSaK37a4sljIi7X6oA8c7ATa+QGCk1aKKbsvGe6hJkY22TRnfK7gfl8dNEEVMhA0Yb3noRo0yWaJ0/c5cyBjGVAfHMTvwrPoDCcfev3QZqQ9dTaCKu1xaxHNvFym945RCH+4ijc95PM2jq45Wi8uiVasgsYov7EiMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712952654; c=relaxed/simple;
	bh=gVqCCcp+XGjfqEG3tcqe7Dp6X3z3wb3JP9B1lRDaq6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mh2SadZSkVsz340pRXgkIx/YMJ/4Lukid5YupmrBmKksjX7lJPa+w7ZqHKsnslDeHBasmQZIHxlukqc6TxzWDbmUrCLhtBt30nWakB4/vV87+H4pp+9Lo4kQIAXfkbXXe93do9DgKDOcGpYqz+CRiR6M29hctRU0VJSNh1TKU5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amyspark.me; spf=pass smtp.mailfrom=amyspark.me; dkim=pass (2048-bit key) header.d=amyspark.me header.i=@amyspark.me header.b=bMvAdsB4; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amyspark.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amyspark.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amyspark.me header.i=@amyspark.me header.b="bMvAdsB4"
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3B6C1BF204;
	Fri, 12 Apr 2024 20:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amyspark.me; s=gm1;
	t=1712952649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJwGxRyzCQuNmrpQC2JkBG1tRAtdmIFXIwkgSdkxcTM=;
	b=bMvAdsB4XBqyHMa0CbdnX3HKWIKe2JhbkbQUGvarc08FhUkPE/xoRkPpQiSGnt59SaFwh+
	AIFCvaux4lkcERPDRxjCDqAvaXknxwdh9aaATushRd1supiVIlls6GsNOPj2jEN9hJZdQz
	TxGksNMwUpOul4ouCUdf3HlraXAUHP/Q4ak/62a+g6vc9AkK21/NWiv7V7we2ONy8K0S75
	kxAl8pm8iYZM2VZv9H5E/X9MKS2H+AHq17fdyU2HYuSEHrpf2R1d0PcLkDrRmPRDjkQuN9
	fb8egO/QfoJ+ZiS4tWU+2KuhTGWVP/gE+0r+4N/+LgSSlF9LKyis0vrHw3CmOA==
Message-ID: <c0353f84-de98-4c74-90fb-bfe1c3f14d21@amyspark.me>
Date: Fri, 12 Apr 2024 17:10:41 -0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [BUG] Clones from local repositories do not work correctly under
 Windows
To: rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>,
 'Johannes Sixt' <j6t@kdbg.org>
Cc: git@vger.kernel.org
References: <44020a6a-707f-4505-adde-e79cda63d711@amyspark.me>
 <2f069d1f-aa4a-4259-9cc5-dcf912f59a17@kdbg.org>
 <e25bbce7-8338-430b-865f-690fe3c94fb6@amyspark.me>
 <01cf64db-2ff5-4be5-8968-d280ab0ffc50@kdbg.org> <xmqqil0mmqpx.fsf@gitster.g>
 <02b801da8d00$b2c5b9f0$18512dd0$@nexbridge.com>
Content-Language: en-US
From: "L. E. Segovia" <amy@amyspark.me>
In-Reply-To: <02b801da8d00$b2c5b9f0$18512dd0$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: amy@amyspark.me

Hi all,

In Cerbero, we use cygpath or a bespoke conversion mechanism, depending
on availability:

https://gitlab.freedesktop.org/gstreamer/cerbero/-/blob/main/cerbero/utils/__init__.py#L142-149

I'm not sure if there's a function in MSYS2's libc exposing that.

amyspark

On 12/04/2024 14:41, rsbecker@nexbridge.com wrote:
> On Friday, April 12, 2024 1:33 PM, Junio C Hamano wrote:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> alternate: C:/Temp/repoorig/.git/objects
>>> alternate: /c/Temp/repoorig/.git/objects
>>>
>>> This is the MSYS2/Cygwin absolute path with a "drive letter".
>>> Unfortunately, this kind of path is unintelligible for Git for Windows.
>>> It expects absolute paths to begin with drive letter-colon or a
>>> double-slash or double-backslash. For this reason, it reports "unable
>>> to normalize alternate object path".
>>>
>>> The conclusion is: Do not use two different flavors of Git on a
>>> repository that is set up with a link to an alternate repository.
>>
>> I do not complain to the conclusion, and I do not use Windows, but it makes
> me
>> wonder if there is a way to spell that full path that can be understood by
> both
>> implementations.  The two implementations are not incompatible in the
> actual
>> object contents and refnames and other things in .git/ directory, are they?
>>
>> In short, does MSYS2/Cygwin understand paths in "C:/Temp/..." style, and if
> so,
>> writing that out, even though it may not what it considers the native
> format, would
>> make the world a happier place.
> 
> I'm my environment (<2 month old Cygwin update), the path would be
> /cygdrive/c/temp... I have not had issues using that style with git. Cygwin
> itself does not understand C:\Temp (resolves to C:temp), but does understand
> C:/Temp in bash and various utilities. It also understands (and expects) ~
> to mean /home/user (C:\Cygwin64\home\user) in the Cygwin space, not relative
> to C:\Users\user for resolving .gitconfig.
> 

-- 
amyspark 🌸 https://www.amyspark.me

