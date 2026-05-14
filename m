Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B275025B0BB
	for <git@vger.kernel.org>; Thu, 14 May 2026 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778789880; cv=none; b=eimTpLW2C8k7PrwEcUagcLk1lLKvOMqQLDv1NiamZXvp0phrJIEBqNu82lyQgwtBQ+3i3aXFfx/ooGMADfPJZk6wXa0cIFEayGg04nMCekSmQsxDAjVqjhRQT/4F8i3BGrqoKDUECSfYmNUQ0IgbZHw+oNSaBUER4S3KrlzORDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778789880; c=relaxed/simple;
	bh=2tf3oc+CCcPrXc3evfv8h7Xdycbwl3lwiRFEevocaYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifY8acQBIe+lZg8TQXgerPKoip00taCgDqMZ2QeMWPyXoI5Zf+m7j4Ry32ygX1vZ6RycIoVTtp3nNVAycKAThhnjzOcAb/okUtIv94rpSy1LR+fHEuOQfkqjVxjbSPI+jLl9w212VWMFaLhx+ojq2XAGfR390GYYNZUuX/Gw7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ReIZTB3F; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ReIZTB3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778789873; x=1779394673; i=l.s.r@web.de;
	bh=whAh9xqyy5jd/B1qme7uof+DmuaXMXUY72qUsx/oe9o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ReIZTB3Fai7ZidNdBRy8mAaASr1MeTK5lURki/JNOxkzsVMiathUo8GdrE2OVHGH
	 6LHiMzUgm53CMhcwG2wakqMhiUWc5eQsWYlrJKfUw0b6h2RQL7AROBt86UQ8Okb0I
	 rZBwZfZXhG6W34KpNejtA2oIKHxP9fN7LfdR4AFQdcGFBBt3/Z+3xZw/t04koH6E2
	 aG50vcy+ywRV7w/4ZwdKkdWPi6xh4mVTeL2IkJgKEjJjpV0BfWgoZ33siM7SIhepx
	 FxePKymb19b+r3ApMaT8KdBT1jsLfbi1cTl6c3HtOzPKHiQUimx2rrMrM6AqfjsiS
	 fVyUCydcKBRCBV4O4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHmlu-1wZ9Lb0JGA-005xll; Thu, 14
 May 2026 22:17:53 +0200
