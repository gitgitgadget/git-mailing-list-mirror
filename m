Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB1EC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbiBJJ3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:29:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbiBJJ30 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:29:26 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B003E10D8
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:25 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t8-20020a259ac8000000b00619a3b5977fso10924691ybo.5
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=GYZji1wInO0NZO6UezqSy7QAaxGLjwdHNA4vsYNZUnw=;
        b=d9Ym2pe3az71obFe/NHTqNckv0bXeqJLVjeKJHJPu7aQ3dJIDeLKQkoQnPgQGbMbr5
         avMKF6uWFx/RGoempaJj7oQsIkdvbHdimiqmYnhQH/iNrKWzKECE2TXQiHfCGkaXvzNS
         AgjD4Du+6qnyV4dWw3FGRme0dMxHRApmZGD2fRJ7BUsYcq/GxfHCGULfQyPWe58mH0AL
         hoBNeem/PWRj61LZyhdvSzXHR9CG9edsyuEpcy3K9jY/keaX4jVZRvz7KZKEMswm0sgl
         YvXdaXZYe4lInNIWUcdJne+V6K0/aih/iwycP5jsHYL91NAEK58rdZqsoYKZtS+yGIXR
         FxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=GYZji1wInO0NZO6UezqSy7QAaxGLjwdHNA4vsYNZUnw=;
        b=yoU0Zr/N1ANLVYPHXroR0XCEsslFElu9RuBXK6mYLitxLD3flOsCwm61dffJHN7EK2
         pDygXCZbrkXYcZU10piwOUcXJQw5gf9HOtP9xpcZHczD6o+6UKYCknZ4vgh4K8uFJlsk
         rcB9wCSfg0ZKiwaUum6FqVorRKmosvzjfQuTMfL0ovVDBbItuv2zfcXqb/SNg3Ajkdho
         4oS9PnZtR8srxHEbB54NLboC7wA83vwfkmLTvcfO6enKGTiAP7oDg9PP98eTPsfhh7gn
         M/2V+IOVR0wI2XlY3zodT+RW/foWi5yIvn7d178Xdsfi1SzRkmLohBLASkl+kHn4dEGd
         a2WQ==
X-Gm-Message-State: AOAM532O+7ryPmn5vgCm5vlS+Had7wJpIo/q9BZ3y2rf94fdYZJdgm4F
        0vMguJ8VczxNYZTGyCwIPNLofumNlADcUNqMLCMh85zV6aCl7gNIoYzR+YnQJ12yXFo+5B5Qfxq
        D5mkxg8mjsqHHMMsXVlBOgSMsaSxAfJqx+ql/HPGbaWzwC/RZzGP3wyI62xPWNiw=
X-Google-Smtp-Source: ABdhPJzgb0o/zgAwmSp5wWxjvcc25vyDFKhEdRJDwgARxOUOuWmXr8zw67apTKL6CRJZ0czoHxM5igyZWDatrw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:a888:: with SMTP id
 f130mr6385732ywh.46.1644485364877; Thu, 10 Feb 2022 01:29:24 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:30 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-18-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 17/20] submodule: move core cmd_update() logic to C
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

From: Atharva Raykar <raykar.ath@gmail.com>

This patch completes the conversion past the flag parsing of
`submodule update` by introducing a helper subcommand called
`submodule--helper update`. The behaviour of `submodule update` should
remain the same after this patch.

