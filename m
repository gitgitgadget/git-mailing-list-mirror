Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B03C433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 16:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKXQqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 11:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKXQqA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 11:46:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA340E873C
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 08:45:57 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v1so3200040wrt.11
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 08:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jPyXv/IknSfdJ9mPTpxQCsz/bn5yTfpRBYNfeCgiY/4=;
        b=U84Rzp6KcKeqsJLq6ZdM6H/pR3hHeHrZSrjGqHKyDzsaMdu0PGRKopV4fiP9hjdNDD
         Ez1BbfS4iK3A8afgahqroAXXylPZoVE1Gm57L6AiWJQCLBljFqq07eyz81ync/1WJwqt
         qW26F+UWBPRMUeihrQAQz6PdjPX8h34hV5j2iyYLuTbB3nbsqojptU9OCqueL6+0xqDi
         KtkorBKFjiSlcRBtK7SmIwld+f1h74aqza9Di/x0Nehqq0HsoxoxO5Lipd3G5dkUxhF/
         haJ/XrJvmLjorDAIa/bjgwEzGN98iVPfbb4afVCpsKhUs8REmQR9g/YJfoh8DWFcg6cI
         UHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPyXv/IknSfdJ9mPTpxQCsz/bn5yTfpRBYNfeCgiY/4=;
        b=yDBzDBRcd0wZ9XjGbEk5KJTYC8XEl5dJJZHaBytDfs82tYxWuTCCKBSOGU10I4PAvX
         g/N0CP+iWn4GSrenyWqO2LEW2EreU9djGZkpC+TzVhcCCTeT6pgf2BDPDinlkue41pWv
         hGvhsu6zHXeUMt2ecJkUI53rkY2yh9Mkp6lDOAxcJrz+pEE7UV0D4I/00zfYRtxb8Vgc
         SUkmixRw7oNQhKRz6m6+JlOxccNu4Tf4nA8P9zXIJpvtT00TqbzFzZw8KeFKL8hHkh5v
         l70DZyvm9/l3k72kDFYGQzfkQnijVARA7EBkY6PDtCuF6wEOr0sxiVngUYSAirnsq+Vk
         MQXg==
X-Gm-Message-State: ANoB5pkS9XLmphJIsspcwgseKWWP/wQDfgb0WW2p/bLYF7UM7riAjbn+
        KCrf0Rms88ZHQqHn3DGiIr0=
X-Google-Smtp-Source: AA0mqf5gP5JtI6R2QTQK6hN/V3Htvkey1SlY0nMl7N+RqoJ+a4XMliJOFShojJicx4XkFAKurWgTfg==
X-Received: by 2002:a05:6000:103:b0:241:d028:78c5 with SMTP id o3-20020a056000010300b00241d02878c5mr9114844wrx.131.1669308356147;
        Thu, 24 Nov 2022 08:45:56 -0800 (PST)
Received: from gmgdl ([149.38.4.46])
        by smtp.gmail.com with ESMTPSA id g6-20020adffc86000000b00241c4bd6c09sm1805759wrr.33.2022.11.24.08.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 08:45:55 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oyFKC-000FOq-22;
        Thu, 24 Nov 2022 17:43:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3 1/4] github-actions: run gcc-8 on ubuntu-20.04 image
Date:   Thu, 24 Nov 2022 17:29:09 +0100
References: <20221124090545.4790-1-worldhello.net@gmail.com>
 <20221124153934.12470-2-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221124153934.12470-2-worldhello.net@gmail.com>
Message-ID: <221124.86sfi8nvzz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 24 2022, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> GitHub starts to upgrade its runner image "ubuntu-latest" from version
> "ubuntu-20.04" to version "ubuntu-22.04". It will fail to find and
> install "gcc-8" package on the new runner image.
>
> Change the runner images from "ubuntu-latest" to "ubuntu-20.04" in order
> to run with "gcc-8" as a dependency.
>
> Instead of use the environment "$runs_on_pool" as below:
>
>     case "$runs_on_pool" in
>     ubuntu-20.04 | ubuntu-latest)
> 	;;
>
> we can reuse the os field in the matrix, and use a new environment
> "$runs_on_os" as below:
>
>     case "$runs_on_os" in
>     ubuntu)
>         ;;
>
> In this way, we can change the "ubuntu-latest" runner image to any
> version such as "ubuntu-22.04" to test CI behavior in advance.
>
> Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  .github/workflows/main.yml | 16 ++++++++++++----
>  ci/install-dependencies.sh |  6 +++---
>  ci/lib.sh                  |  6 +++---
>  3 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 592f9193a8..da0d8ab0bf 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -224,6 +224,7 @@ jobs:
>          vector:
>            - jobname: linux-clang
>              cc: clang
> +            os: ubuntu
>              pool: ubuntu-latest
>            - jobname: linux-sha256
>              cc: clang
> @@ -232,36 +233,43 @@ jobs:
>            - jobname: linux-gcc
>              cc: gcc
>              cc_package: gcc-8
> -            pool: ubuntu-latest
> +            os: ubuntu
> +            pool: ubuntu-20.04
>            - jobname: linux-TEST-vars
>              cc: gcc
> -            os: ubuntu
>              cc_package: gcc-8
> -            pool: ubuntu-latest
> +            os: ubuntu
> +            pool: ubuntu-20.04
>            - jobname: osx-clang
>              cc: clang
> +            os: macos
>              pool: macos-latest
>            - jobname: osx-gcc
>              cc: gcc
>              cc_package: gcc-9
> +            os: macos
>              pool: macos-latest
>            - jobname: linux-gcc-default
>              cc: gcc
> +            os: ubuntu
>              pool: ubuntu-latest
>            - jobname: linux-leaks
>              cc: gcc
> +            os: ubuntu
>              pool: ubuntu-latest
>            - jobname: linux-asan
>              cc: gcc
> +            os: ubuntu
>              pool: ubuntu-latest
>            - jobname: linux-ubsan
>              cc: gcc
> +            os: ubuntu
>              pool: ubuntu-latest
>      env:
>        CC: ${{matrix.vector.cc}}
>        CC_PACKAGE: ${{matrix.vector.cc_package}}
>        jobname: ${{matrix.vector.jobname}}
> -      runs_on_pool: ${{matrix.vector.pool}}
> +      runs_on_os: ${{matrix.vector.os}}
>      runs-on: ${{matrix.vector.pool}}
>      steps:
>      - uses: actions/checkout@v2
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 107757a1fe..f639263a62 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -11,8 +11,8 @@ UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
>   tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
>   libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
>  
> -case "$runs_on_pool" in
> -ubuntu-latest)
> +case "$runs_on_os" in
> +ubuntu)
>  	sudo apt-get -q update
>  	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
>  		$UBUNTU_COMMON_PKGS $CC_PACKAGE
> @@ -30,7 +30,7 @@ ubuntu-latest)
>  		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
>  	popd
>  	;;
> -macos-latest)
> +macos)
>  	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
>  	# Uncomment this if you want to run perf tests:
>  	# brew install gnu-time
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 24d20a5d64..0c0767d354 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -225,8 +225,8 @@ export DEFAULT_TEST_TARGET=prove
>  export GIT_TEST_CLONE_2GB=true
>  export SKIP_DASHED_BUILT_INS=YesPlease
>  
> -case "$runs_on_pool" in
> -ubuntu-latest)
> +case "$runs_on_os" in
> +ubuntu)
>  	if test "$jobname" = "linux-gcc-default"
>  	then
>  		break
> @@ -253,7 +253,7 @@ ubuntu-latest)
>  	GIT_LFS_PATH="$HOME/custom/git-lfs"
>  	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
>  	;;
> -macos-latest)
> +macos)
>  	if [ "$jobname" = osx-gcc ]
>  	then
>  		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"

