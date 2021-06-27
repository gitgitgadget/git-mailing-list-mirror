Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73338C49EA7
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 01:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4950E61A14
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 01:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhF0BhF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 21:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhF0BhF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 21:37:05 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D6EC061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 18:34:41 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id m6-20020a9d1d060000b029044e2d8e855eso12238203otm.8
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 18:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QhHFqXZPvf0Ny+bjsYVAwLjfSIRt+iTGh74CXB3CCg8=;
        b=uIp35cZnsRT3ZiBHywUFiUOe6y1LmrDisiLE74KdpK9QzwelUYTE5eJXDkX18p8zKW
         Hnu7rj4/2Om2em8I7SsrrNAXjFhu3XLH452CSb0E9ho8jRim667qN0CxMj6AxXergPkv
         uS/vFceMjv33cKqDb2BihvygIDLIz88g9P32qQy4B/UFyAZcLS7g/4wVaA2tgSmCU6ev
         y+UUvwdScI4yVh1oBVaXbXJp88gBwCrlerH+1LSDMnyBBCs6FEA+/Tot1Ps4+2FOlMFz
         awVvghfmZLD2BFXW0Tk9n1n2alUXgpZY1wgHD/9+vY75JnHA+TPMOxV6lXjQmlK0QvEl
         ki/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QhHFqXZPvf0Ny+bjsYVAwLjfSIRt+iTGh74CXB3CCg8=;
        b=tXOvgiEqFloZ+bMzEnJT3ua6BN3+U4G/HvvOis8Xhh7BfXvE9cTgib9ui0GtpeMdxJ
         Yx7u/1oanAXdCcYd7AImjSMeSooxXSyKNRlxIB7P8pnDEqsLuvWIXiR+zfcMvZfi8cF9
         PiUHv+YcCSllnnpQWXhCi1Nx+nR0CHWROTY4AI9lgCO2t9etZ/l7Ygl/7ZCkDpJJuB/l
         fqzzujwPMgfHGsdr2hu/NFtQOco6aWedeLJ06XN91vrdQE/z7b9FR8kMafysO6c4Vuz/
         dUKmbdUIypuhvVGU7q8jb40vB6lnBMYi09wY8RdfDbP+iqWYn3tRHeJdmk4bEb5NvgOy
         tziw==
X-Gm-Message-State: AOAM530Qw7ASU4NgOn9pAXVTPQbiRl04aU/2YXXYqX9/fsDUQxx4UTQv
        ED208Y1kPQduFf3W13vqJP8cdXC1acOeWTchuv0=
X-Google-Smtp-Source: ABdhPJz0blFXPiYzGRr8r878TliUc2u4JhHXqozTk8uWa/w7/pFph0czhttFczJVu79VDDjveVjzSs3f9zo/efBZ86s=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr15987204otn.345.1624757680280;
 Sat, 26 Jun 2021 18:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210627000855.530985-1-alexhenrie24@gmail.com>
In-Reply-To: <20210627000855.530985-1-alexhenrie24@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 26 Jun 2021 18:34:28 -0700
Message-ID: <CABPp-BGko7BP6ZMyRKwKrv0xz7FM9ehe67HSAtzgHF9eV2TD3A@mail.gmail.com>
Subject: Re: [PATCH] pull: abort by default if fast-forwarding is impossible
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 26, 2021 at 5:10 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> The behavior of warning but merging anyway is difficult to explain to
> users because it sends mixed signals. End the confusion by firmly
> requiring the user to specify whether they want a merge or a rebase.

I would use some of Junio's wording from
https://lore.kernel.org/git/xmqq360h8286.fsf@gitster.c.googlers.com/:

