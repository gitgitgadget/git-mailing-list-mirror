Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58369C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 03:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbhLVDXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 22:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbhLVDXK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 22:23:10 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E4EC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:23:10 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w16so2861275edc.11
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=G8ZXg4eG7pBoKunpK43T6jTlCs3RduaVKNPitFzRtMY=;
        b=gcrGuv4H/Lx2I7QX1ViYGRZKENIVegvhqXaB/aByHPaXhtHl9IrdrryRJ0AS9jjqnS
         MqZObTs5wmXjfQ+/H/2NUdhBS5vV6ROvJymMUtQYnCtijkGKxmIKtTlT0yLNCYt/ivuz
         qP4UQO8xFxRzs1OIYPyFY8Io0bMSx1Azf/tFjw9kwslP7oXiPLcY3QPI5bqGNpsG810q
         rIbMqARelUm4QUvgTOioczSTDHudDNBzJ/qQoDvE824OsNA43fy+XZB6kj0KD7JA79Bw
         5z+/HGN/NdsDeWEoI/YQLaOa14qw8VhtkN6NuatzyCc80Mhf9uqTWqgs9vXJWCbFB7Up
         AKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=G8ZXg4eG7pBoKunpK43T6jTlCs3RduaVKNPitFzRtMY=;
        b=l2rsX4dKe7oFjuogwcix0dY4rbF1YuJVbzVTsAR4zEynFoFkEZ9jtnI2RnvUrVpCwn
         wt/+K3IFoZ8uuHABePEw7qNiV18akH7nRUr6XeEbVXbqe74mlo/qLL1nQuYpNOL5mS1C
         YjeeNJD1UXDf1Qdnec1vOTdo3ybObGyYJaOp+B4afS2alIF7mRn225hcjRsaLGa/WN6s
         +SEvH0Mgbykx4+BB2WEyJ7czM6iuVTzRaeFws2btlyjOUouRvqA+IxSeHmhPuFMRhcGG
         uSIHuMgt6yeUN14o90jX+ZzMXitDQ3YqawjuaUdMcU8pND+8xcJh6riRDSIEuqJtLf04
         i3xg==
X-Gm-Message-State: AOAM532Ii+QplJtppXKIdncNTnh2ypI/0p2kIfErKuKnzE+3DX8xpaPN
        +GSANd9AROUsW/CxHe/zCom9nxgyRGka/Q==
X-Google-Smtp-Source: ABdhPJzzARcOERKkG5pyu9jaxUrfh7AZ573Vm9m3D0YYFc5VfqWP7p4y3/fosfZxA/6M9PO89incZA==
X-Received: by 2002:a17:906:9512:: with SMTP id u18mr919156ejx.389.1640143388442;
        Tue, 21 Dec 2021 19:23:08 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sa42sm173495ejc.101.2021.12.21.19.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:23:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzsDb-0014Ul-BZ;
        Wed, 22 Dec 2021 04:23:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Fabian Stelzer <fabian@stelzer.cloud>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: t7510-signed-commit.sh hangs on old gpg, regression in 1bfb57f642d
 (was: [PATCH v8 9/9] ssh signing: test that gpg fails for unknown keys)
Date:   Wed, 22 Dec 2021 04:18:36 +0100
References: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
 <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
 <07afb94ed8336d4ca9de7078d7a6c02b1db8a908.1631304462.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <07afb94ed8336d4ca9de7078d7a6c02b1db8a908.1631304462.git.gitgitgadget@gmail.com>
Message-ID: <211222.86ilvhpbl0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Fabian Stelzer via GitGitGadget wrote:

> From: Fabian Stelzer <fs@gigacodes.de>
>
> Test that verify-commit/tag will fail when a gpg key is completely
> unknown. To do this we have to generate a key, use it for a signature
> and delete it from our keyring aferwards completely.
>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
>  t/t7510-signed-commit.sh | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 8df5a74f1db..d65a0171f29 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -71,7 +71,25 @@ test_expect_success GPG 'create signed commits' '
>  	git tag eleventh-signed $(cat oid) &&
>  	echo 12 | git commit-tree --gpg-sign=B7227189 HEAD^{tree} >oid &&
>  	test_line_count = 1 oid &&
> -	git tag twelfth-signed-alt $(cat oid)
> +	git tag twelfth-signed-alt $(cat oid) &&
> +
> +	cat >keydetails <<-\EOF &&
> +	Key-Type: RSA
> +	Key-Length: 2048
> +	Subkey-Type: RSA
> +	Subkey-Length: 2048
> +	Name-Real: Unknown User
> +	Name-Email: unknown@git.com
> +	Expire-Date: 0
> +	%no-ask-passphrase
> +	%no-protection
> +	EOF
> +	gpg --batch --gen-key keydetails &&
> +	echo 13 >file && git commit -a -S"unknown@git.com" -m thirteenth &&
> +	git tag thirteenth-signed &&
> +	DELETE_FINGERPRINT=$(gpg -K --with-colons --fingerprint --batch unknown@git.com | grep "^fpr" | head -n 1 | awk -F ":" "{print \$10;}") &&
> +	gpg --batch --yes --delete-secret-keys $DELETE_FINGERPRINT &&
> +	gpg --batch --yes --delete-keys unknown@git.com
>  '
>  
>  test_expect_success GPG 'verify and show signatures' '
> @@ -110,6 +128,13 @@ test_expect_success GPG 'verify and show signatures' '
>  	)
>  '
>  
> +test_expect_success GPG 'verify-commit exits failure on unknown signature' '
> +	test_must_fail git verify-commit thirteenth-signed 2>actual &&
> +	! grep "Good signature from" actual &&
> +	! grep "BAD signature from" actual &&
> +	grep -q -F -e "No public key" -e "public key not found" actual
> +'
> +
>  test_expect_success GPG 'verify-commit exits success on untrusted signature' '
>  	git verify-commit eighth-signed-alt 2>actual &&
>  	grep "Good signature from" actual &&
> @@ -338,6 +363,8 @@ test_expect_success GPG 'show double signature with custom format' '
>  '
>  
>  
> +# NEEDSWORK: This test relies on the test_tick commit/author dates from the first
> +# 'create signed commits' test even though it creates its own
>  test_expect_success GPG 'verify-commit verifies multiply signed commits' '
>  	git init multiply-signed &&
>  	cd multiply-signed &&

The t7510-signed-commit.sh script hangs on startup with this change, and
with -vx we show:
    
    [...]
    ++ git tag twelfth-signed-alt 17f06d503ee50df92746c17f6cced6feb5940cf5
    ++ cat
    ++ gpg --batch --gen-key keydetails
    gpg: skipping control `%no-protection' ()

This is on a CentOS 7.9 box on the GCC Farm:
    
    [avar@gcc135 t]$ uname -a ; gpg --version
    Linux gcc135.osuosl.org 4.18.0-80.7.2.el7.ppc64le #1 SMP Thu Sep 12 15:45:05 UTC 2019 ppc64le ppc64le ppc64le GNU/Linux
    gpg (GnuPG) 2.0.22
    libgcrypt 1.5.3
    Copyright (C) 2013 Free Software Foundation, Inc.
    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.
    
    Home: ~/.gnupg
    Supported algorithms:
    Pubkey: RSA, ?, ?, ELG, DSA
    Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
            CAMELLIA128, CAMELLIA192, CAMELLIA256
    Hash: MD5, SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
    Compression: Uncompressed, ZIP, ZLIB, BZIP2
