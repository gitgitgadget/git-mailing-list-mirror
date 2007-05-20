From: skimo@liacs.nl
Subject: [PATCH 12/15] git_config: add void * for callback data
Date: Sun, 20 May 2007 20:04:45 +0200
Message-ID: <11796842893963-git-send-email-skimo@liacs.nl>
References: <11796842882917-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 20:06:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hppmv-0007La-9W
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757115AbXETSF3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757391AbXETSF3
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:05:29 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:37222 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757115AbXETSFF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:05:05 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4KI4sUT007824;
	Sun, 20 May 2007 20:04:59 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 0C2977DDAB; Sun, 20 May 2007 20:04:49 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11796842882917-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47875>

From: Sven Verdoolaege <skimo@kotnet.org>

---
 archive-tar.c            |    6 +++---
 builtin-add.c            |    6 +++---
 builtin-apply.c          |    6 +++---
 builtin-blame.c          |    6 +++---
 builtin-branch.c         |   10 +++++-----
 builtin-cat-file.c       |    2 +-
 builtin-checkout-index.c |    2 +-
 builtin-commit-tree.c    |    2 +-
 builtin-config.c         |   21 +++++++++++----------
 builtin-diff-files.c     |    2 +-
 builtin-diff-index.c     |    2 +-
 builtin-diff-tree.c      |    2 +-
 builtin-diff.c           |    2 +-
 builtin-fmt-merge-msg.c  |    5 +++--
 builtin-gc.c             |    6 +++---
 builtin-init-db.c        |    4 ++--
 builtin-log.c            |   18 +++++++++---------
 builtin-ls-files.c       |    2 +-
 builtin-ls-tree.c        |    2 +-
 builtin-mailinfo.c       |    2 +-
 builtin-merge-base.c     |    2 +-
 builtin-mv.c             |    2 +-
 builtin-name-rev.c       |    2 +-
 builtin-pack-objects.c   |    6 +++---
 builtin-push.c           |    4 ++--
 builtin-read-tree.c      |    9 +++++----
 builtin-reflog.c         |    7 ++++---
 builtin-rerere.c         |    6 +++---
 builtin-rev-list.c       |    2 +-
 builtin-rev-parse.c      |    2 +-
 builtin-revert.c         |    2 +-
 builtin-rm.c             |    2 +-
 builtin-runstatus.c      |    2 +-
 builtin-show-branch.c    |    7 ++++---
 builtin-symbolic-ref.c   |    2 +-
 builtin-unpack-objects.c |    2 +-
 builtin-update-index.c   |    2 +-
 builtin-update-ref.c     |    2 +-
 builtin-verify-pack.c    |    2 +-
 cache.h                  |   13 +++++++------
 config.c                 |   36 ++++++++++++++++++------------------
 connect.c                |    7 ++++---
 convert.c                |    5 +++--
 daemon.c                 |    4 ++--
 diff.c                   |    6 +++---
 diff.h                   |    2 +-
 dump-config.c            |    4 ++--
 fast-import.c            |    2 +-
 fetch-pack.c             |    6 +++---
 git.c                    |    4 ++--
 http-fetch.c             |    2 +-
 http.c                   |    6 +++---
 imap-send.c              |    4 ++--
 local-fetch.c            |    2 +-
 merge-recursive.c        |   10 +++++-----
 receive-pack.c           |    6 +++---
 send-pack.c              |    2 +-
 setup.c                  |    5 +++--
 ssh-fetch.c              |    2 +-
 unpack-file.c            |    2 +-
 var.c                    |    8 ++++----
 wt-status.c              |    4 ++--
 wt-status.h              |    2 +-
 63 files changed, 163 insertions(+), 154 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 33e7657..595c153 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -242,7 +242,7 @@ static void write_global_extended_header(const unsigned char *sha1)
 	free(ext_header.buf);
 }
 
-static int git_tar_config(const char *var, const char *value)
+static int git_tar_config(const char *var, const char *value, void *cb_data)
 {
 	if (!strcmp(var, "tar.umask")) {
 		if (!strcmp(value, "user")) {
@@ -253,7 +253,7 @@ static int git_tar_config(const char *var, const char *value)
 		}
 		return 0;
 	}
-	return git_default_config(var, value);
+	return git_default_config(var, value, NULL);
 }
 
 static int write_tar_entry(const unsigned char *sha1,
@@ -300,7 +300,7 @@ int write_tar_archive(struct archiver_args *args)
 {
 	int plen = args->base ? strlen(args->base) : 0;
 
-	git_config(git_tar_config);
+	git_config(git_tar_config, NULL);
 
 	archive_time = args->time;
 	verbose = args->verbose;
diff --git a/builtin-add.c b/builtin-add.c
index 1591171..1b24c56 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -136,7 +136,7 @@ static void update(int verbose, const char **files)
 	run_diff_files(&rev, 0);
 }
 
-static int git_add_config(const char *var, const char *value)
+static int git_add_config(const char *var, const char *value, void *cb_data)
 {
 	if (!strcmp(var, "core.excludesfile")) {
 		if (!value)
@@ -145,7 +145,7 @@ static int git_add_config(const char *var, const char *value)
 		return 0;
 	}
 
-	return git_default_config(var, value);
+	return git_default_config(var, value, NULL);
 }
 
 static struct lock_file lock_file;
@@ -175,7 +175,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		exit(1);
 	}
 
-	git_config(git_add_config);
+	git_config(git_add_config, NULL);
 
 	newfd = hold_locked_index(&lock_file, 1);
 
diff --git a/builtin-apply.c b/builtin-apply.c
index 0399743..deae199 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2707,13 +2707,13 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 	return 0;
 }
 
-static int git_apply_config(const char *var, const char *value)
+static int git_apply_config(const char *var, const char *value, void *cb_data)
 {
 	if (!strcmp(var, "apply.whitespace")) {
 		apply_default_whitespace = xstrdup(value);
 		return 0;
 	}
-	return git_default_config(var, value);
+	return git_default_config(var, value, NULL);
 }
 
 
@@ -2729,7 +2729,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 
 	prefix = setup_git_directory_gently(&is_not_gitdir);
 	prefix_length = prefix ? strlen(prefix) : 0;
-	git_config(git_apply_config);
+	git_config(git_apply_config, NULL);
 	if (apply_default_whitespace)
 		parse_whitespace_option(apply_default_whitespace);
 
