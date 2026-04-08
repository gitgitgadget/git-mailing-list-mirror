Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1682153EA
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685853; cv=none; b=O09j8rfwS5eQZoUPKtWBF5yOs0IGMubrc+46Nhf3FlOtTFjOrwqoXnyEdOiBHdpvjJwX5lFtVd47iS4tFJl646mymYNitibqU7YqIA/WM+djJwdHnzCZX2cNBWNh33aRDrGhWt7DE0uWbA/utRtouZP9mrIQKxr3avbCss51yHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685853; c=relaxed/simple;
	bh=vdQbe4pSU/qQk5PQC4nR+nRpfgcutUDI4/a2LiAQJhI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dy6UlsRYKYVJpr/19c1ljpkzkFntTb3g4QnkgXWoUnhuq+QoSD354MZJvC/Yd/4pnguudRSRZ+n+ckVfyHtfp380WMAJJ04NyS2k4P5hNiSBi7j6f7KS10Gw4HtfSYHS8YZbWUmg939XtWAfe7TS/aoFOK8EMHAC1NzLzAP1SIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 638M47qW3375397
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Apr 2026 22:04:07 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Jeff King'" <peff@peff.net>, <git@vger.kernel.org>,
        "'Patrick Steinhardt'" <ps@pks.im>
References: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com>	<20260408041716.GA1324339@coredump.intra.peff.net>	<011701dcc767$8c2ab400$a4801c00$@nexbridge.com>	<013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>	<20260408173949.GB2850002@coredump.intra.peff.net>	<xmqq4illz5g9.fsf@gitster.g>	<014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com>	<xmqqqzopxkxa.fsf@gitster.g>	<016b01dcc79e$87472860$95d57920$@nexbridge.com> <xmqqcy09xh53.fsf@gitster.g>
In-Reply-To: <xmqqcy09xh53.fsf@gitster.g>
Subject: RE: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Date: Wed, 8 Apr 2026 18:04:01 -0400
Organization: Nexbridge Inc.
Message-ID: <016e01dcc7a3$9f0d06e0$dd2714a0$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQIImllt8JGdGqh7Bu9hfV8wd5a54AFtvwh7AomCUMsCTyy1LAGZ2yzlAlGDzHcBlyeC0wIgPQjWAstiUjQB3KW4kLTpiBSw
X-Antivirus: Norton (VPS 260408-8, 4/8/2026), Outbound message
X-Antivirus-Status: Clean

On April 8, 2026 5:43 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> On April 8, 2026 4:22 PM, Junio C Hamano wrote:
>>><rsbecker@nexbridge.com> writes:
>>>
>>>> On my box, I have the following note:
>>>>
>>>> Specifying  the sum of the iov_len values in the iov array greater
>>>> than the OSS I/O size limit for that open causes the  writev()
>>>> function  to return  -1  and  set errno to [EINVAL].
>>>
>>>That is unexpected.
>>>
>>>writev() may fail if the sum of iov_len would not fit within ssize_t
>>>with
>> EINVAL, but
>>>unless your "the OSS I/O size limit" is the same as SSIZE_MAX, what
>>>you
>> have above
>>>is not quite the same.
>>>
>>>Does your build work with NO_WRITEV=Nope?  I think I saw it asked a
>>>few
>> times
>>>but I do not recall seeing it answered.  At least we know
>>>xwrite() seems to work well enough on your system, which is what the
>>>writev() emulation is written in terms of, so I suspect it would.
>>
>> Yes, NO_WRITEV=Nope does compile and execute. I am including it in our
>> CI/CD job for now. Can we plan on a fix for this?
>
>What I have heard so far indicate that the code that uses writev() would
need to
>loop over to prepare for short writes, but your
>writev() that fails for "the OSS I/O size limit" (whatever it is) does not
sound like
>something we want to change the callers to chomp the writev() calls into
smaller
>chunks for.  Such a platform is far better off using the compat/writev for
the code
>path we recently started using writev() in.
>
>To be quite honest, I am not sure if it is even worth using writev() if we
need a loop
>that protects against shrot writes, so unless I am grossly mistaken (e.g.,
perhaps
>there is some guarantee that there won't be any short writes for writev()
that sends
>data smaller than 64k that I missed in the docs), the best course of action
might be
>to revert the change to use writev() and use the two write(2)s as before,
*if* we
>actually observe that the current code is broken by short writes.

I am 100% sure that EINVAL is returned by writev() on NonStop if the size
exceeds 52K
In 32-bit models. Whether it supports 868K for 64-bit is conjecture.
NO_WRITEV=Nope
works, which I am trying for everything at RC1, then we can live with this.

