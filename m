Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA79C433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 04:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346826AbiBHEOy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 23:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346775AbiBHEOp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 23:14:45 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6499BC0401F2
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 20:14:43 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id f17so17622316edd.2
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 20:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bi9NFDMMwYTXbcfrd0udEAy4D9Mt21I4+/7fOi4KUMI=;
        b=n0SSEjyaJW0jTZOEhx1+NtU5UDl7TYWklxzgGMkWB6C1Ukg66Kdi7+gMIcxeFNVed2
         pWlta3LnYM/9iPOUfWf8mbd9Z8Ptu7RKljly39mtRtmFM7/Mn7MVZGVgJ0AaLxx/7SRq
         P0GnReII0fyFywhFi8T6Hwld5Ug6YLmllxJhTUDpUaFJgbUTurcNa9Zs4mkFgdqoS4LH
         Rh0+bbKb1gfudRzElf0XRzUPlmH0Ve49Z8IsviC2iqzxLUdJHEMhYzfijkYBUUxELLLo
         wvhj5EGzAqjOUBepDmBRiUEqcIxYTyVy+O99rxHH+r1OK1e56Sep5yGV5dqpEqQlqXHe
         pOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bi9NFDMMwYTXbcfrd0udEAy4D9Mt21I4+/7fOi4KUMI=;
        b=cpsMavsYBGhtL3vgAUpVM3ku6OOijBWVud0hLJckC1nDirLqbDGM35IadHPfnF7uDP
         epEW3XpjWFVPqiH77xogg/5+oulotSLza55RVdrDd5+ibfBfa5+d+McBOONz2e8Oj9s7
         a0I1MOHRW941D/4GxHIL4NTO+uR04xZKLN7vyD7/N1uyKOErw1j1tRgm58V3zpyGyJrz
         jqFS/GJzU3JCSpB+aYcvslyq2ALDJ6EQjB+AtSFPd5jEcmPMEoDf4vgGAiEBLfEg3TQr
         UqOpus6Rome4nrkzGjH1eXIJBKv9WK9iPtktrhO06wyFr0jyLbo13T24CHeWDFMzTBG4
         IX+A==
X-Gm-Message-State: AOAM532N7cTx1hC1touhF/M9crKV9qQXiNN8TkmHGGHBCDJYG9RUWq8u
        HXs089atQJPYWWHgLp6h1s9Yxgjd+V3t8WH6uZ4=
X-Google-Smtp-Source: ABdhPJxOKJj6WdD+FO2HTDen23SGMqya5MEAeKu4TrOJKRSf4vC3+1U+FJB812UaRcFRBpkImXgmTi+tfkE8cuxqqCA=
X-Received: by 2002:aa7:da84:: with SMTP id q4mr2609297eds.380.1644293681756;
 Mon, 07 Feb 2022 20:14:41 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com> <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 7 Feb 2022 20:14:29 -0800
Message-ID: <CABPp-BG4m6i+yobjnD6UC5S5n3k-HbB7Y5uUNEvrD79ErOoYHg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Sparse checkout: fix bug with worktree of bare repo
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 7, 2022 at 1:33 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series is now based on v2.35.0 since that contains all of the necessary
> topics.
>
> This patch series includes a fix to the bug reported by Sean Allred [1] and
> diagnosed by Eric Sunshine [2].
>
> The root cause is that 'git sparse-checkout init' writes to the worktree
> config without checking that core.bare or core.worktree are set in the
> common config file. This series fixes this, but also puts in place some
> helpers to prevent this from happening in the future.
>
> ATTENTION: I have significantly redesigned the series since previous
> versions, so most of this cover letter is new.
>
>  * Patch 1 updates documentation around extensions.worktreeConfig in a few
>    places to improve discoverability. Several cross links are added to make
>    it easy to find the related areas. (The documentation for the changes to
>    'git sparse-checkout' are delayed to patch 4.)
>
>  * Patch 2 introduces the init_worktree_config() helper which follows the
>    documented instructions to enable extensions.worktreeConfig as well as
>    move the core.bare and core.worktree config values. This update does not
>    modify core.repositoryFormatVersion, since this is not needed
>    specifically for extensions.worktreeConfig.
>
>  * Patch 3 adds a new repo_config_set_worktree_gently() helper method so we
>    can internally adjust a config value within a worktree, at least if
>    extensions.worktreeConfig is enabled. (It will write to the common config
>    file if the extension is not enabled.)
>
>  * Patch 4 modifies the sparse-checkout builtin to use
>    init_worktree_config() and repo_config_set_worktree_gently() in ways that
>    fix the reported bug. The behavior change here is that it will no longer
>    upgrade the repository format version, since that is not needed for
>    extensions.worktreeConfig.
>
>  * Patch 5 updates 'git worktree add' to copy the worktree config from the
>    current worktree to the new one (while unsetting core.bare=true and
>    core.worktree=*) along with copying the sparse-checkout patterns file.
>
> [1]
> https://lore.kernel.org/git/CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com/
> [2]
> https://lore.kernel.org/git/CAPig+cQ6U_yFw-X2OWrizB1rbCvc4bNxuSzKFzmoLNnm0GH8Eg@mail.gmail.com/
>
>
> Updates in v6
> =============
>
>  * Updated documentation to use "working tree" over "worktree" and "" over
>    ""

Not sure what "" over "" means.

>  * Delay some allocations to avoid leaking memory in error conditions.
>  * Use "main worktree" over "base worktree" in comments.
>  *

Was the empty bullet point meant to cover the new patch 6?  Anyway,
comments on the cover letter aside, the patches themselves are:

Reviewed-by: Elijah Newren <newren@gmail.com>
