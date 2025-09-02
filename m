Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC07285C82
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839105; cv=none; b=MAjsOn3hjn51bk8DTHRTL0O4NXSBypA6y8T9oQ7xXb7NSIu36z6essJi7FTgdk1iCSBliaS0o0TGGuc1se/9E6drwrS6Sz8c7NcmihW0/Aw4kgtZgW2syTKrupLEjcObclPb2TO/VtH0/cyEMQchukkvZPg3wJUntfoUi4tzgk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839105; c=relaxed/simple;
	bh=PjbbbBaop4Swj/YhWmt6q+kVkPUeHEGBh6oVejzcpiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDRn465prDJwWzcD4qiZvD4hS0B4fuTaZ047EPhQMhGaVxmTrYua5+LM2fB9R3OUdce6jdIrlZI16Y49WWn7jIVPal7OLqp5XAJR64qvY0iPEHM0kroazfWXPT2Ld0WxgMHyiVBu24mKerC4TTKFHCsyUsmIuS7ptwoedgvW5FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=fPaJEteV; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="fPaJEteV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756839098; x=1757443898; i=l.s.r@web.de;
	bh=VR8hqq/szGLfLmA6ba3o0B7dKXZz46a2/Xh88HAvKZE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fPaJEteVH6DTpAt+nxoG5gy8+i8lwrwVwMNb+ZkBgsKa5QG80eSZFPBkXV6uA7sn
	 oxozyxRbYil0BhxNXSMHyFN07ZHHg7tTFcAGmk/VYAKci7+58kI6LXHXRlrUdwTMY
	 8Misx3D0MZAnsyXEl0dCngHefavrArtA+3VWGYJdNYSsvN+zlxFXb5vBOtRDYL+a+
	 5Q+Y0T25RPTJf3DzYmOUSJ8J4667vkBp1UvqLLnGHD5mtdS79SlHRkJ+2oGna5mUp
	 nkGD+sLpeq1iY2ozFmnHRtGV3FFqcOlma4ONG5a0EraD7VYrbSc7vhz6H/MCx/1ua
	 7oIsnlVHxML/tTPSdw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.159.98]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIc3F-1uet6V1IOb-00G4if; Tue, 02
 Sep 2025 20:51:38 +0200
Message-ID: <05b8e161-9087-4eb8-b049-6e99ff288af7@web.de>
Date: Tue, 2 Sep 2025 20:51:37 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250902123834.GA711442@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U6/3nJbg7rvouAtTcKP1b7qZXOKFpB4rR8JMB7IHP3N2ZSUczZN
 6lMvYjHiGenPZu6AEjxut2EUI3Xc+pPMi/mzECenWQtIHpbraEZAb+fot4I+ABOWwG0iJhv
 8BH3KeC6l5WKWjsVpAPvEW4dpULrVT61CH86MGi4vdZ9mDW8yKJGPsDsNa9aMWE9wOLO1kL
 JH4XQq5nHeJf52yPZBdwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4qbTy5czRXU=;CtrtrbUNAYaH7urPkmBwrWfvN06
 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

On 9/2/25 2:38 PM, Jeff King wrote:
>=20
> I doubt that commit->index is any better in that regard. If I can
> influence the order in which Git loads the commits (e.g., by creating a
> bunch of refs which get loaded when we walk over for_each_ref), I can
> choose the index for each. They'll be unique, but I can still cause
> collisions modulo the number of buckets.

Hmm, sounds tricky, but feasible. :-O
> Likewise for oidhash(), I'd guess that colliding 4 bytes is not even
> necessary to cause trouble, since probing starts by throwing away
> everything mod n_buckets. So really you just need to collide however
> many low bits you need to make your desired N, and then get O(N^2)
> behavior.

Oh, right.

>> Letting oidhash() XOR in another word would close that line of attack
>> for quite a while, I assume.
>=20
> Yeah. We have at least 160 bits in an object hash, and we only bother
> with the low 32. We could XOR up to 5 times, but I agree that even a
> single extra word would probably be plenty. Might be an interesting
> experiment to time something like the patch below on a hash-heavy
> workload.
>=20
> diff --git a/hash.h b/hash.h
> index fae966b23c..c9d21f589e 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -457,7 +457,10 @@ static inline unsigned int oidhash(const struct obj=
ect_id *oid)
>  	 * platforms that don't support unaligned reads.
>  	 */
>  	unsigned int hash;
> +	unsigned int entropy;
>  	memcpy(&hash, oid->hash, sizeof(hash));
> +	memcpy(&entropy, oid->hash + sizeof(hash), sizeof(entropy));
> +	hash ^=3D entropy;
>  	return hash;
>  }
> =20
>=20
> I suspect it won't make a big time difference. The old code should have
> been optimized down to a single word load, and now we have two word
> loads and an xor. That probably isn't important compared to the actual
> 5-word memcmp() we have to do in order to verify that we found the right
> bucket anyway.
I see slightly worse performance, but within the noise.

However, just stacking two words won't do if only a few bits of the
resulting hash will be used to find a bucket.  We could mix in more bits
and smear them all over, but if that's done by a deterministic function
then it could be applied during the construction of manipulated object
hash values as well, no?

Perhaps salting with a random value determined at runtime would help.
Not XORing it in (pointless if the other value is controlled by the
attacker, as the result would still collide), but using it as a mask to
choose the bits to take from the object hash?

Ren=C3=A9

