Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5257C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 21:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356148AbhLFV70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 16:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356122AbhLFV7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 16:59:25 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E2AC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 13:55:56 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id d3-20020a17090a6a4300b001a70e45f34cso783653pjm.0
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 13:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=w9WxvAaEJRbbx+xN1RSbDC51h8MQAs0WlM9ocka8k1s=;
        b=UQYpuQdRDsPF48XuQjU9JYb+USx7jUg6epWhiuEo6MwJl25lrht5vBPg3DwCCGTA5c
         vtE/OhHxw8e8Va7eVk0XDM5Oq465/1I0o1+I9smipvlyoBdoacszK7fFOF2oqZa433dc
         5ste5baTkTdvw1tY21qDTlr6ad3WF5UB6+XRSjTV4r6HUacuRBVQGkPP+b0a5yflz9GV
         z7j+Zj1vkv9vejuFLbjygDxOn6KBjfRKDIQrddaTYFN27mVQQBTa2+jAs7XdwZt7EknY
         Q3sJryIQSLynIKqWjbpVgNpDo2egWCTGaeAd39Gdgwo4/wfBfMl/dNzEfU5ODbzEsta5
         IVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=w9WxvAaEJRbbx+xN1RSbDC51h8MQAs0WlM9ocka8k1s=;
        b=J7WLARo24toTg1+lmyk5yN9lvhmSjjmYcaMHd59AalpvapM/d5XL0iPsRcSDF7zpJw
         9Eu2i4hgkcybmRnZKK3kWSLEzf086kjPV4OxbDq05CpRiKRximrF38c8H3YPpRwAhwFi
         bSYbrUjZnLL5RuUaxQueG3UdRjhaKYOi+DPTbEYNY12Yp+GK//A/cjItGRn0/vqbj2TB
         MHuh4pdGQZNVK6QCHrxwjyn2qUzLzW06PVLTMvIreyW+9nh3s89lGMQvoxzYBcGP1wfu
         o01fhxF2Dw+Dzi62+pL/+AK2iqVZnQ4m1xlf6tBnAZyXr1Sg11VgxFvFRP7BmhIJcAiE
         53Sw==
X-Gm-Message-State: AOAM533DPfmPQ/FUKfpL1AWtzpw8re+hW82zhdyBoE5Uu71HpqiBqM2K
        Zzg2j4syMwGckpaFyBswNlinSvKjQeABIhkAGkH84l+AWXv9teORynZowROsA1GO9E6I3AjXtMZ
        jlyJiF7tQ0xqlua8k2/ZTpdwaVv5EtR31x6FT7fIq6oqYOilAbu15TyqA4fa0c4U=
X-Google-Smtp-Source: ABdhPJzEJm/+R6r+EZAfcWGsMhXAs5V/u+UsurMSAnApI4hLZmMQCRTh5NA33HYYO7tUqbiYbZkoNZFVAcfirA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1b0a:: with SMTP id
 nu10mr1505625pjb.35.1638827755524; Mon, 06 Dec 2021 13:55:55 -0800 (PST)
Date:   Mon,  6 Dec 2021 13:55:25 -0800
In-Reply-To: <20211122223252.19922-1-chooglen@google.com>
Message-Id: <20211206215528.97050-1-chooglen@google.com>
Mime-Version: 1.0
References: <20211122223252.19922-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v2 0/3] implement branch --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>
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

Thanks for the feedback, everyone. I really really appreciate it.

The biggest difference in V2 is that I took Jonathan's advice to remove
"git branch --dry-run" in favor of adding "--dry-run" to "git
submodule--helper create-branch" instead [1]. The benefit of having "git
branch --dry-run" is pretty small, and we'd have to explain to users why
"--dry-run" doesn't work in more situations [2].

Unfortunately patch 3 (formerly patch 4) is now bigger than I would
prefer. This is due to the combined effect of removing "--dry-run" and
squashing the former patch 1. I'd appreciate any feedback on how I can
structure things differently :)

Changes since v1:
* Move the functionality of "git branch --dry-run" into "git
  submodule-helper create-branch --dry-run"
* Add more fields to the submodules_of_tree() struct to reduce the
  number of allocations made by the caller [3]. Move this functionality
  to patch 3 (formerly patch 4) and drop patch 1.
* Make submodules_of_tree() ignore inactive submodules [4]
* Structure the output of the submodules a bit better by adding prefixes
  to the child process' output (instead of inconsistently indenting the
  output).
** I wasn't able to find a good way to interleave stdout/stderr
   correctly, so a less-than-desirable workaround was to route the child
   process output to stdout/stderr depending on the exit code.
** Eventually, I would like to structure the output of submodules in a
   report, as =C3=86var suggested [5]. But at this stage, I think that it's
   better to spend time getting user feedback on the submodules
   branching UX and it'll be easier to standardize the output when we've
   implemented more of the UX :)

[1] https://lore.kernel.org/git/20211129210140.937875-1-jonathantanmy@googl=
e.com
[2] https://lore.kernel.org/git/211123.86zgpvup6m.gmgdl@evledraar.gmail.com
[3] https://lore.kernel.org/git/211123.86r1b7uoil.gmgdl@evledraar.gmail.com
[4] https://lore.kernel.org/git/3ad3941c-de18-41bf-2e44-4238ae868d79@gmail.=
com
[5] https://lore.kernel.org/git/211123.86v90juovj.gmgdl@evledraar.gmail.com

Glen Choo (3):
  branch: move --set-upstream-to behavior to setup_tracking()
  builtin/branch: clean up action-picking logic in cmd_branch()
  branch: add --recurse-submodules option for branch creation

 Documentation/config/advice.txt    |   3 +
 Documentation/config/submodule.txt |   8 +
 advice.c                           |   1 +
 advice.h                           |   1 +
 branch.c                           | 322 +++++++++++++++++++++--------
 branch.h                           |  44 +++-
 builtin/branch.c                   |  66 ++++--
 builtin/checkout.c                 |   3 +-
 builtin/submodule--helper.c        |  38 ++++
 submodule-config.c                 |  35 ++++
 submodule-config.h                 |  35 ++++
 submodule.c                        |  11 +-
 submodule.h                        |   3 +
 t/t3200-branch.sh                  |  17 ++
 t/t3207-branch-submodule.sh        | 284 +++++++++++++++++++++++++
 15 files changed, 758 insertions(+), 113 deletions(-)
 create mode 100755 t/t3207-branch-submodule.sh

