Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE88C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 07:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbiBYHqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 02:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiBYHqY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 02:46:24 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE0F2272F4
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 23:45:53 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p15so9153215ejc.7
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 23:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7+ioN8UNMxmcSUkAe55HYTYhbZBEEhryrqWe9g7HA3k=;
        b=iIfnwbkZIhgCgvkvW8acnCzw6h12h0lntZjr6ZpuoBkdWyCB0WnPKnj3HKezl7SSFW
         Hwnlvan95z8TBEPNFdccF6lDyNrDkUZ9WsQBXgOONVMRzSyj9X9Mz3vIuObPXk19Gl2+
         /NMIDkqLPjmsGqH8W2QqLRqo26aJgMfWMbZlKqVlh78x4G1E3Yk0wOCU06A6UCek4aiD
         pUEt5i+p3+i+gEJqasrltK1mbfMP0tpUmjJHNGV8b6SKhcIKi6ciXwxcI16eOrRNLSXS
         r1fRuNPus32dW/L59WHCrxbFPLLxQZUphP0X7AMbbJ3K/7qnP0IpN9Tn56BJkBo2qVkj
         l+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7+ioN8UNMxmcSUkAe55HYTYhbZBEEhryrqWe9g7HA3k=;
        b=Gp5WJhq6UJjb2IMkalwet7B4/FXkwA6h8g8Q6ZKLfdvjeq4a0oVXg0jodlYRw3xcbr
         IiFJ0DWK8BOHsG8AscSBYPIDqQz7PSyqHtcHGjLrianGOBtWfM5seGlz9oddtexLNzij
         yAAiQnvMtd35hgnhWBYicZZQcOd+nwrWQ4YJuKbvYdIHFI7NSdI4PcZLjp0rMbsjcFTQ
         kaBwIkti2p5B7qte02YADzPfyS1eOhZ++NkaN7lhH3SuJK3TsabBwzcFnXvyp4QpLB4e
         1t8WBc0hWb4QFNDpkT5cbRp6YPqt/t9HgDyvPsmtEk5lzi+FA/evLe5p0P9+cJrn8idk
         qWBw==
X-Gm-Message-State: AOAM533ZKlNXRVvtujj4E87tDQWm+D8uMmRkA2aeh9jUIkaEl1evUtGd
        kWlqufsTKgzupb3OXWY7ZRUPZstSlXxTrL3KXFw=
X-Google-Smtp-Source: ABdhPJw67FibJgEitf+z0/v9UsjAypoKV3y/bNWFmF4i5/dd2jQR1S+YVdYUQS4z9tFn73uH5WpT4r4gyvlOdKDQYX0=
X-Received: by 2002:a17:906:a855:b0:6cd:ba20:39c5 with SMTP id
 dx21-20020a170906a85500b006cdba2039c5mr5011218ejb.100.1645775151633; Thu, 24
 Feb 2022 23:45:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
 <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com> <f0cff03b95d574dff414a63325a0f1c6d2d1ff96.1645742073.git.gitgitgadget@gmail.com>
In-Reply-To: <f0cff03b95d574dff414a63325a0f1c6d2d1ff96.1645742073.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 24 Feb 2022 23:45:40 -0800
Message-ID: <CABPp-BGLG15g1UYanaNy=zM320DEYWW52xKNRDA_87mcVXWhYQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] status: fix nested sparse directory diff in sparse index
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 24, 2022 at 2:34 PM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Victoria Dye <vdye@github.com>
>
> Add the 'recursive' flag to 'wt_status_collect_changes_index(...)'. Without

Perhaps "Set the 'recursive' diff option flag in
'wt_status_collect_changes_index(...)'" ?  There's no function
argument named 'recursive' in wt_status_collect_changes_index() before
or after your changes, which is what the wording led me to think of.

