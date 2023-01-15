Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB94C3DA78
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 09:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjAOJcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 04:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjAOJb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 04:31:59 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD8D9017
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 01:31:56 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id s3so16485033pfd.12
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 01:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Veb+qZD4PjLnPgx5NtqXK8JHyP9oCSxfRzQjNhNYGlQ=;
        b=fF1ETUOhZQX1kdJlJvh5zw/vvEctZwoJvGjVJggKBBtshbabKfLt5i8b3R5B6TDsdD
         +Mnlm1F9XS+rZb0R2YhkiQrtSpYPryZn6nM5EwoIXIRxHC/SsCXZrOTyFpK/FKF/EPQo
         k9+gg0om6Plia4nLstCt3uLEz5q1w5z2ERTB4lY+ugISwFJI1sTgeCf8h16YoPSTsSiR
         wAWco6U4hMwkpImc9XqJPQ5IzVsw5sQeu3bfJcdTBHMf2EGwX7zy4ksZsQEBeCKTQihR
         ARaHQJDpCPOEUcPDccmzTr3ESVUlaPIuZmQj5W/BwgwqMdQDMNiBpTqyiXUauvQLeOBi
         6k8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Veb+qZD4PjLnPgx5NtqXK8JHyP9oCSxfRzQjNhNYGlQ=;
        b=BbcKTHWfeqfpYE8MUp5huX+TjtP4SpE+xZd9b3LmmDWUzMIxDLmoNPlYn5cPz1VJ1l
         0IvSNF16hq0Uhpg1d8WswhEvb6SPqEvbaDgIzaw9azEbnUp7m3aYtPNxtQlUr1ioG5kK
         Xl1C2ayClZaexxhSEBGwBgYoix+eq3GbsnUvHgEi+lPRCZKVUOKUZRyKs9w5e+2tayfi
         9/i6acHSowISF6FcK4jTEyV+RKAUuE80knnOXn++Rv8i8NTOAVk4CV9BBDYO1u8CwZkv
         WZUoufDvKWASm/j47RvJpRmBmwS1KIew/6lxi6KAo5hHS8zwagcHKA8LDAmwcaBDmS6X
         eygw==
X-Gm-Message-State: AFqh2kqT5ZXpwY+Nu7PKmqrW+QIrqA/l2/cRj+h2AXSf5/7k0fVjrvHF
        z8yyLkR5Lr17ReiaSdHF0ghstA5OkWM=
X-Google-Smtp-Source: AMrXdXsdqXC2S7I3Yyi8S6w9mJs6HJApx8sPDm0TOaVXXwbqop60e7L232DAWAAF4htJGFGuWiLHCw==
X-Received: by 2002:a05:6a00:44c4:b0:58d:97cd:b65a with SMTP id cv4-20020a056a0044c400b0058d97cdb65amr1805916pfb.26.1673775116209;
        Sun, 15 Jan 2023 01:31:56 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g8-20020aa79f08000000b0058d928374f2sm1069823pfr.20.2023.01.15.01.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 01:31:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com, myriamanis@google.com
Subject: Re: [PATCH v4 0/5] submodule: parallelize diff
References: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
        <20221108184200.2813458-1-calvinwan@google.com>
Date:   Sun, 15 Jan 2023 01:31:55 -0800
Message-ID: <xmqqv8l8f8j8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Original cover letter for context:
> https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/
> ...
> Calvin Wan (5):
>   run-command: add duplicate_output_fn to run_processes_parallel_opts
>   submodule: strbuf variable rename
>   submodule: move status parsing into function
>   diff-lib: refactor match_stat_with_submodule
>   diff-lib: parallelize run_diff_files for submodules
>
>  Documentation/config/submodule.txt |  12 ++
>  diff-lib.c                         | 103 +++++++++++--
>  run-command.c                      |  13 +-
>  run-command.h                      |  24 +++
>  submodule.c                        | 229 +++++++++++++++++++++++++----
>  submodule.h                        |   9 ++
>  t/helper/test-run-command.c        |  21 +++
>  t/t0061-run-command.sh             |  39 +++++
>  t/t4027-diff-submodule.sh          |  19 +++
>  t/t7506-status-submodule.sh        |  19 +++
>  10 files changed, 441 insertions(+), 47 deletions(-)

While the topic is marked as "Needs review" in the recent "What's
cooking" reports, merging this topic also breaks the "linux-leaks"
job by causing many tests fail:

    t3040-subprojects-basic.sh
    t4010-diff-pathspec.sh
    t4015-diff-whitespace.sh
    t4027-diff-submodule.sh
    t7403-submodule-sync.sh
    t7409-submodule-detached-work-tree.sh
    t7416-submodule-dash-url.sh
    t7450-bad-git-dotfiles.sh
    t7506-status-submodule.sh

Two of the test scripts are touched by this topic, and their
breakage could be caused by newly using other git subcommands that
were known to be leaking (iow, not because this series introduced
new leaks). It also is possible that they fail because this series
added new leaks to the commands these two test scripts use.  In
either case, other tests that haven't been touched by this topic
were definitely broken by new leaks introduced by the changes made
by this series.

Anybody interested should be able to see the breakage themselves by
checking out 'seen' and running

    SANTIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=true \
    make test

to see the tree with all in-flight topics are clean, and then by
running the same test after merging this topic to 'seen'.

Thanks.
