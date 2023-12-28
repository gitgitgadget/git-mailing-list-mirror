Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE40F9D7
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="AU7U3rrj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703789761; x=1704394561; i=l.s.r@web.de;
	bh=D45Tkwo62XIta/fWC4fToVUFxvfZCNxEwnWmQ5bjGYE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=AU7U3rrjaWV0dq7me+puu8G+RVPw1vy9GyPSu0aKvcegJxr3iC4k7vhFly8fz6Xz
	 oD0H978JAfxA3sXL3dvi61jbjLlVjHqduNz1S5nkZhBvkILoJV65rdYqFLntCNj5K
	 TUQKud8ippgfgFMXNJTXUY21mINzaUf6dXQwL/wQAETuIfjQXgQ4nGobvd4DYLGWS
	 /rz4Iu1yPdBjO0bXtzisWUDqBEsljbThQTAv5PziUq1JUj39NeSIzz8nTkzh/jb7f
	 9DiA/yp96zKmO3HI+GJ6p5AhrnlX4P7kP+OWtA2GYhbcJyzAGLuc7Lx6o6edT7ZSM
	 R0tCtRltzjGnabkGHA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1rTG-1rGjgv3ISG-002kR1; Thu, 28
 Dec 2023 19:56:01 +0100
Message-ID: <34f5913f-b187-43c3-99b7-3d57065dba12@web.de>
Date: Thu, 28 Dec 2023 19:56:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mem-pool: fix big allocations
Content-Language: en-US
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Jameson Miller <jamill@microsoft.com>
References: <fa89d269-1a23-4ed6-bebc-30c0b629f444@web.de>
 <9aad15c8-8d3b-475b-bd44-5d24121cb793@gmail.com>
 <c5d35735-10e2-4b71-8fc7-6218e7002549@web.de>
 <e1e43a6c-3e06-4453-88a3-f00476132bcd@gmail.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <e1e43a6c-3e06-4453-88a3-f00476132bcd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YzT6IEJCEM4FMSNGlzAwZJH89ARz6Uj7KPTa67D1HAohK/wuwon
 let/upy56evYmhQfMiIeRLzHmsNch2xAaH5doOQiL+dFSSNIrXh9dgtG+guMAGAgE1kx/g4
 Odm+tieomJSKrRbRjS9nTLSBgtI/lJ6RL+uSAOFxGDaYrn4oc4MEaX1USHqm2P//NkyhxSb
 dIffyFDh4+1XIA7U36FJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1/e2q37lczw=;5U7vVPfbU81FeiA0vemiw337Ri3
 D3bshf2RpBut/sZkCcOPE95SSNsCS6ZypINMnBAU4J+SNGfett8vZwFez/dI/GC5RTPLU7YCS
 SA3z+d7v0T32aVFNHNfJAKO99lqjOKxG7u+qKD3bDNqoU3frydKpGxuPHeO3em6x7PrEy+pSB
 M1zS1bLO+ZBSNxB7a2C04WWX0OD4qlcqQs4PhMZdtdR7DlycYjq34tgvIJLuSFgWhg0r2H0tw
 MxXV8b/KVG78xQZzG//4orsY6WQSDW3L8lB3SeU4xW8dXiuIbRzISF2MIEaTBXN8D4EXNPQvD
 BUg38PsVVoJ3+RI2R7viMJGEnarJo1RnoAOqHD/zXE6Njoex1eFCO2GqOYFnYOwWt+OiV+oKe
 ueQsxYy/xmEYGekpoXc3vjtJZ5rww3bxZY2GkEd8XMYKnAI81/fPDWpJ3ibNkGWGFTFFrzFYc
 Wz4Esawh63X6+Y7VrNLWzaotGQBzvrPA9u/DcKs6oQPa35XJwtwZNa/TMbXp3NoHvOar5px5L
 u8oxwZYLnA5RVIY+CIuXx7NUrp3ZMIivw0QEjN37Tl1bHDHfNOSGmufLYD70bf766mfaHqUYK
 jf4eNa0Xcq58k4xvkBZNlLy60y/553/IP3hEuKLKuazTqKL6XDat9qPXM5Yl18DF9bD8zMTHG
 tNrWWkJPldBl44LaMAS5bXeo1PfUOnqcBbxWRLFx+m70OlMqYE5KLImPc86woDFHUir9sfieE
 aORG5gU5cwQXTTD4g7hNje7WrNk7fwBP+uUXstrQIMS6LebOlvHEuMWqDbGPfBYAoXSyKDZMM
 osryX78tyIJqu6/WNIhWecBPgfOBYJqkNfZDUJEQy+kn2fTWOGPvOO4TleczSXMt/OgTDtWb2
 MF1sICUxUkDSa6FCk/dei77SnWv6ZifGBp5sdvH5hZya1GSaKCoAJFEoRlDjBJGsT5bTOoAt5
 DkukPQ==