Message-ID: <fceded1f-60a2-48d2-91fc-5d2161272868@web.de>
Date: Thu, 14 May 2026 22:17:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] use __builtin_add_overflow() in st_add() with Clang
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
 <0ded6062-f66a-4713-af24-d1b5aa654823@web.de> <xmqqjyt5g5zr.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqjyt5g5zr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E5z/tYOY2vDatscRIyqHHcSlXW/YAf+TpZ2DEBqh/95aeVXvoWN
 78HK08RItCbNixc9mPjVkFKsHDG24gLZxYbstxVKDAKqhyIG0Ln6odUNy8Ke7yaWif5xCtv
 hnsqmptx2ntiFxBcs1LSrHQu7lXOTcyX2OkgdXs3HLgBKFnGLsmA2wmsKQZxcFexGT2jTxA
 xYEZ6h9ziXxvWVKMCBEgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2t9w4seP7lc=;qbkzRfBju0ANRJWzBDd19/dMV7P
 JMtA/MzrKDNyPvTly5fFkbEEdmlDDRyoojKxaMiokniMOKGZqiqLe7L8m0sm+x6abMj9BOIP2
 UGalaYfFlXs1hPSWEQyIzeJ6BWNPxMyyy/vzdv4UE+jXgF/wOPS+w6qMbLM1J48CLxzIVTcJ9
 KWWanxOsH9R9FhOOvipDblyS9wXsBxjg/L0nHWxQUN97dOo3h1qpJVXisiogo2zRX1Xxv6+5X
 5OJrveWejoiTd6qSiyo9HL7QOvVRx1lfj+kAHEZA4d4+TNaLAAwYAOMBvrySt4seqdPPNq2I9
 9F78nfBHiqROa/gkWRbi1ez9ChEsc4b6TpliKSWqPAuy7Vk9YAjy/NTxc0l6rrM2mo++oGnM+
 +BfVzjwS61Notl1BoG7zgPC1RWvIpVWgzGjSOd01tyhaOeJXVAAO4GkT0IsnJK9Cf/lVsM6Wa
 e/MTnEt6ZTj/XfdUsrjE0E6UUIZWXcP2x13eWtVI1gZvRdZe+c63j+R99c6Ir4Ci5zeo/pbDx
 UCE0+YBNKym7/UxsTPIsc2QolIDpu+XEM4gVpCZdWxu6ZrIOX5LxtSFmBufK8xozRwNFgc1Z5
 GCJt2wlkUgngN83wZkd+CBxQQ9sBqzikPOovSZLZRN7n6h96PBgh6retUgOnrLJvaIWXngGcO
 lhJ7xwtvi0m5a/GD0r7rvCab8lZkyr3MRCcecwx2nT1zQfQPY1jELBh7BJ6oB+2i5ca/YHjIY
 tfysyMDt33ExRzuZlH8pcBQONsvV4lxIajxdxtgaU8BIF5MCeclPbLkx7VKCoREFklPSj0ET9
 EaDayH7nglPlthKzLXct140THapYlxf97lA5bKmAoMJ/fD6J0qSL8GKoyytL5+48Hvf+djGNt
 MsFJ7yAFCIpEkLM7mQDe4QBGYWovLQYKg/Vrt5q1A+FcuXOoEwWMAU1XpWZjk8wFH+n+o19pu
 5Eh7C+jmcLSJA1dlPlCF6NZ/j1nWTU01t64NOL5tzLNbdaJuter/x/E9iTA0mfBz7ZHFKgcXo
 IYn2mdpnlJ+95mNKL6LkNsSkUYpGWnWXPl3KqNeAahGeFnX9bOBIt/p/ANNUu6xB2vbiXFuXJ
 YDQg70OKOtTaDrbJtSUPo7ROIogGMfRcaIiwhCC7d0MzuuekzfkXORVB/tR48Eoc5T+k256Hc
 cNkw4tZzj5FooFoGVHjGHCEZLA/UJ3yQv/27ISM0qmuQ0dILXlORv+CzkJTL1QA4LVNiLYbWE
 1Kt5om5P32sHG9na9Jaby1x1B2q4ckyUJezufpIy2s+3eVssqcRR55AU8gc9TDpx/1ad0QSE6
 HzR/4ZpXthym/2ocgrDTL/nVuR84iqMNGup8ia0Oq1oNuDF/qdRp0QW/pEwJ5P+chxwhVKl9a
 P5+gHMvDyUwC1MdzRDMIDbEXEmY5wYKOWBfiF4PxD76kdB6o4eW1svycbI3/qbiCkwsyla522
 abylQLHHu7MXAUE5GpaYAiJylR+0BGRYkg+Z53OpjOGcisti1RujrWVAgPd94aJKivvmHRpRJ
 CCd2AIvXoHjrXgCsam1wI4v2/MRTIo3BZptWbBZOVwUm1/AKpKbAgRZW/eFTo0D4sCuEahN8b
 m3bm9+afl7x1EnX7t0RFpdc7U5DIcLKEQtud+IobAxTn/OtM3VdTWAGe09z4Yi/JAbNfeNpvU
 QuHTBIYlDKFinuCApRaQyFeAdjphJ8VceSscvCKVwyLuvtGBHchUEHIo6/Mkc8VM9TZKHjgN3
 9rerTDg9MMJWG97NI8rs1RwwJMtWKZMX8VwZb9acsOlK3aoAWAxrhOVfeM2tYg/pvDi7zQ/hG
 gzR0EbKL0vNMsxsBAGziHTZAYRBoeE/2jizy2uHpVo05b8hecbjCSz3LqxvoRuzUxbQXToeQy
 nZArL89gwZPQpL4Y7MfUOU6FtlCG3kOntjHevlsGrlsJNjWnGmPQaa3S01aHYNGU1onoitM0W
 wNAxVhRn/fTr5q7e/EHG2IparCnb+00WNh9lYOXk5u4xH3T0y6H4fOLwfyI+lQp9bdWtiBwDL
 b+07VZyjtABRnc2+XUmhQ5qrfoRNAPGO08sl+i8c7lvZkWreqID/f+1lkLUNjl6HNOp1dIQr5
 pCZ2UdAsTgVEV/NlKgtr0zYaAr5o2/wWp+Imdgu/Xx9cpJL4MqoW26H4A4cT/Ol+lZUZB4pCX
 +BuC7u0mk8vc2sH7EeOjb2sYFmQZL7fo0172X4G2BDyYZ0PFsLL69fpyrbOGSA2hQQ1vzoRTr
 qW4kblcwhLvYH9+yCu/4jqHvYH2sYjzWrEAcCcV4R+s5RGx8Ny+DL9UUOW0jcSEw6Xn6A/hnQ
 +8o264nKDXwNqxCBGbYjPRcNK/XEQFSTDctpcD05veC3ToE7JB4IpHp5hecMfOraw56OQNWAb
 sIApGKCPK0dYJZMBmN2FB5HaZKfwXmsDfXwwj3S/WX82tzFH2l//Bo2KGZOdUErn2/S9GfotC
 yus52NYa4JZPHdh5UIBmO4jhMonswQthEX8/4X3pkXfhZNAWL4L/A8LYUvEyxHtQvK00ZjXXZ
 TATi/QCBGnUF2YTZPSs3l13KrNd+8YfstKDw1fqFsvdgxvBV9YrJVzAHdjoeTb9QqDexxEiJo
 5VvYeLEr3SgE0pQhfmMCJTUFzDwhCgDi6VlLqshzfunRYewbykbVGLebstYqRG4IsU7HZUP2W
 4HFAjbqtEpWu2iMUQ+p86c6CAQKktNBL5lSavJe5jrpClZFhtKaApx81ACWNSd1YXxvNIbFk5
 uHDZE8iZGR+hKpJzKpLswbyWyhqO6J5DErBzb0hMLaBtA8Ii+7ONcblFQJI5ievB+qtyzJMMq
 A4q+w+/7Nd+m2H/W+KtXlxpvdXHW/G7QMzuBmAQG9IUlZ5aFFUhksUl08aYgGZLY0qvadnjDr
 3HgcZKwMYmijDtSES6jPf52i+5LXfG+stmF75Am1sFqB1TbX6Br8RcftPXcNieHdX3iogrPGJ
 zN/mjr2BIEv1pZf72xN8CH/F/4htas4IplOurmuv1wRaR38cyQ6HtW+TZAOQ6c5b3tmrQK97L
 /3sgpjCkp+cuU4QzIFiPHwhLuKdZL9iK5konSMKEw2uuYrNOkv14Rqy2x2Uo1TDycAaqr68ZI
 wGG8dOESb6Y98qRE9QyFaHQgMOxCeanDevBsuWLrh5yP05xIH+R4uY4rPsFpE6dqvKAiK+FC4
 WoEr73x8c911xdNfwy7ZYIuneQmXoRRlrmyb/lAid9rbhmtgfeXbWdDiWADIlv2Q+VhC/KGKC
 WPFwsG5U3temXdyoIylgyNF6CfigV6iZnxOn7cfKb3XElcEdDtaLwFRZ/f+o1E7qi48FW00I7
 SMWiIw7DT/UIe+iK9PnVO70iTxbZcxVV5zoiX8nI8CUF+FriYveY5FyudH/h4H6w1vpeXF9U3
 PJPoIONEwGR/HUzcCkgYm8yX4HkR1iGYoF1dfK9NQhNWaLHoh1yNtOF4nqOPHKbU8d4SA1lNI
 UYNESr4ceJPcUgknO/EgLVB2kjBEBCo+nMq8rpLfsGT7tKwjL5lMQIzmZCyoP7Q90R+9WeAqs
 /QwxDMEQzUEZWUkVJXXj1hNVDilG9za5vsq4sWu/Dyo+Bgnv5Lnn58xvZroHNbDZn6ziCnxtj
 u0wwEXOZ2UEEaGKmra92WqRX4L2Yie/oZxGn2WpV389NHpmFL5W/ShsM4C/mfIQyxHq0nmn+G
 Nvc8Sk8PBiS553RYX5/ZTcmJkjaMobVQfvNm6WEDAN0NCK8B2QiUttRHm9lG70wF1Z6CC0SG7
 shcEL3M4cHFHMpuLaMUuLlg5ltEMuu3ptwggdlfLP7nYK7YcZzLRE3VaYSyZxkSS/Z8ZUHibR
 Hn4bf8h1k3L8CBmKZWmDrx2AX04BYQ45M4cFHzZItx244o8jmG3qLJ03OokyWgXZsDfdo+4R2
 f9y3eIR3nky95iThL+NobYvNgG1MhwTbZWIAGZ+plyJLAxfQ87fadgUDX7ee7uNkEfGhOnXOR
 kW2/maueDI7URFAcFaoe+7+EeKl6mmAMAC4XQsSffctj/MwgD0zERmptWuqIkhHh0vkF9EqAr
 c7P8LhMPz0kONPlu9ZZZDWMSsLMB08WTtUwa5jNXD2S37fsca313CfH1ENV8OnOvLLwCNhdiz
 JbUME+pQV3HtcmPW85iaeJrL3B31O4kpA4dy5/FBqseU1tGBwuZQvP9mBy+PDauYqdrzTOONB
 flu75Yaa71o2n2iAcIjL4E7kCDTExr0gfucdx457LHxavwje15aOEm/KDPyteUTfRvtysSb6/
 kUotmnNF0jHGYxpn4TnKreLfrcUpGitK72hwk/6diBmtHu2OqSS4l+mrtbc9hby9scYk5VpBE
 C1TeusZaI9FeCxhls8sMNbzww7wreLSRa3BKeoUsMX0nEw5LXWYsok5hW/fHSlAVysEdC/+lw
 HAKgkQuEkVOEYib27ysnVKdaW5zHTImGajblkkVULxVhiyWkkIMsczulInP8t/tojkscig7EW
 7deWjzuQQNdi/9jn2PLY5U1yw2JKV103QYogntaBEQrjDNeb63LWSKmSLB/+Dnrp2YLHbybJ3
 NuOQmn8qC8vdLcj9hu+Mflb4CKqMHRYBF3uSv63O5A0+jGgZaHU4/7EJ0JrIoMxYtFyY+uaHj
 qzyJOdUZ9yZGHs9kpvAIcB6Q6qaTwa3Nd305AFv3by8ATUUrl9QWf2zM8tyNGPvGZfr5z8ZnO
 Blg3vhYMGxiwtkXg7R+rpzn2SjDQGwIdpoFTg4cmwKBFsFlWNxmvfDdFvxdgv3sbHoSVKPdLv
 f6dEvskePLykRRQNQhNJ3wWdvBdEMT/w8MyePYWtnmADHc/EOaTtgNGBnBzHiVEBDoj+4Ougs
 ci02hv+BSrA4jxnEBAwlkEW+yLzT6K1IXVd0TCxSr3TTyebxdLWqnIruljVeLobCjelJit5B4
 OxbIdfW/x8IZEYKidQmzg3VMToiGiFi5ud0l29wfpxKjLu48sIEyZM8MCo0OuwUU73k/iE/CV
 4kVlGfSwrDC+wTLpp7Z7fPSsLdsqXjx9iYy3HyT+Schx64LaLXUEN08CwhX/bavfXskYV9eKv
 gpt9cvAsg6ErWc+igyBkTcCZ1iR2wKA7awK//GDxhFG2xBOn1TS7RC/5+HRnApdOtGMFdG6TQ
 gByJleLpSru7RcxI76paONH2o1IntUe5BNTOuIUP6+tlU6VswjKtf1JEjQ0+aMOYSpmy1mThS
 DLiMHeOAQ1FEWAaZmv9OI9hoj2vqrnOyq4V4Yeic6CLYViZ/9MpKsSBwERO6u8xKq5o4WFDES
 reIdoMX87w10vioh3tLqsBf/OioaAs5bQ5W4OM4nCuVSMRWlEgFicVOAlSQO62qFedF4Gm0pg
 3DrF15hUPoF8GriwFlhbmB7yFEkpqEOWVC39GsWNdoa0UkLkbv2d6k0Ta0N3S6qbbxtUZqnVl
 jy5E3AHdyd+7JO2IgTPGAvMVdblV+qsKaVL1trVuYKunfaI4jsHPN5XIru2a6CIqWFNA0b6XD
 +A1EtSqfDRszhpjov0BPAhfdgZsgmiY3Wugp9JU/4uxaACG0q7YIxBO9ucR8tTRQcH45YdmQK
 CsaCkgBBVJI9uhq3BfuOQNotf1c=

