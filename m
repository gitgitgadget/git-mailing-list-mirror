Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD6CC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 21:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiAGVsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 16:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiAGVsW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 16:48:22 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA21C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 13:48:22 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f8so6561756pgf.8
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 13:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cNzCbN9kLoOgIRVhw01yH+qRWE2U2XVcBaMuNwxG4xU=;
        b=peIaBWZVyKuBqXe/Eq6xPV9GVbdX6Mv00Rc9VlkAwDAIKeJCfGVLCtAW272C5RcJpR
         PtPtxrh+LrOt4K1NbJFvxtPsqwTn2z+si1Pr0e8mSGNQ/SzbOiYlSRM+WsWNWbA2RIly
         NQeCJmB8CWUVtCTPiD6hzloOo+FeTxwtfYxhVIgbXl8PbkhWRNCJap3R0/fE8lXXWzwY
         /oX3It3LN9WFGqNNx1BQhTC+xwHrZMqp8ihB1wIyDxDSfCDP9AimW9nvP7aTcjXpw3k/
         hh+4FSSVtsMUWVSe6XMt91ZT21YZQ4TdEShE99JThD9vAdjYK/l5emRage1Ika4Pz69J
         3+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cNzCbN9kLoOgIRVhw01yH+qRWE2U2XVcBaMuNwxG4xU=;
        b=72vqyRfcmqIuzUuPdWSHouuV5hY3LR3kf1mzxlMCvqPxeLGNCxrLkWt78r4q3SGSXW
         vs1jrdXwEuTqqnzhcDJjwRtxtRlTp7UWEhSGqIef0O4A4G+sZ6imxERzZgFWSoVjQ4y6
         XNXreju/5IN0oXdP+n0iZEjJr5LxW76+FCCtf0HJj1igrNZ3dvq+kQAVQr6hLLBDroQi
         rcm94Gxgr4TusF7R6vSZ8P8n307hCQj08aXpXX5lKc76ESrGIkKObUgQWG9i7ItmBXG8
         OeP771BVXjlYpXBsBMYaAB5qNXvR8YwU5zK9lT6oHAExg7ditjww6fFwXtjQ+vzbniK0
         R+yA==
X-Gm-Message-State: AOAM531prqVMBRPny8fu0WCuLxyGl6dt1NHWf9X5WGWrk5nYdSVKwMht
        ApyBE+7ka/tiAtp9skW5Q1l9DQ==
X-Google-Smtp-Source: ABdhPJzMW0TMfibBQq0iZCCUodudpQ48gw08dHo1Sq26la9a9VaU24YNaYcjU88WlHoBgPqLTRmjLw==
X-Received: by 2002:a63:6f08:: with SMTP id k8mr42915660pgc.51.1641592101850;
        Fri, 07 Jan 2022 13:48:21 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:3205:d63a:54aa:9c9d])
        by smtp.gmail.com with ESMTPSA id k19sm6877167pff.5.2022.01.07.13.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:48:21 -0800 (PST)
Date:   Fri, 7 Jan 2022 13:48:16 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 00/17] hook.[ch]: new library to run hooks + simple
 hook conversion
Message-ID: <Ydi1IHDE7PIybKmB@google.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
 <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 04:59:26AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> A trivial update to v5 to rebase it past conflicts with topics that
> recently landed on "master". For v5 see:
> https://lore.kernel.org/git/cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com/

One note, which is not so useful for this time, but might be useful in
the future:

It seems that in order to understand the purpose of this series and what
it's building for, you need to be me or be you (and therefore be aware
of the history of the series), or you need to go back through the
breadcrumbs and eventually read my huge config-based-hooks 30-patch
series (or at least the cover letter). Which sort of defeats the purpose
of splitting the series up into smaller reviewable chunks.

Next time it might be nice to add a quick summary of the whole goal,
which part of that goal this series is, and a link to the longer cover
letter/older series? But again, for this time, I think it is probably
too late, especially since this series looked pretty good to me.

Per-patch reviews to follow momentarily.

 - Emily

