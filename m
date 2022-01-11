Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BD7C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 19:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiAKT1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 14:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbiAKT1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 14:27:43 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89316C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 11:27:43 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b13so609369edn.0
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 11:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1dsql/PzfTgVDVJ2O+JnCHe8fl/C/052t8FKVkVCDU=;
        b=JiNn2y8P7RzOvB4kK7OX1fJJJ315OTgY3F+SFoy1WGWFvDvipnkugEliId/0Yq+TQa
         Ig9N/iSgSEr5ntjiIZGkRemdsB5jnq1vfdZKEi9ZECkVHbk4DZekq3b6U/9KnoQC0C+t
         l+feApTT3c18Hs7MvI3n2EbUsfJMqixHfR+g0fn+9w0RZnMEkHelDOzlXXZbjn/lNf+a
         UDg/y/ANSlsqNNgVKyD9Qy49hY9dHrHN6A33GV2kqxUsubEZhcq6WcWIyn700RCLycJ0
         9KF3lAOYfbxOUBVj+5EVkm131nbVcru+Ao9RV9ce4kXI0K5JwU1rMZpZ5LkxProVrsUm
         +Zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1dsql/PzfTgVDVJ2O+JnCHe8fl/C/052t8FKVkVCDU=;
        b=HSdSsGqMgFtGPxt8T8x6obUqH76bfHgBxIxHVCzCA91sk/wOYF7tRX/gdkeSkGOzXv
         SKbbjPVdB2VZ+bgnv8jfgI/MokmB6bmkh/gn2arrHP5XXxnFG4Lm63+KUUkWUS57I23y
         rOZvKspcyfr8I0q3tcMq/EPNSZZPmhGRTZ9RejaETozYFVjzeyh+H8zQk3l2T1lnhW9r
         5NNRd436J8U6/MSwr+1T0RHK6xCm4EgrhfQbNwLb2NhFQJaDUblMAHKShVPTuNtjs/r3
         mBlm0VT3NO9G4abkabdfkunbTwHEqrOzLEcG8GboRlfc0dS1H5IRuoodE2PHL+V26gmj
         01+g==
X-Gm-Message-State: AOAM531GGPi9eqxWXR23PQAcJw/M11N3/Bx7U5KG8qZ3HvmMqgfenJkA
        YtDIrUYVKJmEDUGM0RAjvMIwSGoO5s9wRWDvWqT2m5kgQU96/Q==
X-Google-Smtp-Source: ABdhPJyqy6bLoHlgkCLGjEXYGke1TejVLSjXGE0bLsc1TObNTbfuHsKglBYr65F37vIVdZPjUMZAGRQojiICILC4q70=
X-Received: by 2002:a17:907:8687:: with SMTP id qa7mr4808551ejc.192.1641929261935;
 Tue, 11 Jan 2022 11:27:41 -0800 (PST)
MIME-Version: 1.0
References: <20220109045732.2497526-1-newren@gmail.com> <20220109045732.2497526-4-newren@gmail.com>
 <38b69b5e-b461-23cc-155e-26fd58e5f714@github.com>
In-Reply-To: <38b69b5e-b461-23cc-155e-26fd58e5f714@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 Jan 2022 11:27:29 -0800
Message-ID: <CABPp-BGaK1JBUrEnqynoeNAsrVmMWO_-94OswDai4KQdsjGrTw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] repo_read_index: ensure SKIP_WORKTREE means skip worktree
To:     Victoria Dye <vdye@github.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 10, 2022 at 12:38 PM Victoria Dye <vdye@github.com> wrote:
>
> Elijah Newren wrote:
...
> > === User facing issues ===
...
> > Further:
> >   * these files will not be updated by by standard commands
> >     (switch/checkout/pull/merge/rebase will leave them alone unless
> >     conflicts happen -- and even then, the conflicted file may be
> >     written somewhere else to avoid overwriting the SKIP_WORKTREE file
> >     that is present and in the way)
> >   * there is nothing in Git that users can use to discover such
> >     files (status, diff, grep, etc. all ignore it)
> >   * there is no reasonable mechanism to "recover" from such a condition
> >     (neither `git sparse-checkout reapply` nor `git reset --hard` will
> >     correct it).
> >
>
> Just to add to this, files like these always force sparse index expansion in
> `git status` (and probably some other commands?), ruining a lot of the
> performance gains of using sparse index in the first place.