diff --git a/builtin-blame.c b/builtin-blame.c
index 35471fc..0fb76ee 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1973,7 +1973,7 @@ static void prepare_blame_range(struct scoreboard *sb,
 		usage(blame_usage);
 }
 
-static int git_blame_config(const char *var, const char *value)
+static int git_blame_config(const char *var, const char *value, void *cb_data)
 {
 	if (!strcmp(var, "blame.showroot")) {
 		show_root = git_config_bool(var, value);
@@ -1983,7 +1983,7 @@ static int git_blame_config(const char *var, const char *value)
 		blank_boundary = git_config_bool(var, value);
 		return 0;
 	}
-	return git_default_config(var, value);
+	return git_default_config(var, value, NULL);
 }
 
 static struct commit *fake_working_tree_commit(const char *path, const char *contents_from)
@@ -2136,7 +2136,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	cmd_is_annotate = !strcmp(argv[0], "annotate");
 
-	git_config(git_blame_config);
+	git_config(git_blame_config, NULL);
 	save_commit_buffer = 0;
 
 	opt = 0;
diff --git a/builtin-branch.c b/builtin-branch.c
index 6bd5843..a0f4c23 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -55,7 +55,7 @@ static int parse_branch_color_slot(const char *var, int ofs)
 	die("bad config variable '%s'", var);
 }
 
-int git_branch_config(const char *var, const char *value)
+int git_branch_config(const char *var, const char *value, void *cb_data)
 {
 	if (!strcmp(var, "color.branch")) {
 		branch_use_color = git_config_colorbool(var, value);
@@ -69,7 +69,7 @@ int git_branch_config(const char *var, const char *value)
 	if (!strcmp(var, "branch.autosetupmerge"))
 		branch_track_remotes = git_config_bool(var, value);
 
-	return git_default_config(var, value);
+	return git_default_config(var, value, NULL);
 }
 
 const char *branch_get_color(enum color_branch ix)
@@ -356,7 +356,7 @@ static int get_remote_branch_name(const char *value)
 	return 0;
 }
 
