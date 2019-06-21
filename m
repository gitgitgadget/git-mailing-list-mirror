Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6101F461
	for <e@80x24.org>; Fri, 21 Jun 2019 18:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfFUSfL (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 14:35:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:55441 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfFUSfL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 14:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561142105;
        bh=5T43jS76fwXe1tKFPsufStqB/h0Io6I/Fhfe7dddkSw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ngs9FmtbhlC9h3Vlux3CMWxaQmmXScYJN8rnhs1Oep374gEzrjRJWH2EVZPufuFuK
         3P0dFbUX4wXkVAE8Cul3R1QgRXWCkA8BKU1nI26fHTy6QtrGqwR8EaJLdBEEFEL3HV
         uL/dJFgtV9EOXRBwVaJ0thvSJ4i8rdh20V2FXSfE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LztD9-1iiqhm2zCd-0155FW; Fri, 21
 Jun 2019 20:35:05 +0200
Date:   Fri, 21 Jun 2019 20:35:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/4] config: avoid calling `labs()` on too-large data
 type
In-Reply-To: <ebe4176d-1b51-fc82-7bce-713d098dbcf3@web.de>
Message-ID: <nycvar.QRO.7.76.6.1906212024010.44@tvgsbejvaqbjf.bet>
References: <pull.265.git.gitgitgadget@gmail.com> <9613c88849e53e00e1f7ade49c6c9056309ef0b9.1560426581.git.gitgitgadget@gmail.com> <03a68560-8058-7436-6edb-38e276a37190@web.de> <f22599d4-148f-212c-282c-790f5bde1706@web.de> <90ef3797-78a6-f6d9-443b-387c0ab7cbe7@web.de>
 <xmqq7e9ltbe2.fsf@gitster-ct.c.googlers.com> <ebe4176d-1b51-fc82-7bce-713d098dbcf3@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1886707034-1561142122=:44"
X-Provags-ID: V03:K1:Kotu/y5sI8hLr7BMEwzPRak7hmj8eeWWiFzwVntOFgJw5liGeTf
 udNWxlcxqpX942yQfe+maVZ53cXKWs/sV1hOOcIju3hl9gYxbLHw/56X8XvGwZFKrJRCgPb
 ch8rncnywuQj+orCh58ZI/Mlqv+tieazjFc6Hd283qyrcEx44Y9J6mBwAM1Chr9i4p7RIAo
 GCNa9IbVyTSQZhCq8I0QQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AHOJNIVB4T4=:aJTb9nwa+NsDcjK7ZgcTHI
 OIdQZ5ERK+ZN6sne7Jw18GGz9arwqRHEiD6rY1GNfIBDyp499614th7WIUF+7LB2r38g1uj6z
 jW4w1+Gfb6jXnRCFk/VB0JcWf1UTaNDZZiKAqCE6YNSjE2j/Oapm15r40MBwBDx0N5B1iGzdx
 EXPDm0OCFgumE1jJM3n6ATiBFv+HDpqNaChx1AwZnCuetJ1IFMXvHB95uFBDSBfeoH1cxrTpH
 sNJrAjEwu2a+YVkZtnyx0yPzA2bwfCZHrpoAfFE7p9giK2X0VT2ntX8nmORWBZaej+QwIWECl
 zpVwbprC/bdjICv9vrEDF9NWxkdubHjzcpmJcDlL+nEEJiC5Y/kPoWWlYH59uAVjc9XR+V74S
 mlV0XN/oxoFwxR8lFMimhH1Rvetub4wtJKTXNZGLCQg3Ph9wBGiVyh0o4o23syfWkzBfo0Lis
 N3ln62N5nEtOWxuvFyBZ92R+SIl7t59Az3cKlQamFvzXb1X4VCJh2DT6Dosm6/EsCiSrqB3lp
 iSEtwGcjDH8XJXPst+QIuoCATOuSYlpQnE+x7jmlVB2rvaP8E6RIT8qV/KRsvYQhK7nknf2XX
 3TCFX10YHqS3hAybKNtVPpKpZmnFcgBcIVpoCExxf4t5Sq5T+y5bkVEVc96mdWzGIjQLmKir+
 4OU/qqOitx82H+MadC1ukewVvV6NEi1dbd1GmQXnx4wB/sp7q5BkAVeP0SwfS5atgmM807a5V
 1bIvIvj9VmRlflyFBSF8JbAfyTNdS92w3BiG0jy1oJPXLz8ViBZUxJMtIzVFcUQ8qaXMfW5z0
 0HJzcq6ys8wB1ZcZxbznAvVbsfUoqlvIAOXoGgnIEfq4CTH4RFuRwh/YHUPp9n0/PASvsUxIC
 fZh4axfNSsRIHXhu6kNLVs5S6VFJ/Fui8OCfyYv9MAQy1g4zv8jyIsFZmAZZNiuyyqPTDzbV1
 ipl7N9n2pAHP52Mvqj9Gdkob3N2YFBsvn013EmJIjoykBX/tTcnOA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1886707034-1561142122=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Thu, 20 Jun 2019, Ren=C3=A9 Scharfe wrote:

