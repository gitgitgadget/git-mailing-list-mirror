Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF5B2230F
	for <git@vger.kernel.org>; Sat, 11 May 2024 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715459553; cv=none; b=KZOkPS2Hk2HylxSiQVADCm6ax1FAS0PvDPiOt78WC6zBqCZwGdO7YY2ckQv/Koqy6JajuMzhsRN/D12Rab3kOOkqWUi2pKYrMqsCLTJSWIj1y/iRJeSwCOGIQGXJWoAM/TATs44+CVVGi7B3EBunhmM216nYh3DMXAh/q2AxqVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715459553; c=relaxed/simple;
	bh=RkJFTma4mN6OHgF8xm9wjKuapF5euGrVih01MzFo14k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YH71wQM3Iu3qMIwTkm6jTh3f3gZ00LL6c+3yIZKstW5+63XFngrqb5qEi2wBZlfEpPReIwhvWSdeHTz6ERkQIBEOL3AIvehmEOJdheUnqV75OvXBmPZ8qYLSJnTZytQh/oMNqR8NRHxIRAue0A7evS5ccE+UjuYeMrhbzzfq+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=BeUroF51; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="BeUroF51"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715459533; x=1716064333; i=l.s.r@web.de;
	bh=MQIXd9/CsR3USInlUG3bXf9HaEdi1nyl8avGoKkWnJA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BeUroF51th9OEaseWnanK9jupZpU04+DNK9pT6JLyevCYhG2H5bmvSymF+Tkyu9E
	 q1XazsG11jsPAbnHtm5/t3gb91884zHQZ+EK3cBPt0TAFskf74/wq+aLz8L4ykW+P
	 GnKYJ02/o/IbDPmRcgYtV8wqrq+alNLhkW6Bj359gZZes+1IKg0nvSfCWdAoMxpiP
	 2kW23EEsi/1d4FlVUSdX3YRqYZLsKZnKUeU0wKvLW4pFAeUXmckbEisUkEGA0CqNv
	 2w5Szfbstjuds7azm+y/xMdaj9MsrpV+1OjCJnNLs06gsdAkISi/FYhZXFkDzXjM+
	 cYiUPilRP24L7cRgAw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqqTV-1sRUho2AVN-00fhvm; Sat, 11
 May 2024 22:32:13 +0200
Message-ID: <f3454199-2eed-4ca1-82db-7f1419b3084e@web.de>
Date: Sat, 11 May 2024 22:32:12 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] diff: fix --exit-code with external diff
To: phillip.wood@dunelm.org.uk, German Lashevich
 <german.lashevich@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
 <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
 <99337bc2-a691-45f7-9b6f-74ededbd9a78@gmail.com>
 <4bf12c41-a6ea-4939-ba76-e2c784952eaa@web.de>
 <539926ac-4274-4b4b-a2ee-aa48af791124@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <539926ac-4274-4b4b-a2ee-aa48af791124@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JjsABSve6YoEr/vXTiltGTd3dFKUzit535RDnb3xtIhOwJSX3V8
 /8sCHUM1cl2qlgEHIHglWrCaE71Qh4GgJVG05WKOKZqiHcUHGxtMrNkfi4W6Ek7+YlicwDW
 kmpMR3JHKAsF/20HFVW0ybWGrxbrsBsYAtFu/GqNEHFZyYAhQuQV6Lol95kPB9VAh8vkghx
 4Dgh/BgTvxZ2rMuLqHuzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J1tz6/UHkJU=;1qnIjOMbMfe5r8vZP4awDhHbSHM
 aMmY7ude7zrqczTPyNGiuUF3RpEnpiiGW+686nghFdUWWWOKqcuB3H6eq5P1pPAv5MwJXhP7m
 A22JyBcPJTufRdTToqK8i69TWYrki/v9Jq3v/td+VuDHrDyt3fLYh8Lxr5JxxORvAAD2Tsdg+
 ABrvUlnqxr71So70nGIdPao/akdUB3duuXI0kDBDbYVZctXEE1ZDgCFIDZJ3djKMPJJJs4/l9
 BHYP3ZZFPoDH67Q8kNp2OFWkibto70RYPV+YXkGGcXUSsfXFlekhnq62VC0B+hFPClF6Ln64g
 ySh/IK+2Ws85ngCgeDt5vqogfFzXhhiQBCPRvm5oC2oNwm5CCQBUHt6K9ZDXE9Zm1X6AWexhs
 ZqbWg4O0ITbVnbQC+ZxANEYAcaY6fow/424x2U1MDLHmmOvINNt4aMfWhCx4f3dBKDmoC7oiL
 OZ2VttzhdldD6s9xvqpoteUg82qllmmfEKRMau8RPB8+mviqMPn11b+LZFtE2MYVH+aKAuRdA
 wqu/LAi9KcUI4GaGEy2gD1ihjIOGXbcBrdC4VorQTctP4L4PeiQk5GmPDC5eXa+ZCWhxKczRn
 O421jJ+veEw9AsqzJfMxLbVDhOb6vmypU7aaNcOPByiUzaU4qXBoIqJzzrHY1oEpGjOsjQiSQ
 0xsOleZTv6RqvlTXaj9JNNAgOoAATSw1xAhXHW/Jj0c3BAosF7xd4XS0E4/g7a6WTW2fnu0aC
 uiRUduDIYyELHxT/HmJI0wPO0Qu0mbIoECexYBWuAvDxnNJddt+O37Ig4sIQgbj3VMPH6LnwG
 3Y2KX0mk5SVXjffi/n2b4SA3icuKvXviYury4pdQPj8G8=

