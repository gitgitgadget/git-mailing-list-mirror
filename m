From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] Provide git_config with a callback-data parameter
Date: Wed, 14 May 2008 18:46:53 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805141846370.30431@racer>
References: <alpine.DEB.1.00.0805141844580.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 14 19:47:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwL4w-0002ZT-0H
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 19:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756610AbYENRq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 13:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757652AbYENRq6
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 13:46:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:41434 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761756AbYENRqx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 13:46:53 -0400
Received: (qmail invoked by alias); 14 May 2008 17:46:50 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp022) with SMTP; 14 May 2008 19:46:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1953b0ocQp5sdyGUacMvMrppZ4cF8cpD7xZYLbWzD
	PqXrS1A4YHeUkP
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0805141844580.30431@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82119>


git_config() only had a function parameter, but no callback data
parameter.  This assumes that all callback functions only modify
global variables.

With this patch, every callback gets a void * parameter, and it is hoped
that this will help the libification effort.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 alias.c                   |    5 +++--
 archive-tar.c             |    6 +++---
 builtin-add.c             |    6 +++---
 builtin-apply.c           |    6 +++---
 builtin-blame.c           |    6 +++---
 builtin-branch.c          |    6 +++---
 builtin-cat-file.c        |    2 +-
 builtin-checkout-index.c  |    2 +-
 builtin-checkout.c        |    2 +-
 builtin-clean.c           |    6 +++---
 builtin-clone.c           |    2 +-
 builtin-commit-tree.c     |    2 +-
 builtin-commit.c          |    8 ++++----
 builtin-config.c          |   26 ++++++++++++++------------
 builtin-diff-files.c      |    2 +-
 builtin-diff-index.c      |    2 +-
 builtin-diff-tree.c       |    2 +-
 builtin-diff.c            |    2 +-
 builtin-fast-export.c     |    2 +-
 builtin-fetch-pack.c      |    6 +++---
 builtin-fmt-merge-msg.c   |    4 ++--
 builtin-gc.c              |    6 +++---
 builtin-http-fetch.c      |    2 +-
 builtin-init-db.c         |    4 ++--
 builtin-log.c             |   18 +++++++++---------
 builtin-ls-files.c        |    2 +-
 builtin-ls-tree.c         |    2 +-
 builtin-mailinfo.c        |    2 +-
 builtin-merge-base.c      |    2 +-
 builtin-merge-recursive.c |    6 +++---
 builtin-mv.c              |    2 +-
 builtin-name-rev.c        |    2 +-
 builtin-pack-objects.c    |    6 +++---
 builtin-read-tree.c       |    4 +---
 builtin-reflog.c          |    6 +++---
 builtin-remote.c          |    8 ++++----
 builtin-rerere.c          |    6 +++---
 builtin-reset.c           |    2 +-
 builtin-rev-list.c        |    2 +-
 builtin-rev-parse.c       |    2 +-
 builtin-revert.c          |    2 +-
 builtin-rm.c              |    2 +-
 builtin-show-branch.c     |    6 +++---
 builtin-symbolic-ref.c    |    2 +-
 builtin-tag.c             |    6 +++---
 builtin-unpack-objects.c  |    2 +-
 builtin-update-index.c    |    2 +-
 builtin-update-ref.c      |    2 +-
 builtin-verify-pack.c     |    2 +-
 builtin-verify-tag.c      |    2 +-
 builtin-write-tree.c      |    2 +-
 cache.h                   |   10 +++++-----
 color.c                   |    4 ++--
 color.h                   |    2 +-
 config.c                  |   27 ++++++++++++++-------------
 connect.c                 |    7 ++++---
 convert.c                 |    4 ++--
 daemon.c                  |    4 ++--
 diff.c                    |    8 ++++----
 diff.h                    |    4 ++--
 fast-import.c             |    6 +++---
 hash-object.c             |    2 +-
 help.c                    |    6 +++---
 http.c                    |    6 +++---
 imap-send.c               |    4 ++--
 index-pack.c              |    6 +++---
 ll-merge.c                |    4 ++--
 pager.c                   |    2 +-
 receive-pack.c            |    6 +++---
 remote.c                  |    4 ++--
 setup.c                   |    4 ++--
 unpack-file.c             |    2 +-
 var.c                     |    8 ++++----
 wt-status.c               |    4 ++--
 wt-status.h               |    2 +-
 75 files changed, 179 insertions(+), 176 deletions(-)

diff --git a/alias.c b/alias.c
index 116cac8..995f3e6 100644
--- a/alias.c
+++ b/alias.c
@@ -2,7 +2,8 @@
 
 static const char *alias_key;
 static char *alias_val;
-static int alias_lookup_cb(const char *k, const char *v)
+
+static int alias_lookup_cb(const char *k, const char *v, void *cb)
 {
 	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key)) {
 		if (!v)
@@ -17,6 +18,6 @@ char *alias_lookup(const char *alias)
 {
 	alias_key = alias;
 	alias_val = NULL;
-	git_config(alias_lookup_cb);
+	git_config(alias_lookup_cb, NULL);
 	return alias_val;
 }
diff --git a/archive-tar.c b/archive-tar.c
index 4add802..d7598f9 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -220,7 +220,7 @@ static void write_global_extended_header(const unsigned char *sha1)
 	strbuf_release(&ext_header);
 }
 
-static int git_tar_config(const char *var, const char *value)
+static int git_tar_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "tar.umask")) {
 		if (value && !strcmp(value, "user")) {
@@ -231,7 +231,7 @@ static int git_tar_config(const char *var, const char *value)
 		}
 		return 0;
 	}
-	return git_default_config(var, value);
+	return git_default_config(var, value, cb);
 }
 
 static int write_tar_entry(const unsigned char *sha1,
@@ -268,7 +268,7 @@ int write_tar_archive(struct archiver_args *args)
 {
 	int plen = args->base ? strlen(args->base) : 0;
 
-	git_config(git_tar_config);
+	git_config(git_tar_config, NULL);
 
 	archive_time = args->time;
 	verbose = args->verbose;
diff --git a/builtin-add.c b/builtin-add.c
index 6edb6a9..64f4787 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -206,13 +206,13 @@ static struct option builtin_add_options[] = {
 	OPT_END(),
 };
 
-static int add_config(const char *var, const char *value)
+static int add_config(const char *var, const char *value, void *cb)
 {
 	if (!strcasecmp(var, "add.ignore-errors")) {
 		ignore_add_errors = git_config_bool(var, value);
 		return 0;
 	}
-	return git_default_config(var, value);
+	return git_default_config(var, value, cb);
 }
 
 int cmd_add(int argc, const char **argv, const char *prefix)
@@ -236,7 +236,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (add_interactive)
 		exit(interactive_add(argc, argv, prefix));
 
-	git_config(add_config);
+	git_config(add_config, NULL);
 
 	newfd = hold_locked_index(&lock_file, 1);
 
diff --git a/builtin-apply.c b/builtin-apply.c
index 1103625..bbdf08a 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2979,11 +2979,11 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 	return 0;
 }
 
-static int git_apply_config(const char *var, const char *value)
+static int git_apply_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "apply.whitespace"))
 		return git_config_string(&apply_default_whitespace, var, value);
