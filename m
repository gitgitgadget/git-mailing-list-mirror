Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE41C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 17:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244041AbiAKRAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 12:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244002AbiAKRAr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 12:00:47 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346D1C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 09:00:47 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z22so24732182edd.12
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 09:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=aTcIAFnGD/8P3bxzourHHwcdbuEg/j7SmiyC8XR/MdY=;
        b=IvebmHtkjGDV1IdCO8gUT96qkMfiC2JSNc9aCmRhKyOffTsEcf1va8kwJcA8t9FyIe
         gvGof36+cfjy+QMYU4xsfPzOiBPPfY/lXloJjxluhnoH5EcRY7L8CaJsxMNro6bvYOEZ
         c0PSa9q+ZLYmc7J+/2a/jxIkS1aLhNUN92zNBrv/K9GzNU9Gqxay57ElNczEsmctx8RQ
         G9musva9nGOIWSL61O3rrvENo6CrI9Ckh4vcGzKjZNr32wMiAPNOUT672UNkelsxnLwa
         G3glESMQYZNuogCl+5u+Kp0jMSTFvmXRJJNaKkGMSZ0d/QxQ5TWIB7cVWbp/ftX4Cmme
         apOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=aTcIAFnGD/8P3bxzourHHwcdbuEg/j7SmiyC8XR/MdY=;
        b=V4KQQJzCo60ArrIQ7xiebRWdRDJ9MBquooMpNwRTDwHrtVHHpGnOZPnoqnKAH1VOAn
         4Xy4+dS4ScpEker5NnBoX/ieu1y4FLFgbxrqpKLqTWG/HpviTPJ3Gf6+jTz9H5s+aooA
         9AeaznGU8gpa0qWQjuQYkuLWUVSHkVVmK5rt74NTMW8aEmF+lh2fkQAPgC3Cs/l9L8vp
         NFFOZhkZmtkzBaO3hWB4VaY1atMKdYoINeUndni2ujSIQ6Nzz1sbptxhvod6xVuesXgP
         p7KL011YOZeXiXarmP8y73uzeHXA2otUxpOPh7qHVBNqH1y81r31qjGzbYI+gdvNcM4/
         VflA==
X-Gm-Message-State: AOAM531QNMLzXrN4BalfhP5L0NQLfvXq4Igt4lUasdfoyAm1rS8cvdXy
        +CVP6k6tsCDjhMza6zRvJmk=
X-Google-Smtp-Source: ABdhPJxfSnXhYHwv8DLQ7YSgBmxgNhTgKm1w5kwgr9X7hj4BOOjItOt1uOf4yr1dGERhXpMpzLBeYQ==
X-Received: by 2002:a05:6402:50c6:: with SMTP id h6mr5293952edb.156.1641920445673;
        Tue, 11 Jan 2022 09:00:45 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g9sm3727035ejo.222.2022.01.11.09.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:00:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7KVo-000fyG-B1;
        Tue, 11 Jan 2022 18:00:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] t/gpg: simplify test for unknown key
Date:   Tue, 11 Jan 2022 17:56:50 +0100
References: <20220107091432.581225-1-fs@gigacodes.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220107091432.581225-1-fs@gigacodes.de>
Message-ID: <220111.86r19exl4z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 07 2022, Fabian Stelzer wrote:

> To test for a key that is completely unknown to the keyring we need one
> to sign the commit with. This was done by generating a new key and not
> add it into the keyring. To avoid the key generation overhead and
> problems where GPG did hang in CI during it, switch GNUPGHOME to an
> empty directory instead, therefore making all used keys unknown for this
> single `verify-commit` call.
>
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
> This was reported by =C3=86var in <211222.86ilvhpbl0.gmgdl@evledraar.gmai=
l.com>.
> Just using an empty keyring / gpg homedir should achieve the same effect =
and=20
> keeps the stress of generating a gpg key out of the CI.

Thanks, it would be great to have this in and before v2.35.0. I've run
into several boxes (on the GCC farm) that hang without this patch.

>  t/t7510-signed-commit.sh | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
>
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 9882b69ae2..2d38580847 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -71,25 +71,7 @@ test_expect_success GPG 'create signed commits' '
>  	git tag eleventh-signed $(cat oid) &&
>  	echo 12 | git commit-tree --gpg-sign=3DB7227189 HEAD^{tree} >oid &&
>  	test_line_count =3D 1 oid &&
> -	git tag twelfth-signed-alt $(cat oid) &&
> -
> -	cat >keydetails <<-\EOF &&
> -	Key-Type: RSA
> -	Key-Length: 2048
> -	Subkey-Type: RSA
> -	Subkey-Length: 2048
> -	Name-Real: Unknown User
> -	Name-Email: unknown@git.com
> -	Expire-Date: 0
> -	%no-ask-passphrase
> -	%no-protection
> -	EOF
> -	gpg --batch --gen-key keydetails &&
> -	echo 13 >file && git commit -a -S"unknown@git.com" -m thirteenth &&
> -	git tag thirteenth-signed &&
> -	DELETE_FINGERPRINT=3D$(gpg -K --with-colons --fingerprint --batch unkno=
wn@git.com | grep "^fpr" | head -n 1 | awk -F ":" "{print \$10;}") &&
> -	gpg --batch --yes --delete-secret-keys $DELETE_FINGERPRINT &&
> -	gpg --batch --yes --delete-keys unknown@git.com
> +	git tag twelfth-signed-alt $(cat oid)
>  '
>=20=20
>  test_expect_success GPG 'verify and show signatures' '
> @@ -129,7 +111,7 @@ test_expect_success GPG 'verify and show signatures' '
>  '
>=20=20
>  test_expect_success GPG 'verify-commit exits failure on unknown signatur=
e' '
> -	test_must_fail git verify-commit thirteenth-signed 2>actual &&
> +	GNUPGHOME=3D./empty_home test_must_fail git verify-commit initial 2>act=
ual &&

Before I noticed this thread (I looked at
https://lore.kernel.org/git/20211230111038.jtoqytdhkilv2732@fs/ first,
and the In-Reply-To chain wasn't connected) I was about to submit
exactly this patch for you but with:

	-       test_must_fail git verify-commit thirteenth-signed 2>actual &&
	+       test_must_fail env GNUPGHOME=3D"$GNUPGHOME_NOT_USED" git verify-co=
mmit initial 2>actual &&

Both of those are probably a good thing to do here. I.e.:

 1. Didn't we have portability issues with "ENV_VAR=3DVALUE shell_function =
..." ?
 2. You're pointing to a nonexisting ./empty_home, but shouldn't we use
    $GNUPGHOME_NOT_USED? The existing "show unknown signature with custom f=
ormat"
    test in the same file does that.
