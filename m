Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD814C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 05:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A70F86136E
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 05:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbhGOFWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 01:22:04 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:44956 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbhGOFWD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 01:22:03 -0400
Received: by mail-ej1-f47.google.com with SMTP id qb4so7069644ejc.11
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 22:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqPiX9JVwx3H3KhuU8MBXqDK2Wk1mUhqE6nsd/TOL0I=;
        b=MZieeXzLDuU0Hb7HO6QKopmERX/IiuWIKESaPHzy80MG968BKIaZkiWdEllmuAC3gz
         l06lD+f4SqukkSsjwoLHSW2N/xhACFBEZcGKfXX86gmACcEnDUEyd/Kr/z4ukNOltfK3
         1oZQrQ50kn9zJEElSMc9+B6M+m1pcNimHrYJ3GdH9i9q6mMXNbE3nbo9NGj348c7FEQd
         NW618K6Rib4W/McSuV2gdwoPz9ZmDsCGM9bdrst0i65MGsqASpXMTS7Z+zrFVg/XP4Is
         HIwTv41Hauaelmwf18ksv7QoLMaiP1QeqX0v7coY0gDhRw5fMkLoG4/t9hAzxXVWp60X
         ZyvA==
X-Gm-Message-State: AOAM533JB6J/zXHqJljtvvQ4LehpLSPn2lSjcPvsp1a8OV87Clz4zudz
        I51XdyFDAl/IcOmyk6R42NOxgJcEk6PPs8uXYvE=
X-Google-Smtp-Source: ABdhPJzDIUepVDQ1FnyVN4jtT76M8PrPvo85YZnCh0Mczf0dARdbs0of7TteYqJ9laiitmrPEsvcJxXsLX0o5VdYe8I=
X-Received: by 2002:a17:906:4a0a:: with SMTP id w10mr3038262eju.371.1626326349745;
 Wed, 14 Jul 2021 22:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com> <7e12c45fc9a94e7b56a6efdc085ebe081dd40afc.1626316849.git.gitgitgadget@gmail.com>
In-Reply-To: <7e12c45fc9a94e7b56a6efdc085ebe081dd40afc.1626316849.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 15 Jul 2021 01:18:58 -0400
Message-ID: <CAPig+cQUQYrkH7YsFio=JBZnaM3FRumti6OtvOTu6cUo4kWKtg@mail.gmail.com>
Subject: Re: [PATCH 5/5] pull: abort by default when fast-forwarding is not possible
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 10:41 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> We have for some time shown a long warning when the user does not
> specify how to reconcile divergent branches with git pull.  Make it an
> error now.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

Teeny tiny nits below...

> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> @@ -15,14 +15,16 @@ SYNOPSIS
> -Incorporates changes from a remote repository into the current
> -branch.  In its default mode, `git pull` is shorthand for
> -`git fetch` followed by `git merge FETCH_HEAD`.
> -
> -More precisely, 'git pull' runs 'git fetch' with the given
> -parameters and calls 'git merge' to merge the retrieved branch
> -heads into the current branch.
> -With `--rebase`, it runs 'git rebase' instead of 'git merge'.

The original text has an odd mix of apostrophes and backticks...

> +Incorporates changes from a remote repository into the current branch.
> +If the current branch is behind the remote, then by default it will
> +fast-forward the current branch to match the remote.  If the current
> +branch and the remote have diverged, the user needs to specify how to
> +reconcile the divergent branches with --no-ff or --rebase (or the
> +corresponding configuration options in pull.ff or pull.rebase).
> +
> +More precisely, 'git pull' runs 'git fetch' with the given parameters
> +and then depending on config options or command line flags, will call
> +either 'git merge' or 'git rebase' to reconcile diverging branches.

... and the revised text adds "no quotes" to the selection. These
days, we'd probably backtick all of these:

    --no-ff
    --rebase
    pull.ff
    pull.rebase
    git pull
    git fetch
    git merge
    git rebase

The rest of this document is actually pretty good about using
backticks, though there are some exceptions.

There's also an odd mix of "configuration options" and "config
options" in the revised text. Perhaps stick with "configuration
options" to be a bit more formal?

>  <repository> should be the name of a remote repository as
>  passed to linkgit:git-fetch[1].  <refspec> can name an

And, as an aside, we'd backtick <repository> and <refspec>, though
your patch isn't touching that, so outside the scope of this change.

> diff --git a/builtin/pull.c b/builtin/pull.c
> @@ -1074,9 +1074,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>                 if (opt_ff) {
>                         if (!strcmp(opt_ff, "--ff-only"))
>                                 die_ff_impossible();
> -               } else {
> -                       if (rebase_unspecified && opt_verbosity >= 0)
> -                               show_advice_pull_non_ff();
> +               } else if (rebase_unspecified) {
> +                       die_pull_non_ff();
>                 }

When reading the previous patch, I was wondering why an `if else`
wasn't used, and here I see that it does become an `if else`. I guess
you didn't want to alter Alex's original patch?
