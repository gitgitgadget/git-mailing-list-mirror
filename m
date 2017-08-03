Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FC4D1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 18:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbdHCSUa (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 14:20:30 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:37118 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbdHCSU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:27 -0400
Received: by mail-pg0-f53.google.com with SMTP id y129so9274439pgy.4
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c74EgcMl9Hps8uTdzDA7pQ+kzB7b9DjgnxpXz0ERM4I=;
        b=CMb5guJrr0S8mW3BvCY3yvMVACfPXUgTii2oSHdy3OMYlb+JGrkH37e/Ka/70uMwPy
         vzlUe6gemPhUwNI3B9mYDarkPCa/VMwSYv5VmMS2vibeg+L5Dw9sgID2aPy6HUJef9Wa
         eeDJQSmTYvxBW+S8N2c4I52msWCDF+7K1ZO0Jb+XZl04CKkYuSD10C4wihwLXxZKJXqG
         jzSg/nTyFJriXqAb8e2fW4KzFfOuA4faY5PgvHCpMZgjp0zoCBJfj3NnyB8bEGXhEbVX
         ZoOskA8Zw/cz4/r1VRFAr2ZLi5PFIFrPZL/9rFki+QqOwgX2fJfO4OevgjiG/jfkwx5o
         xBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c74EgcMl9Hps8uTdzDA7pQ+kzB7b9DjgnxpXz0ERM4I=;
        b=dnWz2naifWQR0KBaXeEVLxrwxvhJzeyJ2DOZpmtj/LOoE2rS1bbiaqiJpCkVFREYfx
         S8pvSuCasxVjs9bEi78UDsdsNIQd5FI6Si5bf+3t7WfSuOzyCF4W2w/G0zpC+rGTNKwu
         Zz5lmGuvdgHngGT5XvjRIPeHKV6pS2dzBll6Xy+V+vlwyxoWnb08n+Eo1e+EuuEtsxQW
         fFe9JchxG5PsLcClZMvpP9sIFIgfQVs9cGKsXDGFwC6nkNYGO/1ar+JMZzo2K/pjkSFe
         YHq0vRsMlJSmop3zMdfBqfyTHxZfyl/zJGl+cXIPCcgpMRhfHZeND00G2iV+N7Gl1ep+
         IHgg==
X-Gm-Message-State: AIVw1117i82gp95sPxiDpiYWa3HIl29BkyCoPfKXKgVNUObsQLTOQMvl
        pbP3F40LY1UOvWjqbN9Y8w==
X-Received: by 10.84.232.8 with SMTP id h8mr2865462plk.252.1501784426088;
        Thu, 03 Aug 2017 11:20:26 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm10706293pgc.57.2017.08.03.11.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 11:20:25 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 12/15] submodule-config: move submodule-config functions to submodule-config.c
Date:   Thu,  3 Aug 2017 11:19:57 -0700
Message-Id: <20170803182000.179328-13-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170803182000.179328-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170803182000.179328-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate the functions used to initialize the submodule-config to
submodule-config.c so that the callback routine used in the
initialization process can be static and prevent it from being used
outside of initializing the submodule-config through the main API.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c |  1 +
 submodule-config.c | 38 +++++++++++++++++++++++++++++++-------
 submodule-config.h |  7 ++-----
 submodule.c        | 35 -----------------------------------
 submodule.h        |  2 --
 5 files changed, 34 insertions(+), 49 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b8514a002..d14612057 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -19,6 +19,7 @@
 #include "pathspec.h"
 #include "run-command.h"
 #include "submodule.h"
+#include "submodule-config.h"
 
 static int abbrev;
 static int show_deleted;
diff --git a/submodule-config.c b/submodule-config.c
index 0b429e942..86636654b 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -449,9 +449,9 @@ static int parse_config(const char *var, const char *value, void *data)
 	return ret;
 }
 
-int gitmodule_oid_from_commit(const struct object_id *treeish_name,
-				      struct object_id *gitmodules_oid,
-				      struct strbuf *rev)
+static int gitmodule_oid_from_commit(const struct object_id *treeish_name,
+				     struct object_id *gitmodules_oid,
+				     struct strbuf *rev)
 {
 	int ret = 0;
 
@@ -552,9 +552,9 @@ static void submodule_cache_check_init(struct repository *repo)
 	submodule_cache_init(repo->submodule_cache);
 }
 
