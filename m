Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD44C433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 21:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351879AbiCOVLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351868AbiCOVLE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 17:11:04 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767F85B3CC
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:09:50 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id l14-20020a17090a660e00b001bf496be6d0so323920pjj.7
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=h7yIHQJuB0upHSbrZjoVfWkui3M3J0xEzKZu3rUVtmc=;
        b=MtfonZ+FmNIq1LElU2+Xry/tkZ9HJ6Pqc2ZLpv+RmwNmgSyZ/21E51try+j/0WufKi
         iK6KuvQxVfmbdtYyVt10JdPtruvCbroMXxmhTJI/tgoOnGB2vxthrjW/ZCI8Y1g23bPv
         K8c63hkGLXo/FinKmkJ6HqxpqhxqsXkfPYp2p+U/55hLYW6rd6VrnWPwxNZtdWH7Db8A
         PpDh/CiuHvC63WT23vnTbkUhFmeWmhH+GL9XV8OlQ5CjcD1rgvx7N88ZkNBgC4ikc50B
         Fl3FaHzAqNkoVRrl4u58nEmSy3Jjbvysrg6iitStuluAbV7bEceugs+Lb969I0HVjBXu
         VHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=h7yIHQJuB0upHSbrZjoVfWkui3M3J0xEzKZu3rUVtmc=;
        b=qi+rs/hf0hBrr6+EpP7W0dkEsbiRrbcWERRO+EcnBqYWtQvTYHe1b48ouan1eTlxw9
         zUTuAAIS/qMGzdi4LiBmmEAAVLW/jRWpB7pVlJ41Y0TlnkrYxMh5XpQEKrK/7lv98Wy+
         9kkqamao/eIh7n7dvHaAhb1n8N0Wkhh3EONtS5JYs4VaW+OtyqHdo7A1Xi+f9zmkBH+m
         DA5Vz9RZrO/2AFR+BqCGW0B1zBYp6PunjOOIJJG769mFG0PrgNfyHADaAVTWvP/t/91h
         6qoVpmKy3pPIPGMCLVYo5kSXISTyb4Od+GEJcxFg4KWDpvu7N9TJMMm6sdJMcYHfTUtx
         EsNQ==
X-Gm-Message-State: AOAM532+NUMkBHdOVx5k/ljyeTTh9Vixeri2UFHypuiBKoK6/lnXfExG
        FiSbCVDWqwRW8cD75dsfzX6BGX/9m+qSjo2e5wNyByd9wjFUqLbYsXShhImkNhhBG9SE6Mn679c
        93OvAopLy/AUtlXpYSeAz2memp1F4WCs3nnS1ux1kL4MAZweMyoowz7tcZaHPp2I=
X-Google-Smtp-Source: ABdhPJyAgypVkvTUradeO9uh+vOyLayKpx5wZLcE+iRo89LJVMUlLzGUnRyfvirC0zlAaMMIeyEUbjdD6Jysww==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:c94a:b0:151:8e65:c715 with SMTP
 id i10-20020a170902c94a00b001518e65c715mr30150353pla.169.1647378589888; Tue,
 15 Mar 2022 14:09:49 -0700 (PDT)
Date:   Tue, 15 Mar 2022 14:09:24 -0700
In-Reply-To: <20220315210925.79289-1-chooglen@google.com>
Message-Id: <20220315210925.79289-7-chooglen@google.com>
Mime-Version: 1.0
References: <20220315210925.79289-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 6/7] submodule: move core cmd_update() logic to C
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

This patch completes the conversion past the flag parsing of
`submodule update` by introducing a helper subcommand called
`submodule--helper update`. The behaviour of `submodule update` should
remain the same after this patch.

Prior to this patch, `submodule update` was implemented by piping the
output of `update-clone` (which clones all missing submodules, then
prints relevant information for all submodules) into
`run-update-procedure` (which reads the information and updates the
submodule tree).

With `submodule--helper update`, we iterate over the submodules and
update the submodule tree in the same process. This reuses most of
existing code structure, except that `update_submodule()` now updates
the submodule tree (instead of printing submodule information to be
consumed by another process).

