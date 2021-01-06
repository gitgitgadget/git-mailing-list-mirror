Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDBCC433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 05:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A60BD227C3
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 05:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbhAFFhY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 00:37:24 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:41682 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbhAFFhY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 00:37:24 -0500
Received: by mail-ed1-f44.google.com with SMTP id i24so3268926edj.8
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 21:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5l2RJIQst0zIq/HYUi0DQPy2gSlBp0/s6j2SrysX1c=;
        b=S/RPJB2KXi2W2EDXL35s6VoK0VOJXogTryFKgY2eCrcbyW+Qldo5qV/gOH4O2Rau/U
         CIH1XBJN2um70wfufGIYa2SHEoEMi6HGq/uu1AQ4RKIhk9wKEEnQI1tz4RXp9AD3Zf8b
         jn7vVzUgyMYYd8kSI3ARS3+n2I+59d+TCux5lxynOuhHTPROCbhJBeL+TUKH0N7Soc1k
         lYZRLmWewjR99ryeXiWOKEiQ2ynGgLnwBgGRTG4CdCiyCWQi2sGmEJtpsMugSANfMNiz
         /wWSeU3mq0ZkCwd3rUHKzwUrH4i9Pfze9+ChzNb3wszPE+Dh4aughSkFBGPwCxYMxeUG
         5Asw==
X-Gm-Message-State: AOAM533ozmrhRgkIPhKvKotmrsLClbrR93ym3m4tFU5WERVG2covuVxk
        J843P+WLw8jgg3c4C6MH6j+OmChf4HoAorEVgPFHz8V8RPM=
X-Google-Smtp-Source: ABdhPJwucWgL8G3B53CGqZsJ29tlq++A4Cqx2zYwRM7p76J0SPKNjaxe8W4caoXc1FuYKcsMz5DFeHMwzNA6t192NQg=
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr2801053edu.163.1609911402711;
 Tue, 05 Jan 2021 21:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Jan 2021 00:36:31 -0500
Message-ID: <CAPig+cSMA0J9fBvG=L0ojWvd5ePwxb6ya67umX1HdOy4LEiZpg@mail.gmail.com>
Subject: Re: [PATCH 0/7] teach `worktree list` verbose mode and prunable annotations
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 4, 2021 at 11:22 AM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> In c57b3367be (worktree: teach `list` to annotate locked worktree,
> 2020-10-11) we taught `git worktree list` to annotate working tree that
> is locked by appending "locked" text in order to signalize to the user
> that a working tree is locked.  During the review, there was some
> discussion about additional annotations and information that `list`
> command could provide to the user that has long been envisioned and
> mentioned in [2], [3] and [4].
>
> This patch series address some of these changes by teaching
> `worktree list` to show "prunable" annotation, adding verbose mode and
> extending the --porcelain format with prunable and locked annotation as
> follow up from [1]. Additionally, it address one shortcoming for porcelain
> format to escape any newline characters (LF and CRLF) for the lock reason
> to prevent breaking format mentioned in [4] and [1] during the review
> cycle.

Thank you for working on this. I'm happy to see these long-envisioned
enhancements finally taking shape. Before even reviewing the patches,
I decided to apply them and play with the new features, and I'm very
pleased to see that they behave exactly as I had envisioned all those
years ago.

Very nicely done.

I'll review the patches when I finish responding to this cover letter.

> The first moves the should_prune_worktree() machinery to the top-level
> worktree.c exposing the function as general API, that will be reference
> by should_prune_worktree() wrapper implemented on the second patch. The
> original idea was to not only move should_prune_worktree() but also
> refactor to accept "struct worktree" and load the information directly,
> which can simplify the `prune` command by reusing get_worktrees().
> However this seems to also require refactoring get_worktrees() itself
> to return "non-valid" working trees that can/should be pruned. This is
> also mentioned in [5]. Having the wrapper function makes it easier to add
> the prunable annotation without touching the get_worktrees() and the
> other worktree sub commands.  The refactoring can be addressed in a
> future patch, if this turns out to be good idea.  One possible approach
> is to teach get_worktrees() to take additional flags that will tell
> whether to return only valid or all worktrees in GIT_DIR/worktrees/
> directory and address its own possible shortcoming, if any.

I haven't looked at the patches yet, so I can't respond to this right now.

> The third patch changes worktree_lock_reason() to be more gentle for the
> main working tree to simply returning NULL instead of aborting the
> program via assert() macro. This allow us to simplify the code that
> checks if the working tree is locked for default and porcelain format.
> This changes is also mentioned in [6].

Sounds good.

> The forth patch is the one that teaches `list` command to show prunable
> annotation, for both default and porcelain format, and adds the verbose
> option. These changes are also done for the "locked" annotation that was
> not done on in [1]. Additionally, `list` learns to fail when both
> --verbose and --porcelain format as used together.

My knee-jerk response to disallowing --verbose and --porcelain
together was that it seemed unnecessarily harsh, but upon reflection,
I think it's the correct thing to do. After all, porcelain output,
even though extensible and flexible, should be predictable, so it
doesn't make sense for options such as --verbose to affect it.

> The fifth patch adds worktree_escape_reason() that accepts a (char *)
> text and returned the text with any LF or CRLF escaped. The caller is
> responsible to freeing the escaped text. This is used by the locked
> annotation in porcelain format. Currently, this is defined within
> builtin/worktree.c as I was not sure whether libfying the function as
> part of this series is a good idea. At this time it seems more sensible
> to leave the code internally and libfying later once we are confident
> about the implementation and whether it can be used in other part of the
> code base but I'm open for suggestion.

Perhaps I misunderstand, but I had envisioned employing one of the
codebase's existing quoting/escaping functions rather than crafting a
new one from scratch. However, I'll reserve judgment until I actually
read the patch.
