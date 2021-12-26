Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CBBC433F5
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 23:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhLZXCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 18:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbhLZXB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 18:01:59 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC54C06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 15:01:59 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id l5so20634168edj.13
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 15:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=cgRcmWPy7dpe8OaEyqhBZ2jAtTOLhX/uBf707zNRUxk=;
        b=ix1icUZ1saKmMGe7cPEJhr6Enx9n20PGbv6hos8dz5woUT0t8kJQX0x8bzVce6lc4Z
         T0CifXSRu/SWD2Xqjkanj0lIT/HblKhqoLRphKMk8YwP/IZRCp6tfFdmPPUV4X+xRTn6
         RhDq3dGwODDKm0d1bwKMmWqva1UEre45rFOdY5ZElGIa/fgdvQKwnJGzTmFu2M8OD7L5
         JJsB1Py6ypsnWaNmf3iDpQ6x/w+Etn8OeG8GuVx5+YuOut7OeVJ8NMBPchPH5cVRa0LH
         zJrq54PbWGYjxrfglxGRVhSYUUoW/U4om+vDp7a53+x1PyitldvdCzsfQsHfgG1DzrIo
         1QJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=cgRcmWPy7dpe8OaEyqhBZ2jAtTOLhX/uBf707zNRUxk=;
        b=qZsAEE8OU6tx7ANhF09C54UP+VsCjb9ueIXAds7UDBlzMoC3CMU0X3XeCItB9RFJQl
         HQy4/gU8EiaHr/RFbEaTXPOcs7ry7V7jK/NFzVCqTAosNIkoCbK/4sZXx6NC0XAaCd5j
         0tBnw/c1OlMs3qOFbLgG+m3WVQ4KsipfpGPiuxiUzVBDbNSbdfk/ZJD8zs7AbCE3aNDt
         IZ4bq8A4sMAqU7JiuX9UClFFMX5FwQJO0mEnj/04jpxPHDmCCq68E3CKPUAGE9geLSx2
         wanyawRItJbT+dYgHU4nggtaVb3c1WHSIHPJ9oxCN36jrHvxXVzZenoIPS47ZnpQ19Km
         rDwQ==
X-Gm-Message-State: AOAM531Y6nGCGCREkFcTaEtnhxB6SBlCsaUCJ73qKZqy7WyCWrAU1UO9
        B9tR3i6JWR1N5FVjttdIheI=
X-Google-Smtp-Source: ABdhPJwlWhVrnhC6HQ9hpcOwS40JVPcwhEPOiSRXKKpzN60kM53LqWQ4/82i6Ev9o1eSF+//+YERuQ==
X-Received: by 2002:a17:906:af19:: with SMTP id lx25mr11992797ejb.338.1640559717563;
        Sun, 26 Dec 2021 15:01:57 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id y22sm2933122eda.49.2021.12.26.15.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 15:01:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n1cWa-000H37-Dj;
        Mon, 27 Dec 2021 00:01:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: t7510-signed-commit.sh hangs on old gpg, regression in
 1bfb57f642d (was: [PATCH v8 9/9] ssh signing: test that gpg fails for
 unknown keys)
Date:   Sun, 26 Dec 2021 23:53:47 +0100
References: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
 <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
 <07afb94ed8336d4ca9de7078d7a6c02b1db8a908.1631304462.git.gitgitgadget@gmail.com>
 <211222.86ilvhpbl0.gmgdl@evledraar.gmail.com>
 <20211222101326.fwl3wphr3ev6c7wt@fs>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211222101326.fwl3wphr3ev6c7wt@fs>
Message-ID: <211227.86h7avezrv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 22 2021, Fabian Stelzer wrote:

