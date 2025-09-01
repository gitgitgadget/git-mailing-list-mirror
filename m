Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25F932F763
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756753591; cv=none; b=t7wNIS/GUPGRH8WO29JkrRnEHyxqyTFuDSbRPdIZjyFc8XDweyWrDoiifaqCErgl/WiEXMArrCJEKUyo9hZyVwNLLkzx97JD8X89d4pvwaTFP2WcVlTPZW2RYPHzAYymX5tkbtuqfglswCZya3JAPsoKIAu4+7jeBevizFxLq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756753591; c=relaxed/simple;
	bh=Hhc4NoIqTdlrR4XoLfqXugoeb+J5cMESQZIuSX2aR7Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AbwrIBmmbFBBUtbmiZK4vemdcU1WIYYBVQD1inw2vaGXhYlrYSHH1nb9mpI5pF3z9vQiNCFHK44bZIcUSN6/KZTuzJ37v57ItQASWG4DMFs9rT5fDoHx+ujtMf14wCbRhrSSmVoQfjVaHkmvfyxob97NUryruq0flRrhFMAxbb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=CfcLQCRy; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="CfcLQCRy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756753580; x=1757358380; i=l.s.r@web.de;
	bh=sad7pJ73tFdFqjj4pJ05PrMUv8x9bIAQSuYMzO5jo40=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CfcLQCRyZAA5de7Wij77gIy2oZfgGzXJ9WKaMYRrOPtKkKGZsyit9kpomcsK/t8j
	 kal8dEPSpm/3+nN89G+5mVkhX8rekEJyE7J3BVepBMYQ1GNQKKSedNDUq15FelslS
	 021J7ZLcOqNyEEJ4JFKfq3o28chYjvA6/bLleK8LrjYVUuBsP4/orf3xI5yKa0COp
	 eUHARt611/jB7ptnFHfCkoCX7Vz3aNloF50D9EYmsPMpr7+4rFpJnZBdwJ8cwgoer
	 DYaLl9mb977neYTlzVHsc7iZo1kNDuXGW1KhDw4qYjuL0Yy0RXry6sS7Acd7OueZ4
	 6ERszerHFUnlah/SOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.159.98]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mav6t-1uMHsO3wa3-00eVTu; Mon, 01
 Sep 2025 21:06:19 +0200
Message-ID: <84fb48b3-17ae-405c-b7a9-6d48a3c57a36@web.de>
Date: Mon, 1 Sep 2025 21:06:19 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] describe: use khash in finish_depth_computation()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
 <20250824103117.GA250458@coredump.intra.peff.net>
 <6402268d-bc80-4bfe-abb8-edec9e1b8417@web.de>
 <20250825073403.GA332447@coredump.intra.peff.net>
 <cb192b28-d85a-4866-a312-df4408cae93e@web.de>
Content-Language: en-US
In-Reply-To: <cb192b28-d85a-4866-a312-df4408cae93e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YTSKDzf6YwJ1FuztbaFjEBxgzIxxvnjeOkyYnu/TuAVg8ho0SZy
 W0VErvZrWkx+Inbn5UubixOgn7nt8+Iq8fC1vlTKM26aYs+lkOz83LhkYUegU0Vcht5mY5e
 5lsDtMz5z+Ij5UD8+w/w+KNivNtIU5eg0B8RCF4SfEFndKqwbAhyLcF8sePO5jZ1hljPq2T
 EM9LF2zISFgroDC3IDWeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uvvdsH4HjEU=;HE1d4jkf5rnBIOiyII9h7Hc6NRy
 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
 k2XUSVZT1k5b2WgYgKY

On 8/31/25 7:25 PM, Ren=C3=A9 Scharfe wrote:
> Sure.  I'm not comfortable with oidhash() though, because it allows
> attackers to influence the hash value, cause collisions and thus
> increase the cost of lookups and inserts to O(N), leading to quadratic
> complexity overall.
>=20
> They "just" need to construct commits with a common hash prefix.  I
> guess that's easy for two bytes and hard for four bytes.  Not sure how
> what an attacker would get out of planting such performance traps, but
> I guess some people would do it just for the heck of it.

There's https://github.com/not-an-aardvark/lucky-commit, which claims to
take a quarter of a second on a four year old laptop to give a commit a
chosen 28-bit hash prefix by adjusting whitespace in its message.
Constructing a history with a common 32-bit prefix that would
effectively turn any oidhash()-based hash table into an unordered list
seems within easy reach.

Ren=C3=A9

