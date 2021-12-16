Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C52EC433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 00:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhLPAc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 19:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhLPAc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 19:32:27 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7A9C061574
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 16:32:26 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id d4-20020a17090a2a4400b001b0f20e1ebeso3178491pjg.9
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 16:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=srpkhHOVMrbSTZ28U4cAeBsmtVKguhLWqyzyrFC/5TA=;
        b=S3byi9LSW18ujAnLDtQhQLKFG34j2ONTN47V+IRX1A+Ao40Cb5dU4sxgbXzhw+20Hd
         3dOaig7efcUw5jS6Sbo5Q8qD61waZtKD8upJESUF2X6ahxdXhAVZzYwVq4wUJnwHGPw+
         QWu23a4QiqT3QqF541qW0bmLTUDbBemQtW3yhFJV7avcFxtahMI9Btf7jDTLZa8T38Xv
         m4ZFddpqOv3HGeZP9JE3nXEfqhAzlysYjO/m6+50p+8Ucg7Hya063kjFHthggDjP2s+/
         RJqnZn7wednf9o8kcQKQRdu5iIr/5s21O/nxIi+dhoQKj2t7jfkXh1Qo6DGsOLDS/hYc
         KlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=srpkhHOVMrbSTZ28U4cAeBsmtVKguhLWqyzyrFC/5TA=;
        b=ffQz9Nw34U5d+3eegfy2zVwVXNIzgEHK6f4ruh4dwibxdgJjMvS2Ht5JTaXrIxG7WE
         7VseCFQEEswJp/nGjrDC63JZ6Yv/uglmTZHqSBwrWHsrwNxghcPWlokWPuKeSJMdJAhD
         DrsUZTawmPhCYKaB2r24J/XOI188c3Etc+k2Wv22AY8YE+PgPw3htPHY9wWMU4/fzVla
         OVTNTDEXVluaR1EV79jPyrgLnn0aPr1ZTzhK6e9gNc+ZCCQRKhoG8w6nKvT2gco95NxR
         2puvBGLNzZHnh2z1O1qPEIBYa6U7KD3C+tO8LrM8dRHQZ2L6TNiXDtkPQ8Ml8wwt8GXM
         bNrg==
X-Gm-Message-State: AOAM532TpUEuCBhxbcTaIh5B+3G5BtYc3WfbMc/k1AwF8I1FvEml35WB
        Tl391aO9RfKiqLQk0jIvdnHEF5E2MMFAyiOdndJuKGX+Tbl8kE+T/+8mKgwI/eWMzV5ifmKeH2x
        6pr/nlyRacORJNIS/0hwLZquib6tsHR+rk/ZdDfGtTZMqwlGArRDrd2XrTWtnzX0=
X-Google-Smtp-Source: ABdhPJzeUK36aihrOChpjwUusUqpZpQyVnHBDWE8XcyjAswVV5bUlF3FPMJImgiIBMISGbs0L3orOL2tpdcf2g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:124e:b0:143:a388:865e with SMTP
 id u14-20020a170903124e00b00143a388865emr13631636plh.42.1639614746298; Wed,
 15 Dec 2021 16:32:26 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:32:08 -0800
In-Reply-To: <20211209184928.71413-1-chooglen@google.com>
Message-Id: <20211216003213.99135-1-chooglen@google.com>
Mime-Version: 1.0
References: <20211209184928.71413-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 0/5] implement branch --recurse-submodules
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

This series implements branch --recurse-submodules as laid out in the
Submodule branching RFC (linked above). If there are concerns about the
UX/behavior, I would appreciate feedback on the RFC thread as well :)

This series is based off js/branch-track-inherit.

Future work:
* `git branch -d --recurse-submodules` so that users can clean up
  extraneous branches.
* `git [checkout | switch] --recurse-submodules` +
  submodule.propagateBranches so that users can actually checkout the
  branches.
