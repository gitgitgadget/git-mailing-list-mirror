Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2334BC433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 08:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350439AbiBHIkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350328AbiBHIj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 03:39:59 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EACC03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 00:39:57 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id y3-20020a1709029b8300b0014c8bcb70a1so7065254plp.3
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 00:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=mAp1OJ3d4spElJIapNvxK1rC9JvnwAFGbFU42XmQiDY=;
        b=PqUkFXayqbn7RWdkqyLHd5b/+8JBdklkbcSoPDTRo59Em7toYbJQH4wKX/EKJNEuFb
         0xpFZA2+a9BkLTrbTNVyRfWDYDVqagEY0G+vSSgWEJnogqA9MyI4zken6TaKayV6t7ab
         YccYvfL8uAoJCKdcpQuzs65HYY+2U2Ytg+rny+XWTjqBeM4eB5ufFoyc3ZgLLRxQLKSL
         W8uxm/tv9Fo/u6Y0O/OCPLzvtUtYAX+MXBvGNTvVoiBD8qgJZFy0ad0Krw1xepngNyqi
         /s9hUo+3xYCjWJ2W87IlKsXxApjYf2vkE18Z732ueMUW7WSfDLyb46k0kBnPEM5Ci+yN
         leow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=mAp1OJ3d4spElJIapNvxK1rC9JvnwAFGbFU42XmQiDY=;
        b=Foxamn1deSO1HvG4WsNzAv3nGtPwhqKfzFfPpaZDfnDlH4svJNKtQI1UuQnH8pPdxh
         CPKRCV9sgdqOeuUTJ6hCv8Dx3DoRwmfzS8nlfcgQ06m5m+JouENPDVX62UFoPVPnBwgS
         pFoLwpxRf9zPL8KpUB2S22c7fviHxY/fw229rHk80oF0Rgri4rbhCVFTpHE/hEnQf8b8
         b/pNGnnHHfHa1+G3BRdKREeJhiHtZYVoauKUDBKBZW7AY5uTFChSbenQjHAMqFs7QaME
         nVUUug16Ga8xmBU0PSsugajGVp03TBK+4+rVA5EIlUEDidcA4fZjNYE+KGNFhjynzPi3
         MEGQ==
X-Gm-Message-State: AOAM5331nb9FkgK8DQSPbJbF9kGk0T2GBApW4x48TNP4LD6NWVS7ezTq
        jelX/ZO3prRQuw9KQGiHwW+7fVZqfFxdnHjqs+73xN8cEAkWXPU05mwn7PcCCScwJeKBxJJrOsb
        jMH0kYlbKZ8+2h7DcP/v2DYt+w6QaX2CrbKSS3Kim7R3qQowJ+z/vZeP4pKBWFYU=
X-Google-Smtp-Source: ABdhPJxj/tTc+hDH50OYIPn4kY/FKcMUnGt250VmaU/4Q5m+9rVWTQEiodsEM/94UmiAQAth694A+kvfLuZhTA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:98:: with SMTP id
 bb24mr134689pjb.175.1644309596751; Tue, 08 Feb 2022 00:39:56 -0800 (PST)
Date:   Tue,  8 Feb 2022 16:39:36 +0800
In-Reply-To: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
Message-Id: <20220208083952.35036-1-chooglen@google.com>
Mime-Version: 1.0
References: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 00/16] submodule: convert the rest of 'update' to C
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

Here is a split-up of the last patch as I promised :) The intent was to
minimize the diff vs v5 instead of getting to a perfect end state; this
will almost certainly need a reroll.

This split-up isn't as complete as I had hoped - the last patch is still
rather large, but breaking that up already took more time than
everything else combined, and I think this organization is already
easier to review than v5. I'd appreciate any suggestions on how this
could be done [1] :) If inspiration strikes, I'll break it up further in
a reroll, but as of right now, I'm out of ideas.

