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
	by dcvr.yhbt.net (Postfix) with ESMTP id 702E01F461
	for <e@80x24.org>; Thu, 20 Jun 2019 19:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfFTT6r (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 15:58:47 -0400
Received: from mout.web.de ([212.227.15.3]:44577 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfFTT6r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 15:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561060718;
        bh=iT45WKHgxDIqzrGXDBQ8sNB5+b2/Vvhie/q1KtDjjeI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RwlKg6LRx9MtvKoA8d/ROVniLWwZgaM9t3/13kPEw0/jAbFrKBhaDHEsTr/+CQlrN
         Mp0AeCpT3eovIskh6goKQjp1Z75tlgLu5n8RWA0kjhK3Ehc+9BvgADSwqbUxUSBgz7
         BwPJUFuX4PW7c2IVboBHrtz3LEhepwZNYQ95E+Fs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.26.169]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LqlAw-1iGyrM2hf8-00eJ63; Thu, 20
 Jun 2019 21:58:38 +0200
Subject: Re: [PATCH 4/4] config: avoid calling `labs()` on too-large data type
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.265.git.gitgitgadget@gmail.com>
 <9613c88849e53e00e1f7ade49c6c9056309ef0b9.1560426581.git.gitgitgadget@gmail.com>
 <03a68560-8058-7436-6edb-38e276a37190@web.de>
 <f22599d4-148f-212c-282c-790f5bde1706@web.de>
 <90ef3797-78a6-f6d9-443b-387c0ab7cbe7@web.de>
 <xmqq7e9ltbe2.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ebe4176d-1b51-fc82-7bce-713d098dbcf3@web.de>
Date:   Thu, 20 Jun 2019 21:58:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <xmqq7e9ltbe2.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:viTsOvocjmaQpTsKFVbXf1qinX64A+wSm0xX29qHAdZVZMRMTaE
 pYKDSe2pledUqMjjlW+mEy2th5DEnW4eZqByu6Rn1apAagSNGIOv3hi70A+lXFXY36+H5ls
 OKOGvvKOmPrlT2f3xUbyVM+Tn99xLslvew2fqrWcV8zD4hIOIBNDJ6iDlhObWxqcZu9RlQ3
 lcueBfXyDW8qMkzzfC8bA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lAPwZNtTwTY=:sUbgBLOm+5mthYKU6gqvUB
 iHlETsqOxUgpbvO5+NYz/jcQYlz0FzrGXewOsUw/VIc9n9ELtWNsjaKHEDzbMDtWYzHTkTQPi
 wO+R8kUpLI3umM9aPaY3aFD7pDsx99mCwm7GygNehlwe/L4VNycD8D5AFoC1/IDghEs0hJ0C3
 6eGwv/7exibGd3d+mUg8XLmJyod6DJ55NeLx2XGMpNfa9st9Vl8Tg8GmNZ5ABv7JleZb+F+ln
 KHjHaDF3Cig9U1U+2qP5aUxJ3ZPYerh5T7fmV5v7XfhkxLutHkTWglpXBz4xG0XPEMMA1fQ6W
 DvHocbbrcq9ldST1mGxugoLFNEkF+p7yl3vIQgxWIxBYNwYWSEJXiWnBxv9UULnGq1kYcgyVx
 a5PvJ6jagyrKF49eX+cdEGEJsm6ezBNGzvsmpiyXr1sK3BCGgT3n0x/8RdDupj1OWJpbYbgSq
 wrfd5weMoZdc8NWEvwK/4WiTI+Z4YKzyLaywupkEU2mM+/+jJQt8owFrEqGsmJUlCIndbXCpB
 6Og2vmKs0ObudE0t1BuLsWrqCUgsTI8OGDS8pVs0J3fRR/rO9NYI/rXTIvOuT3GcpYllbPo/W
 p3U4VID+++TUxww9CmzAMbMK7Iz+0uHk6Ss/b+geD8BzPt+nC+8lQZGmzaG7kte8IYlplbTvW
 s79pas6uamCtTEueHep2981aa8JMLDfO05NQlBWTw7asuS07l5GXzBxo2MCNfFaIdYQgxyu4q
 x44O/97zoKUMO9Iw6s+S0mqDKJa0YGBSjUh+fn7Qn1p/1IrnSGOcXoa0kRtI+1gM5gIIsUwyZ
 zPkk4MWKm9nqufm43FHLpwRoXtx7jBTSxsgmP/44dGQhxs4VDaah7fiQwO8QddpTSjKA3oTTC
 1j7HC5utPMoZAdIC1tRr1QxIomPirCFf43+WtQsvz+WH3KyLIIRBGdA8D0MvncSj577CfVtnL
 j2F4jw61B240oRflftxhvIj3ljAmIHuU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.06.19 um 00:26 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>>>> To fix it, let's just "unroll" the function (i.e. negate the value i=
f it
>>>>> is negative).
>>>>
>>>> There's also imaxabs(3).
>
> That may be true, but seeing that some platforms wants to see
> intmax_t defined in the compat/ layer, I suspect we cannot avoid
> having a copy of unrolled implementation somewhere in our code.

