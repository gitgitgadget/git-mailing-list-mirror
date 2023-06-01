Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9043C7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 22:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjFAWkl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 18:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjFAWkj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 18:40:39 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49F6136
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 15:40:36 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b02cd4b829so9468905ad.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 15:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685659236; x=1688251236;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jrUY8Ju3bES4pT/bobCS+pTSzqEMsct/zOxv4J+903Y=;
        b=ptoJeiZ7VDT3E4CfhpjpbHYo+zClz8JaHd/FwzuoSfuCKJWLl2A5cAoQnjQw2Kiuop
         k2KXjjdsvv1qjhQRvjdW0NFep32O/8xGc3pJfLhSnu7NL45eRZxLR0/sO127npXbfD0O
         F8LNzsIDetddvq5lRjtABBYfqq4LT6LiR4hUizAFhR4UK1EHYGNveqto8r+e52XjbWzk
         hlXMy8DYcV4aPgLWhU00hi5efyy1BCD1U9yer8EuifxhEV4RgIgKp4dAb/Aa52Pv9ae4
         LgkKrq+6sqAtscI21MJh6lIfQ5xj94FTpRy8sbxtbcmE4OJXrUgIl9sl4TlUM0Dv1sUY
         7eNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685659236; x=1688251236;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrUY8Ju3bES4pT/bobCS+pTSzqEMsct/zOxv4J+903Y=;
        b=PHO26k4Vb/JsgwUXe6h/N1lpepNdmdeJRZXuPlkVv9tqxceUKjEocYcknlx1Co51KB
         2kcEDJCYlSYO92Viv0xX5XfFSp819D+BZy6yPJBXQveoROu/G8XkhB55Uc930AIre/P2
         C6cs01a2CykiRDKmp11JYGaMmT796BsGNYOXuvvFmdOleOZQpQK85dk8eZPgmlh+dTqW
         5iZUJNoO6b+z3PmZASpw/CUKjHFgIcPQPqsqhtlLtb8rXoKwBB1B0oouE0Mj1utkXWG+
         nWyP+LHCMjN8AFWZwmzE2TZbx7yZ/nPSieYD4M8qSwedkQPC8AnDdCWUORWpshNJEqCf
         Nndg==
X-Gm-Message-State: AC+VfDy7jT6ZBvxclMi4zvH0FpKVm5lP2Qyikb6qu1emQ067LPqBAMWV
        x8+cbHBPFLnsUHqKxivMIJEVi0bDF3lemw==
X-Google-Smtp-Source: ACHHUZ5BxfpNLYZf20SWFkQGnJHgLWbn+4uhC4pi8eCCIkyvJMKGdRimadSMAcfBHzGIcoWIq+3hmkb0XJrqig==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:903:93:b0:1a9:7f45:8711 with SMTP id
 o19-20020a170903009300b001a97f458711mr109108pld.6.1685659236333; Thu, 01 Jun
 2023 15:40:36 -0700 (PDT)
Date:   Thu, 01 Jun 2023 15:40:35 -0700
In-Reply-To: <CA+3o5aPQ3BkbAn3u6qSMCkAfNgTcpjT+_ikdqAkkc69NBGybpw@mail.gmail.com>
Mime-Version: 1.0
References: <CA+3o5aPQ3BkbAn3u6qSMCkAfNgTcpjT+_ikdqAkkc69NBGybpw@mail.gmail.com>
Message-ID: <kl6lzg5iztzw.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: git fetch recursion problem
From:   Glen Choo <chooglen@google.com>
To:     Fraser Hanson <fraser.hanson@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fraser Hanson <fraser.hanson@gmail.com> writes:

