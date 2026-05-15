Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D198639B4A3
	for <git@vger.kernel.org>; Fri, 15 May 2026 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855443; cv=none; b=KHDu/uHE1JR3yWiFJ7/zinDJQvHZqcdW7YYdxf5qqY2RTqs1BnOD9pwsSqYFsZK7CJ9fnchMV3AULba7EDEwuYPoifmKf6YkSV2ZRr5ABpMnRlnFFjQF3jPQS5NHTpKbT5Q3b/21M2/dJBnKitV4yGM7j/0eUSh1ZFt0O8zXflc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855443; c=relaxed/simple;
	bh=RaUfpT89OI0GxITIGgc96+8TmHvPbJv1IelwQrRQ2bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zk4fJvGwaqVE/jpZG1BNmWK0V4UNeREzpvtbN/kYE40tDWepUBpTPKQZf35a+/IPjRVgYCZsjAZOl7+pTupRz94M7QEd7nCo8O0BTOCeC7hI88eI8uHWXgBAKyjSF73QT4sl5CSjKFi3dbFMqLlk8fYNkdHaoDYd8e30S643Ob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=bQerWV9K; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="bQerWV9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778855434; x=1779460234; i=l.s.r@web.de;
	bh=/Io54uikBSWlNG8jRIwsH5vg2kmvFiPR9TEGGxBoFjQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bQerWV9KN2So5C/LqnUCLK/r3jhGHC88tAR2ytMHg8Hu54c56JgXQb32UWP2q9n+
	 r1fmYyU6fHT4jZXNfwtCCRf0aCxAjrX/gfVU1ORvziR4ya0TcIvhY1ARRDsZe1tcq
	 Ygh4MZKUtV24/slk57MhPJ66L8odVPy4G5xpm9o4+GVy0bwcALBjK2KjCpwgphBPh
	 vMYoe4xRBb7qjdaem+CrlrVpRsCGctgbs0JjGXjkXRnOQ+J8nx1DEax2pdjPJeQQ5
	 8wDDJt/3N8EHlpc76GCx/a8/vpgg2zVmcwxa16mY/tScqu1ZqOCiR7tUQff4DYxQI
	 tg00apc8Cuu8OwUhFA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5ljL-1xTRir2eIF-00rBwk; Fri, 15
 May 2026 16:30:34 +0200
Message-ID: <459f5f2b-2565-4dae-9f9f-8848a5cb9d94@web.de>
Date: Fri, 15 May 2026 16:30:34 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] strbuf: use st_add3() in strbuf_grow()
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
 <xmqqo6ihg690.fsf@gitster.g> <0c3b4e94-b56c-4c92-a4d8-0e4364f1257b@web.de>
 <20260515043606.GA83595@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260515043606.GA83595@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/cWZ9vudpA5pgyboMy8BSlJLY9ctz/IKHWs13RkWLp97qLA8jiQ
 JUdh/l5vJ7t0T9sqM4PIRusdCtGIS11JYaHSmsMc1IrHDS0Zsqvon3JFhcPpWXUT+ZJZkWH
 Cm7dCv98pxmS1mYNfDoQWJvFQEPFKCdQG0X/L4IHUuSBc3zVflWQjdJNzZZaRAByUo/Zv5P
 Xrcv8raqT0rCcPV7J8dSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3dFL6SGQZhQ=;CoNb0vlfZelmnMBQ3B4WH5pjNxr
 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
 t3hjdwXK9C1CfyB2ug8yjuOw==

On 5/15/26 6:36 AM, Jeff King wrote:
> On Thu, May 14, 2026 at 10:13:19PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>> Hmm, alloc_nr() doesn't do any overflow checking.  It should, though,
>> shouldn't it?
>=20
> Yes, probably. It's a known blind spot in the overflow checking, but
> I think is OK in practice because:
>=20
>   1. We are growing an existing buffer by ~3/2. So even with ordering
>      the multiplication first, an overflow implies that you have a
>      single buffer consuming ~1/3 of your address space.
>=20
>      On 64-bit systems that's impractically large, and on 32-bit systems=
 I
>      think you generally run into fragmentation and address-space issues
>      first.
>=20
>   2. If alloc_nr(alloc) is less than the desired nr, we just use that nr
>      directly. So even if we did overflow, I think the result is
>      too-slow allocation, and not a buffer overflow.
> > But it would be nice to be less hand-wavy. One of the reasons I hadn't
> dug into it further is that I wanted to start making use of intrinsics
> to avoid slowdowns. But since you're already doing that (and finding
> that the compiler was doing the fast thing anyway!) it might be a good
> time to make the jump.

Didn't look at __builtin_mul_overflow() in detail; its situation could
be  different than for __builtin_add_overflow(), which turned out to be
unnecessary on x64.

> That's all assuming that no overflow happens before ALLOC_GROW() gets
> the values. We also tend to do unchecked computions for the "nr" field
> there, but it's usually just "nr_foo + 1", so the same logic applies:
> you'd have to have an existing array consuming the entire address space
> minus one byte to trigger an overflow.
The use in read-cache.c::do_read_index() looks odd.  Has been present
since commit one.  Is the point that it over-allocates to have room for
additions right from the start?  For read-only commands this only wastes
memory, no?

Ren=C3=A9

