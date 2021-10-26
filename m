Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2A9C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 20:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8654F60F70
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 20:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbhJZUIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 16:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239090AbhJZUI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 16:08:29 -0400
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2599C061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 13:06:04 -0700 (PDT)
Message-ID: <7bd2ef6f-9afe-2c44-db51-9307b0cd5f0f@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635278763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+TkcKoovQ5pnMP2k9OxzZnfLLFHNaNpwcgR+sKKOoIg=;
        b=gGRCHfjI2Nb/nhqPYJXDUdxBFnWqoncxPmWIKj1bblShG1r75kuvvAJCRow0DTrMjlrVeJ
        20m0fFgS9N7yhqzk20qvUeqHsYwQh0epITcfSpCVyUZ+Pi4M+cOUWmsFocNyBEklWgTeKw
        NTOlxZhpVC+WV4gl38+2oFjVW3tWJeqMIglAMddmDyul3G65BwaVi7FUO6kItyEbWfJG/m
        gM3VfAmDwh6H8LZcUSKxDfGfSSo2RjNmZU6VnrWkWroMEaxzJJyhiZLcJSTsH8EdWWW7aj
        7aTL+r1+yzLK7UQAfRyRxBVa7bb52HP+i2/wCPyW5w2HbrzRLEL0jBTANEjm2vWXRKwl3R
        uIw7oBnYGu91/gOxESyScDTZ8cW/Etw8mipPDIM8fwJlJL2Z+u6RminDa4U19PhY9Uqhul
        RcqdpMQkeav5MK+B5AuUvhGsYanfznRMo0k9KG+e0DJbGvsV3sFMUQD97KvyRvQTiReOPK
        AkzSOLvgHEZG0Uigb7XDhbipyAGVN6VOIjMbb0+A88je2NemIP2sWldAPD5hvi6GjRRp7W
        PVnXJ/SLkVJvDKyPL6xR1AxLKDq7n0i4oK/NftYKY9sk9Cj9U2ldMQFC9H04FqhiaWlBQO
        nE39d668i8KHi5yv0SFaPsuzAOJYnQwx9jp4L4ZAgGDAnNta8BhN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635278763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+TkcKoovQ5pnMP2k9OxzZnfLLFHNaNpwcgR+sKKOoIg=;
        b=msXrMG7jdFGrJbGDoDKFJLfyAOCEsqUI7YKTBKLN1BU9u2c6nykZ4BeF5pnEdWJ9XZyKkk
        KP5SJaSBzNLHCoDQ==
Date:   Tue, 26 Oct 2021 16:05:59 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] pretty.c: rework describe options parsing for
 better extensibility
Content-Language: en-US-large
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211026013452.1372122-2-eschwartz@archlinux.org>
 <CAPig+cTWeN9_Z1jNLyyMsbRS4oOoyrPAWa3+JdCtsgE2B-rKFg@mail.gmail.com>
From:   Eli Schwartz <eschwartz@archlinux.org>
X-Clacks-Overhead: GNU Terry Pratchett
In-Reply-To: <CAPig+cTWeN9_Z1jNLyyMsbRS4oOoyrPAWa3+JdCtsgE2B-rKFg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Z5ryNvhHo2noYwOW95IdLeLe"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Z5ryNvhHo2noYwOW95IdLeLe
Content-Type: multipart/mixed; boundary="------------JwNEylsaxFbj0jPWJDgWjPHj";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Git List <git@vger.kernel.org>
Message-ID: <7bd2ef6f-9afe-2c44-db51-9307b0cd5f0f@archlinux.org>
Subject: Re: [PATCH v2 1/3] pretty.c: rework describe options parsing for
 better extensibility
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211026013452.1372122-2-eschwartz@archlinux.org>
 <CAPig+cTWeN9_Z1jNLyyMsbRS4oOoyrPAWa3+JdCtsgE2B-rKFg@mail.gmail.com>
In-Reply-To: <CAPig+cTWeN9_Z1jNLyyMsbRS4oOoyrPAWa3+JdCtsgE2B-rKFg@mail.gmail.com>

--------------JwNEylsaxFbj0jPWJDgWjPHj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/26/21 1:18 AM, Eric Sunshine wrote:
> On Mon, Oct 25, 2021 at 9:36 PM Eli Schwartz <eschwartz@archlinux.org> =
wrote:
>> It contains option arguments only, not options. We would like to add
>> option support here too, but to do that we need to distinguish between=

>> different types of options.
>>
>> Lay out the groundwork for distinguishing between bools, strings, etc.=