Recursing on a submodule is done by calling a subprocess that launches
`submodule--helper update`, with a modified `--recursive-prefix` and
`--prefix` parameter.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
For the curious, the bug that was in ar/submodule-update
(<xmqqr18770pc.fsf@gitster.g>), comes from a typo that caused
`--single-branch` to be set incorrectly in the recursive `update`:

	if (update_data->single_branch >=3D 0)
		strvec_push(args, "--single-branch");

This has been corrected to:

	if (update_data->single_branch >=3D 0)
		strvec_push(args, update_data->single_branch ?
				    "--single-branch" :
				    "--no-single-branch");

(-1 means "--[no-]single-branch" was not specified)

t3207 only failed because of a second-order effect - the test sets up
tracking based on the remote's "fetch" refspec, but `--single-branch`
caused the wrong refspec to be written. This might suggest that more
direct tests of recursive `update` are needed.

 builtin/submodule--helper.c | 229 +++++++++++++++++++-----------------
 git-submodule.sh            | 104 ++--------------
 2 files changed, 131 insertions(+), 202 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 85f37c4458..842d9ecaa8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1976,7 +1976,7 @@ struct submodule_update_clone {
 	/* configuration parameters which are passed on to the children */
 	struct update_data *update_data;
=20
-	/* to be consumed by git-submodule.sh */
+	/* to be consumed by update_submodule() */
 	struct update_clone_data *update_clone;
 	int update_clone_nr; int update_clone_alloc;
=20
@@ -1992,10 +1992,8 @@ struct submodule_update_clone {
 struct update_data {
 	const char *prefix;
 	const char *recursive_prefix;
-	const char *sm_path;
 	const char *displaypath;
 	const char *update_default;
-	struct object_id oid;
 	struct object_id suboid;
 	struct string_list references;
 	struct submodule_update_strategy update_strategy;
@@ -2009,12 +2007,17 @@ struct update_data {
 	unsigned int force;
 	unsigned int quiet;
 	unsigned int nofetch;
-	unsigned int just_cloned;
 	unsigned int remote;
 	unsigned int progress;
 	unsigned int dissociate;
 	unsigned int init;
 	unsigned int warn_if_uninitialized;
+	unsigned int recursive;
+
+	/* copied over from update_clone_data */
+	struct object_id oid;
+	unsigned int just_cloned;
+	const char *sm_path;
 };
 #define UPDATE_DATA_INIT { \
 	.update_strategy =3D SUBMODULE_UPDATE_STRATEGY_INIT, \
@@ -2419,7 +2422,7 @@ static int run_update_command(struct update_data *ud,=
 int subforce)
 	return 0;
 }
=20
-static int do_run_update_procedure(struct update_data *ud)
+static int run_update_procedure(struct update_data *ud)
 {
 	int subforce =3D is_null_oid(&ud->suboid) || ud->force;
=20
@@ -2449,27 +2452,10 @@ static int do_run_update_procedure(struct update_da=
ta *ud)
 	return run_update_command(ud, subforce);
 }
=20
-/*
- * NEEDSWORK: As we convert "git submodule update" to C,
- * update_submodule2() will invoke more and more functions, making it
- * difficult to preserve the function ordering without forward
- * declarations.
- *
- * When the conversion is complete, this forward declaration will be
- * unnecessary and should be removed.
- */
-static int update_submodule2(struct update_data *update_data);
-static void update_submodule(struct update_clone_data *ucd)
-{
-	fprintf(stdout, "dummy %s %d\t%s\n",
-		oid_to_hex(&ucd->oid),
-		ucd->just_cloned,
-		ucd->sub->path);
-}
-
+static int update_submodule(struct update_data *update_data);
 static int update_submodules(struct update_data *update_data)
 {
-	int i;
+	int i, res =3D 0;
 	struct submodule_update_clone suc =3D SUBMODULE_UPDATE_CLONE_INIT;
=20
 	suc.update_data =3D update_data;
@@ -2486,25 +2472,44 @@ static int update_submodules(struct update_data *up=
date_data)
 	 *   checkout involve more straightforward sequential I/O.
 	 * - the listener can avoid doing any work if fetching failed.
 	 */
-	if (suc.quickstop)
-		return 1;
+	if (suc.quickstop) {
+		res =3D 1;
+		goto cleanup;
+	}
=20
-	for (i =3D 0; i < suc.update_clone_nr; i++)
-		update_submodule(&suc.update_clone[i]);
+	for (i =3D 0; i < suc.update_clone_nr; i++) {
+		struct update_clone_data ucd =3D suc.update_clone[i];
=20
-	return 0;
+		oidcpy(&update_data->oid, &ucd.oid);
+		update_data->just_cloned =3D ucd.just_cloned;
+		update_data->sm_path =3D ucd.sub->path;
+
+		if (update_submodule(update_data))
+			res =3D 1;
+	}
+
+cleanup:
+	string_list_clear(&update_data->references, 0);
+	return res;
 }
=20
-static int update_clone(int argc, const char **argv, const char *prefix)
+static int module_update(int argc, const char **argv, const char *prefix)
 {
 	struct pathspec pathspec;
 	struct update_data opt =3D UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options;
 	int ret;
=20
-	struct option module_update_clone_options[] =3D {
+	struct option module_update_options[] =3D {
+		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
 		OPT_BOOL(0, "init", &opt.init,
 			 N_("initialize uninitialized submodules before update")),
+		OPT_BOOL(0, "remote", &opt.remote,
+			 N_("use SHA-1 of submodule's remote tracking branch")),
+		OPT_BOOL(0, "recursive", &opt.recursive,
+			 N_("traverse submodules recursively")),
+		OPT_BOOL('N', "no-fetch", &opt.nofetch,
+			 N_("don't fetch new objects from the remote site")),
 		OPT_STRING(0, "prefix", &opt.prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
@@ -2551,19 +2556,12 @@ static int update_clone(int argc, const char **argv=
, const char *prefix)
 	git_config(git_update_clone_config, &opt.max_jobs);
=20
 	memset(&filter_options, 0, sizeof(filter_options));
-	argc =3D parse_options(argc, argv, prefix, module_update_clone_options,
+	argc =3D parse_options(argc, argv, prefix, module_update_options,
 			     git_submodule_helper_usage, 0);
=20
 	if (filter_options.choice && !opt.init) {
-		/*
-		 * NEEDSWORK: Don't use usage_with_options() because the
-		 * usage string is for "git submodule update", but the
-		 * options are for "git submodule--helper update-clone".
-		 *
-		 * This will no longer be an issue when "update-clone"
-		 * is replaced by "git submodule--helper update".
-		 */
-		usage(git_submodule_helper_usage[0]);
+		usage_with_options(git_submodule_helper_usage,
+				   module_update_options);
 	}
=20
 	opt.filter_options =3D &filter_options;
@@ -2609,63 +2607,6 @@ static int update_clone(int argc, const char **argv,=
 const char *prefix)
 	return ret;
 }
=20
-static int run_update_procedure(int argc, const char **argv, const char *p=
refix)
-{
-	struct update_data update_data =3D UPDATE_DATA_INIT;
-
-	struct option options[] =3D {
-		OPT__QUIET(&update_data.quiet,
-			   N_("suppress output for update by rebase or merge")),
-		OPT__FORCE(&update_data.force, N_("force checkout updates"),
-			   0),
-		OPT_BOOL('N', "no-fetch", &update_data.nofetch,
-			 N_("don't fetch new objects from the remote site")),
-		OPT_BOOL(0, "just-cloned", &update_data.just_cloned,
-			 N_("overrides update mode in case the repository is a fresh clone")),
-		OPT_INTEGER(0, "depth", &update_data.depth, N_("depth for shallow fetch"=
)),
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("path into the working tree")),
-		OPT_STRING(0, "update", &update_data.update_default,
-			   N_("string"),
-			   N_("rebase, merge, checkout or none")),
-		OPT_STRING(0, "recursive-prefix", &update_data.recursive_prefix, N_("pat=
h"),
-			   N_("path into the working tree, across nested "
-			      "submodule boundaries")),
-		OPT_CALLBACK_F(0, "oid", &update_data.oid, N_("sha1"),
-			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
-			       parse_opt_object_id),
-		OPT_BOOL(0, "remote", &update_data.remote,
-			 N_("use SHA-1 of submodule's remote tracking branch")),
-		OPT_END()
-	};
-
-	const char *const usage[] =3D {
-		N_("git submodule--helper run-update-procedure [<options>] <path>"),
-		NULL
-	};
-
-	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
-
-	if (argc !=3D 1)
-		usage_with_options(usage, options);
-
-	update_data.sm_path =3D argv[0];
-
-	return update_submodule2(&update_data);
-}
-
-static int resolve_relative_path(int argc, const char **argv, const char *=
prefix)
-{
-	struct strbuf sb =3D STRBUF_INIT;
-	if (argc !=3D 3)
-		die("submodule--helper relative-path takes exactly 2 arguments, got %d",=
 argc);
-
-	printf("%s", relative_path(argv[1], argv[2], &sb));
-	strbuf_release(&sb);
-	return 0;
-}
-
 static const char *remote_submodule_branch(const char *path)
 {
 	const struct submodule *sub;
@@ -3028,8 +2969,53 @@ static int module_create_branch(int argc, const char=
 **argv, const char *prefix)
 	return 0;
 }
=20
-/* NEEDSWORK: this is a temporary name until we delete update_submodule() =
*/
-static int update_submodule2(struct update_data *update_data)
+static void update_data_to_args(struct update_data *update_data, struct st=
rvec *args)
+{
+	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
+	strvec_pushf(args, "--jobs=3D%d", update_data->max_jobs);
+	if (update_data->recursive_prefix)
+		strvec_pushl(args, "--recursive-prefix",
+			     update_data->recursive_prefix, NULL);
+	if (update_data->quiet)
+		strvec_push(args, "--quiet");
+	if (update_data->force)
+		strvec_push(args, "--force");
+	if (update_data->init)
+		strvec_push(args, "--init");
+	if (update_data->remote)
+		strvec_push(args, "--remote");
+	if (update_data->nofetch)
+		strvec_push(args, "--no-fetch");
+	if (update_data->dissociate)
+		strvec_push(args, "--dissociate");
+	if (update_data->progress)
+		strvec_push(args, "--progress");
+	if (update_data->require_init)
+		strvec_push(args, "--require-init");
+	if (update_data->depth)
+		strvec_pushf(args, "--depth=3D%d", update_data->depth);
+	if (update_data->update_default)
+		strvec_pushl(args, "--update", update_data->update_default, NULL);
+	if (update_data->references.nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, &update_data->references)
+			strvec_pushl(args, "--reference", item->string, NULL);
+	}
+	if (update_data->filter_options && update_data->filter_options->choice)
+		strvec_pushf(args, "--filter=3D%s",
+				expand_list_objects_filter_spec(
+					update_data->filter_options));
+	if (update_data->recommend_shallow =3D=3D 0)
+		strvec_push(args, "--no-recommend-shallow");
+	else if (update_data->recommend_shallow =3D=3D 1)
+		strvec_push(args, "--recommend-shallow");
+	if (update_data->single_branch >=3D 0)
+		strvec_push(args, update_data->single_branch ?
+				    "--single-branch" :
+				    "--no-single-branch");
+}
+
+static int update_submodule(struct update_data *update_data)
 {
 	char *prefixed_path;
=20
@@ -3075,9 +3061,44 @@ static int update_submodule2(struct update_data *upd=
ate_data)
 	}
=20
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force=
)
-		return do_run_update_procedure(update_data);
+		if (run_update_procedure(update_data))
+			return 1;
+
+	if (update_data->recursive) {
+		struct child_process cp =3D CHILD_PROCESS_INIT;
+		struct update_data next =3D *update_data;
+		int res;
+
+		if (update_data->recursive_prefix)
+			prefixed_path =3D xstrfmt("%s%s/", update_data->recursive_prefix,
+						update_data->sm_path);
+		else
+			prefixed_path =3D xstrfmt("%s/", update_data->sm_path);
+
+		next.recursive_prefix =3D get_submodule_displaypath(prefixed_path,
+								  update_data->prefix);
+		next.prefix =3D NULL;
+		oidcpy(&next.oid, null_oid());
+		oidcpy(&next.suboid, null_oid());
+
+		cp.dir =3D update_data->sm_path;
+		cp.git_cmd =3D 1;
+		prepare_submodule_repo_env(&cp.env_array);
+		update_data_to_args(&next, &cp.args);
=20
-	return 3;
+		/* die() if child process die()'d */
+		res =3D run_command(&cp);
+		if (!res)
+			return 0;
+		die_message(_("Failed to recurse into submodule path '%s'"),
+			    update_data->displaypath);
+		if (res =3D=3D 128)
+			exit(res);
+		else if (res)
+			return 1;
+	}
+
+	return 0;
 }
=20
 struct add_data {
@@ -3465,9 +3486,7 @@ static struct cmd_struct commands[] =3D {
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
-	{"update-clone", update_clone, 0},
-	{"run-update-procedure", run_update_procedure, 0},
-	{"relative-path", resolve_relative_path, 0},
+	{"update", module_update, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index b63a2aefa7..fd0b4a2c94 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -51,14 +51,6 @@ jobs=3D
 recommend_shallow=3D
 filter=3D
=20
-die_if_unmatched ()
-{
-	if test "$1" =3D "#unmatched"
-	then
-		exit ${2:-1}
-	fi
-}
-
 isnumber()
 {
 	n=3D$(($1 + 0)) 2>/dev/null && test "$n" =3D "$1"
@@ -356,11 +348,14 @@ cmd_update()
 		shift
 	done
=20
-	{
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update-clone \
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update \
 		${GIT_QUIET:+--quiet} \
+		${force:+--force} \
 		${progress:+"--progress"} \
+		${remote:+--remote} \
+		${recursive:+--recursive} \
 		${init:+--init} \
+		${nofetch:+--no-fetch} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
@@ -368,98 +363,13 @@ cmd_update()
 		${dissociate:+"--dissociate"} \
 		${depth:+"$depth"} \
 		${require_init:+--require-init} \
+		${dissociate:+"--dissociate"} \
 		$single_branch \
 		$recommend_shallow \
 		$jobs \
 		$filter \
 		-- \
-		"$@" || echo "#unmatched" $?
-	} | {
-	err=3D
-	while read -r quickabort sha1 just_cloned sm_path
-	do
-		die_if_unmatched "$quickabort" "$sha1"
-
-		displaypath=3D$(git submodule--helper relative-path "$prefix$sm_path" "$=
wt_prefix")
-
-		if test $just_cloned -eq 0
-		then
-			just_cloned=3D
-		fi
-
-		out=3D$(git submodule--helper run-update-procedure \
-			  ${wt_prefix:+--prefix "$wt_prefix"} \
-			  ${GIT_QUIET:+--quiet} \
-			  ${force:+--force} \
-			  ${just_cloned:+--just-cloned} \
-			  ${nofetch:+--no-fetch} \
-			  ${depth:+"$depth"} \
-			  ${update:+--update "$update"} \
-			  ${prefix:+--recursive-prefix "$prefix"} \
-			  ${sha1:+--oid "$sha1"} \
-			  ${remote:+--remote} \
-			  "--" \
-			  "$sm_path")
-
-		# exit codes for run-update-procedure:
-		# 0: update was successful, say command output
-		# 1: update procedure failed, but should not die
-		# 128: subcommand died during execution
-		# 3: no update procedure was run
-		res=3D"$?"
-		case $res in
-		0)
-			say "$out"
-			;;
-		1)
-			err=3D"${err};$out"
-			continue
-			;;
-		128)
-			printf >&2 "$out"
-			exit $res
-			;;
-		esac
-
-		if test -n "$recursive"
-		then
-			(
-				prefix=3D$(git submodule--helper relative-path "$prefix$sm_path/" "$wt=
_prefix")
-				wt_prefix=3D
-				sanitize_submodule_env
-				cd "$sm_path" &&
-				eval cmd_update
-			)
-			res=3D$?
-			if test $res -gt 0
-			then
-				die_msg=3D"fatal: $(eval_gettext "Failed to recurse into submodule pat=
h '\$displaypath'")"
-				if test $res -ne 2
-				then
-					err=3D"${err};$die_msg"
-					continue
-				else
-					die_with_status $res "$die_msg"
-				fi
-			fi
-		fi
-	done
-
-	if test -n "$err"
-	then
-		OIFS=3D$IFS
-		IFS=3D';'
-		for e in $err
-		do
-			if test -n "$e"
-			then
-				echo >&2 "$e"
-			fi
-		done
-		IFS=3D$OIFS
-		exit 1
-	fi
-	}
+		"$@"
 }
=20
 #
--=20
2.33.GIT

