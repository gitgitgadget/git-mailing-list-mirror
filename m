Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D05411F462
	for <e@80x24.org>; Sun, 16 Jun 2019 06:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfFPGsS (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 02:48:18 -0400
Received: from mout.web.de ([212.227.15.3]:42641 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfFPGsS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 02:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560667690;
        bh=lHMBxly2r6CZRNRR9R9MrMkWgJ4BDfoA0+VKVPbgtQA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GhZdBodPyAUwylW0jBXQYjylRLwuRPWkIlfJQzS7XMTbB76Rq2YPJ16ulLceUYN55
         2D7XHjm9nP4+BxRIRrswNjB9NB4847YIx3xhsXK8d4xgUVma/CS/mzpPBRAT0VDnmA
         rxYB9hFf9bGZYqQbav5jf6R6PyqlfX7BOhKHBQ8w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.26.169]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmuQW-1iGz2c1OY8-00h6AB; Sun, 16
 Jun 2019 08:48:10 +0200
Subject: Re: [PATCH 4/4] config: avoid calling `labs()` on too-large data type
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.265.git.gitgitgadget@gmail.com>
 <9613c88849e53e00e1f7ade49c6c9056309ef0b9.1560426581.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <03a68560-8058-7436-6edb-38e276a37190@web.de>
Date:   Sun, 16 Jun 2019 08:48:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9613c88849e53e00e1f7ade49c6c9056309ef0b9.1560426581.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aAjTbnuHMx6Mshx5O/7nP5Vcbb7giQDJhOd7guEMyeIn2UkC2dX
 RXhgJVxhqGcTi2VWPODI9Q9K7e1sdOGZvj5xMY7Rx5FP5Kuqgpc7NDdpPtk26jZtV87Zdpa
 fyid/dGwwVVMYh0IDFvftVrpFp9iDEftkoYVZDez0rCJfxCFgGgvMhvPXK5nMG4ZqxcKqZ+
 p5pARGtcTkyNoWJLhQt2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fqh4/bIpf98=:2VrUJywsSifusRN64w+XQS
 vJWI+NV2m8kjEhJGHaCb2fcpn+SJQmZK5Tck64YvhnSweHKlq1Hp5ak2XMgw0by1FNT2TnyQJ
 FlDs7mGMuTjkuAr97M0Kbb66N4IQyDKPicu4ie+2HxJHL6hMHn98U01Mvbjc8CpkULGsbE693
 Rru6KsSUHmCirBiGckBekHMw8L84ELtha4LQSpbPP9v54iaWYG+Lbltvso6MciKuoHvHQ74HN
 QTlwzVplLd0NjB9aHrSnkpRkdQ/NbAXXUdVhq/dIdXnWpDyNcbUZFwJVt3MWkjTrt8C34UXQG
 ItB2O+nP/1aEmmT7LSesYB/WV1rmgqn/cBA7FMTd9M+rRViNzJLVgArqj6fexM0k5GqGhnEet
 HU/YYIBsSfbYz9jspy+TWD4emF6PYBCGjWWOb4hR2b37UdjDyHJmTfUaARDMPH2TN7RQcLPxL
 DCkpWpyYG5XGgDvu+++1H6qBAevYMhdaDa3QRcK6VtdKILmR2P8irSEPWPvKJb876czIWI1qe
 2u0NyhQbXInIRc9Oaw4kb7O4U7B28SvgAVCxlIuetXXnQ39kBZkzsvrEKmCEJ5aN7kBWZVkd4
 CGxR54WT/lF6gG2qs5CibOED5acRTi964hDXVALd9DRk59j/XgNGRNw0T0pSjZMYII3qhxKCl
 HleMlO+lTSySdJ9sgOd7XEDKGhL1FxzegsuhIqBiMAZizKmoPvVpmpiX7XIAukrPBl7k0Mo07
 /IDsKwZPIUOI9gf75r8Jf2MlWaX0KKMnu4Pl+mrPAU4WfoG9m1xaycxGaFFl3GqEReGPAQWAX
 LcGWipGnZCOL2hJilgH6o0EKiJz769XzcuuuZhNKtRPIeQAygS1DGbdgH4PPZMDPaAoNWWbXI
 fWfaA37UwODD1v5DZOtDYEKmrM4MNFwZNIyeO1wax8+bAzbJG1OoGxr3P764R6Ufk+VMP9sVP
 cfFXS7Dy10sqEGFKoosTH6XB3p0LfUNQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.06.19 um 13:49 schrieb Johannes Schindelin via GitGitGadget:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `labs()` function operates, as the initial `l` suggests, on `long`
> parameters. However, in `config.c` we tried to use it on values of type
> `intmax_t`.
>
> This problem was found by GCC v9.x.
>
> To fix it, let's just "unroll" the function (i.e. negate the value if it
> is negative).

There's also imaxabs(3).

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  config.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/config.c b/config.c
> index 296a6d9cc4..01c6e9df23 100644
> --- a/config.c
> +++ b/config.c
> @@ -869,9 +869,9 @@ static int git_parse_signed(const char *value, intma=
x_t *ret, intmax_t max)
>  			errno =3D EINVAL;
>  			return 0;
>  		}
> -		uval =3D labs(val);
> +		uval =3D val < 0 ? -val : val;
>  		uval *=3D factor;
> -		if (uval > max || labs(val) > uval) {
> +		if (uval > max || (val < 0 ? -val : val) > uval) {
>  			errno =3D ERANGE;
>  			return 0;
>  		}

So this check uses unsigned arithmetic to find out if the multiplication
overflows, right?  Let's say value is "4G", then val will be 4 and
factor will be 2^30.  Multiplying the two yields 2^32.  On a 32-bit
system this will wrap around to 0, so that's what we get for uval there.
The range check will then pass unless max is negative, which is wrong.

This behavior was not introduced by your patch, of course.

We could fix it by using the macro unsigned_mult_overflows():

		uval =3D imaxabs(val);
		if (unsigned_mult_overflows(uval, factor) ||
		    uval * factor > max) {
			errno =3D ERANGE;
			return 0;
		}

Ren=C3=A9
