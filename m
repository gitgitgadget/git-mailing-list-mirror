Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9489474
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720953356; cv=none; b=pTi1cCcshLz63JZXV1CU+qaR86n4tQItwyEYR98m7ZHRhstYZ9vv1gbrI7AQx7jnr8W6nqRgejSyybv37yiHT1bTxCf3i4rSin8XQ5s+I40+sFbXb9aoAwoqnZWyARUDzW7CaLnZDU7HcTwHFaMP48zUtnoJyX8UUpj5W1+h4Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720953356; c=relaxed/simple;
	bh=GbhcbPJ48uiDat75tIY8Cn2mdfvmDG4BhXnyNrqNNGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/JjUSEP36HvXOhMyC7TXjqi2FBYKISUwEps5I5KJdSJlNU3yV/9rEccz1Rh7bibdpeWgl/qQaBMrlP/0WOAFXzYCXictdExgXTAnNAfB2VZaCpjnWSUbTRQ4vsqXGo3yY11IvD64+JCtwu65x3mR1Mh2yicqkipWvfb1fC6gKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=oyrSN2K8; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="oyrSN2K8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720953342; x=1721558142; i=l.s.r@web.de;
	bh=+rNTw8ptctidFyO+cJuGKxqZIKcSCn21dpXL/RgDmXI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oyrSN2K85bOybJcFMqg7Tl2y9grR+OHH6lUSrhJgUsOf7FxxT6MNcY0OXspE13A+
	 Bn7N9WjuPHL/370D4Hewzyx/6QvuAQ7LSV1+WSU1APKEDuYJI4DPGB90IyYYGeGb4
	 h/7Rc3mAL/7rJRqoWxpMLNY+NmnNnCC/db9ss9sEVFGWQpQHEEDLusSZiKLwLBqen
	 SaNUNfeV4zQutMPmC1hBRF6imt0/6m0TGcVVgl4V3+khTLCUImHJmhECH/tpA7bmB
	 53Og8knCr3/GTn1nDfZ33XypXJIxfioHA0ugqig6z+QoE08q/l8j2Yb229gSzCkA8
	 84foZRbvYn1LvJNILw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2Phi-1sVgvo2URS-008dFh; Sun, 14
 Jul 2024 12:35:42 +0200
Message-ID: <c14a4a21-9812-497f-a05c-f8e913a1cc02@web.de>
Date: Sun, 14 Jul 2024 12:35:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] unit-tests: add and use TEST_RUN to simplify tests
To: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
 Git List <git@vger.kernel.org>
Cc: Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <xmqqy168uc8i.fsf@gitster.g> <38c962cd-2691-4664-b262-6eb78b8a61b5@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <38c962cd-2691-4664-b262-6eb78b8a61b5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nrpqFDRPmWiUOWkVOVo6qz3xSW/FODy0UrwBYhnU7xiVwCSx3EX
 /TYZ3Y+oYd0FtYTHQMRab+aTBSXk2zuk56/PsjcbVEhg1RviJTi2+r/UFY1UdW7oCvwu5X5
 K6tspM7SLgUJ2GeGlzbkib7LY0VyX9HolbYODPSvXxa6zz5z68V5LKnPxddpAKAkuFAVRPo
 V0glZtFwUb0P7tBtOenAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TtzMGmF1ESw=;l+sf9ZlLoBHDov91wlGX2tvxNVu
 nLg4m+jUMl+gBh1+e4xDk+Zdr7iiTed3GIWe0pLo713RFavrV8fqoiK1IY5i/Ndh2gdjQVwMc
 Lu4+1SpcKoaY59m+X7+SQPwRadNQoCARU41QaUlqV/386ep0gJiQZdD/h+A7rTR+/wx14tqEq
 rnaqpGjVNGYtx/fEL9oD/jQyQ8mK04C2KJ99pn8lbO/KJt2XcZko6zDBPwUPn21PUuShXFiuT
 ub7nXFrWBlgM/osanXwLS0GzuddDmCbVdg/oYoWP/qYYww+VSfTXOhq4ZfwUFjfiCtuZqWVf0
 V/3j3ZRq1hL/eGqy7bK4peW6+5xuyb0U3wnIRaOFr3VggeAPTnNF7YSQiPemfN4jVQHiwxF4V
 Jl4Lmh3Z2n8oqfUvWrKwcPrVnesu6qAA3W9E63bRcBz7MElPavHTF/K2QAPUW7kYtXBYGnMLw
 IL0H8l98Bjtks93zDCWlvLZZuXcz5anoLgmSwbWne22oWSXgfZJn3i2Ruczhkar85wkkzuQK3
 CCsm9LQoUXFTh03c4CfZXeAY6NAve5G6XVQS9wSUrDDEagbBGz8BC1v6Ir5QChXJreZgAcM+k
 eFhFTWGbYOS3nqDUAO1ssthfmO0QhD1mVJpiuH7PN1qmi6F2asxDPypy+voMkBxlw7ri2lQw1
 g2iSv/df+AZPsHn/QcK0rkgeVwmufd+xpoTq+5/aYkkZrbLVr8dzEuYxCunrJQslv9nEvgco5
 BXjpLgu2SVh7uP/8KWmeYLEjgr6MwsZAYWHCEn86fsgLq5VH6hsx0jgGX0jyjeFA3OmwU4uZj
 C7VZMGk7XFO/MIxYNl/zvp+g==

Am 11.07.24 um 12:05 schrieb Phillip Wood:
> On 10/07/2024 23:13, Junio C Hamano wrote:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>> So, looking back the discussion list on
>>
>> =C2=A0=C2=A0 https://lore.kernel.org/git/85b6b8a9-ee5f-42ab-bcbc-49976b=
30ef33@web.de/
>>
>> any loose ends still need to be addressed?=C2=A0 I didn't spot any
>> myself, so I am willing to merge it to 'next' soonish, but please
>> stop me if there were something I missed.
>
> I thought Ren=C3=A9 was planning a re-roll to avoid using xstrfmt() in
> Patch 2 c.f <97390954-49bc-48c4-bab1-95be10717aca@web.de>. Also I'm
> not sure we've reached a conclusion on whether to include the "if" in
> the macro or require the user to write "if(TEST_RUN(...))". My
> impression is that there is a consensus building around having the
> macro include the "if" but we haven't decided what to call it c.f.
> <62d221cc-532a-4a6d-8e96-b5a246ddeb1b@web.de>
Right, thanks, and I'm back now from a surprisingly exhausting business
trip.  Will send v3 soonish.

Ren=C3=A9
