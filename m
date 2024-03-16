Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C947E18EA1
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710612347; cv=none; b=ozKOsBziZRQa7IqQ0Es1Pk44f1hQgdXKuRgMV9oDIn2YmVBSzp64T7UTkVLQhnNikSt3Z0ko1pIK++wac3EmMicBMdDFiaVPIEPcvAsJk3nVm4MCqf+JWP3XvOLbvBENQfLMRgpMVhwaawGhF0vyrFwlbH+65Dg+h5FTglwRF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710612347; c=relaxed/simple;
	bh=7wMd/XyltKBrL0p7saLmTt63Ljtu6XBtEV3YFgB/Lvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBtL6+S24zgje/+5AmDdckilr2aUnBT2nEmHZG8g6G10TDz8i8+E1jGfRURLYGhdfiTZtAmB5a3e1iK59947HhpkY6FdP233ANVSuTPr0TzeSLyA1OrLz0oqyUfDiTO+lMe/suZwJjCrRKA9MeB2YQiaZbQf6vvsv5c1xtGBYVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=eRk/V/UY; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="eRk/V/UY"
Message-ID: <ea07fbc2-8937-486b-87c2-e2abe9856d26@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1710612341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=En/FeWhGGyXRpJz4vRB94rqGBXcyeQE5XxK8qbLnznU=;
	b=eRk/V/UYjlyt8Ali7JpRAbHx+wloY0iobFPz2s8311UhOmGEDlxvqQxTM4a9C7sdXOSVID
	vGFoScv6FIoKtAhv/Q8eIuEAlt6OIYK/AnmQ+GMRxO0r1+tM1OvKjIK9zyYq474CTWcOog
	rpFi224lRCSx8uUM4mhTWYl+OSFlCtw5LE/Vk+bc9p+rOEzU+62a71OnIf9GvRKFwzR8nu
	fLc+WtSJo9fg1lRYfAVfDBdRGFbwqfHf5Jc4xxZgaysh17JN5b3Q9R3CnBSNuqU3lq3ZF0
	EVRRiIt72j2YjKYMs++hkZEN3N7jGFiyY0zcjAzeYNE6CJ9MMu7Pj8DQ1zbLnw==
Date: Sat, 16 Mar 2024 19:05:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] config: learn the "hostname:" includeIf condition
Content-Language: en-US
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org, 'Junio C Hamano' <gitster@pobox.com>,
 'Jeff King' <peff@peff.net>
References: <20240307205006.467443-1-ignacio@iencinas.com>
 <20240309181828.45496-1-ignacio@iencinas.com>
 <20240309181828.45496-2-ignacio@iencinas.com>
 <20240316065737.GA544929@coredump.intra.peff.net>
 <xmqqo7bem7o8.fsf@gitster.g> <006c01da77c9$298b2e50$7ca18af0$@nexbridge.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
In-Reply-To: <006c01da77c9$298b2e50$7ca18af0$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 16/3/24 18:41, rsbecker@nexbridge.com wrote:
> On Saturday, March 16, 2024 1:03 PM, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> Do we need to define "hostname" in more detail here? Specifically, I'm
>>> wondering whether the result will be a FQDN or not (i.e., the output
>>> of "hostname" vs "hostname -f"). Looking at the code I think it will
>>> just be the short name returned. That's probably OK, but it may be
>>> worth documenting.
>>
>> That was my first reaction but there are places where "hostname"
>> already gives a name that is not "short" at all, without being invoked with
> "-f".
>>
>> For example, the (virtual) workstation I am typing this message on sits in
> a $WORK datacenter, where "hostname" gives the same
>> string as "hostname -f", which looks like "git.c.xxxxxx.tld" ("git" is the
> only part I picked myself for it, "c" is shared by those employee
>> workstations hosted at datacenters, "xxxxxx.tld" is redacted to conceal the
> real domain name to protect the culprits ;-).
>>
>> I think the most honest answer we can give in the documentation is that we
> use what gethostname() [*] gives.
> 
> I think this is probably a good idea and but value should not be cached. My
> dev box has a multi-home, multi-cpu IP stack. It makes things really weird
> sometimes. For example, hostname replies with:
> 
> ztc0.xxxxxxxx.local
> 
> and includes the current default IP stack, which is known to DNS, while
> uname -n, which I prefer to use when deciding what system I am on during
> tests, reports:
> 
> xxxxxxxx
> 
> I am not sure how meaningful hostname is; however, "hostname -f" is not
> portable. However, includeif depending on whatever gethostname() returns is
> reasonable, in my opinion, also. I think the series should include a $(uname
> -n) option in some form for completeness.

Correct me if I'm wrong, but gethostname() seems to be equivalent to
$(uname -n)

[1] https://git.musl-libc.org/cgit/musl/tree/src/unistd/gethostname.c 
[2] https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/posix/gethostname.c;h=3c50706b5823368a0b3e876491e554461a4d515e;hb=HEAD

>>
>>
>> [References]
>>
>> *
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/gethostname.html
> 
> --Randall
> 
