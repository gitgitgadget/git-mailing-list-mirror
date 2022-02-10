Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3741FC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbiBJJ2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:28:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbiBJJ2r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:28:47 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD28AD95
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:28:48 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id j1-20020a170903028100b0014b1f9e0068so1163948plr.8
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=/Qy+B6KsNBkCnowSIpZec6R4QQTXSbLQVMSY/FI15i8=;
        b=Pu6kL9+yXqqBOtMPqXHG7I7/MuC5azMfDNtX1JUG6FKMZmwTp9xBs2HTCZyri1dZgN
         eo2Q8IK6p23qay2yX54TnHIOSbEbs5n5Qxqt8BQLKTviApPoicgvU26viN1AakrSKTY5
         S23xMHyl9Eo25Q9UIDHLnZLtH8YbQ2YbVzsaaK45msMoG5SNa5L173e1rErZgapUEMwT
         HufgYG0wHV6Rors3xZUGJX0hFzaLIcx4XnAZ5Wl7Zyq3Vrd4Ae1L4yHOJSlmy7skidxw
         cX6DXTlsMAgvGn91OLqZ175rDNxNriZTTY7AW1uaaPEdvm/SZS9cvyO/M8MmPF2vcj+A
         dolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=/Qy+B6KsNBkCnowSIpZec6R4QQTXSbLQVMSY/FI15i8=;
        b=ls7JbQvm3KJgj/CcZa4zDxVL1fRqZ1wdg2aPoLndEyuiJ8lVAxpgjuMeHNEeTRdFpK
         LlbwOLATAy3ltcnAnHIAMVfPZq3iib1pfRlRY8aIaqOA/JLlGW3qDhs4eZLVYmZ8pSJ1
         6BPu5/rZcBAmAyMjwoBuIIDy46G/zfdM6FYuFMv3vwaWGqoQVe4IhTpp0NXDO2QA+VSU
         V5SiQfpEpehbUVhmIjce4/VMaQu+6lqy3lJSZsipD64mjOOQkQIj4+CUM5zP0qP6k0xL
         PD4KOEBqvWdYBcyJujBpqX/kxDIb7hzpeice7vnmrTCvG7Mrcm401MpLCld9G1bRHTXE
         l6sw==
X-Gm-Message-State: AOAM530dp+HFUhS9/HehTg0mlFAb+2TlKKw9pZ/4vF1NhB0lK0tV8AfK
        bBVd5mzdemVw8rt2CjW9sop03ADI5388Zf18zDieP9apJuJYR6CBd4gQwONftJzUBHmdpDZNnRH
        v0+08+LU9YYckhA69l5WzEs8i96yWnU54sefU70fgATP+SsqLJcBwnD0j0PaiskI=
X-Google-Smtp-Source: ABdhPJxT5Zqt9ZVjKlmyjc6T/JJ1Hw+HDNPi1UTG/UIIsrxsC1dX/VEyQZQnmLv1U25f+rSImyV7N8VZVKRtlA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:e40f:: with SMTP id
 hv15mr318722pjb.1.1644485327530; Thu, 10 Feb 2022 01:28:47 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:13 +0800
In-Reply-To: 20220208083952.35036-1-chooglen@google.com
Message-Id: <20220210092833.55360-1-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 00/20] submodule: convert the rest of 'update' to C
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reroll contains another 'easy' preparatory patch and the fixups I
alluded to in v6 [1]. This isn't the split-up I described in the
footnote of v6, but it gets the big patch (patch 17) to what I think is
a reviewable state.

The diff between v7 and v5 is no longer just NEEDSWORK comments, but I
think it is easier to reason about. Patch 17 resembles v5 the most (I
will include a diff in a reply to that patch); everything after patch 17
is fixups (I did not squash them in because they would grow the diff
even more).

I will also leave a review on patch 17 since the changes were not
originally authored by me.

[1] https://lore.kernel.org/git/20220208083952.35036-1-chooglen@google.com

Changes in v7:
- Split the last patch of v6 (the big one) into patches 16-17.
- Patch 16 moves logic out of run_update_procedure() (because the
  command is going away), removing some noise from patch 17. This makes
  the update_strategy parsing easier to reason about, but at the cost of
  growing the diff vis-a-vis v5
- Patches 18-20 are fixups that address NEEDSWORK comments from earlier
  patches. Once maintaining a small diff vis-a-vis v5 stops making
  sense, I will squash them in.

