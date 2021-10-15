Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CC4C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 18:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E663D6105A
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 18:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbhJOS6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 14:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbhJOS6q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 14:58:46 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29891C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 11:56:40 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f5so9349192pgc.12
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 11:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bLtB2d41O/Jjd7tRMoyX1f77nlmnF9Ji85pH6GcuGPE=;
        b=OpwfDPeuU6koHLzj0eoWZt8/6gk+Nprrru5SbITAP71ATtVNsYf7DrXM57PtVvh43b
         27KkSA/9ID0qHHt7PXZG+cka8BjSoxfMeerOi6Te828ChARpdvGl5gN328cFNUOm0Icd
         knwbUFpAccdfGhlXSJvHSMgD457AGX7HNEHSLyd+TOPjbP2sMHDlFktEULyscSjQWlIk
         KS3QihUfl614xenCNjEerhElFn/j0cjYPrHqSIv2ccaDkgh9IR4UDGYy3JnexYFJBQ00
         1HVHyPQvWTz6bRUJQ4TiWL5FZEFnTO0/yBMuLfGsAU8MCmJWFHzc7VzaHNFLPUmJLsSx
         LIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bLtB2d41O/Jjd7tRMoyX1f77nlmnF9Ji85pH6GcuGPE=;
        b=ZA7EFm/VWotFvUD9NHo2UjsE4OXSoYLdCJx/aTaFtBYqAmy5m47VeEMWqyIdxtaPAd
         LMw+Q/cR0nxCizwDrAK4TobPusqssmWsYwqF/luiWeFmJDu3fPESeij/hRSNVvXIEDfc
         NBPVIcZSM2V90eAj+rXCgh9BH+1ckmO/ONvO2kwpVcP9YZs0okU99GtLLMywmXNrDWKs
         x1XznL5CiJDJr7pPcIbF00DbVnTSIJdhsrO3jUimL8G/NKaE0t/R7xt3IQm6Tlo5y6N/
         qTR8SbSQYe/xIpoimpOgi6Qij5dR8HTRYxyWNuMSkkMdK6wOMMyLXap6X9pa3TgRYSg9
         6YWg==
X-Gm-Message-State: AOAM531hQ0H7KXxJTUTUp/Ic0nf+KMd6QSyWSGCZyc1+NFt01H94rUQm
        LwsQrzOpEL1pIg/SavXmBrPexA==
X-Google-Smtp-Source: ABdhPJy1lieq0CUKo7nTYLSUGyvXr6oFV5tXIA8e7xRqZFskeu7wxiDoCjeVGIcQyAWCQvTsRaKqXw==
X-Received: by 2002:a63:4b5b:: with SMTP id k27mr10242337pgl.294.1634324199399;
        Fri, 15 Oct 2021 11:56:39 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cc2f:afb0:ab09:f218])
        by smtp.gmail.com with ESMTPSA id y9sm5459383pfm.129.2021.10.15.11.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 11:56:38 -0700 (PDT)
Date:   Fri, 15 Oct 2021 11:56:33 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, gitscale@google.com
Subject: Submodules UX overhaul update (was: What's cooking in git.git (Oct
 2021, #04; Thu, 14))
Message-ID: <YWnO4T2QkSm1bIRU@google.com>
References: <xmqqwnmf9lnv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwnmf9lnv.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 14, 2021 at 05:28:04PM -0700, Junio C Hamano wrote:
> [Graduated to 'master']
> 
> * ab/config-based-hooks-1 (2021-09-27) 8 commits
>   (merged to 'next' on 2021-10-06 at d05325ed35)
>  + hook-list.h: add a generated list of hooks, like config-list.h
>  + hook.c users: use "hook_exists()" instead of "find_hook()"
>  + hook.c: add a hook_exists() wrapper and use it in bugreport.c
>  + hook.[ch]: move find_hook() from run-command.c to hook.c
>  + Makefile: remove an out-of-date comment
>  + Makefile: don't perform "mv $@+ $@" dance for $(GENERATED_H)
>  + Makefile: stop hardcoding {command,config}-list.h
>  + Makefile: mark "check" target as .PHONY
>  (this branch is used by ab/config-based-hooks-2.)
> 
>  Mostly preliminary clean-up in the hook API.

Glad to see it go in.

> --------------------------------------------------
> [New Topics]
> 

Ævar has sent the next set of hook API patches to list - please take a
look. I sent a review today, but I am probably too familiar with those
patches to spot important details, by now.

https://lore.kernel.org/git/cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com/


Jonathan Tan sent an RFC series adding a new conditional config include
based on configured remote URL, which we hope will A) make it easier for
us to pilot test the submodule workflow, and B) make it easier for
engineers at MegaCorp (or anybody shipping a package via a package
manager) to provide configs (and later hooks) without relying on the
controversial remote-suggested-hooks topic proposed earlier.

