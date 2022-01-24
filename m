Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97120C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 22:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356581AbiAXWSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 17:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582625AbiAXWPd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 17:15:33 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A045C04A2C2
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 12:45:00 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id e17-20020a63f551000000b0034d214ccec5so9093545pgk.10
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 12:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=3fKDHLvsVE3ml6sV+KrQIjr44JA2mYvIQ0PDu/Y8468=;
        b=H+gmFCCxtDSNZVjdyGy3JPcUzovKe2jPY8hyzEQHyNHmZoafhHXvR7GA5s88PIHcBf
         cvRPePMtDaqUoyNvVELaXD9ODoho48OLKKQe6iqgVi3UaT+WohqNpPr+rwV2IdwHslwC
         eWfFXneTEaEtUSQLGLGp4jqHfQ0Q1eUrGPEiNOdvfKZt/x5lMDmR1IIg9OpMBmR73V7m
         XSoc/FLpEPsIME/S8p974lS9zjm67YgAlx0rsT0k+CJak7aGZh6sDn9eb8A+fTIA9BBP
         wxVUUqr1KuKF6tRCF4H7I7SoqIAwAqgcfIT9NQcoxVDYMWdItbllBoOf8qYxZ4cs9V2k
         aUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=3fKDHLvsVE3ml6sV+KrQIjr44JA2mYvIQ0PDu/Y8468=;
        b=0mwg65FHWTwfXFrNJfAIjqsXQOSvxJgM6xurJah6q2jlz8/H8JdDm9GBotSVuDzsNk
         eO+CNkWDBHPUhK/ghzIwiINaSMMINQ89FB5Vuy6CmBpY/KTGMNx8Cx5BflL76fjpbZgn
         I/bg+mYPogCp+0LhsHSj5PB+Cy/gdHxRQZPfPg8cctnm8Eo0HGbxqz3bv1KXaEeKx1P7
         88JeIl+mbgHVWbOmmfvUNB/GFc2FLgRhz9HmyIdb1/1u8mXwNG0ZlYrRreqTT7TwsMbq
         l4qc7coOhj6ZNbVFMXUCAlxGIBQzfbY/g31nDitvo/NItOfGjmG8p1sjJvrSndIFoxNC
         oIkw==
X-Gm-Message-State: AOAM532cnx0Ok0RpFWCQK+qngn/aMKgThxmsAs4xUuT/2DzIF1bLQvG5
        taFrm3eLyDpOz+Y0gPNxE6YvVa59f4jzMg1P+sp+PsF/mJ/syYSBiRY1H48fwHo+mKKaaMwTRMs
        v+2GL1j18Nw2tbhnEA3KxkpMg7UGynMBubDoLMi1qXqDpvOG7MQDKhIIBGSdxn/k=
X-Google-Smtp-Source: ABdhPJzyoCxRL8Cwx7ati2Zrh5K6ZCDZFonba3+hrn276dvsw5Jk+pGQrSg2grzJzwBaSMqfyky/48RQ273fEA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:be09:0:b0:4c6:1af8:e547 with SMTP id
 l9-20020a62be09000000b004c61af8e547mr15653132pff.3.1643057099731; Mon, 24 Jan
 2022 12:44:59 -0800 (PST)
Date:   Mon, 24 Jan 2022 12:44:36 -0800
In-Reply-To: <20211220233459.45739-1-chooglen@google.com>
Message-Id: <20220124204442.39353-1-chooglen@google.com>
Mime-Version: 1.0
References: <20211220233459.45739-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v7 0/6] implement branch --recurse-submodules
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

Thanks for the feedback, Jonathan! I believe I've incorporated all of your
suggested fixes in this version - the most notable of which is to recreate =
the
test repo setup in each test instead of deleting branches. To save CPU cycl=
es in
setting up the test, the test suite writes the clean test setup to a
directory, then copies the setup to the right location for each test. In my
informal testing, this is even faster than deleting the unused branches.

The range-diff for patches 3-4 have some irrelevant noise because this vers=
ion
is based off 'js/branch-track-inherit', but (due to a mistake when applying=
 the
'js/branch-track-inherit' patches), v6 is based off a different 'master' co=
mmit.

=3D Description

This series implements "git branch --recurse-submodules", which is part of =
the
submodule branching RFC (see "See also"). "git branch" (and some other feat=
ures
in that RFC) are incompatible with existing "--recurse-submodules" commands=
;=20
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
 Documentation/git-branch.txt       |  11 +-
 advice.c                           |   1 +
 advice.h                           |   1 +
 branch.c                           | 271 ++++++++++++++++++++++-----
 branch.h                           |  53 +++++-
 builtin/branch.c                   |  70 +++++--
 builtin/checkout.c                 |   3 +-
 builtin/submodule--helper.c        |  38 ++++
 submodule-config.c                 |  60 ++++++
 submodule-config.h                 |  34 ++++
 submodule.c                        |  11 +-
 submodule.h                        |   3 +
 t/t3200-branch.sh                  |  17 ++
 t/t3207-branch-submodule.sh        | 282 +++++++++++++++++++++++++++++
 16 files changed, 815 insertions(+), 80 deletions(-)
 create mode 100755 t/t3207-branch-submodule.sh