-	return git_default_config(var, value);
+	return git_default_config(var, value, cb);
 }
 
 
@@ -2999,7 +2999,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 
 	prefix = setup_git_directory_gently(&is_not_gitdir);
 	prefix_length = prefix ? strlen(prefix) : 0;
-	git_config(git_apply_config);
+	git_config(git_apply_config, NULL);
 	if (apply_default_whitespace)
 		parse_whitespace_option(apply_default_whitespace);
 
diff --git a/builtin-blame.c b/builtin-blame.c
index 258ae42..3598866 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2028,7 +2028,7 @@ static void prepare_blame_range(struct scoreboard *sb,
 		usage(blame_usage);
 }
 
-static int git_blame_config(const char *var, const char *value)
+static int git_blame_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "blame.showroot")) {
 		show_root = git_config_bool(var, value);
@@ -2038,7 +2038,7 @@ static int git_blame_config(const char *var, const char *value)
 		blank_boundary = git_config_bool(var, value);
 		return 0;
 	}
-	return git_default_config(var, value);
+	return git_default_config(var, value, cb);
 }
 
 /*
@@ -2238,7 +2238,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	cmd_is_annotate = !strcmp(argv[0], "annotate");
 
-	git_config(git_blame_config);
+	git_config(git_blame_config, NULL);
 	save_commit_buffer = 0;
 
 	opt = 0;
diff --git a/builtin-branch.c b/builtin-branch.c
index 19c508a..d279702 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -63,7 +63,7 @@ static int parse_branch_color_slot(const char *var, int ofs)
 	die("bad config variable '%s'", var);
 }
 
-static int git_branch_config(const char *var, const char *value)
+static int git_branch_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "color.branch")) {
 		branch_use_color = git_config_colorbool(var, value, -1);
@@ -76,7 +76,7 @@ static int git_branch_config(const char *var, const char *value)
 		color_parse(value, var, branch_colors[slot]);
 		return 0;
 	}
-	return git_color_default_config(var, value);
+	return git_color_default_config(var, value, cb);
 }
 
 static const char *branch_get_color(enum color_branch ix)
@@ -461,7 +461,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	git_config(git_branch_config);
+	git_config(git_branch_config, NULL);
 
 	if (branch_use_color == -1)
 		branch_use_color = git_use_color_default;
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index f132d58..b488fad 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -85,7 +85,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	int opt;
 	const char *exp_type, *obj_name;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 	if (argc != 3)
 		usage("git-cat-file [-t|-s|-e|-p|<type>] <sha1>");
 	exp_type = argv[1];
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 7e42024..eb1fc9a 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -166,7 +166,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	int read_from_stdin = 0;
 	int prefix_length;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 	state.base_dir = "";
 	prefix_length = prefix ? strlen(prefix) : 0;
 
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 05c0642..2a7c636 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -514,7 +514,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	memset(&new, 0, sizeof(new));
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	opts.track = git_branch_track;
 
diff --git a/builtin-clean.c b/builtin-clean.c
index 6778a03..80a7ff9 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -19,11 +19,11 @@ static const char *const builtin_clean_usage[] = {
 	NULL
 };
 
-static int git_clean_config(const char *var, const char *value)
+static int git_clean_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "clean.requireforce"))
 		force = !git_config_bool(var, value);
-	return git_default_config(var, value);
+	return git_default_config(var, value, cb);
 }
 
 int cmd_clean(int argc, const char **argv, const char *prefix)
@@ -50,7 +50,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_clean_config);
+	git_config(git_clean_config, NULL);
 	if (force < 0)
 		force = 0;
 	else
diff --git a/builtin-clone.c b/builtin-clone.c
index a7c075d..e51ebd6 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -415,7 +415,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_reference)
 		setup_reference(git_dir);
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	if (option_bare) {
 		strcpy(branch_top, "refs/heads/");
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 6610d18..e5e4bdb 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -60,7 +60,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	struct strbuf buffer;
 	int encoding_is_utf8;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	if (argc < 2)
 		usage(commit_tree_usage);
diff --git a/builtin-commit.c b/builtin-commit.c
index 59af472..4cc714a 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -806,7 +806,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	const char *index_file;
 	int commitable;
 
-	git_config(git_status_config);
+	git_config(git_status_config, NULL);
 
 	if (wt_status_use_color == -1)
 		wt_status_use_color = git_use_color_default;
@@ -860,7 +860,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	}
 }
 
-int git_commit_config(const char *k, const char *v)
+int git_commit_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "commit.template")) {
 		if (!v)
@@ -869,7 +869,7 @@ int git_commit_config(const char *k, const char *v)
 		return 0;
 	}
 
-	return git_status_config(k, v);
+	return git_status_config(k, v, cb);
 }
 
 static const char commit_utf8_warn[] =
@@ -897,7 +897,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	unsigned char commit_sha1[20];
 	struct ref_lock *ref_lock;
 
-	git_config(git_commit_config);
+	git_config(git_commit_config, NULL);
 
 	argc = parse_and_validate_options(argc, argv, builtin_commit_usage);
 
diff --git a/builtin-config.c b/builtin-config.c
index 8ee01bd..3a441ef 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -18,7 +18,7 @@ static char key_delim = ' ';
 static char term = '\n';
 static enum { T_RAW, T_INT, T_BOOL, T_BOOL_OR_INT } type = T_RAW;
 
-static int show_all_config(const char *key_, const char *value_)
+static int show_all_config(const char *key_, const char *value_, void *cb)
 {
 	if (value_)
 		printf("%s%c%s%c", key_, delim, value_, term);
@@ -27,7 +27,7 @@ static int show_all_config(const char *key_, const char *value_)
 	return 0;
 }
 
-static int show_config(const char* key_, const char* value_)
+static int show_config(const char* key_, const char* value_, void *cb)
 {
 	char value[256];
 	const char *vptr = value;
@@ -121,14 +121,14 @@ static int get_value(const char* key_, const char* regex_)
 	}
 
 	if (do_all && system_wide)
-		git_config_from_file(show_config, system_wide);
+		git_config_from_file(show_config, system_wide, NULL);
 	if (do_all && global)
-		git_config_from_file(show_config, global);
-	git_config_from_file(show_config, local);
+		git_config_from_file(show_config, global, NULL);
+	git_config_from_file(show_config, local, NULL);
 	if (!do_all && !seen && global)
-		git_config_from_file(show_config, global);
+		git_config_from_file(show_config, global, NULL);
 	if (!do_all && !seen && system_wide)
-		git_config_from_file(show_config, system_wide);
+		git_config_from_file(show_config, system_wide, NULL);
 
 	free(key);
 	if (regexp) {
@@ -182,7 +182,7 @@ static int get_color_found;
 static const char *get_color_slot;
 static char parsed_color[COLOR_MAXLEN];
 
-static int git_get_color_config(const char *var, const char *value)
+static int git_get_color_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, get_color_slot)) {
 		if (!value)
@@ -218,7 +218,7 @@ static int get_color(int argc, const char **argv)
 
 	get_color_found = 0;
 	parsed_color[0] = '\0';
-	git_config(git_get_color_config);
+	git_config(git_get_color_config, NULL);
 
 	if (!get_color_found && def_color)
 		color_parse(def_color, "command line", parsed_color);
@@ -230,7 +230,8 @@ static int get_color(int argc, const char **argv)
 static int stdout_is_tty;
 static int get_colorbool_found;
 static int get_diff_color_found;
-static int git_get_colorbool_config(const char *var, const char *value)
+static int git_get_colorbool_config(const char *var, const char *value,
+		void *cb)
 {
 	if (!strcmp(var, get_color_slot)) {
 		get_colorbool_found =
@@ -265,7 +266,7 @@ static int get_colorbool(int argc, const char **argv)
 	get_colorbool_found = -1;
 	get_diff_color_found = -1;
 	get_color_slot = argv[0];
-	git_config(git_get_colorbool_config);
+	git_config(git_get_colorbool_config, NULL);
 
 	if (get_colorbool_found < 0) {
 		if (!strcmp(get_color_slot, "color.diff"))
@@ -298,7 +299,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l")) {
 			if (argc != 2)
 				usage(git_config_set_usage);
-			if (git_config(show_all_config) < 0 && file && errno)
+			if (git_config(show_all_config, NULL) < 0 &&
+					file && errno)
 				die("unable to read config file %s: %s", file,
 				    strerror(errno));
 			return 0;
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index e2306c1..907392a 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -21,7 +21,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 
 	prefix = setup_git_directory_gently(&nongit);
 	init_revisions(&rev, prefix);
-	git_config(git_diff_basic_config); /* no "diff" UI options */
+	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	rev.abbrev = 0;
 
 	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index 2b955de..2f44ebf 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -17,7 +17,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	int result;
 
 	init_revisions(&rev, prefix);