https://lore.kernel.org/git/cover.1634077795.git.jonathantanmy%40google.com

> --------------------------------------------------
> [Stalled]
> 
> * ar/submodule-update (2021-10-13) 9 commits
>  . submodule--helper: rename helper functions
>  . submodule--helper: remove unused helpers
>  . submodule: move core cmd_update() logic to C
>  . submodule--helper: run update using child process struct
>  . submodule--helper: allow setting superprefix for init_submodule()
>  . submodule--helper: refactor get_submodule_displaypath()
>  . submodule--helper: rename helpers for update-clone
>  . submodule--helper: get remote names from any repository
>  . submodule--helper: split up ensure_core_worktree()
> 
>  Rewrite of "git submodule update" in C.
> 
>  Kicked out of 'seen' to make room for es/superproject-aware-submodules
>  which is among the topics this topic stomps on.

The reroll of es/superproject-aware-submodules v4 went out yesterday:

https://lore.kernel.org/git/20211014203416.2802639-1-emilyshaffer%40google.com

> --------------------------------------------------
> [Cooking]
> 
> * es/superproject-aware-submodules (2021-10-14) 4 commits
>  - submodule: record superproject gitdir during 'update'
>  - submodule: record superproject gitdir during absorbgitdirs
>  - introduce submodule.superprojectGitDir record
>  - t7400-submodule-basic: modernize inspect() helper
> 
>  A configuration variable in a submodule points at the location of
>  the superproject it is bound to (RFC).
> 
>  Brought back to 'seen' to see if it still plays well with the rest
>  of 'seen', without the conflicting ar/submodule-update topic.

See above; a reroll happened.

> * jt/no-abuse-alternate-odb-for-submodules (2021-10-08) 9 commits
>   (merged to 'next' on 2021-10-14 at ae49a2ceda)
>  + submodule: trace adding submodule ODB as alternate
>  + submodule: pass repo to check_has_commit()
>  + object-file: only register submodule ODB if needed
>  + merge-{ort,recursive}: remove add_submodule_odb()
>  + refs: peeling non-the_repository iterators is BUG
>  + refs: teach arbitrary repo support to iterators
>  + refs: plumb repo into ref stores
>  + Merge branch 'jk/ref-paranoia' into jt/no-abuse-alternate-odb-for-submodules
>  + Merge branch 'jt/add-submodule-odb-clean-up' into jt/no-abuse-alternate-odb-for-submodules
> 
>  Follow through the work to use the repo interface to access
>  submodule objects in-process, instead of abusing the alternate
>  object database interface.
> 
>  Will merge to 'master'.

\o/

Besides what was in the What's Cooking mail, we have a couple more
series on our minds:

https://lore.kernel.org/git/0346f447548cfd11307173aaa3284d86a2ef689c.1631319742.git.steadmon@google.com/

 Introducing a new value for core.autosetupmerge, "inherit". This eases
 our ability to push to the right place in submodules when running 'git
 push' recursively from the superproject.

 However, this topic is not ready for review - Josh is planning a
 re-roll later in the week.

https://lore.kernel.org/git/pull.1103.git.git.1633633635.gitgitgadget@gmail.com/

 Pre-work for 'git branch --recurse-submodules' support. This one is
 mostly plumbing through `struct repo` and replacing a few instances of
 `the_repository`. Glen is planning a reroll shortly.

 - Emily