Range-diff against v6:
1:  29669c57b4 ! 1:  206175cfb3 branch: move --set-upstream-to behavior to =
dwim_and_setup_tracking()
    @@ Metadata
      ## Commit message ##
         branch: move --set-upstream-to behavior to dwim_and_setup_tracking=
()
    =20
    -    This refactor is motivated by a desire to add a "dry_run" paramete=
r to
    -    create_branch() that will validate whether or not a branch can be
    -    created without actually creating it - this behavior will be used =
in a
    -    subsequent commit that adds `git branch --recurse-submodules topic=
`.
    +    This commit is preparation for a future commit that will simplify
    +    create_branch() so that it always creates a branch. This will allo=
w
    +    create_branch() to accept a dry_run parameter (which is needed for=
 "git
    +    branch --recurse-submodules").
    =20
    -    Adding "dry_run" is not obvious because create_branch() is also us=
ed to
    -    set tracking information without creating a branch, i.e. when usin=
g
    -    --set-upstream-to. This appears to be a leftover from 4fc5006676 (=
Add
    -    branch --set-upstream, 2010-01-18), when --set-upstream would some=
times
    -    create a branch and sometimes update tracking information without
    -    creating a branch. However, we no longer support --set-upstream, s=
o it
    -    makes more sense to set tracking information with another function=
 and
    -    use create_branch() only to create branches. In a later commit, we=
 will
    -    remove the now-unnecessary logic from create_branch() so that "dry=
_run"
    -    becomes trivial to implement.
    +    create_branch() used to always create a branch, but 4fc5006676 (Ad=
d
    +    branch --set-upstream, 2010-01-18) changed it to also be able to s=
et
    +    tracking information without creating a branch.
    =20
    -    Introduce dwim_and_setup_tracking(), which replaces create_branch(=
)
    -    in `git branch --set-upstream-to`. Ensure correctness by moving th=
e DWIM
    -    and branch validation logic from create_branch() into a helper fun=
ction,
    -    dwim_branch_start(), so that the logic is shared by both functions=
.
    +    Refactor the code that sets tracking information into its own func=
tions
    +    dwim_branch_start() and dwim_and_setup_tracking(). Also change an
    +    invocation of create_branch() in cmd_branch() in builtin/branch.c =
to use
    +    dwim_and_setup_tracking(), since that invocation is only for setti=
ng
    +    tracking information (in "git branch --set-upstream-to").
    =20
    +    As of this commit, create_branch() is no longer invoked in a way t=
hat
    +    does not create branches.
    +
    +    Helped-by: Jonathan Tan <jonathantanmy@google.com>
         Signed-off-by: Glen Choo <chooglen@google.com>
    =20
      ## branch.c ##
    @@ branch.c: static int inherit_tracking(struct tracking *tracking, con=
st char *ori
       */
      static void setup_tracking(const char *new_ref, const char *orig_ref,
      			   enum branch_track track, int quiet)
    -@@ branch.c: static void setup_tracking(const char *new_ref, const cha=
r *orig_ref,
    - 		case BRANCH_TRACK_INHERIT:
    - 			break;
    - 		default:
    --			return;
    -+			goto cleanup;
    - 		}
    -=20
    - 	if (tracking.matches > 1)
    -@@ branch.c: static void setup_tracking(const char *new_ref, const cha=
r *orig_ref,
    - 				tracking.remote, tracking.srcs) < 0)
    - 		exit(-1);
    -=20
    -+cleanup:
    - 	string_list_clear(tracking.srcs, 0);
    - }
    -=20
     @@ branch.c: N_("\n"
      "will track its remote counterpart, you may want to use\n"
      "\"git push -u\" to set the upstream config as you push.");
    @@ branch.c: void create_branch(struct repository *r,
      	if ((commit =3D lookup_commit_reference(r, &oid)) =3D=3D NULL)
      		die(_("Not a valid branch point: '%s'."), start_name);
     -	oidcpy(&oid, &commit->object.oid);
    -+	if (out_real_ref)
    -+		*out_real_ref =3D real_ref ? xstrdup(real_ref) : NULL;
    ++	if (out_real_ref) {
    ++		*out_real_ref =3D real_ref;
    ++		real_ref =3D NULL;
    ++	}
     +	if (out_oid)
     +		oidcpy(out_oid, &commit->object.oid);
     +
     +	FREE_AND_NULL(real_ref);
     +}
     +
    -+void create_branch(struct repository *r, const char *name,
    -+		   const char *start_name, int force, int clobber_head_ok,
    -+		   int reflog, int quiet, enum branch_track track)
    ++void create_branch(struct repository *r,
    ++		   const char *name, const char *start_name,
    ++		   int force, int clobber_head_ok, int reflog,
    ++		   int quiet, enum branch_track track)
     +{
     +	struct object_id oid;
     +	char *real_ref;
2:  ac2532a953 ! 2:  2e02885eb3 branch: make create_branch() always create =
a branch
    @@ Metadata
      ## Commit message ##
         branch: make create_branch() always create a branch
    =20
    -    create_branch() was formerly used to set tracking without creating=
 a
    -    branch. Since the previous commit replaces this use case with
    -    dwim_and_setup_tracking(), we can simplify create_branch() so that=
 it
    -    always creates a branch.
    +    With the previous commit, there are no more invocations of
    +    create_branch() that do not create a branch because:
    =20
    -    Do this simplification, in particular:
    +    * BRANCH_TRACK_OVERRIDE is no longer passed
    +    * clobber_head_ok =3D true and force =3D false is never passed
    =20
    -    * remove the special handling of BRANCH_TRACK_OVERRIDE because it =
is no
    -      longer used
    -    * assert that clobber_head_ok can only be provided with force
    -    * check that we're handling clobber_head_ok and force correctly by
    -      introducing tests for `git branch --force`
    +    Assert these situations, delete dead code and ensure that we're ha=
ndling
    +    clobber_head_ok and force correctly by introducing tests for `git =
branch
    +    --force`. As a result, create_branch() now always creates a branch=
.
    =20
    +    Helped-by: Jonathan Tan <jonathantanmy@google.com>
         Signed-off-by: Glen Choo <chooglen@google.com>
    =20
      ## branch.c ##
    -@@ branch.c: void create_branch(struct repository *r, const char *name=
,
    +@@ branch.c: void create_branch(struct repository *r,
      	char *real_ref;
      	struct strbuf ref =3D STRBUF_INIT;
      	int forcing =3D 0;
    @@ branch.c: void create_branch(struct repository *r, const char *name,
     +	struct strbuf err =3D STRBUF_INIT;
     +	char *msg;
     +
    ++	if (track =3D=3D BRANCH_TRACK_OVERRIDE)
    ++		BUG("'track' cannot be BRANCH_TRACK_OVERRIDE. Did you mean to call =
dwim_and_setup_tracking()?");
     +	if (clobber_head_ok && !force)
     +		BUG("'clobber_head_ok' can only be used with 'force'");
     +
    @@ branch.c: void create_branch(struct repository *r, const char *name,
      	}
     =20
      	dwim_branch_start(r, start_name, track, &real_ref, &oid);
    -@@ branch.c: void create_branch(struct repository *r, const char *name=
,
    +@@ branch.c: void create_branch(struct repository *r,
      	if (reflog)
      		log_all_ref_updates =3D LOG_REFS_NORMAL;
     =20
3:  a0ed3fa438 ! 3:  cd43a9aaaa branch: add a dry_run parameter to create_b=
ranch()
    @@ Commit message
    =20
      ## branch.c ##
     @@ branch.c: static void dwim_branch_start(struct repository *r, const=
 char *start_name,
    -=20
    - void create_branch(struct repository *r, const char *name,
    - 		   const char *start_name, int force, int clobber_head_ok,
    --		   int reflog, int quiet, enum branch_track track)
    -+		   int reflog, int quiet, enum branch_track track, int dry_run)
    + void create_branch(struct repository *r,
    + 		   const char *name, const char *start_name,
    + 		   int force, int clobber_head_ok, int reflog,
    +-		   int quiet, enum branch_track track)
    ++		   int quiet, enum branch_track track, int dry_run)
      {
      	struct object_id oid;
      	char *real_ref;
    -@@ branch.c: void create_branch(struct repository *r, const char *name=
,
    +@@ branch.c: void create_branch(struct repository *r,
      	}
     =20
      	dwim_branch_start(r, start_name, track, &real_ref, &oid);
    @@ branch.c: void create_branch(struct repository *r, const char *name,
     =20
      	if (reflog)
      		log_all_ref_updates =3D LOG_REFS_NORMAL;
    -@@ branch.c: void create_branch(struct repository *r, const char *name=
,
    +@@ branch.c: void create_branch(struct repository *r,
      	if (real_ref && track)
      		setup_tracking(ref.buf + 11, real_ref, track, quiet);
     =20
    @@ branch.h: void dwim_and_setup_tracking(struct repository *r, const c=
har *new_ref
     + *   - dry_run causes the branch to be validated but not created.
     + *
       */
    --void create_branch(struct repository *r,
    --		   const char *name, const char *start_name,
    --		   int force, int clobber_head_ok,
    + void create_branch(struct repository *r,
    + 		   const char *name, const char *start_name,
    + 		   int force, int clobber_head_ok,
     -		   int reflog, int quiet, enum branch_track track);
    -+void create_branch(struct repository *r, const char *name,
    -+		   const char *start_name, int force, int clobber_head_ok,
    -+		   int reflog, int quiet, enum branch_track track, int dry_run);
    ++		   int reflog, int quiet, enum branch_track track,
    ++		   int dry_run);
     =20
      /*
       * Check if 'name' can be a valid name for a branch; die otherwise.
    @@ builtin/checkout.c: static void update_refs_for_switch(const struct =
checkout_opt
     -				      opts->track);
     +				      opts->track,
     +				      0);
    - 		free(new_branch_info->name);
    - 		free(new_branch_info->refname);
    - 		new_branch_info->name =3D xstrdup(opts->new_branch);
    + 		new_branch_info->name =3D opts->new_branch;
    + 		setup_branch_path(new_branch_info);
    + 	}
4:  ebded31c96 ! 4:  8e5f750162 builtin/branch: clean up action-picking log=
ic in cmd_branch()
    @@ Metadata
     Author: Glen Choo <chooglen@google.com>
    =20
      ## Commit message ##
    -    builtin/branch: clean up action-picking logic in cmd_branch()
    +    builtin/branch: consolidate action-picking logic in cmd_branch()
    =20
    -    Add a variable to cmd_branch() that will tell us whether or not
    -    cmd_branch() will default to creating a branch (instead of perform=
ing
    -    another action). Besides making the function more explicit, this a=
llows
    -    us to validate options that can only be used when creating a branc=
h.
    -    Such an option does not exist yet, but one will be introduced in a
    -    subsequent commit.
    +    Consolidate the logic for deciding when to create a new branch in
    +    cmd_branch(), and save the result for reuse. Besides making the fu=
nction
    +    more explicit, this allows us to validate options that can only be=
 used
    +    when creating a branch. Such an option does not exist yet, but one=
 will
    +    be introduced in a subsequent commit.
    =20
    +    Helped-by: Jonathan Tan <jonathantanmy@google.com>
         Signed-off-by: Glen Choo <chooglen@google.com>
    =20
      ## builtin/branch.c ##
    @@ builtin/branch.c: static int edit_branch_description(const char *bra=
nch_name)
      	enum branch_track track;
      	struct ref_filter filter;
     -	int icase =3D 0;
    - 	static struct ref_sorting *sorting;
    - 	struct string_list sorting_options =3D STRING_LIST_INIT_DUP;
    + 	static struct ref_sorting *sorting =3D NULL, **sorting_tail =3D &sor=
ting;
      	struct ref_format format =3D REF_FORMAT_INIT;
    +=20
     @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const=
 char *prefix)
      	    filter.reachable_from || filter.unreachable_from || filter.point=
s_at.nr)
      		list =3D 1;
5:  0a7ec6ee75 ! 5:  c59de1fd9c branch: add --recurse-submodules option for=
 branch creation
    @@ Commit message
         branch: add --recurse-submodules option for branch creation
    =20
         To improve the submodules UX, we would like to teach Git to handle
    -    branches in submodules. Start this process by teaching `git branch=
` the
    -    --recurse-submodules option so that `git branch --recurse-submodul=
es
    -    topic` will create the "topic" branch in the superproject and its
    +    branches in submodules. Start this process by teaching "git branch=
" the
    +    --recurse-submodules option so that "git branch --recurse-submodul=
es
    +    topic" will create the `topic` branch in the superproject and its
         submodules.
    =20
         Although this commit does not introduce breaking changes, it is
    -    incompatible with existing --recurse-submodules semantics e.g. `gi=
t
    -    checkout` does not recursively checkout the expected branches crea=
ted by
    -    `git branch` yet. To ensure that the correct set of semantics is u=
sed,
    -    this commit introduces a new configuration value,
    -    `submodule.propagateBranches`, which enables submodule branching w=
hen
    -    true (defaults to false).
    +    incompatible with existing --recurse-submodules commands because "=
git
    +    branch --recurse-submodules" writes to the submodule ref store, bu=
t most
    +    commands only consider the superproject gitlink and ignore the sub=
module
    +    ref store. For example, "git checkout --recurse-submodules" will c=
heck
    +    out the commits in the superproject gitlinks (and put the submodul=
es in
    +    detached HEAD) instead of checking out the submodule branches.
    =20
    -    This commit includes changes that allow Git to work with submodule=
s
    -    that are in trees (and not just the index):
    +    Because of this, this commit introduces a new configuration value,
    +    `submodule.propagateBranches`. The plan is for Git commands to
    +    prioritize submodule ref store information over superproject gitli=
nks if
    +    this value is true. Because "git branch --recurse-submodules" writ=
es to
    +    submodule ref stores, for the sake of clarity, it will not functio=
n
    +    unless this configuration value is set.
    +
    +    This commit also includes changes that support working with submod=
ules
    +    from a superproject commit because "branch --recurse-submodules" (=
and
    +    future commands) need to read .gitmodules and gitlinks from the
    +    superproject commit, but submodules are typically read from the
    +    filesystem's .gitmodules and the index's gitlinks. These changes a=
re:
    =20
         * add a submodules_of_tree() helper that gives the relevant
           information of an in-tree submodule (e.g. path and oid) and
    @@ Commit message
         incorrect since its inception, a8dfd5eac4 (Make builtin-branch.c u=
se
         parse_options., 2007-10-07).
    =20
    +    Helped-by: Jonathan Tan <jonathantanmy@google.com>
         Signed-off-by: Glen Choo <chooglen@google.com>
    =20
      ## Documentation/config/advice.txt ##
    @@ Documentation/config/submodule.txt: submodule.active::
     -	Applies to all commands that support this option
     -	(`checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`, `reset`,
     -	`restore` and `switch`) except `clone` and `ls-files`.
    --	Defaults to false.
     +	option by default. Defaults to false.
    -+	+
    - 	When set to true, it can be deactivated via the
    - 	`--no-recurse-submodules` option. Note that some Git commands
    - 	lacking this option may call some of the above commands affected by
    -@@ Documentation/config/submodule.txt: submodule.recurse::
    - 	`git fetch` but does not have a `--no-recurse-submodules` option.
    - 	For these commands a workaround is to temporarily change the
    - 	configuration value by using `git -c submodule.recurse=3D0`.
    -+	+
    -+	The following list shows the commands that accept
    -+	`--recurse-submodules` and whether they are supported by this
    -+	setting.
    -+	* `checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`,
    -+	`reset`, `restore` and `switch` are always supported.
    -+	* `clone` and `ls-files` are not supported.
    -+	* `branch` is supported only if `submodule.propagateBranches` is
    -+	enabled
    +++
    ++When set to true, it can be deactivated via the
    ++`--no-recurse-submodules` option. Note that some Git commands
    ++lacking this option may call some of the above commands affected by
    ++`submodule.recurse`; for instance `git remote update` will call
    ++`git fetch` but does not have a `--no-recurse-submodules` option.
    ++For these commands a workaround is to temporarily change the
    ++configuration value by using `git -c submodule.recurse=3D0`.
    +++
    ++The following list shows the commands that accept
    ++`--recurse-submodules` and whether they are supported by this
    ++setting.
    ++
    ++* `checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`,
    ++`reset`, `restore` and `switch` are always supported.
    ++* `clone` and `ls-files` are not supported.
    ++* `branch` is supported only if `submodule.propagateBranches` is
    ++enabled
     +
     +submodule.propagateBranches::
     +	[EXPERIMENTAL] A boolean that enables branching support when
    @@ Documentation/config/submodule.txt: submodule.recurse::
     +	Enabling this will allow certain commands to accept
     +	`--recurse-submodules` and certain commands that already accept
     +	`--recurse-submodules` will now consider branches.
    -+	Defaults to false.
    + 	Defaults to false.
    +-	When set to true, it can be deactivated via the
    +-	`--no-recurse-submodules` option. Note that some Git commands
    +-	lacking this option may call some of the above commands affected by
    +-	`submodule.recurse`; for instance `git remote update` will call
    +-	`git fetch` but does not have a `--no-recurse-submodules` option.
    +-	For these commands a workaround is to temporarily change the
    +-	configuration value by using `git -c submodule.recurse=3D0`.
     =20
      submodule.fetchJobs::
      	Specifies how many submodules are fetched/cloned at the same time.
    @@ branch.c: void dwim_and_setup_tracking(struct repository *r, const c=
har *new_ref
     +/**
     + * Creates a branch in a submodule by calling
     + * create_branches_recursively() in a child process. The child proces=
s
    -+ * is necessary because install_branch_config() (and its variants) do
    -+ * not support writing configs to submodules.
    ++ * is necessary because install_branch_config_multiple_remotes() (whi=
ch
    ++ * is called by setup_tracking()) does not support writing configs to
    ++ * submodules.
     + */
     +static int submodule_create_branch(struct repository *r,
     +				   const struct submodule *submodule,
    @@ branch.c: void dwim_and_setup_tracking(struct repository *r, const c=
har *new_ref
     +	child.stdout_to_stderr =3D 1;
     +
     +	prepare_other_repo_env(&child.env_array, r->gitdir);
    ++	/*
    ++	 * submodule_create_branch() is indirectly invoked by "git
    ++	 * branch", but we cannot invoke "git branch" in the child
    ++	 * process because it does not let us set start_name and
    ++	 * start_oid separately (see create_branches_recursively()).
    ++	 */
     +	strvec_pushl(&child.args, "submodule--helper", "create-branch", NULL=
);
     +	if (dry_run)
     +		strvec_push(&child.args, "--dry-run");
    @@ branch.c: void dwim_and_setup_tracking(struct repository *r, const c=
har *new_ref
      	unlink(git_path_merge_head(r));
    =20
      ## branch.h ##
    -@@ branch.h: void create_branch(struct repository *r, const char *name=
,
    - 		   const char *start_name, int force, int clobber_head_ok,
    - 		   int reflog, int quiet, enum branch_track track, int dry_run);
    +@@ branch.h: void create_branch(struct repository *r,
    + 		   int reflog, int quiet, enum branch_track track,
    + 		   int dry_run);
     =20
     +/*
     + * Creates a new branch in repository and its submodules (and its
    @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const =
char *prefix
     +	    recurse_submodules_explicit =3D 0;
      	enum branch_track track;
      	struct ref_filter filter;
    - 	static struct ref_sorting *sorting;
    + 	static struct ref_sorting *sorting =3D NULL, **sorting_tail =3D &sor=
ting;
     @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const=
 char *prefix)
      		OPT_CALLBACK(0, "points-at", &filter.points_at, N_("object"),
      			N_("print only branches of the object"), parse_opt_object_name),
    @@ t/t3207-branch-submodule.sh (new)
     +. ./test-lib.sh
     +. "$TEST_DIRECTORY"/lib-rebase.sh
     +
    -+test_expect_success 'setup superproject and submodule' '
    -+	git init super &&
    -+	test_commit foo &&
    -+	git init sub-sub-upstream &&
    -+	test_commit -C sub-sub-upstream foo &&
    -+	git init sub-upstream &&
    -+	# Submodule in a submodule
    -+	git -C sub-upstream submodule add "$TRASH_DIRECTORY/sub-sub-upstream=
" sub-sub &&
    -+	git -C sub-upstream commit -m "add submodule" &&
    -+	# Regular submodule
    -+	git -C super submodule add "$TRASH_DIRECTORY/sub-upstream" sub &&
    -+	# Submodule in a subdirectory
    -+	git -C super submodule add "$TRASH_DIRECTORY/sub-sub-upstream" secon=
d/sub &&
    -+	git -C super commit -m "add submodule" &&
    -+	git -C super config submodule.propagateBranches true &&
    -+	git -C super/sub submodule update --init
    -+'
    -+
    -+CLEANUP_SCRIPT_PATH=3D"$TRASH_DIRECTORY/cleanup_branches.sh"
    ++pwd=3D$(pwd)
     +
    -+cat >"$CLEANUP_SCRIPT_PATH" <<'EOF'
    -+	#!/bin/sh
    ++# Creates a clean test environment in "pwd" by copying the repo setup
    ++# from test_dirs.
    ++reset_test () {
    ++	rm -fr super &&
    ++	rm -fr sub-sub-upstream &&
    ++	rm -fr sub-upstream &&
    ++	cp -r test_dirs/* .
    ++}
     +
    -+	super_dir=3D"$1"
    -+	shift
    ++test_expect_success 'setup superproject and submodule' '
    ++	mkdir test_dirs &&
     +	(
    -+		cd "$super_dir" &&
    -+		git checkout main &&
    -+		for branch_name in "$@"; do
    -+			git branch -D "$branch_name"
    -+			git submodule foreach "$TRASH_DIRECTORY/cleanup_branches.sh . $bra=
nch_name || true"
    -+		done
    -+	)
    -+EOF
    -+chmod +x "$CLEANUP_SCRIPT_PATH"
    -+
    -+cleanup_branches() {
    -+	TRASH_DIRECTORY=3D"\"$TRASH_DIRECTORY\"" "$CLEANUP_SCRIPT_PATH" "$@"
    -+} >/dev/null 2>/dev/null
    ++		cd test_dirs &&
    ++		git init super &&
    ++		test_commit -C super foo &&
    ++		git init sub-sub-upstream &&
    ++		test_commit -C sub-sub-upstream foo &&
    ++		git init sub-upstream &&
    ++		# Submodule in a submodule
    ++		git -C sub-upstream submodule add "${pwd}/test_dirs/sub-sub-upstrea=
m" sub-sub &&
    ++		git -C sub-upstream commit -m "add submodule" &&
    ++		# Regular submodule
    ++		git -C super submodule add "${pwd}/test_dirs/sub-upstream" sub &&
    ++		# Submodule in a subdirectory
    ++		git -C super submodule add "${pwd}/test_dirs/sub-sub-upstream" seco=
nd/sub &&
    ++		git -C super commit -m "add submodule" &&
    ++		git -C super config submodule.propagateBranches true &&
    ++		git -C super/sub submodule update --init
    ++	) &&
    ++	reset_test
    ++'
     +
     +# Test the argument parsing
     +test_expect_success '--recurse-submodules should create branches' '
    -+	test_when_finished "cleanup_branches super branch-a" &&
    ++	test_when_finished "reset_test" &&
     +	(
     +		cd super &&
     +		git branch --recurse-submodules branch-a &&
    @@ t/t3207-branch-submodule.sh (new)
     +'
     +
     +test_expect_success '--recurse-submodules should die if submodule.pro=
pagateBranches is false' '
    -+	test_when_finished "cleanup_branches super branch-a" &&
    ++	test_when_finished "reset_test" &&
     +	(
     +		cd super &&
     +		echo "fatal: branch with --recurse-submodules can only be used if s=
ubmodule.propagateBranches is enabled" >expected &&
    @@ t/t3207-branch-submodule.sh (new)
     +'
     +
     +test_expect_success '--recurse-submodules should fail when not creati=
ng branches' '
    -+	test_when_finished "cleanup_branches super branch-a" &&
    ++	test_when_finished "reset_test" &&
     +	(
     +		cd super &&
     +		git branch --recurse-submodules branch-a &&
     +		test_must_fail git branch --recurse-submodules -D branch-a &&
     +		# Assert that the branches were not deleted
    -+		git rev-parse --abbrev-ref branch-a &&
    -+		git -C sub rev-parse --abbrev-ref branch-a
    ++		git rev-parse branch-a &&
    ++		git -C sub rev-parse branch-a
     +	)
     +'
     +
     +test_expect_success 'should respect submodule.recurse when creating b=
ranches' '
    -+	test_when_finished "cleanup_branches super branch-a" &&
    ++	test_when_finished "reset_test" &&
     +	(
     +		cd super &&
     +		git -c submodule.recurse=3Dtrue branch branch-a &&
    -+		git rev-parse --abbrev-ref branch-a &&
    -+		git -C sub rev-parse --abbrev-ref branch-a
    ++		git rev-parse branch-a &&
    ++		git -C sub rev-parse branch-a
     +	)
     +'
     +
     +test_expect_success 'should ignore submodule.recurse when not creatin=
g branches' '
    -+	test_when_finished "cleanup_branches super branch-a" &&
    ++	test_when_finished "reset_test" &&
     +	(
     +		cd super &&
     +		git branch --recurse-submodules branch-a &&
     +		git -c submodule.recurse=3Dtrue branch -D branch-a &&
    -+		test_must_fail git rev-parse --abbrev-ref branch-a &&
    -+		git -C sub rev-parse --abbrev-ref branch-a
    ++		test_must_fail git rev-parse branch-a &&
    ++		git -C sub rev-parse branch-a
     +	)
     +'
     +
     +# Test branch creation behavior
     +test_expect_success 'should create branches based off commit id in su=
perproject' '
    -+	test_when_finished "cleanup_branches super branch-a branch-b" &&
    ++	test_when_finished "reset_test" &&
     +	(
     +		cd super &&
     +		git branch --recurse-submodules branch-a &&
    @@ t/t3207-branch-submodule.sh (new)
     +'
     +
     +test_expect_success 'should not create any branches if branch is not =
valid for all repos' '
    -+	test_when_finished "cleanup_branches super branch-a" &&
    ++	test_when_finished "reset_test" &&
     +	(
     +		cd super &&
     +		git -C sub branch branch-a &&
     +		test_must_fail git branch --recurse-submodules branch-a 2>actual &&
     +		test_must_fail git rev-parse branch-a &&
    -+
    -+		cat >expected <<-EOF &&
    -+		submodule ${SQ}sub${SQ}: fatal: A branch named ${SQ}branch-a${SQ} a=
lready exists.
    -+		fatal: submodule ${SQ}sub${SQ}: cannot create branch ${SQ}branch-a$=
{SQ}
    -+		EOF
    -+		test_cmp expected actual
    ++		grep "submodule .sub.: fatal: A branch named .branch-a. already exi=
sts" actual
     +	)
     +'
     +
     +test_expect_success 'should create branches if branch exists and --fo=
rce is given' '
    -+	test_when_finished "cleanup_branches super branch-a" &&
    ++	test_when_finished "reset_test" &&
     +	(
     +		cd super &&
     +		git -C sub rev-parse HEAD >expected &&
     +		test_commit -C sub baz &&
    -+		git -C sub branch branch-a HEAD~1 &&
    ++		# branch-a in sub now points to a newer commit.
    ++		git -C sub branch branch-a HEAD &&
    ++		git -C sub rev-parse branch-a >actual-old-branch-a &&
     +		git branch --recurse-submodules --force branch-a &&
     +		git rev-parse branch-a &&
    -+		# assert that sub:branch-a was moved
    -+		git -C sub rev-parse branch-a >actual &&
    -+		test_cmp expected actual
    ++		git -C sub rev-parse branch-a >actual-new-branch-a &&
    ++		test_cmp expected actual-new-branch-a &&
    ++		# assert that branch --force actually moved the sub
    ++		# branch
    ++		! test_cmp expected actual-old-branch-a
     +	)
     +'
     +
     +test_expect_success 'should create branch when submodule is not in HE=
AD:.gitmodules' '
    -+	test_when_finished "cleanup_branches super branch-a branch-b branch-=
c" &&
    ++	test_when_finished "reset_test" &&
     +	(
     +		cd super &&
     +		git branch branch-a &&
    @@ t/t3207-branch-submodule.sh (new)
     +		git commit -m "add second submodule" &&
     +		git checkout branch-a &&
     +		git branch --recurse-submodules branch-c branch-b &&
    -+		git rev-parse branch-c &&
    -+		git -C sub rev-parse branch-c &&
    -+		git -C second/sub rev-parse branch-c &&
     +		git checkout --recurse-submodules branch-c &&
     +		git -C sub2 rev-parse branch-c &&
     +		git -C sub2/sub-sub rev-parse branch-c
     +	)
     +'
     +
    ++test_expect_success 'should not create branches in inactive submodule=
s' '
    ++	test_when_finished "reset_test" &&
    ++	test_config -C super submodule.sub.active false &&
    ++	(
    ++		cd super &&
    ++		git branch --recurse-submodules branch-a &&
    ++		git rev-parse branch-a &&
    ++		test_must_fail git -C sub branch-a
    ++	)
    ++'
    ++
     +test_expect_success 'should set up tracking of local branches with tr=
ack=3Dalways' '
    -+	test_when_finished "cleanup_branches super branch-a" &&
    ++	test_when_finished "reset_test" &&
     +	(
     +		cd super &&
     +		git -c branch.autoSetupMerge=3Dalways branch --recurse-submodules b=
ranch-a main &&
    @@ t/t3207-branch-submodule.sh (new)
     +'
     +
     +test_expect_success 'should set up tracking of local branches with ex=
plicit track' '
    -+	test_when_finished "cleanup_branches super branch-a" &&
    ++	test_when_finished "reset_test" &&
     +	(
     +		cd super &&
     +		git branch --track --recurse-submodules branch-a main &&
    @@ t/t3207-branch-submodule.sh (new)
     +'
     +
     +test_expect_success 'should not set up unnecessary tracking of local =
branches' '
    -+	test_when_finished "cleanup_branches super branch-a" &&
    ++	test_when_finished "reset_test" &&
     +	(
     +		cd super &&
     +		git branch --recurse-submodules branch-a main &&
    @@ t/t3207-branch-submodule.sh (new)
     +	)
     +'
     +
    -+test_expect_success 'should not create branches in inactive submodule=
s' '
    -+	test_when_finished "cleanup_branches super branch-a" &&
    -+	test_config -C super submodule.sub.active false &&
    -+	(
    -+		cd super &&
    -+		git branch --recurse-submodules branch-a &&
    -+		git rev-parse branch-a &&
    -+		test_must_fail git -C sub branch-a
    -+	)
    -+'
    ++reset_remote_test () {
    ++	rm -fr super-clone &&
    ++	reset_test
    ++}
     +
    -+test_expect_success 'setup remote-tracking tests' '
    ++test_expect_success 'setup tests with remotes' '
     +	(
    -+		cd super &&
    -+		git branch branch-a &&
    -+		git checkout -b branch-b &&
    -+		git submodule add ../sub-upstream sub2 &&
    -+		# branch-b now has a committed submodule not in branch-a
    -+		git commit -m "add second submodule"
    ++		cd test_dirs &&
    ++		(
    ++			cd super &&
    ++			git branch branch-a &&
    ++			git checkout -b branch-b &&
    ++			git submodule add ../sub-upstream sub2 &&
    ++			# branch-b now has a committed submodule not in branch-a
    ++			git commit -m "add second submodule"
    ++		) &&
    ++		git clone --branch main --recurse-submodules super super-clone &&
    ++		git -C super-clone config submodule.propagateBranches true
     +	) &&
    -+	git clone --branch main --recurse-submodules super super-clone &&
    -+	git -C super-clone config submodule.propagateBranches true
    ++	reset_remote_test
     +'
     +
    -+test_expect_success 'should not create branch when submodule is not i=
n .git/modules' '
    -+	# The cleanup needs to delete sub2 separately because main does not =
have sub2
    -+	test_when_finished "git -C super-clone/sub2 branch -D branch-b && \
    -+		git -C super-clone/sub2/sub-sub branch -D branch-b && \
    -+		cleanup_branches super-clone branch-a branch-b" &&
    ++test_expect_success 'should get fatal error upon branch creation when=
 submodule is not in .git/modules' '
    ++	test_when_finished "reset_remote_test" &&
     +	(
     +		cd super-clone &&
    -+		# This should succeed because super-clone has sub.
    ++		# This should succeed because super-clone has sub in .git/modules
     +		git branch --recurse-submodules branch-a origin/branch-a &&
    -+		# This should fail because super-clone does not have sub2.
    ++		# This should fail because super-clone does not have sub2 .git/modu=
les
     +		test_must_fail git branch --recurse-submodules branch-b origin/bran=
ch-b 2>actual &&
    -+		cat >expected <<-EOF &&
    -+		hint: You may try updating the submodules using ${SQ}git checkout o=
rigin/branch-b && git submodule update --init${SQ}
    -+		fatal: submodule ${SQ}sub2${SQ}: unable to find submodule
    -+		EOF
    -+		test_cmp expected actual &&
    ++		grep "fatal: submodule .sub2.: unable to find submodule" actual &&
     +		test_must_fail git rev-parse branch-b &&
     +		test_must_fail git -C sub rev-parse branch-b &&
     +		# User can fix themselves by initializing the submodule
    @@ t/t3207-branch-submodule.sh (new)
     +'
     +
     +test_expect_success 'should set up tracking of remote-tracking branch=
es' '
    -+	test_when_finished "cleanup_branches super-clone branch-a" &&
    ++	test_when_finished "reset_remote_test" &&
     +	(
     +		cd super-clone &&
     +		git branch --recurse-submodules branch-a origin/branch-a &&
    @@ t/t3207-branch-submodule.sh (new)
     +'
     +
     +test_expect_success 'should not fail when unable to set up tracking i=
n submodule' '
    -+	test_when_finished "cleanup_branches super-clone branch-a && \
    -+		git -C super-clone remote rename ex-origin origin" &&
    ++	test_when_finished "reset_remote_test" &&
     +	(
     +		cd super-clone &&
     +		git remote rename origin ex-origin &&
-:  ---------- > 6:  a4634f0493 branch.c: use 'goto cleanup' in setup_track=
ing() to fix memory leaks

base-commit: 44f14a9d24cd9f04a0a789e58968d52d44d7f332
--=20
2.33.GIT

