Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF732C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 21:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjAQVHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 16:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjAQVFb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 16:05:31 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FC96C550
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:31:49 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 188so35355138ybi.9
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NpZyOV/1AEVFazFNDkmt1+ytFRV+RN3hiUGt8f37O3A=;
        b=dOR7RXSXPKO4a8eocfSzSf0bJNVXxxx2UYhZw58rEuEl4kV2NsY4ZdRsQZZgs6sh8f
         RMsdrWhoGOrbka0+S183+kpB6QIagLHZGDFSVtvuaYEYZ41xg1qRrArRoYaEpUCsScv3
         Wv78EPeS2ng/MPiUNogj/AIx1VuUlJSXUbwqa2usPdv2vFYX8yYz1g2Yy6gnW22DRE0H
         Lx55oNoEsx1K93yVJYbWrtJGlxvaUcFyIMH9L1j3/2Zw0awKREHP/JdtWOpnxQnZI6tK
         VsvchnpjoX4TLfct5Xl12bRh5e2hFISS/P5qhY44Uy6wZ7MPyB3Hg3gKtAVi50spzH6A
         G0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpZyOV/1AEVFazFNDkmt1+ytFRV+RN3hiUGt8f37O3A=;
        b=MaQdFZvPZciV40IF+sQS7vevmg26S5hSYSx68mDVBENayAL5LS88nobcpeKQm/Oxz4
         btI3aoPnDz2fok4nx4m1KSL0e2Ig3AEfekX+SiI2e+vhKtBKwAss9Smv4jyvr4aRwCBg
         09qCfGkt8qiCvJp/VwjLvV4vgLTrWXDphbhJCcqH2HEGdvdwoQpHsoBNiJeZpE4K9Qou
         AX389haFCcVDKTlajEI/36zeNQezL7jiWSbZK5lnPuEwuokSHlv0mKQIGc3aTW/AI159
         0OM1Jar1n0DyVceVaugKabVsMwX0ThVnEsx6z1G696v42GIFPwqwwrTNekKzWMVwECtC
         4+Gw==
X-Gm-Message-State: AFqh2kooIa3K/rKm8sQKKQDMnrkM0bKKKGx/GzjoGHl8/m7dg647Adh9
        F9O+HLsJusacHO8NEzSiTY7w2YnJ9VoXC9D6mrNbIQ==
X-Google-Smtp-Source: AMrXdXvvnqLhA3Ogc54iz6/lYNsJ+3qeRRHtNFoAe9HcF50U6oKuWdWS2d3BfH/N0f8bGWD9Ocp2/+3sx0m+1UYTAr4=
X-Received: by 2002:a25:5f50:0:b0:7bc:7e3f:7cc4 with SMTP id
 h16-20020a255f50000000b007bc7e3f7cc4mr628368ybm.391.1673983908787; Tue, 17
 Jan 2023 11:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20221108184200.2813458-1-calvinwan@google.com> <xmqqv8l8f8j8.fsf@gitster.g>
In-Reply-To: <xmqqv8l8f8j8.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 17 Jan 2023 11:31:37 -0800
Message-ID: <CAFySSZC9XpCLjh7jCSNvixXhfrfGHpVr_coqHrKAXZbYzoT+5w@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] submodule: parallelize diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com, myriamanis@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

I've sent out a reroll to fix this. Thanks!

Passing leaks CI at:
https://github.com/calvin-wan-google/git/actions/runs/3942292098
(linux-musl technically failed, but it looks like for other reasons)


On Sun, Jan 15, 2023 at 1:31 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > Original cover letter for context:
> > https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/
> > ...
> > Calvin Wan (5):
> >   run-command: add duplicate_output_fn to run_processes_parallel_opts
> >   submodule: strbuf variable rename
> >   submodule: move status parsing into function
> >   diff-lib: refactor match_stat_with_submodule
> >   diff-lib: parallelize run_diff_files for submodules
> >
> >  Documentation/config/submodule.txt |  12 ++
> >  diff-lib.c                         | 103 +++++++++++--
> >  run-command.c                      |  13 +-
> >  run-command.h                      |  24 +++
> >  submodule.c                        | 229 +++++++++++++++++++++++++----
> >  submodule.h                        |   9 ++
> >  t/helper/test-run-command.c        |  21 +++
> >  t/t0061-run-command.sh             |  39 +++++
> >  t/t4027-diff-submodule.sh          |  19 +++
> >  t/t7506-status-submodule.sh        |  19 +++
> >  10 files changed, 441 insertions(+), 47 deletions(-)
>
> While the topic is marked as "Needs review" in the recent "What's
> cooking" reports, merging this topic also breaks the "linux-leaks"
> job by causing many tests fail:
>
>     t3040-subprojects-basic.sh
>     t4010-diff-pathspec.sh
>     t4015-diff-whitespace.sh
>     t4027-diff-submodule.sh
>     t7403-submodule-sync.sh
>     t7409-submodule-detached-work-tree.sh
>     t7416-submodule-dash-url.sh
>     t7450-bad-git-dotfiles.sh
>     t7506-status-submodule.sh
>
> Two of the test scripts are touched by this topic, and their
> breakage could be caused by newly using other git subcommands that
> were known to be leaking (iow, not because this series introduced
> new leaks). It also is possible that they fail because this series
> added new leaks to the commands these two test scripts use.  In
> either case, other tests that haven't been touched by this topic
> were definitely broken by new leaks introduced by the changes made
> by this series.
>
> Anybody interested should be able to see the breakage themselves by
> checking out 'seen' and running
>
>     SANTIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=true \
>     make test
>
> to see the tree with all in-flight topics are clean, and then by
> running the same test after merging this topic to 'seen'.
>
> Thanks.
