Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64A6C433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 00:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351855AbiA2AE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 19:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344625AbiA2AE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 19:04:59 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0459C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 16:04:58 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id r3-20020a634403000000b0034dea886e0aso4171040pga.21
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 16:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=D1KFVWR5YZZQovgVb1mno3TFJ0mrj+kHjv6S0gLHS4A=;
        b=e+iMifGRYDBH1GheFKg0ePtiwtfKntLwrUoSIwPWmkAcpWZGSo422TIeD74K0Tyjr6
         i4dVrEFG6ay/7XAv6Z+MijFQdXDN1LseeKoKYvcykyxW+dxgxuNqYD1DqmIshG8jUc90
         +rdWXGcdy8OSiO532wE6UzKeuPF8xMnutuHm/Kty0Nqdg72/DQiUgd2A5VFOYjzB8ROl
         iZ7bHWP+/0NJWfc0mPQKf//TbZK+1YGbsAmy0md+KtRQMV1xgo9DDbBz0tHCDG5yrGEP
         mHoL9wQGkKFHwCBhG46uM7qDkbXKijE41vz6pB1gC1frY8ZJooLys7Ba89aBrHg2FvAe
         cjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=D1KFVWR5YZZQovgVb1mno3TFJ0mrj+kHjv6S0gLHS4A=;
        b=zzuN68CTHNyBGOnWwDHoWVmOI7Yi1FbVHRg8v7njH6dENPQHmc6igvBOsa1N8ViIzy
         ocwUz5P5GKPKEJCRQmnAJOQcwm2omPo2nPw6pq2dcOP4rP24TPDLmS13INvkjyiKcovX
         4b9SXakqflVz3HyCNAQKf3ILcW1AD+PaFUD1pn8qSfwu2+tHQ3s0NhOoEiIztef7JQrl
         5tJK2TDcIBfMC+/lODeMKjX8toIe9h+fn3mTaZCSAH7rOFaBJoVguLnEz6eWRgrbyiE4
         GJQgwAtHY5kptkvyv1rXAgPnsSKnGp/I6wjd5LXb/jwciULIrnPGqRkgJhld7iE+iNUk
         149A==
X-Gm-Message-State: AOAM5306oP5GMJBmqn7PsdDCDpKWBSqiWLLKvpKzTxaelAGIihJ7AQ+H
        1w6D/COAMLbzKUz0djP6cE5WnAtWOZ5BKKtrHg5e7iKVcILdBWGgBxV8E8WPIfArONNdTv1Ns22
        MzgSg4VMt1oJLXqO0oGjlqMYbGwbURg+y7Oe+1FxvWAbKSnPkNN8JdxmqaMt8Nfw=
X-Google-Smtp-Source: ABdhPJw/sAMzHNOStnqAqBLiNJXiXWwD6SWzPr1z2ULQE5yYfUsfK9WzpWK7uqyqAK0igoSxkxFw8vLHuDMC2w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:984:: with SMTP id
 u4mr10373045pfg.67.1643414697418; Fri, 28 Jan 2022 16:04:57 -0800 (PST)
Date:   Fri, 28 Jan 2022 16:04:40 -0800
In-Reply-To: <20220124204442.39353-1-chooglen@google.com>
Message-Id: <20220129000446.99261-1-chooglen@google.com>
Mime-Version: 1.0
References: <20220124204442.39353-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v8 0/6] implement branch --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks again for the feedback, Jonathan!

This version is rebased onto the updated js/branch-track-inherit, from
44f14a9d24 (config: require lowercase for branch.*.autosetupmerge, 2021-12-=
20)
to 6327f0efed (branch,checkout: fix --track documentation, 2022-01-20). As
such, the range-diff for patch 5 shows some additional changes in the usage
string lines.

