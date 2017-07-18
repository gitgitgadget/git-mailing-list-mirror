Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9B8A20387
	for <e@80x24.org>; Tue, 18 Jul 2017 19:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbdGRTFv (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 15:05:51 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33867 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbdGRTFt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 15:05:49 -0400
Received: by mail-pf0-f169.google.com with SMTP id q85so15696786pfq.1
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 12:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7esQsG48HtN3UUdgzuCLsI+ExgIR6EzEu+3YbBS2vk4=;
        b=FcnRI0uDuFV4FbHEPmlEcK90fZwk0+o9kKX52vDzKqAn6ewKr0ufWt3tmXyhvRtR2F
         f23g39CgbnxK46yU0UDeUhPBage4Xhup2HiWxPzyVsiNwg/qTz74cnbPjlf0sH13UqYy
         XHdD23RiqLj4gZO0XudqYBd5d2DDZtQwuNmBW8S6eDfH74inROTzX38PF6faaIKwT6bl
         eipcYrseYKbv6Kflkzi5NAwXV+io+UFWa6bP5Nx/5nzBaOhHvL9wtI93mxd7hH/B97IZ
         DshDXFHeLhR8VfTZFFZireGDK0CL1APr5NEa7mpVdPhR8LLUo8HQ7ejxPZxYsnPmeMYG
         aG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7esQsG48HtN3UUdgzuCLsI+ExgIR6EzEu+3YbBS2vk4=;
        b=Js6CigeDPHAXmNBwzu2UE+rYC5LvX3j61gBHzzbk0Nn+f6PxmmL9TYTIirNPBuSRKN
         1iY1DVG1v94JutyL+Z+RpP8KgK9QdEJ6Eri35uej6HrPdjWGuxkLaclk/FrJ1SlV+Teq
         dnYEJr3cXNMXA04SFCi4BluW0P9lsYPYPUVkK7Vs4fteSHfZNoD4MZLIyrUn1CGAoK6h
         O9UjJuBRZBX/Svy4QeNV1hST5VcqpCTylzvT3XLC8SnL94MA6XpWxHyOfidrYVnJj/Bz
         61jP6ZVCM8dL+lMhmGLBo3W9RNMk2BM9MRi9+hHvsU7DlzhrPkE5QTydryJ5CRsfdMAs
         hpeQ==
X-Gm-Message-State: AIVw113tWDG1JmTfDocVxU7hYITmq3uGG70ua2FNjU2mcmiH2Ez+ULZ3
        SWKcf2XP5p3GqdRvWA4acg==
X-Received: by 10.84.129.12 with SMTP id 12mr3362632plb.242.1500404748112;
        Tue, 18 Jul 2017 12:05:48 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t11sm6894649pfi.66.2017.07.18.12.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 12:05:46 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 06/10] submodule: remove fetch.recursesubmodules from submodule-config parsing
Date:   Tue, 18 Jul 2017 12:05:23 -0700
Message-Id: <20170718190527.78049-7-bmwill@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
In-Reply-To: <20170718190527.78049-1-bmwill@google.com>
References: <20170714222826.81148-1-bmwill@google.com>
 <20170718190527.78049-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the 'fetch.recursesubmodules' configuration option from the
general submodule-config parsing and instead rely on using
'config_from_gitmodules()' in order to maintain backwards compatibility
with this config being placed in the '.gitmodules' file.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c |  8 +++++++-
 submodule.c     | 19 ++++++-------------
 submodule.h     |  2 +-
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ade092bf8..d84c26391 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -71,6 +71,9 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 	if (!strcmp(k, "submodule.fetchjobs")) {
 		max_children = parse_submodule_fetchjobs(k, v);
 		return 0;
+	} else if (!strcmp(k, "fetch.recursesubmodules")) {
+		recurse_submodules = parse_fetch_recurse_submodules_arg(k, v);
+		return 0;
 	}
 
 	return git_default_config(k, v, cb);
