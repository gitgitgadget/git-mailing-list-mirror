Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 331AD202BB
	for <e@80x24.org>; Mon, 25 Mar 2019 15:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfCYPvT (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 11:51:19 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37367 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCYPvS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 11:51:18 -0400
Received: by mail-ua1-f66.google.com with SMTP id x1so3151604uaj.4
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LY+w/rtayG5SFEnIhKAE5TlUWJkajX0FyM15R/veeKI=;
        b=fNke5vAqzRSmXE13bnC7EcYNSW+FmPVFgQ+mwzHCsNin3hS8nMaMR5zymtYbagxpNr
         xL+MJyE/mgA4SLZtABDFX9BueAfYukwlPHefyDwJozjG/yCV5D+Cm42uDEVkZPqeAgmb
         71G2fxgSY/ZFM6BhXxV+OP0giMsAemv7OF0Hsqk3u5k46Cb7Umv5CYMg9+HuH+LsFWT0
         hyf7miF1M8Wf4zb1wCfd86q1joF8L4U4oosBynXf+fhaUKBHXhHopYG1VpBr7iGEX9J4
         k5AgKflJ66EpFwbU/LB9rVkxzXMhUyYmxtQARHjovavZvWSo/PMwQU2Wid6usEJ9IyWw
         efuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LY+w/rtayG5SFEnIhKAE5TlUWJkajX0FyM15R/veeKI=;
        b=PcfeiTZDRpglmpzybF9ixK/nAUVIhju2sjvyBONmjxWkRyzDOPQWh0kS84usaaYBim
         Rkj/vkaIm5RpApsd9k7uHzpwhpEWqcXVRgO4eizkZV6mZQ23x+76Zr+2WKy/D8brWR5K
         t5uHkimRB6+kT7DRatJJk7red6AkPbXSpmBTcLWzONGAp+djSEESog4F17rnyneIcoj0
         zK1OUrYL9RigyCqKDKi2q2UC/dfQfBNr1HHtGdeluO84f1Qs6K0nmXkmehfIBxi/JcRG
         mphXCRof9lgsXgZ4jdfcuLZwpukFKsWdItqENpM/sAeT2yRmUP9LmmxlSXafaAdpWA78
         N0hQ==
X-Gm-Message-State: APjAAAX6f46bxm5YxC1s1kfY9Kv9wToJMP3ZeN/jc+XBCDEFa93Ww+ji
        KD4AXlBIjOb479FqQGmukb6ug8GzcZdpsEsA5oM=
X-Google-Smtp-Source: APXvYqzH9HvKc3qPubKXBs5OLPewKFus/Yt1MM9wj8wh97PjX5kWDL7sxj8KNlMP9Uz3RakXSwj5uZqlcW/UorOqmWA=
X-Received: by 2002:ab0:69da:: with SMTP id u26mr14072963uaq.1.1553529076655;
 Mon, 25 Mar 2019 08:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-2-pclouds@gmail.com>
 <CABPp-BFXZMorrHph3hGFnqfceHs68byWNgffNKGp1ov6X5-o5A@mail.gmail.com> <20190325095322.GA1617@ash>
In-Reply-To: <20190325095322.GA1617@ash>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 25 Mar 2019 08:51:04 -0700
Message-ID: <CABPp-BFtsQzDj3mCr1aRTpy2PQCzATjGGccECCmH8Qa_Y4aASQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/11] checkout: split part of it to new command 'restore'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 2:53 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> (Including Stefan, in case he's still interested in git and planned
> something for the "submodule" restore part I mention below)
>
> On Fri, Mar 08, 2019 at 10:01:25AM -0800, Elijah Newren wrote:
> > Thanks for working on this; overall looks really good.  I've got a few
> > comments here and there on the wording and combinations of options...
>
> OK now that the 'git switch' part is mostly settled, I could go back
> to 'git restore'. I have a lot more homework to do before sending v2,
> but how about this?
>
> Most of this is minor rephrasing and clarification (thanks!). The big
> change is `--force` is split into `--keep-unmerged` and
> `--force-submodules`, the same direction I took in 'git switch'.
>
> Submodules actually pose another problem because there are different
> things in a submodule to restore:
>
>  - restore HEAD only, leave submodule's worktree alone. This is
>    `--no-recurse-submodules` (default)
>
>  - restoring `HEAD`, which is basically "git switch --detach
>    <something>" inside the submodule. This is `--recurse-submodules`.
>
>  - restoring the paths inside the submodules, i.e. the actual "git
>    restore <some paths>" inside the submodule.
>
>  - a combinarion of two. Basically you want "git reset --hard" in
>    every selected submodule.
>
> I wonder if we ever need to cover the third and forth case (and if so,
> what will the UI be like).  I suppose we could eventually make
> --recurse-submodules take an argument to specify what to restore,
> maybe...