I did some minimal review of the implementation, but I plan to do more
after sending this to the list e.g. I have not revisited the earlier
preparatory patches to see if my patches make sense with them. Where I
found issues, I left NEEDSWORK comments instead of fixing them because
the result would be easier to diff with v5 (the only differences between
this tree and v5's is the NEEDSWORK comments). I plan to fix
implementation issues (once we've spotted them in reivew) and the
NEEDSWORKs in the next reroll.

Let me know if the trailers make sense - this is my first time reworking
someone else's changes, so I don't think I did a perfect job at
attributing work. I also had to fiddle with the Signed-off-by to make
them resemble the v5 patches' Signed-off-by (ar/submodule-update seemed
to order them differently from v5, I'm not sure why).

[1] The difficulty in the last patch comes from the fact that we have
the --recursive flag handling in shell, and we are piping update-clone
into {run-update-procedure + --recursive flag handling}. Because of how
"git submodule" parses args, it is tricky to implement --recursive
without bypassing "git submodule" with "git submodule--helper update"
(the final patch does this bypass). On the other hand, it's difficult to
leave --recursive for last, because we would need to mimic the piping
and exiting behavior around update-clone and run-update-procedure.

Changes in v6:
- Split up last patch of v5 into patches 9-16.
- Patches 9-10 are preparatory work on submodule--helper.c.
- Patches 11-14 contain sh -> c conversions of the git-submodule.sh code
  surrounding update-clone and run-update-procedure.
- Patch 15 moves functions around in order to shrink patch 16's diff
  - If reviewers prefer, we could choose _not_ to move the functions
    around. If so, we can drop patch 15.
- Patch 16 introduces "submodule--helper update". Change the commit
  message to drop references to work done in previous patches.
- Add NEEDSWORK comments for potential issues. These will be cleaned up
  in the next version.

Atharva Raykar (6):
  submodule--helper: get remote names from any repository
  submodule--helper: refactor get_submodule_displaypath()
  submodule--helper: allow setting superprefix for init_submodule()
  submodule--helper: run update using child process struct
  builtin/submodule--helper.c: reformat designated initializers
  submodule: move core cmd_update() logic to C

Glen Choo (7):
  submodule--helper: remove update-module-mode
  submodule--helper: reorganize code for sh to C conversion
  submodule--helper run-update-procedure: remove --suboid
  submodule--helper run-update-procedure: learn --remote
  submodule--helper: remove ensure-core-worktree
  submodule--helper update-clone: learn --init
  submodule--helper: move functions around

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
  builtin/submodule--helper.c: rename option variables to "opt"
  submodule--helper: don't use bitfield indirection for parse_options()
  submodule tests: test for init and update failure output

 builtin/submodule--helper.c    | 709 +++++++++++++++++++--------------
 git-submodule.sh               | 145 +------
 t/t7406-submodule-update.sh    |  14 +-
 t/t7408-submodule-reference.sh |  14 +-
 4 files changed, 447 insertions(+), 435 deletions(-)

Range-diff against v5:
 1:  b45e49810a =3D  1:  86ffb53742 submodule--helper: get remote names fro=
m any repository
 2:  8974329fc5 =3D  2:  2a40266b7a submodule--helper: refactor get_submodu=
le_displaypath()
 3:  bd92e00c05 =3D  3:  cd851c8eb5 submodule--helper: allow setting superp=
refix for init_submodule()
 4:  909cb60cd4 =3D  4:  bfe5cad136 submodule--helper: run update using chi=
ld process struct
 5:  36575b2f25 =3D  5:  72c257fdbf builtin/submodule--helper.c: reformat d=
esignated initializers
 6:  a743003e09 =3D  6:  4b5f703fde builtin/submodule--helper.c: rename opt=
ion variables to "opt"
 7:  3a449d00b9 =3D  7:  f1d21f5b1c submodule--helper: don't use bitfield i=
ndirection for parse_options()
 8:  7da45dde67 =3D  8:  9d32a73fc3 submodule tests: test for init and upda=
te failure output
 -:  ---------- >  9:  087bf43aba submodule--helper: remove update-module-m=
ode
 -:  ---------- > 10:  4eb2893a19 submodule--helper: reorganize code for sh=
 to C conversion
 -:  ---------- > 11:  c08e7781e3 submodule--helper run-update-procedure: r=
emove --suboid
 -:  ---------- > 12:  2419c37184 submodule--helper run-update-procedure: l=
earn --remote
 -:  ---------- > 13:  6691fd3648 submodule--helper: remove ensure-core-wor=
ktree
 -:  ---------- > 14:  d2c9c356e9 submodule--helper update-clone: learn --i=
nit
 -:  ---------- > 15:  a5cde5e084 submodule--helper: move functions around
 9:  251a0b4241 ! 16:  f0551a37e5 submodule: move core cmd_update() logic t=
o C
    @@ Commit message
         `submodule--helper update`, with a modified `--recursive-prefix` a=
nd
         `--prefix` parameter.
    =20
    -    We also introduce `update_submodules2()` and `update_submodule2()`
    -    which will supersede `update_submodules()` and `update_submodule()=
`.
    -
    -    When the `--init` flag is passed to the subcommand, we do not spaw=
n a
    -    new subprocess and call `submodule--helper init` on the submodule =
paths,
    -    because the Git machinery is not able to pick up the configuration
    -    changes introduced by that init call[1]. So we instead run the
    -    `init_submodule_cb()` callback over each submodule in the same pro=
cess.
    -
    -    While we are at it, we also remove the fetch_in_submodule() shell
    -    function since it is no longer used anywhere.
    -
    -    [1] https://lore.kernel.org/git/CAP8UFD0NCQ5w_3GtT_xHr35i7h8BuLX4U=
cHNY6VHPGREmDVObA@mail.gmail.com/
    -
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: Shourya Shukla <periperidip@gmail.com>
         Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
         Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Glen Choo <chooglen@google.com>
    =20
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static char *get_default_remote(void)
    - 	return repo_get_default_remote(the_repository);
    - }
    -=20
    --static int print_default_remote(int argc, const char **argv, const ch=
ar *prefix)
    --{
    --	char *remote;
    --
    --	if (argc !=3D 1)
    --		die(_("submodule--helper print-default-remote takes no arguments"))=
;
    --
    --	remote =3D get_default_remote();
    --	if (remote)
    --		printf("%s\n", remote);
    --
    --	free(remote);
    --	return 0;
    --}
    --
    - static int starts_with_dot_slash(const char *str)
    - {
    - 	return str[0] =3D=3D '.' && is_dir_sep(str[1]);
    -@@ builtin/submodule--helper.c: static void determine_submodule_update=
_strategy(struct repository *r,
    - 	free(key);
    - }
    -=20
    --static int module_update_module_mode(int argc, const char **argv, con=
st char *prefix)
    --{
    --	const char *path, *update =3D NULL;
    --	int just_cloned;
    --	struct submodule_update_strategy update_strategy =3D { .type =3D SM_=
UPDATE_CHECKOUT };
    --
    --	if (argc < 3 || argc > 4)
    --		die("submodule--helper update-module-clone expects <just-cloned> <p=
ath> [<update>]");
    --
    --	just_cloned =3D git_config_int("just_cloned", argv[1]);
    --	path =3D argv[2];
    --
    --	if (argc =3D=3D 4)
    --		update =3D argv[3];
    --
    --	determine_submodule_update_strategy(the_repository,
    --					    just_cloned, path, update,
    --					    &update_strategy);
    --	fputs(submodule_strategy_to_string(&update_strategy), stdout);
    --
    --	return 0;
    --}
    --
    - struct update_clone_data {
    - 	const struct submodule *sub;
    - 	struct object_id oid;
     @@ builtin/submodule--helper.c: struct submodule_update_clone {
      	const char *prefix;
      	int single_branch;
    @@ builtin/submodule--helper.c: struct submodule_update_clone {
      	struct update_clone_data *update_clone;
      	int update_clone_nr; int update_clone_alloc;
     =20
    +@@ builtin/submodule--helper.c: struct submodule_update_clone {
    + 	int failed_clones_nr, failed_clones_alloc;
    +=20
    + 	int max_jobs;
    +-	unsigned int init;
    + };
    + #define SUBMODULE_UPDATE_CLONE_INIT { \
    + 	.list =3D MODULE_LIST_INIT, \
     @@ builtin/submodule--helper.c: struct submodule_update_clone {
      }
     =20
    @@ builtin/submodule--helper.c: struct update_data {
      	unsigned int quiet;
      	unsigned int nofetch;
      	unsigned int just_cloned;
    -+	unsigned int remote;
    + 	unsigned int remote;
     +	unsigned int recursive;
     +	unsigned int progress;
     +	unsigned int dissociate;
    @@ builtin/submodule--helper.c: static int run_update_command(struct up=
date_data *u
      	char *oid =3D oid_to_hex(&ud->oid);
      	int must_die_on_failure =3D 0;
     +	struct submodule_update_strategy strategy =3D SUBMODULE_UPDATE_STRAT=
EGY_INIT;
    -=20
    --	switch (ud->update_strategy.type) {
    ++
     +	if (ud->update_strategy.type =3D=3D SM_UPDATE_UNSPECIFIED || ud->jus=
t_cloned)
     +		determine_submodule_update_strategy(the_repository, ud->just_cloned=
,
     +						    ud->sm_path, NULL, &strategy);
     +	else
     +		strategy =3D ud->update_strategy;
    -+
    +=20
    +-	switch (ud->update_strategy.type) {
     +	switch (strategy.type) {
      	case SM_UPDATE_CHECKOUT:
      		cp.git_cmd =3D 1;
    @@ builtin/submodule--helper.c: static int do_run_update_procedure(stru=
ct update_da
     -		ucd->sub->path);
     -}
     -
    --static int update_submodules(struct submodule_update_clone *suc)
    --{
    --	int i;
    --
    --	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task=
,
    --				   update_clone_start_failure,
    --				   update_clone_task_finished, suc, "submodule",
    --				   "parallel/update");
    --
    --	/*
    --	 * We saved the output and put it out all at once now.
    --	 * That means:
    --	 * - the listener does not have to interleave their (checkout)
    --	 *   work with our fetching.  The writes involved in a
    --	 *   checkout involve more straightforward sequential I/O.
    --	 * - the listener can avoid doing any work if fetching failed.
    --	 */
    --	if (suc->quickstop)
    --		return 1;
    --
    --	for (i =3D 0; i < suc->update_clone_nr; i++)
    --		update_submodule(&suc->update_clone[i]);
    --
    --	return 0;
    --}
    --
    --static int update_clone(int argc, const char **argv, const char *pref=
ix)
    --{
    --	const char *update =3D NULL;
    --	struct pathspec pathspec;
    --	struct submodule_update_clone opt =3D SUBMODULE_UPDATE_CLONE_INIT;
    --
    --	struct option module_update_clone_options[] =3D {
    --		OPT_STRING(0, "prefix", &prefix,
    --			   N_("path"),
    --			   N_("path into the working tree")),
    --		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix,
    --			   N_("path"),
    --			   N_("path into the working tree, across nested "
    --			      "submodule boundaries")),
    --		OPT_STRING(0, "update", &update,
    --			   N_("string"),
    --			   N_("rebase, merge, checkout or none")),
    --		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
    --			   N_("reference repository")),
    --		OPT_BOOL(0, "dissociate", &opt.dissociate,
    --			   N_("use --reference only while cloning")),
    --		OPT_STRING(0, "depth", &opt.depth, "<depth>",
    --			   N_("create a shallow clone truncated to the "
    --			      "specified number of revisions")),
    --		OPT_INTEGER('j', "jobs", &opt.max_jobs,
    --			    N_("parallel jobs")),
    --		OPT_BOOL(0, "recommend-shallow", &opt.recommend_shallow,
    --			    N_("whether the initial clone should follow the shallow recomm=
endation")),
    --		OPT__QUIET(&opt.quiet, N_("don't print cloning progress")),
    --		OPT_BOOL(0, "progress", &opt.progress,
    --			    N_("force cloning progress")),
    --		OPT_BOOL(0, "require-init", &opt.require_init,
    --			   N_("disallow cloning into non-empty directory")),
    --		OPT_BOOL(0, "single-branch", &opt.single_branch,
    --			 N_("clone only one branch, HEAD or --branch")),
    --		OPT_END()
    --	};
    --
    --	const char *const git_submodule_helper_usage[] =3D {
    --		N_("git submodule--helper update-clone [--prefix=3D<path>] [<path>.=
..]"),
    --		NULL
    --	};
    --	opt.prefix =3D prefix;
    --
    --	update_clone_config_from_gitmodules(&opt.max_jobs);
    --	git_config(git_update_clone_config, &opt.max_jobs);
    --
    --	argc =3D parse_options(argc, argv, prefix, module_update_clone_optio=
ns,
    --			     git_submodule_helper_usage, 0);
    --
    --	if (update)
    --		if (parse_submodule_update_strategy(update, &opt.update) < 0)
    --			die(_("bad value for update parameter"));
    --
    --	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < =
0)
    --		return 1;
    --
    --	if (pathspec.nr)
    --		opt.warn_if_uninitialized =3D 1;
    --
    --	return update_submodules(&opt);
    --}
    --
    +-/*
    +- * NEEDSWORK: Use a forward declaration to avoid moving
    +- * run_update_procedure() (which will be removed soon).
    +- */
    +-static int update_submodule2(struct update_data *update_data);
     -static int run_update_procedure(int argc, const char **argv, const ch=
ar *prefix)
     -{
     -	char *prefixed_path, *update =3D NULL;
    @@ builtin/submodule--helper.c: static int do_run_update_procedure(stru=
ct update_da
     -		OPT_CALLBACK_F(0, "oid", &opt.oid, N_("sha1"),
     -			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
     -			       parse_opt_object_id),
    --		OPT_CALLBACK_F(0, "suboid", &opt.suboid, N_("subsha1"),
    --			       N_("SHA1 of submodule's HEAD"), PARSE_OPT_NONEG,
    --			       parse_opt_object_id),
    +-		OPT_BOOL(0, "remote", &opt.remote,
    +-			 N_("use SHA-1 of submodule's remote tracking branch")),
     -		OPT_END()
     -	};
     -
    @@ builtin/submodule--helper.c: static int do_run_update_procedure(stru=
ct update_da
     -					    &opt.update_strategy);
     -
     -	free(prefixed_path);
    --
    --	if (!oideq(&opt.oid, &opt.suboid) || opt.force)
    --		return do_run_update_procedure(&opt);
    --
    --	return 3;
    +-	return update_submodule2(&opt);
     -}
     -
     -static int resolve_relative_path(int argc, const char **argv, const c=
har *prefix)
    @@ builtin/submodule--helper.c: static int do_run_update_procedure(stru=
ct update_da
      static const char *remote_submodule_branch(const char *path)
      {
      	const struct submodule *sub;
    -@@ builtin/submodule--helper.c: static int push_check(int argc, const =
char **argv, const char *prefix)
    - 	return 0;
    - }
    -=20
    --static int ensure_core_worktree(int argc, const char **argv, const ch=
ar *prefix)
    -+static void ensure_core_worktree(const char *path)
    - {
    --	const char *path;
    - 	const char *cw;
    - 	struct repository subrepo;
    -=20
    --	if (argc !=3D 2)
    --		BUG("submodule--helper ensure-core-worktree <path>");
    --
    --	path =3D argv[1];
    --
    - 	if (repo_submodule_init(&subrepo, the_repository, path, null_oid()))
    - 		die(_("could not get a repository handle for submodule '%s'"), path=
);
    -=20
    -@@ builtin/submodule--helper.c: static int ensure_core_worktree(int ar=
gc, const char **argv, const char *prefix)
    - 		free(abs_path);
    - 		strbuf_release(&sb);
    - 	}
    --
    --	return 0;
    - }
    -=20
    - static int absorb_git_dirs(int argc, const char **argv, const char *p=
refix)
     @@ builtin/submodule--helper.c: static int module_set_branch(int argc,=
 const char **argv, const char *prefix)
      	return !!ret;
      }
     =20
    +-/* NEEDSWORK: this is a temporary name until we delete update_submodu=
le() */
    +-static int update_submodule2(struct update_data *update_data)
     +static void update_data_to_args(struct update_data *update_data, stru=
ct strvec *args)
     +{
     +	const char *update =3D submodule_strategy_to_string(&update_data->up=
date_strategy);
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, =
const char *
     +}
     +
     +static int update_submodule(struct update_data *update_data)
    -+{
    + {
     +	char *prefixed_path;
     +
    -+	ensure_core_worktree(update_data->sm_path);
    -+
    + 	ensure_core_worktree(update_data->sm_path);
    +=20
     +	if (update_data->recursive_prefix)
     +		prefixed_path =3D xstrfmt("%s%s", update_data->recursive_prefix,
     +					update_data->sm_path);
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, =
const char *
     +							     update_data->prefix);
     +	free(prefixed_path);
     +
    -+	if (update_data->just_cloned) {
    -+		oidcpy(&update_data->suboid, null_oid());
    -+	} else {
    -+		if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data-=
>suboid))
    -+			die(_("Unable to find current revision in submodule path '%s'"),
    -+			    update_data->displaypath);
    -+	}
    -+
    -+	if (update_data->remote) {
    -+		char *remote_name =3D get_default_remote_submodule(update_data->sm_=
path);
    -+		const char *branch =3D remote_submodule_branch(update_data->sm_path=
);
    -+		char *remote_ref =3D xstrfmt("refs/remotes/%s/%s", remote_name, bra=
nch);
    -+
    -+		if (!update_data->nofetch) {
    -+			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
    -+					      0, NULL))
    -+				die(_("Unable to fetch in submodule path '%s'"),
    -+				    update_data->sm_path);
    -+		}
    -+
    -+		if (resolve_gitlink_ref(update_data->sm_path, remote_ref, &update_d=
ata->oid))
    -+			die(_("Unable to find %s revision in submodule path '%s'"),
    -+			    remote_ref, update_data->sm_path);
    -+
    -+		free(remote_ref);
    -+	}
    -+
    -+	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->=
force)
    + 	/* NEEDSWORK: fix the style issues e.g. braces */
    + 	if (update_data->just_cloned) {
    + 		oidcpy(&update_data->suboid, null_oid());
    +@@ builtin/submodule--helper.c: static int update_submodule2(struct up=
date_data *update_data)
    + 	}
    +=20
    + 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->=
force)
    +-		return do_run_update_procedure(update_data);
     +		if (run_update_procedure(update_data))
     +			return 1;
    -+
    +=20
    +-	return 3;
     +	if (update_data->recursive) {
     +		struct child_process cp =3D CHILD_PROCESS_INIT;
     +		struct update_data next =3D *update_data;
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, =
const char *
     +	}
     +
     +	return 0;
    -+}
    -+
    + }
    +=20
    +-static int update_submodules(struct submodule_update_clone *suc)
     +static int update_submodules(struct update_data *update_data)
    -+{
    + {
    +-	int i;
     +	int i, res =3D 0;
     +	struct submodule_update_clone suc =3D SUBMODULE_UPDATE_CLONE_INIT;
    -+
    +=20
    +-	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task=
,
     +	update_clone_from_update_data(&suc, update_data);
     +	run_processes_parallel_tr2(suc.max_jobs, update_clone_get_next_task,
    -+				   update_clone_start_failure,
    + 				   update_clone_start_failure,
    +-				   update_clone_task_finished, suc, "submodule",
     +				   update_clone_task_finished, &suc, "submodule",
    -+				   "parallel/update");
    -+
    -+	/*
    -+	 * We saved the output and put it out all at once now.
    -+	 * That means:
    -+	 * - the listener does not have to interleave their (checkout)
    -+	 *   work with our fetching.  The writes involved in a
    -+	 *   checkout involve more straightforward sequential I/O.
    -+	 * - the listener can avoid doing any work if fetching failed.
    -+	 */
    + 				   "parallel/update");
    +=20
    + 	/*
    +@@ builtin/submodule--helper.c: static int update_submodules(struct su=
bmodule_update_clone *suc)
    + 	 *   checkout involve more straightforward sequential I/O.
    + 	 * - the listener can avoid doing any work if fetching failed.
    + 	 */
    +-	if (suc->quickstop)
    +-		return 1;
     +	if (suc.quickstop) {
     +		res =3D 1;
     +		goto cleanup;
     +	}
    -+
    +=20
    +-	for (i =3D 0; i < suc->update_clone_nr; i++)
    +-		update_submodule(&suc->update_clone[i]);
     +	for (i =3D 0; i < suc.update_clone_nr; i++) {
     +		struct update_clone_data ucd =3D suc.update_clone[i];
    -+
    +=20
    +-	return 0;
     +		oidcpy(&update_data->oid, &ucd.oid);
     +		update_data->just_cloned =3D ucd.just_cloned;
     +		update_data->sm_path =3D ucd.sub->path;
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, =
const char *
     +cleanup:
     +	string_list_clear(&update_data->references, 0);
     +	return res;
    -+}
    -+
    + }
    +=20
    +-static int update_clone(int argc, const char **argv, const char *pref=
ix)
     +static int module_update(int argc, const char **argv, const char *pre=
fix)
    -+{
    -+	const char *update =3D NULL;
    -+	struct pathspec pathspec;
    + {
    + 	const char *update =3D NULL;
    + 	struct pathspec pathspec;
    +-	struct submodule_update_clone opt =3D SUBMODULE_UPDATE_CLONE_INIT;
     +	struct update_data opt =3D UPDATE_DATA_INIT;
    -+
    -+	struct option module_update_clone_options[] =3D {
    +=20
    ++	/* NEEDSWORK: update names and strings */
    + 	struct option module_update_clone_options[] =3D {
     +		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
    -+		OPT_BOOL(0, "init", &opt.init,
    -+			 N_("initialize uninitialized submodules before update")),
    + 		OPT_BOOL(0, "init", &opt.init,
    + 			 N_("initialize uninitialized submodules before update")),
    +-		OPT_STRING(0, "prefix", &prefix,
     +		OPT_BOOL(0, "remote", &opt.remote,
     +			 N_("use SHA-1 of submodule's remote tracking branch")),
     +		OPT_BOOL(0, "recursive", &opt.recursive,
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, =
const char *
     +		OPT_BOOL('N', "no-fetch", &opt.nofetch,
     +			 N_("don't fetch new objects from the remote site")),
     +		OPT_STRING(0, "prefix", &opt.prefix,
    -+			   N_("path"),
    -+			   N_("path into the working tree")),
    -+		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix,
    -+			   N_("path"),
    -+			   N_("path into the working tree, across nested "
    -+			      "submodule boundaries")),
    -+		OPT_STRING(0, "update", &update,
    -+			   N_("string"),
    -+			   N_("rebase, merge, checkout or none")),
    -+		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
    + 			   N_("path"),
    + 			   N_("path into the working tree")),
    + 		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix,
    +@@ builtin/submodule--helper.c: static int update_clone(int argc, cons=
t char **argv, const char *prefix)
    + 			   N_("string"),
    + 			   N_("rebase, merge, checkout or none")),
    + 		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
    +-			   N_("reference repository")),
     +				N_("reference repository")),
    -+		OPT_BOOL(0, "dissociate", &opt.dissociate,
    + 		OPT_BOOL(0, "dissociate", &opt.dissociate,
    +-			   N_("use --reference only while cloning")),
    +-		OPT_STRING(0, "depth", &opt.depth, "<depth>",
    +-			   N_("create a shallow clone truncated to the "
    +-			      "specified number of revisions")),
     +			 N_("use --reference only while cloning")),
     +		OPT_INTEGER(0, "depth", &opt.depth,
     +			    N_("create a shallow clone truncated to the "
     +			       "specified number of revisions")),
    -+		OPT_INTEGER('j', "jobs", &opt.max_jobs,
    -+			    N_("parallel jobs")),
    -+		OPT_BOOL(0, "recommend-shallow", &opt.recommend_shallow,
    + 		OPT_INTEGER('j', "jobs", &opt.max_jobs,
    + 			    N_("parallel jobs")),
    + 		OPT_BOOL(0, "recommend-shallow", &opt.recommend_shallow,
    +-			    N_("whether the initial clone should follow the shallow recomm=
endation")),
     +			 N_("whether the initial clone should follow the shallow recommend=
ation")),
    -+		OPT__QUIET(&opt.quiet, N_("don't print cloning progress")),
    -+		OPT_BOOL(0, "progress", &opt.progress,
    + 		OPT__QUIET(&opt.quiet, N_("don't print cloning progress")),
    + 		OPT_BOOL(0, "progress", &opt.progress,
    +-			    N_("force cloning progress")),
     +			 N_("force cloning progress")),
    -+		OPT_BOOL(0, "require-init", &opt.require_init,
    + 		OPT_BOOL(0, "require-init", &opt.require_init,
    +-			   N_("disallow cloning into non-empty directory")),
     +			 N_("disallow cloning into non-empty directory")),
    -+		OPT_BOOL(0, "single-branch", &opt.single_branch,
    -+			 N_("clone only one branch, HEAD or --branch")),
    -+		OPT_END()
    -+	};
    -+
    -+	const char *const git_submodule_helper_usage[] =3D {
    -+		N_("git submodule--helper update-clone [--prefix=3D<path>] [<path>.=
..]"),
    -+		NULL
    -+	};
    -+
    -+	update_clone_config_from_gitmodules(&opt.max_jobs);
    -+	git_config(git_update_clone_config, &opt.max_jobs);
    -+
    -+	argc =3D parse_options(argc, argv, prefix, module_update_clone_optio=
ns,
    -+			     git_submodule_helper_usage, 0);
    + 		OPT_BOOL(0, "single-branch", &opt.single_branch,
    + 			 N_("clone only one branch, HEAD or --branch")),
    + 		OPT_END()
    +@@ builtin/submodule--helper.c: static int update_clone(int argc, cons=
t char **argv, const char *prefix)
    + 		N_("git submodule--helper update-clone [--prefix=3D<path>] [<path>.=
..]"),
    + 		NULL
    + 	};
    +-	opt.prefix =3D prefix;
    +=20
    + 	update_clone_config_from_gitmodules(&opt.max_jobs);
    + 	git_config(git_update_clone_config, &opt.max_jobs);
    +=20
    + 	argc =3D parse_options(argc, argv, prefix, module_update_clone_optio=
ns,
    + 			     git_submodule_helper_usage, 0);
     +	oidcpy(&opt.oid, null_oid());
     +	oidcpy(&opt.suboid, null_oid());
    -+
    -+	if (update)
    +=20
    + 	if (update)
    +-		if (parse_submodule_update_strategy(update, &opt.update) < 0)
     +		if (parse_submodule_update_strategy(update,
     +						    &opt.update_strategy) < 0)
    -+			die(_("bad value for update parameter"));
    -+
    -+	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < =
0)
    -+		return 1;
    -+
    -+	if (pathspec.nr)
    -+		opt.warn_if_uninitialized =3D 1;
    -+
    -+	if (opt.init) {
    -+		struct module_list list =3D MODULE_LIST_INIT;
    -+		struct init_cb info =3D INIT_CB_INIT;
    -+
    -+		if (module_list_compute(argc, argv, opt.prefix,
    -+					&pathspec, &list) < 0)
    -+			return 1;
    -+
    -+		/*
    -+		 * If there are no path args and submodule.active is set then,
    -+		 * by default, only initialize 'active' modules.
    -+		 */
    -+		if (!argc && git_config_get_value_multi("submodule.active"))
    -+			module_list_active(&list);
    -+
    -+		info.prefix =3D opt.prefix;
    -+		info.superprefix =3D opt.recursive_prefix;
    -+		if (opt.quiet)
    -+			info.flags |=3D OPT_QUIET;
    -+
    -+		for_each_listed_submodule(&list, init_submodule_cb, &info);
    -+	}
    -+
    -+	return update_submodules(&opt);
    -+}
    -+
    - struct add_data {
    - 	const char *prefix;
    - 	const char *branch;
    + 			die(_("bad value for update parameter"));
    +=20
    + 	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < =
0)
     @@ builtin/submodule--helper.c: static struct cmd_struct commands[] =
=3D {
      	{"name", module_name, 0},
      	{"clone", module_clone, 0},
      	{"add", module_add, SUPPORT_SUPER_PREFIX},
    --	{"update-module-mode", module_update_module_mode, 0},
     -	{"update-clone", update_clone, 0},
     -	{"run-update-procedure", run_update_procedure, 0},
    --	{"ensure-core-worktree", ensure_core_worktree, 0},
     -	{"relative-path", resolve_relative_path, 0},
     +	{"update", module_update, 0},
      	{"resolve-relative-url-test", resolve_relative_url_test, 0},
      	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
      	{"init", module_init, SUPPORT_SUPER_PREFIX},
    - 	{"status", module_status, SUPPORT_SUPER_PREFIX},
    --	{"print-default-remote", print_default_remote, 0},
    - 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
    - 	{"deinit", module_deinit, 0},
    - 	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
    =20
      ## git-submodule.sh ##
    -@@ git-submodule.sh: cmd_deinit()
    - 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUI=
ET:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
    - }
    -=20
    --# usage: fetch_in_submodule <module_path> [<depth>] [<sha1>]
    --# Because arguments are positional, use an empty string to omit <dept=
h>
    --# but include <sha1>.
    --fetch_in_submodule () (
    --	sanitize_submodule_env &&
    --	cd "$1" &&
    --	if test $# -eq 3
    --	then
    --		echo "$3" | git fetch ${GIT_QUIET:+--quiet} --stdin ${2:+"$2"}
    --	else
    --		git fetch ${GIT_QUIET:+--quiet} ${2:+"$2"}
    --	fi
    --)
    --
    - #
    - # Update each submodule path to correct revision, using clone and che=
ckout as needed
    - #
     @@ git-submodule.sh: cmd_update()
      		shift
      	done
     =20
    --	if test -n "$init"
    --	then
    --		cmd_init "--" "$@" || return
    --	fi
    --
     -	{
    --	git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
    --		${progress:+"--progress"} \
    +-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update-clone \
     +	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"=
} submodule--helper update \
    -+		${GIT_QUIET:+--quiet} \
    + 		${GIT_QUIET:+--quiet} \
    +-		${progress:+"--progress"} \
     +		${force:+--force} \
     +		${progress:+--progress} \
     +		${dissociate:+--dissociate} \
     +		${remote:+--remote} \
     +		${recursive:+--recursive} \
    -+		${init:+--init} \
    + 		${init:+--init} \
     +		${require_init:+--require-init} \
     +		${nofetch:+--no-fetch} \
      		${wt_prefix:+--prefix "$wt_prefix"} \
    @@ git-submodule.sh: cmd_update()
     -	do
     -		die_if_unmatched "$quickabort" "$sha1"
     -
    --		git submodule--helper ensure-core-worktree "$sm_path" || exit 1
    --
     -		displaypath=3D$(git submodule--helper relative-path "$prefix$sm_pat=
h" "$wt_prefix")
     -
    --		if test $just_cloned -eq 1
    +-		if test $just_cloned -eq 0
     -		then
    --			subsha1=3D
    --		else
     -			just_cloned=3D
    --			subsha1=3D$(sanitize_submodule_env; cd "$sm_path" &&
    --				git rev-parse --verify HEAD) ||
    --			die "fatal: $(eval_gettext "Unable to find current revision in sub=
module path '\$displaypath'")"
    --		fi
    --
    --		if test -n "$remote"
    --		then
    --			branch=3D$(git submodule--helper remote-branch "$sm_path")
    --			if test -z "$nofetch"
    --			then
    --				# Fetch remote before determining tracking $sha1
    --				fetch_in_submodule "$sm_path" $depth ||
    --				die "fatal: $(eval_gettext "Unable to fetch in submodule path '\$=
sm_path'")"
    --			fi
    --			remote_name=3D$(sanitize_submodule_env; cd "$sm_path" && git submo=
dule--helper print-default-remote)
    --			sha1=3D$(sanitize_submodule_env; cd "$sm_path" &&
    --				git rev-parse --verify "${remote_name}/${branch}") ||
    --			die "fatal: $(eval_gettext "Unable to find current \${remote_name}=
/\${branch} revision in submodule path '\$sm_path'")"
     -		fi
     -
     -		out=3D$(git submodule--helper run-update-procedure \
    @@ git-submodule.sh: cmd_update()
     -			  ${update:+--update "$update"} \
     -			  ${prefix:+--recursive-prefix "$prefix"} \
     -			  ${sha1:+--oid "$sha1"} \
    --			  ${subsha1:+--suboid "$subsha1"} \
    +-			  ${remote:+--remote} \
     -			  "--" \
     -			  "$sm_path")
     -

base-commit: b23dac905bde28da47543484320db16312c87551
--=20
2.33.GIT