Right.  And if we later decide to give it a name then we could ask
Coccinelle to find the places that need converting with a semantic
patch like this:

	@@
	intmax_t i;
	@@
	- i < 0 ? -i : i
	+ imaxabs(i)

Side note: I was surprised to find that I added those labs(3) calls, in
83915ba521 ("use labs() for variables of type long instead of abs()",
2014-11-15).  Sloppy. :-/

> A patch to use unsigned_mult_overflows() here, on top of the
> "unrolled imaxabs" patch we reviewed, would be good to tie a loose
> end.

How about this?

=2D- >8 --
Subject: [PATCH] config: simplify unit suffix handling

parse_unit_factor() checks if a K, M or G is present after a number and
multiplies it by 2^10, 2^20 or 2^30, respectively.  One of its callers
checks if the result is smaller than the number alone to detect
overflows.  The other one passes 1 as the number and does multiplication
and overflow check itself in a similar manner.

This works, but is inconsistent, and it would break if we added support
for a bigger unit factor.  E.g. 16777217T expands to 2^64 + 2^40, which
is too big for a 64-bit number.  Modulo 2^64 we get 2^40 =3D=3D 1TB, which
is bigger than the raw number 16777217 =3D=3D 2^24 + 1, so the overflow
would go undetected by that method.

Move the multiplication out of parse_unit_factor() and rename it to
get_unit_factor() to signify its reduced functionality.  This partially
reverts c8deb5a146 ("Improve error messages when int/long cannot be
parsed from config", 2007-12-25), but keeps the improved error messages.
Use a return value of 0 to signal an invalid suffix.

And use unsigned_mult_overflows to check for an overflow *before* doing
the actual multiplication, which is simpler and can deal with larger
unit factors.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
=2D--
Patch generated with --function-context for easier reviewing.

 config.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/config.c b/config.c
index 01c6e9df23..61a8bbb5cd 100644
=2D-- a/config.c
+++ b/config.c
@@ -834,51 +834,46 @@ static int git_parse_source(config_fn_t fn, void *da=
ta,
 	return error_return;
 }

-static int parse_unit_factor(const char *end, uintmax_t *val)
+static uintmax_t get_unit_factor(const char *end)
 {
 	if (!*end)
 		return 1;
-	else if (!strcasecmp(end, "k")) {
-		*val *=3D 1024;
-		return 1;
-	}
-	else if (!strcasecmp(end, "m")) {
-		*val *=3D 1024 * 1024;
-		return 1;
-	}
-	else if (!strcasecmp(end, "g")) {
-		*val *=3D 1024 * 1024 * 1024;
-		return 1;
-	}
+	if (!strcasecmp(end, "k"))
+		return 1024;
+	if (!strcasecmp(end, "m"))
+		return 1024 * 1024;
+	if (!strcasecmp(end, "g"))
+		return 1024 * 1024 * 1024;
 	return 0;
 }

 static int git_parse_signed(const char *value, intmax_t *ret, intmax_t ma=
x)
 {
 	if (value && *value) {
 		char *end;
 		intmax_t val;
 		uintmax_t uval;
-		uintmax_t factor =3D 1;
+		uintmax_t factor;

 		errno =3D 0;
 		val =3D strtoimax(value, &end, 0);
 		if (errno =3D=3D ERANGE)
 			return 0;
-		if (!parse_unit_factor(end, &factor)) {
+		factor =3D get_unit_factor(end);
+		if (!factor) {
 			errno =3D EINVAL;
 			return 0;
 		}
 		uval =3D val < 0 ? -val : val;
-		uval *=3D factor;
-		if (uval > max || (val < 0 ? -val : val) > uval) {
+		if (unsigned_mult_overflows(factor, uval) ||
+		    factor * uval > max) {
 			errno =3D ERANGE;
 			return 0;
 		}
 		val *=3D factor;
 		*ret =3D val;
 		return 1;
 	}
 	errno =3D EINVAL;
 	return 0;
 }
@@ -886,26 +881,28 @@ static int git_parse_signed(const char *value, intma=
x_t *ret, intmax_t max)
 static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_=
t max)
 {
 	if (value && *value) {
 		char *end;
 		uintmax_t val;
-		uintmax_t oldval;
+		uintmax_t factor;

 		errno =3D 0;
 		val =3D strtoumax(value, &end, 0);
 		if (errno =3D=3D ERANGE)
 			return 0;
-		oldval =3D val;
-		if (!parse_unit_factor(end, &val)) {
+		factor =3D get_unit_factor(end);
+		if (!factor) {
 			errno =3D EINVAL;
 			return 0;
 		}
-		if (val > max || oldval > val) {
+		if (unsigned_mult_overflows(factor, val) ||
+		    factor * val > max) {
 			errno =3D ERANGE;
 			return 0;
 		}
+		val *=3D factor;
 		*ret =3D val;
 		return 1;
 	}
 	errno =3D EINVAL;
 	return 0;
 }
=2D-
2.22.0