This looks pretty good to me, though I've got some small comments
below.  Note that I'm basically glossing over or ignoring any part
touching on submodules, so I could easily miss even glaring wording
problems in that part.

> PS. I just found https://asciidoclive.com/. Could be useful to paste
> this text and render without going through git's build system.

Interesting.  :-)

> -- 8< --
> git-restore(1)
> ==============
>
> NAME
> ----
> git-restore - Restore working tree files
>
> SYNOPSIS
> --------
> [verse]
> 'git restore' [<options>] [--source=<tree>] [--staged] [--worktree] <pathspec>...
> 'git restore' (-p|--patch) [<options>] [--source=<tree>] [--staged] [--worktree] [<pathspec>...]
>
> DESCRIPTION
> -----------
> Restore specified paths in the working tree with some contents from a
> restore source. If a path is tracked but does not exist in the restore
> source, it will be removed to match the source.
>
> The command can also be used to restore the content in the index with
> `--staged`, or restore both the working tree and the index with
> `--staged --worktree`.
>
> By default, the restore sources for working tree and the index are the
> index and `HEAD` respectively. `--source` could be used to specify a
> commit as the restore source.
>
> A note about the differences between this command and linkgit:git-reset[1].
> `git restore` modifies the working tree (and maybe the index) to
> change file content to match some other, usually older, version, but
> does not update your branch. `git reset` is mainly about moving the
> tip of your branch in order to either add or remove commits from the
> branch.

Maybe include revert as well?  Perhaps something like...

A note about the differences between this command, linkgit:git-reset[1],
and and linkgit:git-revert[1].  `git restore` modifies the working tree
(and maybe the index) to change file content to match some other,
usually older, version, but does not update your branch. `git reset` is
mainly about moving the tip of your branch to some other commit,
implicitly adding and/or removing many commits to the branch.  `git
revert` is about creating and adding new commits to your branch that
reverse the changes made in specified commits.

(There is also a similar description in git-revert, which also
compares all three of revert, reset, and checkout.  It's shorter, but
focuses more from the "revert" angle.)

> OPTIONS
> -------
> -s <tree>::
> --source=<tree>::
>         Restore the working tree files with the content from the given
>         tree. It is common to specify the source tree by naming a
>         commit, branch or tag associated with it.
> +
> If not specified, the default restore source for the working tree is
> the index, and index `HEAD`. When both `--staged` and `--worktree`
> are specified, `--source` must also be specified.

s/index `HEAD`/the default restore source for the index is `HEAD`/

> -p::
> --patch::
>         Interactively select hunks in the difference between the
>         restore source and the restore location. See the ``Interactive
>         Mode'' section of linkgit:git-add[1] to learn how to operate
>         the `--patch` mode.
> +
> Note that `--patch` can accept no pathspec and will restore all
> modified paths.

s/will restore all/will prompt to restore with all/

> -W::
> --worktree::
> -S::
> --staged::
>         Specify the restore location. If neither option is specified,
>         by default the working tree is restored. Specifying `--staged`
>         will only restore the index. Specifying both restores both.
>
> -q::
> --quiet::
>         Quiet, suppress feedback messages.
>
> --progress::
> --no-progress::
>         Progress status is reported on the standard error stream
>         by default when it is attached to a terminal, unless `--quiet`
>         is specified. This flag enables progress reporting even if not
>         attached to a terminal, regardless of `--quiet`.
>
> -f::
> --force::
>         An alias of `--keep-unmerged` and `--force-submodules`.
>
> --keep-unmerged::
>         If `--source` is not specified, unmerged entries are left
>         alone and will not fail the operation.

