Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD1DC433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 07:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C17D6112E
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 07:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbhIPIAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 04:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbhIPIAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 04:00:16 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4041BC061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 00:58:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id q3so13487133edt.5
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 00:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=f1B06VysxIA8getSSIYcK1LLXzDJq/+izLv35eQSxi0=;
        b=BnchpZoGmBgQONBVXbd/Ewss2B04mernd5Awgreoh3kZInDj1JUBwecR/GmT3uiIOn
         eLMvY2v9amLrZy0P11idwVIs+Qd/8P6DljZfdv/lT4rAeWb4cf+n4RdnzNWd8+LaZHqN
         ms/JsteWeOqdbWmbUeXufvUJXUr2pmM+FtSiVVFKJndIikhbx7aVqjZZDSxM3iem+FRZ
         +ih6tpen10hPD2Bnr66OoorxJPCeTY4N+c41+FOC1Ke1BIGM3NSLKxX26oKoqR+om3+d
         1H6EC63+9eNhpRO4irwgYiaL6WmM0A2KP5E17KYjwGx+tvEEZ/qqnNkyyvVFQQwxNf/N
         kV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=f1B06VysxIA8getSSIYcK1LLXzDJq/+izLv35eQSxi0=;
        b=dDpm07BgD7TdPUC+FIxC2bidWCUUzFqp58JscrE/mXmeJZy0c/kGB5n2rJWWBsNNGf
         nmPwwyDe7FdLqgKkDpvQjYUGxu+jYuFL0ATNdHXlmbfFwIKeDd4EE3/ZurVyV3FF4hls
         2uOnkhiUJzzFd4h9xHblPy0AibJTKSQQ2SdsgmP4A4LeGYB3iuQwI1PZWCthiua5P1Xp
         jVCKvz6StWu7OKG7S/yAxeLjfdYmL8z1l/cYEE7+NmBa/PshySrjZe/GZC4oiI8JiKux
         2vjEdvywqr9qJFEnmApwg9nCExAyZRTqEhKdOfMVfuxGSA5/rtT8ZM+aF1SpHKB7aMv9
         WYkQ==
X-Gm-Message-State: AOAM531oSx3S5HHAUI4YBLt16K0dxk/5fHrfZF1TXNJBgRPUjrmPgzJQ
        0od8e2Qz8nHu80PSl5mQc3iLXkXzNLU=
X-Google-Smtp-Source: ABdhPJxW9fdMv9et76bMkkoas/7OGXaRY6ate4IJOVPJ912V+5LCkhTvku/i3WNNZQmwbdjD92NUjQ==
X-Received: by 2002:a17:906:48e:: with SMTP id f14mr1733616eja.433.1631779134607;
        Thu, 16 Sep 2021 00:58:54 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k8sm1002702edx.62.2021.09.16.00.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 00:58:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fixup! tests: add a test mode for SANITIZE=leak, run it
 in CI
Date:   Thu, 16 Sep 2021 08:14:25 +0200
References: <patch-v5-3.3-f3cd04b16d1-20210907T212626Z-avarab@gmail.com>
 <20210916035603.76369-1-carenas@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210916035603.76369-1-carenas@gmail.com>
Message-ID: <87mtodgddu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 15 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> Use the standard gcc in Linux, instead of the older version
>
> Remove the osx-leaks job; neither clang or gcc support it and won't
> until clang 14 is released.

Thanks, that's well spotted. I'll fix this in a re-roll. I just tested
and the osx job does nothing.

FWIW I'd tested and it errored on clang, but didn't check the gcc case
of silently ignoring it.

> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  .github/workflows/main.yml | 3 ---
>  ci/install-dependencies.sh | 4 ++--
>  ci/lib.sh                  | 8 ++++----
>  3 files changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 7c273147a0..59acc35d37 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -234,9 +234,6 @@ jobs:
>            - jobname: linux-leaks
>              cc: gcc
>              pool: ubuntu-latest
> -          - jobname: osx-leaks
> -            cc: gcc
> -            pool: macos-latest
>      env:
>        CC: ${{matrix.vector.cc}}
>        jobname: ${{matrix.vector.jobname}}
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index bb88afd369..1d0e48f451 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -18,7 +18,7 @@ linux-clang|linux-gcc|linux-leaks)
>  	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
>  		$UBUNTU_COMMON_PKGS
>  	case "$jobname" in
> -	linux-gcc|linux-leaks)
> +	linux-gcc)
>  		sudo apt-get -q -y install gcc-8
>  		;;
>  	esac


> @@ -37,7 +37,7 @@ linux-clang|linux-gcc|linux-leaks)
>  		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
>  	popd
>  	;;
> -osx-clang|osx-gcc|osx-leaks)
> +osx-clang|osx-gcc)
>  	export HOMEBREW_NO_AUTO_UPDATE=3D1 HOMEBREW_NO_INSTALL_CLEANUP=3D1
>  	# Uncomment this if you want to run perf tests:
>  	# brew install gnu-time
> diff --git a/ci/lib.sh b/ci/lib.sh
> index cf62f786a3..36f594751d 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -185,7 +185,7 @@ export SKIP_DASHED_BUILT_INS=3DYesPlease
>  case "$jobname" in
>  linux-clang|linux-gcc|linux-leaks)
>  	case "$jobname" in
> -	linux-gcc|linux-leaks)
> +	linux-gcc)
>  		export CC=3Dgcc-8
>  		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D/usr/bin/python3"
>  		;;
> @@ -208,9 +208,9 @@ linux-clang|linux-gcc|linux-leaks)
>  	GIT_LFS_PATH=3D"$HOME/custom/git-lfs"
>  	export PATH=3D"$GIT_LFS_PATH:$P4_PATH:$PATH"
>  	;;
> -osx-clang|osx-gcc|osx-leaks)
> +osx-clang|osx-gcc)
>  	case "$jobname" in
> -	osx-gcc|osx-leaks)
> +	osx-gcc)
>  		export CC=3Dgcc-9
>  		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python3)"
>  		;;
> @@ -239,7 +239,7 @@ linux-musl)
>  esac
>=20=20
>  case "$jobname" in
> -linux-leaks|osx-leaks)
> +*-leaks)
>  	export SANITIZE=3Dleak
>  	export GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue
>  	;;

I'll leave this stray cleanup out, yes it's functionally equivalent, but
it really helps to be able to see an identifier in main.yml and grep for
it across the untyped-language boundary of that YAML going into
shellscript.
