Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027E7C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 18:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiLSSRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 13:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiLSSRA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 13:17:00 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B5F2727
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:16:58 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id vv4so23632155ejc.2
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jPvkREFmIk09WMyMIU9l9Tr0BDDr3L+wsLQeXuokYVE=;
        b=B4mNxTRN8oYzheS49NCBnrrHo1J5t0p3cusBaH39gKdYQheKSDB4+zjJGNZ6lHgBw4
         yH4Db14hmsAqnHnzNSnwWIIqLvr9tgKWvf3M33mm4+f6m+xfrK0seH4+T88XDljvY4xX
         qt0S5UH5atHSdFSqoOfgJXChg2IzO4FWsqLVmDVUvF2mZraYDQBXLtPx2qCyXjXZy47q
         8qFmZdU+Ywlvxs018FBq1bOu6A036rBKvCyrnD5x0kOYialHkvXtweqzXo8RZEg6RAcR
         52K0i26Xa6Z5O2se84JEAkIbZPkkRkYrQVth7/k1bnqJIpJWUWag6r5+wbwPYlJjx3P5
         RNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPvkREFmIk09WMyMIU9l9Tr0BDDr3L+wsLQeXuokYVE=;
        b=cKEt//Z997yZPNfnWulcX5BQtblyGKS693vNy+j153YGMVWyZUCo2HDlhP9kitBSQ+
         +7nLFTrE5EcPdXAloLMWLJKj1XMriJIVnTmc9zUxiurzyYaEXniV8TG/L2ezVSAmj6wE
         JFypaxF6P0va/DUZ0p9eRDJ6Y2bDPWusP4UI8ydPrwPXcc8cwl8DhJGHCcbab4roflpx
         bpze/yInj3ocMlbIjMf383+KScsnse/KLMNF2f+Yir/c/oiTAFnydKEfTqz7ne1OJa2U
         cZHR0Vpa1WHdhPJRg/+SF5XBR04hMrERT5+TiG9Ssz2NtNX94q0fkFTr1i9NtwXxCqqU
         CH7Q==
X-Gm-Message-State: ANoB5pnaj+We4if5pC/cAJIAXD2p4K1+Q/+yE1GZuQa7DgiXv5aQx8wg
        XkbehILmH2YL+ioZMNPUfpr+NZeBU6GV/Q==
X-Google-Smtp-Source: AA0mqf6M9I512CedsZfy4OXXTZihfklrEoF8kwlJ8zXESiWXW1Zfn9zdIfKXutLGWiAS5rkU8MfGqw==
X-Received: by 2002:a17:907:b60f:b0:7c1:6e53:dd02 with SMTP id vl15-20020a170907b60f00b007c16e53dd02mr30592964ejc.64.1671473816648;
        Mon, 19 Dec 2022 10:16:56 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id i19-20020a170906699300b007add62dafbasm4661342ejr.157.2022.12.19.10.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:16:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7Kh5-006hLr-24;
        Mon, 19 Dec 2022 19:16:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk, peff@peff.net,
        me@ttaylorr.com, phillip.wood123@gmail.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] ci: only run win+VS build & tests in Git for Windows' fork
Date:   Mon, 19 Dec 2022 18:49:12 +0100
References: <pull.1445.git.1671461414191.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1445.git.1671461414191.gitgitgadget@gmail.com>
Message-ID: <221219.86zgbjxnqg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 19 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> [...]
>     Explicitly make CMake-based CI failures the responsibility of "Windows
>     folks"
>=20=20=20=20=20
>     =C3=86var and I have brain-stormed off-list what would be the best wa=
y to
>     resolve the mounting frustration with CI failures that are caused by
>     needing to mirror Makefile changes into the CMake-based build, a burd=
en
>     that the Git project never wanted to bear.
>=20=20=20=20=20
>     While he still wants to improve the CMake support (which will benefit
>     Git for Windows), the main driver of trying to extend CMake support to
>     Linux (which does not need it because make works very well there,
>     indeed) was said frustration with CI failures.
>=20=20=20=20=20
>     A much quicker method to reduce that friction to close to nil is to
>     simply disable the win+VS jobs, which is what this proposal is about.
>     (Almost, at least, we still want to keep those job definitions and run
>     them in Git for Windows' fork to ensure that CMake-based builds still
>     work.)
>=20=20=20=20=20
>     A very welcome side effect is to reduce the CI build time again, which
>     became alarmingly long as of recent, causing friction on its own.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1445%2F=
dscho%2Fonly-run-win%2BVS-in-the-git-for-windows-fork-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1445/dscho=
/only-run-win+VS-in-the-git-for-windows-fork-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1445
>
>  .github/workflows/main.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index e67847a682c..8af3c67f605 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -132,7 +132,7 @@ jobs:
>    vs-build:
>      name: win+VS build
>      needs: ci-config
> -    if: needs.ci-config.outputs.enabled =3D=3D 'yes'
> +    if: github.event.repository.owner.login =3D=3D 'git-for-windows' && =
needs.ci-config.outputs.enabled =3D=3D 'yes'
>      env:
>        NO_PERL: 1
>        GIT_CONFIG_PARAMETERS: "'user.name=3DCI' 'user.email=3Dci@git'"

In terms of implementation: I would like this to use ci-config.

Yes, it will take us some CI time just to spin up the image to decide on
that (only a few seconds), but it's preferrable to hardcoding
github.com/git-for-windows, as you'll be able to opt-in to this to test
changes.

The outstanding "tb/ci-concurrency" topic shows how to do that (and
tweaks an earlier submission of yours where it was similarly hardcoded).

> The purpose of these win+VS jobs is to maintain the CMake-based build
> of Git, with the target audience being Visual Studio users on Windows
> who are typically quite unfamiliar with `make` and POSIX shell

I thought the initial purpose of it was to test compiling & testing with
MSVC rather than GCC?

It's only after 4c2c38e800f (ci: modification of main.yml to use cmake
for vs-build job, 2020-06-26) that it got co-opted to test cmake too.

Whatever we do about the job at this point not discussing 4c2c38e800f in
the commit seems like a big omission, why not revert & adjust it if the
cmake part of it is a perceived hassle?

Now, I don't think that it's worth spending time on running two sets of
Windows tests all the time just to tease out GCC v.s. MSVC differences,
but I think we should still run the build on both. That takes around
~5m, and seems worth it to avoid and flag any portability issues.

Before this we test on gcc/clang/msvc, after this we'll have dropped
that last one. Whatever we do about the tests and/or cmake I think we
really should avoid compiler monoculture, and fix portability issues
early.

> A very welcome side effect is to reduce the CI build time again, which
> became alarmingly long as of recent, causing friction on its own.

I think this is a good goal, but what does the "as of recent" refer to
here? When the ASAN job was introduced?
