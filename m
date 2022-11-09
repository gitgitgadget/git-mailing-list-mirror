Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D21AC433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 00:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiKIArg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 19:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKIAr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 19:47:29 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CB661763
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 16:47:27 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-373582569edso149515167b3.2
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 16:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i/h0Sp69CAAj6L95ExUwzsRdpopQ26Y/9QJJvEoKlgY=;
        b=nm/e+uTw/YjdyXIGPi+eksMerKXd3YdO5cOs2itxfNWAZu+X5XfYTj4bIYE8N+jIK4
         dcO4hoRBi8qj/Oy3GPhT2J2L7NYeUnJpafuYnw5TEMOeAYJEIWQ2iJDyrYegspTjqhf0
         lsqRu3aM9cBZ6pO7/P+EpwNnQBz90dr8Q1fRfflQGS2LwiN5nPmhm7wmW4JDImTfu+sF
         vBw4kymo2crJJVr4R20+Y20lvHhoweww6ke7+mxe/+jVOCkcSgMjg6qqY6PIiqlzFwNn
         aXZltVJ13xayv+GSqCFwzEpKW8bg43rT8jlgOBb75DeFpCTCAyL8IeSlcU4MiXIjPG3v
         noLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/h0Sp69CAAj6L95ExUwzsRdpopQ26Y/9QJJvEoKlgY=;
        b=YZOyWSin1Rawb5j1D8HkEReSUF1hcRGFEFh6/imOKruoI34HvtbjwY9tkOueaAP9JD
         dDXU3hIHeDEJm4gpsojZnZJFVuLoYprWUsKZDRyFZVT0uk4fsnosQy/cvdesQoOifKkQ
         mfnZQexEQmifLjtY9D01rDzdtom4IZQJ7ub6xdZx1kC9JkSZWSmiPU7PKVcbZYkguk7y
         zVyVb89JBIkjk90SgK9Z4zKsI1K/hK70l4UunEUEkU+ijx/NbHdfafJl8kZQ32PQbIwG
         lI3wPuxAH+BiIzBgtkHYC+BCYH4rggBFh6fKrtcPkNyr68phBQ9rqlW3AY45JL017jsN
         91yA==
X-Gm-Message-State: ACrzQf3Tgze0yADPNgvPut1WjtUe4d0AjETcExygM+geTpsEOqXlDWvy
        QbIy3PQIjSPktB0e10D8ISXhFzUmdxQHadyNMQDhhIfaioQg3zO9Fzsqw2al3aqSO7pYrNPdHDY
        O+fo4Y8LtvvOO7oTmylKFdWeJOfHcjxEIlrxvZXWpwgHBBUDC90MN5bZxTFgNdnE=
X-Google-Smtp-Source: AMsMyM4/izXnKMoyha9WC2hfpUsO1HtznfdpBMQohakKp2ObGizmFPmLW9xf5OP/+QlUjCz4ZoG7K1gtNNRknw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a0d:c087:0:b0:368:52a0:9173 with SMTP id
 b129-20020a0dc087000000b0036852a09173mr988065ywd.191.1667954847171; Tue, 08
 Nov 2022 16:47:27 -0800 (PST)
Date:   Tue,  8 Nov 2022 16:47:05 -0800
In-Reply-To: <20221109004708.97668-1-chooglen@google.com>
Mime-Version: 1.0
References: <20221109004708.97668-1-chooglen@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221109004708.97668-2-chooglen@google.com>
Subject: [RFC PATCH 1/4] submodule--helper: teach --toplevel-cwd-prefix
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The top-level "--super-prefix" option (i.e. "git --super-prefix") is
overloaded:

- "git submodule--helper" passes the relative path between the top-level
  "git" process's cwd and the current repository
- "git read-tree" passes the path from the root of top-level
  superproject's tree to the the current repository.

In both cases, "--super-prefix" is only used to display meaningful paths
from the superproject to a nested submodule.

Let's address this overloading by breaking it up into its constituent
use cases. Teach "git submodule--helper" the "--toplevel-cwd-prefix"
option, which replaces its usage of "git --super-prefix". (A future
patch will address the "git read-tree" use case.) This value is only
used in builtin/submodule--helper.c, but it is stored in submodule.c,
since it may be needed by other builtins in the future.

