Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5DFC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 16:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbiAGQff (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 11:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240146AbiAGQfc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 11:35:32 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A63FC061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 08:35:32 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id c71so12659961edf.6
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 08:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HDIQl6Zm17tIYwMctuYQLVCBcZ/zbPGGq+AYp/LgdGc=;
        b=WOJfeylPxhsUAA/+Da56RWrU6HdCXWZPq+dA99iQB+eBY7b1u+BkD9G4b3cGXRZCnW
         RtPyxkRvv4ul4K0huAgz68xmj7NF2eO9kJLK/a9KGMLysueqnpzdrgu6NTpARpug4YIw
         qmoeiwUCLTjXQdYtIUgno9W6eS5djipQ3Yw9GG7OUsmU+xWWWpg+evHaXO22QmwrJ8/x
         V9zlxelSfAbMQa+qvQ1ByBA7K/R1U6bmGlYPcEu7Dik+HLEoO8fxucxuyiTMWUWKer+B
         8YAqrRkeFEIiPp4czCUAs7P27nputB7guEKroOO/Uux2JFqpvGYMq2p40+2oiY3u9Wud
         nysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDIQl6Zm17tIYwMctuYQLVCBcZ/zbPGGq+AYp/LgdGc=;
        b=MKNfWEd3y1o03G+oieChXpUskRyubFkjNl03Y5FqxZ+T/Gtm3Mhrt6R7kNAB7ash+Q
         WE5uDnZgOu5hfTeN0eY0VcGTy7NepiMpn28oT6mWWwtxIuQmBwgn9fyQTGZou49KQizb
         DGrCFjIEKOW+1iHgtR/D3u1eiwmlmQ/DfKU4Y5tCI5kERQnd+mFdXklKuGNzbMI8+wsV
         +8cGXVcgRn1tFgiGHR15+BaCmay7F9cPRGJObKGZ0QWz/T5t1LhQ07E9ivZKMYSHkuN6
         uWzLqqZd1jX5JsrFLEb4uFpWyGidXcTSdtlcHLG47fRPO1LI31H0sZ3zgWzs1PAheUJT
         4eJg==
X-Gm-Message-State: AOAM533KJXnBhwp/vdD0NM4HrtLvl2saHdZdWb/w+OcjHZlf1SYASumm
        IXEvzcjeJ9IXBolHF61yTz3zK0g56T+fsjPG7KhAdRCPjI293g==
X-Google-Smtp-Source: ABdhPJyJ4K/cO7l8t1lcn0yhG7DEpoj7DI5XYoBxIOsHwh+IVePw0PZB322DncVW9Q/tFSlrpob3hdtGFg54R/hUhCY=
X-Received: by 2002:a17:907:2d0c:: with SMTP id gs12mr50468922ejc.100.1641573330508;
 Fri, 07 Jan 2022 08:35:30 -0800 (PST)
MIME-Version: 1.0
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
 <ec9a751e8dcde99cfaa5c0a855f063de9284057e.1641317820.git.gitgitgadget@gmail.com>
 <CABPp-BGCCzgNJEaZ9fgHCkW52ws-ef+00GBhy+LZ5Tx+XkhqDw@mail.gmail.com> <ff3faad1-f5e9-c4db-712d-11f8110d1945@github.com>
In-Reply-To: <ff3faad1-f5e9-c4db-712d-11f8110d1945@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 7 Jan 2022 08:35:19 -0800
Message-ID: <CABPp-BH9tju7WVm=QZDOvaMDdZbpNXrVWQdN-jmfN8wC6YVhmw@mail.gmail.com>
Subject: Re: [PATCH 5/9] checkout-index: add --ignore-skip-worktree-bits option
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 6, 2022 at 7:07 AM Victoria Dye <vdye@github.com> wrote:
>
> Elijah Newren wrote:
> > On Tue, Jan 4, 2022 at 9:37 AM Victoria Dye via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Victoria Dye <vdye@github.com>
> >>
...
> >> +--ignore-skip-worktree-bits::
> >> +       Check out all files, including those with the skip-worktree bit
> >> +       set. Note: may only be used with `--all`; skip-worktree is
> >> +       ignored when explicit filenames are specified.
> >
> > Why this restriction?  What if the user ran
> >    git checkout-index -- '*.c'
> > That's not an explicit filename, but a glob.
> >
>
> `checkout-index` doesn't accept globs/pathspecs, so every provided argument
> must correspond exactly to an entry in the index.

Ah, my mistake; thanks for pointing that out.  I learned something else new.

> I originally restricted '--ignore-skip-worktree-bits' to only work with
> '--all' because I wanted changes to the current behavior of `checkout-index`
> in a sparse checkout to be as minimal as possible. However, if this is more
> "unexpected inconsistency" than "I'm glad checkout-index with filenames
> still works the way it did before", I'm happy to change it.

That's good context.  I'm not sure I have a real strong opinion on
this side of things, but digging around I did note that this behavior
is somewhat inconsistent with checkout/restore:

$ git checkout HEAD sparse-dir/filename
error: pathspec 'sparse-dir/filename' did not match any file(s) known to git

$ git ls-files -t sparse-dir/filename
S sparse-dir/filename

(The error message in checkout/restore might be worth fixing up, since
it's actually a lie as shown by the `ls-files -t` command below it.
But that's obviously outside the scope of this series.)

So we should probably either require the --ignore-skip-worktree-bits
flag even with individual paths (which might also slightly reduce my
objections to the other items below), or explain in the commit message
why checkout and checkout-index treat paths outside the sparsity
specification differently.

> >> +
> >>  --stdin::
> >>         Instead of taking list of paths from the command line,
> >>         read list of paths from the standard input.  Paths are
> >> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> >> index e21620d964e..2053a80103a 100644
> >> --- a/builtin/checkout-index.c
> >> +++ b/builtin/checkout-index.c
> >> @@ -7,6 +7,7 @@
> >>  #define USE_THE_INDEX_COMPATIBILITY_MACROS
> >>  #include "builtin.h"
> >>  #include "config.h"
> >> +#include "dir.h"
> >>  #include "lockfile.h"
> >>  #include "quote.h"
> >>  #include "cache-tree.h"
> >> @@ -116,7 +117,7 @@ static int checkout_file(const char *name, const char *prefix)
> >>         return -1;
> >>  }
> >>
> >> -static int checkout_all(const char *prefix, int prefix_length)
> >> +static int checkout_all(const char *prefix, int prefix_length, int ignore_skip_worktree)
> >>  {
> >>         int i, errs = 0;
> >>         struct cache_entry *last_ce = NULL;
> >> @@ -125,6 +126,8 @@ static int checkout_all(const char *prefix, int prefix_length)
> >>         ensure_full_index(&the_index);
> >>         for (i = 0; i < active_nr ; i++) {
> >>                 struct cache_entry *ce = active_cache[i];
> >> +               if (!ignore_skip_worktree && ce_skip_worktree(ce))
> >> +                       continue;
> >
> > So here I see you let it fall through to the code below that will
> > write the file to the working tree...but it doesn't clear the
> > SKIP_WORKTREE bit in the index when it does so, which I think is a
> > bug.
> >
>
> I disagree, mainly because updating a flag seems inconsistent with how
> `checkout-index` otherwise works. Specifically, `checkout-index` creates or
> replaces a file on disk (not even necessarily in the git working directory)
> based on the file's state in the index, but doesn't modify the index in the
> process. The only exception is '-u', which is effectively a shortcut for
> running `git update-index --refresh` [1].
>
> If a user wants to to checkout a file *and* update `skip-worktree`, I think
> explicitly using `update-index` would be a more appropriate way to do that
> (similar to the example [2] in the `checkout-index` documentation):
>
>         $ git checkout-index outside-cone/file
>         $ git update-index --no-skip-worktree outside-cone/file

I understand the desire to make a minimal change and only do
operations the command previously did, but I'm also worried about
introducing or exacerbating inconsistencies for users.  Matheus'
patches to grep stalled for nearly a year, in part because of
complications of how to handle sparse-checkouts appropriately in all
cases[1][2] (with trying to sanely figure out how to sanely handle
present-despite-SKIP_WORKTREE files being one of the complications).
His rm/add follow-ups also took months because of those kinds of
issues[3].  We've had to add ugly logic to merge-ort to attempt to
handle present-despite-SKIP_WORKTREE files[4], and basically just been
forced to give up in merge-recursive knowing full well that we'll
sometimes silently discard user modifications. Despite stash
essentially being a merge, it needed extra code (beyond what was in
merge-ort and merge-recursive) to manually tweak SKIP_WORKTREE bits in
order to avoid a few different bugs that'd result in an early abort
with a partial stash application[5].  But beyond implementation
complexity for other commands to deal with these problematic files, it
will also cause problems for users:

Since present-despite-SKIP_WORKTREE files are not reported by status,
diff, grep, or anything, and `git sparse-checkout reapply` will NOT
attempt to remove or notify the user about them, and commands like
switch/checkout/pull/merge/rebase etc. will not update them (unless
there are conflicts in that path), the contents of these files will
remain stagnant and likely reflect a version of the file from weeks
ago on a different branch altogether.  When users then either change
their sparsity patterns or disable sparse-checkouts, now they see
files with "all kinds of changes" (because it was the version of a
file from a different branch or commit altogether).  What are users
supposed to do with that?  They have to do something, or else
switch/checkout/pull will now start erroring out, and the issue that
cause the problem for the users is totally disconnected from the
command that eventually gives them errors, potentially by days or
weeks.  It's nearly impossible to help users debug why this happened
with such a disconnect.

However...I've been complaining about these kinds of problems for well
over a year, because the only solution I knew of was to try to
minimize each way we could get into this broken state (of having
present-despite-SKIP_WORKTREE files) and ask folks to test and modify
commands to do something semi-sane when we unfortunately find
ourselves in this broken state anyway.  I've gone round and round with
Matheus trying to figure them out.  And back and forth many times with
Stolee.  And now...it feels like there'll be no end.  So, I decided to
bite the bullet and attempt to see just how hard it would be to
actually detect/notify/correct this broken state for users.  I think I
may have a clever solution.  As long as others don't feel it's too
heavy handed, it could just obviate all these discussions and all the
special case code and simply the tests significantly and drop my
objections to your patch.  I'll submit the series later today.

[1] See https://lore.kernel.org/git/5f3f7ac77039d41d1692ceae4b0c5df3bb45b74a.1612901326.git.matheus.bernardino@usp.br/#t
and the dates on the thread; also Matheus and I had several
conversations off-list trying to resolve the issues over that time
[2] ...it finally kind of got unstuck after
https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/
[3] See e.g. https://lore.kernel.org/git/CABPp-BHwNoVnooqDFPAsZxBT9aR5Dwk5D9sDRCvYSb8akxAJgA@mail.gmail.com/#t
and quotes like "The core functionality of sparse-checkout has always
been only partially implemented", a statement I still believe is true
today.
[4] See commit 66b209b86a ("merge-ort: implement CE_SKIP_WORKTREE
handling with conflicted entries", 2021-03-20)
[5] See commit ba359fd507 ("stash: fix stash application in
sparse-checkouts", 2020-12-01)

> [1] https://lore.kernel.org/git/7vis1kvqac.fsf@assigned-by-dhcp.cox.net/
> [2] https://git-scm.com/docs/git-checkout-index#Documentation/git-checkout-index.txt-Toupdateandrefreshonlythefilesalreadycheckedout
>
> >>                 if (ce_stage(ce) != checkout_stage
> >>                     && (CHECKOUT_ALL != checkout_stage || !ce_stage(ce)))
> >>                         continue;
> >> @@ -176,6 +179,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
> >>         int i;
> >>         struct lock_file lock_file = LOCK_INIT;
> >>         int all = 0;
> >> +       int ignore_skip_worktree = 0;
> >>         int read_from_stdin = 0;
> >>         int prefix_length;
> >>         int force = 0, quiet = 0, not_new = 0;
> >> @@ -185,6 +189,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
> >>         struct option builtin_checkout_index_options[] = {
> >>                 OPT_BOOL('a', "all", &all,
> >>                         N_("check out all files in the index")),
> >> +               OPT_BOOL(0, "ignore-skip-worktree-bits", &ignore_skip_worktree,
> >> +                       N_("do not skip files with skip-worktree set")),
> >>                 OPT__FORCE(&force, N_("force overwrite of existing files"), 0),
> >>                 OPT__QUIET(&quiet,
> >>                         N_("no warning for existing files and files not in index")),
> >> @@ -247,6 +253,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
> >>
> >>                 if (all)
> >>                         die("git checkout-index: don't mix '--all' and explicit filenames");
> >> +               if (ignore_skip_worktree)
> >> +                       die("git checkout-index: don't mix '--ignore-skip-worktree-bits' and explicit filenames");
> >>                 if (read_from_stdin)
> >>                         die("git checkout-index: don't mix '--stdin' and explicit filenames");
> >>                 p = prefix_path(prefix, prefix_length, arg);
> >> @@ -280,7 +288,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
> >>         }
> >>
> >>         if (all)
> >> -               err |= checkout_all(prefix, prefix_length);
> >> +               err |= checkout_all(prefix, prefix_length, ignore_skip_worktree);
> >>
> >>         if (pc_workers > 1)
> >>                 err |= run_parallel_checkout(&state, pc_workers, pc_threshold,
> >> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> >> index db7ad41109b..fad61d96107 100755
> >> --- a/t/t1092-sparse-checkout-compatibility.sh
> >> +++ b/t/t1092-sparse-checkout-compatibility.sh
> >> @@ -799,14 +799,14 @@ test_expect_success 'checkout-index with folders' '
> >>         test_all_match test_must_fail git checkout-index -f -- folder1/
> >>  '
> >>
> >> -# NEEDSWORK: even in sparse checkouts, checkout-index --all will create all
> >> -# files (even those outside the sparse definition) on disk. However, these files
> >> -# don't appear in the percentage of tracked files in git status.
> >> -test_expect_failure 'checkout-index --all' '
> >> +test_expect_success 'checkout-index --all' '
> >>         init_repos &&
> >>
> >>         test_all_match git checkout-index --all &&
> >> -       test_sparse_match test_path_is_missing folder1
> >> +       test_sparse_match test_path_is_missing folder1 &&
> >> +
> >> +       test_all_match git checkout-index --ignore-skip-worktree-bits --all &&
> >> +       test_all_match test_path_exists folder1
> >
> > I added an 'exit 1' here, ran the test and then checked:
> >
> > $ cd trash\ directory.t1092-sparse-checkout-compatibility/sparse-checkout/
> > $ git ls-files -t | grep folder1/
> > S folder1/0/0/0
> > S folder1/0/1
> > S folder1/a
> >
> > So there's some more work to do on this patch.
>
> Unless I'm misreading your comment, this is exactly the behavior I would
> expect in this test: all files (even those with `skip-worktree` set, per
> '--ignore-skip-worktree-bits') are created on-disk, with `skip-worktree`
> unmodified.

If folks agree with the series I'll submit later today to detect/fix
present-despite-SKIP_WORKTREE files, then I'll drop my objection to
this behavior.  But if folks object to that other series, then I am
concerned this behavior gives users a ticking time-bomb without
sufficient warning.  So if that other series isn't acceptable to
folks, then I may come back here and argue that either you or I need
to go back in to checkout-index and make it clear the SKIP_WORKTREE
bit for any files it writes.
