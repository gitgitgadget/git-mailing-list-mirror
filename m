Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD773C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 19:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKHTQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 14:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKHTQD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 14:16:03 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736CA5E3EA
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 11:16:02 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id m22so3951085eji.10
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 11:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wtdY3/MyMlTzT6IidYml/hz+MymUtywjQhOIEWhS09w=;
        b=UkvvgKbq85q3Q1H0SRU8GNOSh4ZsTtNoM946mq46O65tP5g17RvcRam97zxNhlmOz4
         GJeqFaCSceMERfuVkMFvyW+ODlets4B1r99qbE7FbQydlOZ9STUFWjsG+ToPOl8AhuQV
         M7J9OubYDjTpubx9wR/F6zn+xEsK0h3X0KAYU8IPvD5YeiS22VaP3zMKBMcWEwYeOdER
         gl70GpA+HElhtbW1pS2aIX4U1LQVIWegBj5bkhaESJJXEKHCmzO5tkMh2Xh9DSS4pcKR
         0evhO4uSolgbPm70e3cRfX7OHGyebMOibPGFxRGyXaNs1RKTRi3ftJ6gBImziKNhr6KI
         X0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtdY3/MyMlTzT6IidYml/hz+MymUtywjQhOIEWhS09w=;
        b=HjobGeqILwtwwROlo/3DE4cdQ/udmXFB4dAPoX4jO3TiShkSPp8YrbKUbCT1Z0ppmu
         din5UEUgX4YRHPMxMt0xggPQKuPbmh+TQ0J8Ggq2HgrPepX6XjPPhl56WcPwzYOXDt7I
         cojsfuK4jiOaV5VpR7ReQQ+9poL7jCkMkhhLMvFh07/MI4Ec67Rrr5q2RnWG8uLgTMvV
         RKDW2Hpi+0AWWNxjP/kSxtL/sci075Ajwlc6vSsSwknhEnuatPnySn8qcQsa7gavqKPd
         ANbs2Yxq+u7kcZn/QZgM+oHzEO5J1qYTEgsr/F2Z9hwS0DsZKJVmzslA6ba1CcPJWB90
         KY8w==
X-Gm-Message-State: ACrzQf3nQ/LeihbmhZSZWSukfbfEzZmv8dzzwQ/7f3Dh8X3cILkHdZzr
        bUa0dViqgvsYwjlG42cacBQ=
X-Google-Smtp-Source: AMsMyM5uXPBznOqRzka07T2o8PV3XpVMXkqmVWqL0Vuc6P2BgWLql96IeOyI7YKCMOBEt1KHudywZg==
X-Received: by 2002:a17:907:d093:b0:7ae:108:9728 with SMTP id vc19-20020a170907d09300b007ae01089728mr34334311ejc.484.1667934960928;
        Tue, 08 Nov 2022 11:16:00 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ew12-20020a056402538c00b00461cdda400esm5995347edb.4.2022.11.08.11.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 11:16:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osU4l-000iN4-2K;
        Tue, 08 Nov 2022 20:15:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] ci: avoid unnecessary builds
Date:   Tue, 08 Nov 2022 19:52:07 +0100
References: <cover.1667931937.git.me@ttaylorr.com>
 <ff172f1de982f6f79b598e4ac6d5b2964ca4a098.1667931937.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <ff172f1de982f6f79b598e4ac6d5b2964ca4a098.1667931937.git.me@ttaylorr.com>
Message-ID: <221108.86r0ydqmts.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 08 2022, Taylor Blau wrote:

> Whenever a branch is pushed to a repository which has GitHub Actions
> enabled, a bunch of new workflow runs are started.
>
> We sometimes see contributors push multiple branch updates in rapid
> succession, which in conjunction with the impressive time swallowed by
> even just a single CI build frequently leads to many queued-up runs.
>
> This is particularly problematic in the case of Pull Requests where a
> single contributor can easily (inadvertently) prevent timely builds for
> other contributors when using a shared repository.
>
> To help with this situation, let's use the `concurrency` feature of
> GitHub workflows, essentially canceling GitHub workflow runs that are
> obsoleted by more recent runs:
>
>   https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#concurrency
>
> For workflows that *do* want the behavior in the pre-image of this
> patch, they can use the ci-config feature to disable the new behavior by
> adding an executable script on the ci-config branch called
> 'skip-concurrent' which terminates with a non-zero exit code.

