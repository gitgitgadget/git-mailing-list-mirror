Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC84200BB8
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736880914; cv=none; b=YLv4yluNx0H+Jj88CFn5VCyyrshdTWYP2b32EGxSjLvDv1G5fD+0gCfXBbFnylrVCkBH91drPtvUW0Stusn9SDuEQs0p8q8aGlJ5JdrtPshzyv8a8+4JgZtYBoW7VZiY2KRV2Kvf+LGMZoBwSYp5saPC7kNoQ89JkopihoBnDrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736880914; c=relaxed/simple;
	bh=XL4vF+IUA46O9wwhvWx8owhamN/5y6AYUf23JiC099U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l086fsEWhBaXuz5PQyMU4KWSgZvnUhfpgPvegsvnV7bxgGGV4sLYn7eFKCumfPmtFEHBYOXf7kU38lNrlITIa4TkwgP+fyfHr6dzIen9LW5TFAflxaMh+CDiarTzZy9lKxL5yogPjgab0fyQqJ7AXn/RcCS/kgsOukU83rTvlNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=cOgNb2xV; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="cOgNb2xV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1736880904; x=1737485704; i=l.s.r@web.de;
	bh=3PtK+kOlJpdimUelbG2NgZgaRh8VqD7eQ3OpS7KlicM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cOgNb2xVJvcHKY3EOuxC4Ebrl4oZlmQt4hBHezjw02CpD+Ive3PzF549W4whWbMv
	 0dN3GciS+whfdiFNeaFRskYTge3LiXwwrIoOX/tpW5cc4EuMH7arRWLUmiCgCTU+n
	 Bpv2q+p0xGA+Wqhy6OFySlRZ3qu6s01r/BmPby7N1mVUBAg8+zNdhSzWjTWTet7+e
	 9bJ3QVLv/rV0hPRkpGvkADM2Mxe9Rj7bES1APxRFVwNGmhLQZ65P1CI3bC/KyH06F
	 LtHDKDduqQchBLcIxi7KZENV0agWWe4qPWBwNuP7EpoX5Tvtc91MfxHncbfDopwlU
	 a77K9+pzHe7NSZmJsA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPrPV-1ttXwp1T7r-00O4L9; Tue, 14
 Jan 2025 19:55:04 +0100
Message-ID: <57066d48-ce68-42ec-8e94-4ef6c1eba920@web.de>
Date: Tue, 14 Jan 2025 19:55:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ref-filter: share bases and is_base_tips between
 formatting and sorting
To: Jeff King <peff@peff.net>
Cc: Ross Goldberg <ross.goldberg@gmail.com>, git@vger.kernel.org,
 Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <CAAEcvMovcZucuq4H70ouQzKS=_wHnBi1DqJ-4MMFVXX9XLEciw@mail.gmail.com>
 <6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>
 <20250113051700.GA767856@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250113051700.GA767856@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bnfCoMimVpMfG74vF2TjAZXJ5v2O4K3euV8Y/mrMZAXJDxmkhRD
 TMi+GQDYw+eM5nJREiBpz7TRTFYtvbXuG9Lm4P0G6eYIXa9wkaXLLJ3kh+3kjwp3KJ6m4r4
 t3q9ce9o4XnVBGrZXPxt9YkHfQmgkdPinz8/7y2zkY95WThEsSeaycga9EvF4THr6dBRtMm
 9JUq1gmIJw809EXBpLjRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FGGdxoOFqRM=;ftcTYCbd9yGE3z1oiDkWOBDJhMZ
 8CYeSlvwL+3YOnJfOW5cEyYDbKyIvsjnzpFxgPpNQ4Pt9Xl8MESGgded51aIwjpG7NWofAzTL
 pPgPIYMfX9UywLsp9KVg9pnQrA8WC/QKFGW+Wwmgo+nYXa0vS43fPdRUx77Lp+Da1b2SPaQMX
 dByGY+cWmCNuSYm6qVnI0ugXhnRpfJo655OiKUGbdxKgt38bvU3vrxYc1YGda81HaTT2oiB4x
 E43QuoVKGPq6Y90a1+k2ZyexaBnl3mSpAerauANo/wwZ4jQQTSCh8pjnbCfrx8yWE830wJrKx
 iNj+zZkMv9sLiVKyDDHhCrEXQFaMFRE9TbTT1WLUwBCqk7+Jh5fbQmollbL1D0wTp9X297lKu
 sQNf1pP2YFqdtrIuvJSrIs63wn8Bmy8/KgHETEV6q89UMtkPWGH/cdUonVbd9ElppTZJmfC0a
 JhjDrnUuv3zhm2DAwC0JKdy2jqgh8J+JZuatqwMnAgE7uSK+2/HLKiWuRcbqsM4eq1X07tW5U
 a7RQID0m2lL/gHV6D4UNFAGMDpxFTkERvkef3lMpSjA6RLKKbqTJ1QA2lfdpsS7BLllWr6hCw
 RcKfDlOP+rC9s0RgXdYK8rwmtkhpV69Pd6V+eYMkczm2TDq4wUt8ZLoAOjp/xvZzasR4rcF/r
 3CBAYnNH9HJQQwBwGc5vCAuvI4HvwU+vhwkdjFb1lBFYhaOEAtfQCrvfHf5GxdJ5v+YCFWicd
 8swX0j03O0Q8hPtQuEwlW4RqgT82d4wnSJMT9KUKsO3zv9J/lmdcKyAuTNfx0RhxK8T4YltmW
 TuuqqwrKYaj7w5347EYhGnToK60vS6+BUacY/R7DrUClu2fXxO6bhR7mQ1aM7haCYHagI0r9B
 Ya59Gbkzc/OWqQeLI5jVPijVXlLrHoHH90Ja1fSk7PtBPI8plXn8Hkr9YdxMBw7pzYwWB00ie
 Oig17EDjWso+zLHZDYPecnHleTfFGsh6OlMNgn7i/VtUbnnXNYelBp8ZQxEgbv/ZsqGNXK9Ye
 AAnpN61QP1Hay8B6XEp9vdY4qeiOd7stRt+gPd7InciIHs0/OdiPvEJ5+yV+hTwu1mfAp5KHF
 QWkzogrWdz4EyRB0zH7qGCGIqajo7ZJUcmfNwdqJSOo7zNpp3XaUGhNhoL7QxXaDt07RZv3BF
 qM1RqQv2lSdpZtEOlePOLdOJOuEwVv1bzWYZaUXjQAg==