-	git_config(git_diff_basic_config); /* no "diff" UI options */
+	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	rev.abbrev = 0;
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 832797f..9d2a48f 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -68,7 +68,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	int read_stdin = 0;
 
 	init_revisions(opt, prefix);
-	git_config(git_diff_basic_config); /* no "diff" UI options */
+	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	nr_sha1 = 0;
 	opt->abbrev = 0;
 	opt->diff = 1;
diff --git a/builtin-diff.c b/builtin-diff.c
index 7c2a841..583291a 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -234,7 +234,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	 */
 
 	prefix = setup_git_directory_gently(&nongit);
-	git_config(git_diff_ui_config);
+	git_config(git_diff_ui_config, NULL);
 
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index a705029..2e740c2 100755
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -372,7 +372,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	};
 
 	/* we handle encodings */
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	init_revisions(&revs, prefix);
 	argc = setup_revisions(argc, argv, &revs, NULL);
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index c97a427..de1e8d1 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -635,7 +635,7 @@ static int remove_duplicates(int nr_heads, char **heads)
 	return dst;
 }
 
-static int fetch_pack_config(const char *var, const char *value)
+static int fetch_pack_config(const char *var, const char *value, void *cb)
 {
 	if (strcmp(var, "fetch.unpacklimit") == 0) {
 		fetch_unpack_limit = git_config_int(var, value);
@@ -647,7 +647,7 @@ static int fetch_pack_config(const char *var, const char *value)
 		return 0;
 	}
 
-	return git_default_config(var, value);
+	return git_default_config(var, value, cb);
 }
 
 static struct lock_file lock;
@@ -657,7 +657,7 @@ static void fetch_pack_setup(void)
 	static int did_setup;
 	if (did_setup)
 		return;
-	git_config(fetch_pack_config);
+	git_config(fetch_pack_config, NULL);
 	if (0 <= transfer_unpack_limit)
 		unpack_limit = transfer_unpack_limit;
 	else if (0 <= fetch_unpack_limit)
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index b72cb59..b892621 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -10,7 +10,7 @@ static const char *fmt_merge_msg_usage =
 
 static int merge_summary;
 
-static int fmt_merge_msg_config(const char *key, const char *value)
+static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
 	static int found_merge_log = 0;
 	if (!strcmp("merge.log", key)) {
@@ -260,7 +260,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	unsigned char head_sha1[20];
 	const char *current_branch;
 
-	git_config(fmt_merge_msg_config);
+	git_config(fmt_merge_msg_config, NULL);
 
 	while (argc > 1) {
 		if (!strcmp(argv[1], "--log") || !strcmp(argv[1], "--summary"))
diff --git a/builtin-gc.c b/builtin-gc.c
index 48f7d95..f5625bb 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -35,7 +35,7 @@ static const char *argv_repack[MAX_ADD] = {"repack", "-d", "-l", NULL};
 static const char *argv_prune[] = {"prune", "--expire", NULL, NULL};
 static const char *argv_rerere[] = {"rerere", "gc", NULL};
 
-static int gc_config(const char *var, const char *value)
+static int gc_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "gc.packrefs")) {
 		if (value && !strcmp(value, "notbare"))
@@ -67,7 +67,7 @@ static int gc_config(const char *var, const char *value)
 		prune_expire = xstrdup(value);
 		return 0;
 	}
-	return git_default_config(var, value);
+	return git_default_config(var, value, cb);
 }
 
 static void append_option(const char **cmd, const char *opt, int max_length)
@@ -226,7 +226,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(gc_config);
+	git_config(gc_config, NULL);
 
 	if (pack_refs < 0)
 		pack_refs = !is_bare_repository();