Given how annoying the "loudly warn but still go ahead" behaviour for
git pull's default behavior when fast-forwarding is not possible
(which was also displayed even when fast-forwarding was possible until
c525de335e ("pull: display default warning only when non-ff",
2020-12-12)), and how easy it is for existing users to have squelched
the annoyance by choosing between rebase and merge already, turn the
warning into an error.  As an added bonus, the previous behavior of
git pull was difficult to explain, and making this change helps us
simplify it.

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  Documentation/git-pull.txt | 14 +++++++++-----
>  builtin/pull.c             | 32 +++++++++++++++-----------------
>  2 files changed, 24 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index 5c3fb67c01..0fb185811e 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -16,13 +16,17 @@ DESCRIPTION
>  -----------
>
>  Incorporates changes from a remote repository into the current
> -branch.  In its default mode, `git pull` is shorthand for
> -`git fetch` followed by `git merge FETCH_HEAD`.
> +branch.  `git pull` is shorthand for `git fetch` followed by

I'd replace "shorthand for" with "shorthand for either"

> +`git merge FETCH_HEAD` or `git rebase FETCH_HEAD`.
>
>  More precisely, 'git pull' runs 'git fetch' with the given
> -parameters and calls 'git merge' to merge the retrieved branch
> -heads into the current branch.
> -With `--rebase`, it runs 'git rebase' instead of 'git merge'.
> +parameters and then, by default, attempts to fast-forward the
> +current branch to the remote branch head.  If fast-forwarding
> +is not possible because the local and remote branches have

Good to here.

> +diverged, the `--rebase` option causes 'git rebase' to be...
> +called to rebase the local branch upon the remote branch, and
> +the `--no-rebase` option causes 'git merge' to be called to
> +merge the retrieved branch heads into the current branch.

This is okay, but can we just simplify it to:

....diverged, then the user must specify whether to rebase or merge
(see the --rebase and --no-rebase flags).



While at it, we may also want to change the documentation for the
--no-rebase flag.  Instead of

--no-rebase::
    Override earlier --rebase.

which can be confusing since --rebase takes so many different choices, instead:

--no-rebase::
    This is shorthand for --rebase=false


>  <repository> should be the name of a remote repository as
>  passed to linkgit:git-fetch[1].  <refspec> can name an
> diff --git a/builtin/pull.c b/builtin/pull.c
> index e8927fc2ff..21eaebc463 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -925,20 +925,20 @@ static int get_can_ff(struct object_id *orig_head, struct object_id *orig_merge_
>         return ret;
>  }
>
> -static void show_advice_pull_non_ff(void)
> +static void die_pull_non_ff(void)
>  {
> -       advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> -                "discouraged. You can squelch this message by running one of the following\n"
> -                "commands sometime before your next pull:\n"
> -                "\n"
> -                "  git config pull.rebase false  # merge (the default strategy)\n"
> -                "  git config pull.rebase true   # rebase\n"
> -                "  git config pull.ff only       # fast-forward only\n"
> -                "\n"
> -                "You can replace \"git config\" with \"git config --global\" to set a default\n"
> -                "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> -                "or --ff-only on the command line to override the configured default per\n"
> -                "invocation.\n"));
> +       die(_("Pulling without specifying how to reconcile divergent branches is not\n"
> +             "possible. You can squelch this message by running one of the following\n"
> +             "commands sometime before your next pull:\n"
> +             "\n"
> +             "  git config pull.rebase false  # merge\n"
> +             "  git config pull.rebase true   # rebase\n"
> +             "  git config pull.ff only       # fast-forward only\n"
> +             "\n"
> +             "You can replace \"git config\" with \"git config --global\" to set a default\n"
> +             "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> +             "or --ff-only on the command line to override the configured default per\n"
> +             "invocation.\n"));
>  }
>
>  int cmd_pull(int argc, const char **argv, const char *prefix)
> @@ -1047,10 +1047,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>
>         can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
>
> -       if (rebase_unspecified && !opt_ff && !can_ff) {
> -               if (opt_verbosity >= 0)
> -                       show_advice_pull_non_ff();
> -       }
> +       if (rebase_unspecified && !opt_ff && !can_ff)
> +               die_pull_non_ff();
>
>         if (opt_rebase) {
>                 int ret = 0;
> --
> 2.32.0.95.g4a22da5c5a

The code changes look good, but you'll need to add several test
changes as well, or this code change will cause test failures.  You'll
need to go through the relevant `git pull` invocations in the
testsuite and add the --no-rebase flag.

Thanks for working on this.
