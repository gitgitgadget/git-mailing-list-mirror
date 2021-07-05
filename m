Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3885BC07E98
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 06:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B956101C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 06:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhGEG6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 02:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhGEG6U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 02:58:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBBDC061574
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 23:55:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t3so22367431edt.12
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 23:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SlPdjb5bUBFMGJXGdf2FqsbHj7SbWG5e1sVM28wXfnU=;
        b=tNE7FoiaG7YAwzkENUVifTui8XeOH7v6JR0YiG6WBkJ5kmoUFZs7XjDV0UgnLrFBqY
         8OF+Fz3KZzpKLxmJoOwBzVIfbJxwWBUImqzQM4phY27XGdxzFefT7II4nckWv+yjmA8d
         Le28Iy+ECfLT6ceIkdn8Zu00f2s3rs0NyNAd9r0jnZwDUjVO4TsyK0/1NdlBkFISJGxa
         zHU5SK515eo0J5raESnxqJWxGIWqT9cMxnH4axPsZ0n7aSwMMLZ9jHKg4wLzLAiG5Ikp
         YYT+Uz9brSiTea9mKkql064yK4ZjpXh5KBjEL2I5tlpK5GhSxn/HMhR2nX2p745bFxx0
         89/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SlPdjb5bUBFMGJXGdf2FqsbHj7SbWG5e1sVM28wXfnU=;
        b=RY8mehUThGJGhLBYGry7GC3KWvgnJGHWzLsk67QbHL3xPpR0IObTrrPh9ZRuJe34jT
         V4V0vyAo33bNsXP44JyfkXnK1ksyuw84yEnmN5wQ+TBa7HMTgTLMdjbR0GzoWiFaYRSu
         RUXRomgIoowyhMIqWWsNnfFiecHxmR2U8lN5eApoayfpqSa0y2Vp6T+22rosX97UwzLy
         TDQNuLMxw2buCbvdKpB57HxD7bSWkKsLFxt1RXpKvcPEaB75oPYbcp8tnPwa1sze7vBe
         aU0Ja0MRbn0eDquMlNr2EEaPv3p4fjl/gBLhYlzQ2nzkvgTF4tE8a5GhmUHzWhbx2ASo
         JLuA==
X-Gm-Message-State: AOAM531vC0GQeskxdDFEEUPD0795IXikQruAJom/Mnwzffdwn4gYu0Tt
        dt4lNTmT1FDGpCd5uk7tA50=
X-Google-Smtp-Source: ABdhPJyB/Fvf55F1+LPsbteqGoMjDgt9tqGNVaMd2ei2auAXK5PrfBrD7R+6bH0rIvRfqaCbHrZWhw==
X-Received: by 2002:a05:6402:520c:: with SMTP id s12mr14836033edd.357.1625468141246;
        Sun, 04 Jul 2021 23:55:41 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e22sm4969882edu.35.2021.07.04.23.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 23:55:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dennis Ameling via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Dennis Ameling <dennis@dennisameling.com>
Subject: Re: [PATCH v3 6/7] ci(vs-build): build with NO_GETTEXT
Date:   Mon, 05 Jul 2021 08:45:38 +0200
References: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
 <pull.878.v3.git.1625439315.gitgitgadget@gmail.com>
 <2c4cd9dd1c8d966c8df0349bb820449ae1290793.1625439315.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <2c4cd9dd1c8d966c8df0349bb820449ae1290793.1625439315.git.gitgitgadget@gmail.com>
Message-ID: <87o8bh6yhf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 04 2021, Dennis Ameling via GitGitGadget wrote:

> From: Dennis Ameling <dennis@dennisameling.com>

Re the v3 cover letter & my v2 comment:

> We already build Git for Windows with `NO_GETTEXT` when compiling with
> GCC. Let's do the same with Visual C, too.
>
> Note that we do not technically _need_ to pass `NO_GETTEXT` explicitly
> in that `make artifacts-tar` invocation because we do this while `MSVC`
> is set (which will set `uname_S :=3D Windows`, which in turn will set
> `NO_GETTEXT =3D YesPlease`). But it is definitely nicer to be explicit
> here.

Okey, so we never used it in the first place. That makes the subject and
first paragraph of the commit message seem really out of place. So we
really mean something like this instead?:

    ci(vs-build): be explicit about NO_GETTEXT

    We already supply `NO_GETTEXT` implicitly due to config.mak.uname,
    but let's do so explicitly to ???

But if we're being explicit we also have SKIP_DASHED_BUILT_INS=3DYesPlease
since ef60e9f74b2 (ci: stop linking built-ins to the dashed versions,
2020-09-21) for CI, which has an even bigger effect on what's included
in the tarball, so it seems odd to single out NO_GETTEXT=3DYesPlease,
unless there's some other reason to do this that I'm missing.

Hrm, isn't the real reason here that before 5/7 this would error out,
because while NO_GETTEXT=3DY was implicit and we picked it up from the
config.mak.uname, we just had the $(MOFILES) in the archive-tar list
unconditionally.

So after 5/7 that's not the case, so we don't need this change anymore,
but we're making this change anyway? Seems like the result of this being
the first try at a fix, and then re-sequencing the two & keeping the
now-redundant hotfix.

> Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
> Helped-by: Matthias A=C3=9Fhauer <mha1993@live.de>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .github/workflows/main.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 0f7516c9ef3..c99628681ef 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -159,7 +159,7 @@ jobs:
>        shell: bash
>        run: |
>          cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=3D`pwd`/co=
mpat/vcbuild/vcpkg/installed/x64-windows \
> -        -DMSGFMT_EXE=3DC:/git-sdk-64-minimal/mingw64/bin/msgfmt.exe -DPE=
RL_TESTS=3DOFF -DPYTHON_TESTS=3DOFF -DCURL_NO_CURL_CMAKE=3DON
> +        -DNO_GETTEXT=3DYesPlease -DPERL_TESTS=3DOFF -DPYTHON_TESTS=3DOFF=
 -DCURL_NO_CURL_CMAKE=3DON
>      - name: MSBuild
>        run: msbuild git.sln -property:Configuration=3DRelease -property:P=
latform=3Dx64 -maxCpuCount:4 -property:PlatformToolset=3Dv142
>      - name: bundle artifact tar
> @@ -169,7 +169,7 @@ jobs:
>          VCPKG_ROOT: ${{github.workspace}}\compat\vcbuild\vcpkg
>        run: |
>          mkdir -p artifacts &&
> -        eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=3DYesPle=
ase ARTIFACTS_DIRECTORY=3Dartifacts 2>&1 | grep ^tar)"
> +        eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=3DYesPle=
ase ARTIFACTS_DIRECTORY=3Dartifacts NO_GETTEXT=3DYesPlease 2>&1 | grep ^tar=
)"
>      - name: zip up tracked files
>        run: git archive -o artifacts/tracked.tar.gz HEAD
>      - name: upload tracked files and build artifacts