Am 08.05.24 um 17:25 schrieb phillip.wood123@gmail.com:
> Hi Ren=C3=A9
>
> On 06/05/2024 19:23, Ren=C3=A9 Scharfe wrote:
>> Am 05.05.24 um 17:25 schrieb Phillip Wood:
>>> Merge strategies are expected to exit 0 on success, 1 when there are
>>> conflicts and another non-zero value for other errors - it would be
>>> nice to do something similar here where 1 means "there were
>>> differences" but it is probably too late to do that without a config
>>> value to indicate that we should trust the exit code.
>> Right, such a diff command protocol v2 would not need to pipe the
>> output through an inspection loop.=C2=A0 Sounds like a good idea.=C2=A0=
 It's
>> unfortunate that it would increase the configuration surface, which is
>> not in an acute need to expand.=C2=A0 We could advertise the new option=
 when
>> dying due to the unsupported combination of --exit-code and external
>> diff, but that's in equal parts helpful and obnoxious, I feel.
>
> Yes, diff dying would be annoying but the message would be useful.

Having poked at it a bit more, I wonder if we need to add some further
nuance/trick to avoid having to reject certain combinations of options.

Currently external diffs can't signal content equality.  That doesn't
matter for trivial equality (where content and mode of the two files
match), as this case is always handled by the diff machinery already.
Only lossy comparisons (e.g. ignoring whitespace) even have the need to
signal equality.

If we (continue to) assume that external diffs are lossless then we
don't need to change the code, just document that assumption.  And add a
way to specify lossy external diffs that can signal whether they found
interesting differences, to address the originally reported shortcoming.

Is there an official term for comparisons that ignore some details?
"Lossy" is rather used for compression.  Filtered, partial, selective?

> Thinking about the external diff and some of the other diff options I
> wonder what we should do when options like "--quiet" and
> "--name-only" are combined with an external diff (I haven't checked
> the current behavior). If we introduced a diff command protocol v2 we
> could include a way to pass through "--quiet" though maybe just
> redirecting the stdout of the external command to /dev/null and using
> the exit code would be sufficient.

The current code uses shortcuts like that.  For lossy external diffs we
need to turn (some of) them off.  Lots of possible combinations with
special handling -- needs lots of tests for reasonable coverage. :-/

> P.S. I haven't forgotten about our unit-test discussion but I'm
> afraid it will probably be the middle of next month before I have
> time to reply.
No worries; reminds me to polish some unit-test patches, though.  I
get distracted a lot these days..

Ren=C3=A9