Atharva Raykar (6):
  submodule--helper: get remote names from any repository
  submodule--helper: refactor get_submodule_displaypath()
  submodule--helper: allow setting superprefix for init_submodule()
  submodule--helper: run update using child process struct
  builtin/submodule--helper.c: reformat designated initializers
  submodule: move core cmd_update() logic to C

Glen Choo (11):
  submodule--helper: remove update-module-mode
  submodule--helper: reorganize code for sh to C conversion
  submodule--helper run-update-procedure: remove --suboid
  submodule--helper run-update-procedure: learn --remote
  submodule--helper: remove ensure-core-worktree
  submodule--helper update-clone: learn --init
  submodule--helper: move functions around
  submodule--helper: reduce logic in run_update_procedure()
  fixup! submodule--helper run-update-procedure: remove --suboid
  fixup! submodule--helper run-update-procedure: learn --remote
  fixup! submodule: move core cmd_update() logic to C

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
  builtin/submodule--helper.c: rename option variables to "opt"
  submodule--helper: don't use bitfield indirection for parse_options()
  submodule tests: test for init and update failure output

 builtin/submodule--helper.c    | 695 ++++++++++++++++++---------------
 git-submodule.sh               | 153 +-------
 t/t7406-submodule-update.sh    |  14 +-
 t/t7408-submodule-reference.sh |  14 +-
 4 files changed, 423 insertions(+), 453 deletions(-)

Range-diff against v6:
 1:  79c522cf56 =3D  1:  86ffb53742 submodule--helper: get remote names fro=
m any repository
 2:  0b97034d89 =3D  2:  2a40266b7a submodule--helper: refactor get_submodu=
le_displaypath()
 3:  fedbed87a3 =3D  3:  cd851c8eb5 submodule--helper: allow setting superp=
refix for init_submodule()
 4:  8e7868c5d1 =3D  4:  bfe5cad136 submodule--helper: run update using chi=
ld process struct
 5:  3dee4b9b15 =3D  5:  72c257fdbf builtin/submodule--helper.c: reformat d=
esignated initializers
 6:  e2cc866e6b =3D  6:  4b5f703fde builtin/submodule--helper.c: rename opt=
ion variables to "opt"
 7:  4831695dc6 =3D  7:  f1d21f5b1c submodule--helper: don't use bitfield i=
ndirection for parse_options()
 8:  c2dadfffb2 =3D  8:  9d32a73fc3 submodule tests: test for init and upda=
te failure output
 9:  79ceb88dee =3D  9:  087bf43aba submodule--helper: remove update-module=
-mode
10:  6fe25e24da =3D 10:  4eb2893a19 submodule--helper: reorganize code for =
sh to C conversion
11:  52c997f97b =3D 11:  c08e7781e3 submodule--helper run-update-procedure:=
 remove --suboid
12:  61a5b02472 =3D 12:  2419c37184 submodule--helper run-update-procedure:=
 learn --remote
13:  f76627a078 =3D 13:  6691fd3648 submodule--helper: remove ensure-core-w=
orktree
14:  2d93c4232b =3D 14:  d2c9c356e9 submodule--helper update-clone: learn -=
-init
15:  d4899c5635 ! 15:  c8945fcc6f submodule--helper: move functions around
    @@ Metadata
      ## Commit message ##
         submodule--helper: move functions around
    =20
    -    The next commit will change the internals of several functions and
    +    A subsequent commit will change the internals of several functions=
 and
         arrange them in a more logical manner. Move these functions to the=
ir
         final positions so that the diff is smaller.
    =20
 -:  ---------- > 16:  10af533ae0 submodule--helper: reduce logic in run_up=