Range-diff against v1:
1:  1551dd683f < -:  ---------- submodule-config: add submodules_of_tree() =
helper
2:  a4984f6eef ! 1:  cc212dcd39 branch: refactor out branch validation from=
 create_branch()
    @@ Metadata
     Author: Glen Choo <chooglen@google.com>
    =20
      ## Commit message ##
    -    branch: refactor out branch validation from create_branch()
    +    branch: move --set-upstream-to behavior to setup_tracking()
    =20
    -    In a subsequent commit, we would like to be able to validate wheth=
er or
    -    not a branch name is valid before we create it (--dry-run). This i=
s
    -    useful for `git branch --recurse-submodules topic` because it allo=
ws Git
    -    to determine if the branch 'topic' can be created in all submodule=
s
    -    without creating the branch 'topic'.
    +    This refactor is motivated by a desire to add a "dry_run" paramete=
r to
    +    create_branch() that will validate whether or not a branch can be
    +    created without actually creating it - this behavior be used in a
    +    subsequent commit that adds `git branch --recurse-submodules topic=
`.
    =20
    -    A good starting point would be to refactor out the start point
    -    validation and dwim logic in create_branch() in a
    -    validate_branch_start() helper function. Once we do so, it becomes
    -    clear that create_branch() is more complex than it needs to be -
    -    create_branch() is also used to set tracking information when perf=
orming
    -    `git branch --set-upstream-to`. This made more sense when
    -    (the now unsupported) --set-upstream was first introduced in
    -    4fc5006676 (Add branch --set-upstream, 2010-01-18), because
    -    it would sometimes create a branch and sometimes update tracking
    -    information without creating a branch.
    +    Adding "dry_run" is not obvious because create_branch() is also us=
ed to
    +    set tracking information without creating a branch, i.e. when usin=
g
    +    --set-upstream-to. This appears to be a leftover from 4fc5006676 (=
Add
    +    branch --set-upstream, 2010-01-18), when --set-upstream would some=
times
    +    create a branch and sometimes update tracking information without
    +    creating a branch. However, we no longer support --set-upstream, s=
o it
    +    makes more sense to set tracking information with another function=
, like
    +    setup_tracking(), and use create_branch() only to create branches.=
 When
    +    this is done, it will be trivial to add "dry_run".
    =20
    -    Refactor out the branch validation and dwim logic from create_bran=
ch()
    -    into validate_branch_start(), make it so that create_branch() alwa=
ys
    -    tries to create a branch, and replace the now-incorrect create_bra=
nch()
    -    call with setup_tracking(). Since there were none, add tests for
    -    creating a branch with `--force`.
    +    Do this refactor by moving the branch validation and dwim logic fr=
om
    +    create_branch() into a new function, validate_branch_start(), and =
call
    +    it from setup_tracking(). Now that setup_tracking() can perform dw=
im and
    +    tracking setup without creating a branch, use it in `git branch
    +    --set-upstream-to` and remove unnecessary behavior from create_bra=