> On 22.12.2021 04:18, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>>On Fri, Sep 10 2021, Fabian Stelzer via GitGitGadget wrote:
>>
>>> From: Fabian Stelzer <fs@gigacodes.de>
>>>
>>> Test that verify-commit/tag will fail when a gpg key is completely
>>> unknown. To do this we have to generate a key, use it for a signature
>>> and delete it from our keyring aferwards completely.
>>>
>>> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
>>> +
>>> +	cat >keydetails <<-\EOF &&
>>> +	Key-Type: RSA
>>> +	Key-Length: 2048
>>> +	Subkey-Type: RSA
>>> +	Subkey-Length: 2048
>>> +	Name-Real: Unknown User
>>> +	Name-Email: unknown@git.com
>>> +	Expire-Date: 0
>>> +	%no-ask-passphrase
>>> +	%no-protection
>>> +	EOF
>>> +	gpg --batch --gen-key keydetails &&
>>>
>>The t7510-signed-commit.sh script hangs on startup with this change, and
>>with -vx we show:
>>
>>    [...]
>>    ++ git tag twelfth-signed-alt 17f06d503ee50df92746c17f6cced6feb5940cf5
>>    ++ cat
>>    ++ gpg --batch --gen-key keydetails
>>    gpg: skipping control `%no-protection' ()
>>
>>This is on a CentOS 7.9 box on the GCC Farm:
>>
>>    [avar@gcc135 t]$ uname -a ; gpg --version
>>    Linux gcc135.osuosl.org 4.18.0-80.7.2.el7.ppc64le #1 SMP Thu Sep 12 1=
5:45:05 UTC 2019 ppc64le ppc64le ppc64le GNU/Linux
>>    gpg (GnuPG) 2.0.22
>>    libgcrypt 1.5.3
>>    Copyright (C) 2013 Free Software Foundation, Inc.
>>    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/g=
pl.html>
>>    This is free software: you are free to change and redistribute it.
>>    There is NO WARRANTY, to the extent permitted by law.
>>
>>    Home: ~/.gnupg
>>    Supported algorithms:
>>    Pubkey: RSA, ?, ?, ELG, DSA
>>    Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
>>            CAMELLIA128, CAMELLIA192, CAMELLIA256
>>    Hash: MD5, SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
>>    Compression: Uncompressed, ZIP, ZLIB, BZIP2
>
> Hm. I have an identical centos 7.9 installation (same
> versions/features) and the key is generated without issues. Does the
> VM maybe have not enough entropy for generating a gpg key?
> Otherwise we could of course pre-generate the key and commit it. I'm
> usually not a fan of this since over time it can become unclear how it
> was generated or if the committed version still matches what would be
> generated today.
> But of course I don't want to slow down CI with rsa key generation stuff =
:/
> If missing entropy is the problem, then maybe CI could benefit from
> something like haveged in general (other tests might want more entropy
> too).

Late reply. It's not a VM, but yes. I've confirmed that it's due to
/dev/random hanging.

I don't understand why we need to generate a key at all.

It looks like your 1bfb57f642d (ssh signing: test that gpg fails for
unknown keys, 2021-09-10) is just trying to test the case where we sign
with a key, and then don't have that key anymore.

The below POC patch seems to work just as well, and will succeed with:

    ./t7510-signed-commit.sh --run=3D1,3

Of course a lot of other tests now fail, because they relied on the
discord@example.net key.

But that seems easily solved by just moving this test to its own file,
or deleting/re-importing the key for just that test or whatever. If we
truly need yet another key why are we making it on the fly instead of
adding it to t/lib-gpg/keyring.gpg like the others?

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 9882b69ae29..eec2a045cbc 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -73,23 +73,11 @@ test_expect_success GPG 'create signed commits' '
 	test_line_count =3D 1 oid &&
 	git tag twelfth-signed-alt $(cat oid) &&
=20
-	cat >keydetails <<-\EOF &&
-	Key-Type: RSA
-	Key-Length: 2048
-	Subkey-Type: RSA
-	Subkey-Length: 2048
-	Name-Real: Unknown User
-	Name-Email: unknown@git.com
-	Expire-Date: 0
-	%no-ask-passphrase
-	%no-protection
-	EOF
-	gpg --batch --gen-key keydetails &&
-	echo 13 >file && git commit -a -S"unknown@git.com" -m thirteenth &&
+	echo 13 >file && git commit -a -S"discord@example.net" -m thirteenth &&
 	git tag thirteenth-signed &&
-	DELETE_FINGERPRINT=3D$(gpg -K --with-colons --fingerprint --batch unknown=
@git.com | grep "^fpr" | head -n 1 | awk -F ":" "{print \$10;}") &&
+	DELETE_FINGERPRINT=3D$(gpg -K --with-colons --fingerprint --batch discord=
@example.net | grep "^fpr" | head -n 1 | awk -F ":" "{print \$10;}") &&
 	gpg --batch --yes --delete-secret-keys $DELETE_FINGERPRINT &&
-	gpg --batch --yes --delete-keys unknown@git.com
+	gpg --batch --yes --delete-keys discord@example.net
 '
=20
 test_expect_success GPG 'verify and show signatures' '