diff --git a/builtin-http-fetch.c b/builtin-http-fetch.c
index b1f3389..3a06248 100644
--- a/builtin-http-fetch.c
+++ b/builtin-http-fetch.c
@@ -18,7 +18,7 @@ int cmd_http_fetch(int argc, const char **argv, const char *prefix)
 	int get_verbosely = 0;
 	int get_recover = 0;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 5650685..0907366 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -144,7 +144,7 @@ static void copy_templates(const char *template_dir)
 	strcpy(template_path + template_len, "config");
 	repository_format_version = 0;
 	git_config_from_file(check_repository_format_version,
-			     template_path);
+			     template_path, NULL);
 	template_path[template_len] = 0;
 
 	if (repository_format_version &&
@@ -198,7 +198,7 @@ static int create_default_files(const char *template_path)
 	 */
 	copy_templates(template_path);
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	/*
 	 * We would have created the above under user's umask -- under
diff --git a/builtin-log.c b/builtin-log.c
index 9d046b2..3746a36 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -222,7 +222,7 @@ static int cmd_log_walk(struct rev_info *rev)
 	return 0;
 }
 
-static int git_log_config(const char *var, const char *value)
+static int git_log_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "format.pretty"))
 		return git_config_string(&fmt_pretty, var, value);
@@ -236,14 +236,14 @@ static int git_log_config(const char *var, const char *value)
 		default_show_root = git_config_bool(var, value);
 		return 0;
 	}
-	return git_diff_ui_config(var, value);
+	return git_diff_ui_config(var, value, cb);
 }
 
 int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
 
-	git_config(git_log_config);
+	git_config(git_log_config, NULL);
 
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
@@ -319,7 +319,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	struct object_array_entry *objects;
 	int i, count, ret = 0;
 
-	git_config(git_log_config);
+	git_config(git_log_config, NULL);
 
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
@@ -383,7 +383,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
 
-	git_config(git_log_config);
+	git_config(git_log_config, NULL);
 
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
@@ -416,7 +416,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
 
-	git_config(git_log_config);
+	git_config(git_log_config, NULL);
 
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
@@ -471,7 +471,7 @@ static void add_header(const char *value)
 	extra_hdr[extra_hdr_nr++] = xstrndup(value, len);
 }
 
-static int git_format_config(const char *var, const char *value)
+static int git_format_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "format.headers")) {
 		if (!value)
@@ -504,7 +504,7 @@ static int git_format_config(const char *var, const char *value)
 		return 0;
 	}
 
-	return git_log_config(var, value);
+	return git_log_config(var, value, cb);
 }
 
 
@@ -771,7 +771,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	char *add_signoff = NULL;
 	struct strbuf buf;
 
-	git_config(git_format_config);
+	git_config(git_format_config, NULL);
 	init_revisions(&rev, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.verbose_header = 1;
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index dc7eab8..75ba422 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -437,7 +437,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 	memset(&dir, 0, sizeof(dir));
 	if (prefix)
 		prefix_offset = strlen(prefix);
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 7abe333..f4a75dd 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -122,7 +122,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	unsigned char sha1[20];
 	struct tree *tree;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 	ls_tree_prefix = prefix;
 	if (prefix && *prefix)
 		chomp_prefix = strlen(prefix);
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 11f154b..6e23ffd 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -962,7 +962,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	/* NEEDSWORK: might want to do the optional .git/ directory
 	 * discovery
 	 */
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	def_charset = (git_commit_encoding ? git_commit_encoding : "utf-8");
 	metainfo_charset = def_charset;
diff --git a/builtin-merge-base.c b/builtin-merge-base.c
index 0108e22..bcf9395 100644
--- a/builtin-merge-base.c
+++ b/builtin-merge-base.c
@@ -28,7 +28,7 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	unsigned char rev1key[20], rev2key[20];
 	int show_all = 0;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	while (1 < argc && argv[1][0] == '-') {
 		const char *arg = argv[1];
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index fd4a032..25c9a90 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -1340,7 +1340,7 @@ static struct commit *get_ref(const char *ref)
 	return (struct commit *)object;
 }
 
-static int merge_config(const char *var, const char *value)
+static int merge_config(const char *var, const char *value, void *cb)
 {
 	if (!strcasecmp(var, "merge.verbosity")) {
 		verbosity = git_config_int(var, value);
@@ -1354,7 +1354,7 @@ static int merge_config(const char *var, const char *value)
 		merge_rename_limit = git_config_int(var, value);
 		return 0;
 	}
-	return git_default_config(var, value);
+	return git_default_config(var, value, cb);
 }
 
 int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
@@ -1375,7 +1375,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 			subtree_merge = 1;
 	}
 
-	git_config(merge_config);
+	git_config(merge_config, NULL);
 	if (getenv("GIT_MERGE_VERBOSITY"))
 		verbosity = strtol(getenv("GIT_MERGE_VERBOSITY"), NULL, 10);
 
diff --git a/builtin-mv.c b/builtin-mv.c
index c0e31d8..09a626e 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -82,7 +82,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	struct string_list deleted = {NULL, 0, 0, 0};
 	struct string_list changed = {NULL, 0, 0, 0};
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	newfd = hold_locked_index(&lock_file, 1);
 	if (read_cache() < 0)
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 384da4d..cde5de5 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -195,7 +195,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, opts, name_rev_usage, 0);
 	if (!!all + !!transform_stdin + !!argc > 1) {
 		error("Specify either a list, or --all, not both!");
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index f43eb67..70d2f5d 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1760,7 +1760,7 @@ static void prepare_pack(int window, int depth)
 	free(delta_list);
 }
 
-static int git_pack_config(const char *k, const char *v)
+static int git_pack_config(const char *k, const char *v, void *cb)
 {
 	if(!strcmp(k, "pack.window")) {
 		window = git_config_int(k, v);
@@ -1813,7 +1813,7 @@ static int git_pack_config(const char *k, const char *v)
 		pack_size_limit_cfg = git_config_ulong(k, v);
 		return 0;
 	}
-	return git_default_config(k, v);
+	return git_default_config(k, v, cb);
 }
 
 static void read_object_list_from_stdin(void)
@@ -2033,7 +2033,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	rp_av[1] = "--objects"; /* --thin will make it --objects-edge */
 	rp_ac = 2;
 
-	git_config(git_pack_config);
+	git_config(git_pack_config, NULL);
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level = core_compression_level;
 
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 7ac3088..5a09e17 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -104,12 +104,10 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	newfd = hold_locked_index(&lock_file, 1);
 
-	git_config(git_default_config);
-
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
diff --git a/builtin-reflog.c b/builtin-reflog.c
index 280e24e..897d1dc 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -329,7 +329,7 @@ static int collect_reflog(const char *ref, const unsigned char *sha1, int unused
 	return 0;
 }
 
-static int reflog_expire_config(const char *var, const char *value)
+static int reflog_expire_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "gc.reflogexpire")) {
 		if (!value)
@@ -343,7 +343,7 @@ static int reflog_expire_config(const char *var, const char *value)
 		default_reflog_expire_unreachable = approxidate(value);
 		return 0;
 	}
-	return git_default_config(var, value);
+	return git_default_config(var, value, cb);
 }
 
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
@@ -352,7 +352,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	unsigned long now = time(NULL);
 	int i, status, do_all;
 
-	git_config(reflog_expire_config);
+	git_config(reflog_expire_config, NULL);
 
 	save_commit_buffer = 0;
 	do_all = status = 0;
