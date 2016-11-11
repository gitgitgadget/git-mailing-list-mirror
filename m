Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95BA120798
	for <e@80x24.org>; Fri, 11 Nov 2016 23:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934770AbcKKX5U (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 18:57:20 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34047 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756505AbcKKX5T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 18:57:19 -0500
Received: by mail-pg0-f52.google.com with SMTP id x23so15566458pgx.1
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 15:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ePCpjZPZBxVa3l72OMkBloyXoaknIk+IWmdtOWLpygE=;
        b=j3lSF0R3wFKnttsULhagDhVJ+AcraXVnUlg7WwmgcdQ64xqH2joV77hanZ0TW7KA+5
         zX/OPtm3R2xgoKpwS5V3sMzFxiPcLtbFHKYwgBjixmhpA3hV+b2pwr2UzCR63Jk5V90z
         zg2LSe2IjTrnMgdklmMhQGjneu+QODcJ68CXnBq4jQLsXlpvYJ2wim3NSBSePknAsjKB
         mL1J3WuTZV+Id6aLhI0ZKv0AQUP0pnqTZax4IMJpiKA1hR8Qe5wmUjWuTARBz1Chl9AA
         zs2+o5mHOZdl33qAbG7uyFRjRAzaN8HDeHt5nPkBBPenjwB4UjF0l2sy6EY/Et1zEbYG
         1jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ePCpjZPZBxVa3l72OMkBloyXoaknIk+IWmdtOWLpygE=;
        b=UhAYiYtBglivOK19o87PCVr9mn3DGTED1cO3TEoQAvwehQHoVYzKN63icf3FIURHKl
         QqCETJ6l+FYGcPAasd6WFEAdDRNARQcpOEkJPrEwLY9ab8HoDTie4HN8dpnH/uifqPIH
         MbKSWL0UBk3ugi3+e5zTeNyuO/X2oVCB3iPAmMCo0nPNL8y6YhGh0+A3rlO2nS17q7VW
         JJz4we11zKNUxXxagGJ2YgUsnVfdqz7Ysa+xoZTvVi6hiWv8LmnhPN9fjST2M0gzIP6E
         yVKaRhvv7VckFBvYC+qhN74bI1xrQC9VEdZlos0Q5rZzXjuz+KyJ+cTG1dtyFT12P2tU
         NyPg==
X-Gm-Message-State: ABUngvdPUDID6RgMI1ImSIhKPJWaNFIL3WH9q2zpF1CorxjJtdC9lDwSj5z9E1wkP+g5eJ0c
X-Received: by 10.99.143.73 with SMTP id r9mr8725870pgn.54.1478908290637;
        Fri, 11 Nov 2016 15:51:30 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id r74sm17568314pfl.79.2016.11.11.15.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Nov 2016 15:51:29 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v3 0/6] recursively grep across submodules
Date:   Fri, 11 Nov 2016 15:51:07 -0800
Message-Id: <1478908273-190166-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1477953496-103596-1-git-send-email-bmwill@google.com>
References: <1477953496-103596-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of the changes between v2 and v3 of this series were to address the few
reviewer comments.
* use 'path' as the directory to cd into for the child process and use 'name'
  for the super_prefix
* flush output from childprocess on error and print a more useful error msg
* change is_submodule_checked_out to is_submodule_populated
* fix GIT_DIR for a submodule child process from being set to '.git'
* Addition of a test for searching history of a submodule which had been moved.

The series as a whole probably needs a few more rounds of
review so any additional input would be appreciated!  

Thanks!
Brandon

Brandon Williams (6):
  submodules: add helper functions to determine presence of submodules
  submodules: load gitmodules file from commit sha1
  grep: add submodules as a grep source type
  grep: optionally recurse into submodules
  grep: enable recurse-submodules to work on <tree> objects
  grep: search history of moved submodules

 Documentation/git-grep.txt         |  14 ++
 builtin/grep.c                     | 391 ++++++++++++++++++++++++++++++++++---
 cache.h                            |   2 +
 config.c                           |   8 +-
 git.c                              |   2 +-
 grep.c                             |  16 +-
 grep.h                             |   1 +
 submodule-config.c                 |   6 +-
 submodule-config.h                 |   3 +
 submodule.c                        |  50 +++++
 submodule.h                        |   3 +
 t/t7814-grep-recurse-submodules.sh | 182 +++++++++++++++++
 12 files changed, 646 insertions(+), 32 deletions(-)
 create mode 100755 t/t7814-grep-recurse-submodules.sh

