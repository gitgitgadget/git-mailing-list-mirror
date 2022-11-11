Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04AFC4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 14:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbiKKOQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 09:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbiKKOQg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 09:16:36 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0A265858
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 06:07:13 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id f7so7767509edc.6
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 06:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yACayWEkmPvNdIS4FDJLApZj5Gy6ObFl0r6Oy72T/KE=;
        b=G/uLC/ENfNSxsVcs4FEetnNP4Ev60UHT3XnAQoIMyKRRHg4va0FV9mhcGwQ5RVYmhj
         QdYHUhRAT0OsrKJcKuvJzXTYu98R9MMjCjfOaQItnHzEEwbIpw0Xf82IJ6sWwhej6Kee
         bSQHcZJLUFqWrXdwJYnKMXDtPw9mHjU/lbDsxBh2YZavg09Hut3VZgtft3tBAF7jMJ5o
         e4WtwdVV3RjFyARyvj/t4WzBdMbcgcNePkqHSS1zK/egcQ+3CSVxTlHPY+C8lE0HHeSJ
         WAB0xAp5I8uNfYiii9+STApyuwqk4gijR9m2CbnuzZ5CYr0+LBRYtHrGCIHR2tKUmzfF
         FYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yACayWEkmPvNdIS4FDJLApZj5Gy6ObFl0r6Oy72T/KE=;
        b=p60hXwcHwOSm2VQA8wAujmcibY4H0y3vIQQrRKBDrZOdXudZWi7cgFnB71AmCQTqfX
         ZXbbdeQgWyVXvBp/zPEGNLuD1NYz+FK+cnoOZ2w/jBjBx6RkDbRvZt1KXIM56yBPj9qF
         UYlTmziekGGOExl0ThHCHThAIbaKzH5/nC8acGoUC3JlyhxmpJZ3glPJYdXrTh15z1ed
         CKuTWIY70WOZf/qC1r5E5gZUJkFkRUqHAVj+kP6vgHMZ3lMxdnZk97TFVVw4uBEP4ilW
         ffTdp7+fYCiogowPTUhzotmn8HFlsoNH3/9Z7vsLBhziXlp3cpuPYrD+8nqL94texH8p
         p9zQ==
X-Gm-Message-State: ANoB5plT3G/0UgiR/jE5vwdYInUTb30QoCWkGvi/GvGb3eqMyhK/pCn2
        D0p2cIC5McuA11JkFy6oi6k=
X-Google-Smtp-Source: AA0mqf51pDoQK/5169ZE/hWSm2BVjKVJUX1yT80mkZdpBUlTyQVMCbzYqQfyfCsymP/X5u/94RYaOQ==
X-Received: by 2002:a05:6402:2b8e:b0:461:b952:8932 with SMTP id fj14-20020a0564022b8e00b00461b9528932mr1653938edb.104.1668175632346;
        Fri, 11 Nov 2022 06:07:12 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id d26-20020a170906305a00b007ae38d837c5sm913135ejd.174.2022.11.11.06.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 06:07:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1otUgY-001uza-1w;
        Fri, 11 Nov 2022 15:07:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/11] Turn `git bisect` into a full built-in
Date:   Fri, 11 Nov 2022 14:53:19 +0100
References: <cover.1668097286.git.congdanhqx@gmail.com>
 <cover.1668097962.git.congdanhqx@gmail.com>
 <dadca7adbe3e7984f60fd6de6c8d63edb6a1ad8f.1668097966.git.congdanhqx@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <dadca7adbe3e7984f60fd6de6c8d63edb6a1ad8f.1668097966.git.congdanhqx@gmail.com>
Message-ID: <221111.86edu9oa9d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 10 2022, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Now that the shell script hands off to the `bisect--helper` to do
> _anything_ (except to show the help), it is but a tiny step to let the
> helper implement the actual `git bisect` command instead.
>
> This retires `git-bisect.sh`, concluding a multi-year journey that many
> hands helped with, in particular Pranit Bauna, Tanushree Tumane and
> Miriam Rubio.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gma=
il.com>
> ---
>  Makefile                               | 3 +--
>  builtin.h                              | 2 +-
>  builtin/{bisect--helper.c =3D> bisect.c} | 2 +-
>  git.c                                  | 2 +-
>  4 files changed, 4 insertions(+), 5 deletions(-)
>  rename builtin/{bisect--helper.c =3D> bisect.c} (99%)
>
> diff --git a/Makefile b/Makefile
> index 4927379184..78785c6b84 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -627,7 +627,6 @@ THIRD_PARTY_SOURCES =3D
>  # interactive shell sessions without exporting it.
>  unexport CDPATH
>=20=20
> -SCRIPT_SH +=3D git-bisect.sh
>  SCRIPT_SH +=3D git-difftool--helper.sh
>  SCRIPT_SH +=3D git-filter-branch.sh
>  SCRIPT_SH +=3D git-merge-octopus.sh

This is missing a "git rm git-bisect.sh", which should be part of this
commit.

Do we have a test for at least the exit code of "git bisect -h"? I think
not, because before this it would have been (from skimming
git-sh-setup.sh) 1, but 129 after.

The new exit code is better, but let's test that. For some exitsing tests:

	git grep 'test_expect_code 129 .*-h'