>> and move the central logic (validating values and pushing new argument=
s
>> to *args) into the successful match, because that will be fairly
>> conditional on what type of argument is being parsed.
>>
>> Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
>> ---
>> diff --git a/pretty.c b/pretty.c
>> @@ -1216,28 +1216,37 @@ int format_set_trailers_options(struct process=
_trailer_options *opts,
>>  static size_t parse_describe_args(const char *start, struct strvec *a=
rgs)
>>  {
>> +       struct {
>> +               char *name;
>> +               enum { OPT_STRING } type;
>> +       }  option[] =3D {
>> +               { "exclude", OPT_STRING },
>> +               { "match", OPT_STRING },
>> +       };
>>         const char *arg =3D start;
>>
>>         for (;;) {
>> +               int found =3D 0;
>>                 const char *argval;
>>                 size_t arglen =3D 0;
>>                 int i;
>>
>> +               for (i =3D 0; !found && i < ARRAY_SIZE(option); i++) {=

>> +                       switch(option[i].type) {
>> +                       case OPT_STRING:
>> +                               if (match_placeholder_arg_value(arg, o=
ption[i].name, &arg,
>> +                                                               &argva=
l, &arglen) && arglen) {
>> +                                       if (!arglen)
>> +                                               return 0;
>=20
> I may be missing something obvious, but how will it be possible for:
>=20
>     if (!arglen)
>         return 0;
>=20
> to trigger if the `if` immediately above it:
>=20
>     if (... && arglen) {
>=20
>  has already asserted that `arglen` is not 0?


I don't think you are missing anything here, I simply forgot that
halfway through I added a second check to the if, and later moved the
code from down below.

I think returning 0 is correct here, to avoid pointlessly checking the
rest of option[]. So I'll (re-)remove the first check.


>> +                                       strvec_pushf(args, "--%s=3D%.*=
s", option[i].name, (int)arglen, argval);
>> +                                       found =3D 1;
>> +                               }
>>                                 break;
>>                         }
>>                 }
>> +               if (!found)
>>                         break;
>=20
> The use of `found` to break out of a loop from within a `switch` seems
> a bit clunky. An alternative would be to `goto` a label...
>=20
>>         }
>>         return arg - start;
>=20
> ... which could be introduced just before the `return`. Of course,
> this is highly subjective, so not necessarily worth changing.


Keeping in mind that this for (;;) { .... break; } was there before me
:D I just switched the name/type of the variable it checks...

IMO changing to goto is not my business to change (at least not in this
patch), and given the "common wisdom" is "goto is evil" I'm not strongly
inclined to get into the business of rewriting someone else's code for
that. It's too subjective for my taste.

--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User

--------------JwNEylsaxFbj0jPWJDgWjPHj--

--------------Z5ryNvhHo2noYwOW95IdLeLe
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmF4X6gACgkQzrFn77Vy
K9ab7xAAlLD4GRCR0/0vpA5psvhb2u9y57Gpu1G9ppH3DlnBbb2OzSinSE/Ix3ej
2hnQrVoa8X4sBZNIgdbWXvg3FV5KNQB6/QGYr8689I6Te8ZqiTWMZxXRjltIwyd7
6l/10JeK7UHWNerZ0j6A68QkHIAKJ++euLPxchSb9UDP15Ue6eCNdtHK4hvzkai2
FEnpxaHkHUqK8OoeccnVgDhTkjU7RewRNbNrmCoBjTBXIsimyDIRfwdG0p0VR2cQ
TlshUgfVcT5xo82Ecl+VF1zUaPCfKl9U5HhkMvP8ACbjQ2zFtyI5NA6PXEQDFiE8
JDC9u8dBJQwdQdG1E1H/oh3VF7PAQcr7I5IEU1T0U97qa1xS2FpmE7Aw1ZweQ8sz
JMdkuChlYT2LVdNeJzTcO5nrJmq502ko9oCt8hMNAlBCtyCdPRX7PwGhH13huqvD
KP7BICOZqO1i7e6i3Sp0Dsfoh5SbTw4pzcd/11rhzBMnB7VoZ+G5wsOPMWTYFMBD
miUr1hMrKxCQ+lmf0jgOI2BdQqKDTziCdTtNpR4NqwAiXrEx7tgwcDRWV4DVwQYA
/iR8tXU1+Scg6O1iXTCkLY+PYH2RmeLHm+Qakz+ETcfM3xEICuE6pU4GE5hDxf1C
qViUH5nGnFtCd+qfz9JmsQdecTc4pfpuhxxwlOJ516MRAxoNYGE=
=g77I
-----END PGP SIGNATURE-----

--------------Z5ryNvhHo2noYwOW95IdLeLe--
