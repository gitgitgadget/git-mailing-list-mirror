Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4144013958A
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138799; cv=none; b=mg+tZMFQaGdnwTPS3Mz+J5oxAv0jeDOC0glJCCleqqvkMLtL+917Z0/vDjYDY4FOs7mTlceDUO80MhEZwVoHiTYwV9HksO8SE4250I382jRHVX3g/XfnnSdVIQX2SV65p1LQWrPs19zbumALXdI0XhTXlknXcO4XfnqCbTS45ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138799; c=relaxed/simple;
	bh=TnXTPQuUBAcmsJIEztEz29q4kD02bBwfZQV3QC+sAxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkDkZaO8kyyfnZ7JUJU4aV7k6FPK6E5zGgowJoZIR5HMNwJgmN0jZNSkgPlx8NrB6TGguOcRFvXvthQR44gX5wze7Iujflagca1lerOiww41fBJjoed5wDPZwleOC6VpaU7EYwRLeHME+2A5hLdIIy30D8hrhKnEYcmgbKuXEyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=KDCYtEMS; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="KDCYtEMS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712138794; x=1712743594; i=l.s.r@web.de;
	bh=Ecll+fidwleWgcqdDKXZAbVICdG2axTLBcMvuq5pepI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=KDCYtEMSh9twWKtX9yzgJ7rrMPwkKtgfn3NmTyxVDDWFYsV/+L+2F8s/lONMwZyA
	 zy5oz0fBop57rBmcoTiEK9UaTRwjzvJyjQZLjdXG+LP7qRypeLJkBVhZRWXrvEVuO
	 M6xIpX71UkITrUbLXKf1pFfvxnWjOZPXTkgCF82Im3i1FrWn8TflkfKLUZRvCIyGI
	 BykT9jdlvV3Sx6Gul1IjK7I6ZSSvnrKiDDoq1XQWpOP9tAm4dK0fBh0kX7ewlFw6P
	 imR4s9CqkTl8VhoVItWze2eYZRDAZnsn1cMYEjAIo2J+9UlQ9mqDadeMrKgsh6Mjx
	 R7Jcb8cmNwhdPNmEdA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6sG3-1st7ED0HRn-00ylob; Wed, 03
 Apr 2024 12:01:14 +0200
Message-ID: <b48fd3ee-2975-481f-aa0e-8ec4d07ea705@web.de>
Date: Wed, 3 Apr 2024 12:01:13 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mem-pool: use st_add() in mem_pool_strvfmt()
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <bbe00b9e-64d8-4ec8-a2b9-2c6917c72dbd@web.de>
 <20240401033642.GB2639525@coredump.intra.peff.net>
 <9f26b9f0-f8d7-4988-b6d4-e0446dab30b1@web.de>
 <20240403011818.GB892394@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240403011818.GB892394@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OETAd8c0LY0oEWQgclM/JPbnnmT0CKjSJeDqXtIIAOQ5OYBYGTK
 +GYvBXlC+3Y87D0u6dLlbqwCZNtWoL2m6JD2/ndIZloBdTmARu1meCcoBCGk8L1u1xaMgnz
 JaXZTcPYiItKYFi5HCruLznTk3tiddnAf6L1ppEDreixQxW9ijTq0nexC0s/tQKz2qmx6rP
 d2kVoa9Gd//4pOTrV4yrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jfyZ5YW4lmc=;T+HLT4ptox/XGbRnoAU2s8Cm5m4
 7XSdzno0OPoMY3qQIGn7A9OzcCngmaXr8hAWAtM81pr5i5c+OsjQ3zjA5eGfiF9zsCanwnA7s
 YLNUrX5NFufDOpCSRfU2RqlJz5T3tLTfGJfCPkVBYC4Wgoxokd4jTvbkMpnysQ/zJdyFVTG/i
 luGm7rNQxUkeOlusXvGP3nqU6NUCQ+KIVDdvEi10UhtvMqdA90Z4PnqFn4hGjVsh7oHWr+Ses
 JJ17dy53Ng8/fWLGXchIligjrW9+VyhRsTtU4WlCa6ydHEF+qn4uLYPkEoBsn3zwa8nuYxHQ/
 MdESJ89RkLk+nVwVbVaWi8qkKTdmXwQbyCoCOZIDiPG4Eu5EFvnm1Ko+qa1FuWq4vHMyo/l46
 41ZAhCp9ivItDNYpMG+9LfE+8NvwBcL9jBzDb6NOGfFr9EodYvAYwgazz8DJhHdDS8uSd4bvR
 Qn09QPqz/M0ilL+kO9OiPfL1RLWXWG+cA5fwqtzuWzWcneBV63ctztmkQHbbdUwK5xE6mx9dH
 NqbYJRGcYTnlbQCwsVZuxrnoy9h7Jd4WcDkUu6bxYD2Fdyi9j2sTk39lfm82q+LT6jPPGwulF
 RNutfefTI09xa/PNODEVdVo/vezqAmvegCeyjssyuZwaYg1OhKGn3vCGyEJI7rYO4rDlSHNNi
 ZJh0EWN/TVlPwb1qXWdzWjS9EuXN1gDOj6OS90EdJ1CTbtoQp/020WXIZkyeZJMV9as15BzC7
 mX4ZysSELgKY556KiZHrSbtQWmToYXDkSdNlkNASLasuRw5YpQJFUHQf4iGoNS3PvLjpGZO82
 lqVp7QseQmPy9rYj5qnLSuax8I57qtedUEaa0asD2+Wx0=

