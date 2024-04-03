Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CE2136675
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136668; cv=none; b=k+brRDP5mnHQEEt95+vyNB/GXHsN1pKakJBqM7YSygin0isaktwcwD1uoqPrOySeQvbw5HVulJ7KboomO8f0EyUZYT9hY5jAqcMafjSsOGYZnLvHbWU2frcyOMuuKz3LT8bIvfcdU5RYl55YIsc0GaNhKa2s9M42GViSW3Lg3NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136668; c=relaxed/simple;
	bh=JvFiv3l8AVDRARyJru5onOBm/xyffx84L5RUz7wuhUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mR+KT9tzyDLCOwyCm6pPqcemIGYHatDpQCvpXBdLjE3uXFEsuWddURej4LGW7eoRo6pxsMZk2GQvJBB6/rgyQUcqqwNRz7UvH5fBP4QlHNiCwXFAkFy1GErl+U2XkXHMfZHlvnjTvdwgxuFxptHs1dmW2xNe2yld4Dqxig7sOAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=RSF4YvgE; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="RSF4YvgE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712136663; x=1712741463; i=l.s.r@web.de;
	bh=YU2wY7uduYfEMWouI3J8avFcI7kKvl7FqFG7f6dtmJY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=RSF4YvgEE3mwxrUf0S3QjNuffEM9sH9T39VeK3NDbKZnCnUgNConch3EQpIS2EGj
	 QNUUXlwq54Jmb4lEeQ1xBKshH6eyVopdjM4RUSND4GrY8pcQmZALCIDfpNxrGV+Um
	 x9Fsixu9EO1uS1nx7irSFIjVrGDUfOKcbe+EUuEzsyCs3ENLn23CQx1/NviR61LAs
	 mb+YIZ6y77dVeLy2eekSjDSDKk7iw2vNiaIlGECgFcyqJVQE5lAKfo+pijyJbtRd/
	 WoIOAM9gzAMZenpC360cYIh3JvyMvUJNsLwlP9iO+c4WThKWhtQq7az5bWv3E4YCx
	 4bga0SNGPf1E2j103g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MaHWj-1sLQeo1PCn-00Nm8Z; Wed, 03
 Apr 2024 11:25:43 +0200
Message-ID: <970c27ec-c377-4034-853a-0251733ec50c@web.de>
Date: Wed, 3 Apr 2024 11:25:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imap-send: use xsnprintf to format command
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <f9ad9f41-5b9b-474e-9818-f91fc937daae@web.de>
 <20240403004751.GA892394@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240403004751.GA892394@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0yoSKbGqsGbCUiI2m02WWuCUERc9AeWqO7VPWrwGAvSRMKdCtIV
 dxhYldPk1pNkNAx3AcXBHQnhObCSX6cpzdgz/Ee7yU+5Kh43AmN0/N4GpQ5NdfMDH3OLpIb
 cOhdzjUO0zz79XGvkOGfnKnj9bRNtF6nUDFDF5JxUUMViePQr/PFgsaQjqakX1G/Qisjcet
 4AHvRDCWXP6fqMdWSURCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bQcATKn0VOg=;RZu7C1ZNSm9FORSEOcF1d3Gyp4r
 vjwyCiKbGysZ2AQ3GPH8q82LlRvKlk09yCuKAeduIJZSfTuN33QonTWoqvI+SroDVaZenwmUn
 xjnoQw1Fz+VP4UR6YjkRwiblkkrk3uCBie5V6naxuBh+HHsJSueNGCob7Mho7joCkoBotY+HD
 8Sgg+uqGsxzDGqoijrVlBqhMM2Fsy9b3JAZQCy7JWtxr2za7gc/BcKhW0Ip5a6DHGm6XVlw7N
 Hc+FUUYv1HJhkSpvRIJ7AOJc747OD2woCP9l8JGyavqt9LH51jWR9Yc1Q4vfsz4+CJlKOaNm4
 ykybqU3MT1JilnvAYX2ydXERSXtNTuS/W/SgdLWht0eJ17MLZmri3ChD5sJ6lDG7+08HSSSO3
 ze2crHVkG2gx1kNiWa3vv5ZdHWslBg4tLPvnHpeh7H+IAB4xses56jF3MRGpmpIX8mfSzH7S2
 zqJ8oLy4X7kbTHvGO4dG4s0imXCH9t4PRZ3YJHuBHBMCNv++RG1d4sTwG0BpiTUi49Jd4f9mn
 mFUUd6wR5tnPZ4RteVYIGrDnIN13K4i5D7of6xe5355kMdBo44rK4h3CCq6IHw3M1x/5ZY4sr
 oFYuOo0KquYL1wYxRESMxkVVILCIYRyp2s3yHJ8n2XTwNsUtb18akIe4SnqNock84OzjLe4oi
 aihNFHvdTVDBjsqaxcgpBUjZddXBFSuiOp8RLJA518Lt9FotM4gjUcsom889RG6mKQdPX502X
 G5D7dzqgJH33CsPL7gRnAfTpkJjZUiOY6kIjC/7U0f83MnNDxse8Xs39frwRx+PYh/B3HNfxS
 MV+uurDyaAQED343MO0RCa8Qg/z4ktBhWqMvrYXlahXR4=

