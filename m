Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB3020387
	for <e@80x24.org>; Tue, 18 Jul 2017 19:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbdGRTFw (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 15:05:52 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36784 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbdGRTFr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 15:05:47 -0400
Received: by mail-pg0-f43.google.com with SMTP id u5so17453273pgq.3
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 12:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1f63GIkiv8JvLKAOzjYkH35ZK0W3uqdKo4+d/dljXuI=;
        b=BhTVxXn4+0JRWxxPUPw9A+eHroFRBphDe55qkO37dnbSCus49VaWWcDs1ue43LuS5s
         lZl8tInOFCSNJi/Z54ouOlvZ3vmRxpqlT+k32a+OYM8McXHlh7nkc/Vyzg5u2unGilT0
         eziFITHgL/hdGDrYa9BnSnh/A6iaax5tt/+P3Edv6W4WclXrGNqITy/XDYdWp4GMJxUV
         +MlTLELNAM35eGLiqJ3yEhnVLjpXJkqe5fi+OAGkImMWnyB65im3saQYqId449+SHYn5
         Z/ze+u9v/EbINVFxqplAMNA9/geh/G2omh5sGUNSwbjWSTsYaDTQYVzvBGjnIwg5BooF
         cYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1f63GIkiv8JvLKAOzjYkH35ZK0W3uqdKo4+d/dljXuI=;
        b=rWZ57Rb+JJLrx8Bva2p/oa/1r2zqpVb+Yl42nMcnIXeSYtnWDs3WLAOw4ZnnLPXCzl
         eKOhCZvpZIS2Pao4oO4E3jw1tEKEK2NqiejMzZ7IR7/X+xm8SNnntYDfSiUUWoARrZAr
         G3mILbe8Rr/jUKgKXsa36523zaSqAQw22wq9Vh6Mc+Bwb1108RDFjcUb5esJFpBVKwld
         YP70Yyujwa1+vk9MXjMk5ODUUVpLMMDp5w1BES0BpqzGxtyPM3f5FfYwHSi3JFajIskx
         bYu2HDMSfb7vX4MaaKey9jZmaSvIcGhxqvpDRSDTkG80bV6DD3oCcq9ExPWMeOudVkFg
         IuWQ==
X-Gm-Message-State: AIVw111lnfqVAdididYF7cSTU41AmDZwaVVS+7fPk8rWu1kkVn89Lx+/
        RdU86my8hRhYsAYZ6G7/QQ==
X-Received: by 10.84.132.78 with SMTP id 72mr3310053ple.98.1500404746522;
        Tue, 18 Jul 2017 12:05:46 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t11sm6894649pfi.66.2017.07.18.12.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 12:05:45 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 05/10] submodule: remove submodule.fetchjobs from submodule-config parsing
Date:   Tue, 18 Jul 2017 12:05:22 -0700
Message-Id: <20170718190527.78049-6-bmwill@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
In-Reply-To: <20170718190527.78049-1-bmwill@google.com>
References: <20170714222826.81148-1-bmwill@google.com>
 <20170718190527.78049-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The '.gitmodules' file should only contain information pertinent to
configuring individual submodules (name to path mapping, URL where to
obtain the submodule, etc.) while other configuration like the number of
jobs to use when fetching submodules should be a part of the
repository's config.

Remove the 'submodule.fetchjobs' configuration option from the general
submodule-config parsing and instead rely on using the
'config_from_gitmodules()' in order to maintain backwards compatibility
with this config being placed in the '.gitmodules' file.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c             | 18 +++++++++++++++++-
 builtin/submodule--helper.c | 17 +++++++++++++----
 submodule-config.c          |  8 ++++++++
 submodule-config.h          |  1 +
 submodule.c                 | 16 +---------------
 submodule.h                 |  1 -
 6 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c87e59f3b..ade092bf8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -39,7 +39,7 @@ static int prune = -1; /* unspecified */
 static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity, deepen_relative;
 static int progress = -1;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow, deepen;
-static int max_children = -1;
+static int max_children = 1;
 static enum transport_family family;
 static const char *depth;
 static const char *deepen_since;
@@ -68,9 +68,24 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		recurse_submodules = r;
 	}
 
+	if (!strcmp(k, "submodule.fetchjobs")) {
+		max_children = parse_submodule_fetchjobs(k, v);
+		return 0;
+	}
+
 	return git_default_config(k, v, cb);
 }
 
