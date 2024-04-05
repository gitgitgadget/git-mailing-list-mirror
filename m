Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62B16C426
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314375; cv=none; b=LmFK0LWnoyRCmbTCFWazy3ct08N9oXZqflsdvjzid+wUq524ydwZY7UCE9rS/6vzx/t7CLo5+wmnZHkOpEDkhuyXA0VVSlBKsyr4EKTzh3KOPZhOequGC/RbPS3iWK/ynSRUxrXP7qtgG6CLO60bMRDDX/VIsCWGXzJEMOWPPiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314375; c=relaxed/simple;
	bh=ItRo5eCRpE/G++EFRVOs9ftwt6nuRp1q2ex/Yipw9po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjPexoUwTH96muF50mYYOCOz39WOAF7C9mtZBt7fB3YIFiDPfsKbPdefAyBUydeYH2JzZwWyoM1CQkEuXJkn6zrI9EK6TBaOaRT+muwzY1vZKmon5QG8Gn665btUyU0J5lhZZyh/VGpsgOYCmKgh4jBf3iP5MK25PC74bxlOg1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=NkpLd6/S; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="NkpLd6/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712314356; x=1712919156; i=l.s.r@web.de;
	bh=HLfZNtF4+NBjEdWiNwKEoeoucwXq3ghUu5ARAYyn0jo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=NkpLd6/SEHHdVrbxoekQAy7tZ4FyH3JmtXEAEAmpWDZ6ufbvnQ6XaHo/EBBAnmgG
	 KmR2ieD3zTA0f6pGBjSwQdjezdEfVARlcfN8Bc5Wd8Hwlg/MsLREbL1eLavCi5cqe
	 UhJSoZY3v3qWJtBtlSWnYbvE+tvAmXaLcllxdfyzXEsXuBu28RahrcRuANciyj0it
	 BUQwDI+9n1fSVpll3N+EafW6Jucl3m1WVSpRoKCM29VftG7GynPhODrOeQv5ZvxX+
	 ENX7pbmj/2VfugKH3iEd4irhGv+0ua8i/3K4AlazLmYPIs7tRdRzpNkvTud3Xcxzf
	 7SXqIapQvT4KIh4dMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.225]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4eCL-1sqBcJ0zSh-011TTq; Fri, 05
 Apr 2024 12:52:36 +0200
Message-ID: <14c99998-cc4a-4581-aab3-607d7fac7edb@web.de>
Date: Fri, 5 Apr 2024 12:52:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: free and errno, was Re: [PATCH] apply: replace mksnpath() with a
 mkpathdup() call
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <df774306-f29b-4a75-a282-59db89812b9a@web.de>
 <20240404225313.GA2512966@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240404225313.GA2512966@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rWbq5jVC/s3hxGc1+/AJne4HZP4RcgELeS4b+SrQnHXw+sJKg7w
 OTckG1aoWuUYx/HwKewU9m6nAFULbljUmk0fd6IiwzcuSyRbd87IJar76btsbrOwP+8hdOS
 ws6BAIIiyYBGrtEOA1HdGEQYRiBRk6nLIVIMEQH8RCekQai2mvp6UuqlenHVE5A9O6ePVA4
 aVjdw67CoiYWIYFuNQeSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yqkIWVJgpqE=;MSCCnlVVBhgQhsJpOsi3S4thW5F
 KL5vxnUG8A4d7b7ia7QEbKoANt91+ASTl6PkNSG5WI+bbkaEG1MJTdLHr90CYlt8CvaTXRCvd
 nYYD6yetSoGY9kvIm93WarVoheNMcA/f42R+XABnKuFVW8wT5TiD1jZ/2mEUnbA8KVvIMbaOV
 8N7Cn2ubv146J0e6xxDM+gowQUCnrhp4R9Puf3uAaSl+tzNgO3BR0tj2ywFj2xuh2mUP3AnJl
 8zPHgxfRXhF7Kf1cdhWfZ2GtTEDU6gN3XVZSGEvOANral1nUvQrcmdc4tcOR7mCRmxIc8JZ2M
 QyKJrH9RJ1wUwHp0W+wvwOkbdIJ+DLoobspnUV4oqd1NWHRRlT0MyvODJQBDrdV7Ot6+9m2NH
 EtEZFPklVALkQb0X5bigepMU087o2qod20wKyRUUSVfAgwlrO/M7TCdqqkY4qcNLEjSHeZDt3
 vVYkw19RLtyEWBcIqzUFtOrwd5MW++gjvgEgtNPHCgZj69f7ZQGHY/rcGyS2xtTnS/6sIcNrB
 4Du3/1zLSJDgnA4h5FO45hkDjcoBJg8w+ElU0hdEioaT9Yzkb+U0yEizIov7McRRCv0DThCA9
 hcWE3+UYteUfcZiFjp+gHJ56sOmUl2HPETewX7DT8mVWzo3R/EHUIkFJuuUXfOsTXh7Io6iSE
 XVN5fsLxgR3ne8Th2Bzk9m72zCn7VCMtlPhROawbQD163lR0jsqEjcEzyWY2NB1Vembnywbza
 5vLQTzd5TEmbN3HcZRDTUp5o+LwuspXkh29NXVN0SkhDJKEmQTE3k7srNT45LtbTDNMAuulFh
 XXZ453/T1o1E/r3Gh3PSXm9cWtHOPDwhwuo80shQHU92A=

