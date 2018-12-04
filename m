Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C3F7211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 00:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeLDApX (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 19:45:23 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41120 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeLDApX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 19:45:23 -0500
Received: by mail-vs1-f66.google.com with SMTP id t17so8753878vsc.8
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 16:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=27stdBQ68/bqG3jg4WWb4BE9hJ4QL0EycPlAGtYEgvs=;
        b=uFdsJpslUqL3KiOEjGImaEPVa7cZHpwL6VCQWbfjtY4nJHvutsiOYonT7eBj9M/Chs
         Q2Zpen8WWG2Uj9/VjRLQrLwjrzhYxHbPX57ktwYp5WvKvstCpzvW/vILYDLH9LaWhnjl
         qTO411TubA0dc71t4fHa055dVMH7QoZ495Gc7hIncnHKAhfPe/1qFdhelyvtZGRuaWsn
         zbkHb+4p93F36r0RvZzfgfZPeewU++3RiVepmabKCPoiyWHtFJst2XJQbtJxNF3TMEiw
         Z0gK/UdhIT1iT+I9vm0kYonWj9ELBO5ZKk5K5fahrCZfa/bAiekMhE2/Fu4puAIMKNGs
         F+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=27stdBQ68/bqG3jg4WWb4BE9hJ4QL0EycPlAGtYEgvs=;
        b=ELyy+Z+i856ijhrBLqgMh33DGtLKD+CX/AAnw/G6QdLpuc2ACiTjg9pHHgq8JHHO+9
         xhFPYnITAJODxMPX3LPM/pVH+aSwpa1YigrMkewdxPuQf5fXvNiztFgTwoCOSGrmkXCG
         0CHDPhvlKgskyEFlwEgjLRTOcCJHCQWO/qa3jSBeEABU83dDWLue0SIneICEu71Bf9TA
         yu4wKUiSOc/7UC7o91GpWhwnt/oQ6oQ63+9eTEkMjlorrgndwjnU5kLaEBNBWSImH9Li
         3mJVvRUr9LtwHGh9j+9XIOrrCQg8+dsOMYg9uWWyLYsxSj1irBhFSTa17H2VirfnTHWt
         tpfA==
X-Gm-Message-State: AA+aEWaAqGX8yP1FF+Bn4tC1jimmUWgbwNaB9mUV2IJECJb2nLDpH5y1
        cwnrvMEJDwseAUoZ90uucvs2cpI1EG2Td2vaQYE=
X-Google-Smtp-Source: AFSGD/VrQmuDOcxP/14q4t4J6MosZy7qunMMG5FvPKMEPSfg21ntMe8SRTH6idRjdIdhM0k6kquhhqj8J8/FuOAP1I0=
X-Received: by 2002:a67:e44f:: with SMTP id n15mr8231738vsm.116.1543884320145;
 Mon, 03 Dec 2018 16:45:20 -0800 (PST)
MIME-Version: 1.0
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com>
 <20181129215850.7278-8-pclouds@gmail.com>
In-Reply-To: <20181129215850.7278-8-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 3 Dec 2018 16:45:08 -0800
Message-ID: <CABPp-BHQ68pkvO8yXYuy=0D6ne8u=5CUMDqiN0jtRrxCL55n2g@mail.gmail.com>
Subject: Re: [PATCH v3 07/14] checkout: split into switch-branch and restore-files
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>, sxenos@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 29, 2018 at 2:03 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> "git checkout" doing too many things is a source of confusion for many
> users (and it even bites old timers sometimes). To rememdy that, the
> command is now split in two: switch-branch and checkout-files. The

"checkout-files" here....(will comment more on this below)

> good old "git checkout" command is still here and will be until all
> (or most of users) are sick of it.
>
> See the new man pages for the final design of these commands. The
> actual implementation though is still pretty much the same as "git
> checkout". Following patches will adjust their behavior to match the
> man pages.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  .gitignore                          |   2 +
>  Documentation/git-checkout.txt      |   5 +
>  Documentation/git-restore-files.txt | 167 ++++++++++++++++
>  Documentation/git-switch-branch.txt | 289 ++++++++++++++++++++++++++++
>  Makefile                            |   2 +
>  builtin.h                           |   2 +
>  builtin/checkout.c                  |  84 ++++++--
>  command-list.txt                    |   2 +
>  git.c                               |   2 +
>  9 files changed, 543 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/git-restore-files.txt
>  create mode 100644 Documentation/git-switch-branch.txt
>
> diff --git a/.gitignore b/.gitignore
> index 0d77ea5894..c63dcb1427 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -143,6 +143,7 @@
>  /git-request-pull
>  /git-rerere
>  /git-reset
> +/git-restore-files

...and "restore-files" here.  Should be consistent with whatever name you p=
ick.

>  /git-rev-list
>  /git-rev-parse
>  /git-revert
> @@ -167,6 +168,7 @@
>  /git-submodule
>  /git-submodule--helper
>  /git-svn
> +/git-switch-branch
>  /git-symbolic-ref
>  /git-tag
>  /git-unpack-file
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.=
txt
> index 25887a6087..25ec7f508f 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -406,6 +406,11 @@ $ edit frotz
>  $ git add frotz
>  ------------
>
> +SEE ALSO
> +--------
> +linkgit:git-switch-branch[1]
> +linkgit:git-restore-files[1]
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/Documentation/git-restore-files.txt b/Documentation/git-rest=
ore-files.txt
> new file mode 100644
> index 0000000000..03c1250ad0
> --- /dev/null
> +++ b/Documentation/git-restore-files.txt
> @@ -0,0 +1,167 @@
> +git-restore-files(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +git-restore-files - Restore working tree files
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git restore-files' [-f|--ours|--theirs|-m|--conflict=3D<style>] [--from=
=3D<tree-ish>] <pathspec>...

Suggesting that you can use both --ours and --from?  Or -f and --from?
 That seems bad; see below for more on this...

> +'git restore-files' [--from=3D<tree-ish>] <pathspec>...

Isn't this already inferred by the previous line?  Or was the
inclusion of --from on the previous line in error?  Looking at the
git-checkout manpage, it looks like you may have just been copying an
existing weirdness, but it needs to be fixed.  ;-)