diff --git a/builtin-remote.c b/builtin-remote.c
index 4b4b2fc..1e1a87d 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -153,7 +153,7 @@ struct branch_info {
 
 static struct string_list branch_list;
 
-static int config_read_branches(const char *key, const char *value)
+static int config_read_branches(const char *key, const char *value, void *cb)
 {
 	if (!prefixcmp(key, "branch.")) {
 		char *name;
@@ -200,7 +200,7 @@ static void read_branches(void)
 {
 	if (branch_list.nr)
 		return;
-	git_config(config_read_branches);
+	git_config(config_read_branches, NULL);
 	sort_string_list(&branch_list);
 }
 
@@ -515,7 +515,7 @@ struct remote_group {
 	struct string_list *list;
 } remote_group;
 
-static int get_remote_group(const char *key, const char *value)
+static int get_remote_group(const char *key, const char *value, void *cb)
 {
 	if (!prefixcmp(key, "remotes.") &&
 			!strcmp(key + 8, remote_group.name)) {
@@ -547,7 +547,7 @@ static int update(int argc, const char **argv)
 	remote_group.list = &list;
 	for (i = 1; i < argc; i++) {
 		remote_group.name = argv[i];
-		result = git_config(get_remote_group);
+		result = git_config(get_remote_group, NULL);
 	}
 
 	if (!result && !list.nr  && argc == 2 && !strcmp(argv[1], "default"))
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 963b19e..0096a42 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -339,7 +339,7 @@ tail_optimization:
 	return write_rr(rr, fd);
 }
 
-static int git_rerere_config(const char *var, const char *value)
+static int git_rerere_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "gc.rerereresolved"))
 		cutoff_resolve = git_config_int(var, value);
@@ -348,7 +348,7 @@ static int git_rerere_config(const char *var, const char *value)
 	else if (!strcmp(var, "rerere.enabled"))
 		rerere_enabled = git_config_bool(var, value);
 	else
-		return git_default_config(var, value);
+		return git_default_config(var, value, cb);
 	return 0;
 }
 
@@ -376,7 +376,7 @@ static int setup_rerere(struct string_list *merge_rr)
 {
 	int fd;
 
-	git_config(git_rerere_config);
+	git_config(git_rerere_config, NULL);
 	if (!is_rerere_enabled())
 		return -1;
 
diff --git a/builtin-reset.c b/builtin-reset.c
index 79424bb..e32ddd9 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -186,7 +186,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index a965294..a0f0bf2 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -598,7 +598,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int bisect_find_all = 0;
 	int quiet = 0;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 	init_revisions(&revs, prefix);
 	revs.abbrev = 0;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index f8d8548..1d019b3 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -381,7 +381,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		return cmd_parseopt(argc - 1, argv + 1, prefix);
 
 	prefix = setup_git_directory();
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
diff --git a/builtin-revert.c b/builtin-revert.c
index 2b57525..0270f9b 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -269,7 +269,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	const char *message, *encoding;
 	const char *defmsg = xstrdup(git_path("MERGE_MSG"));
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 	me = action == REVERT ? "revert" : "cherry-pick";
 	setenv(GIT_REFLOG_ACTION, me, 0);
 	parse_args(argc, argv);
diff --git a/builtin-rm.c b/builtin-rm.c
index c0a8bb6..22c9bd1 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -144,7 +144,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	const char **pathspec;
 	char *seen;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	newfd = hold_locked_index(&lock_file, 1);
 
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 019abd3..ee4269d 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -533,7 +533,7 @@ static void append_one_rev(const char *av)
 	die("bad sha1 reference %s", av);
 }
 
-static int git_show_branch_config(const char *var, const char *value)
+static int git_show_branch_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "showbranch.default")) {
 		if (!value)
@@ -547,7 +547,7 @@ static int git_show_branch_config(const char *var, const char *value)
 		return 0;
 	}
 
-	return git_default_config(var, value);
+	return git_default_config(var, value, cb);
 }
 
 static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
@@ -611,7 +611,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	int reflog = 0;
 	const char *reflog_base = NULL;
 
-	git_config(git_show_branch_config);
+	git_config(git_show_branch_config, NULL);
 
 	/* If nothing is specified, try the default first */
 	if (ac == 1 && default_num) {
diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index d33982b..b49bdb6 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -35,7 +35,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, options, git_symbolic_ref_usage, 0);
 	if (msg &&!*msg)
 		die("Refusing to perform update with empty message");
diff --git a/builtin-tag.c b/builtin-tag.c
index 129ff57..e675206 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -256,7 +256,7 @@ static void set_signingkey(const char *value)
 		die("signing key value too long (%.10s...)", value);
 }
 
-static int git_tag_config(const char *var, const char *value)
+static int git_tag_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "user.signingkey")) {
 		if (!value)
@@ -265,7 +265,7 @@ static int git_tag_config(const char *var, const char *value)
 		return 0;
 	}
 
-	return git_default_config(var, value);
+	return git_default_config(var, value, cb);
 }
 
 static void write_tag_body(int fd, const unsigned char *sha1)
@@ -408,7 +408,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_tag_config);
+	git_config(git_tag_config, NULL);
 
 	argc = parse_options(argc, argv, options, git_tag_usage, 0);
 
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index fecf0be..85043d1 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -493,7 +493,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 	int i;
 	unsigned char sha1[20];
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	quiet = !isatty(2);
 
diff --git a/builtin-update-index.c b/builtin-update-index.c
index a8795d3..e1ca8de 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -567,7 +567,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	int lock_error = 0;
 	struct lock_file *lock_file;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
 	lock_file = xcalloc(1, sizeof(struct lock_file));
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index e90737c..93c1271 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -22,7 +22,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, options, git_update_ref_usage, 0);
 	if (msg && !*msg)
 		die("Refusing to perform update with empty message.");
diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index 4958bbb..4c515a0 100644
--- a/builtin-verify-pack.c
+++ b/builtin-verify-pack.c
@@ -55,7 +55,7 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 	int no_more_options = 0;
 	int nothing_done = 1;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 	while (1 < argc) {
 		if (!no_more_options && argv[1][0] == '-') {
 			if (!strcmp("-v", argv[1]))
diff --git a/builtin-verify-tag.c b/builtin-verify-tag.c
index db81496..92eaa89 100644
--- a/builtin-verify-tag.c
+++ b/builtin-verify-tag.c
@@ -90,7 +90,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	if (argc == 1)
 		usage(builtin_verify_tag_usage);
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index e838d01..c218799 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -18,7 +18,7 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 	unsigned char sha1[20];
 	const char *me = "git-write-tree";
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 	while (1 < argc) {
 		const char *arg = argv[1];
 		if (!strcmp(arg, "--missing-ok"))
diff --git a/cache.h b/cache.h
index c761915..b79df28 100644
--- a/cache.h
+++ b/cache.h
@@ -719,10 +719,10 @@ extern int matches_pack_name(struct packed_git *p, const char *name);
 /* Dumb servers support */
 extern int update_server_info(int);
 
-typedef int (*config_fn_t)(const char *, const char *);
-extern int git_default_config(const char *, const char *);
-extern int git_config_from_file(config_fn_t fn, const char *);
-extern int git_config(config_fn_t fn);
+typedef int (*config_fn_t)(const char *, const char *, void *);
+extern int git_default_config(const char *, const char *, void *);
+extern int git_config_from_file(config_fn_t fn, const char *, void *);
+extern int git_config(config_fn_t fn, void *);
 extern int git_parse_long(const char *, long *);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
@@ -734,7 +734,7 @@ extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
 extern const char *git_etc_gitconfig(void);
-extern int check_repository_format_version(const char *var, const char *value);
+extern int check_repository_format_version(const char *var, const char *value, void *cb);
 extern int git_env_bool(const char *, int);
 extern int git_config_system(void);
 extern int git_config_global(void);
diff --git a/color.c b/color.c
index 12a6453..fc0b72a 100644
--- a/color.c
+++ b/color.c
@@ -145,14 +145,14 @@ int git_config_colorbool(const char *var, const char *value, int stdout_is_tty)
 	return 0;
 }
 
-int git_color_default_config(const char *var, const char *value)
+int git_color_default_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "color.ui")) {
 		git_use_color_default = git_config_colorbool(var, value, -1);
 		return 0;
 	}
 
