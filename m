Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7152723B4
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="kKxCyY80"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703832794; x=1704437594; i=l.s.r@web.de;
	bh=3nMmld+KU2WrJFsAqqfkpUeSLPWasbdZMNGTXn0f93U=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=kKxCyY80IyFyUKZWkyKR9mOHZX+zEyXnVgjmrgzzosdGvhMm2sO9MAiA8askt0mt
	 yxbasR/pi24kp5TUb4wlreJHCHZSvIk7p1ZEEsOCgPjXFGFe8z3/heFng7bm5o/1o
	 TKdHhkEP2XpTQ4dZ0fS5TEbtwIkMqlOODHoMZamGNSWaiaTNRJxTi4388EkM1KDaY
	 EgAyaYqLXnwKCY8Q73fmeHqbv0nICe2jzpxPHyz+GXflWB1tjvZWJLj0bWjxy0R/V
	 MuW0XxnPdpweq3vEE9aU3Zg7wf+wROIH7Ow51dFW9BJCV7bof5tlONJ44jwpLL/wr
	 qh30zf09Y0TZ+J2stw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJWoe-1rYQfS02cC-00KDdt; Fri, 29
 Dec 2023 07:53:14 +0100
Message-ID: <0dd59d8e-0175-43ef-893d-3352a3f5f1c4@web.de>
Date: Fri, 29 Dec 2023 07:53:13 +0100
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
 <c5d35735-10e2-4b71-8fc7-6218e7002549@web.de>
 <e1e43a6c-3e06-4453-88a3-f00476132bcd@gmail.com>
 <34f5913f-b187-43c3-99b7-3d57065dba12@web.de>
 <48821d3f-2e30-4bce-b9e8-e4199c24e251@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <48821d3f-2e30-4bce-b9e8-e4199c24e251@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dRyAzeZvuVGQI3CYG7Tb5Z/mZOEngs+kIIM2fcWjWHz7sDcsVEI
 zDhLB2PxiljamtIaFALN3Dv+cNcRZ2qo2VUHrAvLvMqcBv7DIx7ZPVNhJfDzb9asiif1H86
 hcHUKP4CvPGp6VjyfcOvF88zm5qg13UVT5jH45lDysbNgwqArhNTtJH47fq+W7/UZu9Ri2C
 jMvd8OR9Wyd6o0La0F32g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Vqcx5KomFdM=;Qii9Kw1KJC36TNIIg42DsFXhj0w
 AgNdTIYZg8baaGFmXg+qWMDi5WcbpUHHoEzioPoHWgXSnjHZ/W+hZHYzPd6WP1mWmVQh4z3p5
 JA5E5OY4gsqzrLPRod7OZLm2zZ5eShwHxLb32HPArp5GASlR2JQGbq1aVOW/ntLS7wgfjIOKz
 lu9sJtpFIl7Vk7uJHlihwbXuB9BknsapD8aMEq5lS3tBnm9/z7+gH3BcszHy6NMHnX37Uu1aF
 071Wv3pM12w14kS5VUA4nF0hCX907qtkuQ30lIdwzWx7lDNZhkBbybTVKv1b+BFFwvaC47WQh
 mNg4EE2ZBciAbkHL/mqsYdq+3AaYR5Gc+FwsDwpUgNwQKiZBeX2y8fEh72Ig9we9X8MTqE8Tn
 l98NTQnGTjU63hYKsfGOoUVQ+o8d6SWW15+ev8g1HAD0+eZMrWdoomF3fEi538xm6ff+vneF1
 lsoR9HupweeLCnpYphSrc2p/bi+ObuFd+EqQR9csKoXME1F5WxktxiIC9xmoJgbYnZv9cFfgh
 +6ha5SNk4bEVoCJIOJoi8jx9CNnlNk4brktKQyfF8JoU7cmFt0Le4w0SYwQPddvWblX9hNlzG
 rmMt0Kv0HtqOABtYJU4w/Qgj5F/KPs8FGxcZib0bUsvad/khBeuXabwKLtnZtHIK/b6Ot4U7n
 MGFmqMtUxPF3f4LSj3vhHqFHbMxlOMEbRHQeZjmnOvdmuMMsXnGT7oV8AxceTh8mq7TuGeVOm
 TXc9ID+rkvcX5/gw9/939/iL4JGrXmXwZgxADq0qt0Ng8r5LMtgTvlmxmTbFdb4yvTOKVZ4pG
 tUOOJoFNBrgpJ8NIEMe0AiYCvRzoa0R+YoHfB9LcJBDBmBrJ3NZOjSjjy26GRNhTZ/14Hsssm
 u9X8XZJKXK3tGQL8XqgQxe4EN1H9wKXzI+MGK+XnlmEy210PXJkTNiKtnsukTvG1IoWrxR3Mm
 aFFuDIj3o3jmIfo//iBOU2jskuU=

Am 28.12.23 um 20:34 schrieb phillip.wood123@gmail.com:
>
> Exactly, my worry is that if the comparison fails it is likely that
> there will have been undefined behavior involved in calculating the
> pointer before we get to the comparison in which case so casting to
> uintptr_t in the comparison does not help.
If there's undefined behavior (UB) somewhere in the test or the tested
unit then the compiler could skip any checks and report success anyway.
Not adding UB in the test framework and tests is the least we can do.

Perhaps disabling link-time optimization would allow us to shield the
unit tests from UB in the tested code, in the sense that the compiler
would then not be able to skip checks.

Ren=C3=A9