This isn't very clear to me.  Maybe:

Incompatible with --source and --staged.  When specified, unmerged
entries in the index will not fail the operation and the corresponding
working tree files will be left unmodified.

> --force-submodules::
>         Continue even if restoring `HEAD` of a submodule leads to loss
>         of local changes in that submodule with `--recurse-submodules`.
>
> --ours::
> --theirs::
>         Restore from stage #2 ('ours') or #3 ('theirs') for unmerged
>         paths.
> +
> Note that during `git rebase` and `git pull --rebase`, 'ours' and
> 'theirs' may appear swapped. See the explanation of the same options
> in linkgit:git-checkout[1] for details.
>
> -m::
> --merge::
>         Recreate the conflicted merge in the specified paths.
>
> --conflict=<style>::
>         The same as `--merge` option above, but changes the way the
>         conflicting hunks are presented, overriding the merge.conflictStyle
>         configuration variable.  Possible values are "merge" (default)
>         and "diff3" (in addition to what is shown by "merge" style,
>         shows the original contents).
>
> --ignore-skip-worktree-bits::
>         In sparse checkout mode, by default is to only update entries
>         matched by `<pathspec>` and sparse patterns in
>         $GIT_DIR/info/sparse-checkout. This option ignores the sparse
>         patterns and unconditionally restores any files in
>         `<pathspec>`.
>
> --recurse-submodules::
> --no-recurse-submodules::
>         Using `--recurse-submodules` will update the content of all
>         initialized submodules according to the commit recorded in the
>         superproject. If nothing (or `--no-recurse-submodules`) is
>         used, the work trees of submodules will not be updated.  Just
>         like linkgit:git-submodule[1], this will detach `HEAD` of the
>         submodules.
>
> --overlay::
> --no-overlay::
>         In overlay mode, the command never removes files when
>         restoring. In no-overlay mode, tracked files that appear in
>         the index and working tree, but not in `--source` tree are
>         removed, to make them match `<tree>` exactly. The default is
>         no-overlay mode.

I think the "index and working tree" wording might cause some
problems.  What if the path doesn't exist in the source tree nor the
working tree, but does appear in the index and the user passes
--staged?  Maybe just remove that phrase, e.g.:

"...In no-overlay mode, tracked files that do not appear in the
`--source` tree are removed..."

?

> EXAMPLES
> --------
>
> The following sequence switches to the `master` branch, reverts the
> `Makefile` to two revisions back, deletes hello.c by mistake, and gets
> it back from the index.
>
> ------------
> $ git switch master
> $ git restore --source master~2 Makefile  <1>
> $ rm -f hello.c
> $ git restore hello.c                     <2>
> ------------
>
> <1> take a file out of another commit
> <2> restore hello.c from the index
>
> If you want to restore _all_ C source files to match the version in
> the index, you can say
>
> ------------
> $ git restore '*.c'
> ------------
>
> Note the quotes around `*.c`.  The file `hello.c` will also be
> restored, even though it is no longer in the working tree, because the
> file globbing is used to match entries in the index (not in the
> working tree by the shell).
>
> To restore all files in the current directory
>
> ------------
> $ git restore .
> ------------
>
> or to restore all working tree files with 'top' pathspec magic (see
> linkgit:gitglossary[7])
>
> ------------
> $ git restore :/
> ------------
>
> To restore a file in the index to match the version in `HEAD` (this is
> the same as using linkgit:git-reset[1])
>
> ------------
> $ git restore --staged hello.c
> ------------
>
> or you can restore both the index and the working tree (this the same
> as using linkgit:git-checkout[1])
>
> ------------
> $ git restore --source=HEAD --staged --worktree hello.c
> ------------
>
> or the short form which is more practical but less readable:
>
> ------------
> $ git restore -s@ -SW hello.c
> ------------

@ means HEAD?  I somehow missed this for five and half years.  (Glad
you put the "less readable" disclaimer/warning on this example,
though.)
