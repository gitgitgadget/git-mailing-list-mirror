Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB971C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 20:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiAGU5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 15:57:02 -0500
Received: from mout.web.de ([212.227.15.14]:42735 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbiAGU5B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 15:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641589010;
        bh=R8W9TTzp2wwAz58E1ysnTFAxyqZbnRVHKL0su7ulWb8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dQ8N6vXWplvvzHlZh329c51zLTaB8R3IBFfg5pNo9yj6wH2ttb37WNmjA3Rm0yr6H
         66btBNwLcpALkfjRNN+w0/HYfMMNhkwfaVp0K7MUDzm0P+0O6xdfXd7W5IRm63Uo6/
         08ciPgxtdsyL4sg7cl6tu3aEh1/F/EhDN4n886Qk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Zns-1mBnQk0b5A-00wp9H; Fri, 07
 Jan 2022 21:56:50 +0100
Message-ID: <40077881-e91a-dfba-5950-cdc03719264d@web.de>
Date:   Fri, 7 Jan 2022 21:56:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
 <YddjJ+uIQM34Gedo@nand.local> <xmqqh7agbiuq.fsf@gitster.g>
 <97D2AB55-0F8F-4C38-A5C6-1AAA43EA064A@jrtc27.com>
 <xmqqfsq09ziq.fsf@gitster.g> <YdeJ8Ub2Q0/c9kO2@camp.crustytoothpaste.net>
 <4D8B32AE-8316-4907-98F6-097901EC3DC0@jrtc27.com>
 <Ydea3EO7wrYc9/Ij@camp.crustytoothpaste.net> <xmqq7dbb9wcz.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq7dbb9wcz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pa7mx92j5p1ORZreiKy5JPeGsP+OJDxxUEXE21Upk6tHa9u0i66
 lu+u/Qz5HhtIcnA2tKvLKqSWaXIlXi6jlxyD1GKjvVfQmO2jgo/6L21w9kJ7vJe8mMw5VCA
 CTuwUx+sZAw30JKJbm4r59iNwmafd49yAFLN5tytpTonjkiJdXcs/KmJj3yetirUkJG0qRz
 9LAjmfixVuGoqsOo7GZRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5mmTEnXH3+s=:yH86U54IJ/mpC2VCjMHhlC
 2ekTt0p/L9A4UxDDOSu92Ab6/kxc3uhsE9ZkbGPIhLewqdWT2ZJ7PeUKMZrIqdtZZakpEz3JH
 gtJ8/mSJZtzce7evVnRw57xbomay3AKjvve8DJGLfyaqPIlabv91kh34D6+wASJHGhgXDtDym
 4Y1lCPz5yt8Lr6orTIQWTw6pcBfbFkoOvJ+RyyRLdcFaO5lT9hwIgjclco2PtQLwR6LS/OzWg
 VXZUVA+nuA3w9xAUb94f7EKKLWVhL7gO3vrESOgf7rm7FGlq0GT5rIfwoPcV/MVkoYGpARi9z
 oAwSWX0MUC3NcA9FKLIwkRu/EEI5HrWphoDAZsussICaGfIVsFq1CXK30jUB46WpxWa71wEaP
 btAFUUPIjK4JEZNelYYnV24orxOwNxOPTmaN2Kx2qnRiuzv2AN8uEVhH1+KYT4eT8oHyj9UGT
 zEtS9GBEUust4TDDbygRrWIl82KNaxsCH/Qp3qvcOURJAOkHs8H6CzUvsH9nBPBbHoOigvDV0
 LNFpGr4DbSh3YOmvXbbCdkjKnecqIy+IzPymgIUfJXoMVwvEbnAUD8Gn5BS3KkpLkBrWX5B+e
 1Vg0CJrl3ELWdVFV9/4zGCs5IR5+kUqfyzj2bAWr2yiHoq6oEeSpvfXC7Qs7Z/LI8ZkLfyUrq
 DiUdiluW3g3NljtjuHwsyyIif7AurVcAMLkJ+9Qdpcm3cP7nCLuFlvlFJW3L5bDvspQyzNWpW
 VbgvORoxBwlDPkXglM1Af+ABPoWYmkyDBsy5PZeAO3khgtLqf+rE8/YvNsTor5mD47f33b0Gs
 9UTPb9qBj/sasXK4IhJ/iuKfpj0N6Ej23DPdzUudLNiGSe/M4x6gHeP8cbAHtxfkBUYIPr/NW
 oyqq0MT77HsFOZ5D/PsyOND8QZj0X1ubY1fBtnJsLkY9ZEoUH0+JThBzGDJr9+uausZmrQTHv
 PeJ50lBlMZNY86435otgrWo3QMykyEA/R8IKXigc0fss2/cU/TXEYQz8EG2GWn+zOS0ZmBi8M
 N3KWxY/fMSzFgeE50pU6N/2EaEG0nhH6xWpCqwey6HUs1Zhx3L4lu7s8ipEqsLeTgIfieHN9l
 CU1HwaFthqAcf4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.01.22 um 20:30 schrieb Junio C Hamano:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> I'm not opposed to a small amount of finagling for this case, but I am
>> very much opposed to defining your C ABI in an intentionally difficult
>> way.
>
> I was looking at git_qsort_s() today and thought that its use of
> "char buf[1k]" on stack is something we would write for a system
> without alloca().
>
> We already have xalloca() wrapper defined in the compat-util header.
> Perhaps it is a good idea to use it instead?
>
> Both the true alloca() and xmalloc() we use as a fallback (when
> <alloca.h> is not available) are supposed to return a block of
> memory that is suitably aligned for any use, no?

If falling back to malloc(3) is fine in general then I wonder if we can
just it use always.  This would save two branches and make buffer
management trivial here.  How much worse is malloc(3)=C2=A0on platforms wi=
th
alloca(3)?  Do we sort lots of short lists somewhere?  In other words:
Does this stack allocation optimization actually make a measurable
difference?

Heap fragmention should not be a concern here, at least, because the
pattern of requesting, using and releasing a single allocation won't
leave holes.

>
>  compat/qsort_s.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git c/compat/qsort_s.c w/compat/qsort_s.c
> index 52d1f0a73d..63660a4304 100644
> --- c/compat/qsort_s.c
> +++ w/compat/qsort_s.c
> @@ -49,21 +49,23 @@ int git_qsort_s(void *b, size_t n, size_t s,
>  		int (*cmp)(const void *, const void *, void *), void *ctx)
>  {
>  	const size_t size =3D st_mult(n, s);
> -	char buf[1024];
> +	char *tmp;
> +	int use_alloca;
>
>  	if (!n)
>  		return 0;
>  	if (!b || !cmp)
>  		return -1;
>
> -	if (size < sizeof(buf)) {
> -		/* The temporary array fits on the small on-stack buffer. */
> -		msort_with_tmp(b, n, s, cmp, buf, ctx);
> -	} else {
> -		/* It's somewhat large, so malloc it.  */
> -		char *tmp =3D xmalloc(size);
> -		msort_with_tmp(b, n, s, cmp, tmp, ctx);
> +	use_alloca =3D (size < 1024);
> +
> +	tmp =3D use_alloca ? xalloca(size) : xmalloc(size);
> +
> +	msort_with_tmp(b, n, s, cmp, tmp, ctx);
> +
> +	if (use_alloca)
> +		xalloca_free(tmp);
> +	else
>  		free(tmp);
> -	}
>  	return 0;
>  }