@@ -81,6 +84,9 @@ static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "submodule.fetchjobs")) {
 		max_children = parse_submodule_fetchjobs(var, value);
 		return 0;
+	} else if (!strcmp(var, "fetch.recursesubmodules")) {
+		recurse_submodules = parse_fetch_recurse_submodules_arg(var, value);
+		return 0;
 	}
 
 	return 0;
@@ -1355,7 +1361,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		deepen = 1;
 
 	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
-		set_config_fetch_recurse_submodules(recurse_submodules_default);
 		gitmodules_config();
 		git_config(submodule_config, NULL);
 	}
@@ -1399,6 +1404,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		result = fetch_populated_submodules(&options,
 						    submodule_prefix,
 						    recurse_submodules,
+						    recurse_submodules_default,
 						    verbosity < 0,
 						    max_children);
 		argv_array_clear(&options);
diff --git a/submodule.c b/submodule.c
index 7293c28a5..b1965290f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -20,7 +20,6 @@
 #include "worktree.h"
 #include "parse-options.h"
 
-static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 static struct string_list changed_submodule_paths = STRING_LIST_INIT_DUP;
 static int initialized_fetch_ref_tips;
@@ -160,10 +159,6 @@ static int git_modules_config(const char *var, const char *value, void *cb)
 {
 	if (starts_with(var, "submodule."))
 		return parse_submodule_config_option(var, value);
-	else if (!strcmp(var, "fetch.recursesubmodules")) {
-		config_fetch_recurse_submodules = parse_fetch_recurse_submodules_arg(var, value);
-		return 0;
-	}
 	return 0;
 }
 
@@ -714,11 +709,6 @@ void show_submodule_inline_diff(FILE *f, const char *path,
 		clear_commit_marks(right, ~0);
 }
 
-void set_config_fetch_recurse_submodules(int value)
-{
-	config_fetch_recurse_submodules = value;
-}
-
 int should_update_submodules(void)
 {
 	return config_update_recurse_submodules == RECURSE_SUBMODULES_ON;
@@ -1164,10 +1154,11 @@ struct submodule_parallel_fetch {
 	const char *work_tree;
 	const char *prefix;
 	int command_line_option;
+	int default_option;
 	int quiet;
 	int result;
 };
-#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0}
+#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0}
 
 static int get_next_submodule(struct child_process *cp,
 			      struct strbuf *err, void *data, void **task_cb)
@@ -1205,10 +1196,10 @@ static int get_next_submodule(struct child_process *cp,
 					default_argv = "on-demand";
 				}
 			} else {
-				if ((config_fetch_recurse_submodules == RECURSE_SUBMODULES_OFF) ||
+				if ((spf->default_option == RECURSE_SUBMODULES_OFF) ||
 				    gitmodules_is_unmerged)
 					continue;
-				if (config_fetch_recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) {
+				if (spf->default_option == RECURSE_SUBMODULES_ON_DEMAND) {
 					if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
 						continue;
 					default_argv = "on-demand";
@@ -1275,6 +1266,7 @@ static int fetch_finish(int retvalue, struct strbuf *err,
 
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
+			       int default_option,
 			       int quiet, int max_parallel_jobs)
 {
 	int i;
@@ -1282,6 +1274,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 
 	spf.work_tree = get_git_work_tree();
 	spf.command_line_option = command_line_option;
+	spf.default_option = default_option;
 	spf.quiet = quiet;
 	spf.prefix = prefix;
 
diff --git a/submodule.h b/submodule.h
index c8164a3b2..29a1ecd19 100644
--- a/submodule.h
+++ b/submodule.h
@@ -76,7 +76,6 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset,
 		const struct diff_options *opt);
-extern void set_config_fetch_recurse_submodules(int value);
 /* Check if we want to update any submodule.*/
 extern int should_update_submodules(void);
 /*
@@ -87,6 +86,7 @@ extern const struct submodule *submodule_from_ce(const struct cache_entry *ce);
 extern void check_for_new_submodule_commits(struct object_id *oid);
 extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
+			       int default_option,
 			       int quiet, int max_parallel_jobs);
 extern unsigned is_submodule_modified(const char *path, int ignore_untracked);
 extern int submodule_uses_gitfile(const char *path);
-- 
2.13.2.932.g7449e964c-goog