-int submodule_config_option(struct repository *repo,
-			    const char *var, const char *value)
+static int gitmodules_cb(const char *var, const char *value, void *data)
 {
+	struct repository *repo = data;
 	struct parse_config_parameter parameter;
 
 	submodule_cache_check_init(repo);
@@ -567,9 +567,33 @@ int submodule_config_option(struct repository *repo,
 	return parse_config(var, value, &parameter);
 }
 
-int parse_submodule_config_option(const char *var, const char *value)
+void repo_read_gitmodules(struct repository *repo)
 {
-	return submodule_config_option(the_repository, var, value);
+	if (repo->worktree) {
+		char *gitmodules;
+
+		if (repo_read_index(repo) < 0)
+			return;
+
+		gitmodules = repo_worktree_path(repo, GITMODULES_FILE);
+
+		if (!is_gitmodules_unmerged(repo->index))
+			git_config_from_file(gitmodules_cb, gitmodules, repo);
+
+		free(gitmodules);
+	}
+}
+
+void gitmodules_config_oid(const struct object_id *commit_oid)
+{
+	struct strbuf rev = STRBUF_INIT;
+	struct object_id oid;
+
+	if (gitmodule_oid_from_commit(commit_oid, &oid, &rev)) {
+		git_config_from_blob_oid(gitmodules_cb, rev.buf,
+					 &oid, the_repository);
+	}
+	strbuf_release(&rev);
 }
 
 const struct submodule *submodule_from_name(const struct object_id *treeish_name,
diff --git a/submodule-config.h b/submodule-config.h
index 84c2cf515..e3845831f 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -34,8 +34,8 @@ extern int option_fetch_parse_recurse_submodules(const struct option *opt,
 						 const char *arg, int unset);
 extern int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 extern int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
-extern int submodule_config_option(struct repository *repo,
-				   const char *var, const char *value);
+extern void repo_read_gitmodules(struct repository *repo);
+extern void gitmodules_config_oid(const struct object_id *commit_oid);
 extern const struct submodule *submodule_from_name(
 		const struct object_id *commit_or_tree, const char *name);
 extern const struct submodule *submodule_from_path(
@@ -43,9 +43,6 @@ extern const struct submodule *submodule_from_path(
 extern const struct submodule *submodule_from_cache(struct repository *repo,
 						    const struct object_id *treeish_name,
 						    const char *key);
-extern int gitmodule_oid_from_commit(const struct object_id *commit_oid,
-				     struct object_id *gitmodules_oid,
-				     struct strbuf *rev);
 extern void submodule_free(void);
 
 #endif /* SUBMODULE_CONFIG_H */
diff --git a/submodule.c b/submodule.c
index 3b383d8c4..c1cef1c37 100644
--- a/submodule.c
+++ b/submodule.c
@@ -216,46 +216,11 @@ void load_submodule_cache(void)
 	gitmodules_config();
 }
 
-static int gitmodules_cb(const char *var, const char *value, void *data)
-{
-	struct repository *repo = data;
-	return submodule_config_option(repo, var, value);
-}
-
-void repo_read_gitmodules(struct repository *repo)
-{
-	if (repo->worktree) {
-		char *gitmodules;
-
-		if (repo_read_index(repo) < 0)
-			return;
-
-		gitmodules = repo_worktree_path(repo, GITMODULES_FILE);
-
-		if (!is_gitmodules_unmerged(repo->index))
-			git_config_from_file(gitmodules_cb, gitmodules, repo);
-
-		free(gitmodules);
-	}
-}
-
 void gitmodules_config(void)
 {
 	repo_read_gitmodules(the_repository);
 }
 
-void gitmodules_config_oid(const struct object_id *commit_oid)
-{
-	struct strbuf rev = STRBUF_INIT;
-	struct object_id oid;
-
-	if (gitmodule_oid_from_commit(commit_oid, &oid, &rev)) {
-		git_config_from_blob_oid(gitmodules_cb, rev.buf,
-					 &oid, the_repository);
-	}
-	strbuf_release(&rev);
-}
-
 /*
  * Determine if a submodule has been initialized at a given 'path'
  */
diff --git a/submodule.h b/submodule.h
index 4f70c4944..02195c24f 100644
--- a/submodule.h
+++ b/submodule.h
@@ -47,8 +47,6 @@ int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 						     const char *arg, int unset);
 void load_submodule_cache(void);
 extern void gitmodules_config(void);
-extern void repo_read_gitmodules(struct repository *repo);
-extern void gitmodules_config_oid(const struct object_id *commit_oid);
 extern int is_submodule_active(struct repository *repo, const char *path);
 /*
  * Determine if a submodule has been populated at a given 'path' by checking if
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

