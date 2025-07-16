Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2DD2F1987
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658736; cv=none; b=Xl1Bp9bnUZSMq9lycoNjbGA+ZfYQfirBZXk2nPqXrH020ynckreaKyhi7BWXXXVss8jKm/+LKdgfsgUqDggQPHtw0JhGOsBci3bPOuFodfgM36mYQ/m8HPA8AAyoxYwnEj1ah6qB9z/O1QuriBhxOxN2bsX5qI5f6/mPvUVqvKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658736; c=relaxed/simple;
	bh=cM2+zr28SjxZGyv76q3ZMbgo/qWERPF4TlXpBbTW8xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cp6IC56LT+YvL91iks7Dx9wzji66HmUegpdTKipzjnmZyBb2gKSU7YjIX1PI1pnz5ztvkCXA4PPuOQKT46Zl7uQdsXgSVXJFamB1ZBpqsA7OxN5ZH4+25rzzs4jUSb2DPhcsykgnZM2dwtyx5uZhkFEzwTqTYxIVEugMOaSWIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=RUT6JYDp; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="RUT6JYDp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752658720; x=1753263520; i=l.s.r@web.de;
	bh=UYDyNoKK8HT0KN0nI8/P5R8F4pY2GxpR27GRQbMkx1M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RUT6JYDp0NZPE8B4UbMAGCkGzC3KSdEM0n94MX29eK5G8DwFRueGmoLOwfUjSi6U
	 DfAhSjiO1bYTrXUnmKsXhrF+7KL+bEsfGogKqAYgp+NcxN8ZfKrDnRhR+45oroKbp
	 QAihQnbSGuaTqr+ejm/4pNM2fZ6IWYWuq84zM48srzj+UQE5HPi97a7rZOZ07JmJq
	 TKQ/MSIu0D/fN4Ra9svokFKsXVd1fL4qFvLk2/O2ueOZNU8pPgxW4tJsZFAPe54qh
	 iquR21MjKMqWxggPDqYih9WjVEHKE+FZrQyWXwFaEcgvGiqEENttfqq7KU7XTYH3l
	 SZZSJgwybbfOQ3P6Sg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOm0x-1uGB1r1Tax-00S0Iy; Wed, 16
 Jul 2025 11:38:40 +0200
Message-ID: <5a25d830-0825-4b28-8763-2be342d2b6a3@web.de>
Date: Wed, 16 Jul 2025 11:38:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] commit: convert pop_most_recent_commit() to
 prio_queue
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <xmqqv7ntdmlx.fsf@gitster.g>
 <20250716051533.GD1396022@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250716051533.GD1396022@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xneEFshuggWVboofUDZ/Y/TxRd+IyYP50Tslros1qQ2PwAqPz74
 KTcRNFZBuMkojhzgy/QB52u99aeXeAjlG4WH9ce6p43y1wRSFTgYCaGaioPqnMZEaBiYCmo
 B2QgzX2rHBoSRh48YUDTsR7VGcxgCrA4WOx81QSjEL0NM/2V3F5NoO6XIM3j2vr5dXy9ggd
 lJCCj1Cnow1mLz5UEbO6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sQhppj56O2A=;DZeC2iXoTqpiJpDY7Aetz9XwDZx
 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
 6Dt8jZOaSIQqkKNywJK5RK/Zk1nf4vgI=

On 7/16/25 7:15 AM, Jeff King wrote:
> On Tue, Jul 15, 2025 at 05:07:38PM -0700, Junio C Hamano wrote:
>=20
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> Use prio_queue to improve worst-case performance at the cost of slight=
ly
>>> worse best-case performance.  Then add and use prio_queue_replace() to
>>> recover that loss.
>>
>> Would change in the tiebreaking behaviour (aka sort stability) also
>> a cost of this change, as this swaps use of sorted linearly linked
>> list with priority queue?
>=20
> The prio_queue uses insertion order as a tie-breaker for stability (with
> earlier entries coming first). For building the initial queue from the
> list, I think that is obviously fine (we feed them in sorted order,
> which the prio queue will retain). For inserting while we walk the list,
> we'll produce the same results as long as the original code always
> inserted new entries after existing ones (in the case of a tie on commit
> date, that is).
>=20
> And I think that is the case, since commit_list_insert_by_date() does
> this:
>=20
>           while ((p =3D *pp) !=3D NULL) {
>                   if (p->item->date < item->date) {
>                           break;
>                   }
>                   pp =3D &p->next;
>           }
>           return commit_list_insert(item, pp);
>=20
> So we only insert once we have found an item in the list _after_ us,
> retaining the same order.
>=20
> But hopefully somebody can double check my logic, as it is quite
> possible I got something reversed above. ;)
Yes, commit_list_insert_by_date() is stable, as it inserts commits after
ones with the same date.  Items are popped from the top, so this ensures
FIFO behavior for commits with the same date.

prio_queue ensures stability using an ID and favors lower ones, so it
provides the same order.

We should add unit tests for that, no?

Ren=C3=A9

