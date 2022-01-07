Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB389C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 19:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiAGTeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 14:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiAGTd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 14:33:59 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092E8C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 11:33:59 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l4so4630075wmq.3
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 11:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4RWjMK7eEs7gv50cc27Wu2deq4Ffd14KhJpxqm7K8sY=;
        b=Zkg8nwW4ommfAqX7VVB5ueJ8IxrwYHCAS4k+j/wwh6GxKHDUfBWuStckBT9+V1Cawg
         YDzXGJwoBKW7Krb/KkOwG9VvYAAbvPxVP90pVglot+4SZEgtcYQGqh71aeRrYEpAXNaV
         gZ0fCNgnn3oD8VFps3ljfxoRZb658SVYYpCTYftfbfpDWldpAokJA9Cmz4dd8usNbQ+b
         SIpfvuYobSINkfF1e57x8Mex8TfCJO3H2fAV8M4sSmDyjEh08Jcxc2J3HK6iOlR7/0Be
         uxAieB0zBK9cwMU64yVpr4s8Ta/wAelqmhyXlwZOrHv87NYsuxabHyN8cC1WbyvjlZg3
         Zf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4RWjMK7eEs7gv50cc27Wu2deq4Ffd14KhJpxqm7K8sY=;
        b=1lzS2khoWCj6CXbI4EY2uOGohTBSRekSufYCJCZ/R3S0iTpD48Cj9hYtt/YAzDw2my
         zvLspZbhBokWkqCQjsl7ND/oMpT7UNBRQb5e9D4/CQoqp6Zy3hiviXSgn3Qrq18tyg89
         jTGfUR7Ftpc5NMnTCWw4Obq99qx7LlH/Rs49XbiZoFhLsPIH0VUlrIaL3NiwusQHTwJm
         t0HQ5NuatjpS9Ear4E3Srj6xXoub31WTdSi4Ooy9iA/WHKhi1NcVgC4A+bu+z/G/FKy3
         oxjfkdYVOcHkfQZbQGc6eIDz2+DECyklo7mHfQTi87qypztGM6fNsQ8Q5ELPrKd3luzK
         AYsA==
X-Gm-Message-State: AOAM533UQbXYvT4XBFfNKqm1AK+vXBqPj/BCjvIzDWhOK+FeTEIeFkng
        AfQW00Eb7bv/g7II3tNMQ7oJRA==
X-Google-Smtp-Source: ABdhPJxvFeGH7dp9TLckEfBy7eZOU/3FgCNbOiiTj67fif4JDPLAhlRioZSYb4er8SLtVQAY6MvJbw==
X-Received: by 2002:a1c:1f85:: with SMTP id f127mr1951793wmf.160.1641584037568;
        Fri, 07 Jan 2022 11:33:57 -0800 (PST)
Received: from smtpclient.apple (global-5-142.nat-2.net.cam.ac.uk. [131.111.5.142])
        by smtp.gmail.com with ESMTPSA id 9sm7121914wrz.90.2022.01.07.11.33.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jan 2022 11:33:57 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <xmqq7dbb9wcz.fsf@gitster.g>
Date:   Fri, 7 Jan 2022 19:33:56 +0000
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <70126D1C-37EC-42CC-B830-9730E6D43156@jrtc27.com>
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
 <YddjJ+uIQM34Gedo@nand.local> <xmqqh7agbiuq.fsf@gitster.g>
 <97D2AB55-0F8F-4C38-A5C6-1AAA43EA064A@jrtc27.com>
 <xmqqfsq09ziq.fsf@gitster.g> <YdeJ8Ub2Q0/c9kO2@camp.crustytoothpaste.net>
 <4D8B32AE-8316-4907-98F6-097901EC3DC0@jrtc27.com>
 <Ydea3EO7wrYc9/Ij@camp.crustytoothpaste.net> <xmqq7dbb9wcz.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 Jan 2022, at 19:30, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
>> I'm not opposed to a small amount of finagling for this case, but I =
am
>> very much opposed to defining your C ABI in an intentionally =
difficult
>> way.
>=20
> I was looking at git_qsort_s() today and thought that its use of
> "char buf[1k]" on stack is something we would write for a system
> without alloca().
>=20
> We already have xalloca() wrapper defined in the compat-util header.
> Perhaps it is a good idea to use it instead?
>=20
> Both the true alloca() and xmalloc() we use as a fallback (when
> <alloca.h> is not available) are supposed to return a block of
> memory that is suitably aligned for any use, no? =20

Yes; I initially considered using it, but didn=E2=80=99t in case the =
fact that
xalloca falls back on malloc when alloca doesn=E2=80=99t exist was =
considered a
regression. If that=E2=80=99s acceptable then xalloca avoids the issue =
entirely
and it=E2=80=99s just the mem pool allocator that needs some notion of =
max
alignment that isn=E2=80=99t just uintmax_t in order to support CHERI.

Jess

> compat/qsort_s.c | 20 +++++++++++---------
> 1 file changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git c/compat/qsort_s.c w/compat/qsort_s.c
> index 52d1f0a73d..63660a4304 100644
> --- c/compat/qsort_s.c
> +++ w/compat/qsort_s.c
> @@ -49,21 +49,23 @@ int git_qsort_s(void *b, size_t n, size_t s,
> 		int (*cmp)(const void *, const void *, void *), void =
*ctx)
> {
> 	const size_t size =3D st_mult(n, s);
> -	char buf[1024];
> +	char *tmp;
> +	int use_alloca;
>=20
> 	if (!n)
> 		return 0;
> 	if (!b || !cmp)
> 		return -1;
>=20
> -	if (size < sizeof(buf)) {
> -		/* The temporary array fits on the small on-stack =
buffer. */
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
> 		free(tmp);
> -	}
> 	return 0;
> }