> Subject: [PATCH] config: simplify unit suffix handling
>
> parse_unit_factor() checks if a K, M or G is present after a number and
> multiplies it by 2^10, 2^20 or 2^30, respectively.  One of its callers
> checks if the result is smaller than the number alone to detect
> overflows.  The other one passes 1 as the number and does multiplication
> and overflow check itself in a similar manner.
>
> This works, but is inconsistent, and it would break if we added support
> for a bigger unit factor.  E.g. 16777217T expands to 2^64 + 2^40, which
> is too big for a 64-bit number.  Modulo 2^64 we get 2^40 =3D=3D 1TB, whi=
ch
> is bigger than the raw number 16777217 =3D=3D 2^24 + 1, so the overflow
> would go undetected by that method.
>
> Move the multiplication out of parse_unit_factor() and rename it to
> get_unit_factor() to signify its reduced functionality.  This partially

I do not necessarily think that the name `get_unit_factor()` is better,
given that we still parse the unit factor. I'd vote for keeping the
original name.

However, what _does_ make sense is to change that function to _really_
only parse the unit factor. That is, I would keep the exact signature, I
just would not multiply `*val` by the unit factor, I would overwrite it by
the unit factor instead.

At least that is what I would have expected, reading the name
`parse_unit_factor()`.

> reverts c8deb5a146 ("Improve error messages when int/long cannot be
> parsed from config", 2007-12-25), but keeps the improved error messages.
> Use a return value of 0 to signal an invalid suffix.

This comment should probably become a code comment above the function.

> And use unsigned_mult_overflows to check for an overflow *before* doing
> the actual multiplication, which is simpler and can deal with larger
> unit factors.

Makes sense.

> Signed-off-by: Rene Scharfe <l.s.r@web.de>

What, no accent?

> ---
> Patch generated with --function-context for easier reviewing.

Ooh, ooh, I did not know that flag. Neat!

> diff --git a/config.c b/config.c
> index 01c6e9df23..61a8bbb5cd 100644
> --- a/config.c
> +++ b/config.c
> @@ -834,51 +834,46 @@ static int git_parse_source(config_fn_t fn, void *=
data,
>  	return error_return;
>  }
>
> -static int parse_unit_factor(const char *end, uintmax_t *val)
> +static uintmax_t get_unit_factor(const char *end)

It has been a historical wart that the parameter was called `end`. Maybe
that could be fixed, "while at it"?

And as I said earlier, I do not see the need to change the signature
(including the function name) at all.

>  {
>  	if (!*end)
>  		return 1;
> -	else if (!strcasecmp(end, "k")) {
> -		*val *=3D 1024;
> -		return 1;
> -	}
> -	else if (!strcasecmp(end, "m")) {
> -		*val *=3D 1024 * 1024;
> -		return 1;
> -	}
> -	else if (!strcasecmp(end, "g")) {
> -		*val *=3D 1024 * 1024 * 1024;
> -		return 1;
> -	}
> +	if (!strcasecmp(end, "k"))
> +		return 1024;
> +	if (!strcasecmp(end, "m"))
> +		return 1024 * 1024;
> +	if (!strcasecmp(end, "g"))
> +		return 1024 * 1024 * 1024;
>  	return 0;
>  }
>
>  static int git_parse_signed(const char *value, intmax_t *ret, intmax_t =
max)
>  {
>  	if (value && *value) {
>  		char *end;
>  		intmax_t val;
>  		uintmax_t uval;
> -		uintmax_t factor =3D 1;
> +		uintmax_t factor;

I'd keep this change, but...

>
>  		errno =3D 0;
>  		val =3D strtoimax(value, &end, 0);
>  		if (errno =3D=3D ERANGE)
>  			return 0;
> -		if (!parse_unit_factor(end, &factor)) {
> +		factor =3D get_unit_factor(end);
> +		if (!factor) {

... drop this change, and...

>  			errno =3D EINVAL;
>  			return 0;
>  		}
>  		uval =3D val < 0 ? -val : val;
> -		uval *=3D factor;
> -		if (uval > max || (val < 0 ? -val : val) > uval) {
> +		if (unsigned_mult_overflows(factor, uval) ||
> +		    factor * uval > max) {

... again keep this change.

>  			errno =3D ERANGE;
>  			return 0;
>  		}
>  		val *=3D factor;
>  		*ret =3D val;
>  		return 1;
>  	}
>  	errno =3D EINVAL;
>  	return 0;
>  }
> @@ -886,26 +881,28 @@ static int git_parse_signed(const char *value, int=
max_t *ret, intmax_t max)
>  static int git_parse_unsigned(const char *value, uintmax_t *ret, uintma=
x_t max)
>  {
>  	if (value && *value) {
>  		char *end;
>  		uintmax_t val;
> -		uintmax_t oldval;
> +		uintmax_t factor;

Good.

>
>  		errno =3D 0;
>  		val =3D strtoumax(value, &end, 0);
>  		if (errno =3D=3D ERANGE)
>  			return 0;
> -		oldval =3D val;
> -		if (!parse_unit_factor(end, &val)) {
> +		factor =3D get_unit_factor(end);
> +		if (!factor) {

Again, here I would strongly suggest the less intrusive change (with a
more intuitive outcome):

-		oldval =3D val;
-		if (!parse_unit_factor(end, &val)) {
+		if (!parse_unit_factor(end, &factor)) {

>  			errno =3D EINVAL;
>  			return 0;
>  		}
> -		if (val > max || oldval > val) {
> +		if (unsigned_mult_overflows(factor, val) ||
> +		    factor * val > max) {

And this is obviously a good change again.

>  			errno =3D ERANGE;
>  			return 0;
>  		}
> +		val *=3D factor;

As is this.

Thanks for working on this!
Dscho

>  		*ret =3D val;
>  		return 1;
>  	}
>  	errno =3D EINVAL;
>  	return 0;
>  }
> --
> 2.22.0
>

--8323328-1886707034-1561142122=:44--