On 5/14/26 9:12 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> Provide a variant of st_add() that wraps __builtin_add_overflow() to
>> help Clang optimize it.  Use it on all platforms for simplicity.
>> ...
>> +/* Help Clang; GCC generates the same code for both variants. */
>> +#if defined(__clang__)
>> +static inline size_t st_add(size_t a, size_t b)
>> +{
>> +	size_t sum;
>> +	if (__builtin_add_overflow(a, b, &sum))
>> +		die("size_t overflow: %"PRIuMAX" + %"PRIuMAX,
>> +		    (uintmax_t)a, (uintmax_t)b);
>> +	return sum;
>> +}
>> +#else
>>  static inline size_t st_add(size_t a, size_t b)
>>  {
>>  	if (unsigned_add_overflows(a, b))
>> @@ -621,6 +632,7 @@ static inline size_t st_add(size_t a, size_t b)
>>  		    (uintmax_t)a, (uintmax_t)b);
>>  	return a + b;
>>  }
>> +#endif
>=20
> Makes me wonder if we tweaked unsigned_add_overflows() to take an
> extra *dst parameter to match __builtin_add_overflow(), which of
> course requires us to all of 18 callsites, it might make the whole
> thing a bit simpler.  New uses of unsigned_add_overflows(), if we
> ever add them, would automatically benefit, right?

