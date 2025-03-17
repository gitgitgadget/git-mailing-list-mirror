Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C418787A
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230231; cv=none; b=BGt7EQCdwStWWaJv15Y0wEuoYNZcDKKQXGCRNMyLszr4jZc+6tRNsTwa9mjLxv7Gk55mL1KQqwxzTi8Ek3TUFtE49gqt+xKVxSlIqkfp3bMyv/t79SIoqH4MxO5xLgq4WfM85BnKGtiunv+kNoXdKUTyG1xvUF+r86BQDe+Lv/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230231; c=relaxed/simple;
	bh=n2RgVa99cCqWiUCoez4RiGKHLgz+HiWeNhDjopodnGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kduM4exQhI2v0I4NKowTHXgqqAb6d6Q9m5/1iHj6/VMPy/0VK9B9dCHqZxAmj1EuBS97+NbV5KCRxJdGpha/vAtQ4l0GHtjtnuwW+l3TbNdf4XD/A4pAT2wiJf9dD72d3m3c1lhPdU1GxIK3v+CICgFcjxG/hFnFW1vzPj/ILDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=aL3E+40r; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="aL3E+40r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742230214; x=1742835014; i=l.s.r@web.de;
	bh=9+rc+7z+j5qvVbVcj7E7QtXSs8iNvNMKGmeWK7DiBMI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aL3E+40rbJk9RdSVHp4j3XkRAelY6qQLA2nS6ydQynBTWFX+hZHn25K6ODZc2rIe
	 VWL6iLriQxqnW7NnJKBIZA/FIMYQTrKRPcAKwZIX/e255No7IBySgt6+ZEpX1Nds3
	 iBMpwDz3kzd0T7sYGA+8gQNwpT09TGDRgObBjsCy8rzK50fMCR5s0Z2c3rujYxE2I
	 LaLoQDa0qUkO8hRwsN4oQchXrOqoiTWyRjFG1Tqjmpm/LMArrHRPCkQ45ss6Kr/+X
	 Mc5FcyR+rLwJEmiACp5zi69EaydyO8mzpDtIVLtEGPQ19cmZCTrOVrnv80uZjbEmc
	 0/L3nEC3p0RDU2H0xQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.29.218]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N01Za-1t0j4K2nbi-00xyj4; Mon, 17
 Mar 2025 17:50:14 +0100
