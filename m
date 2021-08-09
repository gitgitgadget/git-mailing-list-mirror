Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7F3C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 14:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF5161019
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 14:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhHIO43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 10:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbhHIO42 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 10:56:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA08FC0613D3
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 07:56:07 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l18so21885669wrv.5
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=39cRXHH13Sct/0Hr9YEgMIxF29XW4leCTy5hXyguyow=;
        b=nUSG9vBDeCIorflcDcikBS6pFxMIHLF7PZBAw/+/WOUYV5E95N5VFwqbAal7fVzn/w
         dtirUkOyo28zBp16+AUtwc/nhBP4jS/Zr9sDG7V1XSju5ogNRz6BKiIotECXq0x1i9uv
         qh+qWeyh48Wg3EEUbBMxl5xbirhrbQ+bCxp+q0lsNRS8Upjee6QUFJdb/csAHMfOwkJS
         /Nzi5BVxpSymW09Fza32eRdS9/Q08hYwXjiHae60sP6HH9GyRPKrvjDuWn7VCe1hxQ1m
         UvGf6CG0N+nWwHaTO/8WOC+6Ix2EBvxeL8448PNkSvqT10aDqySaPnD8zl8YkHmRXxCJ
         aRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=39cRXHH13Sct/0Hr9YEgMIxF29XW4leCTy5hXyguyow=;
        b=aWpVHjIpJHQwb9MzFWoaN6w1Z+QLbe5tNOy5ZakZ6flER9J77qiwFYIkjVfkcn100V
         oVgL5RDyV/L4xnAAo9A9kzSDRdd0Z8LzlhMEHlX7EEnC92Nxk0p4edjM55YyF8cfTsGn
         EGK2HUA4Bp6bQqBrOo7R+x2UUUWsO0Ylfb/VQHyY9pGAqy5EiIuz20LkTftp5vaCen3T
         KAKVYNTD2vOTTLOgDrk9L58yRROI8oxMYQD9N3/Gg8RgEV9Xyw/auoZA0d+fUlk3Sbxv
         yUQndWn11oNGT2rtj9F8ERVbuhaCYKeOGFLq/LiMNwUIVXDrmtj2YLDBj3FQ8d35AFHg
         xGvA==
X-Gm-Message-State: AOAM531o/cp93X/gaA4I4Qt/+8Ev4V5lUViPNU/5HEw42UxL3fdAAGZX
        2KerQPzZzKZl8ij+h0buVGQ=
X-Google-Smtp-Source: ABdhPJw5bQgzHl5Kw1BYa0bN/yjSsO+SMkv6T2/0OV1WcVIiRXCLr+WGoi1q5O4ECXXoDVUMbG0AqQ==
X-Received: by 2002:a5d:4852:: with SMTP id n18mr2187772wrs.10.1628520966393;
        Mon, 09 Aug 2021 07:56:06 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.232])
        by smtp.gmail.com with ESMTPSA id p8sm1961749wme.22.2021.08.09.07.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 07:56:05 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH/RFC 3/3] ci: run a pedantic build as part of the GitHub
 workflow
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     e@80x24.org
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com>
 <20210809013833.58110-4-carenas@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <1b096830-3e01-efbe-25dc-c0505c8bac7b@gmail.com>
Date:   Mon, 9 Aug 2021 15:56:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809013833.58110-4-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo

On 09/08/2021 02:38, Carlo Marcelo Arenas Belón wrote:
> similar to the recently added sparse task, it is nice to know as early
> as possible.
> 
> add a dockerized build using fedora (that usually has the latest gcc)
> to be ahead of the curve and avoid older ISO C issues at the same time.

If we want to be able to compile with -Wpedantic then it might be better 
just to turn it on unconditionally in config.mak.dev. Then developers 
will see any errors before they push and the ci builds will all use it 
rather than having to run an extra job. I had a quick scan of the mail 
archive threads starting at [1,2] and it's not clear to me why 
-Wpedaintic was added as an optional extra.

Totally unrelated to this patch but while looking at the ci scripts I 
noticed that we only run the linux-gcc-4.8 job on travis, not on github.

Best Wishes

Phillip

[1] https://lore.kernel.org/git/20180721185933.32377-1-dev+git@drbeat.li/
[2] https://lore.kernel.org/git/20180721203647.2619-1-dev+git@drbeat.li/

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>   .github/workflows/main.yml        |  2 ++
>   ci/install-docker-dependencies.sh |  4 ++++
>   ci/run-build-and-tests.sh         | 10 +++++++---
>   3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 47876a4f02..6b9427eff1 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -259,6 +259,8 @@ jobs:
>             image: alpine
>           - jobname: Linux32
>             image: daald/ubuntu32:xenial
> +        - jobname: pedantic
> +          image: fedora
>       env:
>         jobname: ${{matrix.vector.jobname}}
>       runs-on: ubuntu-latest
> diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependencies.sh
> index 26a6689766..07a8c6b199 100755
> --- a/ci/install-docker-dependencies.sh
> +++ b/ci/install-docker-dependencies.sh
> @@ -15,4 +15,8 @@ linux-musl)
>   	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
>   		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
>   	;;
> +pedantic)
> +	dnf -yq update >/dev/null &&
> +	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
> +	;;
>   esac
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 3ce81ffee9..f3aba5d6cb 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -10,6 +10,11 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
>   *) ln -s "$cache_dir/.prove" t/.prove;;
>   esac
>   
> +if test "$jobname" = "pedantic"
> +then
> +	export DEVOPTS=pedantic
> +fi
> +
>   make
>   case "$jobname" in
>   linux-gcc)
> @@ -35,10 +40,9 @@ linux-clang)
>   	export GIT_TEST_DEFAULT_HASH=sha256
>   	make test
>   	;;
> -linux-gcc-4.8)
> +linux-gcc-4.8|pedantic)
>   	# Don't run the tests; we only care about whether Git can be
> -	# built with GCC 4.8, as it errors out on some undesired (C99)
> -	# constructs that newer compilers seem to quietly accept.
> +	# built with GCC 4.8 or with pedantic
>   	;;
>   *)
>   	make test
> 
