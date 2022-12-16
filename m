Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFC0C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 19:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiLPT1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 14:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiLPT0w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 14:26:52 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15A4747D3
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 11:26:29 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so8477786ejc.4
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 11:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNG1IqleJizUkPichCl7WCXxRwg072di9dcwXJqxeuA=;
        b=fDJEQ1ue4CeTqffVpCw4ivsJi0BVUVknqLdcTjPtwMxiploTcd6bNUDON1ai6d2gOI
         4obE7nXd72BzTkSP1IW0c/O9uDgERK55W2oMOj9zw6X/IvXh5O8l/8qcVlD4LBsjG0rS
         O4oiK7Qt46b39g5/lrw2iBbWBGUSQ4cmeWQgsLAqcfUo5xUqhlm86nrkf/w2eRlMrUJ6
         428xeWtoOuUl2VLguIyZX29NGhz8sGZj5xcamWjhl7JlrJz4JMwn4pQJOPBpU3GufiV5
         D/Czwt5sABdnoEJwZOXOYw1j3zK7q4c2kEjXVxpz11/uWqc9G5t9xSifXI66kcawZC5z
         O5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YNG1IqleJizUkPichCl7WCXxRwg072di9dcwXJqxeuA=;
        b=ikAdh2oQj7Ymt5t55iU39N4F6ud6hluqpjB/I/c1Ky/NGaEmU8re5CdNvPYZ7iEAit
         vFgF2iZBZZRkz8gwQmpsxJNEE05FtZ+NdWWhrbZZkinwCE4VP2lz271iAiX5IRw6UC6x
         nGmLLDTHpxoOHInjmIXF2oT4pSKi/aYTJCX5AckHTH2aI8H/fNPpcMLl+h9yswQAkJvz
         dEpWa2fUdswBoaulFkgV+ZNZrefhlK329g76ApSa8N7yFiJ5DIbMyZEPylax00y9vkzQ
         FhGACUMgkeTsbEILGYjr2FLD12oKCOVlL/v2nBhFv3y5QKM7UORXAs4qKpjh+SGWqMlB
         PYeQ==
X-Gm-Message-State: ANoB5pl0SEJAWZdgI1BvVS5ZggLbo9LrSqV0mHEfAaHau1eqp/BPGFPG
        it698Q+17yfzYYBTgWu9YoiUSjtgdyPmBBNK
X-Google-Smtp-Source: AA0mqf43Q3FXlAe4Chu3EfVU+EWtapKk6ZoNAsiwnNw6RNeSumoLC/QzSz54kMYpKVcmdzOOpubiFg==
X-Received: by 2002:a17:906:7c83:b0:7c0:f325:637b with SMTP id w3-20020a1709067c8300b007c0f325637bmr44953030ejo.62.1671218788356;
        Fri, 16 Dec 2022 11:26:28 -0800 (PST)
Received: from ?IPV6:2003:f6:af03:4f00:a9d0:3f87:5d04:1b4f? (p200300f6af034f00a9d03f875d041b4f.dip0.t-ipconnect.de. [2003:f6:af03:4f00:a9d0:3f87:5d04:1b4f])
        by smtp.gmail.com with ESMTPSA id sb25-20020a170906edd900b007ad2da5668csm1161417ejb.112.2022.12.16.11.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 11:26:27 -0800 (PST)
Message-ID: <62a06c5b-9646-17f8-b4d5-39823d3cc25a@grsecurity.net>
Date:   Fri, 16 Dec 2022 20:26:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] grep: fall back to interpreter mode if JIT fails
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <221216.86o7s31fyt.gmgdl@evledraar.gmail.com>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <221216.86o7s31fyt.gmgdl@evledraar.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------V48xruVz5jzElwV7qK7BRq9V"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------V48xruVz5jzElwV7qK7BRq9V
Content-Type: multipart/mixed; boundary="------------8K90wthuEFnHKNo1nrf9skTz";
 protected-headers="v1"
From: Mathias Krause <minipli@grsecurity.net>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?=
 <carenas@gmail.com>
Message-ID: <62a06c5b-9646-17f8-b4d5-39823d3cc25a@grsecurity.net>
Subject: Re: [PATCH] grep: fall back to interpreter mode if JIT fails
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <221216.86o7s31fyt.gmgdl@evledraar.gmail.com>
In-Reply-To: <221216.86o7s31fyt.gmgdl@evledraar.gmail.com>

--------------8K90wthuEFnHKNo1nrf9skTz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 16.12.22 um 17:12 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>=20
> On Fri, Dec 16 2022, Mathias Krause wrote:
>=20
>> From: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
>>
>> Under Linux systems with SELinux's 'deny_execmem' or PaX's MPROTECT
>> enabled, the allocation of PCRE2's JIT rwx memory may be prohibited,
>> making pcre2_jit_compile() fail with PCRE2_ERROR_NOMEMORY (-48):
>>
>>   [user@fedora git]$ git grep -c PCRE2_JIT
>>   grep.c:1
>>
>>   [user@fedora git]$ # Enable SELinux's W^X policy
>>   [user@fedora git]$ sudo semanage boolean -m -1 deny_execmem
>>
>>   [user@fedora git]$ # JIT memory allocation fails, breaking 'git grep=
'
>>   [user@fedora git]$ git grep -c PCRE2_JIT
>>   fatal: Couldn't JIT the PCRE2 pattern 'PCRE2_JIT', got '-48'
>>
>> Instead of failing hard in this case and making 'git grep' unusable on=

