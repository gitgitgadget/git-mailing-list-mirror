Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBE1C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 15:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjEBPz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 11:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjEBPz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 11:55:57 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4C3195
        for <git@vger.kernel.org>; Tue,  2 May 2023 08:55:54 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f00d3f98deso29193821e87.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 08:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683042952; x=1685634952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eF/WMhm3UUVnP+meu/RGJfiAKR8toaHwAho40qdMeF4=;
        b=ov3F/rbN7hHdIen+ykck4miX+MZK4X5ho5mwgLK/tvOut7BZxLt35K3soNZ13/IKtS
         mMAU8/9kwiX0vh4WGXd2CJC19jNmt7Nrq9Te/8aRNcqcODhhD3zzqSobQGTasvwnuT0a
         spq/k4CxuzQUYtRPjDLS1qnL3zxC0GyIbDfIwR/LHxhKWMBYyg3TQfzD4n+h7ZWrxMU1
         KU7BoNEpFKskcqIepKuCYyTXee905hHA6OG4ukaP9M7geirh5TAWOd+TevTy/s1lm8tr
         j7lxf9UJ7fYy8Xb/GLFoyf0fyn9ZGa6Ii4FZxUD2MFRuHSzYctlW8Yl/dZrm1o/Ms+99
         ahyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683042952; x=1685634952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eF/WMhm3UUVnP+meu/RGJfiAKR8toaHwAho40qdMeF4=;
        b=DWZnLjEfx+1TvLgWE9fnsl29L9XgT1OSUF0+2+QN7OStg0UoTpc8UlzFJdlQfzewtN
         my92iQQTEmd+V8yoCW35CIClJQpij1b3ftRpVZnrrL6kZuOZDWKo2OMB97bohRVT+t//
         VijhQ45vIVGac6n5AGz7GCmAT6kJX4IPVU9ML35BBTGt+sWKn4gEYhb2BoIMHP9E6Z34
         WYjp9Ftfx/EM1qRWbzcPmIwmxGlw9a6u6THCtyTxTn5ebWnlO6gjl36cIK1fzoJTWBE+
         lruDh7sA/wnW4S2p1AAWfgChrvMHdM7mzRApZJlJDUQhRFfWzfmLHIkIcbau7sELsh+N
         Wowg==
X-Gm-Message-State: AC+VfDw+mTGfnpYkZHIqr/5pwtS51TAX7GFCKoqx03N6Jwtu4kRBnFpj
        tALxGSArfA3v97HmEpLYEMSgg/L8wAJtFbzOHc8=
X-Google-Smtp-Source: ACHHUZ7emobSZ0sLfcT4U0Jwl29BhkXmoMra3Vm9DHKuoMtzlRVNI4kxuvq9TE6ZjRdnbKP3H1U2d8M070viiQh91oI=
X-Received: by 2002:a05:6512:304b:b0:4ef:ee59:d28d with SMTP id
 b11-20020a056512304b00b004efee59d28dmr127244lfb.7.1683042951732; Tue, 02 May
 2023 08:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1527.git.1683008869804.gitgitgadget@gmail.com>
In-Reply-To: <pull.1527.git.1683008869804.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 2 May 2023 08:55:39 -0700
Message-ID: <CABPp-BH8A=CnO3_UWXDegb87VTNEX8s+=CefB90m1_vjBZ_+Fw@mail.gmail.com>
Subject: Re: [PATCH] RFC: switch: allow same-commit switch during merge if
 conflicts resolved
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2023 at 11:57=E2=80=AFPM Tao Klerks via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Tao Klerks <tao@klerks.biz>
>
> When a "git checkout" branch-switch operation runs during a merge, the
> in-progress merge metadata is removed. The refusal to maintain the merge
> matadata makes sense if the new commit is different to the original commi=
t,

s/matadata/metadata/

> because a merge operation against a different commit could have turned ou=
t
> differently / maintaining the merge relationship would be misleading. It =
is
> still a difficult-to-understand behavior for new users, however, as they
> would expect a switch (to a new or same-commit branch at least) to allow
> committing local changes "faithfully", as in the case of regular non-merg=
e
> local changes.

> "git switch" introduces a little more safety, by refusing to switch if th=
ere

