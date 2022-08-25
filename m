Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE39C32774
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 15:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240732AbiHYPAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 11:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiHYPAI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 11:00:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F86DE94
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 08:00:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gb36so40041204ejc.10
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 08:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=S1tHmByP9NGIFrCzSfq7crXMb8idwu5Qhw7BKEE59Ks=;
        b=GQZGScJ7el2Ss2EMH3UlvCoggn52mIJNMN0gUCSgZCrgQNsGg6a73a176w6S+Qq9u8
         155mmGmE/sPFpdhbjig+q5wmBWWM+f1CoCORhiM2GUSYi9WKq4JF5RB7b4mQehIQOsZR
         jNR5P5L6UhSJ9FcR3wGXN2rQTVUJYKYu7X476FYtj5jxH7U5CBGLjo3rBEd6memYjpiI
         Xuqy4sZK1MOz/9eVaiOrzjmes55PxGxsxSZpdmDPbABiHMKdyyHSV0atIjgggFMBk7Ky
         wX8jlVbc5a/zAZBZZzbjDPgwTlavqe7BmVfxBd2uW/Wy/ab0qgrR9r2PtvLQQkF+9788
         Xrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=S1tHmByP9NGIFrCzSfq7crXMb8idwu5Qhw7BKEE59Ks=;
        b=sc95w3cpxc/KnjC6V3UG+Rg/PTCr4CFm8sHpiOfXLGtvbufSxN06/Llbu2RaRXQF54
         R9DtWMaopAYtpluOQ4UFGpUz4zRC6Y7r41HCVwZQbuNICy4Arpe9CkezYD/NadguQd54
         h5JzNjakIpjyjjqCD3JacQ6emIQznbRjFvvtERJu+S6gaxAjKmuurI1jvub0yOSVcvlT
         epV26+SUt4K1jz6HTpy+tHNfFjcgticWXdo3EebXnaRTF7Ob0tQ22+S+ozmxSGFxF4Fr
         FzPRdq2z5f3CpJvRTkY+AcTz8Om+nEIVPyCpUdlO3zbLgg1S4kCeKzyVA5XFYHdXbaUT
         bs7A==
X-Gm-Message-State: ACgBeo3Vysh/u33nqTvgKROggCZr6hSWSJ0f4gwt48wA2yfpbiQsByUP
        HvQYJZdLiJpPWMpMQCleDBc=
X-Google-Smtp-Source: AA6agR7WoYaIOiQLyTrAyPkCFneGO0o/qzy5vb/BVRDKMrsBg3YuqJyUauJggkgIt6FZQGOruh0B2g==
X-Received: by 2002:a17:907:7f10:b0:73d:a3c5:1df8 with SMTP id qf16-20020a1709077f1000b0073da3c51df8mr2652003ejc.370.1661439605850;
        Thu, 25 Aug 2022 08:00:05 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bt2-20020a0564020a4200b0043d7b19abd0sm4980180edb.39.2022.08.25.08.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 08:00:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oREKy-001JYT-08;
        Thu, 25 Aug 2022 17:00:04 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
Date:   Thu, 25 Aug 2022 16:57:35 +0200
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
Message-ID: <220825.865yig4bd7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 23 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> GitHub Actions scheduled a brownout of Ubuntu 18.04, which canceled all
> runs of the 'static-analysis' job in our CI runs. Update to 22.04 to
> avoid this as the brownout later turns into a complete deprecation.
>
> The use of 18.04 was set in d051ed77ee6 (.github/workflows/main.yml: run
> static-analysis on bionic, 2021-02-08) due to the lack of Coccinelle
> being available on 20.04 (which continues today).
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>     ci: update 'static-analysis' to Ubuntu 20.04
>=20=20=20=20=20
>     I noticed this while preparing my bundle URIs series. See an example
>     cancellation at [1]
>=20=20=20=20=20
>     [1]
>     https://github.com/gitgitgadget/git/runs/7954913465?check_suite_focus=
=3Dtrue
>=20=20=20=20=20
>     I initially asked about this [2]. Thanks to Matthias A=C3=9Fhauer for
>     pointing out that 22.04 has Coccinelle available [3].
>=20=20=20=20=20
>     [2]
>     https://lore.kernel.org/git/eb8779bc-fc41-f601-05f2-024e6bf3f316@gith=
ub.com/
>     [3]
>     https://github.com/gitgitgadget/git/pull/1334#issuecomment-1223597655
>=20=20=20=20=20
>     Thanks,
>=20=20=20=20=20
>      * Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1334%2F=
derrickstolee%2Fstatic-analysis-ubuntu-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1334/derri=
ckstolee/static-analysis-ubuntu-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1334
>
>  .github/workflows/main.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index cd1f52692a5..831f4df56c5 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -309,7 +309,7 @@ jobs:
>      if: needs.ci-config.outputs.enabled =3D=3D 'yes'
>      env:
>        jobname: StaticAnalysis
> -    runs-on: ubuntu-18.04
> +    runs-on: ubuntu-22.04

I think it's worth mentioning in the commit message that the reason
we're not going for "ubuntu-latest" here is because "latest" is a
misnomer, it's not the "latest", but "latest-stable" or
whatever. I.e. it's pointing to 20.04 currently:

	https://docs.github.com/en/actions/using-github-hosted-runners/about-githu=
b-hosted-runners#supported-runners-and-hardware-resources

I think per
https://lore.kernel.org/git/211104.86v918i78r.gmgdl@evledraar.gmail.com/
that we should pin these in general, but you/Junio disagreed at the
time. So maybe a commit message change/comment here noting "# make this
ubuntu-latest once it's ubuntu-22.04 or later" or something would make
the intent clearer.

Also: for "sparse" didn't we miss doing that, i.e. it's pinned on
ubuntu-20.04 explicitly, but surely that should be "ubuntu-latest" now?
