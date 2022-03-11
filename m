Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD84C4332F
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 09:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347511AbiCKJd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 04:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347508AbiCKJdy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 04:33:54 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCDC65D05
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 01:32:48 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y8so5097040edl.9
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 01:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=SPKR+hzZwMcGYucm9C7u3BH63A3ujK0x7iQkIbkwYOE=;
        b=gU0QeK5Jp5H9UK0XFuqteTdSyxcUwAD8jPL8Tjf0sKB7Knr0IJBvgiG9Xor5HrYAsF
         ZY9d6k8bkRAX2Uw6z9k6N5fHRzVWINfE/GG/NpeYE4/izUOhYAr9p5dfcat1rP9ECsYP
         Q9aB5PT/qqq3dh5CMMqcD49vlh3WZcqdPY/dmzG4a+KGmPQBJ5E1er44eQlVNraFebjj
         84/nXe3iLjDOiOMS5Tv4LufznpBaadhJEGzenIDxrSVqPqV2g3g9OOft9yVX9Bvjtugm
         t2BvHsSzL4Jryopld5luWbuXIaEVKcZhdAoiEv1Qclz4I9phiKZzVrnA0WIoDg+pYkWq
         iCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=SPKR+hzZwMcGYucm9C7u3BH63A3ujK0x7iQkIbkwYOE=;
        b=0kPZs+64XfZIl8W87mW5PLYAq7IFc1HW3gfU2Zjy3UPFi43gfP/q9FUE8ZCOizU7Yd
         5p2u0sSO8ruffEKQjNT2Z2gHIh+JuTMWEh0CXmTBXYDXZUZBSoNfSqkpGDH1rb38YthK
         AayLr2kOa7TVx6AxL0zyetsTuDyXp8eGXz3ixbNgdC5IUaXD2o5aSvttxNihKQr67HFP
         1iMYEcRBFclSEeSAWIugJylCoupCyOwDA6UFT7DSaQ0/nElcOuDQlF/nPU5ydpYg00uJ
         xR686Q1/vOIpwEuULedDQ9L7hHU3XO8hSGIKF448Yh1cpWa/xOueglnuqmhwIVXG2G4f
         r7Rg==
X-Gm-Message-State: AOAM532ZM9lha+jFaTP6pcGHmYh97m2w9BUXDE0Pl71kTtJsOZqxSGbi
        ZnDDI9+fbg3NtFmEVCaqcOuNxWgdA0pAfw==
X-Google-Smtp-Source: ABdhPJylKauHgi2kijUqa3Qi7OCYmSfpoDBWrqzaZtU0198wRUr3MU5zqNXJC2Trnn7DBm8Hz98GxQ==
X-Received: by 2002:aa7:cc0a:0:b0:413:a674:7d33 with SMTP id q10-20020aa7cc0a000000b00413a6747d33mr7968386edt.369.1646991166162;
        Fri, 11 Mar 2022 01:32:46 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bm23-20020a170906c05700b006d597fd51c6sm2772338ejb.145.2022.03.11.01.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 01:32:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSbdc-000ww8-UH;
        Fri, 11 Mar 2022 10:32:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v9 0/3] teach submodules to know they're submodules
Date:   Fri, 11 Mar 2022 10:09:50 +0100
References: <20220301002613.1459916-1-emilyshaffer@google.com>
 <20220310004423.2627181-1-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220310004423.2627181-1-emilyshaffer@google.com>
Message-ID: <220311.8635joj0lf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 09 2022, Emily Shaffer wrote:

