Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD7BC433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 23:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiDVXN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 19:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiDVXL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 19:11:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF9F18BCA8
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 15:48:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id el3so7257871edb.11
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 15:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jm35q/hYHTOEbDu/pQJgQsltaCu4fakkXxoJeTT+Hlo=;
        b=nCGFkg/IUcD5SrHQtKTS0qtOF1j73m7Bro/LGM5eiCjT10tW4uCFQCRRdyQ/sDdBBs
         8wQqE1YPOf+zWU5LeqBtA2NMGhHy4Rp9u16U+F7ZcQyd1szz/Awgws24gnCu4zYV9FIC
         vEsnyFJlNut5kfq0m778kM+4tpoE4Vf/GuVjufFueckW8imGwiEF9UtsMrrisVn0k41R
         1CJ6oAT4/xJ/UYJU85PUdym6gQGOTUJ0jmx/SHCU+Arige/6UYQ23lV4VWJsDk0UbpYE
         9wBictRxoQT1r2BoBBiXsKbASgdgZJwBElaJZCOKlWsAi/ko0imfULfAHHUBe/sjOSH4
         jQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jm35q/hYHTOEbDu/pQJgQsltaCu4fakkXxoJeTT+Hlo=;
        b=PahaXdNR0nk1qGZmyUL5At1lWQ7n2o0sESuXB2NPXOW0sBmBl8QJvLvXcWCi6AVTEq
         ODZQYxmkFWYaoS4iuGeSea7CeBot1nzp5EfYdEP56PR2/mcU0qgKa3V5XJ0t7xWE1t+J
         GyvzqSMF0E+dfcf1A+9vrUdvbaAsjEHKbg+PEGhTVSNDFCMQ3MIHtbOK+LJviEa9vnfx
         /5UJ/mj2xRNptA062XirD0wMbPuz6Ge7XEOj7jQR3dyVQQ27f/n+0sxlqrX68o7P5HaG
         sTYZGqYDvLqF93NeF4xYfMVZyrfuXVGYTdz4d8dKkkIgCiEP6Cb8WKwk84v6260kbcW5
         xvMg==
X-Gm-Message-State: AOAM5323/EJnOvse2Wu1heSzGCyB24UJXGzVra8JjC9MKr9ZKA5CMh78
        Abl7leWPgelaKwNlHiP+i50=
X-Google-Smtp-Source: ABdhPJxh2hzWZU7ndbfAwlwMT0u4Qz0NanPb5ogbd2I39BVPOM20ggD96zoZE81BkLv9mb/B/cZrtg==
X-Received: by 2002:a05:6402:518b:b0:423:f9a0:d07f with SMTP id q11-20020a056402518b00b00423f9a0d07fmr7369743edd.268.1650667686911;
        Fri, 22 Apr 2022 15:48:06 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id fy29-20020a1709069f1d00b006e8d248fc2csm1124743ejc.108.2022.04.22.15.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 15:48:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ni24L-000MvH-Vo;
        Sat, 23 Apr 2022 00:48:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v3] CI: select CC based on CC_PACKAGE (again)
Date:   Sat, 23 Apr 2022 00:46:48 +0200
References: <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
 <patch-v3-1.1-8b3444ecc87-20220422T092015Z-avarab@gmail.com>
 <xmqqy1zw4u9p.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqy1zw4u9p.fsf@gitster.g>