Am 28.12.23 um 17:48 schrieb phillip.wood123@gmail.com:
> On 28/12/2023 16:05, Ren=C3=A9 Scharfe wrote:
>> Am 28.12.23 um 16:10 schrieb Phillip Wood:
>>> The diff at the end of
>>> this email shows a possible implementation of a check_ptr() macro for
>>> the unit test library. I'm wary of adding it though because I'm not su=
re
>>> printing the pointer values is actually very useful most of the
>>> time. I'm also concerned that the rules around pointer arithmetic and
>>> comparisons mean that many pointer tests such as
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 check_ptr(pool->mp_block->next_free, <=3D, po=
ol->mp_block->end);
>>>
>>> will be undefined if they fail.
>>
>> True, the compiler could legally emit mush when it finds out that the
>> pointers are for different objects.=C2=A0 And the error being fixed pro=
duces
>> such unrelated pointer pairs -- oops.
>>
>> This check is not important here, we can just drop it.
>>
>> mem_pool_contains() has the same problem, by the way.
>>
>> Restricting ourselves to only equality comparisons for pointers prevent=
s
>> some interesting sanity checks, though.=C2=A0 Casting to intptr_t or
>> uintptr_t would allow arbitrary comparisons without risk of undefined
>> behavior, though.=C2=A0 Perhaps that would make a check_ptr() macro via=
ble
>> and useful.
>
> That certainly helps and the check_ptr() macro in my previous email
> casts the pointers to uintptr_t before comparing them. Maybe I'm
> worrying too much, but my concern is that in a failing comparison it
> is likely one of the pointers is invalid (for example it is the
> result of some undefined pointer arithmetic) and the program is
> undefined from the point the invalid pointer is created.

There are no restrictions on integer comparisons.  So comparing after
casting to uintptr_t should not invoke undefined behavior.  If undefined
behavior was involved in calculating the pointers in the first place
then the compiler might still legally go crazy, but not due to the
comparison.  Right?

Whether the result of a uintptr_t-cast comparison of pointers to
different objects is meaningful is a different question.  Hopefully
range checks are possible.

> The
> documentation for check_ptr() in my previous mail contains the
> following example
>
> =C2=A0=C2=A0=C2=A0 For example if `start` and `end` are pointers to the =
beginning and
> =C2=A0=C2=A0=C2=A0 end of an allocation and `offset` is an integer then
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check_ptr(start + offset, <=
=3D, end)
>
> =C2=A0=C2=A0=C2=A0 is undefined when `offset` is larger than `end - star=
t`. Rewriting
> =C2=A0=C2=A0=C2=A0 the comparison as
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check_uint(offset, <=3D, end =
- start)
>
> =C2=A0=C2=A0=C2=A0 avoids undefined behavior when offset is too large, b=
ut is still
> =C2=A0=C2=A0=C2=A0 undefined if there is a bug that means `start` and `e=
nd` do not
> =C2=A0=C2=A0=C2=A0 point to the same allocation.

True, but in such a unit test we'd need additional checks verifying
that start and end belong to the same object.  Or perhaps use a
numerical size instead of an end pointer.

Ren=C3=A9
