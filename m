Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B63DC48BCF
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 20:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03BB6101A
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 20:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFLUQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 16:16:25 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:37792 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLUQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 16:16:25 -0400
Received: by mail-vs1-f52.google.com with SMTP id f21so5732870vsl.4
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 13:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VR21EyPjNMIQTn8nCusQKWKooH1k0RgT101aCFBwhik=;
        b=qEVfUP9Cj2+h//eNQoVAd5iVdLSQ547IstwtkpCrbhrzEJZsbvP+7qduaAYwssBmVV
         +GALyofZ++wlmto+JKCTi3JQOMLVZ6/tzWIzjFkNE7YuizutUDGOp5JxYAFNqBkjTNFX
         A+XauNDcClEJu0OBQepRAMNDKjqQUHvTIHZc8bjhqa6FLXxxaIeUMnenvNB+TcNqvd/v
         fzx/xAPPlcE6YD+5fIEdljeq4cmGaGrWJegWkAgU4JnF45WFgiiXVtNS216z+hoimDF4
         jEy2s3Yr/w+6M1lTmtY9FEYZeLPut5rJA9F5Tsn+c5McKpva0lDAmyW1nX5/0pUDkJSE
         b46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VR21EyPjNMIQTn8nCusQKWKooH1k0RgT101aCFBwhik=;
        b=qxxONmI1BgQyqU/yQxIq0zxQTmuFhp03Ta4Qh7aL1YLrVoXm84CW7lwHsimJ/DltFV
         JhOl3LoAlyJLmezMEap62caZLegadMEywd8Uz4Txd0brhkKtiZFzeegBo3QjlWalCdxK
         EX0wVzOmZEyp/VaCJUoz6d3EL2WuB71jPCjcOP1oTv/rdX5l53sJghYUXyro7iU3F8ap
         P1tFAqSEbiGKeKIsbCVRq6QbQLEBLrrbpDPDw4nbHwPeAnAM3ZYd5zh7UBxNzjQjHOjw
         mfzUYO/pCu91zXxwHCVlAKkelJcQBbPSokPkzuCtAQfzkBg4GdYz3yGIH+ITK89If4Ss
         K2KA==
X-Gm-Message-State: AOAM5329u4WyJIh1h1WGSTJGfbioSuVHCux0JpzXhYBRS8orBOvUoszb
        OnzFah2DFkhowC5l3AGaDUBKNsHAF8A2SL/yibE=
X-Google-Smtp-Source: ABdhPJyPfQJcmzXG0lcW6gINcpQ/FTXeYQhQMjQ6WpXGGhUPih7qQNzvsy4Otd9H1MwY6BEAR1QEL0yWY5tuO2veoNs=
X-Received: by 2002:a05:6102:243c:: with SMTP id l28mr1908511vsi.27.1623528789109;
 Sat, 12 Jun 2021 13:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210611225428.1208973-1-emilyshaffer@google.com>
In-Reply-To: <20210611225428.1208973-1-emilyshaffer@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 12 Jun 2021 13:12:58 -0700
Message-ID: <CA+P7+xp5NNb6zz1LkQrv_A3Ny41WE=-h2-9VswyL_qzwFdyifw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] cache parent project's gitdir in submodules
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 11, 2021 at 3:54 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> It's necessary for a superproject to know which submodules it contains.
> However, historically submodules do not know they are anything but a
> normal single-repo Git project (or a superproject, in nested-submodules
> cases). This decision does help prevent us from having to support
> divergent behaviors in submodule projects vs. superprojects, which makes
> sure Git is (somewhat) less confusing for the reader, and helps simplify
> our code.
>
> One could imagine, though, some conveniences we could gain from
> submodules learning added behavior (though not necessarily *different*
> behavior) to provide more context about the state of the project as a
> whole, and to make large submodule-based projects easier to work with.
> One example is a series[1] I sent some time ago, adding a config to be
> shared between the superproject and all its submodules. The RFC[2] I
> sent around the same time mentions a few other examples, such as "git
> status" run in the submodule noticing whether the superproject has a
> commit referencing the submodule's current HEAD.
>
> It's expensive and non-definitive to try and guess whether or not the
> current repo is a submodule. submodule.c:get_superproject_working_tree()
> does so by essentially running 'git -C .. ls-files -- <own-path>',
> invoking an additional process. get_superproject_working_tree() is not
> called often, so that's mostly fine. However, [1] attempted to include
> an additional config located in the superproject's gitdir by running
> 'git -C .. rev-parse --git-dir' during startup - a little expensive in
> the best case, because it's an extra process, but extremely expensive in
> the case when the current repo is *not* a submodule, because we hunt all
> the way up the filesystem looking for a '.git'. Adding that cost to
> every startup is infeasible.
>

It also adds cost for no benefit to the normal case where it's not a
submodule. The cost added for non-submodules ought to be as near-zero
as possible.

> To that end, in this series I propose caching a path to the
> superproject's gitdir - by having the superproject write that relative
> path to the submodule's config on creation or update. The goal here is
> *not* to say "If I am a submodule, I must have
> submodule.superprojectGitDir set" - but instead to say "If I have
> submodule.superprojectGitDir set, then I must be a submodule." That is,
> I expect we will find edge cases where a submodule was introduced in
> some interesting way that bypassed any of the patches below, and
> therefore doesn't have the superproject's gitdir cached.
>
> The combination of these two rules:
>  - Anything relying on submodule.superprojectGitDir must be nice to
>    have, but not essential, because
>  - It's possible for a submodule to be valid without having
>    submodule.superprojectGitDir set
> makes me feel more comfortable with the idea of submodules learning
> additional behavior based on this config. I feel pretty unconfident in
> our ability to ensure that *every* submodule has this config set.
>

I think this is a good direction. I do think having some information
about being a submodule could be very useful for tools such as git
status, and making it more of a "if we know for sure, we get some
small benefit, but if we don't know then it's no harm" is a good
direction.

> The series covers a few paths for introducing that config, which I'm
> hoping covers most cases.
>  - "git submodule update" (which seems to be part of the "git submodule
>    init" flow)
>  - "git submodule absorbgitdir" to convert a "git init"'d repo into a
>    submodule
>
> Notably, we can only really set this config when 'the_repository' is the
> superproject - that appears to be the only time when we know the gitdirs
> of both the superproject and the submodule.

We could also presumably add a new command for setting this?

>
> I'm expecting folks may have a lot to say about this, so I look forward
> to discussion :)
>
>  - Emily
>
> 1: https://lore.kernel.org/git/20210423001539.4059524-1-emilyshaffer@google.com
> 2: https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com
>
> Emily Shaffer (4):
>   t7400-submodule-basic: modernize inspect() helper
>   introduce submodule.superprojectGitDir cache
>   submodule: cache superproject gitdir during absorbgitdirs
>   submodule: cache superproject gitdir during 'update'
>
>  builtin/submodule--helper.c        |  4 +++
>  git-submodule.sh                   |  9 ++++++
>  submodule.c                        | 10 ++++++
>  t/t7400-submodule-basic.sh         | 49 ++++++++++++++----------------
>  t/t7406-submodule-update.sh        | 10 ++++++
>  t/t7412-submodule-absorbgitdirs.sh |  1 +
>  6 files changed, 57 insertions(+), 26 deletions(-)
>
> --
> 2.32.0.272.g935e593368-goog
>