-	return git_default_config(var, value);
+	return git_default_config(var, value, cb);
 }
 
 static int color_vfprintf(FILE *fp, const char *color, const char *fmt,
diff --git a/color.h b/color.h
index ecda556..6cf5c88 100644
--- a/color.h
+++ b/color.h
@@ -13,7 +13,7 @@ extern int git_use_color_default;
 /*
  * Use this instead of git_default_config if you need the value of color.ui.
  */
-int git_color_default_config(const char *var, const char *value);
+int git_color_default_config(const char *var, const char *value, void *cb);
 
 int git_config_colorbool(const char *var, const char *value, int stdout_is_tty);
 void color_parse(const char *var, const char *value, char *dst);
diff --git a/config.c b/config.c
index 5195de1..c2f2bbb 100644
--- a/config.c
+++ b/config.c
@@ -111,7 +111,7 @@ static inline int iskeychar(int c)
 	return isalnum(c) || c == '-';
 }
 
-static int get_value(config_fn_t fn, char *name, unsigned int len)
+static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
 {
 	int c;
 	char *value;
@@ -139,7 +139,7 @@ static int get_value(config_fn_t fn, char *name, unsigned int len)
 		if (!value)
 			return -1;
 	}
-	return fn(name, value);
+	return fn(name, value, data);
 }
 
 static int get_extended_base_var(char *name, int baselen, int c)
@@ -197,7 +197,7 @@ static int get_base_var(char *name)
 	}
 }
 
-static int git_parse_file(config_fn_t fn)
+static int git_parse_file(config_fn_t fn, void *data)
 {
 	int comment = 0;
 	int baselen = 0;
@@ -228,7 +228,7 @@ static int git_parse_file(config_fn_t fn)
 		if (!isalpha(c))
 			break;
 		var[baselen] = tolower(c);
-		if (get_value(fn, var, baselen+1) < 0)
+		if (get_value(fn, data, var, baselen+1) < 0)
 			break;
 	}
 	die("bad config file line %d in %s", config_linenr, config_file_name);
@@ -332,7 +332,7 @@ int git_config_string(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
-int git_default_config(const char *var, const char *value)
+int git_default_config(const char *var, const char *value, void *dummy)
 {
 	/* This needs a better name */
 	if (!strcmp(var, "core.filemode")) {
@@ -516,7 +516,7 @@ int git_default_config(const char *var, const char *value)
 	return 0;
 }
 
-int git_config_from_file(config_fn_t fn, const char *filename)
+int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 {
 	int ret;
 	FILE *f = fopen(filename, "r");
@@ -527,7 +527,7 @@ int git_config_from_file(config_fn_t fn, const char *filename)
 		config_file_name = filename;
 		config_linenr = 1;
 		config_file_eof = 0;
-		ret = git_parse_file(fn);
+		ret = git_parse_file(fn, data);
 		fclose(f);
 		config_file_name = NULL;
 	}
@@ -565,7 +565,7 @@ int git_config_global(void)
 	return !git_env_bool("GIT_CONFIG_NOGLOBAL", 0);
 }
 
-int git_config(config_fn_t fn)
+int git_config(config_fn_t fn, void *data)
 {
 	int ret = 0;
 	char *repo_config = NULL;
@@ -578,7 +578,8 @@ int git_config(config_fn_t fn)
 	filename = getenv(CONFIG_ENVIRONMENT);
 	if (!filename) {
 		if (git_config_system() && !access(git_etc_gitconfig(), R_OK))
-			ret += git_config_from_file(fn, git_etc_gitconfig());
+			ret += git_config_from_file(fn, git_etc_gitconfig(),
+				data);
 		home = getenv("HOME");
 		filename = getenv(CONFIG_LOCAL_ENVIRONMENT);
 		if (!filename)
@@ -588,11 +589,11 @@ int git_config(config_fn_t fn)
 	if (git_config_global() && home) {
 		char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
 		if (!access(user_config, R_OK))
-			ret = git_config_from_file(fn, user_config);
+			ret = git_config_from_file(fn, user_config, data);
 		free(user_config);
 	}
 
-	ret += git_config_from_file(fn, filename);
+	ret += git_config_from_file(fn, filename, data);
 	free(repo_config);
 	return ret;
 }
@@ -622,7 +623,7 @@ static int matches(const char* key, const char* value)
 		  !regexec(store.value_regex, value, 0, NULL, 0)));
 }
 