Hmm.  It sounds like a lot of churn, but it would make sure that
we use the checked result and not check a + b and then go on and
use x + y because the code de-synced at some point.

How to do it, though?  It needs to be generic and evaluate its
arguments only once.  Perhaps like this?


diff --git a/git-compat-util.h b/git-compat-util.h
index ca89cfb0b3..27fbb622d7 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -103,6 +103,21 @@ struct strbuf;
 #define unsigned_add_overflows(a, b) \
     ((b) > maximum_unsigned_value_of_type(a) - (a))
=20
+static bool uint_add_overflow(uintmax_t a, uintmax_t b,
+			      uintmax_t *out, size_t out_size)
+{
+	if (b > UINTMAX_MAX - a)
+		return true;
+	a +=3D b;
+	if (a > (UINTMAX_MAX >> (bitsizeof(uintmax_t) - CHAR_BIT * out_size)))
+		return true;
+	*out =3D a;
+	return false;
+}
+
+#define UINT_ADD_OVERFLOW(a, b, out) \
+	uint_add_overflow((a), (b), (out), sizeof(a))
+
 /*
  * Returns true if the multiplication of "a" and "b" will
  * overflow. The types of "a" and "b" must match and must be unsigned.
@@ -616,10 +631,11 @@ int git_open_cloexec(const char *name, int flags);
=20
 static inline size_t st_add(size_t a, size_t b)
 {
-	if (unsigned_add_overflows(a, b))
+	size_t ret;
+	if (UINT_ADD_OVERFLOW(a, b, &ret))
 		die("size_t overflow: %"PRIuMAX" + %"PRIuMAX,
 		    (uintmax_t)a, (uintmax_t)b);
-	return a + b;
+	return ret;
 }
 #define st_add3(a,b,c)   st_add(st_add((a),(b)),(c))
 #define st_add4(a,b,c,d) st_add(st_add3((a),(b),(c)),(d))

