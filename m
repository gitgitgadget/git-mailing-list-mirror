Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C8B16DEB9
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718970541; cv=none; b=VSNRp5lKspjegnzti1Uzh9G+3KIOemLEOb+nhMiH6hBeh1tCyxN/Mg5wydUtHzmSvkrkzf1cPQp7AeiK7PMZILQ78IJaA/4Awb6gB0gBPobea9ymCErem7vHoBTG/bxi7ygq0S10HmbSWj1KlveByEHRA6lo5XDUNAha6frSLI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718970541; c=relaxed/simple;
	bh=cDweqiXnmDBAitFv+Z5X2KLGPXXskmUwAqighpet+oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PadKaJmUQ4IQW1w3QhcapHl2cR+PL2drGY2DJjUztjRqiB+tXeKCWpisSUqe1RdCDCE87zslN2sibSzjKzi2nTSYduwAZ11egcefnQyjZs4/Gr/Qc+vGkyum/wLPB8tq3x61er/ojJMy7raTdf516RDnllm3QfRukdjg8O6+ei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=QpUHAwSs; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="QpUHAwSs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202402191026; t=1718970530;
	bh=Zz1B2w9ZiqC0n5m4e7mokVmYuIgUSjtRcZLrqa3MqyM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QpUHAwSsOz+F5JnhkNtcP1CsmZtSvCApnujmMfFdA06hTFfi0P35f/N743G2prB2+
	 Jw9M8tbAJXA6AOMXZ11Cr02g3nfzz3/c3eHDPVowaFL9i4J46xbev0iyXN4MwB/tpm
	 G+0NP0dkz7XQAUYgJPtYe/O12hA4msE9kv1j0Wqj96Otp+u5YZ2fioOqEN1kR0aqOl
	 TsxeiQOsKqUlgycfBCHlv96QXjhsf+o3nqYQfjzB8Nqe9/j2sDf1MAGC7GddD9WD/4
	 qJdYIoG0gtSS/2QoDxcqO4BpkRnMgv1nSR6cZpDoEf6nSsikQYYG/4f1PT8BmmWThc
	 6jI6musalmGvA==
Received: from [192.168.42.22] (i5C74DC1D.versanet.de [92.116.220.29])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 2AA013C0699;
	Fri, 21 Jun 2024 13:48:50 +0200 (CEST)
Message-ID: <45c76e96-9f05-4b35-9337-faa26980519a@haller-berlin.de>
Date: Fri, 21 Jun 2024 13:48:49 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Thoughts about the -m option of cherry-pick and revert
Content-Language: de-DE, en-US
To: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc: Git <git@vger.kernel.org>
References: <e60a8b1a-98c8-4ac7-b966-ff9635bb781d@haller-berlin.de>
 <xmqqa5jfoxvh.fsf@gitster.g>
 <dd58a60d-a551-4726-85a7-f47b851914be@haller-berlin.de>
 <6e71b1f3-599f-49c3-be37-e499f28983cf@gmail.com>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <6e71b1f3-599f-49c3-be37-e499f28983cf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 21.06.24 12:19, Phillip Wood wrote:
> On 21/06/2024 07:33, Stefan Haller wrote:
> 
>> I'd be interested in example scenarios where both sides of the merge
>> have non-empty diffs. Won't this only happen for evil merges?
> 
> I think you'd need a conflicting merge that is resolved in a way that
> the resolution of the conflicting lines doesn't match either parent. (I
> assume that's what you mean by evil but I thought it best to check)

Ah yes, that's another example, but it's not an evil merge. An evil
merge is one that has additional changes that don't come from either
side, and don't come from conflict resolution (e.g. they were amended
into the merge). I thought that was commonly understood terminology.

>> This seems unnecessarily restrictive to me. Cherry-picking merge commits
>> using -m1 is useful, it's an important part of our release workflow at
>> my day job.
> 
> I can see why people want to revert merges but cherry-picking them
> always feels strange to me - what is the advantage over actually merging
> the branch and seeing the full history of that commit?

It's less work (if you otherwise insist on rebasing the branch to the
destination before merging), and results in a simpler graph that's
easier to understand (if you don't).

And I suppose you could ask the same question about the --squash option
of git-merge.

-Stefan
