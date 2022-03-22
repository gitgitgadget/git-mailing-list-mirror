Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26454C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 10:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiCVKVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 06:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiCVKVE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 06:21:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05177EB3A
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 03:19:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id j15so21064055eje.9
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=CxMO2kcyB/3c+O35POhgd++/rIEAa1BaSQFySg0ILeI=;
        b=gSQVAFM4RPTgUsudQhENmpX0OFR8bF2dP8rJdsu8PVOF7K3T0U1gHjv6aRgRZLYzSX
         iLaz//3jutjxr1Ch+2IqkApl4gXpTegxaMwus5c358GpjMrUnimaXG5oeqFQIOUhuwkD
         53OJxaWpSqmCFGgXpm+bPu8lf2CtK4w0sdlhKL0nBMqcuY2GuB06mKDo1UOkN17dYXz0
         1XEvZu1zTRLStAqrrEl09LqhsvvL9SOrtqv24sOOe4ErhfNqGPbc+v3uFzaBiGWurEKe
         M5N8jD22X7WmvrlePEbtSOqlLtgFZ2rdBmxMmN3jonK1hFK33ihiclws+nLn+XCPWeon
         gV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=CxMO2kcyB/3c+O35POhgd++/rIEAa1BaSQFySg0ILeI=;
        b=ym9153tW+syuqDXLkh2vO99kK5+9yYhlYENtSv2943FxXNiiwWFBUnDDiJ90LYxyzR
         YKUz/utQmQ86tfgXrYxE49kUTVn0Kf/sEQimvkpoyA8jdyhwnv4pyvB1S3RqBYQqMNUb
         Ga/79Q6/QR6zpi9TQbIwteo6aS8+/659xEbaxlEqLHLR33dNaHO78/UgqksVfrrO/OXZ
         Ylc5YvZigSdVOJJzIIHPLfNQUHgCQTAWaBR6LMyeAYjXoWTreSA45eN/NYSUwMNR0QGo
         XiqW2nS82azxW9VQelrpRn8Hq4iocyidRtt/FGsIeSf2MTtR3tSZ/DjQv8mZqvxsjDUY
         PyNw==
X-Gm-Message-State: AOAM533KjqouKjjXPJ2wb0FtQUsBfz04e0qPxs4VVXyUzf3412YNDn6e
        3J6CSI0jSspLNaJCV2yzEddI1LrOZHhwLw==
X-Google-Smtp-Source: ABdhPJytxaYJOaQQDYxS7Wy2e3Y/a+cIVpaK+EwTjYlpFL2fNf/nfF53TsLkTjnpCl/DWY+dZohv6A==
X-Received: by 2002:a17:907:c16:b0:6db:682:c8c9 with SMTP id ga22-20020a1709070c1600b006db0682c8c9mr25514565ejc.153.1647944375049;
        Tue, 22 Mar 2022 03:19:35 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h17-20020a05640250d100b004185745f856sm9447235edb.74.2022.03.22.03.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 03:19:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWbbx-000HLD-U4;
        Tue, 22 Mar 2022 11:19:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] hooks: fix "invoked hook" regression in a8cc5943338
Date:   Tue, 22 Mar 2022 11:12:38 +0100
References: <0220321203019.2614799-1-jonathantanmy@google.com>
 <patch-1.1-d0c9b430b2c-20220321T230933Z-avarab@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <patch-1.1-d0c9b430b2c-20220321T230933Z-avarab@gmail.com>
