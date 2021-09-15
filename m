Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6082DC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4746561242
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhIORAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 13:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhIORAs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 13:00:48 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F1AC061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 09:59:29 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 6so5034138oiy.8
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WX15rv2UKXdyoDa8EtR5tzvgM/7stuoR+w4Re21amtQ=;
        b=cm+iNFAgFgRCFCLcNk8wPyFt34mrxWGgS3lNWWhrwKiPPlqxI/Zo1OPK9fN8FRnzwO
         z90zsjlUIqsJL+gItfWPAwugPUMaoFHy0MJQYCSIAeS7wz7uNgVPHdwo7zwXHJVEscDu
         OJ6VMvZ682O/jiZ0IXOhaCW5CwTrsQWGNbOb6/EyaqxijARFVNwOEoz+18VfLWD4UBGz
         lgGNU8wU8OIxrwf8/wFtiM5spnDzx6OQTGA+QKJOwUX6uN5iYPZfwv0cLIzdZXEfN6Eh
         th6XquaDod4VIWecy/f2GEHo8DOe+U/63f6Wj9/YbpLny1LwT7c3LLj6oOkNZRfaiTEp
         /h4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WX15rv2UKXdyoDa8EtR5tzvgM/7stuoR+w4Re21amtQ=;
        b=kKEP+ba2i384SYL2DRY7dXJqVf2B1gaAB1NV5EjwTC+gbKlicmtKbJlQIg2jp1Fhsx
         h3KbXnPdN8yMT0vII3V2I3siHJPlgddI49qbMme/F7aR4SQyPnNrwMB4pkCPuZFlZKOX
         xNBDQUiE3/g5HlTQxcM0Z44XZ0LLpnWdjDnqxwH1FF5y4ot8uVd2CWkCLEG9fvlrywG3
         b4r1aHKxL+Txz8xqp+6FaAZxhbLjOF3RKvPc3V6Ftdcl+p4akwK+OYxCXBu17SNeXgNZ
         C/J150IQbRMnXWcRGDbwuaOpcG6V4pSXPvsBockdU1f52PNFL4xZeL1dbUr2/SMcp6W2
         bb2g==
X-Gm-Message-State: AOAM531+n3m+UcqPKvwBZlLQXFtFrboOUCj5mru0UZ/4liXLBNOihBXk
        cK/ht9i1eb4Lb+F5wlSyvWIU0Pv916hXg0bEpeE=
X-Google-Smtp-Source: ABdhPJyXmFt+xVFHtl/V/tINQI0IXt18cg9xhR1fJVlvVuh+EBPNQZ3w1mAmKsYVCIg6XgIgzx2tBV84h1t6pTMmOtA=
X-Received: by 2002:a05:6808:2084:: with SMTP id s4mr501364oiw.31.1631725168714;
 Wed, 15 Sep 2021 09:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com> <944ae2cffa8ff175cd1cee0b3a25060ec5599973.1631453010.git.gitgitgadget@gmail.com>