First, thanks for hacking this up. I've tested this just now in my fork,
and it seems to mostly work as advertised to me, more on the "mostly"
later.

I.e. the "cancel-in-progress" seems to work perfectly. I pushed a branch
with this, it started CI, then I made a trivial update, re-pushed, and
the initial branch's CI run was stopped, one job at a time (not all at
the same time, but almost).

Now, obviously it's a bit more of a verbose solution v.s. Johannes's
original in [1], but on the other hand our main.yml is full of that sort
of copy/pasting already.

Aside from the change under discussion I don't find that to be a big
deal. It's a general "problem", and we could always generate the file
with a script if we really cared, but I think for the forseeable future
the copy/pasting is fine.

But now on the "mostly": I *also* observed that when I turned this off
(I manually patched it to be "skip_concurrent=no" by default) the
"re-push" wouldn't run anything yet, because it was waiting on the other
run. A little "clock" icon is shown, and clicking on the job shows e.g.:

	 Waiting: This workflow is waiting on sparse to complete before running. 

The "sparse" is then a link to the in-progress "sparse" run in the
"other job".

So, completely aside from any catering to my (or anyone else's[2]?)
existing workflow around re-pushes (which I'll freely admit may or may
not be worth the effort), I think this change also has the presumably
unintended effect of changing how CI jobs are queued.

Which is that our workers were before scheduled per-repo (I think), and
you have a finite amount, but they're assigned generally (just from my
observation) in FIFO order based on the jobs that need to be run.

But now you have a queue that'll be piled up on the "repo/workflow/ref"
key. So that e.g. if you have 10 outstanding runs, 10 workers, and all
the pushes have finished except for their "linux-asan" job (or whatever
the slowest one happens to be) that you're only going to run one of
those "linux-asan" jobs at a time.

Now, I think this only matters *if* you flip the "cancel-in-progress" to
"false", so it was a moot point in the original [1]. I.e. you wouldn't
get concurrency anyway, so it didn't matter how things were queued.

This seems pretty clear from the API docs:

	Use concurrency to ensure that only a single job or workflow
	using the same concurrency group will run at a time.

I'm less sure about GitHub, but in other CI systems (e.g. GitLab's) a
"concurrency" feature like that is mainly targeted at jobs that
e.g. need some external resource (say a RDBMS), so you really want that
kind of throttling.

I don't know if there's a workaround for that, I'd think it would be the
logical equivalent of e.g.:

	group: sparse-${{ matrix.nr }}-${{ github.ref }}-${{ needs.ci-config.outputs.skip_concurrent ? github.run_id : "" }}

But the docs say "The expression can only use the github context."[3],
and I don't know if such a thing would fit inside the syntax...


1. https://lore.kernel.org/git/pull.1404.git.1667482458622.gitgitgadget@gmail.com/
2. https://lore.kernel.org/git/75ono097-16nr-nno4-rqoq-rrn79spps249@tzk.qr/
3. https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#concurrency


> diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
> index ad3466ad16..0bcc9cffbd 100644
> --- a/.github/workflows/check-whitespace.yml
> +++ b/.github/workflows/check-whitespace.yml
> @@ -9,6 +9,12 @@ on:
>    pull_request:
>      types: [opened, synchronize]
>  
> +# Avoid unnecessary builds. Unlike the main CI jobs, these are not
> +# ci-configurable (but could be).
> +concurrency:
> +  group: ${{ github.workflow }}-${{ github.ref }}
> +  cancel-in-progress: true
> +
>  jobs:
>    check-whitespace:
>      runs-on: ubuntu-latest
> diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
> index 27f72f0ff3..51fd46e6af 100644
> --- a/.github/workflows/l10n.yml
> +++ b/.github/workflows/l10n.yml
> @@ -2,6 +2,12 @@ name: git-l10n
>  
>  on: [push, pull_request_target]
>  
> +# Avoid unnecessary builds. Unlike the main CI jobs, these are not
> +# ci-configurable (but could be).
> +concurrency:
> +  group: ${{ github.workflow }}-${{ github.ref }}
> +  cancel-in-progress: true
> +
>  jobs:
>    git-po-helper:
>      if: >-
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index bd6f75b8e0..d27cd44584 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -11,6 +11,7 @@ jobs:
>      runs-on: ubuntu-latest
>      outputs:
>        enabled: ${{ steps.check-ref.outputs.enabled }}${{ steps.skip-if-redundant.outputs.enabled }}
> +      skip_concurrent: ${{ steps.check-ref.outputs.skip_concurrent }}
>      steps:
>        - name: try to clone ci-config branch
>          run: |
> @@ -34,7 +35,15 @@ jobs:
>            then
>              enabled=no
>            fi
> +
> +          skip_concurrent=yes
> +          if test -x config-repo/ci/config/skip-concurrent &&
> +             ! config-repo/ci/config/skip-concurrent '${{ github.ref }}'
> +          then
> +            skip_concurrent=no
> +          fi
>            echo "::set-output name=enabled::$enabled"
> +          echo "::set-output name=skip_concurrent::$skip_concurrent"
>        - name: skip if the commit or tree was already tested
>          id: skip-if-redundant
>          uses: actions/github-script@v3
> @@ -82,6 +91,9 @@ jobs:
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled == 'yes'
>      runs-on: windows-latest
> +    concurrency:
> +      group: windows-build-${{ github.ref }}
> +      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
>      steps:
>      - uses: actions/checkout@v2
>      - uses: git-for-windows/setup-git-for-windows-sdk@v1
> @@ -101,11 +113,14 @@ jobs:
>    windows-test:
>      name: win test
>      runs-on: windows-latest
> -    needs: [windows-build]
> +    needs: [ci-config, windows-build]
>      strategy:
>        fail-fast: false
>        matrix:
>          nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
> +    concurrency:
> +      group: windows-test-${{ matrix.nr }}-${{ github.ref }}
> +      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
>      steps:
>      - name: download tracked files and build artifacts
>        uses: actions/download-artifact@v2
> @@ -137,6 +152,9 @@ jobs:
>        NO_PERL: 1
>        GIT_CONFIG_PARAMETERS: "'user.name=CI' 'user.email=ci@git'"
>      runs-on: windows-latest
> +    concurrency:
> +      group: vs-build-${{ github.ref }}
> +      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
>      steps:
>      - uses: actions/checkout@v2
>      - uses: git-for-windows/setup-git-for-windows-sdk@v1
> @@ -184,11 +202,14 @@ jobs:
>    vs-test:
>      name: win+VS test
>      runs-on: windows-latest
> -    needs: vs-build
> +    needs: [ci-config, vs-build]
>      strategy:
>        fail-fast: false
>        matrix:
>          nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
> +    concurrency:
> +      group: vs-test-${{ matrix.nr }}-${{ github.ref }}
> +      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
>      steps:
>      - uses: git-for-windows/setup-git-for-windows-sdk@v1
>      - name: download tracked files and build artifacts
> @@ -218,6 +239,9 @@ jobs:
>      name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled == 'yes'
> +    concurrency:
> +      group: ${{ matrix.vector.jobname }}-${{ matrix.vector.pool }}-${{ github.ref }}
> +      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
>      strategy:
>        fail-fast: false
>        matrix:
> @@ -281,6 +305,9 @@ jobs:
>      name: ${{matrix.vector.jobname}} (${{matrix.vector.image}})
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled == 'yes'
> +    concurrency:
> +      group: dockerized-${{ matrix.vector.jobname }}-${{ matrix.vector.image }}-${{ github.ref }}
> +      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
>      strategy:
>        fail-fast: false
>        matrix:
> @@ -316,6 +343,9 @@ jobs:
>      env:
>        jobname: StaticAnalysis
>      runs-on: ubuntu-22.04
> +    concurrency:
> +      group: static-analysis-${{ github.ref }}
> +      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
>      steps:
>      - uses: actions/checkout@v2
>      - run: ci/install-dependencies.sh
> @@ -327,6 +357,9 @@ jobs:
>      env:
>        jobname: sparse
>      runs-on: ubuntu-20.04
> +    concurrency:
> +      group: sparse-${{ github.ref }}
> +      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
>      steps:
>      - name: Download a current `sparse` package
>        # Ubuntu's `sparse` version is too old for us
> @@ -345,6 +378,9 @@ jobs:
>      name: documentation
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled == 'yes'
> +    concurrency:
> +      group: documentation-${{ github.ref }}
> +      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
>      env:
>        jobname: Documentation
>      runs-on: ubuntu-latest