Message-ID: <136bbdac-aca2-411c-8367-8de4472fa858@web.de>
Date: Mon, 17 Mar 2025 17:50:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xdiff: avoid arithmetic overflow in xdl_get_hunk()
To: Junio C Hamano <gitster@pobox.com>
Cc: Jason Cho <jason11choca@proton.me>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <xXWgbH3mlNEvFcdGLqBHwcclZoeZNPoLg8Hr6YCipHXvS5eKaHeTppzFM-l_wyB46BB1R1T0j6g_jWRXIj7-GRJh1LPxi1ta3GkQ5t8F4-0=@proton.me>
 <NYMqsJ7uttDzFT2OOEg5LLsxCSoQhTzqBs16KrMHGEKC7LzOAiYnYTEZavRQWqGH41UgjdwScwer7MssNzI7AEDHnD8GTBWvoBIqJ2e7D6g=@proton.me>
 <4e9b6b4c-aaa1-4c6f-93f4-7bb04607e843@web.de> <xmqqikobdz7l.fsf@gitster.g>
 <8c9a3966-2746-4619-9f77-ca95797dcab8@web.de> <xmqqiko8da63.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqiko8da63.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nlFosCWJmhX7cghWxqUIGwiOmgs7kP4YGbd+knBgQR+a8hxZ07B
 OcmMWLYWYGjBkvpKUeEn7FxSmFv/3HliMN7xyTLLHSttuTHMF2HfP+Enyf6MZcqkBdwhHmU
 OCEXBBPXF20zu/j/IERHPK++fEazVLpZkyojWMWV8SR8c7mg38zF2xJI4c8AW/L1UNsuS5F
 b2aFHGehLIihzRhqfdoQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HXlcU6+hOgI=;/WFuB/XSf2XqvKrrX6peqWOLFxo
 0xive/UVuntnueI6POuP82fKWOnUVEFeU/FfvxehhjGvlKEX0ymFv8AiaNzgEXcYv7joVCfyn
 1e22pKez4Lg8opCznzOE3m1NycsFGgshwtc48uqdI2yDQcBdaNrn8BbtL8I+twfLBaPQ64pdp
 WaktHFzdwbzF/GghLalmqok2zXURp3p/QvqF1MUtpwvFcJ1qN7ax/wMgDJEQQq3ocpk8tcXBn
 DkMNQiuCauj4J4ciO6+Eh7tvi4wCcypXnUSnQtKxdiUgidL7CZEUPdqY0def4NQwqPxXZcwj6
 moC3qrbByNfkKhpd6pSTLK4LzJCC/75V3itdQrXJr2ZmCF1eAuqryHAy6WCtNE9swBuvfsFgI
 b3Or5AikoubQC1g6cgpSf0BRd4YPCdRU32yKmHnmSMEtqjuJ2TkvN8AwqE6OjNKyy8gkiYMLG
 tbeM+PZhzXALT1v/SaxGSNGeALSH9/68dN1vvXH+15idrQounWimuBn1yvO8WGvin8gkb6RjO
 ymnHBadYe9fBSzysLxcaXeetj3UfeddKiz8DRpQBiSBj9vH0p0jPtr55mm0c0/WUmzgStvf0i
 QWRZlECOw6Xxy7APM6Yvkph7Me/JncglsAgn6W1GuGCBpNfi5Gcm6HjBwpmomZU6EkDiJs6ZO
 fBO3KIZR9LvO4DoEWoSj60FvBAE8c7FMvbaEOaOE4b2SjdYnLvZUOJRiXpgXnuXANY9ZkBjXE
 wZbicpIU21XZo8FdksKNrHvVXVgaw8UaE2DVLEXNUlYikShdUJPaLf+uC7HhLsWP4ahjx38BV
 QEw5k1FNvDj5ZXn0NCpHgeO8kmHLi8aK4Y6AazeZuYDHqpQ/2bp6cfxQrWoxf0+cmpkwjAJB3
 41LF1pbQ28CpKPyzIr6W4nmE6YnufYyAEsWdSs8Wu0Q5KJty9GcuGpoD2FMmUXfZ1Xb6eTaAz
 0CBuUMp3Vpw5dXPAUI1p26d6kSxSUPxMWmE0UVvcsf80ULPMT5gyyb9kFro6EsfELRk1LH1rA
 QHyBW7cBchSMxwQhgWHfGZm7S0kPERYUi/YE7DZN9yPmJmAIRaEYuQsbmmp8wZ+M140GaVHEJ
 sa650ZSnY6YYYmzKasxz45X6J3gyyLTqd4akwKVGOAXj+3lg95rpVjWV2uIxbDiSaku9icvxU
 o+5Y498kVc75hbyC6ZhTgtZ5RSPnuB+n1qjM5jf1fy5Tsl4Ry7sDAkwKgQODPNFTve3PcO4F1
 lNl31iyEmVCuFgXVtrv1kqc8WVfnZE4EeOcYMLOmzEGPnElHiGlllzi7wH4oBxy1XLKbTicPM
 UETzf521fXA952I95mSdXbubze/ea1r//dKYkOBxy4EJ7KjIG0zYe4gRkODkf/2tu0EEWRtuX
 iGVYddm0gsWKSfjZGu6yFkfkk/R7UeK/HfIo7arveICVGcb8K0LidKb0HAB3i/enc6Gn0jWPV
 kv728G7zeprOJToazZkFUF6vW+24=

Am 16.03.25 um 20:53 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Comparisons to upstream
>> would become a lot more noisy as well.
>
> I am not sure how much of that matters these days, though.  Are they
> still active, or is the code perfect and pretty much done?  I somehow
> had the impression it has been the latter for a long time...

http://www.xmailserver.org/xdiff-lib.html offers libxdiff-0.23.tar.gz,
whose entries bear the timestamp 2008-11-12.  Solid.

Ren=C3=A9

