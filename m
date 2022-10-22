Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB95C433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 11:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiJVLGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 07:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiJVLF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 07:05:57 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907D511A09
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 03:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666434217; bh=ldMuo0dYSwK/TwEBiuG31QIspikxn4M3LoYq8U8Xfq4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KQCoCm3E21WfM6UHPuxP2c3TgalN62mG9BaaAs9237gIwtak6pgVvEd2VFXZVx2Xk
         2MmhAKJfu6ew3VP2hOGfjsM2k5PVkuAtMp3zmbiySuanwEFSVnCeEV/Qvx5T5ZvO0g
         QddTmiB/c4WqHt+qRI8IxhCSI8kTvmVacUrOXZ4VL29mRis+gIBhFz2Xgl+gvp4BEx
         /Btx0tft7mzvu8ee5PZPKonq5+H59Kh0zJYLwau2jV9pYaIvQ1HPUfG3MGpfkJgAHR
         Y8Nn6hyW2wXQPrVK0zvpYPOEEKippW5FXvlbq0VBgmAWc5fTO1edGcaAbqIvjY1bYh
         PJs0VEdQ6Z6JQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.161]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1aE3-1onXPo2yTb-002mgw; Sat, 22
 Oct 2022 10:09:27 +0200
Message-ID: <80fe7c62-2c59-a715-3a8b-2dc2331d8e37@web.de>
Date:   Sat, 22 Oct 2022 10:09:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH 3/3] git_parse_signed(): avoid integer overflow
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
 <f058f391c3821b341a15fda9ae9fd20dda6a0494.1666359915.git.gitgitgadget@gmail.com>
 <xmqqpmeljae9.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqpmeljae9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/jXz5DXKuhERSQUzGnmIbr/ui0e20F2l1xUXpprIFvGBbAQBCXn
 Ys/xxT2VBtxpqw33QRBonENdbjCVlGSgtXDQuCweBOiLS5+x85Z5A8sNCske2ReXrvqmdQV
 wRVM5ZxbiVETuDfFVG1Rg9PlBiA8pev8KFb+DDOhESTm5H94Fojv6R7c73fwYIVAC7iHJVW
 /Jg2ZjTIZzHzqmrUcAHrA==
UI-OutboundReport: notjunk:1;M01:P0:pbL5Q52HJjY=;aFDrwveLOHQjmz+mkd+Gy5DDfPN
 u1H2wfscCm5Zmb1M4Zh6Eib6IOLP+m4PIugIfBspUmrtuLMR8f9vE03OqgMTXYvIhHZ/yDG2y
 4EOb9nM5QxZzaxgiNQEjP/Q2RCUmQAWTduWm/+sEhtujuOJIooqRnFrykh025Re0Jtu4ey+LB
 Nv0QjVPr8DftHvRKYjf3j0qoE5QB6hC+avQtrTOrlkb+bS6n+ZruVuaUSC9FGa6LbfWuEPHci
 k/c8OtltQdzCVQjQXY+PCdt2pXK69HyDyeCTHOxC9qMe+6MGO2EiUmCppbZcQl0GlMURZB7hW
 bvjJ6aSxMpswKemTrwOTn1gSk0Cdhx+Yp/P6EXkHKzqOAcPHnfkZQMYcrDpW0gyBWc46FCYfP
 B/Xz4OT64RSxdnfqN8xQrJ76keFcITT6nLUVUgs7/JM0IqauKsHCLBXTWF+Pd5gm+Palimsoh
 EjbHmUP3bYugn6F7SZwIrZqo1TFNhBRX4vcmYIeBiJsU6O/Jx0s5F/qvYwFDLs+avlNtGp+Wd
 5Z/LesO31yYxBf0jhNs4+XaPDnwASypIP4P/TkXUxMhzFoJmGPIdzSYMvWBCPw5hO7U8xx8l9
 kxmAzafwY4aII37gG7Vdmay8Ff2Ja7QLgXuzRHfbvVuGw5Eua6/Nog8KB233LO9VyCbAZbKj7
 6rrbxJBwBUSraOZrXwuAIpChcVHvKsiUvsFNDtzOn1xbhseZqAsIRc7oleNskxR1rKSOYfRjU
 u67I1c8lj0psXEuzW9n5AGkUKL1tzHdLWrw93sqsoMQVR+mPSqWNi0ceJMhgFl/Th1dVusDn5
 +1wkHDu9TtvSUQuPDzW6zMz3S7QGSLWTQW6u2T/akt1XCjjbZ6wDiOThaWf1WWra7Sex1G+LW
 lQBJhQ0S2dUXfBKr4Lw6iljHZpjbvcRCx0RS4IK6gkEza6qx1KhYRmOKywbh8aQiFZ+aiJA51
 c42dcg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.10.22 um 20:31 schrieb Junio C Hamano:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> git_parse_signed() checks that the absolute value of the parsed string
