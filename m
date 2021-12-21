Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEFCC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 05:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhLUF7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 00:59:54 -0500
Received: from mail-pg1-f177.google.com ([209.85.215.177]:37481 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbhLUF7x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 00:59:53 -0500
Received: by mail-pg1-f177.google.com with SMTP id a23so11400186pgm.4
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 21:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gUi4KIkbPyh9S2UqBhxHz4InFBI9scdtN3MFeUDj1oA=;
        b=LD6Uhm1MktdfBa3VzO9WHZ/VjeqbQh/RaQaALrqfbnXXP5k01wjRtQMhgt1HIOZG5s
         zKnGUbzwEdeqFJHm0aCP4C0EQShFrh/Gzg/KWURt8RFF/VTvQZLseuPsWmLGEBMFh38W
         rderdLddIM4lPKDMxtbfjrglKNkU1epYsI/MF+mzFuzYByjQLyZ7aHlGdj9/HP3bkviT
         8Nsr9zN0g9UlmVtuCt8pahlH5EpwMe++r333a+PMqFCp+WdgwBJ2QHBB4CAEL+znaq2D
         0liS8+ikzWs5BfwdiLqAuFwNBZRe+1xrQiotG4iazNVPbqF4nxfSDPGG0hEvK/J52+Ab
         UDow==
X-Gm-Message-State: AOAM531bGOWkgoTmmJ3DAknBlyyfaVolfblwPhy1Vb1p94iOu/BLNs2l
        2/3NTBrMEyqD+H6mgwJunZBgQpxRgI2jIO45xGc=
X-Google-Smtp-Source: ABdhPJzXKw352nWlAqMjUGE1bgvPlfaJaFNsnbd6RTV6ZhZnYc3xHiGsdn0mRdKnEdfkvL8l4G0TWuMhcKLdVRBrY0o=
X-Received: by 2002:a63:380e:: with SMTP id f14mr1558292pga.227.1640066392881;
 Mon, 20 Dec 2021 21:59:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <67993f6cff254d341ba4ad7fe7709b57eb3e74d4.1640015844.git.gitgitgadget@gmail.com>
 <6d72a020-ded7-6ef2-825c-ce6421194b26@gmail.com> <CAPig+cTuLYFc9fpAe8Uq9fvBYuSGcc9SA1O-q1BRw0DYxDF4Eg@mail.gmail.com>
In-Reply-To: <CAPig+cTuLYFc9fpAe8Uq9fvBYuSGcc9SA1O-q1BRw0DYxDF4Eg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Dec 2021 00:59:42 -0500
Message-ID: <CAPig+cT7bf7yyO-BpobSgHiXk703sPEa3n-toNMUG=ixjUqCsw@mail.gmail.com>
Subject: Re: [PATCH 3/4] config: add repo_config_set_worktree_gently()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 20, 2021 at 7:01 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> Regarding the actual "fix": we want a new utility function which
> enables per-worktree configuration and handles all the required
> bookkeeping actions described in git-worktree.txt. Specifically, if
> per-worktree configuration is not already enabled, the function will
> need to:
>
> (1) set `extensions.worktreeConfig=true` in .git/config
>
> (1) relocate `core.bare` from .git/config to .git/config.worktree if
> that key exists
>
> (2) relocate `core.worktree` from .git/config to .git/config.worktree
> if that key exists

A couple additional notes:

First, I can't count to three.

Second, item (0) in the above list would be to upgrade the repository
to version 1 since that's a prerequisite of using `extensions` (which
you know already, but I want to be clear for any other readers that
the new utility function should perform this step, as well).
