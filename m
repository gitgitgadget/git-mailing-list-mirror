Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E3C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbhKVSjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbhKVSjn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:39:43 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3D7C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:36:35 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w1so81234328edc.6
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Szfh/r0FufA8tTHBzX5QwW3ws9u9HfFgcrpuiN47oc4=;
        b=Rq8xY0Vaz7AC5b/5CHUQuYshgF2kz1MZoGTpamjwiTIfNyqy9UVSFLNpZQhzgO2N7G
         DtGfxVb0O17JdbPKYVJUM+1hhNlNjjvh6r4pWslj9PY1+yFJ+L5WVA/qsfUiMwsWF8Gp
         LRPqfFZSEQKANdIZ39oWFZqaBN6+NCP+lI5ljNngLI1P61zRYX9xLCSxBTgqgCeltPdA
         3CDyZgjdty/QcJ4oV9uKqfVUX2i4C6sY5PPJW/a+1AAg2ZMfDeml5H1jP/ax36mWttdm
         k2As7rmNdiFnzcl8siCc3lY5zPXqBc36gHtaqApVZoi22A05YP38oiDug0HgYc7q9WZs
         L0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Szfh/r0FufA8tTHBzX5QwW3ws9u9HfFgcrpuiN47oc4=;
        b=Hppn+QkuUeKroaDoCedmSnqyTxqQzsWh78BCOcYxnI6u+zEN3yr0cfP1f+rDg2Xqh3
         /Gtp1lVzIYGn9e8Pdiuocwvnz4LaEq/lpeS8+lrKEucLRA4VxFFaS4RyYh9V+kdOYStA
         nwaNZ+qerU9wMhYoVmrCXOaUOBlVUi1qjiE0INA/mszIgOgBJGy546ZuidhPiJrGhpmL
         dDyWSLHhz/9sARYLxbuVXY/fkcAW1J4/Sp7PL5tEw28jmn8bWDI1OgPLkyF4tQKR+PO1
         EBehd9MlPGH+bYyh5ooxXUgWIv/VME7xXm1/swGJdOQMPdZIkOVJIGl6ntz3T2OMYw+T
         IpWg==
X-Gm-Message-State: AOAM530qJgngt7UH1UMwfGMiVnmEdUc1Gp2MFSOUI8iF7yCv/ijX/K8G
        VsAfsdO7uoEVya81BbcTRpHnhvjxDfDfbbKwFNg=
X-Google-Smtp-Source: ABdhPJyC9Q4GdE1MG5VpN6GOpWDeNRv/zWOoNQqG7HAd3lxhdxoFXoBDhXhSu/Uh+OeiUjYAf32kyOfHS7IaPIEQY6w=
X-Received: by 2002:a17:906:4c9:: with SMTP id g9mr43300351eja.172.1637606193367;
 Mon, 22 Nov 2021 10:36:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com> <e42c0feec94de0e4869cda1fc6b28bd7055774e3.1637077083.git.gitgitgadget@gmail.com>
In-Reply-To: <e42c0feec94de0e4869cda1fc6b28bd7055774e3.1637077083.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Nov 2021 10:36:21 -0800
Message-ID: <CABPp-BFnFpzwGC11TLoLs8YK5yiisA5D5-fFjXnJsbESVDwZsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ls-files: add --sparse option
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 7:38 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Existing callers to 'git ls-files' are expecting file names, not
> directories. It is best to expand a sparse index to show all of the
> contained files in this case.
>
> However, expert users may want to inspect the contents of the index
> itself including which directories are sparse. Add a --sparse option to
> allow users to request this information.
>
> During testing, I noticed that options such as --modified did not affect
> the output when the files in question were outside the sparse-checkout
> definition. Tests are added to document this preexisting behavior and
> how it remains unchanged with the sparse index and the --sparse option.

Sure, 'git diff' and 'git status' don't show anything for such files
either; we're being consistent.  However, this feels like it's
normalizing an erroneous condition, possibly starting to cement one of
the bigger UI problems we have the sparse-checkout (and sparse-index):

