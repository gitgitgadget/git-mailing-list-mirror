Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08367356747
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 05:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476783; cv=none; b=ZxzoEoB3tU5jPRBl4rh+3OqooLgrDzSg+CUCSxL69Nq/heXipiV7opLg67h4mtO7RiALakARHMZUEMN2wmus1jhDI60T9xAzTHVKj+7URFoXrBYDlyUz+w0HG5VodpEzAKi3QcYM/MEU5XCFNOZIthVRxbRGWE8qiEMDU7iCXJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476783; c=relaxed/simple;
	bh=BgxhssbeQytbEvm2MHkHoZUJODSEtmY+wFRzm2aoUOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFzlYeoM5uNeYvCyT/d9WmpQjUHJDZIKKiyDcrRR26xd7rorRJeOlw8Y5Zyf7/YoFcpMWMgNBQFXE/dQ6nwDFT1+uR1HpxO5hKpw+wkRcilHC0A+35fIopMXGiWJHMbOX+e1J362N5t4vZSEdZAFDW5sIqSPy3awOMD7t4FPC8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=H67O3Amn; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="H67O3Amn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785476759; x=1786081559; i=l.s.r@web.de;
	bh=tAbI+8DsXrA9bs7oui+mgD9WMHOtiLewCGYtlb0efgo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=H67O3Amnv4uU61d2FocnXRwg9YRkc3P9qa+5a7iQ3OZN83jOUmFcfgEviuiREzH3
	 oVgW9GDUMyFPwcP1IEXBqdgXds5+qxzOUsR95U/PAa07T0hXcoyg7la2+tCUVP0cr
	 9OSXJvWJSWdh9DrrgaPpMd5YqkryVbqakQVIAHrp9ZGrOFdzQtCzg7PtDMirqf1Gk
	 /epPWlmZ+nmSl+xIjJhEF4XBwxyTY1FYfr6/PtbTaEMbTB3Bp36ssmnZ+W6YeGgtj
	 IjJcGlwo8IeV/3H2JmdzYQZB7Z8fcAQtvOR0QUU+W0/rZw2djvnW+zd4gdS4qxPyj
	 fuLUneyxV8M4Bphpww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MF2gM-1wj2Eg4APY-002aTF; Fri, 31
 Jul 2026 07:45:59 +0200
Message-ID: <535547d0-39fc-4c6a-a0bb-2a5f43f265ed@web.de>
Date: Fri, 31 Jul 2026 07:45:58 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] worktree: don't read out of bounds
To: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
 =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, =?UTF-8?Q?Matthias_A=C3=9Fhauer?=
 <mha1993@live.de>
References: <pull.2187.git.1784978348.gitgitgadget@gmail.com>
 <8bc69c6b80ed42888327331b1567cecf7225ea7e.1784978348.git.gitgitgadget@gmail.com>
 <xmqqbjbvypv3.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqbjbvypv3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6YV5kHWBO3cOVZMu12hajZR6czsYGDgep7yfJr7sxBh4gwbps6Y
 sd3iKwtypUVfBM5CT8TXBMuLtl679/Fi/ewWsdvf9MR5Ln50QrfNH3O3ICoSeDjDnqujFTd
 pdzlAwRUe4xnpz9LMRm3nxdcRuZwvSkNSY7aWEegPC2ang/0F+CtVQgG6fDgGjBGvmwu21x
 j8cyO9x/mTGSaoc+aClSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YBYnJJs9v5M=;AlJeAB+ShpFUTKw4p84T4w9R/fw
 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
 TstK3BZOpEfKNdkY/O0VoZnPDOtO8+Zzyg==