We add more fields to the `struct update_data` that are required by
`struct submodule_update_clone` to be able to perform a clone, when that
is needed to be done.

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
 builtin/submodule--helper.c | 312 ++++++++++++++++++++++--------------
 git-submodule.sh            | 105 ++----------
 2 files changed, 201 insertions(+), 216 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ff7ee73e1a..b895e88a64 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1977,7 +1977,6 @@ struct submodule_update_clone {
 	const char *prefix;
 	int single_branch;
=20
-	/* to be consumed by git-submodule.sh */
 	struct update_clone_data *update_clone;
 	int update_clone_nr; int update_clone_alloc;
=20
@@ -1989,7 +1988,6 @@ struct submodule_update_clone {
 	int failed_clones_nr, failed_clones_alloc;
=20
 	int max_jobs;
-	unsigned int init;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT { \
 	.list =3D MODULE_LIST_INIT, \
@@ -2010,14 +2008,54 @@ struct update_data {
 	struct object_id suboid;
 	struct submodule_update_strategy update_strategy;
 	int depth;
+	int recommend_shallow;
+	int single_branch;
+	int max_jobs;
+	unsigned int init;
 	unsigned int force;
 	unsigned int quiet;
 	unsigned int nofetch;
 	unsigned int just_cloned;
 	unsigned int remote;
+	unsigned int recursive;
+	unsigned int progress;
+	unsigned int dissociate;
+	unsigned int require_init;
+	unsigned warn_if_uninitialized ;
+	struct string_list references;
+	struct module_list list;
 };
 #define UPDATE_DATA_INIT { \
+	.list =3D MODULE_LIST_INIT, \
 	.update_strategy =3D SUBMODULE_UPDATE_STRATEGY_INIT, \
+	.recommend_shallow =3D -1, \
+	.references =3D STRING_LIST_INIT_DUP, \
+	.single_branch =3D -1, \
+	.max_jobs =3D 1, \
+}
+
+static void update_clone_from_update_data(struct submodule_update_clone *s=
uc,
+					  struct update_data *update_data)
+{
+	suc->prefix =3D update_data->prefix;
+	suc->recursive_prefix =3D update_data->recursive_prefix;
+	suc->max_jobs =3D update_data->max_jobs;
+	suc->progress =3D update_data->progress;
+	suc->quiet =3D update_data->quiet;
+	suc->dissociate =3D update_data->dissociate;
+	suc->require_init =3D update_data->require_init;
+	suc->single_branch =3D update_data->single_branch;
+	suc->warn_if_uninitialized =3D update_data->warn_if_uninitialized;
+	suc->list =3D update_data->list;
+	suc->update =3D update_data->update_strategy;
+	suc->recommend_shallow =3D update_data->recommend_shallow;
+	if (update_data->depth)
+		suc->depth =3D xstrfmt("--depth=3D%d", update_data->depth);
+	if (update_data->references.nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, &update_data->references)
+			string_list_append(&suc->references, item->string);
+	}
 }
=20
 static void next_submodule_warn_missing(struct submodule_update_clone *suc=
,
@@ -2356,40 +2394,35 @@ static int run_update_command(struct update_data *u=
d, int subforce)
 	if (run_command(&cp)) {
 		switch (ud->update_strategy.type) {
 		case SM_UPDATE_CHECKOUT:
-			printf(_("Unable to checkout '%s' in submodule path '%s'"),
-			       oid, ud->displaypath);
+			die_message(_("Unable to checkout '%s' in submodule path '%s'"),
+				    oid, ud->displaypath);
 			break;
 		case SM_UPDATE_REBASE:
-			printf(_("Unable to rebase '%s' in submodule path '%s'"),
-			       oid, ud->displaypath);
+			die_message(_("Unable to rebase '%s' in submodule path '%s'"),
+			    oid, ud->displaypath);
 			break;
 		case SM_UPDATE_MERGE:
-			printf(_("Unable to merge '%s' in submodule path '%s'"),
-			       oid, ud->displaypath);
+			die_message(_("Unable to merge '%s' in submodule path '%s'"),
+			    oid, ud->displaypath);
 			break;
 		case SM_UPDATE_COMMAND:
-			printf(_("Execution of '%s %s' failed in submodule path '%s'"),
-			       ud->update_strategy.command, oid, ud->displaypath);
+			die_message(_("Execution of '%s %s' failed in submodule path '%s'"),
+			    ud->update_strategy.command, oid, ud->displaypath);
 			break;
 		default:
 			BUG("unexpected update strategy type: %s",
 			    submodule_strategy_to_string(&ud->update_strategy));
 		}
-		/*
-		 * NEEDSWORK: We are currently printing to stdout with error
-		 * return so that the shell caller handles the error output
-		 * properly. Once we start handling the error messages within
-		 * C, we should use die() instead.
-		 */
 		if (must_die_on_failure)
-			return 2;
-		/*
-		 * This signifies to the caller in shell that the command
-		 * failed without dying
-		 */
+			exit(128);
+
+		/* the command failed, but update must continue */
 		return 1;
 	}
=20
+	if (ud->quiet)
+		return 0;
+
 	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
 		printf(_("Submodule path '%s': checked out '%s'\n"),
@@ -2415,7 +2448,7 @@ static int run_update_command(struct update_data *ud,=
 int subforce)
 	return 0;
 }
=20
-static int do_run_update_procedure(struct update_data *ud)
+static int run_update_procedure(struct update_data *ud)
 {
 	int subforce =3D is_null_oid(&ud->suboid) || ud->force;
=20
@@ -2445,76 +2478,6 @@ static int do_run_update_procedure(struct update_dat=
a *ud)
 	return run_update_command(ud, subforce);
 }
=20
-static void update_submodule(struct update_clone_data *ucd)
-{
-	fprintf(stdout, "dummy %s %d\t%s\n",
-		oid_to_hex(&ucd->oid),
-		ucd->just_cloned,
-		ucd->sub->path);
-}
-
-/*
- * NEEDSWORK: Use a forward declaration to avoid moving
- * run_update_procedure() (which will be removed soon).
- */
-static int update_submodule2(struct update_data *update_data);
-static int run_update_procedure(int argc, const char **argv, const char *p=
refix)
-{
-	struct update_data opt =3D UPDATE_DATA_INIT;
-
-	struct option options[] =3D {
-		OPT__QUIET(&opt.quiet,
-			   N_("suppress output for update by rebase or merge")),
-		OPT__FORCE(&opt.force, N_("force checkout updates"),
-			   0),
-		OPT_BOOL('N', "no-fetch", &opt.nofetch,
-			 N_("don't fetch new objects from the remote site")),
-		OPT_BOOL(0, "just-cloned", &opt.just_cloned,
-			 N_("overrides update mode in case the repository is a fresh clone")),
-		OPT_INTEGER(0, "depth", &opt.depth, N_("depth for shallow fetch")),
-		OPT_STRING(0, "prefix", &opt.prefix,
-			   N_("path"),
-			   N_("path into the working tree")),
-		OPT_STRING(0, "update", &opt.update_default,
-			   N_("string"),
-			   N_("rebase, merge, checkout or none")),
-		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix, N_("path"),
-			   N_("path into the working tree, across nested "
-			      "submodule boundaries")),
-		OPT_CALLBACK_F(0, "oid", &opt.oid, N_("sha1"),
-			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
-			       parse_opt_object_id),
-		OPT_BOOL(0, "remote", &opt.remote,
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
-	opt.sm_path =3D argv[0];
-
-	return update_submodule2(&opt);
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
@@ -2857,8 +2820,53 @@ static int module_set_branch(int argc, const char **=
argv, const char *prefix)
 	return !!ret;
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
+	/*
+	 * NEEDSWORK: the equivalent code in git-submodule.sh does not
+	 * pass --prefix, so this shouldn't either
+	*/
+	if (update_data->prefix)
+		strvec_pushl(args, "--prefix", update_data->prefix, NULL);
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
+	if (update_data->recommend_shallow =3D=3D 0)
+		strvec_push(args, "--no-recommend-shallow");
+	else if (update_data->recommend_shallow =3D=3D 1)
+		strvec_push(args, "--recommend-shallow");
+	if (update_data->single_branch >=3D 0)
+		strvec_push(args, "--single-branch");
+}
+
+static int update_submodule(struct update_data *update_data)
 {
 	char *prefixed_path;
=20
@@ -2907,18 +2915,55 @@ static int update_submodule2(struct update_data *up=
date_data)
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
-static int update_submodules(struct submodule_update_clone *suc)
+static int update_submodules(struct update_data *update_data)
 {
-	int i;
+	int i, res =3D 0;
+	struct submodule_update_clone suc =3D SUBMODULE_UPDATE_CLONE_INIT;
=20
-	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task,
+	update_clone_from_update_data(&suc, update_data);
+	run_processes_parallel_tr2(suc.max_jobs, update_clone_get_next_task,
 				   update_clone_start_failure,
-				   update_clone_task_finished, suc, "submodule",
+				   update_clone_task_finished, &suc, "submodule",
 				   "parallel/update");
=20
 	/*
@@ -2929,50 +2974,69 @@ static int update_submodules(struct submodule_updat=
e_clone *suc)
 	 *   checkout involve more straightforward sequential I/O.
 	 * - the listener can avoid doing any work if fetching failed.
 	 */
-	if (suc->quickstop)
-		return 1;
+	if (suc.quickstop) {
+		res =3D 1;
+		goto cleanup;
+	}
=20
-	for (i =3D 0; i < suc->update_clone_nr; i++)
-		update_submodule(&suc->update_clone[i]);
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
-	const char *update =3D NULL;
 	struct pathspec pathspec;
-	struct submodule_update_clone opt =3D SUBMODULE_UPDATE_CLONE_INIT;
+	struct update_data opt =3D UPDATE_DATA_INIT;
=20
+	/* NEEDSWORK: update names and strings */
 	struct option module_update_clone_options[] =3D {
+		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
 		OPT_BOOL(0, "init", &opt.init,
 			 N_("initialize uninitialized submodules before update")),
-		OPT_STRING(0, "prefix", &prefix,
+		OPT_BOOL(0, "remote", &opt.remote,
+			 N_("use SHA-1 of submodule's remote tracking branch")),
+		OPT_BOOL(0, "recursive", &opt.recursive,
+			 N_("traverse submodules recursively")),
+		OPT_BOOL('N', "no-fetch", &opt.nofetch,
+			 N_("don't fetch new objects from the remote site")),
+		OPT_STRING(0, "prefix", &opt.prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
 		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix,
 			   N_("path"),
 			   N_("path into the working tree, across nested "
 			      "submodule boundaries")),
-		OPT_STRING(0, "update", &update,
+		OPT_STRING(0, "update", &opt.update_default,
 			   N_("string"),
 			   N_("rebase, merge, checkout or none")),
 		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
-			   N_("reference repository")),
+				N_("reference repository")),
 		OPT_BOOL(0, "dissociate", &opt.dissociate,
-			   N_("use --reference only while cloning")),
-		OPT_STRING(0, "depth", &opt.depth, "<depth>",
-			   N_("create a shallow clone truncated to the "
-			      "specified number of revisions")),
+			 N_("use --reference only while cloning")),
+		OPT_INTEGER(0, "depth", &opt.depth,
+			    N_("create a shallow clone truncated to the "
+			       "specified number of revisions")),
 		OPT_INTEGER('j', "jobs", &opt.max_jobs,
 			    N_("parallel jobs")),
 		OPT_BOOL(0, "recommend-shallow", &opt.recommend_shallow,
-			    N_("whether the initial clone should follow the shallow recommendat=
ion")),
+			 N_("whether the initial clone should follow the shallow recommendation=
")),
 		OPT__QUIET(&opt.quiet, N_("don't print cloning progress")),
 		OPT_BOOL(0, "progress", &opt.progress,
-			    N_("force cloning progress")),
+			 N_("force cloning progress")),
 		OPT_BOOL(0, "require-init", &opt.require_init,
-			   N_("disallow cloning into non-empty directory")),
+			 N_("disallow cloning into non-empty directory")),
 		OPT_BOOL(0, "single-branch", &opt.single_branch,
 			 N_("clone only one branch, HEAD or --branch")),
 		OPT_END()
@@ -2982,16 +3046,18 @@ static int update_clone(int argc, const char **argv=
, const char *prefix)
 		N_("git submodule--helper update-clone [--prefix=3D<path>] [<path>...]")=
,
 		NULL
 	};
-	opt.prefix =3D prefix;
=20
 	update_clone_config_from_gitmodules(&opt.max_jobs);
 	git_config(git_update_clone_config, &opt.max_jobs);
=20
 	argc =3D parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
+	oidcpy(&opt.oid, null_oid());
+	oidcpy(&opt.suboid, null_oid());
=20
-	if (update)
-		if (parse_submodule_update_strategy(update, &opt.update) < 0)
+	if (opt.update_default)
+		if (parse_submodule_update_strategy(opt.update_default,
+						    &opt.update_strategy) < 0)
 			die(_("bad value for update parameter"));
=20
 	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0)
@@ -3413,9 +3479,7 @@ static struct cmd_struct commands[] =3D {
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
index 3ccf2388bf..d176469fb1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -50,6 +50,7 @@ single_branch=3D
 jobs=3D
 recommend_shallow=3D
=20
+# NEEDSWORK this is now unused
 die_if_unmatched ()
 {
 	if test "$1" =3D "#unmatched"
@@ -347,108 +348,28 @@ cmd_update()
 		shift
 	done
=20
-	{
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update-clone \
+	# NEEDSWORK --super-prefix isn't actually supported by this
+	# command - we just pass the $prefix to --recursive-prefix.
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} sub=
module--helper update \
 		${GIT_QUIET:+--quiet} \
-		${progress:+"--progress"} \
+		${force:+--force} \
+		${progress:+--progress} \
+		${dissociate:+--dissociate} \
+		${remote:+--remote} \
+		${recursive:+--recursive} \
 		${init:+--init} \
+		${require_init:+--require-init} \
+		${nofetch:+--no-fetch} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
 		${reference:+"$reference"} \
-		${dissociate:+"--dissociate"} \
-		${depth:+--depth "$depth"} \
-		${require_init:+--require-init} \
+		${depth:+"$depth"} \
 		$single_branch \
 		$recommend_shallow \
 		$jobs \
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
-		# 2 or 128: subcommand died during execution
-		# 3: no update procedure was run
-		res=3D"$?"
-		case $res in
-		0)
-			say "$out"
-			;;
-		1)
-			err=3D"${err};fatal: $out"
-			continue
-			;;
-		2|128)
-			die_with_status $res "fatal: $out"
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