I assert that: Having tracked files be SKIP_WORKTREE despite having a
file present in the working directory is typically an *error*, and one
that we need to help users prevent/discover/recover-from.

* I've seen users get into this condition by doing the equivalent of
either 'git sparse-checkout disable' or 'git sparse-checkout set
$NEW_PATHS' and then hit Ctrl-C in the middle of its operation.
* Users also just occasionally copy files from other places (maybe
even `git show REVISION:FILE >FILE`), and potentially edit.

In either of the above cases:
* There is no command provided for discovering these files; not diff,
status, ls-files, or anything
* There is no command provided for correcting the problem; not clean,
not reset, or anything.  They have to do it by hand
* There are ample opportunities for the error to propagate and grow,
due to the fact that these files will not be reported or updated.[1]

[1] For example, the user may first either switch to another branch or
resets to some other commit.  Neither of those operations update these
erroneous present-despite-SKIP_WORKTREE files.  And there will still
be nothing that reports them.  But now the files are out-of-date with
respect to the new commit.  Now if the user disables or changes the
sparse checkout, they suddenly have several "changed" files in their
working tree -- which they didn't touch.  In the best case, they run
diff or status or something and notice the files and then correct it,
and just get perplexed at where the changes came from.  But with
enough users, some percentage of them are just going to commit (some
of) those changes.  When someone else asks why they modified those
files, they'll (correctly, as it turns out) claim they never did and
that no program on their system did.  They might even think those
files weren't part of the commit and claim that git modified the
commit behind their back, which would be wrong, but there won't be any
reasonable logs to check to prove what happened.


I know this issue is out of scope for your series here, but the
addition of testcases that purposely set up an erroneous condition
makes it feel like we're trying to normalize that situation and not
treat it like an error, and are perhap undercutting future attempts to
try to fix it.  I'd rather have it explicitly stated that we're
setting up an erroneous condition in our tests, in order to make sure
we handle it as best as we can so far -- in a manner in line with diff
and grep -- but also note that later solutions to this deeper issue
may affect one or more of these commands.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-ls-files.txt           |  4 ++
>  builtin/ls-files.c                       | 12 +++++-
>  t/t1092-sparse-checkout-compatibility.sh | 47 ++++++++++++++++++++++++
>  3 files changed, 61 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index 6d11ab506b7..1c5d5f85ec5 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -187,6 +187,10 @@ Both the <eolinfo> in the index ("i/<eolinfo>")
>  and in the working tree ("w/<eolinfo>") are shown for regular files,
>  followed by the  ("attr/<eolattr>").
>
> +--sparse::
> +       If the index is sparse, show the sparse directories without expanding
> +       to the contained files.
> +
>  \--::
>         Do not interpret any more arguments as options.
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 031fef1bcaa..c151eb1fb77 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -37,6 +37,7 @@ static int debug_mode;
>  static int show_eol;
>  static int recurse_submodules;
>  static int skipping_duplicates;
> +static int show_sparse_dirs;
>
>  static const char *prefix;
>  static int max_prefix_len;
> @@ -315,8 +316,10 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
>
>         if (!(show_cached || show_stage || show_deleted || show_modified))
>                 return;
> -       /* TODO: audit for interaction with sparse-index. */
> -       ensure_full_index(repo->index);
> +
> +       if (!show_sparse_dirs)
> +               ensure_full_index(repo->index);
> +
>         for (i = 0; i < repo->index->cache_nr; i++) {
>                 const struct cache_entry *ce = repo->index->cache[i];
>                 struct stat st;
> @@ -670,6 +673,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>                 OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
>                 OPT_BOOL(0, "deduplicate", &skipping_duplicates,
>                          N_("suppress duplicate entries")),
> +               OPT_BOOL(0, "sparse", &show_sparse_dirs,
> +                        N_("show sparse directories in the presence of a sparse index")),
>                 OPT_END()
>         };
>         int ret = 0;
> @@ -677,6 +682,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>         if (argc == 2 && !strcmp(argv[1], "-h"))
>                 usage_with_options(ls_files_usage, builtin_ls_files_options);
>
> +       prepare_repo_settings(the_repository);
> +       the_repository->settings.command_requires_full_index = 0;
> +
>         prefix = cmd_prefix;
>         if (prefix)
>                 prefix_len = strlen(prefix);
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index f8a8dde60af..ffb6052ff60 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -814,6 +814,12 @@ test_expect_success 'sparse-index is expanded and converted back' '
>         GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
>                 git -C sparse-index reset -- folder1/a &&
>         test_region index convert_to_sparse trace2.txt &&
> +       test_region index ensure_full_index trace2.txt &&
> +
> +       # ls-files expands on read, but does not write.
> +       rm trace2.txt &&
> +       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +               git -C sparse-index ls-files &&
>         test_region index ensure_full_index trace2.txt
>  '
>
> @@ -838,6 +844,7 @@ test_expect_success 'sparse-index is not expanded' '
>         init_repos &&
>
>         ensure_not_expanded status &&
> +       ensure_not_expanded ls-files --sparse &&