> 
> Emily Shaffer (14):
>   hook: add 'run' subcommand
>   gc: use hook library for pre-auto-gc hook
>   am: convert {pre,post}-applypatch to use hook.h
>   rebase: convert pre-rebase to use hook.h
>   am: convert applypatch-msg to use hook.h
>   merge: convert post-merge to use hook.h
>   hooks: convert non-worktree 'post-checkout' hook to hook library
>   hooks: convert worktree 'post-checkout' hook to hook library
>   send-email: use 'git hook run' for 'sendemail-validate'
>   git-p4: use 'git hook' to run hooks
>   commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>   read-cache: convert post-index-change to use hook.h
>   receive-pack: convert push-to-checkout hook to hook.h
>   run-command: remove old run_hook_{le,ve}() hook API
> 
> Ævar Arnfjörð Bjarmason (3):
>   hook API: add a run_hooks() wrapper
>   hook API: add a run_hooks_l() wrapper
>   git hook run: add an --ignore-missing flag
> 
>  .gitignore                 |   1 +
>  Documentation/git-hook.txt |  45 +++++++++++++
>  Documentation/githooks.txt |   4 ++
>  Makefile                   |   1 +
>  builtin.h                  |   1 +
>  builtin/am.c               |   6 +-
>  builtin/checkout.c         |   3 +-
>  builtin/clone.c            |   3 +-
>  builtin/gc.c               |   3 +-
>  builtin/hook.c             |  84 +++++++++++++++++++++++
>  builtin/merge.c            |   2 +-
>  builtin/rebase.c           |   3 +-
>  builtin/receive-pack.c     |   7 +-
>  builtin/worktree.c         |  26 +++----
>  command-list.txt           |   1 +
>  commit.c                   |  15 +++--
>  git-p4.py                  |  70 ++-----------------
>  git-send-email.perl        |  22 +++---
>  git.c                      |   1 +
>  hook.c                     | 131 ++++++++++++++++++++++++++++++++++++
>  hook.h                     |  57 ++++++++++++++++
>  read-cache.c               |   3 +-
>  reset.c                    |   3 +-
>  run-command.c              |  33 ---------
>  run-command.h              |  17 -----
>  t/t1800-hook.sh            | 134 +++++++++++++++++++++++++++++++++++++
>  t/t9001-send-email.sh      |   4 +-
>  27 files changed, 522 insertions(+), 158 deletions(-)
>  create mode 100644 Documentation/git-hook.txt
>  create mode 100644 builtin/hook.c
>  create mode 100755 t/t1800-hook.sh
> 
> Range-diff against v5:
>  1:  4ca52feebb8 =  1:  ba6fd47482e hook: add 'run' subcommand
>  2:  6275b97a306 =  2:  cfba5c139e7 hook API: add a run_hooks() wrapper
>  3:  b5b3051b2e5 =  3:  a4cca074bcb gc: use hook library for pre-auto-gc hook
>  4:  c88eb5d4c25 =  4:  ce57ce1adcb am: convert {pre,post}-applypatch to use hook.h
>  5:  1d8f7b7e4c1 =  5:  d6162fbef80 hook API: add a run_hooks_l() wrapper
>  6:  d49a1444345 =  6:  4c1a8951fc5 rebase: convert pre-rebase to use hook.h
>  7:  191fdad0165 =  7:  d8aa5e8345f am: convert applypatch-msg to use hook.h
>  8:  119b92fbeae =  8:  6f8d3754b4f merge: convert post-merge to use hook.h
>  9:  359ba416e84 !  9:  d3107034806 hooks: convert non-worktree 'post-checkout' hook to hook library
>     @@ builtin/checkout.c
>       #include "ll-merge.h"
>       #include "lockfile.h"
>       #include "merge-recursive.h"
>     -@@ builtin/checkout.c: struct branch_info {
>     +@@ builtin/checkout.c: static void branch_info_release(struct branch_info *info)
>       static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
>       			      int changed)
>       {
> 10:  b7599be95a7 ! 10:  bff7c1513ca hooks: convert worktree 'post-checkout' hook to hook library
>     @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
>      -		const char *hook = find_hook("post-checkout");
>      -		if (hook) {
>      -			const char *env[] = { "GIT_DIR", "GIT_WORK_TREE", NULL };
>     --			cp.git_cmd = 0;
>     +-			struct child_process cp = CHILD_PROCESS_INIT;
>      -			cp.no_stdin = 1;
>      -			cp.stdout_to_stderr = 1;
>      -			cp.dir = path;
>     --			cp.env = env;
>     --			cp.argv = NULL;
>     +-			strvec_pushv(&cp.env_array, env);
>      -			cp.trace2_hook_name = "post-checkout";
>      -			strvec_pushl(&cp.args, absolute_path(hook),
>      -				     oid_to_hex(null_oid()),
> 11:  f1c84d7f627 = 11:  7d9c0a73568 git hook run: add an --ignore-missing flag
> 12:  4e0f94d9102 = 12:  8ea3b250dff send-email: use 'git hook run' for 'sendemail-validate'
> 13:  e858f332a62 = 13:  a184afd1ffd git-p4: use 'git hook' to run hooks
> 14:  9a5956cc028 = 14:  1a43e50617f commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
> 15:  6fd47c4c499 = 15:  08b7e63ba5b read-cache: convert post-index-change to use hook.h
> 16:  b201ea46f4b = 16:  c47b36ab41a receive-pack: convert push-to-checkout hook to hook.h
> 17:  281d17b04db ! 17:  7b99a4b633c run-command: remove old run_hook_{le,ve}() hook API
>     @@ run-command.c: int async_with_fork(void)
>      -	strvec_push(&hook.args, p);
>      -	while ((p = va_arg(args, const char *)))
>      -		strvec_push(&hook.args, p);
>     --	hook.env = env;
>     +-	if (env)
>     +-		strvec_pushv(&hook.env_array, (const char **)env);
>      -	hook.no_stdin = 1;
>      -	hook.stdout_to_stderr = 1;
>      -	hook.trace2_hook_name = name;
> -- 
> 2.34.1.1146.gb52885e7c44
> 