date_procedure()
16:  edf752da8d ! 17:  19143f6009 submodule: move core cmd_update() logic t=
o C
    @@ builtin/submodule--helper.c: struct submodule_update_clone {
      };
      #define SUBMODULE_UPDATE_CLONE_INIT { \
      	.list =3D MODULE_LIST_INIT, \
    -@@ builtin/submodule--helper.c: struct submodule_update_clone {
    - }
    -=20
    - struct update_data {
    -+	const char *prefix;
    - 	const char *recursive_prefix;
    - 	const char *sm_path;
    - 	const char *displaypath;
     @@ builtin/submodule--helper.c: struct update_data {
      	struct object_id suboid;
      	struct submodule_update_strategy update_strategy;
    @@ builtin/submodule--helper.c: struct update_data {
     =20
      static void next_submodule_warn_missing(struct submodule_update_clone=
 *suc,
     @@ builtin/submodule--helper.c: static int run_update_command(struct u=
pdate_data *ud, int subforce)
    - 	struct child_process cp =3D CHILD_PROCESS_INIT;
    - 	char *oid =3D oid_to_hex(&ud->oid);
    - 	int must_die_on_failure =3D 0;
    -+	struct submodule_update_strategy strategy =3D SUBMODULE_UPDATE_STRAT=
EGY_INIT;
    -+
    -+	if (ud->update_strategy.type =3D=3D SM_UPDATE_UNSPECIFIED || ud->jus=
t_cloned)
    -+		determine_submodule_update_strategy(the_repository, ud->just_cloned=
,
    -+						    ud->sm_path, NULL, &strategy);
    -+	else
    -+		strategy =3D ud->update_strategy;
    -=20
    --	switch (ud->update_strategy.type) {
    -+	switch (strategy.type) {
    - 	case SM_UPDATE_CHECKOUT:
    - 		cp.git_cmd =3D 1;
    - 		strvec_pushl(&cp.args, "checkout", "-q", NULL);
    -@@ builtin/submodule--helper.c: static int run_update_command(struct u=
pdate_data *ud, int subforce)
    - 		break;
    - 	case SM_UPDATE_COMMAND:
    - 		cp.use_shell =3D 1;
    --		strvec_push(&cp.args, ud->update_strategy.command);
    -+		strvec_push(&cp.args, strategy.command);
    - 		must_die_on_failure =3D 1;
    - 		break;
    - 	default:
    - 		BUG("unexpected update strategy type: %s",
    --		    submodule_strategy_to_string(&ud->update_strategy));
    -+		    submodule_strategy_to_string(&strategy));
    - 	}
    - 	strvec_push(&cp.args, oid);
    -=20
    - 	cp.dir =3D xstrdup(ud->sm_path);
    - 	prepare_submodule_repo_env(&cp.env_array);
      	if (run_command(&cp)) {
    --		switch (ud->update_strategy.type) {
    -+		switch (strategy.type) {
    + 		switch (ud->update_strategy.type) {
      		case SM_UPDATE_CHECKOUT:
     -			printf(_("Unable to checkout '%s' in submodule path '%s'"),
     -			       oid, ud->displaypath);
    @@ builtin/submodule--helper.c: static int run_update_command(struct up=
date_data *u
      		case SM_UPDATE_REBASE:
     -			printf(_("Unable to rebase '%s' in submodule path '%s'"),
     -			       oid, ud->displaypath);
    -+			if (!must_die_on_failure)
    -+				break;
    -+			die(_("Unable to rebase '%s' in submodule path '%s'"),
    ++			die_message(_("Unable to rebase '%s' in submodule path '%s'"),
     +			    oid, ud->displaypath);
      			break;
      		case SM_UPDATE_MERGE:
     -			printf(_("Unable to merge '%s' in submodule path '%s'"),
     -			       oid, ud->displaypath);
    -+			if (!must_die_on_failure)
    -+				break;
    -+			die(_("Unable to merge '%s' in submodule path '%s'"),
    ++			die_message(_("Unable to merge '%s' in submodule path '%s'"),
     +			    oid, ud->displaypath);
      			break;
      		case SM_UPDATE_COMMAND:
     -			printf(_("Execution of '%s %s' failed in submodule path '%s'"),
     -			       ud->update_strategy.command, oid, ud->displaypath);
    -+			if (!must_die_on_failure)
    -+				break;
    -+			die(_("Execution of '%s %s' failed in submodule path '%s'"),
    -+			    strategy.command, oid, ud->displaypath);
    ++			die_message(_("Execution of '%s %s' failed in submodule path '%s'"=
),
    ++			    ud->update_strategy.command, oid, ud->displaypath);
      			break;
      		default:
      			BUG("unexpected update strategy type: %s",
    --			    submodule_strategy_to_string(&ud->update_strategy));
    -+			    submodule_strategy_to_string(&strategy));
    + 			    submodule_strategy_to_string(&ud->update_strategy));
      		}
     -		/*
     -		 * NEEDSWORK: We are currently printing to stdout with error
    @@ builtin/submodule--helper.c: static int run_update_command(struct up=
date_data *u
     -		 * properly. Once we start handling the error messages within
     -		 * C, we should use die() instead.
     -		 */
    --		if (must_die_on_failure)
    + 		if (must_die_on_failure)
     -			return 2;
     -		/*
     -		 * This signifies to the caller in shell that the command
     -		 * failed without dying
     -		 */
    ++			exit(128);
     +
     +		/* the command failed, but update must continue */
      		return 1;
      	}
     =20
    --	switch (ud->update_strategy.type) {
     +	if (ud->quiet)
     +		return 0;
     +
    -+	switch (strategy.type) {
    + 	switch (ud->update_strategy.type) {
      	case SM_UPDATE_CHECKOUT:
      		printf(_("Submodule path '%s': checked out '%s'\n"),
    - 		       ud->displaypath, oid);
     @@ builtin/submodule--helper.c: static int run_update_command(struct u=
pdate_data *ud, int subforce)
    - 		break;
    - 	case SM_UPDATE_COMMAND:
    - 		printf(_("Submodule path '%s': '%s %s'\n"),
    --		       ud->displaypath, ud->update_strategy.command, oid);
    -+		       ud->displaypath, strategy.command, oid);
    - 		break;
    - 	default:
    - 		BUG("unexpected update strategy type: %s",
    --		    submodule_strategy_to_string(&ud->update_strategy));
    -+		    submodule_strategy_to_string(&strategy));
    - 	}
    -=20
      	return 0;
      }
     =20
    @@ builtin/submodule--helper.c: static int do_run_update_procedure(stru=
ct update_da
     -static int update_submodule2(struct update_data *update_data);
     -static int run_update_procedure(int argc, const char **argv, const ch=
ar *prefix)
     -{
    --	char *prefixed_path, *update =3D NULL;
     -	struct update_data opt =3D UPDATE_DATA_INIT;
     -
     -	struct option options[] =3D {
    @@ builtin/submodule--helper.c: static int do_run_update_procedure(stru=
ct update_da
     -		OPT_BOOL(0, "just-cloned", &opt.just_cloned,
     -			 N_("overrides update mode in case the repository is a fresh clone=
")),
     -		OPT_INTEGER(0, "depth", &opt.depth, N_("depth for shallow fetch")),
    --		OPT_STRING(0, "prefix", &prefix,
    +-		OPT_STRING(0, "prefix", &opt.prefix,
     -			   N_("path"),
     -			   N_("path into the working tree")),
    --		OPT_STRING(0, "update", &update,
    +-		OPT_STRING(0, "update", &opt.update_default,
     -			   N_("string"),
     -			   N_("rebase, merge, checkout or none")),
     -		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix, N_("path")=
,
    @@ builtin/submodule--helper.c: static int do_run_update_procedure(stru=
ct update_da
     -
     -	opt.sm_path =3D argv[0];
     -
    --	if (opt.recursive_prefix)
    --		prefixed_path =3D xstrfmt("%s%s", opt.recursive_prefix, opt.sm_path=
);
    --	else
    --		prefixed_path =3D xstrdup(opt.sm_path);
    --
    --	opt.displaypath =3D get_submodule_displaypath(prefixed_path, prefix)=
;
    --
    --	determine_submodule_update_strategy(the_repository, opt.just_cloned,
    --					    opt.sm_path, update,
    --					    &opt.update_strategy);
    --
    --	free(prefixed_path);
     -	return update_submodule2(&opt);
     -}
     -
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, =
const char *
     -static int update_submodule2(struct update_data *update_data)
     +static void update_data_to_args(struct update_data *update_data, stru=
ct strvec *args)
     +{
    -+	const char *update =3D submodule_strategy_to_string(&update_data->up=
date_strategy);
    -+
     +	strvec_pushl(args, "submodule--helper", "update", "--recursive", NUL=
L);
     +	strvec_pushf(args, "--jobs=3D%d", update_data->max_jobs);
    ++	/*
    ++	 * NEEDSWORK: the equivalent code in git-submodule.sh does not
    ++	 * pass --prefix, so this shouldn't either
    ++	*/
     +	if (update_data->prefix)
     +		strvec_pushl(args, "--prefix", update_data->prefix, NULL);
     +	if (update_data->recursive_prefix)
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, =
const char *
     +		strvec_push(args, "--require-init");
     +	if (update_data->depth)
     +		strvec_pushf(args, "--depth=3D%d", update_data->depth);
    -+	if (update)
    -+		strvec_pushl(args, "--update", update, NULL);
    ++	if (update_data->update_default)
    ++		strvec_pushl(args, "--update", update_data->update_default, NULL);
     +	if (update_data->references.nr) {
     +		struct string_list_item *item;
     +		for_each_string_list_item(item, &update_data->references)
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, =
const char *
     +
     +static int update_submodule(struct update_data *update_data)
      {
    -+	char *prefixed_path;
    -+
    - 	ensure_core_worktree(update_data->sm_path);
    + 	char *prefixed_path;
     =20
    -+	if (update_data->recursive_prefix)
    -+		prefixed_path =3D xstrfmt("%s%s", update_data->recursive_prefix,
    -+					update_data->sm_path);
    -+	else
    -+		prefixed_path =3D xstrdup(update_data->sm_path);
    -+
    -+	update_data->displaypath =3D get_submodule_displaypath(prefixed_path=
,
    -+							     update_data->prefix);
    -+	free(prefixed_path);
    -+
    - 	/* NEEDSWORK: fix the style issues e.g. braces */
    - 	if (update_data->just_cloned) {
    - 		oidcpy(&update_data->suboid, null_oid());
     @@ builtin/submodule--helper.c: static int update_submodule2(struct up=
date_data *update_data)
      	}
     =20
    @@ builtin/submodule--helper.c: static int update_submodule2(struct upd=
ate_data *up
     -		return do_run_update_procedure(update_data);
     +		if (run_update_procedure(update_data))
     +			return 1;
    -=20
    --	return 3;
    ++
     +	if (update_data->recursive) {
     +		struct child_process cp =3D CHILD_PROCESS_INIT;
     +		struct update_data next =3D *update_data;
    @@ builtin/submodule--helper.c: static int update_submodule2(struct upd=
ate_data *up
     +		cp.git_cmd =3D 1;
     +		prepare_submodule_repo_env(&cp.env_array);
     +		update_data_to_args(&next, &cp.args);
    -+
    +=20
    +-	return 3;
     +		/* die() if child process die()'d */
     +		res =3D run_command(&cp);
     +		if (!res)
    @@ builtin/submodule--helper.c: static int update_submodules(struct sub=
module_updat
     -static int update_clone(int argc, const char **argv, const char *pref=
ix)
     +static int module_update(int argc, const char **argv, const char *pre=
fix)
      {
    - 	const char *update =3D NULL;
    +-	const char *update =3D NULL;
      	struct pathspec pathspec;
     -	struct submodule_update_clone opt =3D SUBMODULE_UPDATE_CLONE_INIT;
     +	struct update_data opt =3D UPDATE_DATA_INIT;
    @@ builtin/submodule--helper.c: static int update_submodules(struct sub=
module_updat
      			   N_("path"),
      			   N_("path into the working tree")),
      		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix,
    -@@ builtin/submodule--helper.c: static int update_clone(int argc, cons=
t char **argv, const char *prefix)
    + 			   N_("path"),
    + 			   N_("path into the working tree, across nested "
    + 			      "submodule boundaries")),
    +-		OPT_STRING(0, "update", &update,
    ++		OPT_STRING(0, "update", &opt.update_default,
      			   N_("string"),
      			   N_("rebase, merge, checkout or none")),
      		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
    @@ builtin/submodule--helper.c: static int update_clone(int argc, const=
 char **argv
     +	oidcpy(&opt.oid, null_oid());
     +	oidcpy(&opt.suboid, null_oid());
     =20
    - 	if (update)
    +-	if (update)
     -		if (parse_submodule_update_strategy(update, &opt.update) < 0)
    -+		if (parse_submodule_update_strategy(update,
    ++	if (opt.update_default)
    ++		if (parse_submodule_update_strategy(opt.update_default,
     +						    &opt.update_strategy) < 0)
      			die(_("bad value for update parameter"));
     =20
    @@ builtin/submodule--helper.c: static struct cmd_struct commands[] =3D=
 {
      	{"init", module_init, SUPPORT_SUPER_PREFIX},
    =20
      ## git-submodule.sh ##
    +@@ git-submodule.sh: single_branch=3D
    + jobs=3D
    + recommend_shallow=3D
    +=20
    ++# NEEDSWORK this is now unused
    + die_if_unmatched ()
    + {
    + 	if test "$1" =3D "#unmatched"
     @@ git-submodule.sh: cmd_update()
      		shift
      	done
     =20
     -	{
     -	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update-clone \
    ++	# NEEDSWORK --super-prefix isn't actually supported by this
    ++	# command - we just pass the $prefix to --recursive-prefix.
     +	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"=
} submodule--helper update \
      		${GIT_QUIET:+--quiet} \
     -		${progress:+"--progress"} \
 -:  ---------- > 18:  9d0afc60ec fixup! submodule--helper run-update-proce=
dure: remove --suboid
 -:  ---------- > 19:  e700861239 fixup! submodule--helper run-update-proce=
dure: learn --remote
 -:  ---------- > 20:  aef1a03b44 fixup! submodule: move core cmd_update() =
logic to C

base-commit: b23dac905bde28da47543484320db16312c87551
--=20
2.33.GIT

