Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D914F98
	for <git@vger.kernel.org>; Sun, 12 May 2024 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715506742; cv=none; b=cy81IC8bJzULfHnn57fwtXkSuRvdrSUGbfeZedL4oCSjrq+i+6jq6x4ozxvU57Ry/HkXmMimhCXkO/1RijoGAC3dC8Ou48u3yPi4+o+YdkQaRuBc3uLq3SjFYqsxAv7w6bATQlOpEOad+1nPQsHcFgSQFcVOqmUITb66Ig4H9+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715506742; c=relaxed/simple;
	bh=Q34sqaiIun/kXVcFB/88k00Ro2G3za/lcAyoe2paI+8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eUNvQ7aI71exlbACrBDDN+dfMBFstWRX1pyWjA1LB7tab36W+EqpuNhAjIjoeQxV7y282RMFhiMpMucgY3PoowjsRd412qNR1QjhUhS819vcxVPGFAcQvgiFbkIB2nl7R3IrOYEOKOb1Bnw7wj2WH50yIvfeT42+woNWov7duYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=K4yVAaGX; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="K4yVAaGX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715506725; x=1716111525; i=l.s.r@web.de;
	bh=AQUyNSb5SDRncEbmwAOxlNzwgXRM/hO2C4YAzGZ54Uk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=K4yVAaGXf9gTMcGhApbN66ch48azKY7gNzo4U8Gx7CNbseNp4Vxhmisvr0daeF6v
	 /GeH+csP1519tKcaZaMA2UMXrMBMHrTix6wHK4fVB7U0umxErlScdA8TQD0sS63V8
	 rFEhWok1YFGbUlej5ltHh1aQTY8EhAjbruiTPjluHcNEl8PnquDRDM8z9+FNpo/di
	 Ak1LmJH4N1m9QkE5t3Hd4gwCLqTlDSbZQgLEve3PukyxRS3ZAcEQbY32C6t6BcNdu
	 /382Kda4UUKduQOZQrKCKMlvkc2bt+/BrM20gtIKm4IyAna5qO2+MM15O/+we3pjM
	 IR5+Qb+qD1yIRQQUig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxYbD-1sUVPY127d-013Owx; Sun, 12
 May 2024 11:38:45 +0200
Message-ID: <e97d91db-cbb5-43f5-84d0-289681620558@web.de>
Date: Sun, 12 May 2024 11:38:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] diff: fix --exit-code with external diff
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: phillip.wood@dunelm.org.uk, German Lashevich
 <german.lashevich@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
 <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
 <99337bc2-a691-45f7-9b6f-74ededbd9a78@gmail.com>
 <4bf12c41-a6ea-4939-ba76-e2c784952eaa@web.de>
 <539926ac-4274-4b4b-a2ee-aa48af791124@gmail.com>
 <f3454199-2eed-4ca1-82db-7f1419b3084e@web.de>
