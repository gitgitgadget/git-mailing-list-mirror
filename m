Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0973036AE1
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710096384; cv=none; b=q1O3EQiuZk4pS4s7ZptgrmktJRDLsX3tEe8M7uCBfJ/w5bPxGSmOTEU9lXIIpspp4akMeeSwbjGekLIyFsVAszC167AUuFcmQAYrGbaOeCmlweL571O0v/w4Y+equRpKqFJ8XoCzQWb/ueCf4z8yeB90Ap/MudRqLZn1Sn2jTFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710096384; c=relaxed/simple;
	bh=CrBDsCyibbmbQtLHyhf2ZnCsojupH7+WxGMmNhKPP7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4QiZXtJ1JRdtMa65flePLbBhadR1JScfpETB2RpJ6Ov4g7Zz5IXSor3xLnmustEZ68VEfubSMXJqwlkS3IM7prRbLL2O5WwAIZNDivOVpr00BgMSHXHHWfwhYGTW2KnOtwrwDueZov8mzqDX6P/3LbKOEZgNSstX8RxIKbfjKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=ZW+3Vb1V; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="ZW+3Vb1V"
Message-ID: <9fb02065-12d2-4c92-b1a5-74c06125c692@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1710096378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gtpq6Qgn573nMgRFkZcIQZJ5Mt8u407FB66gHoWi9Lk=;
	b=ZW+3Vb1VoLw+MNBEdG8MVPoJfGOaOJZKrKSAxwyyoMqnE8t+E2I+IkLGQmIuMz5hRGamcF
	l/BFu6oVly7VbpCofdCYLK2zUM6nOIF9TlcRhDjD79qAUTC/7IwBVVgir4He+ujTydXRy8
	1XH/TnCeMqzvCr7HqQMcVOCJEp5XRX+VjEgqx9cSyaYTjBzHp8c3Mwdyg1wceZqzmoQcvU
	OhmBw6pa6e+tFhrr9PfNv2j3xwCBpx97UubN1xzeE/CUPAI+e5e2IN2ptoK1Xgx6KpiVXz
	9AAIgm5iLb3rRbcVmrg1TuEip0VY7lrQ33zbseKzOjxYUQPE4B/ExYdaFq0IXg==
Date: Sun, 10 Mar 2024 19:46:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] config: learn the "hostname:" includeIf condition
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20240307205006.467443-1-ignacio@iencinas.com>
 <20240309181828.45496-1-ignacio@iencinas.com>
 <20240309181828.45496-2-ignacio@iencinas.com> <xmqqy1aqvx9n.fsf@gitster.g>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
In-Reply-To: <xmqqy1aqvx9n.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/3/24 17:59, Junio C Hamano wrote:
> Ignacio Encinas <ignacio@iencinas.com> writes:
> 
>> +test_expect_success 'conditional include, hostname' '
>> +	cat >>.git/config <<-EOF &&
>> +	[includeIf "hostname:$(hostname)a"]
> 
> This unconditionally runs the $(hostname) command assuming it exists
> everywhere, but
> 
>     $ git grep '$(hostname' t/
>     t/t6500-gc.sh:	hostname=$(hostname || echo unknown) &&
> 
> tells us that we should be prepared to meet a platform where such a
> command does not exist.

Oops, it didn't even cross my mind. Thanks for the catch!

> I have a feeling that it is better done with a test prerequisite
> than hardcoded "unknown", as xgethostname() at C level may come up
> with some random string but it is not guaranteed to be "unknown".

I agree. Not being able to query the current hostname defeats the
purpose of the tests.

> Perhaps have one instance of this before these added tests
> 
> 	test_lazy_prereq WORKING_HOSTNAME '
> 		hostname >/dev/null 2>&1
> 	'
> 
> and then start them with
> 
> 	test_expect_success WORKING_HOSTNAME 'hostname: includeIf' '
> 		...
> 	'
 
Thanks for providing an example. 

> or something?  Others may think of a better way to make sure this
> test does not cause false failures on platforms only because they
> lack working hostname(1) but have a working gethostname(2) and their
> xgethostname() may be working fine.

I can't think of any room for improvement other than integrating
hostname (or a custom hostname) into git and using it in the tests, but
I doubt it is worth it.

> Thanks.

Thank you. I will wait a couple of days to post the v3 to see if anyone 
has a suggestion.
