Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75ECC4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 00:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiKIArh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 19:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiKIArb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 19:47:31 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009586315C
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 16:47:29 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p66-20020a257445000000b006ca0ba7608fso15350545ybc.7
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 16:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9TMBggvmsXLMnHqWqZzz73r2bD7xlZ6JG2FqfiLNAKo=;
        b=i5oFoQod0AccVnCxzx3oiHLCgoLQl2uPMK9zZRIg8cjqCOQawaDNEZFLoU6bRcY0rg
         hq+pvr3qONexRL/LH4WqHpZtEHjAGvfNjr//1waLh6OSgmbKPxb5EZp+YTa8jeLPwd40
         d01euwpb/68x7xa3nx+cg0QDYkECy2Mu6YniHkiRRfbAlcx0MOD5dJK2OHtjQoczBC3X
         PZryUfJSI77fi3W+MJPZcU2f2KI1IWtMGBAE7nM6JnHgkmmxkhCSGohqC3TrZ0mza9O7
         Sj+OGZvwxUc+sTLDn/8p5PRemALLyENy4Cb8oDiY6G7ey0rIA3hetaZLrhTSNEbz6Fuc
         d4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TMBggvmsXLMnHqWqZzz73r2bD7xlZ6JG2FqfiLNAKo=;
        b=oZ4VpZOnQyQdN7ecVnnhIbfC3bVHkC2vwm8HsZuGTyOG1Uec72xp634ygEESl0Nbni
         XzfnOBJ2od2974XZKlnQxtDlIuEtFXBvNjLT2XdCdHRxSTe04j4GZSEuit+V7a5v1iMm
         l0r4reVkbrrBR5s5unU9KsaHXycQRiG8GzfQnSFYqZZM1dow10g0lDsbYjfIFc94PD+6
         eC8wG+B0qpl5LhWWBJ/J0DOfaBJkBcPh1er37gzRpHosUdk5vh11vStfG4xl3skNbJkc
         HewXVTC1AymLIZEZT/lBOeh3kkXKFKbs8Qm2CSrUAoc6LOPc8Eby8vHuii6Slxk/GXjt
         4OCA==
X-Gm-Message-State: ACrzQf3HjXMWWSZLyT3ojFU8U0rE/UZuICitQzgqwL9psWdSyCOGsq4s
        U5RmZmdSSfiwoWvqumQyHCBx19HuPj07r5mPb9kXwf1nN2ZFe8vad4pCO8TI4iAoe13XagNXP3X
        zbNxGtWEiy0tfJMUvosVCc7qMc6WBkQ1UmkQL3lkXqGCg3574VvJ4a9Ccet9JrBQ=
X-Google-Smtp-Source: AMsMyM7pxhlqUtwi8bVr09bRWWLUWG2DYJifxKF0iYt5yQ7IFuQ5FysAC3ZzSf/Y1qKwyn0s0Us2O3HaBLZIPg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6902:110e:b0:66d:e6dc:5f31 with SMTP
 id o14-20020a056902110e00b0066de6dc5f31mr56683703ybu.628.1667954849087; Tue,
 08 Nov 2022 16:47:29 -0800 (PST)