Junio spotted some issues in the context that are worth fixing, but out of =
scope
for this series (https://lore.kernel.org/git/xmqqfsp8zuyg.fsf@gitster.g). I=
 plan
to send fixes for them after this series is merged. Patch 6 arguably fits i=
n
better with that fixup series than this one, but I'll leave the decision to
keep/drop it to Junio.

=3D Description

This series implements "git branch --recurse-submodules", which is part of =
the
submodule branching RFC (see "See also"). "git branch" (and some other feat=
ures
in that RFC) are incompatible with existing "--recurse-submodules" commands=
;
patch 5 describes this incompatibility in more detail and how we plan to
introduce this new functionality in a manner.

This series is based off js/branch-track-inherit.

Patches 1-4 are preparation for the implementation of "branch
--recurse-submodules" in patch 5. Patch 6 cleans up a memory leak that I
encountered on js/branch-track-inherit as I was moving code around; it isn'=
t
neeeded by "branch --recurse-submodules".

See the previous cover letter
(https://lore.kernel.org/git/20211220233459.45739-1-chooglen@google.com)
for discussions of future work.

=3D See also

Submodule branching RFC:
https://lore.kernel.org/git/kl6lv912uvjv.fsf@chooglen-macbookpro.roam.corp.=
google.com/

Original Submodule UX RFC/Discussion:
https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/

Contributor Summit submodules Notes:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110211148060.56@tvgsbejvaqbj=
f.bet/

Submodule UX overhaul updates:
https://lore.kernel.org/git/?q=3DSubmodule+UX+overhaul+update

=3D Changes

Changes since v7:
* Reword patch 5's commit message
* In comments and Documentation/git-branch.txt, clarify how branch
  --recurse-submodules behaves and rename a parameter to better reflect
  this behavior
* In t3207, always assert on error messages when using test_must_fail
* In t3207, assert on config values using test_cmp_config. This avoids
  the silent failures discouraged by t/README:671.
* In patch 6, be more explicit about freeing the stack-allocated
  variable.

Changes since v6:
* Move memory leak fix into its own patch (patch 6)
* Eliminate unnecessary rewrapping and small style fixes
* In branch --recurse-submodules tests, setup test repo anew instead of
  deleting the unused branches
* Numerous commit message wording changes

Changes since v5:
* Rebase onto v7 of js/branch-track-inherit
  (https://lore.kernel.org/git/cover.1639717481.git.steadmon@google.com)

Changes since v4:
* Rebase correctly onto 'gitster/seen^{/^Merge branch .js/branch-track-inhe=
rit.}'
  (see base-commit) as suggested in [1] (thanks Junio!)
* These patches were also verified on top of 'next'.

Changes since v3:
* Split up the old patch 1. Patch 1 had a big diff because it used to
  move lines, remove dead code and introduce repo_* functions (thanks
  Jonathan!)
** repo_* functions have been dropped; they added noise and are not
   necessary for correctness.
* Use a new, harder-to-misuse function in --set-upstream-to,
  dwim_and_setup_tracking(). Now, setup_tracking() never does DWIM and
  dwim_and_setup_tracking() always does DWIM.
* Move create_branch() dry_run to its own patch.
* Fix an oversight where submodules in subtrees were ignored. This was
  because submodules_of_tree() and tree_entry() didn't recurse into
  subtrees. Test this accordingly (thanks Jonathan!).
* cmd_branch() possible actions are more consistently ordered.
* Documentation fixes (thanks Philippe!).
* Additional comments and explanation.
* Drop patch 5 (optional cleanup).
* Rebase onto js/branch-track-inherit v6.

Changes since v2:
* Rebase onto js/branch-track-inherit. This series should continue to be
  the case going forward.
* Patch 1 has a smaller diff because the introduction of
  validate_branch_start() no longer changes the function order thanks to a
  forward declaration. This artificial forward declaration is removed in a
  patch 2 (which can just be squashed into patch 1).
* Optional cleanup: fix questionable exit codes in patch 5.

Changes since v1:
* Move the functionality of "git branch --dry-run" into "git submodule-help=
er create-branch --dry-run"
* Add more fields to the submodules_of_tree() struct to reduce the
  number of allocations made by the caller. Move this functionality
  to patch 3 (formerly patch 4) and drop patch 1.
* Make submodules_of_tree() ignore inactive submodules
* Structure the output of the submodules a bit better by adding prefixes
  to the child process' output (instead of inconsistently indenting the
  output).
** I wasn't able to find a good way to interleave stdout/stderr
   correctly, so a less-than-desirable workaround was to route the child
   process output to stdout/stderr depending on the exit code.
** Eventually, I would like to structure the output of submodules in a
   report, as =C3=86var suggested. But at this stage, I think that it's
   better to spend time getting user feedback on the submodules
   branching UX and it'll be easier to standardize the output when we've
   implemented more of the UX :)