-static int store_aux(const char* key, const char* value)
+static int store_aux(const char* key, const char* value, void *cb)
 {
 	const char *ep;
 	size_t section_len;
@@ -951,7 +952,7 @@ int git_config_set_multivar(const char* key, const char* value,
 		 * As a side effect, we make sure to transform only a valid
 		 * existing config file.
 		 */
-		if (git_config_from_file(store_aux, config_filename)) {
+		if (git_config_from_file(store_aux, config_filename, NULL)) {
 			error("invalid config file %s", config_filename);
 			free(store.key);
 			if (store.value_regex != NULL) {
diff --git a/connect.c b/connect.c
index d12b105..e92af29 100644
--- a/connect.c
+++ b/connect.c
@@ -360,7 +360,8 @@ static char *git_proxy_command;
 static const char *rhost_name;
 static int rhost_len;
 
-static int git_proxy_command_options(const char *var, const char *value)
+static int git_proxy_command_options(const char *var, const char *value,
+		void *cb)
 {
 	if (!strcmp(var, "core.gitproxy")) {
 		const char *for_pos;
@@ -404,7 +405,7 @@ static int git_proxy_command_options(const char *var, const char *value)
 		return 0;
 	}
 
-	return git_default_config(var, value);
+	return git_default_config(var, value, cb);
 }
 
 static int git_use_proxy(const char *host)
@@ -412,7 +413,7 @@ static int git_use_proxy(const char *host)
 	rhost_name = host;
 	rhost_len = strlen(host);
 	git_proxy_command = getenv("GIT_PROXY_COMMAND");
-	git_config(git_proxy_command_options);
+	git_config(git_proxy_command_options, NULL);
 	rhost_name = NULL;
 	return (git_proxy_command && *git_proxy_command);
 }
diff --git a/convert.c b/convert.c
index d8c94cb..1c66844 100644
--- a/convert.c
+++ b/convert.c
@@ -323,7 +323,7 @@ static struct convert_driver {
 	char *clean;
 } *user_convert, **user_convert_tail;
 
-static int read_convert_config(const char *var, const char *value)
+static int read_convert_config(const char *var, const char *value, void *cb)
 {
 	const char *ep, *name;
 	int namelen;
@@ -385,7 +385,7 @@ static void setup_convert_check(struct git_attr_check *check)
 		attr_ident = git_attr("ident", 5);
 		attr_filter = git_attr("filter", 6);
 		user_convert_tail = &user_convert;
-		git_config(read_convert_config);
+		git_config(read_convert_config, NULL);
 	}
 	check[0].attr = attr_crlf;
 	check[1].attr = attr_ident;
diff --git a/daemon.c b/daemon.c
index 2b4a6f1..63cd12c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -306,7 +306,7 @@ struct daemon_service {
 static struct daemon_service *service_looking_at;
 static int service_enabled;
 
-static int git_daemon_config(const char *var, const char *value)
+static int git_daemon_config(const char *var, const char *value, void *cb)
 {
 	if (!prefixcmp(var, "daemon.") &&
 	    !strcmp(var + 7, service_looking_at->config_name)) {
@@ -356,7 +356,7 @@ static int run_service(struct interp *itable, struct daemon_service *service)
 	if (service->overridable) {
 		service_looking_at = service;
 		service_enabled = -1;
-		git_config(git_daemon_config);
+		git_config(git_daemon_config, NULL);
 		if (0 <= service_enabled)
 			enabled = service_enabled;
 	}
diff --git a/diff.c b/diff.c
index 439d474..f77edaf 100644
--- a/diff.c
+++ b/diff.c
@@ -129,7 +129,7 @@ static int parse_funcname_pattern(const char *var, const char *ep, const char *v
  * never be affected by the setting of diff.renames
  * the user happens to have in the configuration file.
  */
-int git_diff_ui_config(const char *var, const char *value)
+int git_diff_ui_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "diff.renamelimit")) {
 		diff_rename_limit_default = git_config_int(var, value);
@@ -166,10 +166,10 @@ int git_diff_ui_config(const char *var, const char *value)
 			return parse_lldiff_command(var, ep, value);
 	}
 
-	return git_diff_basic_config(var, value);
+	return git_diff_basic_config(var, value, cb);
 }
 
-int git_diff_basic_config(const char *var, const char *value)
+int git_diff_basic_config(const char *var, const char *value, void *cb)
 {
 	if (!prefixcmp(var, "diff.color.") || !prefixcmp(var, "color.diff.")) {
 		int slot = parse_diff_color_slot(var, 11);
@@ -190,7 +190,7 @@ int git_diff_basic_config(const char *var, const char *value)
 		}
 	}
 
-	return git_color_default_config(var, value);
+	return git_color_default_config(var, value, cb);
 }
 
 static char *quote_two(const char *one, const char *two)
diff --git a/diff.h b/diff.h
index 3a02d38..f190e02 100644
--- a/diff.h
+++ b/diff.h
@@ -181,8 +181,8 @@ extern void diff_unmerge(struct diff_options *,
 #define DIFF_SETUP_USE_CACHE		2
 #define DIFF_SETUP_USE_SIZE_CACHE	4
 
-extern int git_diff_basic_config(const char *var, const char *value);
-extern int git_diff_ui_config(const char *var, const char *value);
+extern int git_diff_basic_config(const char *var, const char *value, void *cb);
+extern int git_diff_ui_config(const char *var, const char *value, void *cb);
 extern int diff_use_color_default;
 extern void diff_setup(struct diff_options *);
 extern int diff_opt_parse(struct diff_options *, const char **, int);
diff --git a/fast-import.c b/fast-import.c
index 73e5439..36ec5b8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2352,7 +2352,7 @@ static void import_marks(const char *input_file)
 	fclose(f);
 }
 
-static int git_pack_config(const char *k, const char *v)
+static int git_pack_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "pack.depth")) {
 		max_depth = git_config_int(k, v);
@@ -2370,7 +2370,7 @@ static int git_pack_config(const char *k, const char *v)
 		pack_compression_seen = 1;
 		return 0;
 	}
-	return git_default_config(k, v);
+	return git_default_config(k, v, cb);
 }
 
 static const char fast_import_usage[] =
@@ -2381,7 +2381,7 @@ int main(int argc, const char **argv)
 	unsigned int i, show_stats = 1;
 
 	setup_git_directory();
-	git_config(git_pack_config);
+	git_config(git_pack_config, NULL);
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level = core_compression_level;
 
diff --git a/hash-object.c b/hash-object.c
index 61e7160..3d77390 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -43,7 +43,7 @@ int main(int argc, char **argv)
 	int no_more_flags = 0;
 	int hashstdin = 0;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	for (i = 1 ; i < argc; i++) {
 		if (!no_more_flags && argv[i][0] == '-') {
diff --git a/help.c b/help.c
index af80979..d89d437 100644
--- a/help.c
+++ b/help.c
@@ -252,7 +252,7 @@ static int add_man_viewer_info(const char *var, const char *value)
 	return 0;
 }
 
-static int git_help_config(const char *var, const char *value)
+static int git_help_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "help.format")) {
 		if (!value)
@@ -269,7 +269,7 @@ static int git_help_config(const char *var, const char *value)
 	if (!prefixcmp(var, "man."))
 		return add_man_viewer_info(var, value);
 
-	return git_default_config(var, value);
+	return git_default_config(var, value, cb);
 }
 
 /* most GUI terminals set COLUMNS (although some don't export it) */
@@ -641,7 +641,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	const char *alias;
 
 	setup_git_directory_gently(&nongit);
-	git_config(git_help_config);
+	git_config(git_help_config, NULL);
 
 	argc = parse_options(argc, argv, builtin_help_options,
 			builtin_help_usage, 0);
diff --git a/http.c b/http.c
index acf746a..2a21ccb 100644
--- a/http.c
+++ b/http.c
@@ -90,7 +90,7 @@ static void process_curl_messages(void)
 }
 #endif
 
-static int http_options(const char *var, const char *value)
+static int http_options(const char *var, const char *value, void *cb)
 {
 	if (!strcmp("http.sslverify", var)) {
 		if (curl_ssl_verify == -1) {
@@ -169,7 +169,7 @@ static int http_options(const char *var, const char *value)
 	}
 
 	/* Fall back on the default ones */
-	return git_default_config(var, value);
+	return git_default_config(var, value, cb);
 }
 
 static CURL* get_curl_handle(void)
@@ -263,7 +263,7 @@ void http_init(struct remote *remote)
 	if (low_speed_time != NULL)
 		curl_low_speed_time = strtol(low_speed_time, NULL, 10);
 
-	git_config(http_options);
+	git_config(http_options, NULL);
 
 	if (curl_ssl_verify == -1)
 		curl_ssl_verify = 1;
diff --git a/imap-send.c b/imap-send.c
index db65597..1ec1310 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1247,7 +1247,7 @@ static imap_server_conf_t server =
 static char *imap_folder;
 
 static int
-git_imap_config(const char *key, const char *val)
+git_imap_config(const char *key, const char *val, void *cb)
 {
 	char imap_key[] = "imap.";
 
@@ -1296,7 +1296,7 @@ main(int argc, char **argv)
 	/* init the random number generator */
 	arc4_init();
 
-	git_config( git_imap_config );
+	git_config(git_imap_config, NULL);
 
 	if (!imap_folder) {
 		fprintf( stderr, "no imap store specified\n" );
diff --git a/index-pack.c b/index-pack.c
index 9c0c278..aaba944 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -765,7 +765,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	}
 }
 
-static int git_index_pack_config(const char *k, const char *v)
+static int git_index_pack_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "pack.indexversion")) {
 		pack_idx_default_version = git_config_int(k, v);
@@ -773,7 +773,7 @@ static int git_index_pack_config(const char *k, const char *v)
 			die("bad pack.indexversion=%d", pack_idx_default_version);
 		return 0;
 	}