Am 13.01.25 um 06:17 schrieb Jeff King:
> On Sun, Jan 12, 2025 at 11:01:52AM +0100, Ren=C3=A9 Scharfe wrote:
>
>> verify_ref_format() parses a ref-filter format string and stores
>> recognized items in the static array "used_atom".  For
>> "ahead-behind:<committish>" and "is-base:<committish>" it stores the
>> committish part in string_lists that are part of struct ref_format.
>>
>> ref_sorting_options() also parses bare ref-filter format items and also
>> stores recognized ones in "used_atom".  The committish parts go to a
>> dummy struct ref_format in parse_sorting_atom(), though, and are leaked
>> and forgotten.
>>
>> If verify_ref_format() is called before ref_sorting_options(), like in
>> git for-each-ref, then all works well if the sort key is included in th=
e
>> format string.  If it isn't then sorting cannot work as the committishe=
s
>> are missing.
>>
>> If ref_sorting_options() is called first, like in git branch, then we
>> have the additional issue that if the sort key is included in the forma=
t
>> string then filter_ahead_behind() and filter_is_base() can't see their
>> committishes, will not generate any results for them and thus they will
>> for expanded to empty strings.
>
> Good analysis. The sorting and formatting are definitely tied in subtle
> ways, and not all code takes that into account.
>
> The dummy ref_format here is one such problem. Another is that we don't
> do the equivalent of verify_ref_format() on the sorting fields. Most of
> what it does is probably superfluous, but for example it's supposed to
> reject some atoms that have parsers. So:
>
>   $ git for-each-ref --format=3D'%(rest)'
>   fatal: this command reject atom %(rest)
>
> but:
>
>   $ git for-each-ref --sort=3Drest
>   [...no error...]
>
> That's somewhat orthogonal, but it may influence the direction of our
> solution.

Not nice.  Erroring out would be better than leaving users wondering why
that sort arg does nothing.

A totally different thing that bugs me: Calling ahead-behind an atom is
weird; it's more of a molecule.  It should be possible to add separate
ahead and behind atoms, with scalar values, that we then could sort
separately, preferably numerically instead of lexically.

>> Fix those issues by making the string_lists static, like their sibling
>> "used_atom".  This way they can all be shared for handling both
>> ref-filter format strings and sorting options in the same command.
>> And since struct ref_format no longer contains any allocated members,
>> remove the now unnecessary ref_format_init() and ref_format_clear().
>
> Hmm. So this certainly fixes the problem. But is it where we want to go
> in the long run?
>
> For now there is no program that uses more than one ref-filter format.
> But it seems like an obvious interface that would want to be lib-ified
> eventually. We are not there yet because of the static global used_atoms
> array. But the obvious path forward is to have a context struct
> representing one ref-filter iteration.
>
> I think the intent was that ref_format would be that context struct,
> though arguably it is a little funny since it forces the sorting and
> formatting to be joined (OTOH, that is very much how the code works,
> since it wants to share results between the two for efficiency).
>
> So one solution would be to make the use of that context struct more
> explicit, and require ref_sorting callers to provide a format struct.
> Like the patch below, which also passes your tests.

Did that in the first version of the patch.  It works, but keeps the
cause of the issue unaddressed: The separation of used_atom and the
string_lists, which together represent the parsed items.

I'm not convinced that ref_format is the right place for them, but
haven't thought this through, admittedly.  struct ref_filter and a
new dedicated struct would be alternatives.  Moving used_atom will be
painful in any case.

> I dunno. Your patch is deleting more code, which is nice. But I think in
> the long run we'd end up replacing it. But maybe making a clean slate
> now would make that easier? I could go either way.

I think joining the three structs is better than leaving them apart,
but if someone is moving them to their right place soon anyway, be it
ref_format or somewhere else, then I could send the the first version
of the patch (basically what you sent).

Ren=C3=A9

