Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2082ED8
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710887541; cv=none; b=jofjPhhudwZRzx2uubcEvpz1Uo1eSSZ8hqJnGbBNpaJ47xMEv1+Q4qZO3fZ8iZ3Cio7vKOEquYdxjnXeWOSNSVIJzwxrjogFXVjJ+EvJAxpGNt+swtQsqNADIwFB+17B1QDteTNnxpQDDLhIwc3W2D0hvitnEOKXOGQp3A9Lhns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710887541; c=relaxed/simple;
	bh=LplD5pS8KxsO9mEob/AggPU/kmHKZ7NUZswEwu012LQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=MHGpfVDu6LR9ZN6hGGzm+CtAkbb0DaYklMJCd8Nbpwe4BBPBYo4sbTE8EuZvTOdL0cbSY1BKxrzHIJ3L1YgfqlCZaFYNmD2rtWJLitgtavmpI3+3avMElFor8H877WLlW+phPufxSyX7dUnyc/9fnyalCo89wtkq2EvriLIzc0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 42JMVrgZ3094110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:31:54 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Dirk Gouders'" <dirk@gouders.net>
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Eric Sunshine'" <sunshine@sunshineco.com>,
        "'Ignacio Encinas'" <ignacio@iencinas.com>, <git@vger.kernel.org>,
        "'Jeff King'" <peff@peff.net>, "'Taylor Blau'" <me@ttaylorr.com>
References: <20240309181828.45496-1-ignacio@iencinas.com>	<20240319183722.211300-1-ignacio@iencinas.com>	<CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqDs7Xv2Nf4A@mail.gmail.com>	<xmqqa5mulycz.fsf@gitster.g> <ghv85hj446.fsf@gouders.net>	<02d601da7a49$3bbf1230$b33d3690$@nexbridge.com> <ghr0g5j1sc.fsf@gouders.net>
In-Reply-To: <ghr0g5j1sc.fsf@gouders.net>
Subject: RE: [PATCH v3 0/2] Add hostname condition to includeIf
Date: Tue, 19 Mar 2024 18:31:47 -0400
Organization: Nexbridge Inc.
Message-ID: <02d701da7a4d$3e60e960$bb22bc20$@nexbridge.com>
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
Thread-Index: AQGtFbHTdn1kVN5iPDvVZmFFSAj7tAJ4RnKbAdcT/EoCkKsPPAKng2iXARNvOzABvkAqwLE3pHfQ

On Tuesday, March 19, 2024 6:27 PM, Dirk Gouders wrote:
><rsbecker@nexbridge.com> writes:
>
>> On Tuesday, March 19, 2024 5:37 PM, Dirk Gouders wrote:
>>>Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>>
>>>>> Peff felt that adding `git config --show-hostname-for-includes` was
>>>>> probably overkill, but I'd argue that it is necessary to enable
>>>>> users to deterministically figure out the value to use in their
>>>>> configuration rather than having to grope around in the dark via
>>>>> guesswork and trial-and-error to figure out exactly what works.
>>>>>
>>>>> And the option name doesn't necessarily have to be so verbose; a
>>>>> shorter name, such as `git config --show-hostname` may be good enough.
>>>>> Implementing this option would also obviate the need to implement
>>>>> `test-tool xgethostname` (though, I agree with Junio that
>>>>> `test-tool gethostname` would have been a better, less
>>>>> implementation-revealing name).
>>>>
>>>> Yeah, I like that show-hostname thing (which I do not know if "config"
>>>> is a good home for, though).
>>>
>>>A thought when I was reading this: wouldn't it be enough to document
>>>that
>> `uname -n` can be used to get the hostname that should
>>>be used?
>>>
>>>As far as I know this should be POSIX-compliant and uses gethostname(2).
>>
>> As previously pointed out, uname -n and gethostname(2) are not
equivalent.
>> uname -n does not (depending on implementation) go to DNS while
>> gethostname(2) goes to DNS first (although apparently glibc may not).
>> This is particularly important in a multi-home situation where more
>> than one IP adapter has a different IP address on the same host, and
>> where DNS does not consider the different addresses to be equivalent
>> (which otherwise could cause problems for reverse lookups).
>
>Thanks for the explanation, I did not notice this has already been
discussed.
>
>Interestingly, I strace(1)'ed uname -n here on Linux and noticed it uses
>uname(2) (what else?) and not gethostname(2), so it seems I was completely
>wrong.
>
>Sorry for disturbing the discussion.

No worries. I only know this point because I was rather deeply in a related
code base back in 1994. I did not know that glibc varied from an old UNIX (I
think that's where the code was from) code base prior to this thread.
Learning is good and never a problem.

Regards,
Randall