-	return git_default_config(k, v);
+	return git_default_config(k, v, cb);
 }
 
 int main(int argc, char **argv)
@@ -786,7 +786,7 @@ int main(int argc, char **argv)
 	struct pack_idx_entry **idx_objects;
 	unsigned char sha1[20];
 
-	git_config(git_index_pack_config);
+	git_config(git_index_pack_config, NULL);
 
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
diff --git a/ll-merge.c b/ll-merge.c
index 5ae7433..9837c84 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -225,7 +225,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 static struct ll_merge_driver *ll_user_merge, **ll_user_merge_tail;
 static const char *default_ll_merge;
 
-static int read_merge_config(const char *var, const char *value)
+static int read_merge_config(const char *var, const char *value, void *cb)
 {
 	struct ll_merge_driver *fn;
 	const char *ep, *name;
@@ -309,7 +309,7 @@ static void initialize_ll_merge(void)
 	if (ll_user_merge_tail)
 		return;
 	ll_user_merge_tail = &ll_user_merge;
-	git_config(read_merge_config);
+	git_config(read_merge_config, NULL);
 }
 
 static const struct ll_merge_driver *find_ll_merge_driver(const char *merge_attr)
diff --git a/pager.c b/pager.c
index ca002f9..dbd9414 100644
--- a/pager.c
+++ b/pager.c
@@ -33,7 +33,7 @@ void setup_pager(void)
 		return;
 	if (!pager) {
 		if (!pager_program)
-			git_config(git_default_config);
+			git_config(git_default_config, NULL);
 		pager = pager_program;
 	}
 	if (!pager)
diff --git a/receive-pack.c b/receive-pack.c
index e9de36c..cf45020 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -19,7 +19,7 @@ static int report_status;
 static char capabilities[] = " report-status delete-refs tellme-more ";
 static int capabilities_sent;
 
-static int receive_pack_config(const char *var, const char *value)
+static int receive_pack_config(const char *var, const char *value, void *cb)
 {
 	if (strcmp(var, "receive.denynonfastforwards") == 0) {
 		deny_non_fast_forwards = git_config_bool(var, value);
@@ -41,7 +41,7 @@ static int receive_pack_config(const char *var, const char *value)
 		return 0;
 	}
 
-	return git_default_config(var, value);
+	return git_default_config(var, value, cb);
 }
 
 static int show_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
@@ -638,7 +638,7 @@ int main(int argc, char **argv)
 	if (is_repository_shallow())
 		die("attempt to push into a shallow repository");
 
-	git_config(receive_pack_config);
+	git_config(receive_pack_config, NULL);
 
 	if (0 <= transfer_unpack_limit)
 		unpack_limit = transfer_unpack_limit;
diff --git a/remote.c b/remote.c
index 05041ed..c7ba617 100644
--- a/remote.c
+++ b/remote.c
@@ -297,7 +297,7 @@ static void read_branches_file(struct remote *remote)
 	remote->fetch_tags = 1; /* always auto-follow */
 }
 
-static int handle_config(const char *key, const char *value)
+static int handle_config(const char *key, const char *value, void *cb)
 {
 	const char *name;
 	const char *subkey;
@@ -419,7 +419,7 @@ static void read_config(void)
 		current_branch =
 			make_branch(head_ref + strlen("refs/heads/"), 0);
 	}
-	git_config(handle_config);
+	git_config(handle_config, NULL);
 	alias_all_urls();
 }
 
diff --git a/setup.c b/setup.c
index b8fd476..d630e37 100644
--- a/setup.c
+++ b/setup.c
@@ -300,7 +300,7 @@ void setup_work_tree(void)
 
 static int check_repository_format_gently(int *nongit_ok)
 {
-	git_config(check_repository_format_version);
+	git_config(check_repository_format_version, NULL);
 	if (GIT_REPO_VERSION < repository_format_version) {
 		if (!nongit_ok)
 			die ("Expected git repo version <= %d, found %d",
@@ -524,7 +524,7 @@ int git_config_perm(const char *var, const char *value)
 	return i & 0666;
 }
 
-int check_repository_format_version(const char *var, const char *value)
+int check_repository_format_version(const char *var, const char *value, void *cb)
 {
 	if (strcmp(var, "core.repositoryformatversion") == 0)
 		repository_format_version = git_config_int(var, value);
diff --git a/unpack-file.c b/unpack-file.c
index 65c66eb..bcdc8bb 100644
--- a/unpack-file.c
+++ b/unpack-file.c
@@ -31,7 +31,7 @@ int main(int argc, char **argv)
 		die("Not a valid object name %s", argv[1]);
 
 	setup_git_directory();
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	puts(create_temp_file(sha1));
 	return 0;
diff --git a/var.c b/var.c
index c20ac91..724ba87 100644
--- a/var.c
+++ b/var.c
@@ -39,13 +39,13 @@ static const char *read_var(const char *var)
 	return val;
 }
 
-static int show_config(const char *var, const char *value)
+static int show_config(const char *var, const char *value, void *cb)
 {
 	if (value)
 		printf("%s=%s\n", var, value);
 	else
 		printf("%s\n", var);
-	return git_default_config(var, value);
+	return git_default_config(var, value, cb);
 }
 
 int main(int argc, char **argv)
@@ -60,11 +60,11 @@ int main(int argc, char **argv)
 	val = NULL;
 
 	if (strcmp(argv[1], "-l") == 0) {
-		git_config(show_config);
+		git_config(show_config, NULL);
 		list_vars();
 		return 0;
 	}
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 	val = read_var(argv[1]);
 	if (!val)
 		usage(var_usage);
diff --git a/wt-status.c b/wt-status.c
index a44c543..9bb5ea6 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -362,7 +362,7 @@ void wt_status_print(struct wt_status *s)
 	}
 }
 
-int git_status_config(const char *k, const char *v)
+int git_status_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "status.submodulesummary")) {
 		int is_bool;
@@ -386,5 +386,5 @@ int git_status_config(const char *k, const char *v)
 		wt_status_relative_paths = git_config_bool(k, v);
 		return 0;
 	}
-	return git_color_default_config(k, v);
+	return git_color_default_config(k, v, cb);
 }
diff --git a/wt-status.h b/wt-status.h
index 7d61410..f2c7130 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -27,7 +27,7 @@ struct wt_status {
 	const char *prefix;
 };
 
-int git_status_config(const char *var, const char *value);
+int git_status_config(const char *var, const char *value, void *cb);
 extern int wt_status_use_color;
 extern int wt_status_relative_paths;
 void wt_status_prepare(struct wt_status *s);
-- 
1.5.5.1.375.g1becb
