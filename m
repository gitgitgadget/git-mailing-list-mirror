Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57703C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 22:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C1B60F92
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 22:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhJLWJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 18:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbhJLWJP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 18:09:15 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27592C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 15:07:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c4so458255pls.6
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JlrrGGsZ2TVQV51s/nWkLWJINLqCZQ7xjqYmfBzrm5U=;
        b=KeT0V+em58ABN1xp5Y2KujKziHKD0PZzuM7fxhhw7jANz5UFGBxDfSs5FfpTyhXaTM
         eU5jFYZOcNnBSZ74ZL/LZw3NKwU2tQoH+3sQEskyOhEIG7x2RIsPIhmMwoiHl18Ox/6T
         IY1NmlbJqakFmConT0PnUcQV7glIznBnLI63w684WJ46wnk2S/OBIAqKePjMb5I4+6Mi
         fZ0RPKvk9gDpS5dBUja8Z1Nsb8ILupebLve9Kc2VAnnh1+lfIFJCydXdE1whup9nubct
         ys4vlQo2xTK7B09JFo0S9/0T54zr17NLoaYg+5OHYI9o8OtVNIEh9yPFZbtdQ4SFxnZt
         tC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JlrrGGsZ2TVQV51s/nWkLWJINLqCZQ7xjqYmfBzrm5U=;
        b=sfqqtW7aVT5CC/ZfZFxglO3tpfOzRk15Tr3IoYKXAzuLz0KzeQhO3VgA3JkKa7LCn4
         sX90vDHCKtXncS6Y3WuageWLRD0YblyCLi7wcUpVUHhH9y6dHcytjbKrukG+Sjv0OdtE
         4sqg//UymfnHRB3JU6hqM6egVeVvyiO784ZdKiUlJwTq2t3yvg25eo7GYYGbTzOEvQGc
         1jRnO5MH/93GRLFlehubACX8y/xUvlFLiDcmDymBTEXufh8s1KLsiIQO13cvYSBQBJXo
         VthrDs81jNcJ7CXndh+I3koQOLcALLy6WMwafwdK7XyKHXfAav0ZRddvztTLLZ0bahd8
         4EXA==
X-Gm-Message-State: AOAM531OZDltkFBzkX2sYeP6ovGj7KzSD5JBqgdYGDYYcXbAVmkHMwUu
        jKAGah95qMdxgO33siRH/+wS8Q==
X-Google-Smtp-Source: ABdhPJw5cV+9L7V9Zq4WoBUyV7GEPfmlZXXw9XfgS0zggev7kETqizpX3LfH7ZNR91cxhhYfI8qxPA==
X-Received: by 2002:a17:90b:696:: with SMTP id m22mr9122407pjz.108.1634076432140;
        Tue, 12 Oct 2021 15:07:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:58e0:23e7:f3b1:61b])
        by smtp.gmail.com with ESMTPSA id p3sm11832247pfb.205.2021.10.12.15.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 15:07:11 -0700 (PDT)
Date:   Tue, 12 Oct 2021 15:07:06 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, gitscale@google.com
Subject: Submodules UX overhaul update (was: What's cooking in git.git (Oct
 2021, #03; Mon, 11))
Message-ID: <YWYHCnpPnrjwTjhA@google.com>
References: <xmqqv9239k15.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9239k15.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As I promised in IRC yesterday, here's an attempt to filter this into a
submodules newsletter of sorts.

For context on the broader submodules effort I'm discussing in this
note, please see the design doc:
https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/

I'm aware there are other submodule efforts ongoing too, but in this
letter I've highlighted ones that are necessary for the above-linked
design doc. Selfish, I know. ;)

On Mon, Oct 11, 2021 at 05:14:14PM -0700, Junio C Hamano wrote:
> [Stalled]
> 
> * ar/submodule-update (2021-09-20) 8 commits
>  . submodule--helper: rename helper functions
>  . submodule--helper: remove unused helpers
>  . submodule--helper: remove update-clone subcommand
>  . submodule: move core cmd_update() logic to C
>  . submodule--helper: refactor get_submodule_displaypath()
>  . submodule--helper: rename helpers for update-clone
>  . submodule--helper: get remote names from any repository
>  . submodule--helper: split up ensure_core_worktree()
> 
>  Rewrite of "git submodule update" in C.
> 
>  Kicked out of 'seen' to make room for es/superproject-aware-submodules
>  which is among the topics this topic stomps on.

Mentioning this series in the "newsletter" since I'm aware that I'm
blocking it with es/superproject-aware-submodules. I have it open in
another tab as I type and plan to send a reroll today or tomorrow.

> --------------------------------------------------
> [Cooking]
> 
> * es/superproject-aware-submodules (2021-08-19) 5 commits
>  - fixup! introduce submodule.superprojectGitDir record
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

Like I said above - planning to send a reroll today or tomorrow.

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
> 
>  Mostly preliminary clean-up in the hook API.
> 
>  Will merge to 'master'.

We saw this make it in to 'next' last week - woohoo! (Yes, this is part
of the critical path for the planned submodulesy work.)

Looks like the next chunk is at
https://lore.kernel.org/git/cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com/
- I will try and take a look this week (but probably cannot til ~Thursday).

> * jt/no-abuse-alternate-odb-for-submodules (2021-10-08) 9 commits
>  - submodule: trace adding submodule ODB as alternate
>  - submodule: pass repo to check_has_commit()
>  - object-file: only register submodule ODB if needed
>  - merge-{ort,recursive}: remove add_submodule_odb()
>  - refs: peeling non-the_repository iterators is BUG
>  - refs: teach arbitrary repo support to iterators
>  - refs: plumb repo into ref stores
>  - Merge branch 'jk/ref-paranoia' into jt/no-abuse-alternate-odb-for-submodules
>  - Merge branch 'jt/add-submodule-odb-clean-up' into jt/no-abuse-alternate-odb-for-submodules
> 
>  Follow through the work to use the repo interface to access
>  submodule objects in-process, instead of abusing the alternate
>  object database interface.
> 
>  Will merge to 'next'?

I asked around and it seems like:
 1. Josh Steadmon will take a last pass at the latest;
 2. Jonathan Tan thinks it's pretty much ready.

Thanks.

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

Additionally, later this week Jonathan Tan is planning on sending an RFC
to allow a config 'includeIf' to gate on remote URLs. This will be handy
for us (Google) to do some pilot groups more efficiently, but I imagine
will also be useful for external users (especially combined with the
completed config-based-hooks feature).

 - Emily
