Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D45C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 13:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E44260F5C
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 13:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbhG3NMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 09:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238892AbhG3NL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 09:11:59 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85D8C061765
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 06:11:54 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id e3-20020a4ab9830000b029026ada3b6b90so2449590oop.0
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 06:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M1iN9gmaa4t+d/bw7RlwRqe3OCU2ULfOPi8mWN+cN2A=;
        b=CBbCui9ukZF8trKWnjxhEz1x5DSdX5nV83N5HqmU2Xo6IwfCQr8jZwnceDXDoVq8HY
         Sl8zfTbe3wO/XnDhZFm0bpMg40Dw2q71C/GbvEUiM8HQ7t4jJoquaM8ka15C0mbnxa0R
         hbnFDGKPelBnd1ApJxt0uIssqtROqOgtoSpaVbWaSrgEIA8HLtLeBSoNEKjTYvosIdFF
         EXIn5DKvG4LfkbZM8loTT7roue01qQFw8MZFlcpr8/TQHbLbJRaafGdXke7QX6k5Tk4b
         fVncTvH5VEGduzDSW3C1F1OQEYbumtqgiXC++uQv1SC5O5Eh0VdK5FYUku0uKOSJupot
         oJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1iN9gmaa4t+d/bw7RlwRqe3OCU2ULfOPi8mWN+cN2A=;
        b=DbgKnL71qpN4cdkMEs9q1hVjipjdJrlr6MU+WljEdjskMsOWoF36NV4fsElXhgeiDX
         WUoPQycSbiO8ZzU+WaJYtcPo21cDStlsdnJi8FOGWbt85eufhhzTXojHlZA2uyCkMWYf
         elRTnyxQklkuFaxe/FQrus0Q1+euM6LbnOb2eQe9NfawqyH9uldS+v2HRFHnBCsbAnOs
         eSyfUcMiX74UHsUiUiIjQDH5Af+6bl27+uRu2X/g8+7/vlO4vctdczVTyf6s554BuHFj
         YDs7lGoOWo9FIOFfXfx5rWFQow+AGMrCDEhBgTFyDtMtidLc/vMH0Z4hfebA12JjVOEH
         2xNQ==
X-Gm-Message-State: AOAM532Ecq6FtTL5nk2Ly+jlM0wG2/NVRjWCUbTVfeNcuONuQoKVZyqd
        CvsfPP9avnDGiYC9cWOCwrCNa1B2mWwuzC+0czk=
X-Google-Smtp-Source: ABdhPJzIkzFMP9w4JmwxeRooVQQgSpVcIFw2cmZ2R17eNm6275RyCApSmE8u1gYzb3EneZyE8ZAAzQ7EfmfcgSJg2T0=
X-Received: by 2002:a4a:a385:: with SMTP id s5mr1578177ool.7.1627650714258;
 Fri, 30 Jul 2021 06:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Jul 2021 07:11:43 -0600
Message-ID: <CABPp-BH1jw6MakBeFADybeEV6LTDRS1OMvqGwMYiLoTBdG_L1w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Sparse index: delete ignored files outside sparse cone
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 11:27 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> My commits are technically based on ds/add-with-sparse-index, but could
> apply earlier, I believe.
>
> We launched an experimental release [1] of the sparse-index feature to our
> internal users. We immediately discovered a problem due to the isolated way
> in which we tested the sparse index: we were never building the project and
> changing our sparse-checkout definition.
>
> [1] https://github.com/microsoft/git/releases/tag/v2.32.0.vfs.0.102.exp
>
> Users who ran a build in one project and then moved to another still had
> build artifacts in their worktree that lived inside the old directories.
> Since the files are marked by the .gitignore patterns, these files were not
> removed by the 'git sparse-checkout set' command. However, they make the
> sparse-index unusable because every 'git status' command needs to expand the
> sparse-directory entries in order to see if the files are tracked or not.
> This made the first experimental release actually slower for all users
> because of this cost.

As highlighted at
https://lore.kernel.org/git/CABPp-BHwRHhYE3BPxCG+fRFWf2dCZ60rnO=ykztquKoOp_x_QQ@mail.gmail.com/
?

"""So, although 'git status'
shouldn't have to check the tracked files anymore, it is still going
to have to look at each of the *untracked* files and compare to
.gitignore files in order to correctly classify each file as ignored
or just plain untracked."""

As I noted there,

"""about a month ago my
colleagues made the tool just auto-invoke [--remove-old-ignores] from other
sparsify invocations.  To my knowledge, there have been no complaints
about that being automatically turned on; but there were
complaints/confusion before about the directories being left around.
(Of course, non-ignored files are still left around by that option.)"""

I think your changes here shouldn't be limited to a sparse-index but
should apply to cone-mode sparse checkouts generally.

> The solution we shipped to these customers was to change the way our fork
> handles these ignored files. Specifically, instead of Git completely
> ignoring the files, we changed Git to understand that with cone-mode
> sparse-checkout patterns, the users is asking for entire directories to be
> removed from the worktree. The link [1] included earlier has this change.

Could you clarify what you are removing?
  1) Tracked but now SKIP_WOKRTREE files
  2) .gitignore'd files
  3) other untracked files

(1) has always been removed by sparse-checkout.  I think you're adding
(2) but it's not clear if you are also removing (3).

> I believe that this is a reasonable expectation, though I recognize that it
> might look like breaking the expectations of how .gitignore files work.
>
> To limit the scope of this change, the focus is limited to behave this way
> only when the sparse-index is enabled, because otherwise the sparse index
> does not behave as intended. With that restriction in mind, the
> implementation can use the sparse directory entries to assist.
>
> I imagine that when the sparse index is mature enough, we will enable it by
> default when cone mode sparse-checkout is enabled, in which case this
> behavior would expand to all users with cone mode sparse-checkout.

I'm all in favor of just doing it for all cone mode users, at least
for .gitignore'd files.

> I'm interested in the community's thoughts about this change, as it seems
> like one that we should make carefully and intentionally.

Yeah, I approached it pretty cautiously, just adding a new option in
our tool (`sparsify --remove-old-ignores`) because I wasn't sure if it
should be done by default but wanted to provide an easy way for users
to access it.  We got numerous complaints and after some months, added
a config option to run it automatically.  We still got complaints and
eventually my colleagues just made it automatically run and provided
no way to turn it off.  No user complaints since.