-- interdiff based on 'bw/grep-recurse-submodules'

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 386a868..71f32f3 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -26,7 +26,7 @@ SYNOPSIS
 	   [--threads <num>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
-	   [--recurse-submodules] [--parent-basename]
+	   [--recurse-submodules] [--parent-basename <basename>]
 	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
 	   [--] [<pathspec>...]
 
@@ -95,7 +95,7 @@ OPTIONS
 	<tree> option the prefix of all submodule output will be the name of
 	the parent project's <tree> object.
 
---parent-basename::
+--parent-basename <basename>::
 	For internal use only.  In order to produce uniform output with the
 	--recurse-submodules option, this option can be used to provide the
 	basename of a parent's <tree> object to a submodule so the submodule
diff --git a/builtin/grep.c b/builtin/grep.c
index bdf1b90..1879432 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -538,14 +538,22 @@ static int grep_submodule_launch(struct grep_opt *opt,
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int status, i;
 	const char *end_of_base;
+	const char *name;
 	struct work_item *w = opt->output_priv;
 
+	end_of_base = strchr(gs->name, ':');
+	if (end_of_base)
+		name = end_of_base + 1;
+	else
+		name = gs->name;
+
 	prepare_submodule_repo_env(&cp.env_array);
+	argv_array_push(&cp.env_array, GIT_DIR_ENVIRONMENT);
 
 	/* Add super prefix */
 	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
-			 super_prefix ? super_prefix: "",
-			 gs->path);
+			 super_prefix ? super_prefix : "",
+			 name);
 	argv_array_push(&cp.args, "grep");
 
 	/*
@@ -556,7 +564,6 @@ static int grep_submodule_launch(struct grep_opt *opt,
 	 * parent project's object name to the submodule so the submodule can
 	 * prefix its output with the parent's name and not its own SHA1.
 	 */
-	end_of_base = strchr(gs->name, ':');
 	if (end_of_base)
 		argv_array_pushf(&cp.args, "--parent-basename=%.*s",
 				 (int) (end_of_base - gs->name),
@@ -588,8 +595,12 @@ static int grep_submodule_launch(struct grep_opt *opt,
 	 * anything else is an error.
 	 */
 	status = capture_command(&cp, &w->out, 0);
-	if (status && (status != 1))
-		exit(status);
+	if (status && (status != 1)) {
+		/* flush the buffer */
+		write_or_die(1, w->out.buf, w->out.len);
+		die("process for submodule '%s' failed with exit code: %d",
+		    gs->name, status);
+	}
 
 	/* invert the return code to make a hit equal to 1 */
 	return !status;
@@ -605,11 +616,20 @@ static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
 			  const char *filename, const char *path)
 {
 	if (!(is_submodule_initialized(path) &&
-	      is_submodule_checked_out(path))) {
-		warning("skiping submodule '%s%s' since it is not initialized and checked out",
-			super_prefix ? super_prefix: "",
-			path);
-		return 0;
+	      is_submodule_populated(path))) {
+		/*
+		 * If searching history, check for the presense of the
+		 * submodule's gitdir before skipping the submodule.
+		 */
+		if (sha1) {
+			path = git_path("modules/%s",
+					submodule_from_path(null_sha1, path)->name);
+
+			if(!(is_directory(path) && is_git_directory(path)))
+				return 0;
+		} else {
+			return 0;
+		}
 	}
 
 #ifndef NO_PTHREADS
@@ -670,8 +690,7 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec,
 					continue;
 				hit |= grep_sha1(opt, ce->oid.hash, ce->name,
 						 0, ce->name);
-			}
-			else {
+			} else {
 				hit |= grep_file(opt, ce->name);
 			}
 		} else if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