When "--toplevel-cwd-prefix" is provided, paths to submodules in the
working tree should be prefixed by it when they are printed, making the
paths relative to the top-level process's cwd. This is the only way the
prefix is used in "git submodule--helper", and all of its subcommands
already conform to this behavior (even the ones that weren't marked
SUPPORT_SUPER_PREFIX) because they all use
get_submodule_displaypath() when printing paths to submodules. As such,
we can say that all of "git submodule--helper" supports (and should
continue to support) this flag, so we drop the constraint that
"--toplevel-cwd-prefix" is only allowed for certain subcommands.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c        | 52 +++++++++++++-----------------
 submodule.c                        | 26 ++++++++++++---
 submodule.h                        | 10 ++++++
 t/t7412-submodule-absorbgitdirs.sh | 13 ++++++--
 4 files changed, 64 insertions(+), 37 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c75e9e86b0..acb838e4d6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -115,18 +115,18 @@ static char *resolve_relative_url(const char *rel_url, const char *up_path, int
 /* the result should be freed by the caller. */
 static char *get_submodule_displaypath(const char *path, const char *prefix)
 {
-	const char *super_prefix = get_super_prefix();
+	const char *toplevel_cwd_prefix = get_toplevel_cwd_prefix();
 
-	if (prefix && super_prefix) {
-		BUG("cannot have prefix '%s' and superprefix '%s'",
-		    prefix, super_prefix);
+	if (prefix && toplevel_cwd_prefix) {
+		BUG("cannot have prefix '%s' and toplevel_cwd_prefix '%s'",
+		    prefix, toplevel_cwd_prefix);
 	} else if (prefix) {
 		struct strbuf sb = STRBUF_INIT;
 		char *displaypath = xstrdup(relative_path(path, prefix, &sb));
 		strbuf_release(&sb);
 		return displaypath;
-	} else if (super_prefix) {
-		return xstrfmt("%s%s", super_prefix, path);
+	} else if (toplevel_cwd_prefix) {
+		return xstrfmt("%s%s", toplevel_cwd_prefix, path);
 	} else {
 		return xstrdup(path);
 	}
@@ -364,9 +364,10 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		cpr.dir = path;
 		prepare_submodule_repo_env(&cpr.env);
 
-		strvec_pushl(&cpr.args, "--super-prefix", NULL);
+		strvec_pushl(&cpr.args, "submodule--helper",
+			     "--toplevel-cwd-prefix", NULL);
 		strvec_pushf(&cpr.args, "%s/", displaypath);
-		strvec_pushl(&cpr.args, "submodule--helper", "foreach", "--recursive",
+		strvec_pushl(&cpr.args, "foreach", "--recursive",
 			     NULL);
 
 		if (info->quiet)
@@ -682,10 +683,10 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 		cpr.dir = path;
 		prepare_submodule_repo_env(&cpr.env);
 
-		strvec_push(&cpr.args, "--super-prefix");
+		strvec_pushl(&cpr.args, "submodule--helper",
+			     "--toplevel-cwd-prefix", NULL);
 		strvec_pushf(&cpr.args, "%s/", displaypath);
-		strvec_pushl(&cpr.args, "submodule--helper", "status",
-			     "--recursive", NULL);
+		strvec_pushl(&cpr.args, "status", "--recursive", NULL);
 
 		if (flags & OPT_CACHED)
 			strvec_push(&cpr.args, "--cached");
@@ -1276,10 +1277,10 @@ static void sync_submodule(const char *path, const char *prefix,
 		cpr.dir = path;
 		prepare_submodule_repo_env(&cpr.env);
 
-		strvec_push(&cpr.args, "--super-prefix");
+		strvec_pushl(&cpr.args, "submodule--helper",
+			     "--toplevel-cwd-prefix", NULL);
 		strvec_pushf(&cpr.args, "%s/", displaypath);
-		strvec_pushl(&cpr.args, "submodule--helper", "sync",
-			     "--recursive", NULL);
+		strvec_pushl(&cpr.args, "sync", "--recursive", NULL);
 
 		if (flags & OPT_QUIET)
 			strvec_push(&cpr.args, "--quiet");
@@ -2438,11 +2439,12 @@ static void update_data_to_args(const struct update_data *update_data,
 {
 	enum submodule_update_type update_type = update_data->update_default;
 
+	strvec_push(args, "submodule--helper");
 	if (update_data->displaypath) {
-		strvec_push(args, "--super-prefix");
+		strvec_push(args, "--toplevel-cwd-prefix");
 		strvec_pushf(args, "%s/", update_data->displaypath);
 	}
-	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
+	strvec_pushl(args, "update", "--recursive", NULL);
 	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
 	if (update_data->quiet)
 		strvec_push(args, "--quiet");
@@ -3353,14 +3355,15 @@ static int module_add(int argc, const char **argv, const char *prefix)
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
-	const char *cmd = argv[0];
-	const char *subcmd;
 	parse_opt_subcommand_fn *fn = NULL;
 	const char *const usage[] = {
 		N_("git submodule--helper <command>"),
 		NULL
 	};
 	struct option options[] = {
+		OPT_CALLBACK_F(0, "toplevel-cwd-prefix", NULL, "path",
+			       "path from top level cwd to working tree root",
+			       0, option_parse_toplevel_cwd_prefix),
 		OPT_SUBCOMMAND("clone", &fn, module_clone),
 		OPT_SUBCOMMAND("add", &fn, module_add),
 		OPT_SUBCOMMAND("update", &fn, module_update),
@@ -3375,21 +3378,10 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 		OPT_SUBCOMMAND("set-url", &fn, module_set_url),
 		OPT_SUBCOMMAND("set-branch", &fn, module_set_branch),
 		OPT_SUBCOMMAND("create-branch", &fn, module_create_branch),
+
 		OPT_END()
 	};
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
-	subcmd = argv[0];
-
-	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
-	    strcmp(subcmd, "foreach") && strcmp(subcmd, "status") &&
-	    strcmp(subcmd, "sync") && strcmp(subcmd, "absorbgitdirs") &&
-	    get_super_prefix())
-		/*
-		 * xstrfmt() rather than "%s %s" to keep the translated
-		 * string identical to git.c's.
-		 */
-		die(_("%s doesn't support --super-prefix"),
-		    xstrfmt("'%s %s'", cmd, subcmd));
 
 	return fn(argc, argv, prefix);
 }
diff --git a/submodule.c b/submodule.c
index 8fa2ad457b..a6db8c4bbe 100644
--- a/submodule.c
+++ b/submodule.c
@@ -28,6 +28,7 @@ static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 static int initialized_fetch_ref_tips;
 static struct oid_array ref_tips_before_fetch;
 static struct oid_array ref_tips_after_fetch;
+static const char *toplevel_cwd_prefix;
 
 /*
  * Check if the .gitmodules file is unmerged. Parsing of the .gitmodules file
@@ -241,6 +242,21 @@ int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 	return 0;
 }
 
+int option_parse_toplevel_cwd_prefix(const struct option *opt,
+				     const char *arg, int unset)
+{
+	if (arg)
+		toplevel_cwd_prefix = arg;
+	return 0;
+}
+
+const char *get_toplevel_cwd_prefix(void)
+{
+	if (!toplevel_cwd_prefix)
+		return "";
+	return toplevel_cwd_prefix;
+}
+
 /*
  * Determine if a submodule has been initialized at a given 'path'
  */
@@ -2298,7 +2314,7 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	real_new_git_dir = real_pathdup(new_gitdir.buf, 1);
 
 	fprintf(stderr, _("Migrating git directory of '%s%s' from\n'%s' to\n'%s'\n"),
-		get_super_prefix_or_empty(), path,
+		get_toplevel_cwd_prefix(), path,
 		real_old_git_dir, real_new_git_dir);
 
 	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
@@ -2317,10 +2333,10 @@ static void absorb_git_dir_into_superproject_recurse(const char *path)
 	cp.dir = path;
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
-	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
-		     get_super_prefix_or_empty(), path);
-	strvec_pushl(&cp.args, "submodule--helper",
-		     "absorbgitdirs", NULL);
+	strvec_push(&cp.args, "submodule--helper");
+	strvec_pushf(&cp.args, "--toplevel-cwd-prefix=%s%s/",
+		     get_toplevel_cwd_prefix(), path);
+	strvec_pushl(&cp.args, "absorbgitdirs", NULL);
 	prepare_submodule_repo_env(&cp.env);
 	if (run_command(&cp))
 		die(_("could not recurse into submodule '%s'"), path);
diff --git a/submodule.h b/submodule.h
index b52a4ff1e7..436dbb2e11 100644
--- a/submodule.h
+++ b/submodule.h
@@ -54,6 +54,16 @@ int git_default_submodule_config(const char *var, const char *value, void *cb);
 struct option;
 int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 						     const char *arg, int unset);
+int option_parse_toplevel_cwd_prefix(const struct option *opt,
+				   const char *arg, int unset);
+/*
+ * Return the relative path of the top-level process's cwd to the root of the
+ * working tree. When printing paths to submodules in the working tree, this
+ * value should be prepended to the path so that they appear relative to the
+ * top-level process's cwd instead of this process's cwd.
+ */
+const char *get_toplevel_cwd_prefix(void);
+
 int is_tree_submodule_active(struct repository *repo,
 			     const struct object_id *treeish_name,
 			     const char *path);
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 2859695c6d..a9efebc7ec 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -54,15 +54,24 @@ test_expect_success 'setup nested submodule' '
 '
 
 test_expect_success 'absorb the git dir in a nested submodule' '
+	# Touch the files so that they show up in git status
+	>expect.err &&
+	>actual.err &&
 	git status >expect.1 &&
 	git -C sub1/nested rev-parse HEAD >expect.2 &&
-	git submodule absorbgitdirs &&
+	git submodule absorbgitdirs 2>actual.err &&
 	test -f sub1/nested/.git &&
 	test -d .git/modules/sub1/modules/nested &&
 	git status >actual.1 &&
 	git -C sub1/nested rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
-	test_cmp expect.2 actual.2
+	test_cmp expect.2 actual.2 &&
+	cat >expect.err <<-EOF &&
+	Migrating git directory of ${SQ}sub1/nested${SQ} from
+	${SQ}/Users/chooglen/Code/git/t/trash directory.t7412-submodule-absorbgitdirs/sub1/nested/.git${SQ} to
+	${SQ}/Users/chooglen/Code/git/t/trash directory.t7412-submodule-absorbgitdirs/.git/modules/sub1/modules/nested${SQ}
+	EOF
+	test_cmp expect.err actual.err
 '
 
 test_expect_success 're-setup nested submodule' '
-- 
2.38.1.431.g37b22c650d-goog