[1] https://lore.kernel.org/git/xmqqlf0lz6os.fsf@gitster.g=20

Glen Choo (6):
  branch: move --set-upstream-to behavior to dwim_and_setup_tracking()
  branch: make create_branch() always create a branch
  branch: add a dry_run parameter to create_branch()
  builtin/branch: consolidate action-picking logic in cmd_branch()
  branch: add --recurse-submodules option for branch creation
  branch.c: use 'goto cleanup' in setup_tracking() to fix memory leaks

 Documentation/config/advice.txt    |   3 +
 Documentation/config/submodule.txt |  37 ++--
 Documentation/git-branch.txt       |  19 +-
 advice.c                           |   1 +
 advice.h                           |   1 +
 branch.c                           | 277 ++++++++++++++++++++++-----
 branch.h                           |  60 +++++-
 builtin/branch.c                   |  70 +++++--
 builtin/checkout.c                 |   3 +-
 builtin/submodule--helper.c        |  38 ++++
 submodule-config.c                 |  60 ++++++
 submodule-config.h                 |  34 ++++
 submodule.c                        |  11 +-
 submodule.h                        |   3 +
 t/t3200-branch.sh                  |  17 ++
 t/t3207-branch-submodule.sh        | 292 +++++++++++++++++++++++++++++
 16 files changed, 845 insertions(+), 81 deletions(-)
 create mode 100755 t/t3207-branch-submodule.sh

Range-diff against v7:
1:  206175cfb3 =3D 1:  547055d55e branch: move --set-upstream-to behavior t=
o dwim_and_setup_tracking()
2:  2e02885eb3 =3D 2:  016f62681d branch: make create_branch() always creat=
e a branch
3:  cd43a9aaaa =3D 3:  a459a030f6 branch: add a dry_run parameter to create=
_branch()
4:  8e5f750162 =3D 4:  4903f8eb4b builtin/branch: consolidate action-pickin=
g logic in cmd_branch()
5:  c59de1fd9c ! 5:  b95b77b7c1 branch: add --recurse-submodules option for=
 branch creation
    @@ Commit message
         topic" will create the `topic` branch in the superproject and its
         submodules.
    =20
    -    Although this commit does not introduce breaking changes, it is
    -    incompatible with existing --recurse-submodules commands because "=
git
    +    Although this commit does not introduce breaking changes, it does =
not
    +    work well with existing --recurse-submodules commands because "git
         branch --recurse-submodules" writes to the submodule ref store, bu=
t most
         commands only consider the superproject gitlink and ignore the sub=
module
         ref store. For example, "git checkout --recurse-submodules" will c=
heck
    @@ Documentation/git-branch.txt: SYNOPSIS
      	[--points-at <object>] [--format=3D<format>]
      	[(-r | --remotes) | (-a | --all)]
      	[--list] [<pattern>...]
    --'git branch' [--track [direct|inherit] | --no-track] [-f] <branchname=
> [<start-point>]
    -+'git branch' [--track [direct|inherit] | --no-track] [-f]
    +-'git branch' [--track[=3D(direct|inherit)] | --no-track] [-f] <branch=
