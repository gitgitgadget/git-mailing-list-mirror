Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79665C433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 13:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242079AbiARNb0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 08:31:26 -0500
Received: from mout.web.de ([212.227.15.14]:46451 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235098AbiARNb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 08:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642512663;
        bh=sSPWEabWj4uG8+VDcZKC/7CIRhvSyhip7RlraqRs180=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EUeQYn5dAQlSnaOdmRYQwk9XI0tSQHq6uIMnm68FNv/7ed4UwaL5gcll348fla/Nl
         6hR2jc6cdjGuNOAsF3ruiCvkWjvlGYPnydiLvHiFykRKRq1peUFZDX3wyqLYesQcXg
         cHx4xwrkXnevevd4XjuxHu9u+ncyOFFeGL3j9QxE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRF3I-1mvT743lZs-00NZU3; Tue, 18
 Jan 2022 14:31:02 +0100
Message-ID: <fdab40cf-572c-d5a1-3dc0-8afe736c38af@web.de>
Date:   Tue, 18 Jan 2022 14:31:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        rsbecker@nexbridge.com, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-2-sandals@crustytoothpaste.net>
 <220118.86v8yhpdmr.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220118.86v8yhpdmr.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JDIJZlHMNHJn6Iayjps4fK1Q7Y/estyof5txf34c4W6KiND99hi
 dy8/FqxPUvJn2//3eZ9E4bkMoGWzx+TwazWR9S8sP+z7O4LRkuAMvbPCJx1nhY9sM/2XK4h
 xDRfystRkBBP/lcDKJIESOJ7U/htsuTWEKUFB9wo59RyE1W8yeK7QDOR/0swno/xEx/Mnj6
 ioFmkqSNoEHogvlwCMb7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jTB5bPOGB8s=:raM9JpiRrRRH53BQuuZN2f
 Uv0z6DIxzkKRVz85P1oPUD/zXC9ktWenpZlmXzgKmXpdXqzf7+DXivHmolDNiIsK+qcEXRojC
 dyctTpU4TOXeuPjGmBVciAWT6hDGSZR5+HgWiKBP+HChx7XMRD/gyyxQjuVAkIOyposLujt6S
 bAbkJyHnRytSZ3LGG85GshlCkj+GMGNaAsRq/xVoxIlcETEPSwicceIATnZ/X6FbQ4KnLcTvz
 6PLm2qbE0fE2fxDFH3XLT5m3RNQyoDJowa0Hh6oFPJ0+2YhDASWgL6i6R1dSIBgDuliaL+ccy
 lQkb1PhvJJLNweizAlfUnGrk6YdjzfzJM9Q7CeaZ/j3DMwHt2wvmE2V26SnoIsfR6+pvhDX5O
 mi+jyUXFZFoj6xxOL3wf+D8YaOXP0ZZ3ZdZmfsXoSOoKpuZqXZ52qcB0v5hLSk7NN3fAn+Kdp
 Si2iin4u/AvWY5Oo6a9w7MbJ83aGoXFARl9WQX3byG6rVAzNt6dUp9p1HYCazzQWf6xKPLGw1
 zATCdkIvOGZeU6jEefJx45kqMfNP29sn3zhiCVSgwkzDKHmzBThp13vNLTY9rO2TtueOX2aeg
 rbv1fCtINPBGqo+yEJcG+HnODVCfsm453wgHU2gHT+2ZXrYyAOO6ysevzLkBrAb9FKGvX4LDo
 9ICz2l9Wy3r1bUgHhTKDaMvZlXazxCe5jvuc2B5lJd5oQSBQ6PLkB1LLZWmsgXmNFZd3dCxES
 YERKV3J9xQ7zlnE4UGVk1hyTAC7pugYZcTI6sdoN09IraPq0yM4a71g1jnCEOEtgnhCBovCZM
 7L8qolJuzRH+m40e1rNJSJ1ynEN7TvZpUH1ZrLyx+0UvoE7VlNWt5QKr4atsxHUOkvRUsXrZX
 Mw6erwW7qsKSHqrs0Pw2cq/u6LnZXqTDNwIkqfVXxYA2x1MNxyB7psj3rJW1gKkjz5Deyvtze
 Mf8a/DG39yGdn3eg8FHa+VgHUaJlJ2NwfZHtDrBUfs01vfk04TJ5lKQBM85aOF8MDc7TzYM0N
 S1hymoRIhK1vg7g2FHC39UHSFp5YJxoAUCX0iSCVa7+I/J9d7VJ3gzkCQomBJrs7Eyct7R1lr
 qpootOe4wJhpEU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.01.22 um 10:45 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Mon, Jan 17 2022, brian m. carlson wrote:
>
>> +int csprng_bytes(void *buf, size_t len)
>> +{
>> +#if defined(HAVE_ARC4RANDOM) || defined(HAVE_ARC4RANDOM_LIBBSD)
>> +	/* This function never returns an error. */
>> +	arc4random_buf(buf, len);
>> +	return 0;
>> +#elif defined(HAVE_GETRANDOM)
>> +	ssize_t res;
>> +	char *p =3D buf;
>> +	while (len) {
>> +		res =3D getrandom(p, len, 0);
>> +		if (res < 0)
>> +			return -1;
>> +		len -=3D res;
>> +		p +=3D res;
>> +	}
>> +	return 0;
>> +#elif defined(HAVE_GETENTROPY)
>> +	int res;
>> +	char *p =3D buf;
>> +	while (len) {
>> +		/* getentropy has a maximum size of 256 bytes. */
>> +		size_t chunk =3D len < 256 ? len : 256;
>> +		res =3D getentropy(p, chunk);
>> +		if (res < 0)
>> +			return -1;
>> +		len -=3D chunk;
>> +		p +=3D chunk;
>> +	}
>> +	return 0;
>> +#elif defined(HAVE_RTLGENRANDOM)
>> +	if (!RtlGenRandom(buf, len))
>> +		return -1;
>> +	return 0;
>> +#elif defined(HAVE_OPENSSL_CSPRNG)
>> +	int res =3D RAND_bytes(buf, len);
>> +	if (res =3D=3D 1)
>> +		return 0;
>> +	if (res =3D=3D -1)
>> +		errno =3D ENOTSUP;
>> +	else
>> +		errno =3D EIO;
>> +	return -1;
>
> Why fake up errno here instead of just returning -1? In 2/2 you call
> error_errno(). This seems buggy for a function that doesn't clear errno
> and doesn't guarantee that it's set on failure....

Clearing errno is unnecessary as long as it's always set on error and
the return code indicates whether to look at it.  Translating the return
codes of RAND_bytes to suitable errno values makes sense if the goal is
to consistently report errors that way on all platforms.

arc4random_buf never fails, getrandom and getentropy do set errno, so no
translation is needed for them.  RAND_bytes doesn't set errno according
to [1], and the translation above looks sensible.

RtlGenRandom also doesn't set errno according to [2], but a translation
is missing above.  Should it set errno to EIO in the error case?

[1] https://www.openssl.org/docs/manmaster/man3/RAND_bytes.html
[2] https://docs.microsoft.com/en-us/windows/win32/api/ntsecapi/nf-ntsecap=
i-rtlgenrandom

>
>> +#else
>> +	ssize_t res;
>> +	char *p =3D buf;
>> +	int fd, err;
>> +	fd =3D open("/dev/urandom", O_RDONLY);
>> +	if (fd < 0)
>> +		return -1;
>> +	while (len) {
>> +		res =3D xread(fd, p, len);
>> +		if (res < 0) {
>> +			err =3D errno;
>> +			close(fd);
>> +			errno =3D err;
>> +			return -1;
>> +		}
>> +		len -=3D res;
>> +		p +=3D res;
>> +	}
>> +	close(fd);
>> +	return 0;
>> +#endif
>> +}
>
> ...seems better to turn it into a "int *failure_errno" parameter
> instead, or just have the function itself call error_errno() in these
> cases.
>
> You can't just check "if (errno)" either due to the return value of
> close() not being checked here...

If the last close(2) call fails for some reason then callers of
csprng_bytes() won't notice due to the return code being zero, nor do
they care -- they got their random data and they cannot do anything
about the file descriptor that now hangs in limbo.  So this code looks
OK to me.

Ren=C3=A9