Oh, good point.  Another reason this state is just bad.

...
> > === Suggested solution ===
> >
> > SKIP_WORKTREE was written to allow sparse-checkouts, in particular, as
> > the name of the option implies, to allow the file to NOT be in the
> > worktree but consider it to be unchanged rather than deleted.
> >
> > The suggests a simple solution: present-despite-SKIP_WORKTREE files
> > should not exist, for those using sparse-checkouts.
> >
> > Enforce this at index loading time by checking if core.sparseCheckout is
> > true; if so, check files in the index with the SKIP_WORKTREE bit set to
> > verify that they are absent from the working tree.  If they are present,
> > unset the bit (in memory, though any commands that write to the index
> > will record the update).
> >
>
> Since this solution is specific to a sparse-checkout, should this automatic
> unsetting only be done if the file is outside the sparse checkout
> definition? Otherwise, the `sparse-checkout reapply` cleanup suggested below
> doesn't return the original `skip-worktree` state.

That's an interesting distinction, but I think there are multiple
problems with it:
  1) I think you might be assuming this state would only be entered by
a deliberate user choice, but that's far from the case
  2) Allowing present-despite-SKIP_WORKTREE only for in-cone paths
still allows the state to exist, which has multiple ramifications:
    2A) while it solves user facing problems for out-of-cone
present-despite-SKIP_WORKTREE files, it leaves user facing problems
for in-cone ones
    2B) it doesn't solve any of the complexity or need for special
testing outlined in the commit message since the bad state is still
possible for some paths
    2C) Related to (2B), your series would need to do more work to
make checkout-index sane
  3) It's basically impossible to keep this kind of skip-worktree
state in a sparse-checkout anyway.

Let's look at (1), (2A), and (3) in more detail, since those may not be obvious:

=== (1) present-despite-SKIP_WORKTREE on in-cone can be triggered
accidentally ===

Users can directly edit $GIT_DIR/info/sparse-checkout.  We documented
how for years.  People wrote tools that did so.  `git sparse-checkout`
came much later.  So, they could get into this state by having a
sparse-checkout already, and then editing
$GIT_DIR/info/sparse-checkout such that the files which used to be
out-of-cone are now in-cone even though the working directory doesn't
match.  People could also get into this state without knowing about
the $GIT_DIR/info/sparse-checkout file, with an in-opportune Ctrl-C
during the middle of a `git sparse-checkout ...` command of some sort.
I actually think it's more likely that people accidentally get into
this state than deliberately.  However, for sake of argument, let's
presume people could only get into this state intentionally.  I think
we'd still want to make my changes for this class of files because of
the other reasons, so let's move on to those...

=== (2A) present-despite-SKIP_WORKTREE on in-cone has user-facing
problems too ===

So, we have a user who has some file(s) that are marked SKIP_WORKTREE
despite being in-cone.  Let's assume that the in-cone file has some
dirty change(s).  First, note that the in-cone file is already
SKIP_WORKTREE:

   $ git ls-files -t
   S in-cone/foo.c
   S out-of-cone/tracked

Now this user tries to switch to another branch which does differ in
in-cone/foo.c (or try to do a rebase that involves in-cone/foo.c,
or...):

   $ git checkout other-branch-modifying-in-cone
   error: Your local changes to the following files would be
overwritten by checkout:
   in-cone/foo.c
   Please commit your changes or stash them before you switch branches.
   Aborting

Oh, thinks the user, maybe I should check status before switching branches:

   $ git status --porcelain
   $