At the end of [1] I suggested splitting up the refactoring part of
this. I still think that would be a good thing to do, but just to
comment on the *actual* change (which I was hoping a split-out would
make clearer).

This is proposing to refactor
"runs-on-pool={ubuntu-latest,macos-latest}" to "os={ubuntu,macos}". I
think it's worth cleaning up how we match main.yml and ci/*.sh, but
think it's a bit of a digression in this otherwise narrowly focused
series.

Now, this seems to somewhat come back to being all my fault. AFAICT I
added "os" in c08bb260105 (CI: rename the "Linux32" job to lower-case
"linux32", 2021-11-23) as part of some WIP (or from an earlier version?)
that ende dup doing nothing.

But looking at it again, I don't see how an "os" here makes much
sense. For "macos-latest" if we're going to refactor it let's just stop
selecting stuff based on this "pool name", and instead fold it into the
adjacent "jobname" selection:
	
	diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
	index 107757a1fea..b5a373060c1 100755
	--- a/ci/install-dependencies.sh
	+++ b/ci/install-dependencies.sh
	@@ -30,7 +30,9 @@ ubuntu-latest)
	 		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
	 	popd
	 	;;
	-macos-latest)
	+esac
	+case "$jobname" in
	+osx-*)
	 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
	 	# Uncomment this if you want to run perf tests:
	 	# brew install gnu-time
	diff --git a/ci/lib.sh b/ci/lib.sh
	index 24d20a5d648..fef60a507e9 100755
	--- a/ci/lib.sh
	+++ b/ci/lib.sh
	@@ -253,19 +253,17 @@ ubuntu-latest)
	 	GIT_LFS_PATH="$HOME/custom/git-lfs"
	 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
	 	;;
	-macos-latest)
	-	if [ "$jobname" = osx-gcc ]
	-	then
	-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
	-	else
	-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
	-		MAKEFLAGS="$MAKEFLAGS NO_APPLE_COMMON_CRYPTO=NoThanks"
	-		MAKEFLAGS="$MAKEFLAGS NO_OPENSSL=NoThanks"
	-	fi
	-	;;
	 esac
	 
	 case "$jobname" in
	+osx-gcc)
	+	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
	+	;;
	+osx-clang)
	+	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
	+	MAKEFLAGS="$MAKEFLAGS NO_APPLE_COMMON_CRYPTO=NoThanks"
	+	MAKEFLAGS="$MAKEFLAGS NO_OPENSSL=NoThanks"
	+	;;
	 linux32)
	 	CC=gcc
	 	;;

That nicely sidesteps the need to refactor it here, and IMO makes it
more future-proof.

For the "ubuntu" case I think it's even worse, because it now *looks*
like a case that should be equivalent to just:

	test "$(lsb_release -si 2>&1 | grep -x Debian)" = "Debian"

But it's not, because we're not setting this "os=ubuntu" in all the
places where the OS is Ubuntu. It really just means "the stuff that used
to set env.runs_on_pool=ubuntu-latest, which e.g. doesn't cover the
"documentation" job, which runs on "ubuntu-latest".

So I think *if* we're going to refactor this while-at-it, let's not make
it "os=ubuntu", but e.g. "extra_ubuntu_packages: 1", which is really
what it means. I.e. we're intercepting it in ci/lib.sh to set the "p4"
variables etc., which we only need if we're doing the optional "apt
install" on the "ubuntu-latest".

1. https://lore.kernel.org/git/221124.86mt8gpqra.gmgdl@evledraar.gmail.com/