> +'git restore-files' (-p|--patch) [--from=3D<tree-ish>] [<pathspec>...]
> +
> +DESCRIPTION
> +-----------
> +Updates files in the working tree to match the version in the index
> +or the specified tree.
> +
> +'git restore-files' [--from=3D<tree-ish>] <pathspec>...::

<tree-ish> and <pathspec>?  I understand <commit-ish> and <pathspec>,
or <tree-ish> but have no clue why it'd be okay to specify <tree-ish>
and <pathspec> together.  What does that even mean?

Also, rather than fixing from <tree-ish> to <commit-ish> or <commit>,
perhaps we should just use <revision> here?  (I'm thinking of git
rev-parse's "Specifying revisions", which suggests "revisions" as a
good substitute for "commit-ish" that isn't quite so weird for new
users.)

> +
> +       Overwrite paths in the working tree by replacing with the
> +       contents in the index or in the <tree-ish> (most often a
> +       commit).  When a <tree-ish> is given, the paths that
> +       match the <pathspec> are updated both in the index and in
> +       the working tree.

Is that the default we really want for this command?  Why do we
automatically assume these files are ready for commit?  I understand
that it's what checkout did, but I'd find it more natural to only
affect the working tree by default.  We can give it an option for
affecting the index instead (or perhaps in addition).

> ++
> +The index may contain unmerged entries because of a previous failed merg=
e.
> +By default, if you try to check out such an entry from the index, the
> +checkout operation will fail and nothing will be checked out.
> +Using `-f` will ignore these unmerged entries.  The contents from a
> +specific side of the merge can be checked out of the index by
> +using `--ours` or `--theirs`.  With `-m`, changes made to the working tr=
ee
> +file can be discarded to re-create the original conflicted merge result.
> +
> +'git restore-files' (-p|--patch) [--from=3D<tree-ish>] [<pathspec>...]::
> +       This is similar to the "check out paths to the working tree
> +       from either the index or from a tree-ish" mode described
> +       above, but lets you use the interactive interface to show
> +       the "diff" output and choose which hunks to use in the
> +       result.  See below for the description of `--patch` option.
> +
> +OPTIONS
> +-------
> +-q::
> +--quiet::
> +       Quiet, suppress feedback messages.
> +
> +--[no-]progress::
> +       Progress status is reported on the standard error stream
> +       by default when it is attached to a terminal, unless `--quiet`
> +       is specified. This flag enables progress reporting even if not
> +       attached to a terminal, regardless of `--quiet`.
> +
> +-f::
> +--force::
> +       Do not fail upon unmerged entries; instead, unmerged entries
> +       are ignored.

You just copied this from the checkout manpage, but this is ambiguous
and/or wrong; using git-checkout (since your patch-series doesn't
apply cleanly to either master or next for me):

$ sha1sum counting
c0ed0e34b0fbef4274ef59480e0a0a1cb2776870  counting
$ git checkout counting; echo $?
error: path 'counting' is unmerged
1
$ git checkout -f counting; echo $?
warning: path 'counting' is unmerged
0
$ sha1sum counting
c0ed0e34b0fbef4274ef59480e0a0a1cb2776870  counting

Maybe printing a warning counts as "ignored", though it doesn't seem
like it.  However, even worse is:

$ git checkout -f HEAD~1 counting
$ sha1sum counting
612ca68d0305c821750a452e9d5bf050e915824f  counting

Now the unmerged entry wasn't ignored; it was updated in the working
tree and overwritten in the index.