name> [<start-point>]
    ++'git branch' [--track[=3D(direct|inherit)] | --no-track] [-f]
     +	[--recurse-submodules] <branchname> [<start-point>]
      'git branch' (--set-upstream-to=3D<upstream> | -u <upstream>) [<branc=
hname>]
      'git branch' --unset-upstream [<branchname>]
    @@ Documentation/git-branch.txt: how the `branch.<name>.remote` and `br=
anch.<name>.
     +	THIS OPTION IS EXPERIMENTAL! Causes the current command to
     +	recurse into submodules if `submodule.propagateBranches` is
     +	enabled. See `submodule.propagateBranches` in
    -+	linkgit:git-config[1].
    -+	+
    -+	Currently, only branch creation is supported.
    ++	linkgit:git-config[1]. Currently, only branch creation is
    ++	supported.
    +++
    ++When used in branch creation, a new branch <branchname> will be creat=
ed
    ++in the superproject and all of the submodules in the superproject's
    ++<start-point>. In submodules, the branch will point to the submodule
    ++commit in the superproject's <start-point> but the branch's tracking
    ++information will be set up based on the submodule's branches and remo=
tes
    ++e.g. `git branch --recurse-submodules topic origin/main` will create =
the
    ++submodule branch "topic" that points to the submodule commit in the
    ++superproject's "origin/main", but tracks the submodule's "origin/main=
".
     +
      --set-upstream::
      	As this option had confusing syntax, it is no longer supported.
    @@ branch.c: void dwim_and_setup_tracking(struct repository *r, const c=
har *new_ref
     +static int submodule_create_branch(struct repository *r,
     +				   const struct submodule *submodule,
     +				   const char *name, const char *start_oid,
    -+				   const char *start_name, int force,
    ++				   const char *tracking_name, int force,
     +				   int reflog, int quiet,
     +				   enum branch_track track, int dry_run)
     +{
    @@ branch.c: void dwim_and_setup_tracking(struct repository *r, const c=
har *new_ref
     +	/*
     +	 * submodule_create_branch() is indirectly invoked by "git
     +	 * branch", but we cannot invoke "git branch" in the child
    -+	 * process because it does not let us set start_name and
    -+	 * start_oid separately (see create_branches_recursively()).
    ++	 * process. "git branch" accepts a branch name and start point,
    ++	 * where the start point is assumed to provide both the OID
    ++	 * (start_oid) and the branch to use for tracking
    ++	 * (tracking_name). But when recursing through submodules,
    ++	 * start_oid and tracking name need to be specified separately
    ++	 * (see create_branches_recursively()).
     +	 */
     +	strvec_pushl(&child.args, "submodule--helper", "create-branch", NULL=
);
     +	if (dry_run)
    @@ branch.c: void dwim_and_setup_tracking(struct repository *r, const c=
har *new_ref
     +	if (track =3D=3D BRANCH_TRACK_ALWAYS || track =3D=3D BRANCH_TRACK_EX=
PLICIT)
     +		strvec_push(&child.args, "--track");
     +
    -+	strvec_pushl(&child.args, name, start_oid, start_name, NULL);
    ++	strvec_pushl(&child.args, name, start_oid, tracking_name, NULL);
     +
     +	if ((ret =3D start_command(&child)))
     +		return ret;
    @@ branch.c: void dwim_and_setup_tracking(struct repository *r, const c=
har *new_ref
     +}
     +
     +void create_branches_recursively(struct repository *r, const char *na=
me,
    -+				 const char *start_name,
    ++				 const char *start_commitish,
     +				 const char *tracking_name, int force,
     +				 int reflog, int quiet, enum branch_track track,
     +				 int dry_run)
    @@ branch.c: void dwim_and_setup_tracking(struct repository *r, const c=
har *new_ref
     +	struct object_id super_oid;
     +	struct submodule_entry_list submodule_entry_list;
     +
    -+	/* Perform dwim on start_name to get super_oid and branch_point. */
    -+	dwim_branch_start(r, start_name, BRANCH_TRACK_NEVER, &branch_point,
    -+			  &super_oid);
    ++	/* Perform dwim on start_commitish to get super_oid and branch_point=
. */
    ++	dwim_branch_start(r, start_commitish, BRANCH_TRACK_NEVER,
    ++			  &branch_point, &super_oid);
     +
     +	/*
     +	 * If we were not given an explicit name to track, then assume we ar=
e at
    @@ branch.c: void dwim_and_setup_tracking(struct repository *r, const c=
har *new_ref
     +		if (submodule_entry_list.entries[i].repo =3D=3D NULL) {
     +			if (advice_enabled(ADVICE_SUBMODULES_NOT_UPDATED))
     +				advise(_("You may try updating the submodules using 'git checkout=
 %s && git submodule update --init'"),
    -+				       start_name);
    ++				       start_commitish);
     +			die(_("submodule '%s': unable to find submodule"),
     +			    submodule_entry_list.entries[i].submodule->name);
     +		}
    @@ branch.c: void dwim_and_setup_tracking(struct repository *r, const c=
har *new_ref
     +			    name);
     +	}
     +
    -+	create_branch(the_repository, name, start_name, force, 0, reflog, qu=
iet,
    ++	create_branch(the_repository, name, start_commitish, force, 0, reflo=
g, quiet,
     +		      BRANCH_TRACK_NEVER, dry_run);
     +	if (dry_run)
     +		return;
    @@ branch.h: void create_branch(struct repository *r,
      		   int dry_run);
     =20
     +/*
    -+ * Creates a new branch in repository and its submodules (and its
    -+ * submodules, recursively). Besides these exceptions, the parameters
    -+ * function identically to create_branch():
    ++ * Creates a new branch in a repository and its submodules (and its
    ++ * submodules, recursively). The parameters are mostly analogous to
    ++ * those of create_branch() except for start_name, which is represent=
ed
    ++ * by two different parameters:
     + *
    -+ * - start_name is the name of the ref, in repository r, that the new
    -+ *   branch should start from. In submodules, branches will start fro=
m
    -+ *   the respective gitlink commit ids in start_name's tree.
    ++ * - start_commitish is the commit-ish, in repository r, that determi=
nes
    ++ *   which commits the branches will point to. The superproject branc=
h
    ++ *   will point to the commit of start_commitish and the submodule
    ++ *   branches will point to the gitlink commit oids in start_commitis=
h's
    ++ *   tree.
     + *
    -+ * - tracking_name is the name used of the ref that will be used to s=
et
    -+ *   up tracking, e.g. origin/main. This is propagated to submodules =
so
    -+ *   that tracking information will appear as if the branch branched =
off
    -+ *   tracking_name instead of start_name (which is a plain commit id =
for
    -+ *   submodules). If omitted, start_name is used for tracking (just l=
ike
    -+ *   create_branch()).
    ++ * - tracking_name is the name of the ref, in repository r, that will=
 be
    ++ *   used to set up tracking information. This value is propagated to
    ++ *   all submodules, which will evaluate the ref using their own ref
    ++ *   stores. If NULL, this defaults to start_commitish.
     + *
    ++ * When this function is called on the superproject, start_commitish
    ++ * can be any user-provided ref and tracking_name can be NULL (simila=
r
    ++ * to create_branches()). But when recursing through submodules,
    ++ * start_commitish is the plain gitlink commit oid. Since the oid can=
not
    ++ * be used for tracking information, tracking_name is propagated and
    ++ * used for tracking instead.
     + */
     +void create_branches_recursively(struct repository *r, const char *na=
me,
    -+				 const char *start_name,
    ++				 const char *start_commitish,
     +				 const char *tracking_name, int force,
     +				 int reflog, int quiet, enum branch_track track,
     +				 int dry_run);
    @@ t/t3207-branch-submodule.sh (new)
     +	cp -r test_dirs/* .
     +}
     +
    ++# Tests that the expected branch does not exist
    ++test_no_branch () {
    ++	DIR=3D$1 &&
    ++	BRANCH_NAME=3D$2 &&
    ++	test_must_fail git -C "$DIR" rev-parse "$BRANCH_NAME" 2>err &&
    ++	grep "ambiguous argument .$BRANCH_NAME." err
    ++}
    ++
     +test_expect_success 'setup superproject and submodule' '
     +	mkdir test_dirs &&
     +	(
    @@ t/t3207-branch-submodule.sh (new)
     +	(
     +		cd super &&
     +		git branch --recurse-submodules branch-a &&
    -+		test_must_fail git branch --recurse-submodules -D branch-a &&
    ++		echo "fatal: --recurse-submodules can only be used to create branch=
es" >expected &&
    ++		test_must_fail git branch --recurse-submodules -D branch-a 2>actual=
 &&
    ++		test_cmp expected actual &&
     +		# Assert that the branches were not deleted
     +		git rev-parse branch-a &&
     +		git -C sub rev-parse branch-a
    @@ t/t3207-branch-submodule.sh (new)
     +		cd super &&
     +		git branch --recurse-submodules branch-a &&
     +		git -c submodule.recurse=3Dtrue branch -D branch-a &&
    -+		test_must_fail git rev-parse branch-a &&
    ++		test_no_branch . branch-a &&
     +		git -C sub rev-parse branch-a
     +	)
     +'
    @@ t/t3207-branch-submodule.sh (new)
     +		cd super &&
     +		git -C sub branch branch-a &&
     +		test_must_fail git branch --recurse-submodules branch-a 2>actual &&
    -+		test_must_fail git rev-parse branch-a &&
    ++		test_no_branch . branch-a &&
     +		grep "submodule .sub.: fatal: A branch named .branch-a. already exi=
sts" actual
     +	)
     +'
    @@ t/t3207-branch-submodule.sh (new)
     +		cd super &&
     +		git branch --recurse-submodules branch-a &&
     +		git rev-parse branch-a &&
    -+		test_must_fail git -C sub branch-a
    ++		test_no_branch sub branch-a
     +	)
     +'
     +
    @@ t/t3207-branch-submodule.sh (new)
     +		cd super &&
     +		git -c branch.autoSetupMerge=3Dalways branch --recurse-submodules b=
ranch-a main &&
     +		git -C sub rev-parse main &&
    -+		test "$(git -C sub config branch.branch-a.remote)" =3D . &&
    -+		test "$(git -C sub config branch.branch-a.merge)" =3D refs/heads/ma=
in
    ++		test_cmp_config -C sub . branch.branch-a.remote &&
    ++		test_cmp_config -C sub refs/heads/main branch.branch-a.merge
     +	)
     +'
     +
    @@ t/t3207-branch-submodule.sh (new)
     +		cd super &&
     +		git branch --track --recurse-submodules branch-a main &&
     +		git -C sub rev-parse main &&
    -+		test "$(git -C sub config branch.branch-a.remote)" =3D . &&
    -+		test "$(git -C sub config branch.branch-a.merge)" =3D refs/heads/ma=
in
    ++		test_cmp_config -C sub . branch.branch-a.remote &&
    ++		test_cmp_config -C sub refs/heads/main branch.branch-a.merge
     +	)
     +'
     +
    @@ t/t3207-branch-submodule.sh (new)
     +		cd super &&
     +		git branch --recurse-submodules branch-a main &&
     +		git -C sub rev-parse main &&
    -+		test "$(git -C sub config branch.branch-a.remote)" =3D "" &&
    -+		test "$(git -C sub config branch.branch-a.merge)" =3D ""
    ++		test_cmp_config -C sub "" --default "" branch.branch-a.remote &&
    ++		test_cmp_config -C sub "" --default "" branch.branch-a.merge
     +	)
     +'
     +
    @@ t/t3207-branch-submodule.sh (new)
     +		# This should fail because super-clone does not have sub2 .git/modu=
les
     +		test_must_fail git branch --recurse-submodules branch-b origin/bran=
ch-b 2>actual &&
     +		grep "fatal: submodule .sub2.: unable to find submodule" actual &&
    -+		test_must_fail git rev-parse branch-b &&
    -+		test_must_fail git -C sub rev-parse branch-b &&
    ++		test_no_branch . branch-b &&
    ++		test_no_branch sub branch-b &&
     +		# User can fix themselves by initializing the submodule
     +		git checkout origin/branch-b &&
     +		git submodule update --init --recursive &&
    @@ t/t3207-branch-submodule.sh (new)
     +	(
     +		cd super-clone &&
     +		git branch --recurse-submodules branch-a origin/branch-a &&
    -+		test "$(git config branch.branch-a.remote)" =3D origin &&
    -+		test "$(git config branch.branch-a.merge)" =3D refs/heads/branch-a =
&&
    ++		test_cmp_config origin branch.branch-a.remote &&
    ++		test_cmp_config refs/heads/branch-a branch.branch-a.merge &&
     +		# "origin/branch-a" does not exist for "sub", but it matches the re=
fspec
     +		# so tracking should be set up
    -+		test "$(git -C sub config branch.branch-a.remote)" =3D origin &&
    -+		test "$(git -C sub config branch.branch-a.merge)" =3D refs/heads/br=
anch-a &&
    -+		test "$(git -C sub/sub-sub config branch.branch-a.remote)" =3D orig=
in &&
    -+		test "$(git -C sub/sub-sub config branch.branch-a.merge)" =3D refs/=
heads/branch-a
    ++		test_cmp_config -C sub origin branch.branch-a.remote &&
    ++		test_cmp_config -C sub refs/heads/branch-a branch.branch-a.merge &&
    ++		test_cmp_config -C sub/sub-sub origin branch.branch-a.remote &&
    ++		test_cmp_config -C sub/sub-sub refs/heads/branch-a branch.branch-a.=
merge
     +	)
     +'
     +
    @@ t/t3207-branch-submodule.sh (new)
     +		cd super-clone &&
     +		git remote rename origin ex-origin &&
     +		git branch --recurse-submodules branch-a ex-origin/branch-a &&
    -+		test "$(git config branch.branch-a.remote)" =3D ex-origin &&
    -+		test "$(git config branch.branch-a.merge)" =3D refs/heads/branch-a =
&&
    -+		test "$(git -C sub config branch.branch-a.remote)" =3D "" &&
    -+		test "$(git -C sub config branch.branch-a.merge)" =3D ""
    ++		test_cmp_config ex-origin branch.branch-a.remote &&
    ++		test_cmp_config refs/heads/branch-a branch.branch-a.merge &&
    ++		test_cmp_config -C sub "" --default "" branch.branch-a.remote &&
    ++		test_cmp_config -C sub "" --default "" branch.branch-a.merge
     +	)
     +'
     +
6:  a4634f0493 ! 6:  bdf7be52be branch.c: use 'goto cleanup' in setup_track=
ing() to fix memory leaks
    @@ branch.c: static void setup_tracking(const char *new_ref, const char=
 *orig_ref,
      				tracking.remote, tracking.srcs) < 0)
      		exit(-1);
     =20
    +-	string_list_clear(tracking.srcs, 0);
     +cleanup:
    - 	string_list_clear(tracking.srcs, 0);
    ++	string_list_clear(&tracking_srcs, 0);
      }
     =20
    + int read_branch_desc(struct strbuf *buf, const char *branch_name)

base-commit: 6327f0efed36c64d98a140110171362b7cb75a52
--=20
2.33.GIT

