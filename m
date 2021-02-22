Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43E1C433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 18:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB9C64E20
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 18:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhBVS6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 13:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhBVS6F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 13:58:05 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD44C061574
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 10:57:24 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id l16so4040404oti.12
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 10:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lu/JqL+QcCWkQ3q9QtsGPOZZuuV98LjSgepEHG6VD0I=;
        b=eOhL4g9jKM96s7/g/F2MbAzONvK0pKxH+PaofzuVyF1J4oPzwqbip0oyBo9ui26x1K
         mVm0ugiwKGaBcT08u2UmewVjA6Zvbi6nivz7n1HERaSfzCM80UAWCnp+qjCTrNFVWcnI
         BkcqX+T2lIb8NoP57qHYNTf77SwFxJeMXr1Bkr6R3CrTLAAcezHydi4d/kkCi6AQcOOb
         YVMI2wSkSp3cIE1vdPwVMz/PIi1ehkPfdqAUDRtmfGCkf7tEV7qsH3Xb1WSNsG946Rqs
         hsBvNUaLwAy3h4MCGivjwMQOpl3U4lNUTWcZLk8Nzblwm4Z150+RBoHaZknoG97S4nvF
         r9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lu/JqL+QcCWkQ3q9QtsGPOZZuuV98LjSgepEHG6VD0I=;
        b=M9ZJabPmNSh5iMZ2S3hOxkXCZdso0EyQ/c2O1qKasiy8A+auYYhcqqjuM8DzuuGXD5
         sy7NaJsKj+rQCmIG5HWurdT5mAhU1iXr3GDylsqvU+gLGiUI3XRLCUFXm55DXGSecPNy
         cX2dTob3pfx5L83dooSa5v0tvHqWgbuxcCSd6MM+rmQ6ihkd7oFD8yKYqDwN0zXJb6mP
         zr5pDpvylArV/TZEyZoL7NPacfHWWrciarVbnckZqBmMOZWoulaA/S2s/gcpVqVIueq0
         Yb5ATPEg/DLw+l8xGS/kda0MIpgbrxYrNr9g60GKiFo22bxp760WB+T7qXPsXmwMe+tQ
         iThQ==
X-Gm-Message-State: AOAM531NeVo+IsF8eUBHN4chU7aG5quq9WDmjfpkwWRaY4ykSvEMPckq
        ROaMSbf4yNsRGcF+fGsQbgKVpuMHp2TWLH/7Nbq+YjpZyKM=
X-Google-Smtp-Source: ABdhPJytC+0cJVyfAb7RMmIajK9uql39VPZu5Y3Xgs7/t4V/TDzWsoZNaMypZOkFW6WvTP2S4SKwsbkAXhAAcXnIf44=
X-Received: by 2002:a9d:7459:: with SMTP id p25mr6170070otk.316.1614020243390;
 Mon, 22 Feb 2021 10:57:23 -0800 (PST)
MIME-Version: 1.0
References: <c17158e3b105d7c0679515446c5fd7b8d5fc8435.1605535068.git.matheus.bernardino@usp.br>
 <cover.1613593946.git.matheus.bernardino@usp.br>
In-Reply-To: <cover.1613593946.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Feb 2021 10:57:12 -0800
Message-ID: <CABPp-BH2LLxu-HV7hURwRN5j2Cd3P5Xdb+CLip=XApkUHFQj6A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] add/rm: honor sparse checkout and warn on sparse paths
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sorry for the delay in getting back to you.

On Wed, Feb 17, 2021 at 1:02 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> This is based on the discussion at [1]. It makes `rm` honor sparse
> checkouts and adds a warning to both `rm` and `add`, for the case where
> a pathspec _only_ matches skip-worktree entries. The first two patches
> are somewhat unrelated fixes, but they are used by the later patches.
>
> [1]: https://lore.kernel.org/git/CABPp-BHwNoVnooqDFPAsZxBT9aR5Dwk5D9sDRCvYSb8akxAJgA@mail.gmail.com/

I thought you said you wouldn't have time to look at git-add.  Are
there other commands you don't have time to look at?  I've got a few
suggestions...  :-)

Thanks so much for working on this; much appreciated.  I've looked
over the patch series, and am obviously a fan of the general thrust.
I didn't spot anything additional to point out; Junio already looked
over it pretty closely it appears.  I did add a comment answering one
of his questions, but that's it.

> Matheus Tavares (7):
>   add --chmod: don't update index when --dry-run is used
>   add: include magic part of pathspec on --refresh error
>   t3705: add tests for `git add` in sparse checkouts
>   add: make --chmod and --renormalize honor sparse checkouts
>   pathspec: allow to ignore SKIP_WORKTREE entries on index matching
>   add: warn when pathspec only matches SKIP_WORKTREE entries
>   rm: honor sparse checkout patterns
>
>  Documentation/config/advice.txt  |   4 +
>  Documentation/git-rm.txt         |   4 +-
>  advice.c                         |  19 +++++
>  advice.h                         |   4 +
>  builtin/add.c                    |  72 ++++++++++++++----
>  builtin/check-ignore.c           |   2 +-
>  builtin/rm.c                     |  35 ++++++---
>  pathspec.c                       |  25 ++++++-
>  pathspec.h                       |  13 +++-
>  read-cache.c                     |   3 +-
>  t/t3600-rm.sh                    |  54 ++++++++++++++
>  t/t3700-add.sh                   |  26 +++++++
>  t/t3705-add-sparse-checkout.sh   | 122 +++++++++++++++++++++++++++++++
>  t/t7011-skip-worktree-reading.sh |   5 --
>  t/t7012-skip-worktree-writing.sh |  19 -----
>  15 files changed, 349 insertions(+), 58 deletions(-)
>  create mode 100755 t/t3705-add-sparse-checkout.sh
>
> --
> 2.29.2