>> such systems, simply fall back to interpreter mode, leading to a much
>> better user experience.
>>
>> Such a change was already proposed 4 years ago [1] but wasn't merged f=
or
>> unknown reasons.
>=20
> Yeah, it's unfortunate that it fell between the cracks, and it's good t=
o
> have such a fallback mechanism.

I fully agree, obviously!

>> 1. https://lore.kernel.org/r/20181209230024.43444-3-carenas@gmail.com
>>
>> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
>> Signed-off-by: Mathias Krause <minipli@grsecurity.net>	# tweaked chang=
elog, added comment
>> ---
>>  grep.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/grep.c b/grep.c
>> index 06eed694936c..f2ada528b21d 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -317,8 +317,21 @@ static void compile_pcre2_pattern(struct grep_pat=
 *p, const struct grep_opt *opt
>>  	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
>>  	if (p->pcre2_jit_on) {
>>  		jitret =3D pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);=

>> -		if (jitret)
>> -			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern,=
 jitret);
>> +		if (jitret) {
>> +			/*
>> +			 * Even though pcre2_config(PCRE2_CONFIG_JIT, ...)
>> +			 * indicated JIT support, the library might still
>> +			 * fail to generate JIT code for various reasons,
>> +			 * e.g. when SELinux's 'deny_execmem' or PaX's
>> +			 * MPROTECT prevent creating W|X memory mappings.
>> +			 *
>> +			 * Instead of faling hard, fall back to interpreter
>> +			 * mode, just as if the pattern was prefixed with
>> +			 * '(*NO_JIT)'.
>> +			 */
>> +			p->pcre2_jit_on =3D 0;
>> +			return;
>=20
> From my reading of the docs it returns two different codes:
> PCRE2_ERROR_JIT_BADOPTION or PCRE2_ERROR_NOMEMORY.
>=20
> This change will start treating both the same, but we only want to allo=
w
> the latter, surely?
>=20
> So shouldn't this be e.g.:
>=20
> 	jitret =3D pcre2_jit_compile(...);
> 	if (jitret =3D=3D PCRE2_ERROR_NOMEMORY) {
> 		/* code you added here */
> 	} else if (jitret) {
> 		BUG(...);
> 	}

I'm fine with it either way. In fact, just testing for the "JIT memory
cannot be allocated" error might be more on point and could detect wrong
API usage by the means of an error. However, from a user's point of view
a fall back to interpreter mode might still be desired in this case, as
a failing 'git grep' is simply not acceptable, IMHO.

> I put a BUG() there, we could keep the die(), but
> PCRE2_ERROR_JIT_BADOPTION is really more appropriate as a BUG(), and if=

> it starts returning any other codes our use of the API is also in some
> unknown state, so we should also BUG() out.

Valid points. I'll give others some more time to churn in and if there
are no strong objections, I'll change it like you suggest.

Thanks,
Mathias

--------------8K90wthuEFnHKNo1nrf9skTz--

--------------V48xruVz5jzElwV7qK7BRq9V
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEEd7J359B9wKgGsB94J4hPxYYBGYYFAmOcxmIFAwAAAAAACgkQJ4hPxYYBGYYh
hgv+O/J1CY6vZjlA5ngdCbypere3gTSUAdk8zItaUBWicG1hcV577EOaYrr5iOuCMfjGqV+pAZzG
lwWZUw7YJn4Tp7X95MTJCdg2sQaeHONsGvdZJr9KOst5vSs6dm0PdvxPXq0GiZx2pQ0mvB8iRxW/
nPKYsdDUO6C10H50slUhA1oE8L1O9P+B5t3sBx6UXjZAZn285855lEAfa50z6iMkIFFIdyzlddWH
wxn3REUXl9GNlsRbTUVfCOW7vmV/7/vKEs+oBrzBXC8j3kSKamfx2rRm/UJDWznnghxqsRvhcKM+
SN8ohHIHhoVtIymiAnMC5Hw7xwn4hJX2PeYZ5YjnbpyZsyxokUuRhIKjyJ00FLLyNe+wudbL/wpa
XOiOceCKebvvwrRbmw1l+Oh33LpOGOjgGyWSZoq5jFLXouDoFz/dAzJEUhrgJyCIrfHx1CFUy5uJ
ZlSSGXiyi4H0lMLHZ0eoFz8jAbtjaAyo/B2SR2MET2q+khgU13v/6j93ML9b
=mw1s
-----END PGP SIGNATURE-----

--------------V48xruVz5jzElwV7qK7BRq9V--