> For the original cover letter, see
> https://lore.kernel.org/git/20210611225428.1208973-1-emilyshaffer%40google.com.
>
> CI run: https://github.com/nasamuffin/git/actions/runs/1954710601
>
> Since v8:
>
> Only a couple of minor fixes.
>
> Junio pointed out that I could write the tests better using --type=bool
> and 'test_cmp_config', and that we could be a little more careful about
> when to give up on 'git rev-parse --show-superproject-working-dir'.
>
> Glen mentioned that builtin/submodule--helper.c:run_update_procedure() is called
> unconditionally earlier in the same function where I had added the
> config in git-submodule.sh. So, I moved the config set into
> submodule--helper.c to reduce possible edge cases where the config might
> not be set.
>
> Otherwise, this series is pretty much unchanged.
>
> Since v7:
>
> Actually a fairly large rework. Rather than keeping the path from gitdir
> to gitdir, just keep a boolean under 'submodule.hasSuperproject'. The
> idea is that from this boolean, we can decide whether to traverse the
> filesystem looking for a superproject.
>
> Because this simplifies the implementation, I compressed the three
> middle commits into one. As proof-of-concept, I added a patch at the end
> to check for this boolean when running `git rev-parse
> --show-superproject-working-tree`.
>
> One thing I'm not sure about: in the tests, I check whether the config
> is set, but not what the boolean value of it is. Is there a better way
> to do that? For example, I could imagine someone deciding to set
> `submodule.hasSuperproject = false` and the tests would not function
> correctly in that case. I think we don't really normalize the value on a
> boolean config like that, so I didn't want to write a lot of comparison
> to check if the value is 1 or true or True or TRUE or Yes or .... Am I
> overthinking it?
>
> The other thing I'm not sure about: since it's just a bool, we're not
> restricted to setting this config only when we have both gitdir paths
> available. That makes me want to set the config any time we are doing
> something with submodules anyway, like any time 'git-submodule--helper'
> is used. But that helper seems to be called in the context of the
> superproject, not of the submodules, so adding this config for each
> submodule we touch would be a second child process. Is there some other
> common entry point for submodules that we can use?

I really don't mean to bring up the same points again, but I'm still
genuinely unsure what this is intended to solve in the end.

I.e. from the original RFC we went from it being for optimizations for
the shellscript "git rev-parse", to suggestions that the configured path
would be "canonical" in a way we couldn't discover on-the-fly (i.e. some
of Jonathan's noted edge cases [1]).

But now it's a boolean indicating "it's there, discover it", and the
implied (but not really explicitly stated) reason in 2/3 is that it's
purely for optimization purposes at this point.

But it's an optimization without a benchmark.

In [1] Jonathan (if I understood it correctly, see [2]) might have
suggested this is important to deal with some Google in-house NFS-a-like
auto-mounting software, i.e. the "walking up" is truly expensive in some
scenarios.

I do worry a bit that we'll be creating behavior edge cases related to
this, and if the problem being solved is for a relatively obscure setup
is it worth it, and in that case perhaps there should be a "I need this
optimization" setting guarding it?

But I don't know, a concrete case where this series makes a difference
would really help.

I tried to come up with one before[3] and all I could find was fleeting
cases we'd see go away with the migration of the remaining parts of
git-submodule.sh to C, which we already have in-flight patches for (or
rather, Glen is AFAIK at series 1/2 of submitting those, with 1/2
in-flight).

In any case I think lifting the bits of [3] where we assert that this
doesn't introduce any behavior change with a GIT_TEST_* knob would be
valuable.

I.e. as long a the intent isn't a behavior change let's test that
get_superproject_working_tree() doesn't need this across the entire test
suite, with specific tests that opt-in to the behavior (or do a whole
test suite run in that mode), rather than the default being
opt-out.

An opt-out is just a recipe for growing accidental implicit
dependencies, which explicitly isn't what we want for a "just an
optimization" knob. We do the same sort of opt-in/out-out testing for
e.g. split index, untracked cache etc (see the GIT_TEST_* bits in
ci/run-build-and-tests.sh). AFAICT a fix-up of just adding the
git_env_bool() here to this code in your 3/3 would do it:

	if (!git_env_bool("GIT_TEST_NO_SUBMODULE_HAS_SUPERPROJECT", 0) &&
	    !git_config_get_bool("submodule.hassuperproject", &has_superproject_cfg)
	    && !has_superproject_cfg)

And then adding GIT_TEST_NO_SUBMODULE_HAS_SUPERPROJECT=true to
linux-TEST-vars in ci/run-build-and-tests.sh. The tests that do rely on
submodule.hassuperproject would need to set
GIT_TEST_NO_SUBMODULE_HAS_SUPERPROJECT=false of course...

1. https://lore.kernel.org/git/YgF5V2Y0Btr8B4cd@google.com/
2. https://lore.kernel.org/git/220212.864k53yfws.gmgdl@evledraar.gmail.com/
3. https://lore.kernel.org/git/RFC-cover-0.2-00000000000-20211117T113134Z-avarab@gmail.com/
