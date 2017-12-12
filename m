Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B25C41F406
	for <e@80x24.org>; Tue, 12 Dec 2017 19:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbdLLTyL (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 14:54:11 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44852 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752464AbdLLTyH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 14:54:07 -0500
Received: by mail-pf0-f194.google.com with SMTP id m26so17212pfj.11
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 11:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z/ddcmTu81DH00RfEQvWq4ondqhWRZm2C2qTU48XnAY=;
        b=cZFZmXf/P93m+/R1KsskLCPWHeOpigJmO0Xd+eWta9uRcPtx4MLjlNv8kUXx5PDxNo
         1Cg0biOjbTaSz/vlVxX11YTbEXur0VBKw1ZU7og+QWUU+6uf1ZOKEb8e4gIz2J8C5bVW
         SnbT81DHq8P3Vn3sFaiM1b5tKsz9Vj9+vCflZpI0l/PBy7FAh+W3fNS/C5ZywaIOrGRF
         A64goF2/Nia/3pRtZT+YETD8ZWzGdqRhbgunDPdxw2YkReyKQucgIhMoyWZud2cdMGM8
         a0V4JwIJNstDprBD4DFIZy+0PQhdJ4+6op8kSIubQICrTL+35HkO0GTE3Oc0J5f6SwY8
         I2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z/ddcmTu81DH00RfEQvWq4ondqhWRZm2C2qTU48XnAY=;
        b=aqmOZ7+phgaHD3Ltf/cfWX/iB6l02bkodJQPOS8lW38hHP5nyoF2xGYc7ZofWzpe7U
         CR9x1TYQBuzwHXFleVyc4alSka0gTY/WupPapJVpNE0/5nY2aIuH+uvYF+YD3VufM+Cy
         aNMnrO77QHQEiY9LS5lOAlkCdtgDDzPfLPlK6ShuDaURdr8+ZNMivrTfMzAvbCSUav6r
         RNkyhscXdld0Nl+ezS3VKbtdxowPPV7t3UYLWbkButmtEuwXHG+e1A7f/FpWHbRdGCCg
         MXiLbnSYVuoUtx4kxxdSkrzaU3xY1157t3XvdHB5IAtn2dlpz/CQFHN55e2AI4LwDEgy
         oJVQ==
X-Gm-Message-State: AKGB3mI44qvjDX6OEbDBCY5u4eeVXtpGFEaYYP6N+UTM5FUb2/R+SAxV
        HgUg3aOdQlE1qOdoHOcrlpp8O5bauPU=
X-Google-Smtp-Source: ACJfBoseKeL0WlsKKhh/SiovyG13NXQJX8hLJmCYvx18zJDHHPhc8ELDrgRGeBdxg1fm0z9aoNQ4LQ==
X-Received: by 10.98.31.7 with SMTP id f7mr3369642pff.235.1513108446007;
        Tue, 12 Dec 2017 11:54:06 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id h69sm32822565pfe.107.2017.12.12.11.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Dec 2017 11:54:04 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 3/3] submodule: convert get_next_submodule to not rely on the_index
Date:   Tue, 12 Dec 2017 11:53:52 -0800
Message-Id: <20171212195352.146675-4-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.504.g5279b80103-goog
In-Reply-To: <20171212195352.146675-1-bmwill@google.com>
References: <20171212195352.146675-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of implicitly relying on the global 'the_index', convert
'get_next_submodule()' to use the index of the repository stored in the
callback data 'struct submodule_parallel_fetch'.

Since this removes the last user of the index compatibility macros,
define 'NO_THE_INDEX_COMPATIBILITY_MACROS' to prevent future users of
these macros in submodule.c.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c |  4 +++-
 submodule.c     | 23 +++++++++++++----------
 submodule.h     | 10 ++++++----
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e705237fa..e656746ab 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "repository.h"
 #include "refs.h"
 #include "commit.h"
 #include "builtin.h"
@@ -1397,7 +1398,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		struct argv_array options = ARGV_ARRAY_INIT;
 
 		add_options_to_argv(&options);