@@ -705,8 +724,8 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 	struct strbuf name = STRBUF_INIT;
 	int name_base_len = 0;
 	if (super_prefix) {
-		name_base_len = strlen(super_prefix);
 		strbuf_addstr(&name, super_prefix);
+		name_base_len = name.len;
 	}
 
 	while (tree_entry(tree, &entry)) {
@@ -715,8 +734,16 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		if (match != all_entries_interesting) {
 			strbuf_setlen(&name, name_base_len);
 			strbuf_addstr(&name, base->buf + tn_len);
-			match = tree_entry_interesting(&entry, &name,
-						       0, pathspec);
+
+			if (recurse_submodules && S_ISGITLINK(entry.mode)) {
+				strbuf_addstr(&name, entry.path);
+				match = submodule_path_match(pathspec, name.buf,
+							     NULL);
+			} else {
+				match = tree_entry_interesting(&entry, &name,
+							       0, pathspec);
+			}
+
 			if (match == all_entries_not_interesting)
 				break;
 			if (match == entry_not_interesting)
diff --git a/submodule.c b/submodule.c
index f2a5668..062e58b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -221,31 +221,30 @@ int is_submodule_initialized(const char *path)
 	module = submodule_from_path(null_sha1, path);
 
 	if (module) {
-		struct strbuf buf = STRBUF_INIT;
-		char *submodule_url = NULL;
+		char *key = xstrfmt("submodule.%s.url", module->name);
+		char *value = NULL;
 
-		strbuf_addf(&buf, "submodule.%s.url",module->name);
-		ret = !git_config_get_string(buf.buf, &submodule_url);
+		ret = !git_config_get_string(key, &value);
 
-		free(submodule_url);
-		strbuf_release(&buf);
+		free(value);
+		free(key);
 	}
 
 	return ret;
 }
 
 /*
- * Determine if a submodule has been checked out at a given 'path'
+ * Determine if a submodule has been populated at a given 'path'
  */
-int is_submodule_checked_out(const char *path)
+int is_submodule_populated(const char *path)
 {
 	int ret = 0;
-	struct strbuf buf = STRBUF_INIT;
+	char *gitdir = xstrfmt("%s/.git", path);
 
-	strbuf_addf(&buf, "%s/.git", path);
-	ret = file_exists(buf.buf);
+	if (resolve_gitdir(gitdir))
+		ret = 1;
 
-	strbuf_release(&buf);
+	free(gitdir);
 	return ret;
 }
 
diff --git a/submodule.h b/submodule.h
index 9a24ac8..9203d89 100644
--- a/submodule.h
+++ b/submodule.h
@@ -39,7 +39,7 @@ int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
 extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
 extern int is_submodule_initialized(const char *path);
-extern int is_submodule_checked_out(const char *path);
+extern int is_submodule_populated(const char *path);
 int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 3d1892d..ee173ad 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -127,6 +127,47 @@ test_expect_success 'grep tree and pathspecs' '
 	test_cmp expect actual
 '
 
+test_expect_success 'grep history with moved submoules' '
+	git init parent &&
+	echo "foobar" >parent/file &&
+	git -C parent add file &&
+	git -C parent commit -m "add file" &&
+
+	git init sub &&
+	echo "foobar" >sub/file &&
+	git -C sub add file &&
+	git -C sub commit -m "add file" &&
+
+	git -C parent submodule add ../sub &&
+	git -C parent commit -m "add submodule" &&
+
+	cat >expect <<-\EOF &&
+	file:foobar
+	sub/file:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules > actual &&
+	test_cmp expect actual &&
+
+	git -C parent mv sub sub-moved &&
+	git -C parent commit -m "moved submodule" &&
+
+	cat >expect <<-\EOF &&
+	file:foobar
+	sub-moved/file:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules > actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	HEAD^:file:foobar
+	HEAD^:sub/file:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules HEAD^ > actual &&
+	test_cmp expect actual &&
+
+	rm -rf parent sub
+'
+
 test_incompatible_with_recurse_submodules ()
 {
 	test_expect_success "--recurse-submodules and $1 are incompatible" "
diff --git a/tree-walk.c b/tree-walk.c
index b3f9961..828f435 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -999,11 +999,10 @@ static enum interesting do_match(const struct name_entry *entry,
 					return entry_interesting;
 
 				/*
-				 * Match all directories and gitlinks. We'll
-				 * try to match files later on.
+				 * Match all directories. We'll try to
+				 * match files later on.
 				 */
-				if (ps->recursive && (S_ISDIR(entry->mode) ||
-						      S_ISGITLINK(entry->mode)))
+				if (ps->recursive && S_ISDIR(entry->mode))
 					return entry_interesting;
 			}
 
@@ -1044,13 +1043,13 @@ static enum interesting do_match(const struct name_entry *entry,
 		strbuf_setlen(base, base_offset + baselen);
 
 		/*
-		 * Match all directories and gitlinks. We'll try to match files
-		 * later on.  max_depth is ignored but we may consider support
-		 * it in future, see
+		 * Match all directories. We'll try to match files
+		 * later on.
+		 * max_depth is ignored but we may consider support it
+		 * in future, see
 		 * http://thread.gmane.org/gmane.comp.version-control.git/163757/focus=163840
 		 */
-		if (ps->recursive && (S_ISDIR(entry->mode) ||
-				      S_ISGITLINK(entry->mode)))
+		if (ps->recursive && S_ISDIR(entry->mode))
 			return entry_interesting;
 	}
 	return never_interesting; /* No matches */

-- 
2.8.0.rc3.226.g39d4020