Message-ID: <220423.86fsm4raze.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 22 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Fix a regression in 707d2f2fe86 (CI: use "$runs_on_pool", not
>> "$jobname" to select packages & config, 2021-11-23).
>>
>> In that commit I changed CC=3Dgcc from CC=3Dgcc-9, but on OSX the "gcc" =
in
>> $PATH points to clang, we need to use gcc-9 instead. Likewise for the
>> linux-gcc job CC=3Dgcc-8 was changed to the implicit CC=3Dgcc, which wou=
ld
>> select GCC 9.4.0 instead of GCC 8.4.0.
>>
>> Furthermore in 25715419bf4 (CI: don't run "make test" twice in one
>> job, 2021-11-23) when the "linux-TEST-vars" job was split off from
>> "linux-gcc" the "cc_package: gcc-8" line was copied along with
>> it, so its "cc_package" line wasn't working as intended either.
>>
>> As a table, this is what's changed by this commit, i.e. it only
>> affects the linux-gcc, linux-TEST-vars and osx-gcc jobs:
>>
>> 	|-------------------+-----------+-------------------+-------+-------|
>> 	| jobname           | vector.cc | vector.cc_package | old   | new   |
>> 	|-------------------+-----------+-------------------+-------+-------|
>> 	| linux-clang       | clang     | -                 | clang | clang |
>> 	| linux-sha256      | clang     | -                 | clang | clang |
>> 	| linux-gcc         | gcc       | gcc-8             | gcc   | gcc-8 |
>> 	| osx-clang         | clang     | -                 | clang | clang |
>> 	| osx-gcc           | gcc       | gcc-9             | clang | gcc-9 |
>> 	| linux-gcc-default | gcc       | -                 | gcc   | gcc   |
>> 	| linux-TEST-vars   | gcc       | gcc-8             | gcc   | gcc-8 |
>> 	|-------------------+-----------+-------------------+-------+-------|
>>
>> Reported-by: Carlo Arenas <carenas@gmail.com>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>
>> I just dropped the linux-TEST-vars change from the v2 in lieu of
>> trying to get the wording in the commit message right.
>
> I plan to fast-track this; the revamp of ci/lib.sh in the other huge
> series would probably need to be rebased on top, or independently
> fix it the same way.
>
> In the meantime, here is what I'll throwing into today's 'seen'.
>
> diff --cc ci/lib.sh
> index 86e37da9bc,80e89f89b7..0000000000
> --- i/ci/lib.sh
> +++ w/ci/lib.sh
> @@@ -195,6 -224,79 +224,79 @@@ ubuntu-latest
>   esac
>=20=20=20
>   case "$jobname" in
> + windows-build)
> + 	setenv --build NO_PERL NoThanks
> + 	setenv --build ARTIFACTS_DIRECTORY artifacts
> + 	;;
> + windows-test)
> + 	setenv --test MAKEFLAGS "$COMMON_MAKEFLAGS"
> + 	;;
> + vs-build)
> + 	setenv --build DEVELOPER $DEVELOPER
> + 	setenv --build SKIP_DASHED_BUILT_INS $SKIP_DASHED_BUILT_INS
> +=20
> + 	setenv --build NO_PERL NoThanks
> + 	setenv --build NO_GETTEXT NoThanks
> + 	setenv --build ARTIFACTS_DIRECTORY artifacts
> + 	setenv --build INCLUDE_DLLS_IN_ARTIFACTS YesPlease
> + 	setenv --build MSVC YesPlease
> +=20
> + 	setenv --build GIT_CONFIG_COUNT 2
> + 	setenv --build GIT_CONFIG_KEY_0 user.name
> + 	setenv --build GIT_CONFIG_VALUE_0 CI
> + 	setenv --build GIT_CONFIG_KEY_1 user.emailname
> + 	setenv --build GIT_CONFIG_VALUE_1 ci@git
> + 	setenv --build GIT_CONFIG_VALUE_1 ci@git
> + 	;;
> + vs-test)
> + 	setenv --test NO_SVN_TESTS YesPlease
> + 	setenv --test MAKEFLAGS "$COMMON_MAKEFLAGS"
> + 	;;
> + linux-gcc)
>  -	CC=3Dgcc
> ++	CC=3Dgcc-8
> + 	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME main
> + 	;;
> + linux-gcc-default)
> + 	CC=3Dgcc
> + 	;;
> + linux-TEST-vars)
>  -	CC=3Dgcc
> ++	CC=3Dgcc-8
> + 	setenv --test GIT_TEST_SPLIT_INDEX yes
> + 	setenv --test GIT_TEST_MERGE_ALGORITHM recursive
> + 	setenv --test GIT_TEST_FULL_IN_PACK_ARRAY true
> + 	setenv --test GIT_TEST_OE_SIZE 10
> + 	setenv --test GIT_TEST_OE_DELTA_SIZE 5
> + 	setenv --test GIT_TEST_COMMIT_GRAPH 1
> + 	setenv --test GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS 1
> + 	setenv --test GIT_TEST_MULTI_PACK_INDEX 1
> + 	setenv --test GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP 1
> + 	setenv --test GIT_TEST_ADD_I_USE_BUILTIN 1
> + 	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME master
> + 	setenv --test GIT_TEST_WRITE_REV_INDEX 1
> + 	setenv --test GIT_TEST_CHECKOUT_WORKERS 2
> + 	;;
> + osx-gcc)
> + 	MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python3)"
>  -	CC=3Dgcc
> ++	CC=3Dgcc-9
> + 	;;
> + osx-clang)
> + 	MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python2)"
> + 	CC=3Dclang
> + 	;;
> + linux-clang)
> + 	CC=3Dclang
> + 	setenv --test GIT_TEST_DEFAULT_HASH sha1
> + 	;;
> + linux-sha256)
> + 	CC=3Dclang
> + 	setenv --test GIT_TEST_DEFAULT_HASH sha256
> + 	;;
> + pedantic)
> + 	CC=3Dgcc
> + 	# Don't run the tests; we only care about whether Git can be
> + 	# built.
> + 	setenv --build DEVOPTS pedantic
> + 	;;
>   linux32)
>   	CC=3Dgcc
>   	;;

This matches the resolution I have for it. noted here:
https://lore.kernel.org/git/cover-v5-00.29-00000000000-20220421T181526Z-ava=
rab@gmail.com/

I.e. it was just those CC=3Dgcc lines for those two jobs that needed to be
tweaked to have CC=3Dgcc-8 and CC=3Dgcc-9, respectively. Then likewise for
linux-TEST-vars (not in my version, since that was against the v2 of the
series, but correct here).

Thanks!