> the 'recursive' flag, 'git status' could report index changes incorrectly
> when the following conditions were met:
>
> * sparse index is enabled
> * there is a difference between the index and HEAD in a file inside a
>   *subdirectory* of a sparse directory
> * the sparse directory index entry is *not* expanded in-core
>
> In this scenario, 'git status' would not recurse into the sparse directory's
> subdirectories to identify which file contained the difference between the
> index and HEAD. Instead, it would report the immediate subdirectory itself
> as "modified".
>
> Example:
>
> $ git init
> $ mkdir -p sparse/sub
> $ echo test >sparse/sub/foo
> $ git add .
> $ git commit -m "commit 1"
> $ echo somethingelse >sparse/sub/foo
> $ git add .
> $ git commit -a -m "commit 2"
> $ git sparse-checkout set --cone --sparse-index 'sparse'
> $ git reset --soft HEAD~1
> $ git status
> On branch master
> You are in a sparse checkout.
>
> Changes to be committed:
>   (use "git restore --staged <file>..." to unstage)
>         modified:   sparse/sub
>
> The 'recursive' diff option in 'wt_status_collect_changes_index' corrects
> this by indicating that 'git status' should recurse into sparse directories
> to find modified files. Given the same repository setup as the example
> above, the corrected result of `git status` is:
>
> $ git status
> On branch master
> You are in a sparse checkout.
>
> Changes to be committed:
>   (use "git restore --staged <file>..." to unstage)
>         modified:   sparse/sub/foo
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 7 +++++++
>  wt-status.c                              | 9 +++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 9ef7cd80885..b1dcaa0e642 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -278,6 +278,13 @@ test_expect_success 'status with options' '
>         test_all_match git status --porcelain=v2 -uno
>  '
>
> +test_expect_success 'status with diff in unexpanded sparse directory' '
> +       init_repos &&
> +       test_all_match git checkout rename-base &&
> +       test_all_match git reset --soft rename-out-to-out &&
> +       test_all_match git status --porcelain=v2
> +'
> +
>  test_expect_success 'status reports sparse-checkout' '
>         init_repos &&
>         git -C sparse-checkout status >full &&
> diff --git a/wt-status.c b/wt-status.c
> index 335e723a71e..4a5b9beeca1 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -651,6 +651,15 @@ static void wt_status_collect_changes_index(struct wt_status *s)
>         rev.diffopt.detect_rename = s->detect_rename >= 0 ? s->detect_rename : rev.diffopt.detect_rename;
>         rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
>         rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
> +
> +       /*
> +        * The `recursive` option must be enabled to show differences in files
> +        * *more than* one level deep in a sparse directory index entry (e.g., given
> +        * sparse directory 'sparse-dir/', reporting a difference in the file
> +        * 'sparse-dir/another-dir/my-file').
> +        */
> +       rev.diffopt.flags.recursive = 1;

Kind of clever, and makes sense.

I'm wondering if there's an alternate wording that might be helpful
here or in the commit message, that instead of just saying the
'recursive' option is necessary, perhaps says a little bit about why
it helps.  In particular, the diff machinery, by default, is not
recursive and stops at comparing the first level of trees.  (See e.g.
the -r option in diff-tree, it's just that it's turned on by default
in 'git diff' and by the -p option in 'git log'.)  I'm guessing the
recursive option never needed to be turned on previously within
wt-status, due to something about the nature of the index only holding
files previously.  Now, however, the sparse index changes that.  (And
it also suggests that perhaps we should look to see if other commands
run the diff machinery without the recursive flag, and see if they
need it now due to sparse indices.)

Granted, I'm not totally sure how to work these facts in (in part
because I don't know how comparison to the index normally avoids the
need for the recursive flag), and maybe what you have is fine.  Just
thought I'd point it out since I wasn't aware of the non-recursive
nature of the diff machinery until I started doing things with
diff-tree.


> +
>         copy_pathspec(&rev.prune_data, &s->pathspec);
>         run_diff_index(&rev, 1);
>         object_array_clear(&rev.pending);
> --
> gitgitgadget