-		result = fetch_populated_submodules(&options,
+		result = fetch_populated_submodules(the_repository,
+						    &options,
 						    submodule_prefix,
 						    recurse_submodules,
 						    recurse_submodules_default,
diff --git a/submodule.c b/submodule.c
index a9670eaae..59372eada 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1,3 +1,5 @@
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
+
 #include "cache.h"
 #include "repository.h"
 #include "config.h"
@@ -1179,7 +1181,7 @@ int submodule_touches_in_range(struct object_id *excl_oid,
 struct submodule_parallel_fetch {
 	int count;
 	struct argv_array args;
-	const char *work_tree;
+	struct repository *r;
 	const char *prefix;
 	int command_line_option;
 	int default_option;
@@ -1200,7 +1202,7 @@ static int get_fetch_recurse_config(const struct submodule *submodule,
 
 		int fetch_recurse = submodule->fetch_recurse;
 		key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
-		if (!repo_config_get_string_const(the_repository, key, &value)) {
+		if (!repo_config_get_string_const(spf->r, key, &value)) {
 			fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
 		}
 		free(key);
@@ -1219,11 +1221,11 @@ static int get_next_submodule(struct child_process *cp,
 	int ret = 0;
 	struct submodule_parallel_fetch *spf = data;
 
-	for (; spf->count < active_nr; spf->count++) {
+	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
 		struct strbuf submodule_path = STRBUF_INIT;
 		struct strbuf submodule_git_dir = STRBUF_INIT;
 		struct strbuf submodule_prefix = STRBUF_INIT;
-		const struct cache_entry *ce = active_cache[spf->count];
+		const struct cache_entry *ce = spf->r->index->cache[spf->count];
 		const char *git_dir, *default_argv;
 		const struct submodule *submodule;
 		struct submodule default_submodule = SUBMODULE_INIT;
@@ -1231,7 +1233,7 @@ static int get_next_submodule(struct child_process *cp,
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		submodule = submodule_from_path(&null_oid, ce->name);
+		submodule = submodule_from_cache(spf->r, &null_oid, ce->name);
 		if (!submodule) {
 			const char *name = default_name_or_path(ce->name);
 			if (name) {
@@ -1257,7 +1259,7 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 		}
 
-		strbuf_addf(&submodule_path, "%s/%s", spf->work_tree, ce->name);
+		strbuf_repo_worktree_path(&submodule_path, spf->r, "%s", ce->name);
 		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
 		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, ce->name);
 		git_dir = read_gitfile(submodule_git_dir.buf);
@@ -1310,7 +1312,8 @@ static int fetch_finish(int retvalue, struct strbuf *err,
 	return 0;
 }
 
-int fetch_populated_submodules(const struct argv_array *options,
+int fetch_populated_submodules(struct repository *r,
+			       const struct argv_array *options,
 			       const char *prefix, int command_line_option,
 			       int default_option,
 			       int quiet, int max_parallel_jobs)
@@ -1318,16 +1321,16 @@ int fetch_populated_submodules(const struct argv_array *options,
 	int i;
 	struct submodule_parallel_fetch spf = SPF_INIT;
 
-	spf.work_tree = get_git_work_tree();
+	spf.r = r;
 	spf.command_line_option = command_line_option;
 	spf.default_option = default_option;
 	spf.quiet = quiet;
 	spf.prefix = prefix;
 
-	if (!spf.work_tree)
+	if (!r->worktree)
 		goto out;
 
-	if (read_cache() < 0)
+	if (repo_read_index(r) < 0)
 		die("index file corrupt");
 
 	argv_array_push(&spf.args, "fetch");
diff --git a/submodule.h b/submodule.h
index e2a5de3d8..b9b7ef003 100644
--- a/submodule.h
+++ b/submodule.h
@@ -76,10 +76,12 @@ extern int should_update_submodules(void);
  */
 extern const struct submodule *submodule_from_ce(const struct cache_entry *ce);
 extern void check_for_new_submodule_commits(struct object_id *oid);
-extern int fetch_populated_submodules(const struct argv_array *options,
-			       const char *prefix, int command_line_option,
-			       int default_option,
-			       int quiet, int max_parallel_jobs);
+extern int fetch_populated_submodules(struct repository *r,
+				      const struct argv_array *options,
+				      const char *prefix,
+				      int command_line_option,
+				      int default_option,
+				      int quiet, int max_parallel_jobs);
 extern unsigned is_submodule_modified(const char *path, int ignore_untracked);
 extern int submodule_uses_gitfile(const char *path);
 
-- 
2.15.1.504.g5279b80103-goog

