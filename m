Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37423C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 082A8613E6
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245344AbhDUS5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 14:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbhDUS5J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 14:57:09 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9425C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 11:56:35 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so34753440otf.12
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUEJ16soGeiqkfBsX8GHEPPwem6M2/Pswnjap4m1hy8=;
        b=LCoEmAjTqrAuw0wvDs97TdpJSAbE0OymTcMX4778iQhDNQFnfRIJmgIXe5RCWfAheF
         /Wsx315c71QeRNw+bT3MQwWqWDpqned0rbOv3g3KlfOjKJO3k8QLzAxsVD99CgIYNGeH
         dXTo1tjTN/nVoxPVWD5bJbuJ77QgrAyFnW4dgE2rtWgAWSTxektf9YPP8//QNxxyJ5zn
         qrK0kzC4tVkj1CkXD7Vgcgw+0RO9DpA+T2K6XQ/xW4gwNpsZ4UrvR9jopXNXxl2cmyyV
         HnHh5iTdqd6i7WoFQF/fwYiptxHLeMn4YXYMigWFpLCQU3gDLJqgXB7MYUuA9d8to640
         v10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUEJ16soGeiqkfBsX8GHEPPwem6M2/Pswnjap4m1hy8=;
        b=aq8utnnM+XlF4OmgkIErLl3PzNqbZuw6z7wnr/JIyxtDJ8w/mMCr010uLuoUBxhk6O
         MMO1khiKItFVJPR8Ax1A2rQq73j1XAyADdmOcq8PfHRukKHvm+iAUaQ9c+aNZzWTPbDy
         IzY+/bK7uSSUsl5IKk3hAYf/w1Z/8T2mZ+8U0/Hmrsn0z7tmQ0ABtu5FmcVtE4Mwe3D1
         IOMnkTb+1+Xbm0wFcgxeR2Ov5e+N1GA1kCZGlYU8YGtGfCuz3ZT21WY9MlNe+fkw5qAi
         GcQh7ph5wZSK/vdWgLyL2b5EEEugmOrsS3UcATqZyHyJ4nl5YYQiK1S/3drqWMH8HCpO
         bkog==
X-Gm-Message-State: AOAM531+ceaxC21XUfBuLS+zZ4oUZe+e6pA8v5BN60+tyrrGlVUiJ+ex
        fhHTIKFcY2Wu6E4xatdRLigiO10WfE2RA3b8XmM=
X-Google-Smtp-Source: ABdhPJwoR1XoJJBLwGdO1k35xn/hpF///47WstyAK5iPra6GKM290TZ/GClCbEvKpDF6Kq1WIeXAdYAlUC7i3vURLfo=
X-Received: by 2002:a05:6830:906:: with SMTP id v6mr24494430ott.345.1619031395373;
 Wed, 21 Apr 2021 11:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <0a3892d2ec9e4acd4cba1c1d0390acc60dc6e50f.1618322497.git.gitgitgadget@gmail.com>
 <CABPp-BHcdhO_kEdqR23sDdGAgoSu2R-HBWv-RmzQvJ0ysWtzxg@mail.gmail.com> <34972851-7d3b-c759-ba87-7022702f74c0@gmail.com>
In-Reply-To: <34972851-7d3b-c759-ba87-7022702f74c0@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Apr 2021 11:56:24 -0700
Message-ID: <CABPp-BF0ZhbSs42R3Bw_r-hbhQ71qtbXSBqXdq0djyaan=8p=A@mail.gmail.com>
Subject: Re: [PATCH 02/10] unpack-trees: make sparse aware
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 10:27 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 4/20/2021 7:00 PM, Elijah Newren wrote:
> > On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
>
> >> diff --git a/read-cache.c b/read-cache.c
> >> index 29ffa9ac5db9..6308234b4838 100644
> >> --- a/read-cache.c
> >> +++ b/read-cache.c
> >> @@ -1594,6 +1594,9 @@ int refresh_index(struct index_state *istate, unsigned int flags,
> >>                 if (ignore_skip_worktree && ce_skip_worktree(ce))
> >>                         continue;
> >>
> >> +               if (istate->sparse_index && S_ISSPARSEDIR(ce->ce_mode))
> >> +                       continue;
> >> +
> >
> > I'm a bit confused about what could trigger ce_skip_worktree(ce) &&
> > !ignore_skip_worktree and why it'd be desirable to refresh
> > skip-worktree entries.  However, this is tangential to your patch and
> > has apparently been around since 2009 (in particular, from 56cac48c35
> > ("ie_match_stat(): do not ignore skip-worktree bit with
> > CE_MATCH_IGNORE_VALID", 2009-12-14)).
>
> I did some more digging on this part here. There has been movement in
> this space!
>
> The thing that triggers this ignore_skip_worktree variable inside
> refresh_index() is now the REFRESH_IGNORE_SKIP_WORKTREE flag which was
> introduced recently and is set only by builtin/add.c:refresh(), by
> Matheus: a20f704 (add: warn when asked to update SKIP_WORKTREE entries,
> 2021-04-08).
>
> This means that we can (for now) keep the behavior the same by adding
>
>         if (ignore_skip_worktree)
>                 ensure_full_index(istate);
>
> before the loop. This prevents the expansion during 'git status', but
> requires modification before we are ready for 'git add' to work
> correctly. Specifically, 'git add' currently warns only when adding
> something that exactly matches a tracked file with SKIP_WORKTREE. It
> does _not_ warn when adding something that is untracked but would have
> the SKIP_WORKTREE bit if it was tracked. We will need to add that
> extra warning if we want to avoid expanding during 'git add'.
>
> Alternatively, we can decide to change the behavior here and send an
> error() and return failure if they try to add something that would
> live within a sparse-directory entry. I will think more on this and
> have a good answer before v2 is ready.

See my comments on 01/10; users are already getting surprised by "git
add" today and has been going on for months (though not super
frequently).  When they try to "git add" an untracked path that would
not match any path specifications in $GIT_DIR/info/sparse-checkout,
the fact that "git add" doesn't error out (or at the very least give a
warning) causes _subsequent_ commands to surprise the user with their
behavior; the fact that it is some later command that does weird stuff
(removing the file from the working tree) makes it harder for them to
try to understand and make sense of.  So, I'd say we do want to change
the behavior here...and not just for sparse-indexes but
sparse-checkouts in general.

As for how this affects the code, I think I'm behind both you and
Matheus on understanding here, but I'm starting to think it was a good
idea for me to spout my offhand comment on what looked like a funny
code smell that I thought was unrelated to your patch.  Sounds like it
is causing some good digging...I'll try to read up more on the results
when you send v2.  :-)
