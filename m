Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93A0A20A04
	for <e@80x24.org>; Fri, 26 May 2017 19:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944663AbdEZTLe (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 15:11:34 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36731 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937352AbdEZTK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 15:10:27 -0400
Received: by mail-pf0-f173.google.com with SMTP id m17so19303072pfg.3
        for <git@vger.kernel.org>; Fri, 26 May 2017 12:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=biP8Gjl1lfTQ9eiB8wBUrmCuUqNGm0Iz9vkDZh/Awl0=;
        b=tMUQjnhu0j3CDY6NIkJZ9BeGdhewUqAJR9jrwR5UB9pjeHrMYBCHRhJtEJb6of9TAh
         Nm17SfQkKWlhQ13w8sH3BAz4WGmXBzBLYI0NHgpTzctswfkZIw9p5MY4UaNmZ5vOg7eD
         GvbnKHku3dq62GLNR0BmnhxitRReCdXaZc9GOYQZYNAQST3736TTqPsEjtJCdYG2u49A
         W3wTOx6BJRC822diM2R4FF/cOsTy6uUHmibR6nFBUP6/5ffgkqzwxTfmy+Qzh3yGOGgB
         Vwa5pJ/L37CsbxRLBps0IiUp5ESubDLeuVPC8JnPzphuJKAbJHYwnvZiDZpaZvBXiknr
         pqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=biP8Gjl1lfTQ9eiB8wBUrmCuUqNGm0Iz9vkDZh/Awl0=;
        b=pKfL4dH5relU79iExs2DfNhfgk5nWnfwTk35AEXXe8xKMQchi8esdcXPF37PrGCict
         Olf7ATTBqz4msfkjicPixWl6W/hXSk9jJ17sfn6sZ8mIeUb6dQXFBljBQU5uAqjnvYJA
         zoNSolF8LshmtvUKPVcpiVcoO02izNVcXVH9jJLCKqCp/1wsP9ALQCCuxoTi1YXXscXb
         lm3ViUgWQ+4s3fpm7DnwTcHKh5kBwmyJYbFY7Ee6KeIe5hAmReI7Nz/CupIfwP22zRR8
         RRF+8yZ0kJRBEGzgqIFlJBcbM5gPijooyhdfGvstMXb6vKmToLcZ0bMGSkDVcS+g846A
         Nyfw==
X-Gm-Message-State: AODbwcA8Kb3IUWgygoSaYqBYZLBBwE3X/ZC++mJMA1p5Au6Waf9IMKj+
        8L2gJcLDl/UMjkEC
X-Received: by 10.99.104.6 with SMTP id d6mr4325876pgc.185.1495825827037;
        Fri, 26 May 2017 12:10:27 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:818a:1f3a:57c6:8d29])
        by smtp.gmail.com with ESMTPSA id f63sm2865483pgc.63.2017.05.26.12.10.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 May 2017 12:10:26 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/8] Introduce 'submodule.recurse' option for worktree manipulators
Date:   Fri, 26 May 2017 12:10:14 -0700
Message-Id: <20170526191017.19155-6-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.g582985b1e4
In-Reply-To: <20170526191017.19155-1-sbeller@google.com>
References: <20170526191017.19155-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any command that understands '--recurse-submodules' can have its
default changed to true, by setting the new 'submodule.recurse'
option.

This patch includes read-tree/checkout/reset for working tree
manipulating commands. Later patches will cover other commands.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt  |  5 +++++
 builtin/checkout.c        |  2 +-
 builtin/read-tree.c       | 10 +++++++++-
 builtin/reset.c           | 10 +++++++++-
 submodule.c               | 23 +++++++++++++++++++++--
 submodule.h               |  1 +
 t/lib-submodule-update.sh | 12 ++++++++++++
 7 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d51..e367becf72 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3063,6 +3063,11 @@ submodule.active::
 	submodule's path to determine if the submodule is of interest to git
 	commands.
 
