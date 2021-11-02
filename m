Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F15FC433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D6B60F02
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhKBP2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbhKBP2x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 11:28:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9661FC061767
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 08:26:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ee33so6413446edb.8
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 08:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=J+p97iAAQLFiA1OKy1r7bjYD8RVs59Xl8xVkyNh7x/w=;
        b=NGJgP7BvBNL4NbIsxI7FhJPgg/QpKWKiFDEiKwoTEPeB5D/K8FNmP8T6b7mTp3BG2x
         R/CO39/nULh0/tWn1f9eBkem2A44FSqxL/N4UjJZnof2WOydocyKXAiHMJkcHHxl5uk2
         Vf/LN7Ywmr7z/iJajsEJTRZSh8mmHlCwTEMZAB7vY5oJIdIVwWW5m603HQVoW5lLIuY+
         Plc4HZhwQUnRWy9S2tCGXpfmUTIIUV9LUFPI+g8qCpE82uj7/INiDbGUzCm9VDNjtyAl
         m1pfubYcixN/oB3NdHbSdqWQm6xox72RDmrzkULKHej40DQ9ajLADNKtDjHMT8ewLxkk
         yalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=J+p97iAAQLFiA1OKy1r7bjYD8RVs59Xl8xVkyNh7x/w=;
        b=RLy2UfPbf5dDP4HKKZ0VC8xgll0tQcS5wCtG+z3RVuZqgE4asU9Qs14E8okwJUpLhx
         oxo1zMwEr1v8Z58Cs4tF94KrX/PUrCp63JLNbLvBHxOgcJYPC2xNTL0tMz9tmVVwUv8U
         /uze7Fp/wtMcMIVcwIK1HgrdiNjYf4MrV9TgWyHZQPJ+zB9mhATyHu1b5BhrlrnhIe25
         8hitQw7k+bl/Gd4dnK10Tnl/5ge/NDb5ppPcI9vq4ACh1j38e/I3jh9fjy0b5S7tuJ2H
         +iLfYBqTFR0p0f92DNPmvsZtvgT+BfhQy/578HrDj0z+2Zylz8nH+9lPvO3YFK65KkZi
         q3iQ==
X-Gm-Message-State: AOAM532/3hjkYC4+meTdR/BQTVuliUTyE1f1n4tBYwv8oCsinEtLMKg1
        takoNoqbeK89Y0apFV8C9ao=
X-Google-Smtp-Source: ABdhPJyJMtz3pKPeXVitkqAkVYYEB7KZQSOU1NHXxAjBqId0T1sk9lAy7gQXJBKFOYvZ0Wi7O8uYOA==
X-Received: by 2002:a17:907:72c9:: with SMTP id du9mr46258390ejc.124.1635866777069;
        Tue, 02 Nov 2021 08:26:17 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j11sm8213875ejt.114.2021.11.02.08.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:26:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mhvfz-002EFY-W6;
        Tue, 02 Nov 2021 16:26:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: disallow directional formatting
Date:   Tue, 02 Nov 2021 16:01:57 +0100
References: <pull.1071.git.1635857935312.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <pull.1071.git.1635857935312.gitgitgadget@gmail.com>
Message-ID: <211102.86tugu1svc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 02 2021, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> As described in https://trojansource.codes/trojan-source.pdf, it is
> possible to abuse directional formatting (a feature of Unicode) to
> deceive human readers into interpreting code differently from compilers.
>
> It is highly unlikely that Git's source code wants to contain such
> directional formatting in the first place, so let's disallow it.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     ci: disallow directional formatting
>     
>     I just stumbled over
>     https://siliconangle.com/2021/11/01/trojan-source-technique-can-inject-malware-source-code-without-detection/,
>     which details an interesting social-engineering attack: it uses
>     directional formatting in source code to pretend to human readers that
>     the code does something different than it actually does.
>     
>     It is highly unlikely that Git's source code wants to contain such
>     directional formatting in the first place, so let's disallow it.
>     
>     Technically, this is not exactly -rc material, but the paper was just
>     published, and I want us to be safe.

There's a parallel discussion about doing something to detect this in
"git am", which for the git project seems like a better place to put
this.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1071%2Fdscho%2Fcheck-for-utf-8-directional-formatting-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1071/dscho/check-for-utf-8-directional-formatting-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1071
>
>  .github/workflows/main.yml | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 6ed6a9e8076..7b4b4df03c3 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -289,6 +289,13 @@ jobs:
>      - uses: actions/checkout@v2
>      - run: ci/install-dependencies.sh
>      - run: ci/run-static-analysis.sh
> +    - name: disallow Unicode directional formatting
> +      run: |
> +        # Use UTF-8-aware `printf` to feed a byte pattern to non-UTF-8-aware `git grep`
> +        # (Ubuntu's `git grep` is compiled without support for libpcre, otherwise we
> +        # could use `git grep -P` with the `\u` syntax).
> +        ! LANG=C git grep -Il "$(LANG=C.UTF-8 printf \
> +          '\\(\u202a\\|\u202b\\|\u202c\\|\u202d\\|\u202e\\|\u2066\\|\u2067\\|\u2068\\|\u2069\\)')"
>    sparse:
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled == 'yes'
>
> base-commit: 0cddd84c9f3e9c3d793ec93034ef679335f35e49

It would be easier to maintain this if were added to
ci/run-static-analysis.sh instead, where we have some similar tests, and
if it lives there we could do away with the double-escaping, then it can
also be run manually.

Also, can't we just pipe "git ls-files -z" into "perl -0ne" here and use
its unconditional support for e.g. unicode properties in regexes.

How will this change impact RTL languages being added to po/?
