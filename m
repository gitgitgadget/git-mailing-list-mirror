Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C901EB2F
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737489102; cv=none; b=rb5YhOLklwl4qpVqCV7f1KKOxDIr3s1jQSTyJtqaMJn5PzU7J//ofqbj0e8nL1YL0Q44bcub+m1qvECfrqA+nIUFm4xTdonpH1VNHdxxfp80bfJIb+OTAVWsHGtG6waxyFldV8w65rpTZYctbMy+FKIJQhK+cgvnqM34gQ4Mo3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737489102; c=relaxed/simple;
	bh=W/Ka/OabwNEq1jCbrWfEXsV4OqwSqrqQ/tBn6/hGO/k=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=RNPfenrxIFj+iDkrRw7ew8bhWgXhCAJBMpVc4fhbpMKxL2GV/fJDcOUlwWP3YBPqifbB8hg2ahYz8zWVQQddIG38pUiN7q1ua2h6u6MRSSmdGh8N+bHCQIycCM9q+h3ckEH7cAbHjAVOkGEXjfxfNg1NpJCaxJlVY1kBTLvXDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50LJpJtI394311
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 19:51:19 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Usman Akinyemi'" <usmanakinyemi202@gmail.com>
Cc: <git@vger.kernel.org>, <christian.couder@gmail.com>, <ps@pks.im>,
        <johncai86@gmail.com>, <Johannes.Schindelin@gmx.de>, <me@ttaylorr.com>,
        <phillip.wood@dunelm.org.uk>, <sunshine@sunshineco.com>,
        "'Christian Couder'" <chriscool@tuxfamily.org>
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>	<20250117104639.65608-1-usmanakinyemi202@gmail.com>	<20250117104639.65608-7-usmanakinyemi202@gmail.com>	<xmqqwmethxyq.fsf@gitster.g>	<CAPSxiM_9JKxu5QkxjHUFDM6cb5rSs400O72eYCiM8jHF9dr7Vw@mail.gmail.com> <xmqqjzao0yk6.fsf@gitster.g>
In-Reply-To: <xmqqjzao0yk6.fsf@gitster.g>
Subject: RE: [PATCH v2 6/6] version: introduce osversion.command config for os-version output
Date: Tue, 21 Jan 2025 14:51:14 -0500
Organization: Nexbridge Inc.
Message-ID: <02e901db6c3d$d7c1d190$874574b0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL1iKQeqDpt8guF+jE2EcHccRlcdgGGCMwEAb1tHEECbCriYQIQ9xHCAcGK4hGwoViDEA==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250121-0, 1/20/2025), Outbound message
X-Antivirus-Status: Clean

On January 21, 2025 2:14 PM, Junio C Hamano wrote:
>Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
>>> That way, we do not need to add another mechanism that lets people
>>> spawn an arbitrary command while Git is running, we do not need to
>>> worry about security implications, and we do not need to worry about
>>> people abusing the facility to throw totally random and useless
>>> garbage information at the other end to make their stats useless.
>>
>> Thanks for the review.
>> This config option was added at Randall's request.
>>
>> Randall wrote:
>>
>> "Instead of an override, what about a knob that specifies the uname
>> command to use to build the value. Personally, I would use `uname -s
>> -r -v` on NonStop to get the kernel version used in the build. The
>> difficulty on my platform is that this is not truly useful info. The
>> effective build OS compatibility version is in a #define
>> __L_Series_RVU and __H_Series_RVU, so the knob might be needed in
>> git_compat_util.h or similar. This comes from the compiler arguments,
>> which are not yet captured."
>>
>> So, the difficulty is that the compile time information might not be
useful.
>
>It only tells us that uname(2) gives useless information on the platform,
but there
>are other ways to ask the system for more useful information.  Isn't that
the same
>deal with how useful information is obtained from not uname(2), since a
useful one
>does not exist there, but from GetVersion() on mingw?  We do not have to
spawn
>an external process on MinGW to do this---we shouldn't have to do so on
NonStop,
>either.  We should be able to make a call into a NonStop specific code you
or Randal
>add in compat/ from get_uname_info() to hide the platform-specific details,
no?

I agree. One this series is finalized, I can put together a patch to obtain
OS details
on NonStop from proprietary calls. Not something I am happy about doing, but
it is what it is. I still do not get why people cannot just run 'uname -a'
instead of
this integration. From a support standpoint, knowing what OS level was used
in
the build is more useful that git telling me what I can get from uname. But
I
accept that others want this, so I'm going with it - once the code is
accepted
into base git.

