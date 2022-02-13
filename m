Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BCFC43217
	for <git@archiver.kernel.org>; Sun, 13 Feb 2022 00:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiBMAkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 19:40:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiBMAkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 19:40:09 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F3A6005A
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 16:40:04 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d27so17366330wrb.5
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 16:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wMtVOKdIdUvfblmdEHAlxd8ozSGdUKNBlb2K8VUene8=;
        b=HeFjaF+Cs4f+6Fphp61yCsYtdIqiGVGhe2RCCkX0UTSRQg/01UuRr8Ysfg/UGBqrpE
         6HMDiz3pAc9t959Ztuo+BYWjULvdS3X6CERfFZDed1AFdLuHBjIj6RTTNh9Y9dseHV4E
         N2Dcms5sAT7iChR4Dg4d9DERh6tAOitzKUZ2ZXjg7tb5gzl7v2ImJqhYSYbjbUC4Jc3M
         TKBeIHzJ3as18KeYL6b5im9UKV8f6SeFVS95xQ9YyGhUssgB8o6S91mwtrU0nDERx5jy
         TK1IAtqxW3N7nAtMEVSNbIWLaO+Kw1Y0t1lPeNQj1SCL9T6vTXixaqzx/oQXVzSbYL+m
         27XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wMtVOKdIdUvfblmdEHAlxd8ozSGdUKNBlb2K8VUene8=;
        b=dONBgwCieijg3oA2tl12gCF6nF7WzQaEb6yu3HAU6DBukq+IlxjuSx3zCINcSo1KPo
         obbCOWjAQ8BWrJKf5VLI0EthuE+aWsDKofwHfcaw0mZa4vUMc8NZr8MT9GcNdgKDJ2PO
         l1O1C0Tg8uTmrwD30nQwifbVtQgJGLF964QOS+cGQvpSN9OXLzgoLJcrELGyJXH2mysT
         vfSd9NoX06np7np8wcns1XKLBvk/ZyM2RgG5Z5k8Z9PO6yzH8PwhpXkVVhDmnlnYCKsC
         ApJZxgbJDjsBf4PAyZn6PvcEbQ1ijBnyummrOC5xnUwZ5XnRrotFQHWsGWlWpyJeHhIz
         tQ2A==
X-Gm-Message-State: AOAM533jCTYQKrYKo89+VZ7VkTsAXDnjngxx64JnVWTWYhpWBJgGdkzY
        sHuhwG7b01WzZHGMW2T1GJXyF10xZBI=
X-Google-Smtp-Source: ABdhPJycP0OjteDeKmUHER1i/58I3Sofc5fLgxirifix6BOFV2GWb7695IKXYFNUcD4ohNJs7atIYA==
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr6249147wrh.245.1644712802690;
        Sat, 12 Feb 2022 16:40:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10sm13937436wrc.98.2022.02.12.16.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 16:40:02 -0800 (PST)
Message-Id: <5e27cad17a7080170f476684610391bd56024f36.1644712798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Feb 2022 00:39:54 +0000
Subject: [PATCH 4/7] sparse-checkout: error or warn when given individual
 files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The set and add subcommands accept multiple positional arguments.
The meaning of these arguments differs slightly in the two modes:

Cone mode only accepts directories.  If given a file, it would
previously treat it as a directory, causing not just the file itself to
be included but all sibling files as well -- likely against users'
expectations.  Throw an error if the specified path is a file in the
index.  Provide a --skip-checks argument to allow users to override
(e.g. for the case when the given path IS a directory on another
branch).

Non-cone mode accepts general gitignore patterns.  However, it has an
O(N*M) performance baked into its design, where all N index files must
be matched against all M sparse-checkout patterns with EVERY call to
unpack_trees() that updates the working tree.  As such, it is important
to keep the number of patterns small, and thus we should warn users to
prefer passing directories and more generic glob patterns to get the
paths they want instead of listing each individual file.  (The
--skip-checks argument can also be used to bypass this warning.)  Also,
even when users do want to specify individual files, they will often
want to do so by providing a leading '/' (to avoid selecting the same
filename in all subdirectories), in which case this error message would
never trigger anyway.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 43 +++++++++++++++++++++++++-----
 t/t1091-sparse-checkout-builtin.sh | 16 ++++++++++-
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index bec423d5af9..8f8d2bd6ba5 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "cache.h"
 #include "config.h"
 #include "dir.h"
 #include "parse-options.h"
@@ -681,8 +682,11 @@ static int modify_pattern_list(int argc, const char **argv, int use_stdin,
 	return result;
 }
 
