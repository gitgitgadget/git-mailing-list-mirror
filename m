Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6264286D7B
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914903; cv=none; b=dplhgno4Kzs/yPKSDw/HwxnTKP7kpgV+OYPy1vU3SPdI/FpY+7/uSS+qK89WYi55ZPDIjsXk/ak7UtOTghRlrodE8+Dux/7ny9T6EKWMtq7zSI0kbi7zQOPDbiAa04ggL1TZEhQmH2AyLelQJGeVErIdwHHOtD44y773JbQgkFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914903; c=relaxed/simple;
	bh=kbrAWM9VmWqWpOhPFPQkyEB2dVB8M7mbSS7An9MtiKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLpscHrNBQuCQS4HGoQLer0+S9hZmLi8C0PxijLzl3JmObf1E4h0L4/dam1B4g9SoTpeqP6jumoc0EMQkIRvnVtvjFCZVYI5Kzg+6h3Cr/dUdJhsz+iEpq8rujZ/EMzsRgVFyArVUskdo+uK6hJRzd9epTiaedEQSF3dfpEVYCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=CBXn0BTk; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="CBXn0BTk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756914899; x=1757519699; i=l.s.r@web.de;
	bh=DyQzl2KytsWrwN5ZYbSg0zVtuhKiHO+n3MZfimqRrBs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CBXn0BTkMqpN632TQoilWuHmSe719rOCozm6R7S/MMd7Cz9WzKkWPTPJUArdO5rG
	 jFNWN4mThzgodeAdghPS0kJWo+TS2+9ruOZMCaVpTYGnjU6v2q64gpVMhz5Lzeg6D
	 kdSsTzWcwQuNC8AQD+ecuWapn66JG3PGtMTX6uNGczA74inCxoY7DnJaUKDawQV5J
	 dJPhQn50kmxe+4V9ooWgYbJfzENljYoFzOg257KqCjxZW0faEd6McjKWpYCMuuNWJ
	 m16bX4I0fTD4Yon3QcpED1yWjSusTQLwUuplcDYiY9ppiEyz1p84jNPD8SuWJs8ow
	 wYKcN6L7cU0jyKw2MQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.159.98]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N14tM-1uRpOm1rH0-010htW; Wed, 03
 Sep 2025 17:41:50 +0200
Message-ID: <f6b4c1fb-9f59-4072-a796-e2971524ffa5@web.de>
Date: Wed, 3 Sep 2025 17:41:49 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] describe: use khash in finish_depth_computation()
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
 <20250824103117.GA250458@coredump.intra.peff.net>
 <6402268d-bc80-4bfe-abb8-edec9e1b8417@web.de>
 <20250825073403.GA332447@coredump.intra.peff.net>
 <cb192b28-d85a-4866-a312-df4408cae93e@web.de>
 <20250902123834.GA711442@coredump.intra.peff.net>
 <05b8e161-9087-4eb8-b049-6e99ff288af7@web.de>
 <20250903143134.GA1884731@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250903143134.GA1884731@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i/pGIgrU+n5KmqjtCtNBD+BaQ/Ij0HnGqLDFeoFsV8vPYM+MCQT
 ub2CB+aAl+U9oXixeVQK7RJWmdq6n7aGT+gl3k7iDB5Xc4yM6c8OjaX8MmtbkmmDYcT8Sc4
 sFbGJT46KP4OX25cx7lpD/DfZ8IbArrTK2D4852+txa1xHBBCLmxmo0vwwBYNgXBLpU5df0
 aSRDUFRvPKXHYaTOHSEJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9zBqlaFnXTM=;WM+DBiMTQrQChQ6ecJ6lZ/H7q7I
 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
 i8dXp8fLQI8vyOrj4TBY2x7MltEa

On 9/3/25 4:31 PM, Jeff King wrote:
> On Tue, Sep 02, 2025 at 08:51:37PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>>> I suspect it won't make a big time difference. The old code should hav=
e
>>> been optimized down to a single word load, and now we have two word
>>> loads and an xor. That probably isn't important compared to the actual
>>> 5-word memcmp() we have to do in order to verify that we found the rig=
ht
>>> bucket anyway.
>>
>> I see slightly worse performance, but within the noise.
>>
>> However, just stacking two words won't do if only a few bits of the
>> resulting hash will be used to find a bucket.  We could mix in more bit=
s
>> and smear them all over, but if that's done by a deterministic function
>> then it could be applied during the construction of manipulated object
>> hash values as well, no?
>=20
> I think the difficulty in manipulating scales as the number of bits
> increases. So yeah, if you are worried about the low 8 bits, then
> XOR-ing in another 8 bits is not going to do much. But your table is
> only 256 items long, so you don't care much either way.
>=20
> At even 16 bits, it gets hard for the attacker to choose the low 16 bits
> _and_ the low 16 bits of the next word (you mentioned a project earlier
> which claims 28 bits). If you XOR in a third word, now your 16-bit hash
> is using 48 bits that the attacker has to control. And so on.
>=20
>> Perhaps salting with a random value determined at runtime would help.
>> Not XORing it in (pointless if the other value is controlled by the
>> attacker, as the result would still collide), but using it as a mask to
>> choose the bits to take from the object hash?
>=20
> I think that would work, but XOR-ing the higher order bits is easier to
> do and I think produces a similar effect. Let's shrink the problem for a
> second. Imagine sha1 was 16 bits, and we wanted to create an 8-bit hash
> to use in our table.  The attacker creates two objects with binary
> hashes:
>=20
>   object a: 10111001 11110111
>   object b: 01001000 11110111
>=20
> They collide in the lower 8 bits, but we don't want them to. In your
> scheme, as I understand it, we'd come up with a 16-bit mask that has
> exactly 8 bits set, like:
>=20
>   11010110 01011000
>=20
> and then picking only the bits where the mask is "1", we get:
>=20
>   object a: 10111001 11110111
>       mask: 11010110 01011000
>     hash a: 10100110
>=20
>   object b: 01001000 11110111
>       mask: 11010110 01011000
>     hash b: 01000110
>=20
> So I agree that is hard to foil without the attacker knowing which bits
> you'll pick. You've made their job 8 bits harder, because they now have
> to control all 16 bits to get their collision.
>=20
> But if we instead XOR the words of the object hashes together, we get:
>=20
>   object a[hi]: 10111001
>   object a[lo]: 11110111
>         hash a: 01001110
>=20
>   object b[hi]: 01001000
>   object b[lo]: 11110111
>         hash b: 10111111
>=20
> So you're flipping bits "randomly". It's not truly random, but is coming
> from the rest of the hash the attacker provided. But for any bit they
> want to control, they have to control that position in both words. So
> they're back to needing to control all 16 bits to get their desired
> hash.
>=20
> And as somebody who just hand-computed those answers, I can tell you
> that the XOR one is much simpler to do. ;)
No doubt. :)  Using a deterministic function is easier, but also allows
an attacker to use it for finding object hash values that yield
colliding hash table hashes.

How does an attacker control object hashes?  Hash it, check if it fits
the criteria, if it doesn't then make some inconsequential changes like
adding whitespace to a commit message and repeat.  That criteria can be
"bits 1-16 are all zero", but it can just as well be "bits 1-8 XORed
with bits 9-16 are all zero".  For the former they'd have to roll the
dice in the order of 2^16 times, for the latter just 2^8 times.

The attacker in our scenario doesn't have to care about the individual
bits of object hashes, just the resulting hash table hashes, which
reduces their search space a lot.  Making the deterministic function
more complicated or using more attacker-supplied input bits doesn't
change that.

Ren=C3=A9