>> is less than or equal to a caller supplied maximum value. When
>> calculating the absolute value there is a integer overflow if `val =3D=
=3D
>> INTMAX_MIN`.
>
> It is a problem that is worth looking into.
>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>  config.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/config.c b/config.c
>> index b7fb68026d8..aad3e00341d 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1160,8 +1160,10 @@ static int git_parse_signed(const char *value, i=
ntmax_t *ret, intmax_t max)
>>  	if (value && *value) {
>>  		char *end;
>>  		intmax_t val;
>> -		uintmax_t uval;
>> -		uintmax_t factor;
>> +		intmax_t factor;
>> +
>> +		if (max < 0)
>> +			BUG("max must be a positive integer");
>
> In parse_signed(), would we expect to accept end-user input that is
> a negative integer?  We must.  Otherwise we would not be calling a
> "signed" parser.  Now, are there cases where the valid value range
> is bounded by a negative integer at the top?  No current callers may
> pass such a value, but is it reasonable to add such a new constraints
> to an existing API function?

Hmm, if minimum and maximum are not symmetric, then we need to supply
both, don't we?

=2D-- >8 ---
Subject: [PATCH] config: let git_parse_signed() check minimum

git_parse_signed() checks that the absolute value of the parsed string
is less than or equal to a caller supplied maximum value.  When
calculating the absolute value there is a integer overflow if `val =3D=3D
INTMAX_MIN`.

Avoid overflow during sign inversion by supplying the minimum value to
the function as well.  Make `factor` signed to avoid promoting the
division results in the limit check line to unsigned, but check whether
it's positive.

Add a new macro, minimum_signed_value_of_type, and use it in the callers
of git_parse_signed() to provide the newly required minimum value.  It
calculates the minimum for a given type using division instead of right
shift because the latter is implementation-defined for signed types,
and we need an arithmetic right shift here, not a logical one.

Original-patch-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
git_config_get_expiry_in_days() could use git_parse_int(), but that's
a different topic.

 config.c          | 28 +++++++++++++++++-----------
 git-compat-util.h |  2 ++
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/config.c b/config.c
index cbb5a3bab7..7cf196dc84 100644
=2D-- a/config.c
+++ b/config.c
@@ -1155,26 +1155,24 @@ static uintmax_t get_unit_factor(const char *end)
 	return 0;
 }

-static int git_parse_signed(const char *value, intmax_t *ret, intmax_t ma=
x)
+static int git_parse_signed(const char *value, intmax_t *ret,
+			    intmax_t min, intmax_t max)
 {
 	if (value && *value) {
 		char *end;
 		intmax_t val;
-		uintmax_t uval;
-		uintmax_t factor;
+		intmax_t factor;

 		errno =3D 0;
 		val =3D strtoimax(value, &end, 0);
 		if (errno =3D=3D ERANGE)
 			return 0;
 		factor =3D get_unit_factor(end);
-		if (!factor) {
+		if (factor < 1) {
 			errno =3D EINVAL;
 			return 0;
 		}
-		uval =3D val < 0 ? -val : val;
-		if (unsigned_mult_overflows(factor, uval) ||
-		    factor * uval > max) {
+		if (val < min / factor || val > max / factor) {
 			errno =3D ERANGE;
 			return 0;
 		}
@@ -1218,7 +1216,9 @@ static int git_parse_unsigned(const char *value, uin=
tmax_t *ret, uintmax_t max)
 static int git_parse_int(const char *value, int *ret)
 {
 	intmax_t tmp;
-	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(int)))
+	if (!git_parse_signed(value, &tmp,
+			      minimum_signed_value_of_type(int),
+			      maximum_signed_value_of_type(int)))
 		return 0;
 	*ret =3D tmp;
 	return 1;
@@ -1227,7 +1227,9 @@ static int git_parse_int(const char *value, int *ret=
)
 static int git_parse_int64(const char *value, int64_t *ret)
 {
 	intmax_t tmp;
-	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(int64_t)=
))
+	if (!git_parse_signed(value, &tmp,
+			      minimum_signed_value_of_type(int64_t),
+			      maximum_signed_value_of_type(int64_t)))
 		return 0;
 	*ret =3D tmp;
 	return 1;
@@ -1245,7 +1247,9 @@ int git_parse_ulong(const char *value, unsigned long=
 *ret)
 int git_parse_ssize_t(const char *value, ssize_t *ret)
 {
 	intmax_t tmp;
-	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(ssize_t)=
))
+	if (!git_parse_signed(value, &tmp,
+			      minimum_signed_value_of_type(ssize_t),
+			      maximum_signed_value_of_type(ssize_t)))
 		return 0;
 	*ret =3D tmp;
 	return 1;
@@ -2751,7 +2755,9 @@ int git_config_get_expiry_in_days(const char *key, t=
imestamp_t *expiry, timestam
 	if (git_config_get_string_tmp(key, &expiry_string))
 		return 1; /* no such thing */

-	if (git_parse_signed(expiry_string, &days, maximum_signed_value_of_type(=
int))) {
+	if (git_parse_signed(expiry_string, &days,
+			     minimum_signed_value_of_type(int),
+			     maximum_signed_value_of_type(int))) {
 		const int scale =3D 86400;
 		*expiry =3D now - days * scale;
 		return 0;
diff --git a/git-compat-util.h b/git-compat-util.h
index ea53ea4a78..35425c373b 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -112,6 +112,8 @@ struct strbuf;

 #define bitsizeof(x)  (CHAR_BIT * sizeof(x))

+#define minimum_signed_value_of_type(a) \
+    (INTMAX_MIN / ((intmax_t)1 << (bitsizeof(intmax_t) - bitsizeof(a))))
 #define maximum_signed_value_of_type(a) \
     (INTMAX_MAX >> (bitsizeof(intmax_t) - bitsizeof(a)))

=2D-
2.38.1
