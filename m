Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54B82E410
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710445091; cv=none; b=m92XqJMTK70RNKmDFl+yGnDfGtn0GrCfJNuYd8LIThffe6FGxvU/YaXl+cvQKk7O9G3SFZRbxHlUsjAGFfKmrJw0IxbNeb/D2MyeqHaliG1dZezJxcWCuDrrjZKvfEv4i3+GxoGH6hX/8KyNVgWm2JoDxH765BDUxVagEHFXHG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710445091; c=relaxed/simple;
	bh=R9h33c/0+xTrGOcjEEfFzrgNkEKmrNLO8janLoGwn6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g61vbEEyvay0Ga5cpMeywocgHJr5VbtfQgI4rVwl16s2R7Lb40NpNzuvjpU/fBIh4en+PrT8uoUa6Oj6cwRov7b9SvOYlPfhjo4D/ulHroPuPtYX/CfEYDx5TopYLiPEKD9Lm9gD8s+8LW4/AmOyEewhfqhzQYNeTomFnsHZC/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=D4soE22z; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="D4soE22z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1710445067; x=1711049867; i=l.s.r@web.de;
	bh=la98M3eGxV7bIEaBrHn1WExsHN7ku/YQppPZQ2yCdbA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=D4soE22zzcTGmYFXGctmYhvEWKBFnA1JAgN6cHsYyRZ6TP2fFB3VUB1FgQRgqrSI
	 pWox/vjjVPEXEwvI/GIyVRlhJZkqB0U6CP5cYvfTSpKxkTWj+NLZo6EMuYaNGLUq3
	 ESXXe4sKrVzAG3zDgIk0O9+AgVf5AgaMEzcdGwEj86E3IxDhH4phdVGHQhQvnxaoS
	 iXXpVgi2wfSD9snIodQfizR3VlIBVvkzN8Yk6t92awr0+OYCw8MAqIpOhjOWpe3df
	 oqs1KWtzwG3CB4PQXoLvAlc6XSjkngJ6dI0KNTBZQ5KZSIQI1HDaXqIxS+7ktV9fp
	 igbgvrCqUtxdt8SZ0w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJFhX-1rUZEH3ciZ-00KiP1; Thu, 14
 Mar 2024 20:37:46 +0100
Message-ID: <89e2369a-9d9b-4621-8311-77e2deb3e5f7@web.de>
Date: Thu, 14 Mar 2024 20:37:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] find multi-byte comment chars in unterminated
 buffers
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Manlio Perillo <manlio.perillo@gmail.com>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
 <20240307092638.GK2080210@coredump.intra.peff.net>
 <3f823e48-572c-4e19-ab76-e6d7cab9461f@web.de>
 <20240312080525.GB47852@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240312080525.GB47852@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xLiOoKrrzRGT/thHxPvNaMHbkk84IieuqyFs7/w6K0UiY81+dIf
 5Lmw6iYdYFJCW7b0J5RfJpk8obte0mK8CmzhUBkchfeZoUiSHwrx2RmUtbxG75SraPScSgs
 hxJXUZov6Ls/GC0G/VIa38+PxK2tPpV88E+VCbKHaCg4owUjzOAL23H1jSty1Qa4TInKsTX
 sMt0H7rLw5Kf2lS/jzFSg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MYFpGI+IfX0=;0myJjvqd0S2KvrVuYSL6DIuv4Pv
 tPwCmx3khh/CaHUNM2+IsIs1Du5X0xoKZAj3Qk4Gal30/wCQ7HyuYRAi8NW9Byn4YxhCSZx6A
 a6GBnoRzCIcdAYegpf5i117f8g9pnIMha/QNgBVRPStcL5MmulJtlvelvyriY1/T2e92hNuEg
 61fZl1KCtaRi7YxLQDMjlg6gZ+kVNF/BywFfFrVCyFi12+Ifqzp84tLkkOXu2ylk+RDCNWBEx
 npHMK9/1Uy7kApe0sEc62Ie2x2qcKA960QH5ZbY+j0yJw1aTnhVX6zfI1KmfLZbdMhMDQKPE5
 frzPWt15HYQY82dbtT4hh01l/SjrNkUL+4VZRoQzdeJY95xhRELTuSw46KvR7ICDjsUkbdSId
 24YwbqRGiy96AfDIjHl7LosdrM/hiV2ouDzb4Y5PkPD+SSuXf9lsrO2JPPJ1e8/e+2UpUVvLw
 gFHuCahLIE9sKSYnUYE5spxB3H52+EYWzPYqstMr2T9drYQDjw48aLU3vJX31mh+f6luDgshI
 14LQ/Sn6xi1xw2yXQXYbMs0vTjBucKiv55WN2+zjxIKqP3Yc8UfjDOOFqdoEq+d3GljzIt6pP
 mbaFz5IEoctehEmTUziRWRPj4X2FAOBoJKHL/S9ZUSA8LeE3V2D3t7cQNuXZqB3//MjuQuQUJ
 ZLBjjia40df6M/Vb0n+TWURePgDtvgnzNcywlq6+ReBhIS65KoPCRHENZBIpgR2Y9yLyeb85u
 quVOiPb7VWp/j9X5dMR9XL5oF+ToTQBW7oUX4sLHuyagKYmerPKtXxEoTK0lAhE2Au6AIBj14
 5/6agGJc86UvdhrdVCzobNeOdsARFZDL23R6spVnt4tZg=