Do we also want a
    ensure_not_expanded ls-files &&
?  We don't expect ls-files to write a new index file in any scenario, right?

>         ensure_not_expanded commit --allow-empty -m empty &&
>         echo >>sparse-index/a &&
>         ensure_not_expanded commit -a -m a &&
> @@ -942,6 +949,46 @@ test_expect_success 'sparse index is not expanded: fetch/pull' '
>         ensure_not_expanded pull full base
>  '
>
> +test_expect_success 'ls-files' '
> +       init_repos &&
> +
> +       # Behavior agrees by default. Sparse index is expanded.
> +       test_all_match git ls-files &&
> +
> +       # With --sparse, the sparse index data changes behavior.
> +       git -C sparse-index ls-files --sparse >sparse-index-out &&
> +       grep "^folder1/\$" sparse-index-out &&
> +       grep "^folder2/\$" sparse-index-out &&
> +
> +       # With --sparse and no sparse index, nothing changes.
> +       git -C sparse-checkout ls-files --sparse >sparse-checkout-out &&
> +       grep "^folder1/0/0/0\$" sparse-checkout-out &&
> +       ! grep "/\$" sparse-checkout-out &&

I'd be tempted to split the test up to this point from the rest of the test.

> +
> +       write_script edit-content <<-\EOF &&
> +       mkdir folder1 &&
> +       echo content >>folder1/a
> +       EOF
> +       run_on_sparse ../edit-content &&

As above, since folder1/a is a tracked file, I'd rather we explicitly
called out that we're intentionally setting up an erroneous condition.

> +
> +       # ls-files does not notice modified files whose
> +       # cache entries are marked SKIP_WORKTREE.

...nor does diff, status, etc., as per my lengthy comment from the
beginning of the email.

> +       test_sparse_match git ls-files --modified &&
> +       test_must_be_empty sparse-checkout-out &&
> +       test_must_be_empty sparse-index-out &&
> +
> +       git -C sparse-index ls-files --sparse --modified >sparse-index-out &&
> +       test_must_be_empty sparse-index-out &&
> +
> +       run_on_sparse git sparse-checkout add folder1 &&
> +       test_sparse_match git ls-files --modified &&
> +       grep "^folder1/a\$" sparse-checkout-out &&
> +       grep "^folder1/a\$" sparse-index-out &&
> +
> +       # Double-check index expansion
> +       ensure_not_expanded ls-files --sparse
> +'
> +
>  # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
>  # in this scenario, but it shouldn't.
>  test_expect_success 'reset mixed and checkout orphan' '
> --
> gitgitgadget


Other than my concerns about careful messages with erroneous
conditions (and the minor question about also having a
ensure_not_expanded without the --sparse flag), the patch looks good
to me.
