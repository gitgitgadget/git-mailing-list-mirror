Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2704AF4F6
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="QJcHksC3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703779548; x=1704384348; i=l.s.r@web.de;
	bh=9GJd0WaSCv7XenUmBQE/JD7vQpFQ+WijCkIOtMb7ryk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=QJcHksC3+ClXNv4JjRCtM9+B9tvGDLmfvZ/IAzuEqH8QrWC5Bi8fDJx91gVzO7pc
	 Jc/8cObjiY8erx2+pYf3BpPTdlEDoJf55JjzJDerWDCKBXDnQpVx9fEb8PB1CGa2k
	 FBg0+5jSZTuB8vI47tZAQ6md/bo3RZFJ/NaEwru7F7LUQvaTRHkqFIRqdqrxpF1TG
	 yXSmOPHkWL0poW/LE01xBqsi5AiHAj4HaFa4RENRjm+0xM0MTnAZ4yaUHyNe5rITE
	 HKuVhTFAV1g+r/DdwQenla4PXPMNSWR1rQ7pQI7fo4tr6qJbBz6rJXdglnV3N441b
	 ZK1rDOenGXVK7yGzpA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MumNN-1r1UhL1XU3-00rfXC; Thu, 28
 Dec 2023 17:05:48 +0100
Message-ID: <c5d35735-10e2-4b71-8fc7-6218e7002549@web.de>
Date: Thu, 28 Dec 2023 17:05:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mem-pool: fix big allocations
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Jameson Miller <jamill@microsoft.com>
References: <fa89d269-1a23-4ed6-bebc-30c0b629f444@web.de>
 <9aad15c8-8d3b-475b-bd44-5d24121cb793@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <9aad15c8-8d3b-475b-bd44-5d24121cb793@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j12SdZtsZCanex1SmoCDpE9rU5440NdICtiUtjnRmOZeS29VU3e
 orhlP3/bwA7ePMtAWrcA9rVUGJjW6Wg/yJDkHENaciGqWEaD1kPxsOW/o/RYQBk4Pp+k7Pj
 UGS0T/0vDKU8QJTkdONfEAI1Q1PytRhpcR2lI48PSphcbtnQxTMy4yIC+Nxl3/Osl2Hjaqo
 1mtAUQdVMiPKRW/kVH2Yw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ag4FgGm9bVU=;i20JkUxp1Du1jwMt6IVQN0vTrDd
 SLSrl90Yf6WNyd/K8UPHCf7++Uh0pK5/SmMnpKXGe//HnFolRb9en9T1e/KIw1Yb8CGuVCrbm
 +D6RXUWQZvRJNdruW70DizOkn4yImksdKzY5/AMU144SclCXfpXjHkC8RfwMvBjHIaVPQ5FHx
 UY77ClNXxRm21p8bf4GIKj645opSoOhW5hy90t4Yie3mlM0cPLuKSXeARPFrgZgadAZnsXrJw
 dCoqUgsiH03cEIigKTZ5ZKpZ3AbVDTJfGdMf/+bK+4BvtSvV9C9KflV/s7aQ4roDq2m0446E2
 tzlOoMywbwFS/L+2Qioc/kund9uQmBMG6Ox+/1lsAZw1JM/Qy3YKHYkhMHLZDC/x2ki5uEF8f
 T4FtYWqCvUpgTsMUf0fRpwYMGeUKkmTwC1RQ8yFzv8yHIfQJUVhXCqrNWj70BglvoPPpyRoYd
 KUao23BfM0oTb6yeIl9orbmBaqLpWoGM1JyP8cReMjNlF7j9wBdnOoVArO2qPkHrAxgU14MM3
 cOAn32F1+dnAqUhZoQwS8i7j02XdUOy/+d8YkJ/629LreRNuTm9shoUzVeIi6Vk5MM5L5vjX8
 xiDZYiIxCvWH/OjjBWdYpipOqhwqL8ckBGjkclFCQihsk6uZKe2DNS2T4S+S1ap5neJ8zh69g
 Q0l+Cf+jsDdlHNJrP7kq00dKIScNlr7YFs5P2yLL81qmzvWTUXkIcvvFVv0tS9qOrIWIjFkuE
 DcT3ilB2YiKUpWJaVSycjqcGddPuGIOJkM+E9Ym1s9BthNfkae0F546kYlZfiT/wHk4fIorYb
 yuFRV9Z81HOvrniyme12Yq+VKzdXeQIk44LbN2rbTgWPq3KhuxcvYu4bxZSTD1UFfHOLILH4F
 xJoE46XpdbH8BO39Fvs9mYA9bnjEPKRaPCQ+Qwo45URHLld2jHc05Dec+0d6SphuqhSbh5vZi
 vTF39Q==

Am 28.12.23 um 16:10 schrieb Phillip Wood:
> Hi Ren=C3=A9
>
> On 21/12/2023 23:13, Ren=C3=A9 Scharfe wrote:
>> +#define check_ptr(a, op, b) check_int(((a) op (b)), =3D=3D, 1)
>> [...]
>> +static void t_calloc_100(struct mem_pool *pool)
>> +{
>> +=C2=A0=C2=A0=C2=A0 size_t size =3D 100;
>> +=C2=A0=C2=A0=C2=A0 char *buffer =3D mem_pool_calloc(pool, 1, size);
>> +=C2=A0=C2=A0=C2=A0 for (size_t i =3D 0; i < size; i++)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check_int(buffer[i], =3D=3D=
, 0);
>> +=C2=A0=C2=A0=C2=A0 if (!check_ptr(pool->mp_block, !=3D, NULL))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 check_ptr(pool->mp_block->next_free, <=3D, pool->mp=
_block->end);
>> +=C2=A0=C2=A0=C2=A0 check_ptr(pool->mp_block->next_free, !=3D, NULL);
>> +=C2=A0=C2=A0=C2=A0 check_ptr(pool->mp_block->end, !=3D, NULL);
>> +}
>
> It's great to see the unit test framework being used here. I wonder
> though if it would be simpler just to use
>
> =C2=A0=C2=A0=C2=A0=C2=A0check(ptr !=3D NULL)

Yes, that's better.

> as I'm not sure what the check_ptr() macro adds. The diff at the end of
> this email shows a possible implementation of a check_ptr() macro for
> the unit test library. I'm wary of adding it though because I'm not sure
> printing the pointer values is actually very useful most of the
> time. I'm also concerned that the rules around pointer arithmetic and
> comparisons mean that many pointer tests such as
>
> =C2=A0=C2=A0=C2=A0 check_ptr(pool->mp_block->next_free, <=3D, pool->mp_b=
lock->end);
>
> will be undefined if they fail.

True, the compiler could legally emit mush when it finds out that the
pointers are for different objects.  And the error being fixed produces
such unrelated pointer pairs -- oops.

This check is not important here, we can just drop it.

mem_pool_contains() has the same problem, by the way.

Restricting ourselves to only equality comparisons for pointers prevents
some interesting sanity checks, though.  Casting to intptr_t or
uintptr_t would allow arbitrary comparisons without risk of undefined
behavior, though.  Perhaps that would make a check_ptr() macro viable
and useful.

Ren=C3=A9