Am 12.03.24 um 09:05 schrieb Jeff King:
> On Thu, Mar 07, 2024 at 08:42:22PM +0100, Ren=C3=A9 Scharfe wrote:
>
>>> @@ -2562,7 +2562,7 @@ static int parse_insn_line(struct repository *r,=
 struct todo_item *item,
>>>  	/* left-trim */
>>>  	bol +=3D strspn(bol, " \t");
>>>
>>> -	if (bol =3D=3D eol || *bol =3D=3D '\r' || *bol =3D=3D comment_line_c=
har) {
>>> +	if (bol =3D=3D eol || *bol =3D=3D '\r' || starts_with_mem(bol, eol -=
 bol, comment_line_str)) {
>>
>> If the strspn() call is safe (which it is, as the caller expects the
>> string to be NUL-terminated) then you could use starts_with() here and
>> avoid the length calculation.  But that would also match
>> comment_line_str values that contain LF, which the _mem version does no=
t
>> and that's better.
>
> I try not to read too much into the use of string functions on what
> otherwise appears to be an unterminated buffer. While in Git it is quite
> often terminated at allocation time (coming from a strbuf, etc) I feel
> like I've fixed a number of out-of-bounds reads simply due to sloppy
> practices. And even if something is correct today, it is easy for it to
> change, since the assumption is made far away from allocation.
>
> So I dunno. Like you said, fewer computations is fewer opportunity to
> mess things up. I don't like the idea of introducing a new hand-grenade
> that might blow up later, but maybe if it's right next to a strspn()
> call that's already a problem, it's not materially making anything
> worse.

Yeah, and my logic was flawed: If the caller somehow guarantees that a
space or tab occurs before eol then the strspn() call is safe.  Its
presence doesn't guarantee NUL termination.  parse_insn_line() would
not be safe to use without that prerequisite, but that's a different
matter..

>>> @@ -882,7 +882,7 @@ static size_t find_trailer_block_start(const char =
*buf, size_t len)
>>>
>>>  	/* The first paragraph is the title and cannot be trailers */
>>>  	for (s =3D buf; s < buf + len; s =3D next_line(s)) {
>>> -		if (s[0] =3D=3D comment_line_char)
>>> +		if (starts_with_mem(s, buf + len - s, comment_line_str))
>>>  			continue;
>>>  		if (is_blank_line(s))
>>
>> Another case where starts_with() would be safe to use, as
>> is_blank_line() expects (and gets) a NUL-terminated string, but it woul=
d
>> allow matching comment_line_str values that contain LF.
>
> Hmm. Yes, it is a NUL-terminated string always, but the caller has told
> us not to look past end_of_log_message(). I suspect that if there is no
> newline in comment_line_str() it's probably impossible to go past "len"
> (just because the end of the log surely ends with either a NUL or a
> newline). But it feels iffy to me. I dunno.

Same flawed thinking on my part: As long as we're guaranteed a blank
line in the buffer we won't walk past its end.  That doesn't mean we can
assume a NUL is present.  But that's fragile.  The code should use
memchr() instead of strchrnul().

That's not the problem you set out to solve in your series, though, and
you avoid making it worse by respecting the length limit in the code
you change.  #leftoverbits

Keeping track of the remaining length increases code size and adds
opportunities for mistakes.  Not sure how to avoid it, however.  Using
eol instead of len at least avoids subtractions.

tl;dr: Good patch (in v2).

Ren=C3=A9