Am 05.04.24 um 00:53 schrieb Jeff King:
> On Thu, Apr 04, 2024 at 11:08:38PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Support paths longer than PATH_MAX in create_one_file() (which is not a
>> hard limit e.g. on Linux) by calling mkpathdup() instead of mksnpath().
>> Remove the latter, as it becomes unused by this change.  Resist the
>> temptation of using the more convenient mkpath() to avoid introducing a
>> dependency on a static variable deep inside the apply machinery.
>>
>> Suggested-by: Jeff King <peff@peff.net>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>
> Heh, so obviously I had the same patch stewing. But one thing that gave
> me pause is: do we need to worry about preserving errno across free()
> boundaries?
>
> Traditionally touching errno was something free() was allowed to do, and
> there were definitely cases where glibc would do so (mostly due to
> munmap). But recent versions of POSIX clarify that it should not touch
> errno, and glibc as of 2.33 does not (which dates to 2021).
>
> This issue from 2015 talks about "the next version of POSIX" making that
> change:
>
>   https://sourceware.org/bugzilla/show_bug.cgi?id=3D17924
>
> but it looks to me from:
>
>   https://www.austingroupbugs.net/view.php?id=3D385
>
> that the change wasn't accepted there until 2020 (and AFAICT that hasn't
> resulted in a new published spec yet).

Horrible.  OS implementation details peeking through an API that has no
return value and no defined errors is outright Lovecraftian.

> Now it would be pretty darn useful to not have to worry about preserving
> errno. It's subtle code that's hard to remember is needed, and sometimes
> hard to get right depending on the rest of the flow control.

Yes.

> Years like "2020" and "2021" are too recent for us to say "oh, that's
> ancient history, we don't have to care anymore". But I wonder if we can
> be a little cavalier here for two reasons:
>
>   - it's rare; for the most part free() isn't going to touch errno.
>     Failures from munmap() are pretty rare, and small allocations like
>     this are probably done with sbrk() anyway. Of course that's just
>     talking about glibc, and there are other platforms. But it still
>     seems like it should be a rarity for any free() implementation to
>     fail or to want to touch errno.
>
>   - the stakes are usually pretty low; the outcome in most cases would
>     be a misleading error message as we clobber errno. But note that it
>     does sometimes affect control flow (this patch is an example; we are
>     checking for EEXIST to break out of the loop).
>
> So would it be that unreasonable to assume the modern, desired behavior,
> and mostly shrug our shoulders for other platforms? We could even
> provide:
>
>   #ifdef FREE_CLOBBERS_ERRNO
>   void git_free(void *ptr)
>   {
>         int saved_errno =3D errno;
>         free(ptr);
>         errno =3D saved_errno;
>   }
>   #define free(ptr) git_free(ptr)
>   #endif
>
> if we really wanted to be careful, though it's hard to know which
> platforms even need it (and again, it's so rare to come up in practice
> that I'd suspect people could go for a long time before realizing their
> platform was a problem). I guess the flip side is that we could use the
> function above by default, and disable it selectively (the advantage of
> disabling it being that it's slightly more efficient; maybe that's not
> even measurable?).

I think performing this ritual automatically every time on all platforms
(i.e. to use git_free() unconditionally) to provide sane errno values
around free(3) calls is better than having to worry about attacks from
the deep.  But then again I'm easily scared and still a bit in shock, so
perhaps I'm overreacting.

Ren=C3=A9