-static int get_remote_config(const char *key, const char *value)
+static int get_remote_config(const char *key, const char *value, void *cb_data)
 {
 	const char *var;
 	if (prefixcmp(key, "remote."))
@@ -400,7 +400,7 @@ static void set_branch_defaults(const char *name, const char *real_ref)
 	start_ref = real_ref;
 	start_len = strlen(real_ref);
 	base_len = slash - real_ref;
-	git_config(get_remote_config);
+	git_config(get_remote_config, NULL);
 	if (!config_repo && !config_remote &&
 	    !prefixcmp(real_ref, "refs/heads/")) {
 		set_branch_merge(name, ".", real_ref);
@@ -538,7 +538,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int kinds = REF_LOCAL_BRANCH;
 	int i;
 
-	git_config(git_branch_config);
+	git_config(git_branch_config, NULL);
 	track = branch_track_remotes;
 
 	for (i = 1; i < argc; i++) {
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
index 8460f97..47a8b1b 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -168,7 +168,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	int read_from_stdin = 0;
 	int prefix_length;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 	state.base_dir = "";
 	prefix_length = prefix ? strlen(prefix) : 0;
 
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index ccbcbe3..3439321 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -92,7 +92,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	unsigned int size;
 	int encoding_is_utf8;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	if (argc < 2)
 		usage(commit_tree_usage);
diff --git a/builtin-config.c b/builtin-config.c
index 7e18f73..7834e19 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -16,7 +16,7 @@ static int do_not_match;
 static int seen;
 static enum { T_RAW, T_INT, T_BOOL } type = T_RAW;
 
-static int show_all_config(const char *key_, const char *value_)
+static int show_all_config(const char *key_, const char *value_, void *cb_data)
 {
 	if (value_)
 		printf("%s=%s\n", key_, value_);
@@ -25,7 +25,7 @@ static int show_all_config(const char *key_, const char *value_)
 	return 0;
 }
 
-static int show_config(const char* key_, const char* value_)
+static int show_config(const char* key_, const char* value_, void *cb_data)
 {
 	char value[256];
 	const char *vptr = value;
@@ -107,17 +107,17 @@ static int get_value(const char* key_, const char* regex_)
 	}
 
 	if (dest)
-		git_config_from_remote(show_config, dest);
+		git_config_from_remote(show_config, dest, NULL);
 	else {
 		if (do_all && system_wide)
-			git_config_from_file(show_config, system_wide);
+			git_config_from_file(show_config, system_wide, NULL);
 		if (do_all && global)
-			git_config_from_file(show_config, global);
-		git_config_from_file(show_config, local);
+			git_config_from_file(show_config, global, NULL);
+		git_config_from_file(show_config, local, NULL);
 		if (!do_all && !seen && global)
-			git_config_from_file(show_config, global);
+			git_config_from_file(show_config, global, NULL);
 		if (!do_all && !seen && system_wide)
-			git_config_from_file(show_config, system_wide);
+			git_config_from_file(show_config, system_wide, NULL);
 	}
 
 	free(key);
@@ -149,9 +149,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			type = T_BOOL;
 		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l")) {
 			if (dest)
-				return git_config_from_remote(show_all_config, dest);
+				return git_config_from_remote(show_all_config,
+								dest, NULL);
 			else
-				return git_config(show_all_config);
+				return git_config(show_all_config, NULL);
 		}
 		else if (!strcmp(argv[1], "--global")) {
 			char *home = getenv("HOME");
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 6cb30c8..017f4b9 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -21,7 +21,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 
 	prefix = setup_git_directory_gently(&nongit);
 	init_revisions(&rev, prefix);
-	git_config(git_default_config); /* no "diff" UI options */
+	git_config(git_default_config, NULL); /* no "diff" UI options */
 	rev.abbrev = 0;
 
 	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index d90eba9..6e92b78 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -17,7 +17,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	int result;
 
 	init_revisions(&rev, prefix);
-	git_config(git_default_config); /* no "diff" UI options */
+	git_config(git_default_config, NULL); /* no "diff" UI options */
 	rev.abbrev = 0;
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 0b591c8..341edad 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -68,7 +68,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	int read_stdin = 0;
 
 	init_revisions(opt, prefix);
-	git_config(git_default_config); /* no "diff" UI options */
+	git_config(git_default_config, NULL); /* no "diff" UI options */
 	nr_sha1 = 0;
 	opt->abbrev = 0;
 	opt->diff = 1;
diff --git a/builtin-diff.c b/builtin-diff.c
index 7f367b6..906b698 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -220,7 +220,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	 */
 
 	prefix = setup_git_directory_gently(&nongit);
-	git_config(git_diff_ui_config);
+	git_config(git_diff_ui_config, NULL);
 	init_revisions(&rev, prefix);
 
 	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 5c145d2..a156548 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -10,7 +10,8 @@ static const char *fmt_merge_msg_usage =
 
 static int merge_summary;
 
-static int fmt_merge_msg_config(const char *key, const char *value)
+static int fmt_merge_msg_config(const char *key, const char *value,
+				void *cb_data)
 {
 	if (!strcmp("merge.summary", key))
 		merge_summary = git_config_bool(key, value);
@@ -251,7 +252,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	unsigned char head_sha1[20];
 	const char *current_branch;
 
-	git_config(fmt_merge_msg_config);
+	git_config(fmt_merge_msg_config, NULL);
 
 	while (argc > 1) {
 		if (!strcmp(argv[1], "--summary"))
diff --git a/builtin-gc.c b/builtin-gc.c
index 8ea165a..164fe71 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -27,7 +27,7 @@ static const char *argv_repack[MAX_ADD] = {"repack", "-a", "-d", "-l", NULL};
 static const char *argv_prune[] = {"prune", NULL};
 static const char *argv_rerere[] = {"rerere", "gc", NULL};
 
-static int gc_config(const char *var, const char *value)
+static int gc_config(const char *var, const char *value, void *cb_data)
 {
 	if (!strcmp(var, "gc.packrefs")) {
 		if (!strcmp(value, "notbare"))
@@ -40,7 +40,7 @@ static int gc_config(const char *var, const char *value)
 		aggressive_window = git_config_int(var, value);
 		return 0;
 	}
-	return git_default_config(var, value);
+	return git_default_config(var, value, NULL);
 }
 
 static void append_option(const char **cmd, const char *opt, int max_length)
@@ -62,7 +62,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	int prune = 0;
 	char buf[80];
 
-	git_config(gc_config);
+	git_config(gc_config, NULL);
 
 	if (pack_refs < 0)
 		pack_refs = !is_bare_repository();
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 4df9fd0..11460b6 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -152,7 +152,7 @@ static void copy_templates(const char *git_dir, int len, const char *template_di
 	strcpy(template_path + template_len, "config");
 	repository_format_version = 0;
 	git_config_from_file(check_repository_format_version,
-			     template_path);
+			     template_path, NULL);
 	template_path[template_len] = 0;
 
 	if (repository_format_version &&
@@ -207,7 +207,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	path[len] = 0;
 	copy_templates(path, len, template_path);
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	/*
 	 * We would have created the above under user's umask -- under
diff --git a/builtin-log.c b/builtin-log.c
index 3744712..2581ce4 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -93,20 +93,20 @@ static int cmd_log_walk(struct rev_info *rev)
 	return 0;
 }
 
-static int git_log_config(const char *var, const char *value)
+static int git_log_config(const char *var, const char *value, void *cb_data)
 {
 	if (!strcmp(var, "log.showroot")) {
 		default_show_root = git_config_bool(var, value);
 		return 0;
 	}
-	return git_diff_ui_config(var, value);
+	return git_diff_ui_config(var, value, NULL);
 }
 
 int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
 
-	git_config(git_log_config);
+	git_config(git_log_config, NULL);
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.diffopt.recursive = 1;
@@ -155,7 +155,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	struct object_array_entry *objects;
 	int i, count, ret = 0;
 
-	git_config(git_log_config);
+	git_config(git_log_config, NULL);
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.diffopt.recursive = 1;
@@ -220,7 +220,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
 
-	git_config(git_log_config);
+	git_config(git_log_config, NULL);
 	init_revisions(&rev, prefix);
 	init_reflog_walk(&rev.reflog_info);
 	rev.abbrev_commit = 1;
@@ -248,7 +248,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
 
-	git_config(git_log_config);
+	git_config(git_log_config, NULL);
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
 	cmd_log_init(argc, argv, prefix, &rev);
@@ -268,7 +268,7 @@ static char *extra_headers = NULL;
 static int extra_headers_size = 0;
 static const char *fmt_patch_suffix = ".patch";
 
-static int git_format_config(const char *var, const char *value)
+static int git_format_config(const char *var, const char *value, void *cb_data)
 {
 	if (!strcmp(var, "format.headers")) {
 		int len;
@@ -291,7 +291,7 @@ static int git_format_config(const char *var, const char *value)
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
 		return 0;
 	}
-	return git_log_config(var, value);
+	return git_log_config(var, value, NULL);
 }
 
 
@@ -440,7 +440,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	char message_id[1024];
 	char ref_message_id[1024];
 
-	git_config(git_format_config);
+	git_config(git_format_config, NULL);
 	init_revisions(&rev, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.verbose_header = 1;
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index f7c066b..9bdadc4 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -347,7 +347,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 	memset(&dir, 0, sizeof(dir));
 	if (prefix)
 		prefix_offset = strlen(prefix);
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 1cb4dca..104e98f 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -108,7 +108,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	unsigned char sha1[20];
 	struct tree *tree;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 	ls_tree_prefix = prefix;
 	if (prefix && *prefix)
 		chomp_prefix = strlen(prefix);
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index c95e477..82f7a6e 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -894,7 +894,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	/* NEEDSWORK: might want to do the optional .git/ directory
 	 * discovery
 	 */
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	def_charset = (git_commit_encoding ? git_commit_encoding : "utf-8");
 	metainfo_charset = def_charset;
diff --git a/builtin-merge-base.c b/builtin-merge-base.c
index e35d362..9f766c5 100644
--- a/builtin-merge-base.c
+++ b/builtin-merge-base.c
@@ -27,7 +27,7 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	unsigned char rev1key[20], rev2key[20];
 	int show_all = 0;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	while (1 < argc && argv[1][0] == '-') {
 		const char *arg = argv[1];
diff --git a/builtin-mv.c b/builtin-mv.c
index 3563216..7d01203 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -75,7 +75,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	struct path_list deleted = {NULL, 0, 0, 0};
 	struct path_list changed = {NULL, 0, 0, 0};
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	newfd = hold_locked_index(&lock_file, 1);
 	if (read_cache() < 0)
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index ef16385..988426c 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -151,7 +151,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	int as_is = 0, all = 0, transform_stdin = 0;
 	struct name_ref_data data = { 0, NULL };
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	if (argc < 2)
 		usage(name_rev_usage);
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index d165f10..e6ce67a 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1419,7 +1419,7 @@ static void prepare_pack(int window, int depth)
 	free(delta_list);
 }
 
-static int git_pack_config(const char *k, const char *v)
+static int git_pack_config(const char *k, const char *v, void *cb_data)
 {
 	if(!strcmp(k, "pack.window")) {
 		window = git_config_int(k, v);
@@ -1439,7 +1439,7 @@ static int git_pack_config(const char *k, const char *v)
 		pack_compression_seen = 1;
 		return 0;
 	}
-	return git_default_config(k, v);
+	return git_default_config(k, v, NULL);
 }
 
 static void read_object_list_from_stdin(void)
@@ -1549,7 +1549,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	rp_av[1] = "--objects"; /* --thin will make it --objects-edge */
 	rp_ac = 2;
 
-	git_config(git_pack_config);
+	git_config(git_pack_config, NULL);
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level = core_compression_level;
 
diff --git a/builtin-push.c b/builtin-push.c
index cb78401..a19be32 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -193,7 +193,7 @@ static int config_current_uri;
 static int config_get_refspecs;
 static int config_get_receivepack;
 
-static int get_remote_config(const char* key, const char* value)
+static int get_remote_config(const char* key, const char* value, void *cb_data)
 {
 	if (!prefixcmp(key, "remote.") &&
 	    !strncmp(key + 7, config_repo, config_repo_len)) {
@@ -230,7 +230,7 @@ static int get_config_remotes_uri(const char *repo, const char *uri[MAX_URI])
 	config_get_refspecs = !(refspec_nr || all || tags);
 	config_get_receivepack = (receivepack == NULL);
 
-	git_config(get_remote_config);
+	git_config(get_remote_config, NULL);
 	return config_current_uri;
 }
 
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index b9fcff7..cec2021 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -92,14 +92,15 @@ static const char read_tree_usage[] = "git-read-tree (<sha> | [[-m [--aggressive
 static struct lock_file lock_file;
 static struct unpack_trees_options opts;
 
-static int git_read_tree_config(const char *var, const char *value)
+static int git_read_tree_config(const char *var, const char *value,
+				void *cb_data)
 {
 	if (!strcmp(var, "core.submodules")) {
 		opts.submodules = git_config_bool(var, value);
 		return 0;
 	}
 
-	return git_default_config(var, value);
+	return git_default_config(var, value, NULL);
 }
 
 int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
@@ -110,11 +111,11 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	opts.head_idx = -1;
 
 	setup_git_directory();
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	newfd = hold_locked_index(&lock_file, 1);
 
-	git_config(git_read_tree_config);
+	git_config(git_read_tree_config, NULL);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/builtin-reflog.c b/builtin-reflog.c
index ce093ca..c616a0a 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -281,14 +281,15 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	return status;
 }
 
-static int reflog_expire_config(const char *var, const char *value)
+static int reflog_expire_config(const char *var, const char *value,
+				void *cb_data)
 {
 	if (!strcmp(var, "gc.reflogexpire"))
 		default_reflog_expire = approxidate(value);
 	else if (!strcmp(var, "gc.reflogexpireunreachable"))
 		default_reflog_expire_unreachable = approxidate(value);
 	else
-		return git_default_config(var, value);
+		return git_default_config(var, value, NULL);
 	return 0;
 }
 
@@ -298,7 +299,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	unsigned long now = time(NULL);
 	int i, status, do_all;
 
-	git_config(reflog_expire_config);
+	git_config(reflog_expire_config, NULL);
 
 	save_commit_buffer = 0;
 	do_all = status = 0;
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 8c2c8bd..5d1fe12 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -380,14 +380,14 @@ tail_optimization:
 	return write_rr(rr, fd);
 }
 
-static int git_rerere_config(const char *var, const char *value)
+static int git_rerere_config(const char *var, const char *value, void *cb_data)
 {
 	if (!strcmp(var, "gc.rerereresolved"))
 		cutoff_resolve = git_config_int(var, value);
 	else if (!strcmp(var, "gc.rerereunresolved"))
 		cutoff_noresolve = git_config_int(var, value);
 	else
-		return git_default_config(var, value);
+		return git_default_config(var, value, NULL);
 	return 0;
 }
 
@@ -400,7 +400,7 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 	if (stat(git_path("rr-cache"), &st) || !S_ISDIR(st.st_mode))
 		return 0;
 
-	git_config(git_rerere_config);
+	git_config(git_rerere_config, NULL);
 
 	merge_rr_path = xstrdup(git_path("rr-cache/MERGE_RR"));
 	fd = hold_lock_file_for_update(&write_lock, merge_rr_path, 1);
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index ebf53f5..8700d37 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -468,7 +468,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int read_from_stdin = 0;
 	int bisect_show_vars = 0;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 	init_revisions(&revs, prefix);
 	revs.abbrev = 0;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 37addb2..8e868c3 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -214,7 +214,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	int i, as_is = 0, verify = 0;
 	unsigned char sha1[20];
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/builtin-revert.c b/builtin-revert.c
index ea2f15b..aa26c27 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -239,7 +239,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	const char *message, *encoding;
 	const char *defmsg = xstrdup(git_path("MERGE_MSG"));
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 	me = action == REVERT ? "revert" : "cherry-pick";
 	setenv(GIT_REFLOG_ACTION, me, 0);
 	parse_options(argc, argv);
diff --git a/builtin-rm.c b/builtin-rm.c
index 4a0bd93..7f03735 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -109,7 +109,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	const char **pathspec;
 	char *seen;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	newfd = hold_locked_index(&lock_file, 1);
 
diff --git a/builtin-runstatus.c b/builtin-runstatus.c
index 4b489b1..d365d7d 100644
--- a/builtin-runstatus.c
+++ b/builtin-runstatus.c
@@ -11,7 +11,7 @@ int cmd_runstatus(int argc, const char **argv, const char *prefix)
 	struct wt_status s;
 	int i;
 
-	git_config(git_status_config);
+	git_config(git_status_config, NULL);
 	wt_status_prepare(&s);
 
 	for (i = 1; i < argc; i++) {
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index c892f1f..73565c8 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -531,7 +531,8 @@ static void append_one_rev(const char *av)
 	die("bad sha1 reference %s", av);
 }
 
-static int git_show_branch_config(const char *var, const char *value)
+static int git_show_branch_config(const char *var, const char *value,
+				  void *cb_data)
 {
 	if (!strcmp(var, "showbranch.default")) {
 		if (default_alloc <= default_num + 1) {
@@ -543,7 +544,7 @@ static int git_show_branch_config(const char *var, const char *value)
 		return 0;
 	}
 
-	return git_default_config(var, value);
+	return git_default_config(var, value, NULL);
 }
 
 static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
@@ -607,7 +608,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	int reflog = 0;
 	const char *reflog_base = NULL;
 
-	git_config(git_show_branch_config);
+	git_config(git_show_branch_config, NULL);
 
 	/* If nothing is specified, try the default first */
 	if (ac == 1 && default_num) {
diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index d41b406..114c473 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -27,7 +27,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 	int quiet = 0;
 	const char *msg = NULL;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	while (1 < argc) {
 		const char *arg = argv[1];
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index a6ff62f..73dd79f 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -341,7 +341,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 	int i;
 	unsigned char sha1[20];
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	quiet = !isatty(2);
 
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 8f98991..023c2dc 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -570,7 +570,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	int lock_error = 0;
 	struct lock_file *lock_file;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
 	lock_file = xcalloc(1, sizeof(struct lock_file));
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index feac2ed..782d4aa 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -14,7 +14,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 
 	delete = 0;
 	ref_flags = 0;
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	for (i = 1; i < argc; i++) {
 		if (!strcmp("-m", argv[i])) {
diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index 4e31c27..8a59d14 100644
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
diff --git a/cache.h b/cache.h
index 446030a..d56db20 100644
--- a/cache.h
+++ b/cache.h
@@ -499,17 +499,18 @@ extern const char *packed_object_info_detail(struct packed_git *, off_t, unsigne
 /* Dumb servers support */
 extern int update_server_info(int);
 
-typedef int (*config_fn_t)(const char *, const char *);
-extern int git_default_config(const char *, const char *);
-extern int git_config_from_file(config_fn_t fn, const char *);
-extern int git_config_from_remote(config_fn_t fn, char *dest);
-extern int git_config(config_fn_t fn);
+typedef int (*config_fn_t)(const char *, const char *, void *cb_data);
+extern int git_default_config(const char *, const char *, void *cb_data);
+extern int git_config_from_file(config_fn_t fn, const char *, void *cb_data);
+extern int git_config_from_remote(config_fn_t fn, char *dest, void *cb_data);
+extern int git_config(config_fn_t fn, void *cb_data);
 extern int git_config_int(const char *, const char *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
-extern int check_repository_format_version(const char *var, const char *value);
+extern int check_repository_format_version(const char *var, const char *value,
+					   void *cb_data);
 
 #define MAX_GITNAME (1000)
 extern char git_default_email[MAX_GITNAME];
diff --git a/config.c b/config.c
index fc2162b..cab6f29 100644
--- a/config.c
+++ b/config.c
@@ -113,7 +113,7 @@ static inline int iskeychar(int c)
 	return isalnum(c) || c == '-';
 }
 
-static int get_value(config_fn_t fn, char *name, unsigned int len)
+static int get_value(config_fn_t fn, char *name, unsigned int len, void *cb_data)
 {
 	int c;
 	char *value;
@@ -141,7 +141,7 @@ static int get_value(config_fn_t fn, char *name, unsigned int len)
 		if (!value)
 			return -1;
 	}
-	return fn(name, value);
+	return fn(name, value, cb_data);
 }
 
 static int get_extended_base_var(char *name, int baselen, int c)
@@ -199,7 +199,7 @@ static int get_base_var(char *name)
 	}
 }
 
-static int git_parse_file(config_fn_t fn)
+static int git_parse_file(config_fn_t fn, void *cb_data)
 {
 	int comment = 0;
 	int baselen = 0;
@@ -231,7 +231,7 @@ static int git_parse_file(config_fn_t fn)
 		if (!isalpha(c))
 			break;
 		var[baselen] = tolower(c);
-		if (get_value(fn, var, baselen+1) < 0)
+		if (get_value(fn, var, baselen+1, cb_data) < 0)
 			break;
 	}
 	die("bad config file line %d in %s", config_linenr, config_file_name);
@@ -267,7 +267,7 @@ int git_config_bool(const char *name, const char *value)
 	return git_config_int(name, value) != 0;
 }
 
-int git_default_config(const char *var, const char *value)
+int git_default_config(const char *var, const char *value, void *cb_data)
 {
 	/* This needs a better name */
 	if (!strcmp(var, "core.filemode")) {
@@ -390,7 +390,7 @@ int git_default_config(const char *var, const char *value)
 	return 0;
 }
 
-int git_config_from_file(config_fn_t fn, const char *filename)
+int git_config_from_file(config_fn_t fn, const char *filename, void *cb_data)
 {
 	int ret;
 	FILE *f = fopen(filename, "r");
@@ -400,24 +400,24 @@ int git_config_from_file(config_fn_t fn, const char *filename)
 		config_file = f;
 		config_file_name = filename;
 		config_linenr = 1;
-		ret = git_parse_file(fn);
+		ret = git_parse_file(fn, cb_data);
 		fclose(f);
 		config_file_name = NULL;
 	}
 	return ret;
 }
 
-static int config_from_http(config_fn_t fn, char *dest)
+static int config_from_http(config_fn_t fn, char *dest, void *cb_data)
 {
 	char config_temp[50];
 	if (git_http_fetch_config(dest, config_temp, sizeof(config_temp)))
 		return 1;
-	git_config_from_file(fn, config_temp);
+	git_config_from_file(fn, config_temp, cb_data);
 	unlink(config_temp);
 	return 0;
 }
 
-int git_config_from_remote(config_fn_t fn, char *dest)
+int git_config_from_remote(config_fn_t fn, char *dest, void *cb_data)
 {
 	int ret;
 	int fd[2];
@@ -426,7 +426,7 @@ int git_config_from_remote(config_fn_t fn, char *dest)
 	static char value[1024];
 
 	if (!prefixcmp(dest, "http://"))
-		return config_from_http(fn, dest);
+		return config_from_http(fn, dest, cb_data);
 
 	pid = git_connect(fd, dest, dumpconfig, 0);
 	if (pid < 0)
@@ -435,7 +435,7 @@ int git_config_from_remote(config_fn_t fn, char *dest)
 	while (packet_read_line(fd[0], var, sizeof(var))) {
 		if (!packet_read_line(fd[0], value, sizeof(value)))
 			die("Missing value");
-		fn(var, value);
+		fn(var, value, cb_data);
 	}
 	close(fd[0]);
 	close(fd[1]);
@@ -443,7 +443,7 @@ int git_config_from_remote(config_fn_t fn, char *dest)
 	return !!ret;
 }
 
-int git_config(config_fn_t fn)
+int git_config(config_fn_t fn, void *cb_data)
 {
 	int ret = 0;
 	char *repo_config = NULL;
@@ -456,7 +456,7 @@ int git_config(config_fn_t fn)
 	filename = getenv(CONFIG_ENVIRONMENT);
 	if (!filename) {
 		if (!access(ETC_GITCONFIG, R_OK))
-			ret += git_config_from_file(fn, ETC_GITCONFIG);
+			ret += git_config_from_file(fn, ETC_GITCONFIG, cb_data);
 		home = getenv("HOME");
 		filename = getenv(CONFIG_LOCAL_ENVIRONMENT);
 		if (!filename)
@@ -466,11 +466,11 @@ int git_config(config_fn_t fn)
 	if (home) {
 		char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
 		if (!access(user_config, R_OK))
-			ret = git_config_from_file(fn, user_config);
+			ret = git_config_from_file(fn, user_config, cb_data);
 		free(user_config);
 	}
 
-	ret += git_config_from_file(fn, filename);
+	ret += git_config_from_file(fn, filename, cb_data);
 	free(repo_config);
 	return ret;
 }
@@ -500,7 +500,7 @@ static int matches(const char* key, const char* value)
 		  !regexec(store.value_regex, value, 0, NULL, 0)));
 }
 
-static int store_aux(const char* key, const char* value)
+static int store_aux(const char* key, const char* value, void *cb_data)
 {
 	const char *ep;
 	size_t section_len;
@@ -836,7 +836,7 @@ int git_config_set_multivar(const char* key, const char* value,
 		 * As a side effect, we make sure to transform only a valid
 		 * existing config file.
 		 */
-		if (git_config_from_file(store_aux, config_filename)) {
+		if (git_config_from_file(store_aux, config_filename, NULL)) {
 			fprintf(stderr, "invalid config file\n");
 			free(store.key);
 			if (store.value_regex != NULL) {
diff --git a/connect.c b/connect.c
index 2a26fdb..08cfac0 100644
--- a/connect.c
+++ b/connect.c
@@ -558,7 +558,8 @@ static char *git_proxy_command;
 static const char *rhost_name;
 static int rhost_len;
 
-static int git_proxy_command_options(const char *var, const char *value)
+static int git_proxy_command_options(const char *var, const char *value,
+				     void *cb_data)
 {
 	if (!strcmp(var, "core.gitproxy")) {
 		const char *for_pos;
@@ -602,7 +603,7 @@ static int git_proxy_command_options(const char *var, const char *value)
 		return 0;
 	}
 
-	return git_default_config(var, value);
+	return git_default_config(var, value, NULL);
 }
 
 static int git_use_proxy(const char *host)
@@ -610,7 +611,7 @@ static int git_use_proxy(const char *host)
 	rhost_name = host;
 	rhost_len = strlen(host);
 	git_proxy_command = getenv("GIT_PROXY_COMMAND");
-	git_config(git_proxy_command_options);
+	git_config(git_proxy_command_options, NULL);
 	rhost_name = NULL;
 	return (git_proxy_command && *git_proxy_command);
 }
diff --git a/convert.c b/convert.c
index 4b26b1a..6dde5fa 100644
--- a/convert.c
+++ b/convert.c
@@ -335,7 +335,8 @@ static struct convert_driver {
 	char *clean;
 } *user_convert, **user_convert_tail;
 
-static int read_convert_config(const char *var, const char *value)
+static int read_convert_config(const char *var, const char *value,
+				void *cb_data)
 {
 	const char *ep, *name;
 	int namelen;
@@ -402,7 +403,7 @@ static void setup_convert_check(struct git_attr_check *check)
 		attr_ident = git_attr("ident", 5);
 		attr_filter = git_attr("filter", 6);
 		user_convert_tail = &user_convert;
-		git_config(read_convert_config);
+		git_config(read_convert_config, NULL);
 	}
 	check[0].attr = attr_crlf;
 	check[1].attr = attr_ident;
diff --git a/daemon.c b/daemon.c
index 3e5ebf3..2d6302f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -284,7 +284,7 @@ struct daemon_service {
 static struct daemon_service *service_looking_at;
 static int service_enabled;
 
-static int git_daemon_config(const char *var, const char *value)
+static int git_daemon_config(const char *var, const char *value, void *cb_data)
 {
 	if (!prefixcmp(var, "daemon.") &&
 	    !strcmp(var + 7, service_looking_at->config_name)) {
@@ -334,7 +334,7 @@ static int run_service(struct interp *itable, struct daemon_service *service)
 	if (service->overridable) {
 		service_looking_at = service;
 		service_enabled = -1;
-		git_config(git_daemon_config);
+		git_config(git_daemon_config, NULL);
 		if (0 <= service_enabled)
 			enabled = service_enabled;
 	}
diff --git a/diff.c b/diff.c
index 33297aa..8edfcc5 100644
--- a/diff.c
+++ b/diff.c
@@ -99,7 +99,7 @@ static int parse_lldiff_command(const char *var, const char *ep, const char *val
  * never be affected by the setting of diff.renames
  * the user happens to have in the configuration file.
  */
-int git_diff_ui_config(const char *var, const char *value)
+int git_diff_ui_config(const char *var, const char *value, void *cb_data)
 {
 	if (!strcmp(var, "diff.renamelimit")) {
 		diff_rename_limit_default = git_config_int(var, value);
@@ -131,7 +131,7 @@ int git_diff_ui_config(const char *var, const char *value)
 		return 0;
 	}
 
-	return git_default_config(var, value);
+	return git_default_config(var, value, NULL);
 }
 
 static char *quote_one(const char *str)
@@ -1762,7 +1762,7 @@ static const char *external_diff_attr(const char *name)
 
 			if (!user_diff_tail) {
 				user_diff_tail = &user_diff;
-				git_config(git_diff_ui_config);
+				git_config(git_diff_ui_config, NULL);
 			}
 			for (drv = user_diff; drv; drv = drv->next)
 				if (!strcmp(drv->name, value))
diff --git a/diff.h b/diff.h
index 63738c1..a715dff 100644
--- a/diff.h
+++ b/diff.h
@@ -161,7 +161,7 @@ extern int diff_scoreopt_parse(const char *opt);
 #define DIFF_SETUP_USE_CACHE		2
 #define DIFF_SETUP_USE_SIZE_CACHE	4
 
-extern int git_diff_ui_config(const char *var, const char *value);
+extern int git_diff_ui_config(const char *var, const char *value, void *cb_data);
 extern void diff_setup(struct diff_options *);
 extern int diff_opt_parse(struct diff_options *, const char **, int);
 extern int diff_setup_done(struct diff_options *);
diff --git a/dump-config.c b/dump-config.c
index 355920d..99dbeb6 100644
--- a/dump-config.c
+++ b/dump-config.c
@@ -4,7 +4,7 @@
 
 static const char dump_config_usage[] = "git-dump-config <dir>";
 
-static int dump_config(const char *var, const char *value)
+static int dump_config(const char *var, const char *value, void *cb_data)
 {
 	packet_write(1, "%s", var);
 	packet_write(1, "%s", value);
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
 	if (!enter_repo(dir, 0))
 		die("'%s': unable to chdir or not a git archive", dir);
 
-	git_config(dump_config);
+	git_config(dump_config, NULL);
 	packet_flush(1);
 
 	return 0;
diff --git a/fast-import.c b/fast-import.c
index ffa00fd..599d045 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2009,7 +2009,7 @@ int main(int argc, const char **argv)
 {
 	int i, show_stats = 1;
 
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 	alloc_objects(object_entry_alloc);
 	strbuf_init(&command_buf);
 	atom_table = xcalloc(atom_table_sz, sizeof(struct atom_str*));
diff --git a/fetch-pack.c b/fetch-pack.c
index aa59043..c7d24fe 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -646,7 +646,7 @@ static int remove_duplicates(int nr_heads, char **heads)
 	return dst;
 }
 
-static int fetch_pack_config(const char *var, const char *value)
+static int fetch_pack_config(const char *var, const char *value, void *cb_data)
 {
 	if (strcmp(var, "fetch.unpacklimit") == 0) {
 		fetch_unpack_limit = git_config_int(var, value);
@@ -658,7 +658,7 @@ static int fetch_pack_config(const char *var, const char *value)
 		return 0;
 	}
 
-	return git_default_config(var, value);
+	return git_default_config(var, value, NULL);
 }
 
 static struct lock_file lock;
@@ -672,7 +672,7 @@ int main(int argc, char **argv)
 	struct stat st;
 
 	setup_git_directory();
-	git_config(fetch_pack_config);
+	git_config(fetch_pack_config, NULL);
 
 	if (0 <= transfer_unpack_limit)
 		unpack_limit = transfer_unpack_limit;
diff --git a/git.c b/git.c
index f200907..bbe09d5 100644
--- a/git.c
+++ b/git.c
@@ -87,7 +87,7 @@ static int handle_options(const char*** argv, int* argc)
 static const char *alias_command;
 static char *alias_string;
 
-static int git_alias_config(const char *var, const char *value)
+static int git_alias_config(const char *var, const char *value, void *cb_data)
 {
 	if (!prefixcmp(var, "alias.") && !strcmp(var + 6, alias_command)) {
 		alias_string = xstrdup(value);
@@ -158,7 +158,7 @@ static int handle_alias(int *argcp, const char ***argv)
 	subdir = setup_git_directory_gently(&nongit);
 
 	alias_command = (*argv)[0];
-	git_config(git_alias_config);
+	git_config(git_alias_config, NULL);
 	if (alias_string) {
 		if (alias_string[0] == '!') {
 			trace_printf("trace: alias to shell cmd: %s => %s\n",
diff --git a/http-fetch.c b/http-fetch.c
index 53fb2a9..bc87d4b 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -996,7 +996,7 @@ int main(int argc, const char **argv)
 	int rc = 0;
 
 	setup_git_directory();
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
diff --git a/http.c b/http.c
index c8237cb..fd359bf 100644
--- a/http.c
+++ b/http.c
@@ -97,7 +97,7 @@ static void process_curl_messages(void)
 }
 #endif
 
-static int http_options(const char *var, const char *value)
+static int http_options(const char *var, const char *value, void *cb_data)
 {
 	if (!strcmp("http.sslverify", var)) {
 		if (curl_ssl_verify == -1) {
@@ -164,7 +164,7 @@ static int http_options(const char *var, const char *value)
 	}
 
 	/* Fall back on the default ones */
-	return git_default_config(var, value);
+	return git_default_config(var, value, NULL);
 }
 
 static CURL* get_curl_handle(void)
@@ -252,7 +252,7 @@ void http_init(void)
 	if (low_speed_time != NULL)
 		curl_low_speed_time = strtol(low_speed_time, NULL, 10);
 
-	git_config(http_options);
+	git_config(http_options, NULL);
 
 	if (curl_ssl_verify == -1)
 		curl_ssl_verify = 1;
diff --git a/imap-send.c b/imap-send.c
index 4283a4a..129776c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1255,7 +1255,7 @@ static imap_server_conf_t server =
 static char *imap_folder;
 
 static int
-git_imap_config(const char *key, const char *val)
+git_imap_config(const char *key, const char *val, void *cb_data)
 {
 	char imap_key[] = "imap.";
 
@@ -1300,7 +1300,7 @@ main(int argc, char **argv)
 	/* init the random number generator */
 	arc4_init();
 
-	git_config( git_imap_config );
+	git_config(git_imap_config, NULL);
 
 	if (!imap_folder) {
 		fprintf( stderr, "no imap store specified\n" );
diff --git a/local-fetch.c b/local-fetch.c
index 4b650ef..23d2cbe 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -204,7 +204,7 @@ int main(int argc, const char **argv)
 	int arg = 1;
 
 	setup_git_directory();
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't')
diff --git a/merge-recursive.c b/merge-recursive.c
index 8f72b2c..f774342 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -851,7 +851,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 static struct ll_merge_driver *ll_user_merge, **ll_user_merge_tail;
 static const char *default_ll_merge;
 
-static int read_merge_config(const char *var, const char *value)
+static int read_merge_config(const char *var, const char *value, void *cb_data)
 {
 	struct ll_merge_driver *fn;
 	const char *ep, *name;
@@ -940,7 +940,7 @@ static void initialize_ll_merge(void)
 	if (ll_user_merge_tail)
 		return;
 	ll_user_merge_tail = &ll_user_merge;
-	git_config(read_merge_config);
+	git_config(read_merge_config, NULL);
 }
 
 static const struct ll_merge_driver *find_ll_merge_driver(const char *merge_attr)
@@ -1696,13 +1696,13 @@ static struct commit *get_ref(const char *ref)
 	return (struct commit *)object;
 }
 
-static int merge_config(const char *var, const char *value)
+static int merge_config(const char *var, const char *value, void *cb_data)
 {
 	if (!strcasecmp(var, "merge.verbosity")) {
 		verbosity = git_config_int(var, value);
 		return 0;
 	}
-	return git_default_config(var, value);
+	return git_default_config(var, value, NULL);
 }
 
 int main(int argc, char *argv[])
@@ -1723,7 +1723,7 @@ int main(int argc, char *argv[])
 			subtree_merge = 1;
 	}
 
-	git_config(merge_config);
+	git_config(merge_config, NULL);
 	if (getenv("GIT_MERGE_VERBOSITY"))
 		verbosity = strtol(getenv("GIT_MERGE_VERBOSITY"), NULL, 10);
 
diff --git a/receive-pack.c b/receive-pack.c
index d3c422b..feab9a4 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -18,7 +18,7 @@ static int report_status;
 static char capabilities[] = " report-status delete-refs ";
 static int capabilities_sent;
 
-static int receive_pack_config(const char *var, const char *value)
+static int receive_pack_config(const char *var, const char *value, void *cb_data)
 {
 	if (strcmp(var, "receive.denynonfastforwards") == 0) {
 		deny_non_fast_forwards = git_config_bool(var, value);
@@ -35,7 +35,7 @@ static int receive_pack_config(const char *var, const char *value)
 		return 0;
 	}
 
-	return git_default_config(var, value);
+	return git_default_config(var, value, NULL);
 }
 
 static int show_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
@@ -484,7 +484,7 @@ int main(int argc, char **argv)
 	if (is_repository_shallow())
 		die("attempt to push into a shallow repository");
 
-	git_config(receive_pack_config);
+	git_config(receive_pack_config, NULL);
 
 	if (0 <= transfer_unpack_limit)
 		unpack_limit = transfer_unpack_limit;
diff --git a/send-pack.c b/send-pack.c
index 83ee87d..7895520 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -346,7 +346,7 @@ int main(int argc, char **argv)
 	pid_t pid;
 
 	setup_git_directory();
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
diff --git a/setup.c b/setup.c
index a45ea83..d3487aa 100644
--- a/setup.c
+++ b/setup.c
@@ -270,7 +270,8 @@ int git_config_perm(const char *var, const char *value)
 	return git_config_bool(var, value);
 }
 
-int check_repository_format_version(const char *var, const char *value)
+int check_repository_format_version(const char *var, const char *value,
+				    void *cb_data)
 {
        if (strcmp(var, "core.repositoryformatversion") == 0)
                repository_format_version = git_config_int(var, value);
@@ -281,7 +282,7 @@ int check_repository_format_version(const char *var, const char *value)
 
 int check_repository_format(void)
 {
-	git_config(check_repository_format_version);
+	git_config(check_repository_format_version, NULL);
 	if (GIT_REPO_VERSION < repository_format_version)
 		die ("Expected git repo version <= %d, found %d",
 		     GIT_REPO_VERSION, repository_format_version);
diff --git a/ssh-fetch.c b/ssh-fetch.c
index bdf51a7..ceb8b7d 100644
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -125,7 +125,7 @@ int main(int argc, char **argv)
 	if (!prog) prog = "git-ssh-upload";
 
 	setup_git_directory();
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
diff --git a/unpack-file.c b/unpack-file.c
index 25c56b3..ade9926 100644
--- a/unpack-file.c
+++ b/unpack-file.c
@@ -33,7 +33,7 @@ int main(int argc, char **argv)
 		die("Not a valid object name %s", argv[1]);
 
 	setup_git_directory();
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 
 	puts(create_temp_file(sha1));
 	return 0;
diff --git a/var.c b/var.c
index e585e59..8ec0fdd 100644
--- a/var.c
+++ b/var.c
@@ -39,13 +39,13 @@ static const char *read_var(const char *var)
 	return val;
 }
 
-static int show_config(const char *var, const char *value)
+static int show_config(const char *var, const char *value, void *cb_data)
 {
 	if (value)
 		printf("%s=%s\n", var, value);
 	else
 		printf("%s\n", var);
-	return git_default_config(var, value);
+	return git_default_config(var, value, NULL);
 }
 
 int main(int argc, char **argv)
@@ -59,11 +59,11 @@ int main(int argc, char **argv)
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
index a055990..6e40870 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -346,7 +346,7 @@ void wt_status_print(struct wt_status *s)
 	}
 }
 
-int git_status_config(const char *k, const char *v)
+int git_status_config(const char *k, const char *v, void *cb_data)
 {
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
 		wt_status_use_color = git_config_colorbool(k, v);
@@ -356,5 +356,5 @@ int git_status_config(const char *k, const char *v)
 		int slot = parse_status_slot(k, 13);
 		color_parse(v, k, wt_status_colors[slot]);
 	}
-	return git_default_config(k, v);
+	return git_default_config(k, v, NULL);
 }
diff --git a/wt-status.h b/wt-status.h
index cfea4ae..242e9c5 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -21,7 +21,7 @@ struct wt_status {
 	int workdir_untracked;
 };
 
-int git_status_config(const char *var, const char *value);
+int git_status_config(const char *var, const char *value, void *cb_data);
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 
-- 
1.5.2.rc3.815.g8fc2
