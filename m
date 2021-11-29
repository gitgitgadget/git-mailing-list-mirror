Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4BEC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhK2Wgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbhK2Wfu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:35:50 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3A2C061379
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:23:12 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y13so76327831edd.13
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U/O5Ilo/sqaC8BRU84Xp/pjenUQz/X9DuNmU0EcURxg=;
        b=mYbmY63G1nm7jEn3RNqn+thCj/2UCakkAGKCgoEABOB42yu4Er7d5UYtjaTPMbls8q
         XPv4dS54SNwQK7+tWPI7WksLYke68jCkFN+p+Wq8JQjeGY2RgRBgZzCzTGBVAVoS1S7w
         KtQYejY9z0g3qpCUPxaED0qeh1Yk+1ILfhMGfam/w8pShy2j6gplfYkMqujAKbdmR4kQ
         /s70sygf2ldxARbxpDR5sYWGQpVGUeDbYWNuz5MS2Lum7zRR5yZoPFXhBsrooavMKnS3
         NAPdhuYo4bmz8GBGkg9ep2fjXu8QUL+gKiXE6xzU0IbSyl/V88HdEWpiTfqMWCE+yoW5
         6VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/O5Ilo/sqaC8BRU84Xp/pjenUQz/X9DuNmU0EcURxg=;
        b=jRpPgK6NKpv3oTLf/LCezsrSSdm07bxlXSK5sEr5lXl8x8T5aXbv9eUdSLQvDngFmw
         GqLuAFM28lDS63Tqj1tgpnml2o0iEltfm2jiYFxNg6W9+fWkeG4LwUsfRvmgaI0oowlP
         +/3yI6Ruk0sQh16SW4PbP+Wt4UqZ3BkZjCvphHgpKyXy41FKUVkO3MMyctCQnEF9VWFy
         0Txz7cYAoxjTrL00h3WGKtclqLWK9MbyKASYKstYvai168ymBweE1x4m/3soSVMesJM/
         FXWvyBsUh/eHaoGWWHgWH2t80yzrZSSeQ4C4+dU6LeKw3qv//HQSUyyoBAEfzZ3H3gcf
         TfWA==
X-Gm-Message-State: AOAM531/QWWlws04jnXda5BUnikyuAmK3bWbOrTJzWVJKrlopUl6hh1L
        yQ9RzEkFjOZ5NJhc1nRWHpr5TLKZkOijKmNS7x4=
X-Google-Smtp-Source: ABdhPJx9pn9iu08KJ4NMohTRYUbvTPjYalsa0EyZXVnENacZcnFuewH9hr3XW2cMhayOicYTSQttcZYfHjMe5NqnC3Q=
X-Received: by 2002:a17:906:4c9:: with SMTP id g9mr61279260eja.172.1638213791045;
 Mon, 29 Nov 2021 11:23:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com> <39b1f3a225ec74a79320503eff04ba47ae4259fd.1637966463.git.gitgitgadget@gmail.com>
 <7d90bf61-59c6-045e-1987-81d50454c260@gmail.com>
In-Reply-To: <7d90bf61-59c6-045e-1987-81d50454c260@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Nov 2021 11:22:59 -0800
Message-ID: <CABPp-BFr-U1kaqaj9HR+A=tRt0F_btcbDp89xeoZRdXewM4a2w@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] rebase: do not attempt to remove startup_info->original_cwd
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 9:50 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/26/2021 5:40 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Since rebase spawns a `checkout` subprocess, make sure we run that from
> > the startup_info->original_cwd directory, so that the checkout process
> > knows to protect that directory.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  sequencer.c          | 3 +++
> >  t/t2501-cwd-empty.sh | 4 ++--
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index ea96837cde3..b71f7b8a0a6 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -4228,6 +4228,9 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
> >
> >       cmd.git_cmd = 1;
> >
> > +     if (startup_info->original_cwd &&
> > +         !is_absolute_path(startup_info->original_cwd))
> > +             cmd.dir = startup_info->original_cwd;
>
> I was initially confused by the "!is_absolute_path()" because
> it seemed to me like it would be natural to store an absolute
> path there, but I see this comment in patch 2:
>
> +        * For convience, we would like to have the path relative to the
> +        * worktree instead of an absolute path.
>
> So it seems that we won't store it as an absolute path. Is
> there any value in this condition, then?

Good catch.  This is leftover from an earlier round; I'll remove it.
From stash too.

> This assignment of cmd.dir to the relative path has a lot
> of baked-in knowledge of this variable _and_ the current
> state (Git chdir()'d to the root of the worktree). If the
> path is always relative, then it should be a BUG() if we
> see an absolute path. Also, it seems like we would want
> cmd.dir to be a concatenation of the worktree root and the
> original_cwd.
>
> Or perhaps I'm being overly cautious and this could all be
> resolved with a comment about the expected state of the
> working directory and original_cwd. The tests will catch if
> any of those expectations change.

Yeah, with the extra condition in there I should have added a good
explanation about why I had it in there.  But I think a simple

if (startup_info->original_cwd)
    cmd.dir = startup_info->original_cwd;

should be good enough?  Or do you still want a comment for that?