+static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "submodule.fetchjobs")) {
+		max_children = parse_submodule_fetchjobs(var, value);
+		return 0;
+	}
+
+	return 0;
+}
+
 static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
 {
 	ALLOC_GROW(refmap_array, refmap_nr + 1, refmap_alloc);
@@ -1311,6 +1326,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++)
 		strbuf_addf(&default_rla, " %s", argv[i]);
 
+	config_from_gitmodules(gitmodules_fetch_config, NULL);
 	git_config(git_fetch_config, NULL);
 
 	argc = parse_options(argc, argv, prefix,
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6abdad329..6d9600d4f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -960,10 +960,19 @@ static int update_clone_task_finished(int result,
 	return 0;
 }
 
+static int gitmodules_update_clone_config(const char *var, const char *value,
+					  void *cb)
+{
+	int *max_jobs = cb;
+	if (!strcmp(var, "submodule.fetchjobs"))
+		*max_jobs = parse_submodule_fetchjobs(var, value);
+	return 0;
+}
+
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
 	const char *update = NULL;
-	int max_jobs = -1;
+	int max_jobs = 1;
 	struct string_list_item *item;
 	struct pathspec pathspec;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
@@ -1000,6 +1009,9 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	};
 	suc.prefix = prefix;
 
+	config_from_gitmodules(gitmodules_update_clone_config, &max_jobs);
+	git_config(gitmodules_update_clone_config, &max_jobs);
+
 	argc = parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
 
@@ -1017,9 +1029,6 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	git_config(submodule_config, NULL);
 
-	if (max_jobs < 0)
-		max_jobs = parallel_submodules();
-
 	run_processes_parallel(max_jobs,
 			       update_clone_get_next_task,
 			       update_clone_start_failure,
diff --git a/submodule-config.c b/submodule-config.c
index 5fe2d0787..70400f553 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -248,6 +248,14 @@ static int parse_fetch_recurse(const char *opt, const char *arg,
 	}
 }
 
+int parse_submodule_fetchjobs(const char *var, const char *value)
+{
+	int fetchjobs = git_config_int(var, value);
+	if (fetchjobs < 0)
+		die(_("negative values not allowed for submodule.fetchjobs"));
+	return fetchjobs;
+}
+
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
 {
 	return parse_fetch_recurse(opt, arg, 1);
diff --git a/submodule-config.h b/submodule-config.h
index 233bfcb7f..995d404f8 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -27,6 +27,7 @@ struct repository;
 
 extern void submodule_cache_free(struct submodule_cache *cache);
 
+extern int parse_submodule_fetchjobs(const char *var, const char *value);
 extern int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 struct option;
 extern int option_fetch_parse_recurse_submodules(const struct option *opt,
diff --git a/submodule.c b/submodule.c
index 6531c5d60..7293c28a5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -22,7 +22,6 @@
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
-static int parallel_jobs = 1;
 static struct string_list changed_submodule_paths = STRING_LIST_INIT_DUP;
 static int initialized_fetch_ref_tips;
 static struct oid_array ref_tips_before_fetch;
@@ -159,12 +158,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 /* For loading from the .gitmodules file. */
 static int git_modules_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "submodule.fetchjobs")) {
-		parallel_jobs = git_config_int(var, value);
-		if (parallel_jobs < 0)
-			die(_("negative values not allowed for submodule.fetchJobs"));
-		return 0;
-	} else if (starts_with(var, "submodule."))
+	if (starts_with(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 	else if (!strcmp(var, "fetch.recursesubmodules")) {
 		config_fetch_recurse_submodules = parse_fetch_recurse_submodules_arg(var, value);
@@ -1303,9 +1297,6 @@ int fetch_populated_submodules(const struct argv_array *options,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	if (max_parallel_jobs < 0)
-		max_parallel_jobs = parallel_jobs;
-
 	calculate_changed_submodule_paths();
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
@@ -1825,11 +1816,6 @@ int merge_submodule(struct object_id *result, const char *path,
 	return 0;
 }
 
-int parallel_submodules(void)
-{
-	return parallel_jobs;
-}
-
 /*
  * Embeds a single submodules git directory into the superprojects git dir,
  * non recursively.
diff --git a/submodule.h b/submodule.h
index e85b14486..c8164a3b2 100644
--- a/submodule.h
+++ b/submodule.h
@@ -112,7 +112,6 @@ extern int push_unpushed_submodules(struct oid_array *commits,
 				    const struct string_list *push_options,
 				    int dry_run);
 extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
-extern int parallel_submodules(void);
 /*
  * Given a submodule path (as in the index), return the repository
  * path of that submodule in 'buf'. Return -1 on error or when the
-- 
2.13.2.932.g7449e964c-goog