s/little/lot/ or s/a little//

By the way, it was a problem that git-checkout wasn't updated to have
the same safety that git-switch has.  We should fix that.  (It's on my
todo list, along with adding other
prevent-erroneous-command-while-in-middle-of-other-operation cases.)

> is a merge in progress - or a number of other operations such as rebase,
> cherry-pick, or "git am". This is less of a nasty surprise than the merge
> metadata/state being silently discarded, but is still not very helpful, w=
hen
> a user has a complex merge resolved, and wishes to commit it to a new bra=
nch
> for testing.

I'm worried this is likely to lead us into confusing UI mismatches,
and makes it harder to understand the appropriate rules of what can
and cannot be done.  A very simple "no switching branches in the
middle of operations" is a very simple rule, and saves users from lots
of headaches.

Granted, expert users may understand that with the commit being the
same, there is no issue.  But expert users can use `git update-ref` to
tweak HEAD, or edit .git/HEAD directly, and accept the consequences.
Why do we need to confuse the UI for the sake of expert users who
already have an escape hatch?

More importantly, though...

> Change the behavior of "git switch" and "git checkout" to no longer delet=
e
> merge metadata, nor prohibit the switch, if a merge is in progress and th=
e
> commit being switched to is the same commit the HEAD was previously set t=
o.

Even if there are conflicts?  For rebases, cherry-picks, ams, and
reverts too?  (Does allowing this during rebases and whatnot mean that
--abort becomes really funny?  Does it mean that some commits are
applied to one branch, and all commits are applied to another?  What
about autostashes?  Does it interact weirdly with --update-refs?
etc.)

I think this change is premature unless it discusses all these cases,
because UI backward-compatibility requirements means we can't rip this
out later if we add it, and any change here is going to lead to
questions about either inconsistencies in the UI for other operations
(why can't I also switch branches if there are conflicts?  why can't I
also switch branches to a same-commit branch during a rebase?) or
crazy problems we've introduced (`git rebase --abort` only aborted
changes to one of the branches I modified??  Which of the three
branches -- the one I started on, the one I was rebasing, or the one I
switched to in the middle -- is my autostash now found on??) by
opening this can of worms.

My first gut guess is that switching with conflicts would be just as
safe as this is, and any users who likes your change is going to
complain if we don't allow it during conflicts.  But I think it'd take
a fair amount of work to figure out if it's safe during
rebase/cherry-pick/am/revert (is it only okay on the very first patch
of a series?  And only if non-interactive?  And only without
--autostash and --update-refs?  etc.), and whether the ending set of
rules feels horribly inconsistent or feels fine to support.

> Also add a warning when the merge metadata is deleted (in case of a
> "git checkout" to another commit) to let the user know the merge state
> was lost, and that "git switch" would prevent this.

If we're touching this area, we should employ the right fix rather
than a half measure.  As I mentioned above, this should be an error
with the operation prevented -- just like switch behaves.

> Also add a warning when the merge metadata is preserved (same commit),
> to let the user know the commit message prepared for the merge may still
> refer to the previous branch.

So, it's not entirely safe even when the commit of the target branch
matches HEAD?  Is that perhaps reason to just leave this for expert
users to use the update-refs workaround?