In-Reply-To: <944ae2cffa8ff175cd1cee0b3a25060ec5599973.1631453010.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 15 Sep 2021 09:59:16 -0700
Message-ID: <CABPp-BFvCpfq66oJoxgABJy3LP=VNDwtd3YkTwV-nEQjXm2_Bg@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] add: implement the --sparse option
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 12, 2021 at 6:23 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> We previously modified 'git add' to refuse updating index entries
> outside of the sparse-checkout cone. This is justified to prevent users
> from accidentally getting into a confusing state when Git removes those
> files from the working tree at some later point.
>
> Unfortunately, this caused some workflows that were previously possible
> to become impossible, especially around merge conflicts outside of the
> sparse-checkout cone. These were documented in tests within t1092.
>
> We now re-enable these workflows using a new '--sparse' option to 'git
> add'. This allows users to signal "Yes, I do know what I'm doing with
> these files," and accept the consequences of the files leaving the
> worktree later.
>
> We delay updating the advice message until implementing a similar option
> in 'git rm' and 'git mv'.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-add.txt                |  9 +++++++-
>  builtin/add.c                            | 12 +++++++----
>  t/t1092-sparse-checkout-compatibility.sh | 27 ++++++++----------------
>  t/t3705-add-sparse-checkout.sh           | 17 ++++++++++++++-
>  4 files changed, 41 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index be5e3ac54b8..bb79016d2ca 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
> -         [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]
> +         [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]] [--sparse]
>           [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
>           [--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
>           [--] [<pathspec>...]
> @@ -79,6 +79,13 @@ in linkgit:gitglossary[7].
>  --force::
>         Allow adding otherwise ignored files.
>
> +--sparse::
> +       Allow updating index entries outside of the sparse-checkout cone.
> +       Normally, `git add` refuses to update index entries whose paths do
> +       not fit within the sparse-checkout cone, since those files might
> +       be removed from the working tree without warning. See
> +       linkgit:git-sparse-checkout[1] for more.

for more ...?  details?  I find the last sentence incomplete.

Following that track for a moment and thinking out loud, I wonder if
we want more details somewhere in the sparse-checkout docs about this
issue and if so, if we should point to that specific part of that
page.  The 'reapply' section of the sparse-checkout page kind of
touches on the topic of the worktree not exactly matching sparsity
patterns (due to other commands), but focuses on unsparsifying files
due to conflicts and kind of ignores the re-sparsification that
happens in other commands after the working copy matches the index.
(Such a documentation improvement could come after your series, as I
said, I'm just thinking out loud.)

> +
>  -i::
>  --interactive::
>         Add modified contents in the working tree interactively to
> diff --git a/builtin/add.c b/builtin/add.c
> index 09c3fad6321..f8e3930608d 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -30,6 +30,7 @@ static int patch_interactive, add_interactive, edit_interactive;
>  static int take_worktree_changes;
>  static int add_renormalize;
>  static int pathspec_file_nul;
> +static int include_sparse;
>  static const char *pathspec_from_file;
>  static int legacy_stash_p; /* support for the scripted `git stash` */
>
> @@ -46,7 +47,7 @@ static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
>                 struct cache_entry *ce = active_cache[i];
>                 int err;
>
> -               if (ce_skip_worktree(ce))
> +               if (!include_sparse && ce_skip_worktree(ce))
>                         continue;
>
>                 if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
> @@ -95,7 +96,7 @@ static void update_callback(struct diff_queue_struct *q,
>                 struct diff_filepair *p = q->queue[i];
>                 const char *path = p->one->path;
>
> -               if (!path_in_sparse_checkout(path, &the_index))
> +               if (!include_sparse && !path_in_sparse_checkout(path, &the_index))
>                         continue;
>
>                 switch (fix_unmerged_status(p, data)) {
> @@ -383,6 +384,7 @@ static struct option builtin_add_options[] = {
>         OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
>         OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
>         OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
> +       OPT_BOOL(0, "sparse", &include_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
>         OPT_STRING(0, "chmod", &chmod_arg, "(+|-)x",
>                    N_("override the executable bit of the listed files")),
>         OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
> @@ -461,7 +463,8 @@ static int add_files(struct dir_struct *dir, int flags)
>         }
>
>         for (i = 0; i < dir->nr; i++) {
> -               if (!path_in_sparse_checkout(dir->entries[i]->name, &the_index)) {
> +               if (!include_sparse &&
> +                   !path_in_sparse_checkout(dir->entries[i]->name, &the_index)) {
>                         string_list_append(&matched_sparse_paths,
>                                            dir->entries[i]->name);
>                         continue;
> @@ -646,7 +649,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>                         if (seen[i])
>                                 continue;
>
> -                       if (matches_skip_worktree(&pathspec, i, &skip_worktree_seen)) {
> +                       if (!include_sparse &&
> +                           matches_skip_worktree(&pathspec, i, &skip_worktree_seen)) {
>                                 string_list_append(&only_match_skip_worktree,
>                                                    pathspec.items[i].original);
>                                 continue;
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 0fdc5c7098c..7d64d9deb22 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -343,11 +343,7 @@ test_expect_success 'commit including unstaged changes' '
>         test_all_match git status --porcelain=v2
>  '
>
> -# NEEDSWORK: Now that 'git add folder1/new' fails, the changes being
> -# attempted here fail for the sparse-checkout and sparse-index repos.
> -# We must enable a way for adding files outside the sparse-checkout
> -# done, even if it is by an optional flag.
> -test_expect_failure 'status/add: outside sparse cone' '
> +test_expect_success 'status/add: outside sparse cone' '
>         init_repos &&
>
>         # folder1 is at HEAD, but outside the sparse cone
> @@ -375,15 +371,16 @@ test_expect_failure 'status/add: outside sparse cone' '
>         test_sparse_match test_must_fail git add folder1/new &&
>         test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
>         test_sparse_unstaged folder1/new &&
> +       test_sparse_match git add --sparse folder1/a &&
> +       test_sparse_match git add --sparse folder1/new &&
>
> -       # NEEDSWORK: behavior begins to deviate here.
> -       test_all_match git add . &&
> +       test_all_match git add --sparse . &&
>         test_all_match git status --porcelain=v2 &&
>         test_all_match git commit -m folder1/new &&
>         test_all_match git rev-parse HEAD^{tree} &&
>
>         run_on_all ../edit-contents folder1/newer &&
> -       test_all_match git add folder1/ &&
> +       test_all_match git add --sparse folder1/ &&
>         test_all_match git status --porcelain=v2 &&
>         test_all_match git commit -m folder1/newer &&
>         test_all_match git rev-parse HEAD^{tree}
> @@ -527,12 +524,7 @@ test_expect_success 'merge, cherry-pick, and rebase' '
>         done
>  '
>
> -# NEEDSWORK: This test is documenting current behavior, but that
> -# behavior can be confusing to users so there is desire to change it.
> -# Right now, users might be using this flow to work through conflicts,
> -# so any solution should present advice to users who try this sequence
> -# of commands to follow whatever new method we create.
> -test_expect_failure 'merge with conflict outside cone' '
> +test_expect_success 'merge with conflict outside cone' '

Based on the comments on the next hunk, I also wonder if this hunk
doesn't belong in the previous commit...

>         init_repos &&
>
>         test_all_match git checkout -b merge-tip merge-left &&
> @@ -555,9 +547,6 @@ test_expect_failure 'merge with conflict outside cone' '
>         # 3. Rename the file to another sparse filename and
>         #    accept conflict markers as resolved content.
>         run_on_all mv folder2/a folder2/z &&
> -       # NEEDSWORK: This mode now fails, because folder2/z is
> -       # outside of the sparse-checkout cone and does not match an
> -       # existing index entry with the SKIP_WORKTREE bit cleared.
>         test_sparse_match test_must_fail git add folder2 &&
>         test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
>         test_sparse_unstaged folder2/z &&

Is this hunk in the wrong commit?  You added a --sparse flag to the
git add a few lines below in the previous commit, so it seems the
NEEDSWORK comment should have been removed at the same time.

> @@ -569,7 +558,7 @@ test_expect_failure 'merge with conflict outside cone' '
>         test_all_match git rev-parse HEAD^{tree}
>  '
>
> -test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
> +test_expect_success 'cherry-pick/rebase with conflict outside cone' '
>         init_repos &&
>
>         for OPERATION in cherry-pick rebase
> @@ -592,6 +581,7 @@ test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
>                 test_sparse_match test_must_fail git add folder1/a &&
>                 test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
>                 test_sparse_unstaged folder1/a &&
> +               test_all_match git add --sparse folder1/a &&
>                 test_all_match git status --porcelain=v2 &&
>
>                 # 3. Rename the file to another sparse filename and
> @@ -603,6 +593,7 @@ test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
>                 test_sparse_match test_must_fail git add folder2 &&
>                 test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
>                 test_sparse_unstaged folder2/z &&
> +               test_all_match git add --sparse folder2 &&
>                 test_all_match git status --porcelain=v2 &&
>
>                 test_all_match git $OPERATION --continue &&
> diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
> index 678be1acbf9..0f7e03b5326 100755
> --- a/t/t3705-add-sparse-checkout.sh
> +++ b/t/t3705-add-sparse-checkout.sh
> @@ -167,7 +167,13 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
>
>         git update-index --no-skip-worktree sparse_entry &&
>         test_must_fail git add sparse_entry &&
> -       test_sparse_entry_unstaged
> +       test_sparse_entry_unstaged &&
> +
> +       # Avoid munging CRLFs to avoid an error message
> +       git -c core.autocrlf=input add --sparse sparse_entry 2>stderr &&
> +       test_must_be_empty stderr &&
> +       test-tool read-cache --table >actual &&
> +       grep "^100644 blob.*sparse_entry\$" actual

Does this CRLF anti-munging belong in a separate commit somewhere?  I
was surprised to see it, and it's not clear to me how it relates to
the other changes.  Am I missing something?

>  '
>
>  test_expect_success 'add obeys advice.updateSparsePath' '
> @@ -178,4 +184,13 @@ test_expect_success 'add obeys advice.updateSparsePath' '
>
>  '
>
> +test_expect_success 'add allows sparse entries with --sparse' '
> +       git sparse-checkout set a &&
> +       echo modified >sparse_entry &&
> +       test_must_fail git add sparse_entry &&
> +       test_sparse_entry_unchanged &&
> +       git add --sparse sparse_entry 2>stderr &&
> +       test_must_be_empty stderr
> +'
> +
>  test_done
> --
> gitgitgadget