The user perhaps finds it odd that the file reported as having "local
changes" doesn't show up in status, but decides to do what the error
message reported anyway:

   $ git stash save foobar
   No local changes to save

If neither status nor stash think there are any changes, why does
checkout?  Why can't I switch branches??  If they attempt to switch
branches again anyway, they'll get the same local-changes error.
Perhaps at this point they notice there were two possible solutions in
the error message, so they decide to try committing the changes:

   $ git commit -am 'changes'
   On branch main
   You are in a sparse checkout with 0% of tracked files present.

   nothing to commit, working tree clean

Three commands tell me my working tree is clean, but checkout says
otherwise?!?!?  Why can't I switch branches???  Stupid Git!  (And if
someone points them at `git add $FILENAME`, then they get another
error message and are told to use `git add --sparse $FILENAME`...)

In contrast, with my patch, none of this craziness happens and a
locally modified file is detected and reported as locally modified by
every command within a sparse checkout.  It's so much saner for users.

But, for sake of argument, let's ignore all of the reasons so far and
instead pretend there are users who deliberately create skip-worktree
files in-cone, and thus expect all these weirdnesses.  Let's focus on
the experience they might expect, and turn to item (3):

=== (3) present-despite-SKIP_WORKTREE on in-cone files will be
aggressively cleared _anyway_, due to the fundamental design of
sparse-checkout ===

Let's say I have a simple sparse-checkout with just a couple files:

   $ git ls-files -t
   H in-cone/foo.c
   S out-of-cone/tracked

Now, I decide to make in-cone/foo.c skip-worktree, but keep it in the
working tree and dirty its contents:

   $ git update-index --skip-worktree in-cone/foo.c
   $ echo dirty >in-cone/foo.c
   $ git ls-files -t
   S in-cone/foo.c
   S out-of-cone/tracked