nch().
    +
    +    Since there were none, add tests for creating a branch with `--for=
ce`.
    =20
         Signed-off-by: Glen Choo <chooglen@google.com>
    =20
    @@ branch.c: N_("\n"
     -		   const char *name, const char *start_name,
     -		   int force, int clobber_head_ok, int reflog,
     -		   int quiet, enum branch_track track)
    ++/**
    ++ * Validates whether a ref is a valid starting point for a branch, wh=
ere:
    ++ *
    ++ *   - r is the repository to validate the branch for
    ++ *
    ++ *   - start_name is the ref that we would like to test. This is
    ++ *     expanded with DWIM and assigned to real_ref.
    ++ *
    ++ *   - track is the tracking mode of the new branch. If tracking is
    ++ *     explicitly requested, start_name must be a branch (because
    ++ *     otherwise start_name cannot be tracked)
    ++ *
    ++ *   - oid is an out parameter containing the object_id of start_name
    ++ *
    ++ *   - real_ref is an out parameter containing the full, 'real' form =
of
    ++ *     start_name e.g. refs/heads/main instead of main
    ++ *
    ++ */
     +static void validate_branch_start(struct repository *r, const char *s=
tart_name,
     +				  enum branch_track track,
    -+				  struct object_id *oid, char **full_ref)
    ++				  struct object_id *oid, char **real_ref)
      {
      	struct commit *commit;
     -	struct object_id oid;
    @@ branch.c: void create_branch(struct repository *r,
      	}
     =20
     -	switch (dwim_ref(start_name, strlen(start_name), &oid, &real_ref, 0)=
) {
    -+	switch (repo_dwim_ref(r, start_name, strlen(start_name), oid, full_r=
ef,
    ++	switch (repo_dwim_ref(r, start_name, strlen(start_name), oid, real_r=
ef,
     +			      0)) {
      	case 0:
      		/* Not branching from any existing branch */
    @@ branch.c: void create_branch(struct repository *r,
      		/* Unique completion -- good, only if it is a real branch */
     -		if (!starts_with(real_ref, "refs/heads/") &&
     -		    validate_remote_tracking_branch(real_ref)) {
    -+		if (!starts_with(*full_ref, "refs/heads/") &&
    -+		    validate_remote_tracking_branch(*full_ref)) {
    ++		if (!starts_with(*real_ref, "refs/heads/") &&
    ++		    validate_remote_tracking_branch(*real_ref)) {
      			if (explicit_tracking)
      				die(_(upstream_not_branch), start_name);
      			else
     -				FREE_AND_NULL(real_ref);
    -+				FREE_AND_NULL(*full_ref);
    ++				FREE_AND_NULL(*real_ref);
      		}
      		break;
      	default:
3:  cbcbc4f49e < -:  ---------- branch: add --dry-run option to branch
-:  ---------- > 2:  320749cc82 builtin/branch: clean up action-picking log=
ic in cmd_branch()
4:  416a114fa9 ! 3:  c0441c6691 branch: add --recurse-submodules option for=
 branch creation
    @@ Metadata
      ## Commit message ##
         branch: add --recurse-submodules option for branch creation
    =20
    -    Teach cmd_branch to accept the --recurse-submodules option when cr=
eating
    -    branches so that `git branch --recurse-submodules topic` will crea=
te the
    -    "topic" branch in the superproject and all submodules. Guard this =
(and
    -    future submodule branching) behavior behind a new configuration va=
lue
    -    'submodule.propagateBranches'.
    +    To improve the submodules UX, we would like to teach Git to handle
    +    branches in submodules. Start this process by teaching `git branch=
` the
    +    --recurse-submodules option so that `git branch --recurse-submodul=
es
    +    topic` will create the "topic" branch in the superproject and its
    +    submodules.
    +
    +    Although this commit does not introduce breaking changes, it is
    +    incompatible with existing --recurse-submodules semantics e.g. `gi=
t
    +    checkout` does not recursively checkout the expected branches crea=
ted by
    +    `git branch` yet. To ensure that the correct set of semantics is u=
sed,
    +    this commit introduces a new configuration value,
    +    `submodule.propagateBranches`, which enables submodule branching w=
hen
    +    true (defaults to false).
    +
    +    This commit includes changes that allow Git to work with submodule=
s
    +    that are in trees (and not just the index):
    +
    +    * add a submodules_of_tree() helper that gives the relevant
    +      information of an in-tree submodule (e.g. path and oid) and
    +      initializes the repository
    +    * add is_tree_submodule_active() by adding a treeish_name paramete=
r to
    +      is_submodule_active()
    +    * add the "submoduleNotUpdated" advice to advise users to update t=
he
    +      submodules in their trees
    +
    +    Other changes
    +
    +    * add a "dry_run" parameter to create_branch() in order to support
    +      `git submodule--helper create-branch --dry-run`
    =20
         Signed-off-by: Glen Choo <chooglen@google.com>
    =20
    @@ Documentation/config/submodule.txt: submodule.recurse::
      	configuration value by using `git -c submodule.recurse=3D0`.
     =20
     +submodule.propagateBranches::
    -+	[EXPERIMENTAL] A boolean that enables branching support with
    -+	submodules. This allows certain commands to accept
    -+	`--recurse-submodules` (`git branch --recurse-submodules` will
    -+	create branches recursively), and certain commands that already
    -+	accept `--recurse-submodules` will now consider branches (`git
    -+	switch --recurse-submodules` will switch to the correct branch
    -+	in all submodules).
    ++	[EXPERIMENTAL] A boolean that enables branching support when
    ++	using `--recurse-submodules` or `submodule.recurse=3Dtrue`.
    ++	Enabling this will allow certain commands to accept
    ++	`--recurse-submodules` and certain commands that already accept
    ++	`--recurse-submodules` will now consider branches.
    ++	Defaults to false.
     +
      submodule.fetchJobs::
      	Specifies how many submodules are fetched/cloned at the same time.
    @@ branch.c
     =20
      struct tracking {
      	struct refspec_item spec;
    +@@ branch.c: void setup_tracking(const char *new_ref, const char *orig=
_ref,
    +=20
    + void create_branch(struct repository *r, const char *name,
    + 		   const char *start_name, int force, int clobber_head_ok,
    +-		   int reflog, int quiet, enum branch_track track)
    ++		   int reflog, int quiet, enum branch_track track, int dry_run)
    + {
    + 	struct object_id oid;
    + 	char *real_ref;
     @@ branch.c: void create_branch(struct repository *r, const char *name=
,
    + 	}
    +=20
    + 	validate_branch_start(r, start_name, track, &oid, &real_ref);
    ++	if (dry_run)
    ++		goto cleanup;
    +=20
    + 	if (reflog)
    + 		log_all_ref_updates =3D LOG_REFS_NORMAL;
    +@@ branch.c: void create_branch(struct repository *r, const char *name=
,
    + 	if (real_ref && track)
    + 		setup_tracking(ref.buf + 11, real_ref, track, quiet, 0);
    +=20
    ++cleanup:
    + 	strbuf_release(&ref);
      	free(real_ref);
      }
     =20
    -+static int submodule_validate_branchname(struct repository *r, const =
char *name,
    -+					 const char *start_name, int force,
    -+					 int quiet, char **err_msg)
    -+{
    -+	int ret =3D 0;
    -+	struct child_process child =3D CHILD_PROCESS_INIT;
    -+	struct strbuf child_err =3D STRBUF_INIT;
    -+	child.git_cmd =3D 1;
    -+	child.err =3D -1;
    -+
    -+	prepare_other_repo_env(&child.env_array, r->gitdir);
    -+	strvec_pushl(&child.args, "branch", "--dry-run", NULL);
    -+	if (force)
    -+		strvec_push(&child.args, "--force");
    -+	if (quiet)
    -+		strvec_push(&child.args, "--quiet");
    -+	strvec_pushl(&child.args, name, start_name, NULL);
    -+
    -+	if ((ret =3D start_command(&child)))
    -+		return ret;
    -+	ret =3D finish_command(&child);
    -+	strbuf_read(&child_err, child.err, 0);
    -+	*err_msg =3D strbuf_detach(&child_err, NULL);
    -+	return ret;
    -+}
    -+
    -+static int submodule_create_branch(struct repository *r, const char *=
name,
    -+				   const char *start_oid,
    ++static int submodule_create_branch(struct repository *r,
    ++				   const struct submodule *submodule,
    ++				   const char *name, const char *start_oid,
     +				   const char *start_name, int force,
     +				   int reflog, int quiet,
    -+				   enum branch_track track, char **err_msg)
    ++				   enum branch_track track, int dry_run)
     +{
     +	int ret =3D 0;
     +	struct child_process child =3D CHILD_PROCESS_INIT;
     +	struct strbuf child_err =3D STRBUF_INIT;
    ++	struct strbuf out_buf =3D STRBUF_INIT;
    ++	char *out_prefix =3D xstrfmt("submodule '%s': ", submodule->name);
     +	child.git_cmd =3D 1;
     +	child.err =3D -1;
    ++	child.stdout_to_stderr =3D 1;
     +
     +	prepare_other_repo_env(&child.env_array, r->gitdir);
     +	strvec_pushl(&child.args, "submodule--helper", "create-branch", NULL=
);
    ++	if (dry_run)
    ++		strvec_push(&child.args, "--dry-run");
     +	if (force)
     +		strvec_push(&child.args, "--force");
     +	if (quiet)
    @@ branch.c: void create_branch(struct repository *r, const char *name,
     +		return ret;
     +	ret =3D finish_command(&child);
     +	strbuf_read(&child_err, child.err, 0);
    -+	*err_msg =3D strbuf_detach(&child_err, NULL);
    ++	strbuf_add_lines(&out_buf, out_prefix, child_err.buf, child_err.len)=
;
    ++
    ++	if (ret)
    ++		fprintf(stderr, "%s", out_buf.buf);
    ++	else
    ++		printf("%s", out_buf.buf);
    ++
    ++	strbuf_release(&child_err);
    ++	strbuf_release(&out_buf);
     +	return ret;
     +}
     +
    -+void create_submodule_branches(struct repository *r, const char *name=
,
    -+			       const char *start_name, int force, int reflog,
    -+			       int quiet, enum branch_track track)
    ++void create_branches_recursively(struct repository *r, const char *na=
me,
    ++				 const char *start_name,
    ++				 const char *tracking_name, int force,
    ++				 int reflog, int quiet, enum branch_track track,
    ++				 int dry_run)
     +{
     +	int i =3D 0;
     +	char *branch_point =3D NULL;
    -+	struct repository *subrepos;
    -+	struct submodule *submodules;
     +	struct object_id super_oid;
    -+	struct submodule_entry_list *submodule_entry_list;
    -+	char *err_msg =3D NULL;
    -+
    -+	validate_branch_start(r, start_name, track, &super_oid, &branch_poin=
t);
    -+
    -+	submodule_entry_list =3D submodules_of_tree(r, &super_oid);
    -+	CALLOC_ARRAY(subrepos, submodule_entry_list->entry_nr);
    -+	CALLOC_ARRAY(submodules, submodule_entry_list->entry_nr);
    -+
    -+	for (i =3D 0; i < submodule_entry_list->entry_nr; i++) {
    -+		submodules[i] =3D *submodule_from_path(
    -+			r, &super_oid,
    -+			submodule_entry_list->name_entries[i].path);
    -+
    -+		if (repo_submodule_init(
    -+			    &subrepos[i], r,
    -+			    submodule_entry_list->name_entries[i].path,
    -+			    &super_oid)) {
    -+			die(_("submodule %s: unable to find submodule"),
    -+			    submodules[i].name);
    ++	struct submodule_entry_list submodule_entry_list;
    ++
    ++	/* Perform dwim on start_name to get super_oid and branch_point. */
    ++	validate_branch_start(r, start_name, BRANCH_TRACK_NEVER, &super_oid,
    ++			      &branch_point);
    ++
    ++	/*
    ++	 * If we were not given an explicit name to track, then assume we ar=
e at
    ++	 * the top level and, just like the non-recursive case, the tracking
    ++	 * name is the branch point.
    ++	 */
    ++	if (!tracking_name)
    ++		tracking_name =3D branch_point;
    ++
    ++	submodules_of_tree(r, &super_oid, &submodule_entry_list);
    ++	/*
    ++	 * Before creating any branches, first check that the branch can
    ++	 * be created in every submodule.
    ++	 */
    ++	for (i =3D 0; i < submodule_entry_list.entry_nr; i++) {
    ++		if (submodule_entry_list.entries[i].repo =3D=3D NULL) {
     +			if (advice_enabled(ADVICE_SUBMODULES_NOT_UPDATED))
    -+				advise(_("You may try initializing the submodules using 'git chec=
kout %s && git submodule update'"),
    ++				advise(_("You may try updating the submodules using 'git checkout=
 %s && git submodule update --init'"),
     +				       start_name);
    ++			die(_("submodule '%s': unable to find submodule"),
    ++			    submodule_entry_list.entries[i].submodule->name);
     +		}
     +
    -+		if (submodule_validate_branchname(
    -+			    &subrepos[i], name,
    -+			    oid_to_hex(
    -+				    &submodule_entry_list->name_entries[i].oid),
    -+			    force, quiet, &err_msg))
    -+			die(_("submodule %s: could not create branch '%s'\n\t%s"),
    -+			    submodules[i].name, name, err_msg);
    ++		if (submodule_create_branch(
    ++			    submodule_entry_list.entries[i].repo,
    ++			    submodule_entry_list.entries[i].submodule, name,
    ++			    oid_to_hex(&submodule_entry_list.entries[i]
    ++						.name_entry->oid),
    ++			    tracking_name, force, reflog, quiet, track, 1))
    ++			die(_("submodule '%s': cannot create branch '%s'"),
    ++			    submodule_entry_list.entries[i].submodule->name,
    ++			    name);
     +	}
     +
     +	create_branch(the_repository, name, start_name, force, 0, reflog, qu=
iet,
    -+		      track);
    -+
    -+	for (i =3D 0; i < submodule_entry_list->entry_nr; i++) {
    -+		printf_ln(_("submodule %s: creating branch '%s'"),
    -+			  submodules[i].name, name);
    ++		      BRANCH_TRACK_NEVER, dry_run);
    ++	if (dry_run)
    ++		return;
    ++	/*
    ++	 * NEEDSWORK If tracking was set up in the superproject but not the
    ++	 * submodule, users might expect "git branch --recurse-submodules" t=
o
    ++	 * fail or give a warning, but this is not yet implemented because i=
t is
    ++	 * tedious to determine whether or not tracking was set up in the
    ++	 * superproject.
    ++	 */
    ++	setup_tracking(name, tracking_name, track, quiet, 0);
    ++
    ++	for (i =3D 0; i < submodule_entry_list.entry_nr; i++) {
     +		if (submodule_create_branch(
    -+			    &subrepos[i], name,
    -+			    oid_to_hex(
    -+				    &submodule_entry_list->name_entries[i].oid),
    -+			    branch_point, force, reflog, quiet, track,
    -+			    &err_msg))
    -+			die(_("submodule %s: could not create branch '%s'\n\t%s"),
    -+			    submodules[i].name, name, err_msg);
    -+
    -+		repo_clear(&subrepos[i]);
    ++			    submodule_entry_list.entries[i].repo,
    ++			    submodule_entry_list.entries[i].submodule, name,
    ++			    oid_to_hex(&submodule_entry_list.entries[i]
    ++						.name_entry->oid),
    ++			    tracking_name, force, reflog, quiet, track, 0))
    ++			die(_("submodule '%s': cannot create branch '%s'"),
    ++			    submodule_entry_list.entries[i].submodule->name,
    ++			    name);
    ++		repo_clear(submodule_entry_list.entries[i].repo);
     +	}
     +}
     +
    @@ branch.c: void create_branch(struct repository *r, const char *name,
      	unlink(git_path_merge_head(r));
    =20
      ## branch.h ##
    -@@ branch.h: void create_branch(struct repository *r,
    - 		   int force, int clobber_head_ok,
    - 		   int reflog, int quiet, enum branch_track track);
    +@@ branch.h: void setup_tracking(const char *new_ref, const char *orig=
_ref,
    +  *   - track causes the new branch to be configured to merge the remo=
te branch
    +  *     that start_name is a tracking branch for (if any).
    +  *
    ++ *   - dry_run causes the branch to be validated but not created.
    ++ *
    +  */
    +-void create_branch(struct repository *r,
    +-		   const char *name, const char *start_name,
    +-		   int force, int clobber_head_ok,
    +-		   int reflog, int quiet, enum branch_track track);
    ++void create_branch(struct repository *r, const char *name,
    ++		   const char *start_name, int force, int clobber_head_ok,
    ++		   int reflog, int quiet, enum branch_track track, int dry_run);
     =20
     +/*
    -+ * Creates a new branch in repository and its submodules.
    ++ * Creates a new branch in repository and its submodules (and its
    ++ * submodules, recursively). Besides these exceptions, the parameters
    ++ * function identically to create_branch():
    ++ *
    ++ * - start_name is the name of the ref, in repository r, that the new
    ++ *   branch should start from. In submodules, branches will start fro=
m
    ++ *   the respective gitlink commit ids in start_name's tree.
    ++ *
    ++ * - tracking_name is the name used of the ref that will be used to s=
et
    ++ *   up tracking, e.g. origin/main. This is propagated to submodules =
so
    ++ *   that tracking information will appear as if the branch branched =
off
    ++ *   tracking_name instead of start_name (which is a plain commit id =
for
    ++ *   submodules). If omitted, start_name is used for tracking (just l=
ike
    ++ *   create_branch()).
    ++ *
     + */
    -+void create_submodule_branches(struct repository *r, const char *name=
,
    -+			       const char *start_name, int force, int reflog,
    -+			       int quiet, enum branch_track track);
    ++void create_branches_recursively(struct repository *r, const char *na=
me,
    ++				 const char *start_name,
    ++				 const char *tracking_name, int force,
    ++				 int reflog, int quiet, enum branch_track track,
    ++				 int dry_run);
      /*
       * Check if 'name' can be a valid name for a branch; die otherwise.
       * Return 1 if the named branch already exists; return 0 otherwise.
    @@ builtin/branch.c: static int git_branch_config(const char *var, cons=
t char *valu
      }
     =20
     @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const=
 char *prefix)
    - 	int delete =3D 0, rename =3D 0, copy =3D 0, force =3D 0, list =3D 0,=
 create =3D 0,
      	    unset_upstream =3D 0, show_current =3D 0, edit_description =3D 0=
;
    + 	int noncreate_actions =3D 0;
      	/* possible options */
    --	int reflog =3D 0, quiet =3D 0, dry_run =3D 0, icase =3D 0;
    -+	int reflog =3D 0, quiet =3D 0, dry_run =3D 0, icase =3D 0,
    -+	    recurse_submodules_explicit =3D 0;
    +-	int reflog =3D 0, quiet =3D 0, icase =3D 0;
    ++	int reflog =3D 0, quiet =3D 0, icase =3D 0, recurse_submodules_expli=
cit =3D 0;
      	const char *new_upstream =3D NULL;
      	enum branch_track track;
      	struct ref_filter filter;
    @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const =
char *prefix
      		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are =
case insensitive")),
     +		OPT_BOOL(0, "recurse-submodules", &recurse_submodules_explicit, N_(=
"recurse through submodules")),
      		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format=
 to use for the output")),
    - 		OPT__DRY_RUN(&dry_run, N_("show whether the branch would be created=
")),
      		OPT_END(),
    + 	};
     @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const=
 char *prefix)
    - 	if (create < 0)
    + 	if (noncreate_actions > 1)
      		usage_with_options(builtin_branch_usage, options);
     =20
    -+	if (recurse_submodules_explicit && submodule_propagate_branches &&
    -+	    !create)
    -+		die(_("--recurse-submodules can only be used to create branches"));
    - 	if (dry_run && !create)
    - 		die(_("--dry-run can only be used when creating branches"));
    -=20
    ++	if (recurse_submodules_explicit) {
    ++		if (!submodule_propagate_branches)
    ++			die(_("branch with --recurse-submodules can only be used if submod=
ule.propagateBranches is enabled"));
    ++		if (noncreate_actions)
    ++			die(_("--recurse-submodules can only be used to create branches"))=
;
    ++	}
    ++
     +	recurse_submodules =3D
     +		(recurse_submodules || recurse_submodules_explicit) &&
     +		submodule_propagate_branches;
    @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const =
char *prefix
      		filter.abbrev =3D DEFAULT_ABBREV;
      	filter.ignore_case =3D icase;
     @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const=
 char *prefix)
    - 			FREE_AND_NULL(unused_full_ref);
    - 			return 0;
    - 		}
    + 		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REP=
LACE);
    + 		strbuf_release(&buf);
    + 	} else if (!noncreate_actions && argc > 0 && argc <=3D 2) {
    ++		const char *branch_name =3D argv[0];
    ++		const char *start_name =3D argc =3D=3D 2 ? argv[1] : head;
    ++
    + 		if (filter.kind !=3D FILTER_REFS_BRANCHES)
    + 			die(_("The -a, and -r, options to 'git branch' do not take a branc=
h name.\n"
    + 				  "Did you mean to use: -a|-r --list <pattern>?"));
    +@@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const=
 char *prefix)
    + 		if (track =3D=3D BRANCH_TRACK_OVERRIDE)
    + 			die(_("the '--set-upstream' option is no longer supported. Please =
use '--track' or '--set-upstream-to' instead."));
    +=20
    +-		create_branch(the_repository,
    +-			      argv[0], (argc =3D=3D 2) ? argv[1] : head,
    +-			      force, 0, reflog, quiet, track);
    +-
     +		if (recurse_submodules) {
    -+			create_submodule_branches(the_repository, branch_name,
    -+						  start_name, force, reflog,
    -+						  quiet, track);
    ++			create_branches_recursively(the_repository, branch_name,
    ++						    start_name, NULL, force,
    ++						    reflog, quiet, track, 0);
     +			return 0;
     +		}
    - 		create_branch(the_repository, branch_name, start_name, force, 0,
    - 			      reflog, quiet, track);
    ++		create_branch(the_repository, branch_name, start_name, force, 0,
    ++			      reflog, quiet, track, 0);
      	} else
    + 		usage_with_options(builtin_branch_usage, options);
    +=20
    +
    + ## builtin/checkout.c ##
    +@@ builtin/checkout.c: static void update_refs_for_switch(const struct=
 checkout_opts *opts,
    + 				      opts->new_branch_force ? 1 : 0,
    + 				      opts->new_branch_log,
    + 				      opts->quiet,
    +-				      opts->track);
    ++				      opts->track,
    ++				      0);
    + 		new_branch_info->name =3D opts->new_branch;
    + 		setup_branch_path(new_branch_info);
    + 	}
    =20
      ## builtin/submodule--helper.c ##
     @@
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, =
const char *
     +static int module_create_branch(int argc, const char **argv, const ch=
ar *prefix)
     +{
     +	enum branch_track track;
    -+	int quiet =3D 0, force =3D 0, reflog =3D 0;
    ++	int quiet =3D 0, force =3D 0, reflog =3D 0, dry_run =3D 0;
     +
     +	struct option options[] =3D {
     +		OPT__QUIET(&quiet, N_("print only error messages")),
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, =
const char *
     +		OPT_SET_INT('t', "track", &track,
     +			    N_("set up tracking mode (see git-pull(1))"),
     +			    BRANCH_TRACK_EXPLICIT),
    ++		OPT__DRY_RUN(&dry_run,
    ++			     N_("show whether the branch would be created")),
     +		OPT_END()
     +	};
     +	const char *const usage[] =3D {
    -+		N_("git submodule--helper create-branch [-f|--force] [--create-refl=
og] [-q|--quiet] [-t|--track] <name> <start_oid> <start_name>"),
    ++		N_("git submodule--helper create-branch [-f|--force] [--create-refl=
og] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start_oid> <start_name=
>"),
     +		NULL
     +	};
     +
    ++	git_config(git_default_config, NULL);
    ++	track =3D git_branch_track;
     +	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
     +
     +	if (argc !=3D 3)
     +		usage_with_options(usage, options);
     +
    -+	create_branch(the_repository, argv[0], argv[1], force, 0, reflog, qu=
iet,
    -+		      BRANCH_TRACK_NEVER);
    -+	setup_tracking(argv[0], argv[2], track, quiet, 0);
    ++	if (!quiet && !dry_run)
    ++		printf_ln(_("creating branch '%s'"), argv[0]);
     +
    ++	create_branches_recursively(the_repository, argv[0], argv[1], argv[2=
],
    ++				    force, reflog, quiet, track, dry_run);
     +	return 0;
     +}
      struct add_data {
    @@ builtin/submodule--helper.c: static struct cmd_struct commands[] =3D=
 {
     =20
      int cmd_submodule__helper(int argc, const char **argv, const char *pr=
efix)
    =20
    + ## submodule-config.c ##
    +@@
    + #include "strbuf.h"
    + #include "object-store.h"
    + #include "parse-options.h"
    ++#include "tree-walk.h"
    +=20
    + /*
    +  * submodule cache lookup structure
    +@@ submodule-config.c: const struct submodule *submodule_from_path(str=
uct repository *r,
    + 	return config_from(r->submodule_cache, treeish_name, path, lookup_pa=
th);
    + }
    +=20
    ++void submodules_of_tree(struct repository *r,
    ++			const struct object_id *treeish_name,
    ++			struct submodule_entry_list *out)
    ++{
    ++	struct tree_desc tree;
    ++	struct submodule_tree_entry *st_entry;
    ++	struct name_entry *name_entry;
    ++
    ++	name_entry =3D xmalloc(sizeof(*name_entry));
    ++
    ++	CALLOC_ARRAY(out->entries, 0);
    ++	out->entry_nr =3D 0;
    ++	out->entry_alloc =3D 0;
    ++
    ++	fill_tree_descriptor(r, &tree, treeish_name);
    ++	while (tree_entry(&tree, name_entry)) {
    ++		if (!S_ISGITLINK(name_entry->mode) || !is_tree_submodule_active(r, =
treeish_name, name_entry->path)) {
    ++			continue;
    ++		}
    ++
    ++		st_entry =3D xmalloc(sizeof(*st_entry));
    ++		st_entry->name_entry =3D name_entry;
    ++		st_entry->submodule =3D
    ++			submodule_from_path(r, treeish_name, name_entry->path);
    ++		st_entry->repo =3D xmalloc(sizeof(*st_entry->repo));
    ++		if (repo_submodule_init(st_entry->repo, r, name_entry->path,
    ++					treeish_name))
    ++			FREE_AND_NULL(st_entry->repo);
    ++
    ++		ALLOC_GROW(out->entries, out->entry_nr + 1, out->entry_alloc);
    ++		out->entries[out->entry_nr++] =3D *st_entry;
    ++	}
    ++}
    ++
    + void submodule_free(struct repository *r)
    + {
    + 	if (r->submodule_cache)
    +
    + ## submodule-config.h ##
    +@@
    + #include "hashmap.h"
    + #include "submodule.h"
    + #include "strbuf.h"
    ++#include "tree-walk.h"
    +=20
    + /**
    +  * The submodule config cache API allows to read submodule
    +@@ submodule-config.h: int check_submodule_name(const char *name);
    + void fetch_config_from_gitmodules(int *max_children, int *recurse_sub=
modules);
    + void update_clone_config_from_gitmodules(int *max_jobs);
    +=20
    ++/*
    ++ * Submodule entry that contains relevant information about a
    ++ * submodule in a tree.
    ++ */
    ++struct submodule_tree_entry {
    ++	/* The submodule's tree entry. */
    ++	struct name_entry *name_entry;
    ++	/*
    ++	 * A struct repository corresponding to the submodule. May be
    ++	 * NULL if the submodule has not been updated.
    ++	 */
    ++	struct repository *repo;
    ++	/*
    ++	 * A struct submodule containing the submodule config in the
    ++	 * tree's .gitmodules.
    ++	 */
    ++	const struct submodule *submodule;
    ++};
    ++
    ++struct submodule_entry_list {
    ++	struct submodule_tree_entry *entries;
    ++	int entry_nr;
    ++	int entry_alloc;
    ++};
    ++
    ++/**
    ++ * Given a treeish, return all submodules in the tree. This only read=
s
    ++ * one level of the tree, so it will not return nested submodules;
    ++ * callers that require nested submodules are expected to handle the
    ++ * recursion themselves.
    ++ */
    ++void submodules_of_tree(struct repository *r,
    ++			const struct object_id *treeish_name,
    ++			struct submodule_entry_list *ret);
    + #endif /* SUBMODULE_CONFIG_H */
    +
    + ## submodule.c ##
    +@@ submodule.c: int option_parse_recurse_submodules_worktree_updater(c=
onst struct option *opt,
    +  * ie, the config looks like: "[submodule] active\n".
    +  * Since that is an invalid pathspec, we should inform the user.
    +  */
    +-int is_submodule_active(struct repository *repo, const char *path)
    ++int is_tree_submodule_active(struct repository *repo,
    ++			     const struct object_id *treeish_name,
    ++			     const char *path)
    + {
    + 	int ret =3D 0;
    + 	char *key =3D NULL;
    +@@ submodule.c: int is_submodule_active(struct repository *repo, const=
 char *path)
    + 	const struct string_list *sl;
    + 	const struct submodule *module;
    +=20
    +-	module =3D submodule_from_path(repo, null_oid(), path);
    ++	module =3D submodule_from_path(repo, treeish_name, path);
    +=20
    + 	/* early return if there isn't a path->module mapping */
    + 	if (!module)
    +@@ submodule.c: int is_submodule_active(struct repository *repo, const=
 char *path)
    + 	return ret;
    + }
    +=20
    ++int is_submodule_active(struct repository *repo, const char *path)
    ++{
    ++	return is_tree_submodule_active(repo, null_oid(), path);
    ++}
    ++
    + int is_submodule_populated_gently(const char *path, int *return_error=
_code)
    + {
    + 	int ret =3D 0;
    +
    + ## submodule.h ##
    +@@ submodule.h: int git_default_submodule_config(const char *var, cons=
t char *value, void *cb);
    + struct option;
    + int option_parse_recurse_submodules_worktree_updater(const struct opt=
ion *opt,
    + 						     const char *arg, int unset);
    ++int is_tree_submodule_active(struct repository *repo,
    ++			     const struct object_id *treeish_name,
    ++			     const char *path);
    + int is_submodule_active(struct repository *repo, const char *path);
    + /*
    +  * Determine if a submodule has been populated at a given 'path' by c=
hecking if
    +
      ## t/t3207-branch-submodule.sh (new) ##
     @@
     +#!/bin/sh
    @@ t/t3207-branch-submodule.sh (new)
     +test_expect_success 'setup superproject and submodule' '
     +	git init super &&
     +	test_commit foo &&
    ++	git init sub-sub-upstream &&
    ++	test_commit -C sub-sub-upstream foo &&
     +	git init sub-upstream &&
    -+	test_commit -C sub-upstream foo &&
    -+	git -C super submodule add ../sub-upstream sub &&
    ++	git -C sub-upstream submodule add "$TRASH_DIRECTORY/sub-sub-upstream=
" sub-sub &&
    ++	git -C sub-upstream commit -m "add submodule" &&
    ++	git -C super submodule add "$TRASH_DIRECTORY/sub-upstream" sub &&
     +	git -C super commit -m "add submodule" &&
    -+	git -C super config submodule.propagateBranches true
    ++	git -C super config submodule.propagateBranches true &&
    ++	git -C super/sub submodule update --init
     +'
     +
    -+cleanup_branches() {
    ++CLEANUP_SCRIPT_PATH=3D"$TRASH_DIRECTORY/cleanup_branches.sh"
    ++
    ++cat >"$CLEANUP_SCRIPT_PATH" <<'EOF'
    ++	#!/bin/sh
    ++
     +	super_dir=3D"$1"
     +	shift
     +	(
    @@ t/t3207-branch-submodule.sh (new)
     +		git checkout main &&
     +		for branch_name in "$@"; do
     +			git branch -D "$branch_name"
    -+			git submodule foreach "(git checkout main && git branch -D $branch=
_name) || true"
    ++			git submodule foreach "$TRASH_DIRECTORY/cleanup_branches.sh . $bra=
nch_name || true"
     +		done
     +	)
    ++EOF
    ++chmod +x "$CLEANUP_SCRIPT_PATH"
    ++
    ++cleanup_branches() {
    ++	TRASH_DIRECTORY=3D"\"$TRASH_DIRECTORY\"" "$CLEANUP_SCRIPT_PATH" "$@"
     +} >/dev/null 2>/dev/null
     +
     +# Test the argument parsing
    @@ t/t3207-branch-submodule.sh (new)
     +	(
     +		cd super &&
     +		git branch --recurse-submodules branch-a &&
    -+		git rev-parse --abbrev-ref branch-a &&
    -+		git -C sub rev-parse --abbrev-ref branch-a
    ++		git rev-parse branch-a &&
    ++		git -C sub rev-parse branch-a &&
    ++		git -C sub/sub-sub rev-parse branch-a
     +	)
     +'
     +
    -+test_expect_success '--recurse-submodules should be ignored if submod=
ule.propagateBranches is false' '
    ++test_expect_success '--recurse-submodules should die if submodule.pro=
pagateBranches is false' '
     +	test_when_finished "cleanup_branches super branch-a" &&
     +	(
     +		cd super &&
    -+		git -c submodule.propagateBranches=3Dfalse branch --recurse-submodu=
les branch-a &&
    -+		git rev-parse branch-a &&
    -+		test_must_fail git -C sub rev-parse branch-a
    ++		echo "fatal: branch with --recurse-submodules can only be used if s=
ubmodule.propagateBranches is enabled" >expected &&
    ++		test_must_fail git -c submodule.propagateBranches=3Dfalse branch --=
recurse-submodules branch-a 2>actual &&
    ++		test_cmp expected actual
     +	)
     +'
     +
    @@ t/t3207-branch-submodule.sh (new)
     +		test_must_fail git branch --recurse-submodules branch-a 2>actual &&
     +		test_must_fail git rev-parse branch-a &&
     +
    -+		cat >expected <<EOF &&
    -+fatal: submodule sub: could not create branch ${SQ}branch-a${SQ}
    -+	fatal: A branch named ${SQ}branch-a${SQ} already exists.
    -+
    -+EOF
    ++		cat >expected <<-EOF &&
    ++		submodule ${SQ}sub${SQ}: fatal: A branch named ${SQ}branch-a${SQ} a=
lready exists.
    ++		fatal: submodule ${SQ}sub${SQ}: cannot create branch ${SQ}branch-a$=
{SQ}
    ++		EOF
     +		test_cmp expected actual
     +	)
     +'
    @@ t/t3207-branch-submodule.sh (new)
     +	)
     +'
     +
    -+test_expect_success 'should create branch when submodule is in .git/m=
odules but not .gitmodules' '
    ++test_expect_success 'should create branch when submodule is not in HE=
AD .gitmodules' '
     +	test_when_finished "cleanup_branches super branch-a branch-b branch-=
c" &&
     +	(
     +		cd super &&
     +		git branch branch-a &&
     +		git checkout -b branch-b &&
     +		git submodule add ../sub-upstream sub2 &&
    ++		git -C sub2 submodule update --init &&
     +		# branch-b now has a committed submodule not in branch-a
     +		git commit -m "add second submodule" &&
     +		git checkout branch-a &&
    @@ t/t3207-branch-submodule.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'should not create branches in inactive submodule=
s' '
    ++	test_when_finished "cleanup_branches super branch-a" &&
    ++	test_config -C super submodule.sub.active false &&
    ++	(
    ++		cd super &&
    ++		git branch --recurse-submodules branch-a &&
    ++		git rev-parse branch-a &&
    ++		test_must_fail git -C sub branch-a
    ++	)
    ++'
    ++
     +test_expect_success 'setup remote-tracking tests' '
     +	(
     +		cd super &&
    @@ t/t3207-branch-submodule.sh (new)
     +		# branch-b now has a committed submodule not in branch-a
     +		git commit -m "add second submodule"
     +	) &&
    -+	(
    -+		cd sub-upstream &&
    -+		git branch branch-a
    -+	) &&
     +	git clone --branch main --recurse-submodules super super-clone &&
     +	git -C super-clone config submodule.propagateBranches true
     +'
     +
     +test_expect_success 'should not create branch when submodule is not i=
n .git/modules' '
    -+	# The cleanup needs to delete sub2:branch-b in particular because ma=
in does not have sub2
    ++	# The cleanup needs to delete sub2 separately because main does not =
have sub2
     +	test_when_finished "git -C super-clone/sub2 branch -D branch-b && \
    ++		git -C super-clone/sub2/sub-sub branch -D branch-b && \
     +		cleanup_branches super-clone branch-a branch-b" &&
     +	(
     +		cd super-clone &&
    @@ t/t3207-branch-submodule.sh (new)
     +		# This should fail because super-clone does not have sub2.
     +		test_must_fail git branch --recurse-submodules branch-b origin/bran=
ch-b 2>actual &&
     +		cat >expected <<-EOF &&
    -+		fatal: submodule sub: unable to find submodule
    -+		You may reinitialize the submodules using ${SQ}git checkout origin/=
branch-b && git submodule update${SQ}
    ++		hint: You may try updating the submodules using ${SQ}git checkout o=
rigin/branch-b && git submodule update --init${SQ}
    ++		fatal: submodule ${SQ}sub2${SQ}: unable to find submodule
     +		EOF
    ++		test_cmp expected actual &&
     +		test_must_fail git rev-parse branch-b &&
     +		test_must_fail git -C sub rev-parse branch-b &&
     +		# User can fix themselves by initializing the submodule
     +		git checkout origin/branch-b &&
    -+		git submodule update &&
    ++		git submodule update --init --recursive &&
     +		git branch --recurse-submodules branch-b origin/branch-b
     +	)
     +'
    @@ t/t3207-branch-submodule.sh (new)
     +	(
     +		cd super-clone &&
     +		git branch --recurse-submodules branch-a origin/branch-a &&
    ++		test "$(git config branch.branch-a.remote)" =3D origin &&
    ++		test "$(git config branch.branch-a.merge)" =3D refs/heads/branch-a =
&&
    ++		# "origin/branch-a" does not exist for "sub", but it matches the re=
fspec
    ++		# so tracking should be set up
     +		test "$(git -C sub config branch.branch-a.remote)" =3D origin &&
    -+		test "$(git -C sub config branch.branch-a.merge)" =3D refs/heads/br=
anch-a
    ++		test "$(git -C sub config branch.branch-a.merge)" =3D refs/heads/br=
anch-a &&
    ++		test "$(git -C sub/sub-sub config branch.branch-a.remote)" =3D orig=
in &&
    ++		test "$(git -C sub/sub-sub config branch.branch-a.merge)" =3D refs/=
heads/branch-a
     +	)
     +'
     +
     +test_expect_success 'should not fail when unable to set up tracking i=
n submodule' '
    -+	test_when_finished "cleanup_branches super-clone branch-b" &&
    ++	test_when_finished "cleanup_branches super-clone branch-a && \
    ++		git -C super-clone remote rename ex-origin origin" &&
     +	(
     +		cd super-clone &&
    -+		git branch --recurse-submodules branch-b origin/branch-b
    ++		git remote rename origin ex-origin &&
    ++		git branch --recurse-submodules branch-a ex-origin/branch-a &&
    ++		test "$(git config branch.branch-a.remote)" =3D ex-origin &&
    ++		test "$(git config branch.branch-a.merge)" =3D refs/heads/branch-a =
&&
    ++		test "$(git -C sub config branch.branch-a.remote)" =3D "" &&
    ++		test "$(git -C sub config branch.branch-a.merge)" =3D ""
     +	)
     +'
     +
--=20
2.33.GIT