> The git trace output looks like this (some server names redacted):
>     $ export GIT_TRACE=1
>     $ git fetch
>     07:41:19.325652 git.c:439               trace: built-in: git fetch
>     07:41:19.330118 run-command.c:655       trace: run_command:
> GIT_DIR=.git git remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:19.337765 git.c:725               trace: exec:
> git-remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:19.338220 run-command.c:655       trace: run_command:
> git-remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:20.664527 run-command.c:655       trace: run_command: git -c
> fetch.negotiationAlgorithm=noop fetch origin --no-tags
> --no-write-fetch-head --recurse-submodules=no --filter=blob:none
> --stdin
>     07:41:20.679814 git.c:439               trace: built-in: git fetch
> origin --no-tags --no-write-fetch-head --recurse-submodules=no
> --filter=blob:none --stdin
>     07:41:20.681735 run-command.c:655       trace: run_command: git
> remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:20.692494 git.c:725               trace: exec:
> git-remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:20.693132 run-command.c:655       trace: run_command:
> git-remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:21.695677 run-command.c:655       trace: run_command: git -c
> fetch.negotiationAlgorithm=noop fetch origin --no-tags
> --no-write-fetch-head --recurse-submodules=no --filter=blob:none
> --stdin
>     07:41:21.715621 git.c:439               trace: built-in: git fetch
> origin --no-tags --no-write-fetch-head --recurse-submodules=no
> --filter=blob:none --stdin
>     07:41:21.717230 run-command.c:655       trace: run_command: git
> remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:21.727616 git.c:725               trace: exec:
> git-remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:21.728337 run-command.c:655       trace: run_command:
> git-remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:22.801117 run-command.c:655       trace: run_command: git -c
> fetch.negotiationAlgorithm=noop fetch origin --no-tags
> --no-write-fetch-head --recurse-submodules=no --filter=blob:none
> --stdin
>     07:41:22.816026 git.c:439               trace: built-in: git fetch
> origin --no-tags --no-write-fetch-head --recurse-submodules=no
> --filter=blob:none --stdin
>     07:41:22.817972 run-command.c:655       trace: run_command: git
> remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:22.828436 git.c:725               trace: exec:
> git-remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:22.829219 run-command.c:655       trace: run_command:
> git-remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:24.242220 run-command.c:655       trace: run_command: git -c
> fetch.negotiationAlgorithm=noop fetch origin --no-tags
> --no-write-fetch-head --recurse-submodules=no --filter=blob:none
> --stdin
>     07:41:24.257211 git.c:439               trace: built-in: git fetch
> origin --no-tags --no-write-fetch-head --recurse-submodules=no
> --filter=blob:none --stdin
>     07:41:24.259264 run-command.c:655       trace: run_command: git
> remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:24.269718 git.c:725               trace: exec:
> git-remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:24.270612 run-command.c:655       trace: run_command:
> git-remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:25.306129 run-command.c:655       trace: run_command: git -c
> fetch.negotiationAlgorithm=noop fetch origin --no-tags
> --no-write-fetch-head --recurse-submodules=no --filter=blob:none
> --stdin
>     07:41:25.320842 git.c:439               trace: built-in: git fetch
> origin --no-tags --no-write-fetch-head --recurse-submodules=no
> --filter=blob:none --stdin
>     07:41:25.322801 run-command.c:655       trace: run_command: git
> remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:25.332775 git.c:725               trace: exec:
> git-remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:25.333522 run-command.c:655       trace: run_command:
> git-remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:26.332580 run-command.c:655       trace: run_command: git -c
> fetch.negotiationAlgorithm=noop fetch origin --no-tags
> --no-write-fetch-head --recurse-submodules=no --filter=blob:none
> --stdin
>     07:41:26.348349 git.c:439               trace: built-in: git fetch
> origin --no-tags --no-write-fetch-head --recurse-submodules=no
> --filter=blob:none --stdin
>     07:41:26.350225 run-command.c:655       trace: run_command: git
> remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:26.361171 git.c:725               trace: exec:
> git-remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:26.361969 run-command.c:655       trace: run_command:
> git-remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:27.585641 run-command.c:655       trace: run_command: git -c
> fetch.negotiationAlgorithm=noop fetch origin --no-tags
> --no-write-fetch-head --recurse-submodules=no --filter=blob:none
> --stdin
>     07:41:27.600316 git.c:439               trace: built-in: git fetch
> origin --no-tags --no-write-fetch-head --recurse-submodules=no
> --filter=blob:none --stdin
>     07:41:27.602370 run-command.c:655       trace: run_command: git
> remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:27.611823 git.c:725               trace: exec:
> git-remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:27.612607 run-command.c:655       trace: run_command:
> git-remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:28.666477 run-command.c:655       trace: run_command: git -c
> fetch.negotiationAlgorithm=noop fetch origin --no-tags
> --no-write-fetch-head --recurse-submodules=no --filter=blob:none
> --stdin
>     07:41:28.678956 git.c:439               trace: built-in: git fetch
> origin --no-tags --no-write-fetch-head --recurse-submodules=no
> --filter=blob:none --stdin
>     07:41:28.680665 run-command.c:655       trace: run_command: git
> remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:28.690534 git.c:725               trace: exec:
> git-remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:41:28.691277 run-command.c:655       trace: run_command:
> git-remote-https origin
> https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
>     ^C
>
>
> Random clues and experiments:
>
> A `git clone` from our corporate mirrors always succeeds.  Immediately
> after a `git clone`, I am always able to `git fetch`, so far.
> Something else must cause the repository to enter a broken state,
> possibly the addition of upstream commits.  I can't verify that since
> I can't complete `git fetch.`
>
> I can fix a broken repository by deleting these settings from `.git/config`:
>         promisor = true
>         partialclonefilter = blob:none
> After this, `git fetch` succeeds.
> Deleting just one of these settings is not sufficient, it must be both.
>
> I copied one such broken repository out of our secure environment onto
> a mac laptop that has access to both our mirror sites and to the
> internet.
> I verified that `git fetch` from our mirror is still broken on the mac.
> Then I modified .git/config to point to the https://github.com/ url
> instead of our mirror site, leaving the 'promisor' and
> 'partialclonefilter' settings in place.
> Running `git fetch` in this state succeeded.
>
> This suggests that our internal mirror site is returning something
> different from github itself.
>
>
> Here is the trace from successfully fetching from github.com:
>     $ git fetch
>     07:43:30.901275 git.c:439               trace: built-in: git fetch
>     07:43:30.904188 run-command.c:655       trace: run_command:
> GIT_DIR=.git git remote-https origin
> https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:43:30.917345 git.c:725               trace: exec:
> git-remote-https origin
> https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git
>     07:43:30.918560 run-command.c:655       trace: run_command:
> git-remote-https origin
> https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git
>     remote: Enumerating objects: 8, done.
>     remote: Counting objects: 100% (8/8), done.
>     remote: Compressing objects: 100% (5/5), done.
>     07:43:31.714337 run-command.c:655       trace: run_command: git
> index-pack --stdin -v --fix-thin --promisor --pack_header=2,8
>     remote: Total 8 (delta 2), reused 5 (delta 1), pack-reused 0
>     07:43:31.729793 git.c:439               trace: built-in: git
> index-pack --stdin -v --fix-thin --promisor --pack_header=2,8
>     Receiving objects: 100% (8/8), 3.36 KiB | 3.36 MiB/s, done.
>     Resolving deltas: 100% (2/2), completed with 1 local object.
>     07:43:31.738815 run-command.c:655       trace: run_command: git
> rev-list --objects --stdin --exclude-promisor-objects --not --all
> --quiet --alternate-refs
>     07:43:31.748286 git.c:439               trace: built-in: git
> rev-list --objects --stdin --exclude-promisor-objects --not --all
> --quiet --alternate-refs
>     From https://github.com/nvim-treesitter/nvim-treesitter-textobjects
>        9c5237b..95b76b9  master        -> origin/master
>        9c5237b..11ae4c7  update-readme -> origin/update-readme
>     07:43:31.757504 run-command.c:1524      run_processes_parallel:
> preparing to run up to 1 tasks
>     07:43:31.757515 run-command.c:1551      run_processes_parallel: done
>     07:43:31.757522 run-command.c:655       trace: run_command: git
> maintenance run --auto --no-quiet
>     07:43:31.765282 git.c:439               trace: built-in: git
> maintenance run --auto --no-quiet
>
> The difference starts just a few lines in, my failed fetches never see this:
>     remote: Counting objects: 100% (8/8), done.
>     remote: Compressing objects: 100% (5/
>
> Next I enabled both GIT_TRACE and GIT_CURL_VERBOSE to identify
> differences in the HTTP conversation between a failed fetch versus a
> successful one.
> The successful run was made by deleting the `promisor` and
> `partialclonefilter` settings from .git/config.
> I'm having some some trouble attaching these to this email, I'll have
> to include them in a follow up.

This looks a lot like the partial clone fetch is recursing infinitely.
This could happen if Git encountered a missing object, initiated a
partial clone fetch to get the missing object, then in the process of
that fetch it encountered a missing object, initiated a partial clone
fetch to get the missing object, then (etc etc etc).

I don't have good clues as to why that might be the case though.

Wild speculation: Does this reproduce if you clone without submodules,
or if you pass --no-recurse-submodules to "git fetch"? In a non-partial
clone fetch, "git fetch" may read .gitmodules to get submodule
information. Perhaps something similar is happening in the partial clone
fetch.