Now, status won't report our dirty modifications, commit won't include
them, etc.  Perhaps that's what the user wanted by marking it as
skip-worktree.  But as soon as they invoke any command that calls
unpack_trees() in a way that might update the working copy (but which
wouldn't need to touch the dirty files marked skip-worktree), the
skip-worktree status is going to be dropped:

   $ git checkout -q HEAD^0
   warning: The following paths were already present and thus not
updated despite sparse patterns:
   in-cone/foo.c

   After fixing the above paths, you may want to run `git
sparse-checkout reapply`.
   Switched to branch 'other-mod'
   $ git ls-files -t
   H in-cone/foo.c
   S out-of-cone/tracked

This is not special to detaching HEAD; I could have switched to
another branch and seen the same thing.  Or rebased or cherry-picked
or merge commits that didn't modify the skip-worktree file, and they'd
all unset the skip-worktree bit for this file.  This isn't a bug,
either; it's by design.  sparsity patterns have to be reapplied when
switching branches in general (or rebasing or...), because that
operation might bring in new files and so we need to know whether
those new files should be SKIP_WORKTREE.  You might say we could
attempt to limit the SKIP_WORKTREE bit flipping to "just" new files,
but due to the possibility of conflicts in earlier merges/rebases
causing files to lose the SKIP_WORKTREE bit, we wanted future
operations that were busy updating the bits anyway to update those
files and clear the bit (and this pre-dated the work Stolee and I did
on sparse-checkouts, btw).

So, this means that checkout, merge, rebase, cherry-pick, etc. are
going to be clearing SKIP_WORKTREE bits for in-cone files all the
time.

So, even if users did try to deliberately get into such a state,
there's no point attempting to preserve the bit since so many commands
are going to be aggressively clearing it anyway.

> Admittedly, I imagine it's unlikely that someone is simultaneously using a
> sparse checkout and manually SKIP_WORKTREE-ing files *inside* the sparse
> checkout definition. But, given that you're not unsetting the flag for
> non-sparse-checkout SKIP_WORKTREE files, it seems like an additional
> constraint based on sparse checkout patterns would be consistent with
> other parts of this patch.
>
> > Users can, of course, can get the SKIP_WORKTREE bit back such as by
> > running `git sparse-checkout reapply` (if they have ensured the file is
> > unmodified and doesn't match the specified sparsity patterns).
> >
>
> There are some performance implications of this solution in a sparse
> index-enabled checkout. Any time an out-of-cone file is no longer
> SKIP_WORKTREE, its parent directory lineage will be added to the sparse index,
> and performance would progressively (silently) degrade as more out-of-cone
> files were added.

Can I restate this a bit?

"""
The point of sparse-index is to allow operations to be faster due to
needing to track fewer items in the index.  Its performance is nearly
linearly correlated with the number of paths it has to track, so fewer
paths is better.  If a user needs to work with more paths than they
previously did, then their sparse-index will be correspondingly
slower.

And users who start modifying files, are obviously working with more
paths than they previously did.
"""

Based on that restating, I think the only thing that could be
considered a problem is your implication that the performance
degradation would silently persist.  If users don't undo or commit
those local modifications, then they really are working with more
files and I think it's fine for the sparse-index to remain expanded to
include those files.  In contrast, if users undo those local changes
(or commit them so they are no longer dirty), then future
checkout/rebase/merge/etc. operations will automatically (re-)set the
SKIP_WORKTREE bit on those files, and the sparse-index can shrink
again.  These dirty files would be very similar to files that have
conflicts during a merge: both have their SKIP_WORKTREE bit cleared
despite being outside the sparsity paths.  Continuing the comparison,
after a user resolves a conflict and commits the changes, the
previously conflicted file will automatically have its SKIP_WORKTREE
bit set again by a future checkout/rebase/merge/etc.  Or users can
manually get it to be set earlier with a `git sparse-checkout
reapply`.  So the performance degradation from the additional paths
the user is working with is only temporary, and only lasts roughly as
long as the user is still working with these additional paths.  To me,
this feels like expected and wanted behavior.

> That said, a lot of my concern would be alleviated with some kind of warning
> indicating that a file just had SKIP_WORKTREE removed, including a mention
> of fixing it with `git sparse-checkout reapply`.

That might be interesting, but there's two problems here:
  * It'd affect more types of files and situations than intended.  In
particular, given [11], it could be quite noisy due to triggering on
files other than those manually tweaked by users and even include
files never involved in conflicts either.
  * It'd repeatedly trigger on the exact same files, possibly muddying
other output unexpectedly.  Given that we clear the bit in memory but
not necessarily on disk, users would repeatedly see the same warning
for the same files during sequences of read-only operations (like `git
diff` or `git log`) and they warnings would only go away once the user
ran a command that re-wrote the index (such as `git status`).

I think the point of your suggestion was to help users recover from
potentially persisting performance degradation; is that fair?  If so,
then as I highlighted above, I don't think we have any such persisting
problem.

[11] https://lore.kernel.org/git/xmqqbmb1a7ga.fsf@gitster-ct.c.googlers.com/

> It would be *extra* nice if `git status` could tell a user that they have
> non-SKIP_WORKTREE files outside the sparse definition, but I think that's
> less critical and probably better suited as a separate series.

Oh, interesting idea.  But I agree, it'd be better suited to a separate series.

> > diff --git a/sparse-index.c b/sparse-index.c
> > index a1d505d50e..79d50e444c 100644
> > --- a/sparse-index.c
> > +++ b/sparse-index.c
> > @@ -341,6 +341,28 @@ void ensure_correct_sparsity(struct index_state *istate)
> >               ensure_full_index(istate);
> >  }
> >
> > +void ensure_skip_worktree_means_skip_worktree(struct index_state *istate)
>
> I can feel the frustration behind this name. :)

:-)

> However, a more descriptive one would make the code easier to follow, e.g.
> 'clear_skip_worktree_from_present_files' (or something else indicating what
> it does to the index).

Yeah, I did spend some time trying to come up with a better name (I
realized it wasn't the best), but failed.  Your suggestion seems
obvious in hindsight.  I like it; I'll make that change.