Am 03.04.24 um 03:18 schrieb Jeff King:
> On Tue, Apr 02, 2024 at 03:48:45PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Makes sense.  Could be rolled into a new wrapper, xvsnprintf();
>> imap-send.c::nfvasprintf() could call it as well.
>>
>> There are also callers of vsnprintf(3) that use its return value withou=
t
>> checking for error: builtin/receive-pack.c::report_message(),
>> path.c::mksnpath() and arguably imap-send.c::nfsnprintf().
>
> Hmm, yeah. Those are all OK not to use xsnprintf(), since they handle
> truncation themselves. But the first two don't look like they handle a
> negative return well. In report_message(), we'd end up shrinking "sz".
> That's potentially an out-of-bounds problem, except that we'll always
> have put a non-empty prefix into the buffer.

Getting only a truncated prefix is hopefully detected as invalid, but
explicit handling would probably be better.

> For mksnpath(), though, I
> suspect that trying to format a very long name could result in the
> output being full of uninitialized bytes.
>
> It only has one caller, which creates "foo~1" when we got EEXIST from
> "foo". So I doubt you can get up to too much mischief with it. But it
> could easily be replaced by mkpathdup() (or even a reusable strbuf
> outside the loop if you really wanted to hyper-optimize)
>
> And then we could get rid of mksnpath() entirely, and its horrible
> bad_path failure mode.

mkpath() would be perfect but unusable in multiple threads.  Cleaning
up after mkpathdup() is a bit iffy in that caller.  strbuf would be a
bit much in that error path, I think, and you might have to export or
reimplement strbuf_cleanup_path().

>> We can throw in errno to distinguish between EILSEQ (invalid wide
>> character) and EOVERFLOW.  And we'd better not call die_errno() to avoi=
d
>> triggering a recursion warning.  We can open-code it instead:
>>
>>         if (vsnprintf(p, pend - p, err, params) < 0) {
>>                 fprintf(stderr, _("%sunable to format message '%s': %s\=
n"),
>>                         _("fatal: "), err, strerror(errno));
>>                 exit(128);
>>         }
>
> We could also just throw it into the buffer and let the rest of the
> function proceed, like:
>
> diff --git a/usage.c b/usage.c
> index 09f0ed509b..5baab98fa3 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -19,8 +19,10 @@ static void vreportf(const char *prefix, const char *=
err, va_list params)
>  	}
>  	memcpy(msg, prefix, prefix_len);
>  	p =3D msg + prefix_len;
> -	if (vsnprintf(p, pend - p, err, params) < 0)
> +	if (vsnprintf(p, pend - p, err, params) < 0) {
> +		if (snprintf(p, pend - p, "could not format error: %s", err) < 0)
>  		*p =3D '\0'; /* vsnprintf() failed, clip at prefix */
> +	}
>
>  	for (; p !=3D pend - 1 && *p; p++) {
>  		if (iscntrl(*p) && *p !=3D '\t' && *p !=3D '\n')
>
> Though most of the rest of the function is not that useful (it is mostly
> removing unreadable chars, and hopefully we do not have any of those in
> our format strings!).

For warnings and usage messages this would keep the prefix and not
die.  This would look a bit strange, no?

	usage: could not format error: TERRIBLE MESSAGE!

> I had not thought about showing strerror(). The C
> standard does mention a negative value for encoding errors, but says
> nothing about errno. POSIX does seem to mention EILSEQ and EOVERFLOW.
> So this...
>
>> But when I ran your test command (on macOS 14.4.1) ten times with this
>> change I got:
>>
>> fatal: unable to format message 'invalid ref format: %s': Invalid argum=
ent
>> fatal: unable to format message 'invalid ref format: %s': Undefined err=
or: 0
>> fatal: unable to format message 'invalid ref format: %s': Invalid argum=
ent
>> fatal: unable to format message 'invalid ref format: %s': Undefined err=
or: 0
>> fatal: unable to format message 'invalid ref format: %s': Invalid argum=
ent
>> fatal: unable to format message 'invalid ref format: %s': Undefined err=
or: 0
>> fatal: unable to format message 'invalid ref format: %s': Invalid argum=
ent
>> fatal: unable to format message 'invalid ref format: %s': Undefined err=
or: 0
>> fatal: unable to format message 'invalid ref format: %s': Undefined err=
or: 0
>> fatal: unable to format message 'invalid ref format: %s': Undefined err=
or: 0
>>
>> Which scares me.  Why is errno sometimes zero?  Why EINVAL instead of
>> EOVERFLOW?  O_o
>
> ...is just confusing. I do think even without worrying about errno,
> simply saying "I tried to format 'some error: %s' and couldn't" is going
> to be way more useful than just "fatal: ". The only reason it would fail
> is that there's something gross in that "%s". We can't be more specific
> without interpreting the printf-format ourselves (which is probably not
> worth it).

Yes, showing errno doesn't add that much value.  Except in this case it
shows that there's something going on that I don't understand.  Dare I
dig deeper?  Probably not..

Ren=C3=A9
