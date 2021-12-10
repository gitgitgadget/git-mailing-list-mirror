Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940E4C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 08:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbhLJIia (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 03:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbhLJIia (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 03:38:30 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491C1C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 00:34:55 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id d10so19685022ybe.3
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 00:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDvpWcZGGpGgRQehOxwqP1XtwBkXoQP/zH+jM3855sg=;
        b=ECIlyelGLsFPE/MdgDWuiAScTg/9CV1MS9a7xIxXi5igB86UHFCbXYjkig0NLIWCCl
         A8qooDOVWdW0EnynXcAMAZ2BoxBgEikNBNgx0Ow03idGPTh/Gk2VpUwad6CB9l3FvSpm
         NpsYcqFiZ5mLlO43k/aA1hQLxh7VGgbqeOzZ6gg6TkbouryYX2+/SGQV5fQql5nLyzzn
         e8QvR13BoyppKk+/4tcH8DT/CqXVwfYAa23iwj9yWMqj7iNgLkAaSJuyCHJlJoIvejTH
         1NhBq1plZRsuxoJcseIlzlKic/aV0Is49grEvVk9huAX7buUi/ulTYJ+ziJm0wOK6ZyO
         jfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDvpWcZGGpGgRQehOxwqP1XtwBkXoQP/zH+jM3855sg=;
        b=k1HWzC2in/m+tZHSkWqSUaOlUxoleR95Mq9nUltgOZ/Ss2hhmet3HLdfTvDFrlVenL
         gH/z9K0lrs4neEysfgUTBP280s3Rnn6JfGga/BiWL7vu6YZUnMernsqnlFiL8b0+1PT5
         kEu+eb8Agwj3Wh5+gOIfIDMaXNbHnZio9Xs6bZIo5LtqNvnV+97xVtx/PL9kyxXTi+WY
         PW/YY0PYXFuTcuyZg2GXNddXR5MoENms4NY8sjMJqiCPk987TFtxoNnNlHX+0OzAxLoq
         NsDmGTC0uyfpjFgfmC9A779uEHMQDATGhRwEu2ohf7kb7TOHi3Tf3fPp+Uf2FyLxlwFU
         NQMw==
X-Gm-Message-State: AOAM53025jmRjdMK5ylixwVcm9prqM+XabZ909crYK+d50qjJc9L2qx3
        aBfqifhiFb+k4dZqfO11gSa66GNO9C5ApoeFU9E=
X-Google-Smtp-Source: ABdhPJxZT1dgp860UBjDcxcTmdq+kehWZHvibYI0L26A4eTupEkQI5HKYt3EdTGE5ASU3V67RkYehCf0KIMof+fUH1w=
X-Received: by 2002:a25:8609:: with SMTP id y9mr12423760ybk.50.1639125294393;
 Fri, 10 Dec 2021 00:34:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.1095.git.1639117329.gitgitgadget@gmail.com> <254b352e31029d8151eb6a974fdf8c127340cf79.1639117329.git.gitgitgadget@gmail.com>
In-Reply-To: <254b352e31029d8151eb6a974fdf8c127340cf79.1639117329.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 10 Dec 2021 09:34:43 +0100
Message-ID: <CAP8UFD0MK++3QdMAvJ6Az0LZyXUWXRJcRQPG1THKw4CFW0yRLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkout: introduce "--to-branch" option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 7:22 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> When we want checkout to a branch (e.g. dev1) which reference
> to a commit, but sometimes we only remember the tag (e.g. v1.1)
> on it, we will use `git checkout v1.1` to find the commit first,
> git will be in the state of deatching HEAD, so we have to search the

s/deatching/detached/

It's possible, and likely faster, to use something like `git log -1
v1.1` or `git show <sha>` to see which branches point to the tag or
commit, as the branches are added as decoration to the output.

> branches on the commit and checkout the branch we perfer. This will

s/perfer/prefer/

> be a bit cumbersome.
>
> Introduce "--to-branch" option, `git checkout --to-branch <tag>`
> and `git checkout --to-branch <commit>` will search all branches
> and find a unique branch reference to the commit (or the commit which
> the tag reference to) and checkout to it. If the commit have more

s/have/has/

> than one branches, it will report error "here are more than one

s/branches/branch/

> branch on commit".

Maybe reporting something like "more than one branch point to commit
XXX" would be a bit better.

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  Documentation/git-checkout.txt |  8 +++-
>  builtin/checkout.c             | 33 +++++++++++++
>  t/t2018-checkout-branch.sh     | 85 ++++++++++++++++++++++++++++++++++
>  t/t9902-completion.sh          |  1 +
>  4 files changed, 126 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index d473c9bf387..2a240699fd9 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  [verse]
>  'git checkout' [-q] [-f] [-m] [<branch>]
>  'git checkout' [-q] [-f] [-m] --detach [<branch>]
> -'git checkout' [-q] [-f] [-m] [--detach] <commit>
> +'git checkout' [-q] [-f] [-m] [--detach] [-w|--to-branch] <commit>

It's a bit strange that --detach can be used along with the new
option, as the purpose of the new option is to not detach. It makes
one wonder what happens when both --detach and --to-branch are used.

I wonder if all the following lines:

      git checkout [-q] [-f] [-m] [<branch>]
      git checkout [-q] [-f] [-m] --detach [<branch>]
      git checkout [-q] [-f] [-m] [--detach] <commit>

could be replaced with just:

      git checkout [-q] [-f] [-m] [--detach|--to-branch] <commitish>

>  'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
>  'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...
>  'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]
> @@ -210,6 +210,12 @@ variable.
>         `<commit>` is not a branch name.  See the "DETACHED HEAD" section
>         below for details.
>
> +-w::
> +--to-branch::

Using a short option name like "-w" might not be a good idea at this
point. Maybe if many people use the long option a lot, they will want
a short option name, but we can add it then instead of using one of
the few left right now.

> +       Rather than checking out a commit to work on it, checkout out

"checking out a commit to work on it" might not describe well that it
works when we pass a tag too and that we checkout the underlying
commit in the detached HEAD mode by default.

> +       to the unique branch on it. If there are multiple branches on
> +       the commit, the checkout will fail.

It might be a bit better to say that a branch "points to" a commit,
rather than that it is "on" a commit.

>  --orphan <new_branch>::
>         Create a new 'orphan' branch, named `<new_branch>`, started from
>         `<start_point>` and switch to it.  The first commit made on this
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 3eeac3147f2..696248b05c0 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -28,6 +28,7 @@
>  #include "xdiff-interface.h"
>  #include "entry.h"
>  #include "parallel-checkout.h"
> +#include "../ref-filter.h"

Are you sure that "../" is needed above?

>  static const char * const checkout_usage[] = {
>         N_("git checkout [<options>] <branch>"),
> @@ -70,6 +71,7 @@ struct checkout_opts {
>         int empty_pathspec_ok;
>         int checkout_index;
>         int checkout_worktree;
> +       int to_branch;
>         const char *ignore_unmerged_opt;
>         int ignore_unmerged;
>         int pathspec_file_nul;
> @@ -1512,6 +1514,35 @@ static int checkout_branch(struct checkout_opts *opts,
>                     (flag & REF_ISSYMREF) && is_null_oid(&rev))
>                         return switch_unborn_to_new_branch(opts);
>         }
> +       if (opts->to_branch) {
> +               struct ref_filter filter;
> +               struct ref_array array;
> +               int i;
> +               int count = 0;
> +               const char *unused_pattern = NULL;
> +
> +               memset(&array, 0, sizeof(array));
> +               memset(&filter, 0, sizeof(filter));
> +               filter.kind = FILTER_REFS_BRANCHES;
> +               filter.name_patterns = &unused_pattern;
> +               filter_refs(&array, &filter, filter.kind);
> +               for (i = 0; i < array.nr; i++) {
> +                       if (oideq(&array.items[i]->objectname, &new_branch_info->oid)) {
> +                               if (count)
> +                                       die(_("here are more than one branch on commit %s"), oid_to_hex(&new_branch_info->oid));
> +                               count++;
> +                               if (new_branch_info->refname)
> +                                       free((char *)new_branch_info->refname);
> +                               new_branch_info->refname = xstrdup(array.items[i]->refname);
> +                               if (new_branch_info->path)
> +                                       free((char *)new_branch_info->path);
> +                               new_branch_info->path = xstrdup(array.items[i]->refname);
> +                               new_branch_info->name = new_branch_info->path;
> +                       }
> +               }
> +               ref_array_clear(&array);

It might be my personal taste, but I would find it cleaner and easier
to understand if a separate function to find the branch we are looking
for was called, instead of adding all the code here.

> +       }
> +
>         return switch_branches(opts, new_branch_info);
>  }
>
> @@ -1797,6 +1828,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>                 OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
>                 OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
>                          N_("second guess 'git checkout <no-such-branch>' (default)")),
> +               OPT_BOOL('w', "to-branch", &opts.to_branch,
> +                        N_("checkout to a branch from a commit or a tag")),
>                 OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
>                 OPT_END()
>         };
> diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
> index 93be1c0eae5..53e45cfe7fd 100755
> --- a/t/t2018-checkout-branch.sh
> +++ b/t/t2018-checkout-branch.sh

I plan to look at the tests after we decide how the new option relates
to --detach.

Thanks!