> Add tests to verify the exception works correctly, and to verify that
> --force always wipes out in-progress merge metadata when it is discarding
> worktree changes.
>
> Signed-off-by: Tao Klerks <tao@klerks.biz>
> ---
>     RFC: switch: allow same-commit switch during merge if conflicts resol=
ved
>
>     RFC V1: proposing a limited-scope change as per mailing discussion
>     https://lore.kernel.org/git/CAPMMpoht4FWnv-WuSM3+Z2R4HhwFY+pahJ6zirFU=
-BD5r34B7Q@mail.gmail.com/T/#t
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1527%2F=
TaoK%2Ftao-checkout-during-merge-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1527/TaoK/=
tao-checkout-during-merge-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1527
>
>  branch.c           |  7 ++++-
>  branch.h           |  6 +++++
>  builtin/checkout.c | 64 ++++++++++++++++++++++++++++++++++++++++++----
>  t/t2060-switch.sh  | 18 ++++++++++++-
>  4 files changed, 88 insertions(+), 7 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 5aaf073dce1..8cc7fabe599 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -812,10 +812,15 @@ void remove_merge_branch_state(struct repository *r=
)
>  }
>
>  void remove_branch_state(struct repository *r, int verbose)
> +{
> +       remove_branch_state_except_merge(r, verbose);
> +       remove_merge_branch_state(r);
> +}
> +
> +void remove_branch_state_except_merge(struct repository *r, int verbose)
>  {
>         sequencer_post_commit_cleanup(r, verbose);
>         unlink(git_path_squash_msg(r));
> -       remove_merge_branch_state(r);
>  }
>
>  void die_if_checked_out(const char *branch, int ignore_current_worktree)
> diff --git a/branch.h b/branch.h
> index ef56103c050..c73d98b8766 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -135,6 +135,12 @@ void remove_merge_branch_state(struct repository *r)=
;
>   */
>  void remove_branch_state(struct repository *r, int verbose);
>
> +/*
> + * Remove information about the state of working on the current
> + * branch, *except* merge state.
> + */
> +void remove_branch_state_except_merge(struct repository *r, int verbose)=
;
> +
>  /*
>   * Configure local branch "local" as downstream to branch "remote"
>   * from remote "origin".  Used by git branch --set-upstream.
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 21a4335abb0..cae54af997b 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -985,7 +985,11 @@ static void update_refs_for_switch(const struct chec=
kout_opts *opts,
>                                 delete_reflog(old_branch_info->path);
>                 }
>         }
> -       remove_branch_state(the_repository, !opts->quiet);
> +
> +       remove_branch_state_except_merge(the_repository, !opts->quiet);
> +       if (opts->force || old_branch_info->commit !=3D new_branch_info->=
commit) {
> +               remove_merge_branch_state(the_repository);
> +       }
>         strbuf_release(&msg);
>         if (!opts->quiet &&
>             (new_branch_info->path || (!opts->force_detach && !strcmp(new=
_branch_info->name, "HEAD"))))
> @@ -1098,6 +1102,36 @@ static void orphaned_commit_warning(struct commit =
*old_commit, struct commit *ne
>         release_revisions(&revs);
>  }
>
> +/*
> + * Check whether we're in a merge, and if so warn - about the ongoing me=
rge and surprising merge
> + * message if the merge state will be preserved, and about the destroyed=
 merge state otherwise.
> + */
> +static void merging_checkout_warning(const char *name, struct commit *ol=
d_commit,
> +                                     struct commit *new_commit)
> +{
> +       struct wt_status_state state;
> +       memset(&state, 0, sizeof(state));
> +       wt_status_get_state(the_repository, &state, 0);
> +
> +       if (!state.merge_in_progress)
> +       {
> +               wt_status_state_free_buffers(&state);
> +               return;
> +       }
> +
> +       if (old_commit =3D=3D new_commit)
> +               warning(_("switching while merge-in-progress (without cha=
nging commit).\n"
> +                         "An auto-generated commit message may still ref=
er to the previous\n"
> +                         "branch.\n"));
> +       else
> +               warning(_("switching to a different commit while while me=
rge-in-progress;\n"
> +                         "merge metadata was removed. To avoid accidenta=
lly losing merge,\n"
> +                         "metadata in this way, please use \"git switch\=
" instead of\n"
> +                         "\"git checkout\".\n"));
> +
> +       wt_status_state_free_buffers(&state);
> +}
> +
>  static int switch_branches(const struct checkout_opts *opts,
>                            struct branch_info *new_branch_info)
>  {
> @@ -1153,6 +1187,9 @@ static int switch_branches(const struct checkout_op=
ts *opts,
>         if (!opts->quiet && !old_branch_info.path && old_branch_info.comm=
it && new_branch_info->commit !=3D old_branch_info.commit)
>                 orphaned_commit_warning(old_branch_info.commit, new_branc=
h_info->commit);
>
> +       if (!opts->quiet && !opts->force)
> +               merging_checkout_warning(old_branch_info.name, old_branch=
_info.commit, new_branch_info->commit);
> +
>         update_refs_for_switch(opts, &old_branch_info, new_branch_info);
>
>         ret =3D post_checkout_hook(old_branch_info.commit, new_branch_inf=
o->commit, 1);
> @@ -1445,15 +1482,31 @@ static void die_expecting_a_branch(const struct b=
ranch_info *branch_info)
>         exit(code);
>  }
>
> -static void die_if_some_operation_in_progress(void)
> +static void die_if_some_incompatible_operation_in_progress(struct commit=
 *new_commit)
>  {
> +       /*
> +        * Note: partially coordinated logic in related function
> +        * merging_checkout_warning(), checking for merge_in_progress
> +        * and old_commit !=3D new_commit to issue warnings. Issuing thos=
e
> +        * warnings here would be simpler to implement, but would make th=
e
> +        * language more complex to account for common situations where t=
he
> +        * switch still won't happen (namely working tree merge failure).
> +        */
> +
>         struct wt_status_state state;
> +       struct branch_info old_branch_info =3D { 0 };
> +       struct object_id rev;
> +       int flag;
>
>         memset(&state, 0, sizeof(state));
>         wt_status_get_state(the_repository, &state, 0);
> +       memset(&old_branch_info, 0, sizeof(old_branch_info));
> +       old_branch_info.path =3D resolve_refdup("HEAD", 0, &rev, &flag);
> +       if (old_branch_info.path)
> +               old_branch_info.commit =3D lookup_commit_reference_gently=
(the_repository, &rev, 1);
>
> -       if (state.merge_in_progress)
> -               die(_("cannot switch branch while merging\n"
> +       if (state.merge_in_progress && old_branch_info.commit !=3D new_co=
mmit)
> +               die(_("cannot switch to a different commit while merging\=
n"
>                       "Consider \"git merge --quit\" "
>                       "or \"git worktree add\"."));
>         if (state.am_in_progress)
> @@ -1476,6 +1529,7 @@ static void die_if_some_operation_in_progress(void)
>                 warning(_("you are switching branch while bisecting"));
>
>         wt_status_state_free_buffers(&state);
> +       branch_info_release(&old_branch_info);
>  }
>
>  static int checkout_branch(struct checkout_opts *opts,
> @@ -1536,7 +1590,7 @@ static int checkout_branch(struct checkout_opts *op=
ts,
>                 die_expecting_a_branch(new_branch_info);
>
>         if (!opts->can_switch_when_in_progress)
> -               die_if_some_operation_in_progress();
> +               die_if_some_incompatible_operation_in_progress(new_branch=
_info->commit);
>
>         if (new_branch_info->path && !opts->force_detach && !opts->new_br=
anch &&
>             !opts->ignore_other_worktrees) {
> diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
> index 5a7caf958c3..9c80d469b6b 100755
> --- a/t/t2060-switch.sh
> +++ b/t/t2060-switch.sh
> @@ -111,13 +111,29 @@ test_expect_success 'guess and create branch' '
>         test_cmp expected actual
>  '
>
> -test_expect_success 'not switching when something is in progress' '
> +test_expect_success 'not switching to a different commit when something =
is in progress' '
>         test_when_finished rm -f .git/MERGE_HEAD &&
>         # fake a merge-in-progress
>         cp .git/HEAD .git/MERGE_HEAD &&
>         test_must_fail git switch -d @^
>  '
>
> +test_expect_success 'switching to same-commit when merge is in progress =
succeeds' '
> +       test_when_finished rm -f .git/MERGE_HEAD &&
> +       # fake a merge-in-progress
> +       cp .git/HEAD .git/MERGE_HEAD &&
> +       git switch -d @ &&
> +       # confirm the merge-in-progress is still there
> +       test -e .git/MERGE_HEAD
> +'
> +test_expect_success 'switching with --force removes merge state' '
> +       test_when_finished rm -f .git/MERGE_HEAD &&
> +       # fake a merge-in-progress
> +       cp .git/HEAD .git/MERGE_HEAD &&
> +       git switch --force -d @ &&
> +       # confirm the merge-in-progress is removed
> +       test ! -e .git/MERGE_HEAD
> +'
>  test_expect_success 'tracking info copied with autoSetupMerge=3Dinherit'=
 '
>         # default config does not copy tracking info
>         git switch -c foo-no-inherit foo &&
>
> base-commit: 950264636c68591989456e3ba0a5442f93152c1a
> --
> gitgitgadget