Perhaps -f and --from should be incompatible and throw an error if
both are specified?  Also does "printed a warning message for"
actually count as "ignored" or should the documentation for this
option be updated?

> +--ours::
> +--theirs::
> +       Check out stage #2 ('ours') or #3 ('theirs') for unmerged
> +       paths.
> ++
> +Note that during `git rebase` and `git pull --rebase`, 'ours' and
> +'theirs' may appear swapped; `--ours` gives the version from the
> +branch the changes are rebased onto, while `--theirs` gives the
> +version from the branch that holds your work that is being rebased.
> ++
> +This is because `rebase` is used in a workflow that treats the
> +history at the remote as the shared canonical one, and treats the
> +work done on the branch you are rebasing as the third-party work to
> +be integrated, and you are temporarily assuming the role of the
> +keeper of the canonical history during the rebase.  As the keeper of
> +the canonical history, you need to view the history from the remote
> +as `ours` (i.e. "our shared canonical history"), while what you did
> +on your side branch as `theirs` (i.e. "one contributor's work on top
> +of it").

Total aside because I'm not sure what you could change here, but man
do I hate this.

> +
> +--ignore-skip-worktree-bits::
> +       In sparse checkout mode, update only entries matched by
> +       <paths> and sparse patterns in
> +       $GIT_DIR/info/sparse-checkout. This option ignores the sparse
> +       patterns and adds back any files in <paths>.

This doesn't make any sense now that you've removed the "`git checkout
-- <paths>` would" from the original.

> +
> +-m::
> +--merge::
> +       When checking out paths from the index, this option lets you
> +       recreate the conflicted merge in the specified paths.
> +
> +--conflict=3D<style>::
> +       The same as --merge option above, but changes the way the
> +       conflicting hunks are presented, overriding the
> +       merge.conflictStyle configuration variable.  Possible values are
> +       "merge" (default) and "diff3" (in addition to what is shown by
> +       "merge" style, shows the original contents).
> +
> +-p::
> +--patch::
> +       Interactively select hunks in the difference between the
> +       <tree-ish> (or the index, if unspecified) and the working
> +       tree.  The chosen hunks are then applied in reverse to the
> +       working tree (and if a <tree-ish> was specified, the index).
> ++
> +This means that you can use `git restore-files -p` to selectively
> +discard edits from your current working tree. See the ``Interactive
> +Mode'' section of linkgit:git-add[1] to learn how to operate the
> +`--patch` mode.
> +
> +--[no-]recurse-submodules::
> +       Using --recurse-submodules will update the content of all initial=
ized
> +       submodules according to the commit recorded in the superproject. =
If
> +       local modifications in a submodule would be overwritten the check=
out
> +       will fail unless `-f` is used. If nothing (or --no-recurse-submod=
ules)
> +       is used, the work trees of submodules will not be updated.
> +       Just like linkgit:git-submodule[1], this will detach the
> +       submodules HEAD.
> +
> +<tree-ish>::
> +       Tree to checkout from (when paths are given). If not specified,
> +       the index will be used.

Again, I'd really rather use <revision> here.

> +
> +EXAMPLES
> +--------
> +
> +. The following sequence checks out the `master` branch, reverts
> +the `Makefile` to two revisions back, deletes hello.c by
> +mistake, and gets it back from the index.
> ++
> +------------
> +$ git switch-branch master                    <1>
> +$ git restore-files --from master~2 Makefile  <2>
> +$ rm -f hello.c
> +$ git restore-files hello.c                   <3>
> +------------
> ++
> +<1> switch branch
> +<2> take a file out of another commit
> +<3> restore hello.c from the index
> ++

Why is the switch-branch command labelled but not the rm command?  It
made sense in the original checkout manpage to label all checkout
commands, but here since only restore-files is being discussed it
seems the switch-branch should lose its label.

> +If you want to check out _all_ C source files out of the index,
> +you can say
> ++
> +------------
> +$ git restore-files '*.c'
> +------------
> ++
> +Note the quotes around `*.c`.  The file `hello.c` will also be
> +checked out, even though it is no longer in the working tree,
> +because the file globbing is used to match entries in the index
> +(not in the working tree by the shell).

Sounds good.

> ++
> +If you have an unfortunate branch that is named `hello.c`, this
> +step would be confused as an instruction to switch to that branch.
> +You should instead write:
> ++
> +------------
> +$ git restore-files hello.c
> +------------

Isn't the point of this command to allow us to remove paragraphs like
this last one?

> +
> +SEE ALSO
> +--------
> +linkgit:git-checkout[1]
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite


My single biggest worry about this whole series is that I'm worried
you're perpetuating and even further ingraining one of the biggest
usability problems with checkout: people suggest and use it for
reverting/restoring paths to a previous version, but it doesn't do
that:

git restore-files --from master~10 Documentation/
<edit some non-documentation files>
git add -u
git commit -m "Rationale for changing files including reverting Documentati=
on/"

In particular, now you have a mixture of files in Documentation/ from
master~10 (er, now likely master~11) and HEAD~1; any files and
sub-directories that existed in HEAD~1 still remain and are mixed with
all other files in Documentation/ from the older commit.

You may think this is a special case, but this particular issue
results in some pretty bad surprises.  Also, it was pretty surprising
to me just how difficult it was to implement an svn-like revert in
EasyGit, in large part because of this 'oversight' in git.  git
checkout -- <paths> to me has always been fundamentally wrong, but I
just wasn't sure if I wanted to fight the backward compatibility
battle and suggest changing it.  With a new command, we definitely
shouldn't be reinforcing this error.  (And maybe we should consider
taking the time to fix git checkout too.)


> diff --git a/Documentation/git-switch-branch.txt b/Documentation/git-swit=
ch-branch.txt
> new file mode 100644
> index 0000000000..d5bf5cb37d
> --- /dev/null
> +++ b/Documentation/git-switch-branch.txt
> @@ -0,0 +1,289 @@
> +git-switch-branch(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +git-switch-branch - Switch branches
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git switch-branch' [-q] [-f] [-m] <branch>
> +'git switch-branch' [-q] [-f] [-m] --detach [<commit>]
> +'git switch-branch' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<sta=
rt_point>]

You label the options as -b/-B here, but -c/-C below.  Should be consistent=
.

> +
> +DESCRIPTION
> +-----------
> +Switch to a specified branch and update files in the working tree to
> +match it.
> +
> +'git switch-branch' <branch>::
> +       To prepare for working on <branch>, switch to it by updating
> +       the index and the files in the working tree. Local
> +       modifications to the files in the working tree are kept, so
> +       that they can be committed to the <branch>.
> ++
> +If <branch> is not found but there does exist a tracking branch in
> +exactly one remote (call it <remote>) with a matching name, treat as
> +equivalent to
> ++
> +------------
> +$ git switch-branch -b <branch> --track <remote>/<branch>
> +------------

If we're making --detach explicit (which I think is good), shouldn't
this also be made explicit?  I think I saw Junio arguing for this in
another thread.

Also, this is another case where you used -b instead of -c.  Finally,
--track wasn't mentioned in the synopsis but it is shown the first
time -b or -c is used?

> ++
> +If the branch exists in multiple remotes and one of them is named by
> +the `checkout.defaultRemote` configuration variable, we'll use that
> +one for the purposes of disambiguation, even if the `<branch>` isn't
> +unique across all remotes. Set it to
> +e.g. `checkout.defaultRemote=3Dorigin` to always checkout remote
> +branches from there if `<branch>` is ambiguous but exists on the
> +'origin' remote. See also `checkout.defaultRemote` in
> +linkgit:git-config[1].

So switch-branch will be controlled by checkout.* config variables?
That probably makes the most sense, but it does dilute the advantage
of adding these simpler commands.

Also, the fact that we're trying to make a simpler command makes me
think that removing the auto-vivify behavior from the default and
adding a simple flag which users can pass to request will allow this
part of the documentation to be hidden behind the appropriate flag,
which may make it easier for users to compartmentalize the command and
it's options, enabling them to learn as they go.

> +
> +'git switch-branch' -c|-C <new_branch> [<start_point>]::
> +
> +       Specifying `-c` causes a new branch to be created as if
> +       linkgit:git-branch[1] were called and then switched to. In
> +       this case you can use the `--track` or `--no-track` options,
> +       which will be passed to 'git branch'.  As a convenience,
> +       `--track` without `-c` implies branch creation; see the
> +       description of `--track` below.

Can we get rid of --track/--no-track and just provide a flag (which
takes no arguments) for the user to use?  Problems with --track:
  * it's not even in your synopsis
  * user has to repeat themselves (e.g. 'next' in two places from '-c
next --track origin/next'); this repetition is BOTH laborious AND
error-prone
  * it's rather inconsistent: --track is the default due to
auto-vivify when the user specifies nothing but a branch name that
doesn't exist yet, but when the user realizes the branch doesn't exist
yet and asks to have it created then suddenly tracking is not the
default??


I'm not sure what's best, but here's some food for thought:


   git switch-branch <branch>
switches to <branch>, if it exists.  Error cases:
  * If <branch> isn't actually a branch but a <tag> or
<remote-tracking-branch> or <revision>, error out and suggest using
--detach.
  * If <branch> isn't actually a branch but there is a similarly named
<remote-tracking-branch> (e.g. origin/<branch>), then suggest using
-c.

  git switch-branch -c <branch>
creates <branch> and, if a relevant-remote-tracking branch exists,
base the branch on that revision and set the new branch up to track
it.  Error cases:
  * If <branch> already exists, error out, suggesting -C or using a
non-conflicting name instead.

Other cases:
  * user wants a branch named 'master' that tracks 'origin/next'?  Use
git branch instead, don't support that in switch-branch.
  * user wants a branch named 'master' that doesn't track
'origin/master' despite 'origin/master' existing?  Use git branch
instead; don't support that in switch-branch.

> ++
> +If `-C` is given, <new_branch> is created if it doesn't exist;
> +otherwise, it is reset. This is the transactional equivalent of
> ++
> +------------
> +$ git branch -f <branch> [<start_point>]
> +$ git switch-branch <branch>
> +------------
> ++
> +that is to say, the branch is not reset/created unless "git
> +switch-branch" is successful.

...and when exactly would it fail?  Reading this, it looks like the
only possible error condition was removed due saying we'll reset the
branch if it already exists, so it's rather confusing.

> +
> +'git switch-branch' --detach [<commit>]::
> +
> +       Prepare to work on a unnamed branch on top of <commit> (see
> +       "DETACHED HEAD" section), and updating the index and the files
> +       in the working tree.  Local modifications to the files in the
> +       working tree are kept, so that the resulting working tree will
> +       be the state recorded in the commit plus the local
> +       modifications.
> ++
> +When the <commit> argument is a branch name, the `--detach` option can
> +be used to detach HEAD at the tip of the branch (`git switch-branch
> +<branch>` would check out that branch without detaching HEAD).
> ++
> +Omitting <commit> detaches HEAD at the tip of the current branch.
> +
> +OPTIONS
> +-------
> +-q::
> +--quiet::
> +       Quiet, suppress feedback messages.
> +
> +--[no-]progress::
> +       Progress status is reported on the standard error stream
> +       by default when it is attached to a terminal, unless `--quiet`
> +       is specified. This flag enables progress reporting even if not
> +       attached to a terminal, regardless of `--quiet`.
> +
> +-f::
> +--force::
> +       Proceed even if the index or the working tree differs from
> +       HEAD.  This is used to throw away local changes.

Haven't thought through this thoroughly, but do we really need an
option for that instead of telling users to 'git reset --hard HEAD'
before switching branches if they want their stuff thrown away?

> +-c <new_branch>::
> +--create <new_branch>::
> +       Create a new branch named <new_branch> and start it at
> +       <start_point>; see linkgit:git-branch[1] for details.
> +
> +-C <new_branch>::
> +--force-create <new_branch>::
> +       Creates the branch <new_branch> and start it at <start_point>;
> +       if it already exists, then reset it to <start_point>. This is
> +       equivalent to running "git branch" with "-f"; see
> +       linkgit:git-branch[1] for details.

Makes sense, but let's get the -b/-B vs. -c/-C consistent.

> +
> +-t::
> +--track::
> +       When creating a new branch, set up "upstream" configuration. See
> +       "--track" in linkgit:git-branch[1] for details.
> ++
> +If no `-c` option is given, the name of the new branch will be derived
> +from the remote-tracking branch, by looking at the local part of the
> +refspec configured for the corresponding remote, and then stripping
> +the initial part up to the "*".
> +This would tell us to use "hack" as the local branch when branching
> +off of "origin/hack" (or "remotes/origin/hack", or even
> +"refs/remotes/origin/hack").  If the given name has no slash, or the abo=
ve
> +guessing results in an empty name, the guessing is aborted.  You can
> +explicitly give a name with `-c` in such a case.
> +
> +--no-track::
> +       Do not set up "upstream" configuration, even if the
> +       branch.autoSetupMerge configuration variable is true.

These two options and the intervening paragraph, while they make sense
to me, seem like the kind of stuff we'd want to throw out -- or at
least rework -- when trying to introduce a new command to simplify.
But I already discussed that above.

> +-l::
> +       Create the new branch's reflog; see linkgit:git-branch[1] for
> +       details.

??  Jettison this.

> +
> +--detach::
> +       Rather than checking out a branch to work on it, check out a
> +       commit for inspection and discardable experiments.
> +       This is the default behavior of "git checkout <commit>" when
> +       <commit> is not a branch name.  See the "DETACHED HEAD" section
> +       below for details.
> +
> +--orphan <new_branch>::
> +       Create a new 'orphan' branch, named <new_branch>, started from
> +       <start_point> and switch to it.  The first commit made on this

What??  started from <start_point>?  The whole point of --orphan is
you have no parent, i.e. no start point.  Also, why does the
explanation reference an argument that wasn't in the immediately
preceding synopsis?

> +       new branch will have no parents and it will be the root of a new
> +       history totally disconnected from all the other branches and
> +       commits.
> ++
> +The index and the working tree are adjusted as if you had previously run
> +"git checkout <start_point>".  This allows you to start a new history
> +that records a set of paths similar to <start_point> by easily running
> +"git commit -a" to make the root commit.
> ++
> +This can be useful when you want to publish the tree from a commit
> +without exposing its full history. You might want to do this to publish
> +an open source branch of a project whose current tree is "clean", but
> +whose full history contains proprietary or otherwise encumbered bits of
> +code.
> ++
> +If you want to start a disconnected history that records a set of paths
> +that is totally different from the one of <start_point>, then you should
> +clear the index and the working tree right after creating the orphan
> +branch by running "git rm -rf ." from the top level of the working tree.
> +Afterwards you will be ready to prepare your new files, repopulating the
> +working tree, by copying them from elsewhere, extracting a tarball, etc.

Ick.  Seems overly complex.  I'd rather that --orphan defaulted to
clearing the index and working tree, and that one would need to pass
HEAD for <start_point> if you wanted to start out with all those other
files.  That would certainly make the explanation a little clearer to
users, and more natural when they start experimenting with it.

However, --orphan is pretty special case.  Do we perhaps want to leave
it out of this new command and only include it in checkout?

> +-m::
> +--merge::
> +       If you have local modifications to one or more files that are
> +       different between the current branch and the branch to which
> +       you are switching, the command refuses to switch branches in
> +       order to preserve your modifications in context.  However,
> +       with this option, a three-way merge between the current
> +       branch, your working tree contents, and the new branch is
> +       done, and you will be on the new branch.
> ++
> +When a merge conflict happens, the index entries for conflicting
> +paths are left unmerged, and you need to resolve the conflicts
> +and mark the resolved paths with `git add` (or `git rm` if the merge
> +should result in deletion of the path).
> +
> +--conflict=3D<style>::
> +       The same as --merge option above, but changes the way the
> +       conflicting hunks are presented, overriding the
> +       merge.conflictStyle configuration variable.  Possible values are
> +       "merge" (default) and "diff3" (in addition to what is shown by
> +       "merge" style, shows the original contents).
> +
> +--ignore-other-worktrees::
> +       `git switch-branch` refuses when the wanted ref is already
> +       checked out by another worktree. This option makes it check
> +       the ref out anyway. In other words, the ref can be held by
> +       more than one worktree.

seems rather dangerous...is the goal to be an easier-to-use suggestion
for new users while checkout continues to exist, or is this command
meant to handle all branch switching functionality that checkout has?

> +
> +--[no-]recurse-submodules::
> +       Using --recurse-submodules will update the content of all initial=
ized
> +       submodules according to the commit recorded in the superproject. =
If
> +       local modifications in a submodule would be overwritten the check=
out
> +       will fail unless `-f` is used. If nothing (or --no-recurse-submod=
ules)
> +       is used, the work trees of submodules will not be updated.
> +       Just like linkgit:git-submodule[1], this will detach the
> +       submodules HEAD.
> +
> +<branch>::
> +       Branch to checkout; if it refers to a branch (i.e., a name that,
> +       when prepended with "refs/heads/", is a valid ref), then that
> +       branch is checked out. Otherwise, if it refers to a valid
> +       commit, your HEAD becomes "detached" and you are no longer on
> +       any branch (see below for details).

I thought we requiring --detach in order to detach.  Does this
paragraph need updating?  Also, if we require --detach when we'll be
detaching HEAD, then this paragraph gets a LOT simpler.

> ++
> +You can use the `"@{-N}"` syntax to refer to the N-th last
> +branch/commit checked out using "git checkout" operation. You may
> +also specify `-` which is synonymous to `"@{-1}`.
> ++
> +As a special case, you may use `"A...B"` as a shortcut for the
> +merge base of `A` and `B` if there is exactly one merge base. You can
> +leave out at most one of `A` and `B`, in which case it defaults to `HEAD=
`.

I actually didn't know about the A...B special case for checkout.
Interesting...but I'm starting to wonder if this is too much info for
a "simplified command".

> +
> +<new_branch>::
> +       Name for the new branch.
> +
> +<start_point>::
> +       The name of a commit at which to start the new branch; see
> +       linkgit:git-branch[1] for details. Defaults to HEAD.

Erm, so if <start_point> is given, and there is an associated remote
tracking branch for the given branch name, perhaps we don't set up the
automatic tracking in contrast to what I mentioned above?  Hmm...

> +
> +DETACHED HEAD
> +-------------
> +include::detach-head.txt[]
> +
> +EXAMPLES
> +--------
> +
> +. The following sequence checks out the `master` branch.
> ++
> +------------
> +$ git switch-branch master
> +------------
> ++
> +
> +. After working in the wrong branch, switching to the correct
> +branch would be done using:
> ++
> +------------
> +$ git switch-branch mytopic
> +------------
> ++
> +However, your "wrong" branch and correct "mytopic" branch may
> +differ in files that you have modified locally, in which case
> +the above checkout would fail like this:
> ++
> +------------
> +$ git switch-branch mytopic
> +error: You have local changes to 'frotz'; not switching branches.
> +------------
> ++
> +You can give the `-m` flag to the command, which would try a
> +three-way merge:
> ++
> +------------
> +$ git switch-branch -m mytopic
> +Auto-merging frotz
> +------------
> ++
> +After this three-way merge, the local modifications are _not_
> +registered in your index file, so `git diff` would show you what
> +changes you made since the tip of the new branch.
> +
> +. When a merge conflict happens during switching branches with
> +the `-m` option, you would see something like this:
> ++
> +------------
> +$ git switch-branch -m mytopic
> +Auto-merging frotz
> +ERROR: Merge conflict in frotz
> +fatal: merge program failed
> +------------
> ++
> +At this point, `git diff` shows the changes cleanly merged as in
> +the previous example, as well as the changes in the conflicted
> +files.  Edit and resolve the conflict and mark it resolved with
> +`git add` as usual:
> ++
> +------------
> +$ edit frotz
> +$ git add frotz
> +------------
> +
> +SEE ALSO
> +--------
> +linkgit:git-checkout[1]
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Makefile b/Makefile
> index 1a44c811aa..f035dbab9e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -777,9 +777,11 @@ BUILT_INS +=3D git-format-patch$X
>  BUILT_INS +=3D git-fsck-objects$X
>  BUILT_INS +=3D git-init$X
>  BUILT_INS +=3D git-merge-subtree$X
> +BUILT_INS +=3D git-restore-files$X
>  BUILT_INS +=3D git-show$X
>  BUILT_INS +=3D git-stage$X
>  BUILT_INS +=3D git-status$X
> +BUILT_INS +=3D git-switch-branch$X
>  BUILT_INS +=3D git-whatchanged$X
>
>  # what 'all' will build and 'install' will install in gitexecdir,
> diff --git a/builtin.h b/builtin.h
> index 6538932e99..01ed43ea69 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -214,6 +214,7 @@ extern int cmd_remote_fd(int argc, const char **argv,=
 const char *prefix);
>  extern int cmd_repack(int argc, const char **argv, const char *prefix);
>  extern int cmd_rerere(int argc, const char **argv, const char *prefix);
>  extern int cmd_reset(int argc, const char **argv, const char *prefix);
> +extern int cmd_restore_files(int argc, const char **argv, const char *pr=
efix);
>  extern int cmd_rev_list(int argc, const char **argv, const char *prefix)=
;
>  extern int cmd_rev_parse(int argc, const char **argv, const char *prefix=
);
>  extern int cmd_revert(int argc, const char **argv, const char *prefix);
> @@ -227,6 +228,7 @@ extern int cmd_show_index(int argc, const char **argv=
, const char *prefix);
>  extern int cmd_status(int argc, const char **argv, const char *prefix);
>  extern int cmd_stripspace(int argc, const char **argv, const char *prefi=
x);
>  extern int cmd_submodule__helper(int argc, const char **argv, const char=
 *prefix);
> +extern int cmd_switch_branch(int argc, const char **argv, const char *pr=
efix);
>  extern int cmd_symbolic_ref(int argc, const char **argv, const char *pre=
fix);
>  extern int cmd_tag(int argc, const char **argv, const char *prefix);
>  extern int cmd_tar_tree(int argc, const char **argv, const char *prefix)=
;
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 764e1a83a1..7dc0f4d3f3 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -33,6 +33,16 @@ static const char * const checkout_usage[] =3D {
>         NULL,
>  };
>
> +static const char * const switch_branch_usage[] =3D {
> +       N_("git switch-branch [<options>] [<branch>]"),
> +       NULL,
> +};
> +
> +static const char * const restore_files_usage[] =3D {
> +       N_("git restore-files [<options>] [<branch>] -- <file>..."),
> +       NULL,
> +};
> +
>  struct checkout_opts {
>         int patch_mode;
>         int quiet;
> @@ -1302,31 +1312,23 @@ static struct option *add_checkout_path_options(s=
truct checkout_opts *opts,
>         return newopts;
>  }
>
> -int cmd_checkout(int argc, const char **argv, const char *prefix)
> +static int checkout_main(int argc, const char **argv, const char *prefix=
,
> +                        struct checkout_opts *opts, struct option *optio=
ns,
> +                        const char * const usagestr[])
>  {
> -       struct checkout_opts real_opts;
> -       struct checkout_opts *opts =3D &real_opts;
>         struct branch_info new_branch_info;
>         int dwim_remotes_matched =3D 0;
> -       struct option *options =3D NULL;
>
> -       memset(opts, 0, sizeof(*opts));
>         memset(&new_branch_info, 0, sizeof(new_branch_info));
>         opts->overwrite_ignore =3D 1;
>         opts->prefix =3D prefix;
>         opts->show_progress =3D -1;
> -       opts->dwim_new_local_branch =3D 1;
>
>         git_config(git_checkout_config, opts);
>
>         opts->track =3D BRANCH_TRACK_UNSPECIFIED;
>
> -       options =3D parse_options_dup(options);
> -       options =3D add_common_options(opts, options);
> -       options =3D add_switch_branch_options(opts, options);
> -       options =3D add_checkout_path_options(opts, options);
> -
> -       argc =3D parse_options(argc, argv, prefix, options, checkout_usag=
e,
> +       argc =3D parse_options(argc, argv, prefix, options, usagestr,
>                              PARSE_OPT_KEEP_DASHDASH);
>
>         if (opts->show_progress < 0) {
> @@ -1455,3 +1457,61 @@ int cmd_checkout(int argc, const char **argv, cons=
t char *prefix)
>                 return checkout_branch(opts, &new_branch_info);
>         }
>  }
> +
> +int cmd_checkout(int argc, const char **argv, const char *prefix)
> +{
> +       struct checkout_opts opts;
> +       struct option *options =3D NULL;
> +       int ret;
> +
> +       memset(&opts, 0, sizeof(opts));
> +       opts.dwim_new_local_branch =3D 1;
> +
> +       options =3D parse_options_dup(options);
> +       options =3D add_common_options(&opts, options);
> +       options =3D add_switch_branch_options(&opts, options);
> +       options =3D add_checkout_path_options(&opts, options);
> +
> +       ret =3D checkout_main(argc, argv, prefix, &opts,
> +                           options, checkout_usage);
> +       FREE_AND_NULL(options);
> +       return ret;
> +}
> +
> +int cmd_switch_branch(int argc, const char **argv, const char *prefix)
> +{
> +       struct checkout_opts opts;
> +       struct option *options =3D NULL;
> +       int ret;
> +
> +       memset(&opts, 0, sizeof(opts));
> +       opts.dwim_new_local_branch =3D 1;
> +
> +       options =3D parse_options_dup(options);
> +       options =3D add_common_options(&opts, options);
> +       options =3D add_switch_branch_options(&opts, options);
> +
> +       ret =3D checkout_main(argc, argv, prefix, &opts,
> +                           options, switch_branch_usage);
> +       FREE_AND_NULL(options);
> +       return ret;
> +}
> +
> +int cmd_restore_files(int argc, const char **argv, const char *prefix)
> +{
> +       struct checkout_opts opts;
> +       struct option *options =3D NULL;
> +       int ret;
> +
> +       memset(&opts, 0, sizeof(opts));
> +       opts.dwim_new_local_branch =3D 1;
> +
> +       options =3D parse_options_dup(options);
> +       options =3D add_common_options(&opts, options);
> +       options =3D add_checkout_path_options(&opts, options);
> +
> +       ret =3D checkout_main(argc, argv, prefix, &opts,
> +                           options, restore_files_usage);
> +       FREE_AND_NULL(options);
> +       return ret;
> +}
> diff --git a/command-list.txt b/command-list.txt
> index 3a9af104b5..4638802754 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -151,6 +151,7 @@ git-replace                             ancillarymani=
pulators           complete
>  git-request-pull                        foreignscminterface             =
complete
>  git-rerere                              ancillaryinterrogators
>  git-reset                               mainporcelain           worktree
> +git-restore-files                       mainporcelain           worktree
>  git-revert                              mainporcelain
>  git-rev-list                            plumbinginterrogators
>  git-rev-parse                           plumbinginterrogators
> @@ -171,6 +172,7 @@ git-status                              mainporcelain=
           info
>  git-stripspace                          purehelpers
>  git-submodule                           mainporcelain
>  git-svn                                 foreignscminterface
> +git-switch-branch                       mainporcelain           history
>  git-symbolic-ref                        plumbingmanipulators
>  git-tag                                 mainporcelain           history
>  git-unpack-file                         plumbinginterrogators
> diff --git a/git.c b/git.c
> index 2f604a41ea..a2be6c3eb5 100644
> --- a/git.c
> +++ b/git.c
> @@ -542,6 +542,7 @@ static struct cmd_struct commands[] =3D {
>         { "replace", cmd_replace, RUN_SETUP },
>         { "rerere", cmd_rerere, RUN_SETUP },
>         { "reset", cmd_reset, RUN_SETUP },
> +       { "restore-files", cmd_restore_files, RUN_SETUP | NEED_WORK_TREE =
},
>         { "rev-list", cmd_rev_list, RUN_SETUP | NO_PARSEOPT },
>         { "rev-parse", cmd_rev_parse, NO_PARSEOPT },
>         { "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
> @@ -557,6 +558,7 @@ static struct cmd_struct commands[] =3D {
>         { "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
>         { "stripspace", cmd_stripspace },
>         { "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT=
_SUPER_PREFIX | NO_PARSEOPT },
> +       { "switch-branch", cmd_switch_branch, RUN_SETUP | NEED_WORK_TREE =
},
>         { "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
>         { "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
>         { "unpack-file", cmd_unpack_file, RUN_SETUP | NO_PARSEOPT },
> --
> 2.20.0.rc1.380.g3eb999425c.dirty
>