Message-ID: <220322.86ee2unvbe.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 22 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Fix a regression in a8cc5943338 (hooks: fix an obscure TOCTOU "did we
> just run a hook?" race, 2022-03-07): The "invoked_hook" variable
> passed to run_commit_hook() wasn't passed forward to run_hooks_opt(),
> as push_to_checkout() in that commit correctly did.
>
> Whether we ran the code contingent on having run the hook or not was
> thus undefined, but in practice on most (all?) modern platforms we'd
> have run it (almost?) all the time, since stack variables will get
> initialized to some random value, which most of the time isn't "0".
>
> This bug was revealed by running e.g. "t5537-fetch-shallow.sh" with
> the --valgrind option. Unfortunately running the whole test suite with
> --valgrind is really slow, so we didn't have a CI job that spotted
> this. The --valgrind output was:
>
>     =3D=3D31275=3D=3D Conditional jump or move depends on uninitialised v=
alue(s)
>     =3D=3D31275=3D=3D    at 0x43C63F: prepare_to_commit (commit.c:1058)
>     =3D=3D31275=3D=3D    by 0x4396A5: cmd_commit (commit.c:1722)
>     =3D=3D31275=3D=3D    by 0x407C8A: run_builtin (git.c:465)
>     =3D=3D31275=3D=3D    by 0x406741: handle_builtin (git.c:718)
>     =3D=3D31275=3D=3D    by 0x407665: run_argv (git.c:785)
>     =3D=3D31275=3D=3D    by 0x406500: cmd_main (git.c:916)
>     =3D=3D31275=3D=3D    by 0x510839: main (common-main.c:56)
>     =3D=3D31275=3D=3D  Uninitialised value was created by a stack allocat=
ion
>     =3D=3D31275=3D=3D    at 0x43B344: prepare_to_commit (commit.c:719)
>
> Reported-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>
> On Mon, Mar 21 2022, Jonathan Tan wrote:
>
>> This commit causes Git to fail Valgrind (tested using "cd t && sh
>> t5537*.sh -i -v --valgrind-only=3D10"). You can see here that a caller of
>> run_commit_hook() expects invoked_hook to be set, but...
>
> That's a really stupid bug, sorry :( This fixes it.
>
>  commit.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/commit.c b/commit.c
> index 98b2e556653..ec1207ebef4 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1732,5 +1732,6 @@ int run_commit_hook(int editor_is_used, const char =
*index_file,
>  		strvec_push(&opt.args, arg);
>  	va_end(args);
>=20=20
> +	opt.invoked_hook =3D invoked_hook;
>  	return run_hooks_opt(name, &opt);
>  }

I tried adding a valgrind CI job, but even running --valgrind-only=3D1
(i.e. only the first test in each file would run with valgrind) took
around 5h40m to complete with the patch below.

I wonder if it's still worth it in some form, it would suck to have to
wait that long by default for "green" CI, but e.g. for Junio's "master"
and "next" (and maybe "seen") maybe it's fine if some of the extended
checks take a long time to complete. It would have caught the problem in
this case.

We could probably run the entire test suite through valgrind by sharding
the test jobs similarly to what the Windows jobs do now, and could also
run e.g. SANITIZE=3Daddress and any other opt-in long-running CI.

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index c35200defb9..58a0c0c8966 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -251,6 +251,9 @@ jobs:
           - jobname: linux-leaks
             cc: gcc
             pool: ubuntu-latest
+          - jobname: linux-valgrind
+            cc: gcc
+            pool: ubuntu-latest
     env:
       CC: ${{matrix.vector.cc}}
       CC_PACKAGE: ${{matrix.vector.cc_package}}
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index dbcebad2fb2..098ffde3a57 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -76,6 +76,9 @@ linux-gcc-default)
 	sudo apt-get -q update
 	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS
 	;;
+linux-valgrind)
+	sudo apt-get -q -y install valgrind
+	;;
 esac
=20
 if type p4d >/dev/null && type p4 >/dev/null
diff --git a/ci/lib.sh b/ci/lib.sh
index cbc2f8f1caa..1a78dab7a47 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -208,6 +208,10 @@ linux-leaks)
 	export SANITIZE=3Dleak
 	export GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue
 	;;
+linux-valgrind)
+	GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --valgrind-only=3D1"
+	export GIT_TEST_OPTS
+	;;
 esac
=20
 MAKEFLAGS=3D"$MAKEFLAGS CC=3D${CC:-cc}"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9af5fb7674d..8157edcfee0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -274,7 +274,7 @@ fi
 if test -n "$valgrind_only"
 then
 	test -z "$valgrind" && valgrind=3Dmemcheck
-	test -z "$verbose" && verbose_only=3D"$valgrind_only"
+	test -z "$verbose$verbose_log" && verbose_only=3D"$valgrind_only"
 elif test -n "$valgrind"
 then
 	test -z "$verbose_log" && verbose=3Dt