-static void sanitize_paths(int argc, const char **argv, const char *prefix)
+static void sanitize_paths(int argc, const char **argv,
+			   const char *prefix, int skip_checks)
 {
+	int i;
+
 	if (!argc)
 		return;
 
@@ -691,26 +695,49 @@ static void sanitize_paths(int argc, const char **argv, const char *prefix)
 		 * The args are not pathspecs, so unfortunately we
 		 * cannot imitate how cmd_add() uses parse_pathspec().
 		 */
-		int i;
 		int prefix_len = strlen(prefix);
 
 		for (i = 0; i < argc; i++)
 			argv[i] = prefix_path(prefix, prefix_len, argv[i]);
 	}
+
+	if (skip_checks)
+		return;
+
+	for (i = 0; i < argc; i++) {
+		struct cache_entry *ce;
+		struct index_state *index = the_repository->index;
+		int pos = index_name_pos(index, argv[i], strlen(argv[i]));
+
+		if (pos < 0)
+			continue;
+		ce = index->cache[pos];
+		if (S_ISSPARSEDIR(ce->ce_mode))
+			continue;
+
+		if (core_sparse_checkout_cone)
+			die(_("\"%s\" is not a directory; to treat it as a directory anyway, rerun with --skip-checks"), argv[i]);
+		else
+			warning(_("path \"%s\" is an individual file; passing directories or less specific patterns is recommended (see NON-CONE PROBLEMS in the git-sparse-checkout manual)."), argv[i]);
+	}
 }
 
 static char const * const builtin_sparse_checkout_add_usage[] = {
-	N_("git sparse-checkout add (--stdin | <patterns>)"),
+	N_("git sparse-checkout add [--skip-checks] (--stdin | <patterns>)"),
 	NULL
 };
 
 static struct sparse_checkout_add_opts {
+	int skip_checks;
 	int use_stdin;
 } add_opts;
 
 static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_add_options[] = {
+		OPT_BOOL_F(0, "skip-checks", &add_opts.skip_checks,
+			   N_("skip some sanity checks on the given paths that might give false positives"),
+			   PARSE_OPT_NONEG),
 		OPT_BOOL(0, "stdin", &add_opts.use_stdin,
 			 N_("read patterns from standard in")),
 		OPT_END(),
@@ -726,19 +753,20 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 			     builtin_sparse_checkout_add_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	sanitize_paths(argc, argv, prefix);
+	sanitize_paths(argc, argv, prefix, add_opts.skip_checks);
 
 	return modify_pattern_list(argc, argv, add_opts.use_stdin, ADD);
 }
 
 static char const * const builtin_sparse_checkout_set_usage[] = {
-	N_("git sparse-checkout set [--[no-]cone] [--[no-]sparse-index] (--stdin | <patterns>)"),
+	N_("git sparse-checkout set [--[no-]cone] [--[no-]sparse-index] [--skip-checks] (--stdin | <patterns>)"),
 	NULL
 };
 
 static struct sparse_checkout_set_opts {
 	int cone_mode;
 	int sparse_index;
+	int skip_checks;
 	int use_stdin;
 } set_opts;
 
@@ -752,6 +780,9 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 			 N_("initialize the sparse-checkout in cone mode")),
 		OPT_BOOL(0, "sparse-index", &set_opts.sparse_index,
 			 N_("toggle the use of a sparse index")),
+		OPT_BOOL_F(0, "skip-checks", &set_opts.skip_checks,
+			   N_("skip some sanity checks on the given paths that might give false positives"),
+			   PARSE_OPT_NONEG),
 		OPT_BOOL_F(0, "stdin", &set_opts.use_stdin,
 			   N_("read patterns from standard in"),
 			   PARSE_OPT_NONEG),
@@ -780,7 +811,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 		argv = default_patterns;
 		argc = default_patterns_nr;
 	} else {
-		sanitize_paths(argc, argv, prefix);
+		sanitize_paths(argc, argv, prefix, set_opts.skip_checks);
 	}
 
 	return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index b9e6987f5a6..1d95fa47258 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -580,7 +580,7 @@ test_expect_success 'different sparse-checkouts with worktrees' '
 '
 
 test_expect_success 'set using filename keeps file on-disk' '
-	git -C repo sparse-checkout set a deep &&
+	git -C repo sparse-checkout set --skip-checks a deep &&
 	cat >expect <<-\EOF &&
 	/*
 	!/*/
@@ -843,4 +843,18 @@ test_expect_success 'add from subdir pays attention to prefix' '
 	test_cmp expect actual
 '
 
+test_expect_success 'by default, cone mode will error out when passed files' '
+	git -C repo sparse-checkout reapply --cone &&
+	test_must_fail git -C repo sparse-checkout add .gitignore 2>error &&
+
+	grep ".gitignore.*is not a directory" error
+'
+
+test_expect_success 'by default, non-cone mode will warn on individual files' '
+	git -C repo sparse-checkout reapply --no-cone &&
+	git -C repo sparse-checkout add .gitignore 2>warning &&
+
+	grep "passing directories or less specific patterns is recommended" warning
+'
+
 test_done
-- 
gitgitgadget