Content-Language: en-US
In-Reply-To: <f3454199-2eed-4ca1-82db-7f1419b3084e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FW8E3v6MZr4shNSJPXg1e3TFbCpC7HLdSFVyBfQ+CxJzkKZlrMe
 2cuG9BsNSCJYoq7lCtaVPQTu1fFvqB3BOPpxETz4c5B9WhK9C69vxXam4cgU+mOS0gQUPEz
 uNL7EUO7sa9EBqxGwwpdZo6InhSwmYHH5yn7g8qnz92eoZI2totRNiL6NqOSzQyi0CN573N
 MSyg2Dbqd/51eNl/KuqgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KjCgC+viUO0=;TgkDQa1lzwagXYnv807R3eLlaiJ
 h+2MpIZp9Uhb62bTOcgn1N8LL6QuZE47ejGL52pgMEQPrmAcYGwL9L7P4CcqwttCFRTcTUoBl
 BDsf5RoJwyvscCokTXCblICYyY+U8OX5y9Om74ArPhPu3jVSqX/9LE8izjGY6SNiUXk5FAh2i
 7B8ZkFLZb5FJiZ2iIu0kptdJwbY11OamuL/KIAtdphoknUm9zB06nXLid4TVlLVVPGle48g59
 6lDqq1TRjn+zaEencOQrunGetbb8p0aCRnlTYaXbczKGLqgOxtxip8CaKZ09ZwYaJ/4l506dU
 fWltJsNSXF9Vx6TR0+QIqy8J9lKBfJrJUDOOxxa81xnD28esQcvQdmVuThArv/4gFCScRApe6
 rmMv+GC2os8XZb4R1/l0oWMQ86Sr4HLb02wYosrfcyfPk/NP6tTdM4w48DCXboaT73qZyjpgs
 38NWZAxS0Kj3Y6D0dIxI2VqkLP1tZK3GS1JhFiaB9eZlYfVh5PCOG8cd6uPRKaOA+p9AEsW0q
 1EEo2hSiQ9/jfsjjRo0Ux0smEGyyarzHreoZ2M5OcFD5pt5HgYE7y9czQd8mO+AHYDG3qeBNU
 cEsU8FbViL5J2pdbtu5IVsQ3QYMWoqWadE5iL/pANvQscdP18Ar87Cumg/NSSvwanXcIw8Ug9
 e7HIzaQOiSeGKgCTqqdSG6/YRti7Z209a8a6kyOcaU6RKubMZGuK59bNf4RkU16qRsNiwZKDq
 poF+khVOzUYZvZR5P6HoAQe0a6VsMfUd1hv+XdN9LgqJRik8nOx6asa7yPXymaF81TJZIdoKW
 JVblMZ9IqPwvxV5ZozalbrliPlZw9E/exksc9vtEvgcgY=

Am 11.05.24 um 22:32 schrieb Ren=C3=A9 Scharfe:
> Am 08.05.24 um 17:25 schrieb phillip.wood123@gmail.com:
>> Hi Ren=C3=A9
>>
>> On 06/05/2024 19:23, Ren=C3=A9 Scharfe wrote:
>>> Am 05.05.24 um 17:25 schrieb Phillip Wood:
>>>> Merge strategies are expected to exit 0 on success, 1 when there are
>>>> conflicts and another non-zero value for other errors - it would be
>>>> nice to do something similar here where 1 means "there were
>>>> differences" but it is probably too late to do that without a config
>>>> value to indicate that we should trust the exit code.
>>> Right, such a diff command protocol v2 would not need to pipe the
>>> output through an inspection loop.=C2=A0 Sounds like a good idea.=C2=
=A0 It's
>>> unfortunate that it would increase the configuration surface, which is
>>> not in an acute need to expand.=C2=A0 We could advertise the new optio=
n when
>>> dying due to the unsupported combination of --exit-code and external
>>> diff, but that's in equal parts helpful and obnoxious, I feel.
>>
>> Yes, diff dying would be annoying but the message would be useful.
>
> Having poked at it a bit more, I wonder if we need to add some further
> nuance/trick to avoid having to reject certain combinations of options.
>
> Currently external diffs can't signal content equality.  That doesn't
> matter for trivial equality (where content and mode of the two files
> match), as this case is always handled by the diff machinery already.
> Only lossy comparisons (e.g. ignoring whitespace) even have the need to
> signal equality.
>
> If we (continue to) assume that external diffs are lossless then we
> don't need to change the code, just document that assumption.  And add a
> way to specify lossy external diffs that can signal whether they found
> interesting differences, to address the originally reported shortcoming.

One more step in that direction: If we continue to use exit code 0 to
mean "notable changes present" and redefine 1 to mean "non-trivial
equality"  instead of "fatal error" then we don't need to add any config
options.

A downside is that the exit codes of diff(1) have the opposite meaning.
Which is weird in itself: You say "give me a diff" and it answers "true,
I got nothing for you" or "false, I actually had to print that dang
thing".  Inherited from cmp(1), I guess.  Which I further guess got it
from bcmp(3)?

But we can't directly use diff(1) anyway because we pass either one or
six parameters instead of the two that it would expect.  Our external
diff calling protocol is already special enough that we can freely
chose the meaning of exit codes.

Any other downsides?  Am I missing something?

Ren=C3=A9