Am 03.04.24 um 02:47 schrieb Jeff King:
> On Tue, Apr 02, 2024 at 04:51:05PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> nfsnprintf() wraps vsnprintf(3) and reports attempts to use too small a
>> buffer using BUG(), just like xsnprintf().
>>
>> It has an extra check that makes sure the buffer size (converted to int=
)
>> is positive.  vsnprintf(3) is supposed to handle a buffer size of zero
>> or bigger than INT_MAX just fine, so this extra comparison doesn't make
>> us any safer.  If a platform has a broken implementation, we'd need to
>> work around it in our compat code.
>>
>> Call xsnprintf() instead to reduce code duplication and make the caller
>> slightly more readable by using this more common helper.
>
> I think this is an improvement, and since the original also called BUG()
> we are not making anything worse. But I think the original was actually
> in error to do so, since it depends on user data. E.g., setting
> imap.user to the output of $(perl -e 'print "a" x 1024"') results in:
>
>   BUG: imap-send.c:511: buffer too small. Please report a bug.
>   error: git-imap-send died of signal 6
>
> Now obviously that's a dumb username, but this is the buffer used for
> all IMAP commands. So conceivably long folder names, etc, do the same
> thing. It's probably not a big deal in practice, but conceptually this
> probably ought to be xstrfmt() and not xsnprintf().

=46rom reading the code I assumed the static buffer is there to stay
within some IMAP limit.  RFC 9051 mentions the distinction between
synchronizing and non-synchronizing literals.  The latter have a maximum
length of 4096 bytes.

But those are transferred after the command, so have no relevance for
the command buffer size.  I see no other limits, and I don't see us
respecting that non-synchronizing literals limit, either.  I guess that
means messages longer than 4096 bytes could be rejected by a conforming
IMAP server?  Hmm.

> Likewise imap-send's nfvasprintf() is basically xstrfmt(), except it
> takes a va_list. So it would have to be replaced by strbuf_vaddf().

Looking closer I notice that the result of the single nfvasprintf() call
is fed into the 1024 bytes buffer.  So we could replace it with
strbuf_vaddf() or xstrvfmt() and still stay within that strange limit,
as it's enforced later.

Its own 8192 buffer shields us from huge allocations e.g. due to long
usernames or paths, but we probably don't need this protection as such
and "attack" would originate and be felt only locally.

> I wouldn't be surprised if there are other opportunities for string
> cleanup, but I generally hoped that if we waited long enough imap-send
> would just go away. ;) Either because we could get rid of the tool
> entirely (though from a recent-ish search, there did not seem to be a
> lot of good other tools) or because we'd just drop the old code and rely
> on curl to do the heavy lifting.

Oh, my build uses curl, so my earlier test run was even worth less than
I thought.

Ren=C3=A9