+submodule.recurse::
+	Specifies if commands recurse into submodules by default. This
+	applies to all commands that have a `--recurse-submodules` option.
+	Defaults to false.
+
 submodule.fetchJobs::
 	Specifies how many submodules are fetched/cloned at the same time.
 	A positive integer allows up to that number of submodules fetched
diff --git a/builtin/checkout.c b/builtin/checkout.c
index acff6039d6..9ccc4a1d52 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -854,7 +854,7 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 	}
 
 	if (starts_with(var, "submodule."))
-		return parse_submodule_config_option(var, value);
+		return submodule_config(var, value, NULL);
 
 	return git_xmerge_config(var, value, NULL);
 }
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 8a889ef4c3..6dd70cd430 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -98,6 +98,14 @@ static int debug_merge(const struct cache_entry * const *stages,
 	return 0;
 }
 
+int git_read_tree_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "submodule.recurse"))
+		return git_default_submodule_config(var, value, cb);
+
+	return git_default_config(var, value, cb);
+}
+
 static struct lock_file lock_file;
 
 int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
@@ -150,7 +158,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 
-	git_config(git_default_config, NULL);
+	git_config(git_read_tree_config, NULL);
 
 	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
 			     read_tree_usage, 0);
diff --git a/builtin/reset.c b/builtin/reset.c
index 6f89dc5494..8ccdb7437e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -266,6 +266,14 @@ static int reset_refs(const char *rev, const struct object_id *oid)
 	return update_ref_status;
 }
 
+int git_reset_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "submodule.recurse"))
+		return git_default_submodule_config(var, value, cb);
+
+	return git_default_config(var, value, cb);
+}
+
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
@@ -294,7 +302,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	git_config(git_reset_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
diff --git a/submodule.c b/submodule.c
index 78cccb7563..2b157dc995 100644
--- a/submodule.c
+++ b/submodule.c
@@ -16,6 +16,7 @@
 #include "quote.h"
 #include "remote.h"
 #include "worktree.h"
+#include "parse-options.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
@@ -170,10 +171,28 @@ static int git_modules_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-/* Loads all submodule settings from the config */
+/* Loads all submodule settings from the config. */
 int submodule_config(const char *var, const char *value, void *cb)
 {
-	return git_modules_config(var, value, cb);
+	if (!strcmp(var, "submodule.recurse")) {
+		int v = git_config_bool(var, value) ?
+			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
+		config_update_recurse_submodules = v;
+		return 0;
+	} else {
+		return git_modules_config(var, value, cb);
+	}
+}
+
+/* Cheap function that only determines if we're interested in submodules at all */
+int git_default_submodule_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "submodule.recurse")) {
+		int v = git_config_bool(var, value) ?
+			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
+		config_update_recurse_submodules = v;
+	}
+	return 0;
 }
 
 int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
diff --git a/submodule.h b/submodule.h
index b13f120f76..d920ca1d5a 100644
--- a/submodule.h
+++ b/submodule.h
@@ -39,6 +39,7 @@ extern void stage_updated_gitmodules(void);
 extern void set_diffopt_flags_from_submodule_config(struct diff_options *,
 		const char *path);
 extern int submodule_config(const char *var, const char *value, void *cb);
+extern int git_default_submodule_config(const char *var, const char *value, void *cb);
 
 struct option;
 int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 0272c4d8ca..52beadad96 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -990,6 +990,18 @@ test_submodule_switch_recursing_with_args () {
 		)
 	'
 
+	test_expect_success "git -c submodule.recurse=true $cmd_args: modified submodule updates submodule work tree" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			git -c submodule.recurse=true $cmd_args modify_sub1 &&
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/modify_sub1
+		)
+	'
+
 	# Updating a submodule to an invalid sha1 doesn't update the
 	# superproject nor the submodule's work tree.
 	test_expect_success "$command: updating to a missing submodule commit fails" '
-- 
2.13.0.17.g582985b1e4