Date:   Tue,  8 Nov 2022 16:47:06 -0800
In-Reply-To: <20221109004708.97668-1-chooglen@google.com>
Mime-Version: 1.0
References: <20221109004708.97668-1-chooglen@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221109004708.97668-3-chooglen@google.com>
Subject: [RFC PATCH 2/4] fetch: refactor --submodule-prefix
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since "git fetch" learned to recurse into submodules [1], it has passed
"--submodule-prefix=<path from root of superproject tree to submodule>"
to print full paths to the submodules being fetched. This is the same
value as "--super-prefix"'s when calling "git read-tree
--recurse-submodules", as well as "git (grep|ls-files)
--recurse-submodules" before they were implemented in-process [2] [3],
(when they used repository.submodule_prefix to replace "--super-prefix).

Let's standardize the way we pass such prefixes. Having a per-command
"--submodule-prefix" is preferable to a top-level "--super-prefix",
since it gives us fine-grained control over which commands support it
and which don't, and we can preserve the effort-saving properties of the
top-level flag by sharing an implementation under the hood.

Refactor "git fetch" so that "--submodule-prefix" is stored in
repository.submodule_prefix, and create functions in submodule.h for
parsing and reading its value. Also, mark it with PARSE_OPT_HIDDEN and
drop it from our documentation. We will follow this pattern for "git
read-tree" in the next commit.

Since we've previously documented that repository.submodule_prefix is
only set for submodules, introduce repository.is_submodule for
distinguishing between the_repository and a submodule (although, this
turns out to be unused, since no caller uses repository.submodule_prefix
for that purpose).

[1] 7dce19d374 (fetch/pull: Add the --recurse-submodules option, 2010-11-12)
[2] 188dce131f (ls-files: use repository object, 2017-06-22)
[3] f9ee2fcdfa (grep: recurse in-process using 'struct repository', 2017-08-02)

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/fetch-options.txt |  5 -----
 builtin/fetch.c                 |  7 +++----
 repository.c                    |  1 +
 repository.h                    |  9 +++++++--
 submodule.c                     | 35 +++++++++++++++++++++------------
 submodule.h                     | 12 +++++++++--
 6 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 622bd84768..20cbd2c291 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -241,11 +241,6 @@ endif::git-pull[]
 	linkgit:git-config[1].
 
 ifndef::git-pull[]
---submodule-prefix=<path>::
-	Prepend <path> to paths printed in informative messages
-	such as "Fetching submodule foo".  This option is used
-	internally when recursing over submodules.
-
 --recurse-submodules-default=[yes|on-demand]::
 	This option is used internally to temporarily provide a
 	non-negative default value for the --recurse-submodules
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b06e454cbd..78a46389ff 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -74,7 +74,6 @@ static struct string_list deepen_not = STRING_LIST_INIT_NODUP;
 static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *gtransport;
 static struct transport *gsecondary;
-static const char *submodule_prefix = "";
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int recurse_submodules_cli = RECURSE_SUBMODULES_DEFAULT;
 static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
@@ -195,8 +194,9 @@ static struct option builtin_fetch_options[] = {
 	OPT_SET_INT_F(0, "refetch", &refetch,
 		      N_("re-fetch without negotiating common commits"),
 		      1, PARSE_OPT_NONEG),
-	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, N_("dir"),
-		   N_("prepend this to submodule path output"), PARSE_OPT_HIDDEN },
+	OPT_CALLBACK_F(0, "submodule-prefix", NULL, "path",
+			"path from top-level superproject root to current repo root",
+			PARSE_OPT_HIDDEN, option_parse_submodule_prefix),
 	OPT_CALLBACK_F(0, "recurse-submodules-default",
 		   &recurse_submodules_default, N_("on-demand"),
 		   N_("default for recursive fetching of submodules "
@@ -2297,7 +2297,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		add_options_to_argv(&options);
 		result = fetch_submodules(the_repository,
 					  &options,
-					  submodule_prefix,
 					  recurse_submodules,
 					  recurse_submodules_default,
 					  verbosity < 0,
diff --git a/repository.c b/repository.c
index 5d166b692c..1d454a0ac4 100644
--- a/repository.c
+++ b/repository.c
@@ -229,6 +229,7 @@ int repo_submodule_init(struct repository *subrepo,
 		}
 	}
 
+	subrepo->is_submodule = 1;
 	subrepo->submodule_prefix = xstrfmt("%s%s/",
 					    superproject->submodule_prefix ?
 					    superproject->submodule_prefix :
diff --git a/repository.h b/repository.h
index 24316ac944..1bc4afc2b6 100644
--- a/repository.h
+++ b/repository.h
@@ -119,10 +119,15 @@ struct repository {
 	 */
 	char *worktree;
 
+	/*
+	 * Whether this struct represents a submodule of this process's main
+	 * repository.
+	 */
+	int is_submodule;
+
 	/*
 	 * Path from the root of the top-level superproject down to this
-	 * repository.  This is only non-NULL if the repository is initialized
-	 * as a submodule of another repository.
+	 * repository.
 	 */
 	char *submodule_prefix;
 
diff --git a/submodule.c b/submodule.c
index a6db8c4bbe..d84345a0b4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -257,6 +257,21 @@ const char *get_toplevel_cwd_prefix(void)
 	return toplevel_cwd_prefix;
 }
 
+int option_parse_submodule_prefix(const struct option *opt,
+				  const char *arg, int unset)
+{
+	if (arg)
+		the_repository->submodule_prefix = xstrdup(arg);
+	return 0;
+}
+
+const char *get_submodule_prefix(void)
+{
+	if (!the_repository->submodule_prefix)
+		return "";
+	return the_repository->submodule_prefix;
+}
+
 /*
  * Determine if a submodule has been initialized at a given 'path'
  */
@@ -1392,7 +1407,6 @@ struct submodule_parallel_fetch {
 	int changed_count;
 	struct strvec args;
 	struct repository *r;
-	const char *prefix;
 	int command_line_option;
 	int default_option;
 	int quiet;
@@ -1583,7 +1597,7 @@ get_fetch_task_from_index(struct submodule_parallel_fetch *spf,
 		if (task->repo) {
 			if (!spf->quiet)
 				strbuf_addf(err, _("Fetching submodule %s%s\n"),
-					    spf->prefix, ce->name);
+					    get_submodule_prefix(), ce->name);
 
 			spf->index_count++;
 			return task;
@@ -1645,7 +1659,7 @@ get_fetch_task_from_changed(struct submodule_parallel_fetch *spf,
 		if (!spf->quiet)
 			strbuf_addf(err,
 				    _("Fetching submodule %s%s at commit %s\n"),
-				    spf->prefix, task->sub->path,
+				    get_submodule_prefix(), task->sub->path,
 				    find_unique_abbrev(cs_data->super_oid,
 						       DEFAULT_ABBREV));
 
@@ -1692,8 +1706,6 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 		task = get_fetch_task_from_changed(spf, err);
 
 	if (task) {
-		struct strbuf submodule_prefix = STRBUF_INIT;
-
 		child_process_init(cp);
 		cp->dir = task->repo->gitdir;
 		prepare_submodule_repo_env_in_gitdir(&cp->env);
@@ -1705,13 +1717,11 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 		strvec_push(&cp->args, task->default_argv);
 		strvec_push(&cp->args, "--submodule-prefix");
 
-		strbuf_addf(&submodule_prefix, "%s%s/",
-						spf->prefix,
-						task->sub->path);
-		strvec_push(&cp->args, submodule_prefix.buf);
+		strvec_pushf(&cp->args, "%s%s/",
+					get_submodule_prefix(),
+					task->sub->path);
 		*task_cb = task;
 
-		strbuf_release(&submodule_prefix);
 		string_list_insert(&spf->seen_submodule_names, task->sub->name);
 		return 1;
 	}
@@ -1723,7 +1733,7 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 		spf->oid_fetch_tasks_nr--;
 
 		strbuf_addf(&submodule_prefix, "%s%s/",
-			    spf->prefix, task->sub->path);
+			    get_submodule_prefix(), task->sub->path);
 
 		child_process_init(cp);
 		prepare_submodule_repo_env_in_gitdir(&cp->env);
@@ -1829,7 +1839,7 @@ static int fetch_finish(int retvalue, struct strbuf *err,
 
 int fetch_submodules(struct repository *r,
 		     const struct strvec *options,
-		     const char *prefix, int command_line_option,
+		     int command_line_option,
 		     int default_option,
 		     int quiet, int max_parallel_jobs)
 {
@@ -1851,7 +1861,6 @@ int fetch_submodules(struct repository *r,
 	spf.command_line_option = command_line_option;
 	spf.default_option = default_option;
 	spf.quiet = quiet;
-	spf.prefix = prefix;
 
 	if (!r->worktree)
 		goto out;
diff --git a/submodule.h b/submodule.h
index 436dbb2e11..f2701c4869 100644
--- a/submodule.h
+++ b/submodule.h
@@ -55,7 +55,7 @@ struct option;
 int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 						     const char *arg, int unset);
 int option_parse_toplevel_cwd_prefix(const struct option *opt,
-				   const char *arg, int unset);
+				     const char *arg, int unset);
 /*
  * Return the relative path of the top-level process's cwd to the root of the
  * working tree. When printing paths to submodules in the working tree, this
@@ -63,6 +63,15 @@ int option_parse_toplevel_cwd_prefix(const struct option *opt,
  * top-level process's cwd instead of this process's cwd.
  */
 const char *get_toplevel_cwd_prefix(void);
+int option_parse_submodule_prefix(const struct option *opt,
+				      const char *arg, int unset);
+/*
+ * Return the path from the root of the top-level superproject to root of this
+ * repository. When printing paths to submodules in a tree, this value should be
+ * prepended to the path so that they originate from the top-level
+ * superproject's tree instead of this repository's tree.
+ */
+const char *get_submodule_prefix(void);
 
 int is_tree_submodule_active(struct repository *repo,
 			     const struct object_id *treeish_name,
@@ -100,7 +109,6 @@ const struct submodule *submodule_from_ce(const struct cache_entry *ce);
 void check_for_new_submodule_commits(struct object_id *oid);
 int fetch_submodules(struct repository *r,
 		     const struct strvec *options,
-		     const char *prefix,
 		     int command_line_option,
 		     int default_option,
 		     int quiet, int max_parallel_jobs);
-- 
2.38.1.431.g37b22c650d-goog