On 7/25/26 6:51 PM, Junio C Hamano wrote:
> "Matthias A=C3=9Fhauer via GitGitGadget" <gitgitgadget@gmail.com> writes=
:
>=20
>> `worktree_basename` tries to read from memory before the passed `path`
>> string, if `path` is empty (or only consists of directory separators).
>> That results in unexpected nonsense data being returned to the caller,
>> which can lead to issues, such as `git worktree add ""` recursively
>> deleting the current working directory, including `.git`.
>=20
> OK, so you do want to handle a case where path is something silly
> like "///".
>=20
>> Stop reading out of bounds in these cases to avoid that behaviour.
>>
>> This leads to `git worktree add ""` consistently exiting with the
>> message `BUG: How come '' becomes empty after sanitization?`, which is
>> still undesirable, but at least it doesn't result in data loss anymore.
>=20
> OK.
>=20
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> index 4bc7b4f6e7..d8188035db 100644
>> --- a/builtin/worktree.c
>> +++ b/builtin/worktree.c
>> @@ -297,17 +297,21 @@ static void remove_junk_on_signal(int signo)
>>  static const char *worktree_basename(const char *path, int *olen)
>>  {
>>  	const char *name;
>> -	int len;
>> +	int len, len2;
>> =20
>> -	len =3D strlen(path);
>> +	len2 =3D len =3D strlen(path);
>>  	while (len && is_dir_sep(path[len - 1]))
>>  		len--;
>=20
> These two 'len' variables should have clear names to distinguish
> what each length represents.  Rather than introducing a cryptic
> 'len2', give it a more meaningful name, and rename 'len' as well if
> necessary.
>=20
> I suspect that it is to remember the original length of the 'path'
> before stripping the trailing directory separators?
>=20
>> -	for (name =3D path + len - 1; name > path; name--)
>> -		if (is_dir_sep(*name)) {
>> -			name++;
>> -			break;
>> -		}
>=20
> When 'len' is 0, the original code sets 'name' to '&path[-1]' and
> does not enter the loop.  However, '*olen' is set to 0, and 'name',
> pointing before the start of the string, is returned.  If left
> unfixed, callers pass it to xstrndup(), strbuf_add(), and the like,
> reading memory before the start of the string, which is horrible and
> worth fixing.
>=20
>> +	if(len) {
>> +		for (name =3D path + len - 1; name > path; name--)
>> +			if (is_dir_sep(*name)) {
>> +				name++;
>> +				break;
>> +			}
>> +	}
>> +	else
>> +		name =3D path + len2;
>=20
> Style:
>=20
>  (1) Missing SP between 'if' and '(len'.
>=20
>  (2) 'else' sits on the same line as '}' that closes the 'if'
>      clause.
>=20
>  (3) When any one branch of an 'if'...'else if'...'else' cascade
>      needs a pair of braces to group multiple statements, all other
>      branches must use braces as well.
>=20
> Taken together:
>=20
> 	if (len) {
> 		...
> 	} else {
> 		...
> 	}
>=20
> As for what the patch intends to do, setting 'name =3D path + len2'
> when 'len' is 0 breaks when 'path' consists only of directory
> separators (for example, "/" or "///"), no?
>=20
> In that case, 'len2' is positive (for example, 3) while 'len' is 0.
> In add_worktree(), 'path + len - name' evaluates to (path + 0) -
> (path + 3) =3D -3.  Passed as size_t to strbuf_add(), this wraps
> around to SIZE_MAX - 2 (approx. 18 exabytes), leading to a buffer
> allocation failure or a crash.
>=20
> Rather than calculating 'path - 1' out of bounds or introducing
> 'len2', worktree_basename() can simply keep 'name =3D path' when 'len'
> is 0.  Using an integer index loop 'for (int i =3D len - 1; 0 <=3D i;
> i--)' avoids pointer arithmetic before the start of the buffer
> entirely, I would think.  Or am I missing something?
Interesting.  This function has two types of callers.  add_worktree()
does:

	name =3D worktree_basename(path, &len);
	strbuf_add(&sb, name, path + len - name);

While dwim_branch() and add() do basically:

	name =3D worktree_basename(path, &len);
	copy =3D xstrndup(name, len);

If path is empty or all separators, len is 0 and name invalid, as noted.
add_worktree() breaks, the other callers are mostly fine because
xstrndup() calls memchr(3) and memcpy(3) with a size of 0 internally
and thus doesn't dereference the pointer in practice.  So patch 2 should
suffice to prevent the out of bounds read.

If path contains one component ("foo/"), add_worktree() adds "foo" to
the strbuf and the others similarly duplicate "foo".  OK.

If path contains more components ("foo/bar/"), add_worktree() adds
"bar", while the others duplicate "bar/", because len is the length of
path without any trailing separator (7 in this example).

xstrndup("bar/", 7) could read out of bounds because it's calling
memchr(3) internally, which doesn't have to stop at the found byte.  But
more practically, do we really want to keep trailing separators?

worktree_basename() would be harder to misuse if it gave the length of
the basename instead.  Then add_worktree() wouldn't have to do any
pointer arithmetic and the others wouldn't risk reading out of bounds.

Ren=C3=A9