* After [1], it seems clear that --recurse-submodules parsing could
  really benefit from some standardization. It's not obvious which
  RECURSE_SUBMODULE_* enums are applicable to which commands, and there
  is no way to distinguish between an explicit --recurse-submodules from
  argv vs submodule.recurse from the config.

  I chose not to use them in this series because their usage is already
  inconsistent (grep.c doesn't use them either), and it would be _more_
  confusing to use the enum (handling RECURSE_SUBMODULES_DEFAULT =3D 1 is
  trickier than boolean 0 and 1).

  At this point, I think it would be too noisy to introduce the enum,
  but this would be a nice cleanup to do later.
* As documented in branch.c, we create branches using a child process
  only because install_branch_config() does not support submodules.
  It should be possible to remove the child process once we make the
  appropriate changes to config.c. I attempted this in [2] but chose to
  punt it because it was too time-consuming at the time.

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

[1] https://lore.kernel.org/git/kl6lbl1p9zjf.fsf@chooglen-macbookpro.roam.c=
orp.google.com/
[2] https://lore.kernel.org/git/kl6lv90ytd4v.fsf@chooglen-macbookpro.roam.c=
orp.google.com/

Glen Choo (5):
  branch: move --set-upstream-to behavior to dwim_and_setup_tracking()
  branch: make create_branch() always create a branch
  branch: add a dry_run parameter to create_branch()
  builtin/branch: clean up action-picking logic in cmd_branch()
  branch: add --recurse-submodules option for branch creation

 Documentation/config/advice.txt    |   3 +
 Documentation/config/submodule.txt |  24 ++-
 Documentation/git-branch.txt       |  11 +-
 advice.c                           |   1 +
 advice.h                           |   1 +
 branch.c                           | 257 ++++++++++++++++++++-----
 branch.h                           |  57 +++++-
 builtin/branch.c                   |  70 +++++--
 builtin/checkout.c                 |   3 +-
 builtin/submodule--helper.c        |  38 ++++
 submodule-config.c                 |  60 ++++++
 submodule-config.h                 |  34 ++++
 submodule.c                        |  11 +-
 submodule.h                        |   3 +
 t/t3200-branch.sh                  |  17 ++
 t/t3207-branch-submodule.sh        | 291 +++++++++++++++++++++++++++++
 16 files changed, 805 insertions(+), 76 deletions(-)
 create mode 100755 t/t3207-branch-submodule.sh

Range-diff against v3:
1:  8241c0b51a < -:  ---------- branch: move --set-upstream-to behavior to =
setup_tracking()
2:  b74bcbaade < -:  ---------- branch: remove forward declaration of valid=
ate_branch_start()
-:  ---------- > 1:  dfdbbaaca5 branch: move --set-upstream-to behavior to =
dwim_and_setup_tracking()
-:  ---------- > 2:  e22a177cb7 branch: make create_branch() always create =
a branch
-:  ---------- > 3:  8a895aa401 branch: add a dry_run parameter to create_b=
ranch()
3:  235173efc9 ! 4:  971c53ec85 builtin/branch: clean up action-picking log=
ic in cmd_branch()
    @@ Commit message
         Such an option does not exist yet, but one will be introduced in a
         subsequent commit.
    =20
    -    Incidentally, fix an incorrect usage string that combined the 'lis=
t'
    -    usage of git branch (-l) with the 'create' usage; this string has =
been
    -    incorrect since its inception, a8dfd5eac4 (Make builtin-branch.c u=
se
    -    parse_options., 2007-10-07).
    -
         Signed-off-by: Glen Choo <chooglen@google.com>
    =20
      ## builtin/branch.c ##
    -@@
    -=20
    - static const char * const builtin_branch_usage[] =3D {
    - 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
    --	N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]")=
,
    -+	N_("git branch [<options>] [-l] [<pattern>...]"),
    - 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
    - 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
    - 	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
     @@ builtin/branch.c: static int edit_branch_description(const char *br=
anch_name)
     =20
      int cmd_branch(int argc, const char **argv, const char *prefix)
    @@ builtin/branch.c: static int edit_branch_description(const char *bra=
nch_name)
     -	int reflog =3D 0, edit_description =3D 0;
     -	int quiet =3D 0, unset_upstream =3D 0;
     +	/* possible actions */
    -+	int delete =3D 0, rename =3D 0, copy =3D 0, force =3D 0, list =3D 0,
    ++	int delete =3D 0, rename =3D 0, copy =3D 0, list =3D 0,
     +	    unset_upstream =3D 0, show_current =3D 0, edit_description =3D 0=
;
    + 	const char *new_upstream =3D NULL;
     +	int noncreate_actions =3D 0;
     +	/* possible options */
    -+	int reflog =3D 0, quiet =3D 0, icase =3D 0;
    - 	const char *new_upstream =3D NULL;
    ++	int reflog =3D 0, quiet =3D 0, icase =3D 0, force =3D 0;
      	enum branch_track track;
      	struct ref_filter filter;
     -	int icase =3D 0;
4:  3dabb8e2fa ! 5:  cd88f3ad92 branch: add --recurse-submodules option for=
 branch creation
    @@ Commit message
         * add the "submoduleNotUpdated" advice to advise users to update t=
he
           submodules in their trees
    =20
    -    Other changes
    -
    -    * add a "dry_run" parameter to create_branch() in order to support
    -      `git submodule--helper create-branch --dry-run`
    +    Incidentally, fix an incorrect usage string that combined the 'lis=
t'
    +    usage of git branch (-l) with the 'create' usage; this string has =
been
    +    incorrect since its inception, a8dfd5eac4 (Make builtin-branch.c u=
se
    +    parse_options., 2007-10-07).
    =20
         Signed-off-by: Glen Choo <chooglen@google.com>
    =20
    @@ Documentation/config/advice.txt: advice.*::
      		configured to "die" causes a fatal error.
     +	submodulesNotUpdated::
     +		Advice shown when a user runs a submodule command that fails
    -+		because `git submodule update` was not run.
    ++		because `git submodule update --init` was not run.
      	addIgnoredFile::
      		Advice shown if a user attempts to add an ignored file to
      		the index.
    =20
      ## Documentation/config/submodule.txt ##
    +@@ Documentation/config/submodule.txt: submodule.active::
    +=20
    + submodule.recurse::
    + 	A boolean indicating if commands should enable the `--recurse-submod=
ules`
    +-	option by default.
    +-	Applies to all commands that support this option
    +-	(`checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`, `reset`,
    +-	`restore` and `switch`) except `clone` and `ls-files`.
    +-	Defaults to false.
    ++	option by default. Defaults to false.
    ++	+
    + 	When set to true, it can be deactivated via the
    + 	`--no-recurse-submodules` option. Note that some Git commands
    + 	lacking this option may call some of the above commands affected by
     @@ Documentation/config/submodule.txt: submodule.recurse::
    + 	`git fetch` but does not have a `--no-recurse-submodules` option.
      	For these commands a workaround is to temporarily change the
      	configuration value by using `git -c submodule.recurse=3D0`.
    -=20
    ++	+
    ++	The following list shows the commands that accept
    ++	`--recurse-submodules` and whether they are supported by this
    ++	setting.
    ++	* `checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`,
    ++	`reset`, `restore` and `switch` are always supported.
    ++	* `clone` and `ls-files` are not supported.
    ++	* `branch` is supported only if `submodule.propagateBranches` is
    ++	enabled
    ++
     +submodule.propagateBranches::
     +	[EXPERIMENTAL] A boolean that enables branching support when
     +	using `--recurse-submodules` or `submodule.recurse=3Dtrue`.
    @@ Documentation/config/submodule.txt: submodule.recurse::
     +	`--recurse-submodules` and certain commands that already accept
     +	`--recurse-submodules` will now consider branches.
     +	Defaults to false.
    -+
    +=20
      submodule.fetchJobs::
      	Specifies how many submodules are fetched/cloned at the same time.
    - 	A positive integer allows up to that number of submodules fetched
    +
    + ## Documentation/git-branch.txt ##
    +@@ Documentation/git-branch.txt: SYNOPSIS
    + 	[--points-at <object>] [--format=3D<format>]
    + 	[(-r | --remotes) | (-a | --all)]
    + 	[--list] [<pattern>...]
    +-'git branch' [--track [direct|inherit] | --no-track] [-f] <branchname=
> [<start-point>]
    ++'git branch' [--track [direct|inherit] | --no-track] [-f]
    ++	[--recurse-submodules] <branchname> [<start-point>]
    + 'git branch' (--set-upstream-to=3D<upstream> | -u <upstream>) [<branc=
hname>]
    + 'git branch' --unset-upstream [<branchname>]
    + 'git branch' (-m | -M) [<oldbranch>] <newbranch>
    +@@ Documentation/git-branch.txt: how the `branch.<name>.remote` and `b=
ranch.<name>.merge` options are used.
    + 	Do not set up "upstream" configuration, even if the
    + 	branch.autoSetupMerge configuration variable is set.
    +=20
    ++--recurse-submodules::
    ++	THIS OPTION IS EXPERIMENTAL! Causes the current command to
    ++	recurse into submodules if `submodule.propagateBranches` is
    ++	enabled. See `submodule.propagateBranches` in
    ++	linkgit:git-config[1].
    ++	+
    ++	Currently, only branch creation is supported.
    ++
    + --set-upstream::
    + 	As this option had confusing syntax, it is no longer supported.
    + 	Please use `--track` or `--set-upstream-to` instead.
    =20
      ## advice.c ##
     @@ advice.c: static struct {
    @@ branch.c
     =20
      struct tracking {
      	struct refspec_item spec;
    -@@ branch.c: void setup_tracking(const char *new_ref, const char *orig=
_ref,
    -=20
    - void create_branch(struct repository *r, const char *name,
    - 		   const char *start_name, int force, int clobber_head_ok,
    --		   int reflog, int quiet, enum branch_track track)
    -+		   int reflog, int quiet, enum branch_track track, int dry_run)
    - {
    - 	struct object_id oid;
    - 	char *real_ref;
    -@@ branch.c: void create_branch(struct repository *r, const char *name=
,
    - 	}
    -=20
    - 	validate_branch_start(r, start_name, track, &oid, &real_ref);
    -+	if (dry_run)
    -+		goto cleanup;
    -=20
    - 	if (reflog)
    - 		log_all_ref_updates =3D LOG_REFS_NORMAL;
    -@@ branch.c: void create_branch(struct repository *r, const char *name=
,
    - 	if (real_ref && track)
    - 		setup_tracking(ref.buf + 11, real_ref, track, quiet, 0);
    -=20
    -+cleanup:
    - 	strbuf_release(&ref);
    - 	free(real_ref);
    +@@ branch.c: void dwim_and_setup_tracking(struct repository *r, const =
char *new_ref,
    + 	setup_tracking(new_ref, real_orig_ref, track, quiet);
      }
     =20
    ++/**
    ++ * Creates a branch in a submodule by calling
    ++ * create_branches_recursively() in a child process. The child proces=
s
    ++ * is necessary because install_branch_config() (and its variants) do
    ++ * not support writing configs to submodules.
    ++ */
     +static int submodule_create_branch(struct repository *r,
     +				   const struct submodule *submodule,
     +				   const char *name, const char *start_oid,
    @@ branch.c: void create_branch(struct repository *r, const char *name,
     +	struct submodule_entry_list submodule_entry_list;
     +
     +	/* Perform dwim on start_name to get super_oid and branch_point. */
    -+	validate_branch_start(r, start_name, BRANCH_TRACK_NEVER, &super_oid,
    -+			      &branch_point);
    ++	dwim_branch_start(r, start_name, BRANCH_TRACK_NEVER, &branch_point,
    ++			  &super_oid);
     +
     +	/*
     +	 * If we were not given an explicit name to track, then assume we ar=
e at
    @@ branch.c: void create_branch(struct repository *r, const char *name,
     +	 * tedious to determine whether or not tracking was set up in the
     +	 * superproject.
     +	 */
    -+	setup_tracking(name, tracking_name, track, quiet, 0);
    ++	setup_tracking(name, tracking_name, track, quiet);
     +
     +	for (i =3D 0; i < submodule_entry_list.entry_nr; i++) {
     +		if (submodule_create_branch(
    @@ branch.c: void create_branch(struct repository *r, const char *name,
      	unlink(git_path_merge_head(r));
    =20
      ## branch.h ##
    -@@ branch.h: void setup_tracking(const char *new_ref, const char *orig=
_ref,
    -  *   - track causes the new branch to be configured to merge the remo=
te branch
    -  *     that start_name is a tracking branch for (if any).
    -  *
    -+ *   - dry_run causes the branch to be validated but not created.
    -+ *
    -  */
    --void create_branch(struct repository *r,
    --		   const char *name, const char *start_name,
    --		   int force, int clobber_head_ok,
    --		   int reflog, int quiet, enum branch_track track);
    -+void create_branch(struct repository *r, const char *name,
    -+		   const char *start_name, int force, int clobber_head_ok,
    -+		   int reflog, int quiet, enum branch_track track, int dry_run);
    +@@ branch.h: void create_branch(struct repository *r, const char *name=
,
    + 		   const char *start_name, int force, int clobber_head_ok,
    + 		   int reflog, int quiet, enum branch_track track, int dry_run);
     =20
     +/*
     + * Creates a new branch in repository and its submodules (and its
    @@ branch.h: void setup_tracking(const char *new_ref, const char *orig_=
ref,
       * Return 1 if the named branch already exists; return 0 otherwise.
    =20
      ## builtin/branch.c ##
    +@@
    +=20
    + static const char * const builtin_branch_usage[] =3D {
    + 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
    +-	N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]")=
,
    ++	N_("git branch [<options>] [-f] [--recurse-submodules] <branch-name>=
 [<start-point>]"),
    ++	N_("git branch [<options>] [-l] [<pattern>...]"),
    + 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
    + 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
    + 	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
     @@ builtin/branch.c: static const char * const builtin_branch_usage[] =
=3D {
     =20
      static const char *head;
    @@ builtin/branch.c: static int git_branch_config(const char *var, cons=
t char *valu
      }
     =20
     @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const=
 char *prefix)
    - 	    unset_upstream =3D 0, show_current =3D 0, edit_description =3D 0=
;
    + 	const char *new_upstream =3D NULL;
      	int noncreate_actions =3D 0;
      	/* possible options */
    --	int reflog =3D 0, quiet =3D 0, icase =3D 0;
    -+	int reflog =3D 0, quiet =3D 0, icase =3D 0, recurse_submodules_expli=
cit =3D 0;
    - 	const char *new_upstream =3D NULL;
    +-	int reflog =3D 0, quiet =3D 0, icase =3D 0, force =3D 0;
    ++	int reflog =3D 0, quiet =3D 0, icase =3D 0, force =3D 0,
    ++	    recurse_submodules_explicit =3D 0;
      	enum branch_track track;
      	struct ref_filter filter;
    + 	static struct ref_sorting *sorting;
     @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const=
 char *prefix)
      		OPT_CALLBACK(0, "points-at", &filter.points_at, N_("object"),
      			N_("print only branches of the object"), parse_opt_object_name),
    @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const =
char *prefix
     =20
     -		create_branch(the_repository,
     -			      argv[0], (argc =3D=3D 2) ? argv[1] : head,
    --			      force, 0, reflog, quiet, track);
    +-			      force, 0, reflog, quiet, track, 0);
     -
     +		if (recurse_submodules) {
     +			create_branches_recursively(the_repository, branch_name,
    @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const =
char *prefix
      		usage_with_options(builtin_branch_usage, options);
     =20
    =20
    - ## builtin/checkout.c ##
    -@@ builtin/checkout.c: static void update_refs_for_switch(const struct=
 checkout_opts *opts,
    - 				      opts->new_branch_force ? 1 : 0,
    - 				      opts->new_branch_log,
    - 				      opts->quiet,
    --				      opts->track);
    -+				      opts->track,
    -+				      0);
    - 		new_branch_info->name =3D opts->new_branch;
    - 		setup_branch_path(new_branch_info);
    - 	}
    -
      ## builtin/submodule--helper.c ##
     @@
      #include "diff.h"
    @@ submodule-config.c: const struct submodule *submodule_from_path(stru=
ct repositor
      	return config_from(r->submodule_cache, treeish_name, path, lookup_pa=
th);
      }
     =20
    -+void submodules_of_tree(struct repository *r,
    -+			const struct object_id *treeish_name,
    -+			struct submodule_entry_list *out)
    ++/**
    ++ * Used internally by submodules_of_tree(). Recurses into 'treeish_na=
me'
    ++ * and appends submodule entries to 'out'. The submodule_cache expect=
s
    ++ * a root-level treeish_name and paths, so keep track of these values
    ++ * with 'root_tree' and 'prefix'.
    ++ */
    ++static void traverse_tree_submodules(struct repository *r,
    ++				     const struct object_id *root_tree,
    ++				     char *prefix,
    ++				     const struct object_id *treeish_name,
    ++				     struct submodule_entry_list *out)
     +{
     +	struct tree_desc tree;
     +	struct submodule_tree_entry *st_entry;
     +	struct name_entry *name_entry;
    ++	char *tree_path =3D NULL;
     +
     +	name_entry =3D xmalloc(sizeof(*name_entry));
     +
    ++	fill_tree_descriptor(r, &tree, treeish_name);
    ++	while (tree_entry(&tree, name_entry)) {
    ++		if (prefix)
    ++			tree_path =3D
    ++				mkpathdup("%s/%s", prefix, name_entry->path);
    ++		else
    ++			tree_path =3D xstrdup(name_entry->path);
    ++
    ++		if (S_ISGITLINK(name_entry->mode) &&
    ++		    is_tree_submodule_active(r, root_tree, tree_path)) {
    ++			st_entry =3D xmalloc(sizeof(*st_entry));
    ++			st_entry->name_entry =3D name_entry;
    ++			st_entry->submodule =3D
    ++				submodule_from_path(r, root_tree, tree_path);
    ++			st_entry->repo =3D xmalloc(sizeof(*st_entry->repo));
    ++			if (repo_submodule_init(st_entry->repo, r, tree_path,
    ++						root_tree))
    ++				FREE_AND_NULL(st_entry->repo);
    ++
    ++			ALLOC_GROW(out->entries, out->entry_nr + 1,
    ++				   out->entry_alloc);
    ++			out->entries[out->entry_nr++] =3D *st_entry;
    ++		} else if (S_ISDIR(name_entry->mode))
    ++			traverse_tree_submodules(r, root_tree, tree_path,
    ++						 &name_entry->oid, out);
    ++		free(tree_path);
    ++	}
    ++}
    ++
    ++void submodules_of_tree(struct repository *r,
    ++			const struct object_id *treeish_name,
    ++			struct submodule_entry_list *out)
    ++{
     +	CALLOC_ARRAY(out->entries, 0);
     +	out->entry_nr =3D 0;
     +	out->entry_alloc =3D 0;
     +
    -+	fill_tree_descriptor(r, &tree, treeish_name);
    -+	while (tree_entry(&tree, name_entry)) {
    -+		if (!S_ISGITLINK(name_entry->mode) || !is_tree_submodule_active(r, =
treeish_name, name_entry->path)) {
    -+			continue;
    -+		}
    -+
    -+		st_entry =3D xmalloc(sizeof(*st_entry));
    -+		st_entry->name_entry =3D name_entry;
    -+		st_entry->submodule =3D
    -+			submodule_from_path(r, treeish_name, name_entry->path);
    -+		st_entry->repo =3D xmalloc(sizeof(*st_entry->repo));
    -+		if (repo_submodule_init(st_entry->repo, r, name_entry->path,
    -+					treeish_name))
    -+			FREE_AND_NULL(st_entry->repo);
    -+
    -+		ALLOC_GROW(out->entries, out->entry_nr + 1, out->entry_alloc);
    -+		out->entries[out->entry_nr++] =3D *st_entry;
    -+	}
    ++	traverse_tree_submodules(r, treeish_name, NULL, treeish_name, out);
     +}
     +
      void submodule_free(struct repository *r)
    @@ submodule-config.h: int check_submodule_name(const char *name);
     +};
     +
     +/**
    -+ * Given a treeish, return all submodules in the tree. This only read=
s
    -+ * one level of the tree, so it will not return nested submodules;
    -+ * callers that require nested submodules are expected to handle the
    -+ * recursion themselves.
    ++ * Given a treeish, return all submodules in the tree and its subtree=
s,
    ++ * but excluding nested submodules. Callers that require nested
    ++ * submodules are expected to recurse into the submodules themselves.
     + */
     +void submodules_of_tree(struct repository *r,
     +			const struct object_id *treeish_name,
    @@ t/t3207-branch-submodule.sh (new)
     +	git init sub-sub-upstream &&
     +	test_commit -C sub-sub-upstream foo &&
     +	git init sub-upstream &&
    ++	# Submodule in a submodule
     +	git -C sub-upstream submodule add "$TRASH_DIRECTORY/sub-sub-upstream=
" sub-sub &&
     +	git -C sub-upstream commit -m "add submodule" &&
    ++	# Regular submodule
     +	git -C super submodule add "$TRASH_DIRECTORY/sub-upstream" sub &&
    ++	# Submodule in a subdirectory
    ++	git -C super submodule add "$TRASH_DIRECTORY/sub-sub-upstream" secon=
d/sub &&
     +	git -C super commit -m "add submodule" &&
     +	git -C super config submodule.propagateBranches true &&
     +	git -C super/sub submodule update --init
    @@ t/t3207-branch-submodule.sh (new)
     +		git branch --recurse-submodules branch-a &&
     +		git rev-parse branch-a &&
     +		git -C sub rev-parse branch-a &&
    -+		git -C sub/sub-sub rev-parse branch-a
    ++		git -C sub/sub-sub rev-parse branch-a &&
    ++		git -C second/sub rev-parse branch-a
     +	)
     +'
     +
    @@ t/t3207-branch-submodule.sh (new)
     +	)
     +'
     +
    -+test_expect_success 'should create branch when submodule is not in HE=
AD .gitmodules' '
    ++test_expect_success 'should create branch when submodule is not in HE=
AD:.gitmodules' '
     +	test_when_finished "cleanup_branches super branch-a branch-b branch-=
c" &&
     +	(
     +		cd super &&
    @@ t/t3207-branch-submodule.sh (new)
     +		git branch --recurse-submodules branch-c branch-b &&
     +		git rev-parse branch-c &&
     +		git -C sub rev-parse branch-c &&
    ++		git -C second/sub rev-parse branch-c &&
     +		git checkout --recurse-submodules branch-c &&
    -+		git -C sub2 rev-parse branch-c
    ++		git -C sub2 rev-parse branch-c &&
    ++		git -C sub2/sub-sub rev-parse branch-c
     +	)
     +'
     +
5:  70fb03f882 < -:  ---------- branch.c: replace questionable exit() codes
--=20
2.33.GIT

