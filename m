From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 2/3] Convert existing die(..., strerror(errno)) to die_errno()
Date: Mon,  8 Jun 2009 23:02:19 +0200
Message-ID: <5a74ed8a911fc1048c021bc3b42e679526bc4c8e.1244494647.git.trast@student.ethz.ch>
References: <cover.1244494646.git.trast@student.ethz.ch>
 <5f43aa9d0b69e99600a73bddd4c93217608ab661.1244494647.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>,
	Alexander Potashev <aspotashev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 23:03:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDlzO-0002u3-J7
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 23:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756116AbZFHVCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 17:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756079AbZFHVCd
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 17:02:33 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:34240 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755960AbZFHVCa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 17:02:30 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Jun 2009 23:02:31 +0200
Received: from localhost.localdomain ([77.58.128.129]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Jun 2009 23:02:14 +0200
X-Mailer: git-send-email 1.6.3.2.333.g27636
In-Reply-To: <5f43aa9d0b69e99600a73bddd4c93217608ab661.1244494647.git.trast@student.ethz.ch>
In-Reply-To: <cover.1244494646.git.trast@student.ethz.ch>
References: <cover.1244299302.git.trast@student.ethz.ch> <cover.1244494646.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 08 Jun 2009 21:02:14.0989 (UTC) FILETIME=[667DF7D0:01C9E87C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121108>

Change calls to die(..., strerror(errno)) to use the new die_errno().

In the process, also make slight style adjustments: at least state
_something_ about the function that failed (instead of just printing
the pathname), and put paths in single quotes.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 bisect.c                 |    5 ++---
 branch.c                 |    4 ++--
 builtin-apply.c          |    6 +++---
 builtin-blame.c          |    7 +++----
 builtin-clone.c          |   11 +++++------
 builtin-commit-tree.c    |    2 +-
 builtin-commit.c         |   23 ++++++++++-------------
 builtin-config.c         |    4 ++--
 builtin-diff.c           |    2 +-
 builtin-fast-export.c    |    2 +-
 builtin-fetch--tool.c    |    2 +-
 builtin-fmt-merge-msg.c  |    3 +--
 builtin-fsck.c           |    8 ++++----
 builtin-grep.c           |    2 +-
 builtin-merge.c          |    8 ++++----
 builtin-mv.c             |    2 +-
 builtin-pack-objects.c   |   14 +++++---------
 builtin-rm.c             |    2 +-
 builtin-send-pack.c      |    2 +-
 builtin-tag.c            |    7 +++----
 builtin-unpack-objects.c |    2 +-
 csum-file.c              |    5 ++---
 daemon.c                 |   15 +++++++--------
 diff.c                   |    4 ++--
 dir.c                    |    2 +-
 entry.c                  |    8 ++++----
 fast-import.c            |    4 ++--
 git.c                    |    6 +++---
 index-pack.c             |   21 ++++++++++-----------
 merge-recursive.c        |    6 +++---
 pack-refs.c              |    7 +++----
 pack-write.c             |   10 +++++-----
 pkt-line.c               |    4 ++--
 read-cache.c             |    6 +++---
 refs.c                   |    2 +-
 run-command.c            |    4 ++--
 setup.c                  |    8 ++++----
 sha1_file.c              |    2 +-
 shell.c                  |    2 +-
 test-sha1.c              |    2 +-
 wrapper.c                |    8 ++++----
 write_or_die.c           |    6 +++---
 42 files changed, 117 insertions(+), 133 deletions(-)

diff --git a/bisect.c b/bisect.c
index c43c120..281e16a 100644
--- a/bisect.c
+++ b/bisect.c
@@ -461,7 +461,7 @@ void read_bisect_paths(struct argv_array *array)
 	FILE *fp = fopen(filename, "r");
 
 	if (!fp)
-		die("Could not open file '%s': %s", filename, strerror(errno));
+		die_errno("Could not open file '%s'", filename);
 
 	while (strbuf_getline(&str, fp, '\n') != EOF) {
 		char *quoted;
@@ -632,8 +632,7 @@ static void mark_expected_rev(char *bisect_rev_hex)
 	int fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 
 	if (fd < 0)
-		die("could not create file '%s': %s",
-		    filename, strerror(errno));
+		die_errno("could not create file '%s'", filename);
 
 	bisect_rev_hex[len] = '\n';
 	write_or_die(fd, bisect_rev_hex, len + 1);
diff --git a/branch.c b/branch.c
index 62030af..05ef3f5 100644
--- a/branch.c
+++ b/branch.c
@@ -172,7 +172,7 @@ void create_branch(const char *head,
 
 	lock = lock_any_ref_for_update(ref.buf, NULL, 0);
 	if (!lock)
-		die("Failed to lock ref for update: %s.", strerror(errno));
+		die_errno("Failed to lock ref for update");
 
 	if (reflog)
 		log_all_ref_updates = 1;
@@ -188,7 +188,7 @@ void create_branch(const char *head,
 		setup_tracking(name, real_ref, track);
 
 	if (write_ref_sha1(lock, sha1, msg) < 0)
-		die("Failed to write ref: %s.", strerror(errno));
+		die_errno("Failed to write ref");
 
 	strbuf_release(&ref);
 	free(real_ref);
diff --git a/builtin-apply.c b/builtin-apply.c
index 94ba2bd..6526c08 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -280,7 +280,7 @@ static void say_patch_name(FILE *output, const char *pre,
 static void read_patch_file(struct strbuf *sb, int fd)
 {
 	if (strbuf_read(sb, fd, 0) < 0)
-		die("git apply: read returned %s", strerror(errno));
+		die_errno("git apply: failed to read");
 
 	/*
 	 * Make sure that we have some slop in the buffer
@@ -2864,7 +2864,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	strbuf_release(&nbuf);
 
 	if (close(fd) < 0)
-		die("closing file %s: %s", path, strerror(errno));
+		die_errno("closing file '%s'", path);
 	return 0;
 }
 
@@ -3354,7 +3354,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 
 		fd = open(arg, O_RDONLY);
 		if (fd < 0)
-			die("can't open patch '%s': %s", arg, strerror(errno));
+			die_errno("can't open patch '%s'", arg);
 		read_stdin = 0;
 		set_default_whitespace_mode(whitespace_option);
 		errs |= apply_patch(fd, arg, options);
diff --git a/builtin-blame.c b/builtin-blame.c
index 0c2d29a..7d8fbd5 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2035,7 +2035,7 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		contents_from = "standard input";
 		mode = 0;
 		if (strbuf_read(&buf, 0, 0) < 0)
-			die("read error %s from stdin", strerror(errno));
+			die_errno("failed to read from stdin");
 	}
 	convert_to_git(path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr = buf.buf;
@@ -2261,8 +2261,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	argc = parse_options_end(&ctx);
 
 	if (revs_file && read_ancestry(revs_file))
-		die("reading graft file %s failed: %s",
-		    revs_file, strerror(errno));
+		die_errno("reading graft file '%s' failed", revs_file);
 
 	if (cmd_is_annotate) {
 		output_option |= OUTPUT_ANNOTATE_COMPAT;
@@ -2350,7 +2349,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 		setup_work_tree();
 		if (!has_string_in_work_tree(path))
-			die("cannot stat path %s: %s", path, strerror(errno));
+			die_errno("cannot stat path '%s'", path);
 	}
 
 	setup_revisions(argc, argv, &revs, NULL);
diff --git a/builtin-clone.c b/builtin-clone.c
index 5c46496..5f34414 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -252,8 +252,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest)
 		}
 
 		if (unlink(dest->buf) && errno != ENOENT)
-			die("failed to unlink %s: %s",
-			    dest->buf, strerror(errno));
+			die_errno("failed to unlink '%s'", dest->buf);
 		if (!option_no_hardlinks) {
 			if (!link(src->buf, dest->buf))
 				continue;
@@ -420,11 +419,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (!option_bare) {
 		junk_work_tree = work_tree;
 		if (safe_create_leading_directories_const(work_tree) < 0)
-			die("could not create leading directories of '%s': %s",
-					work_tree, strerror(errno));
+			die_errno("could not create leading directories of '%s'",
+				  work_tree);
 		if (!dest_exists && mkdir(work_tree, 0755))
-			die("could not create work tree dir '%s': %s.",
-					work_tree, strerror(errno));
+			die_errno("could not create work tree dir '%s'.",
+				  work_tree);
 		set_git_work_tree(work_tree);
 	}
 	junk_git_dir = git_dir;
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 0453425..6467077 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -124,7 +124,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	}
 
 	if (strbuf_read(&buffer, 0, 0) < 0)
-		die("git commit-tree: read returned %s", strerror(errno));
+		die_errno("git commit-tree: failed to read");
 
 	if (!commit_tree(buffer.buf, tree_sha1, parents, commit_sha1, NULL)) {
 		printf("%s\n", sha1_to_hex(commit_sha1));
diff --git a/builtin-commit.c b/builtin-commit.c
index 41e222d..88c51bd 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -438,8 +438,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 		hook_arg1 = "message";
 	} else if (logfile) {
 		if (strbuf_read_file(&sb, logfile, 0) < 0)
-			die("could not read log file '%s': %s",
-			    logfile, strerror(errno));
+			die_errno("could not read log file '%s'",
+				  logfile);
 		hook_arg1 = "message";
 	} else if (use_message) {
 		buffer = strstr(use_message_buffer, "\n\n");
@@ -450,16 +450,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 		hook_arg2 = use_message;
 	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path("MERGE_MSG"), 0) < 0)
-			die("could not read MERGE_MSG: %s", strerror(errno));
+			die_errno("could not read MERGE_MSG");
 		hook_arg1 = "merge";
 	} else if (!stat(git_path("SQUASH_MSG"), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path("SQUASH_MSG"), 0) < 0)
-			die("could not read SQUASH_MSG: %s", strerror(errno));
+			die_errno("could not read SQUASH_MSG");
 		hook_arg1 = "squash";
 	} else if (template_file && !stat(template_file, &statbuf)) {
 		if (strbuf_read_file(&sb, template_file, 0) < 0)
-			die("could not read %s: %s",
-			    template_file, strerror(errno));
+			die_errno("could not read '%s'", template_file);
 		hook_arg1 = "template";
 	}
 
@@ -472,8 +471,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 
 	fp = fopen(git_path(commit_editmsg), "w");
 	if (fp == NULL)
-		die("could not open %s: %s",
-		    git_path(commit_editmsg), strerror(errno));
+		die_errno("could not open '%s'", git_path(commit_editmsg));
 
 	if (cleanup_mode != CLEANUP_NONE)
 		stripspace(&sb, 0);
@@ -497,7 +495,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 	}
 
 	if (fwrite(sb.buf, 1, sb.len, fp) < sb.len)
-		die("could not write commit template: %s", strerror(errno));
+		die_errno("could not write commit template");
 
 	strbuf_release(&sb);
 
@@ -940,8 +938,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		pptr = &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
 		fp = fopen(git_path("MERGE_HEAD"), "r");
 		if (fp == NULL)
-			die("could not open %s for reading: %s",
-			    git_path("MERGE_HEAD"), strerror(errno));
+			die_errno("could not open '%s' for reading",
+				  git_path("MERGE_HEAD"));
 		while (strbuf_getline(&m, fp, '\n') != EOF) {
 			unsigned char sha1[20];
 			if (get_sha1_hex(m.buf, sha1) < 0)
@@ -952,8 +950,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		strbuf_release(&m);
 		if (!stat(git_path("MERGE_MODE"), &statbuf)) {
 			if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
-				die("could not read MERGE_MODE: %s",
-						strerror(errno));
+				die_errno("could not read MERGE_MODE");
 			if (!strcmp(sb.buf, "no-ff"))
 				allow_fast_forward = 0;
 		}
diff --git a/builtin-config.c b/builtin-config.c
index 60915f9..a2d656e 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -383,8 +383,8 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 		check_argc(argc, 0, 0);
 		if (git_config(show_all_config, NULL) < 0) {
 			if (config_exclusive_filename)
-				die("unable to read config file %s: %s",
-				    config_exclusive_filename, strerror(errno));
+				die_errno("unable to read config file '%s'",
+					  config_exclusive_filename);
 			else
 				die("error processing config file(s)");
 		}
diff --git a/builtin-diff.c b/builtin-diff.c
index d75d69b..2e51f40 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -70,7 +70,7 @@ static int builtin_diff_b_f(struct rev_info *revs,
 		usage(builtin_diff_usage);
 
 	if (lstat(path, &st))
-		die("'%s': %s", path, strerror(errno));
+		die_errno("failed to stat '%s'", path);
 	if (!(S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)))
 		die("'%s': not a regular file or symlink", path);
 
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 6cef810..333d438 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -451,7 +451,7 @@ static void import_marks(char *input_file)
 	char line[512];
 	FILE *f = fopen(input_file, "r");
 	if (!f)
-		die("cannot read %s: %s", input_file, strerror(errno));
+		die_errno("cannot read '%s'", input_file);
 
 	while (fgets(line, sizeof(line), f)) {
 		uint32_t mark;
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 29356d2..3dbdf7a 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -8,7 +8,7 @@
 {
 	struct strbuf buf = STRBUF_INIT;
 	if (strbuf_read(&buf, 0, 1024) < 0) {
-		die("error reading standard input: %s", strerror(errno));
+		die_errno("error reading standard input");
 	}
 	return strbuf_detach(&buf, NULL);
 }
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index fbf9582..1248d5e 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -372,8 +372,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	}
 
 	if (strbuf_read(&input, fileno(in), 0) < 0)
-		die("could not read input file %s", strerror(errno));
-
+		die_errno("could not read input file");
 	ret = fmt_merge_msg(merge_summary, &input, &output);
 	if (ret)
 		return ret;
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 7da706c..a49dbe1 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -225,15 +225,15 @@ static void check_unreachable_object(struct object *obj)
 						&type, &size);
 				if (buf) {
 					if (fwrite(buf, size, 1, f) != 1)
-						die("Could not write %s: %s",
-						    filename, strerror(errno));
+						die_errno("Could not write '%s'",
+							  filename);
 					free(buf);
 				}
 			} else
 				fprintf(f, "%s\n", sha1_to_hex(obj->sha1));
 			if (fclose(f))
-				die("Could not finish %s: %s",
-				    filename, strerror(errno));
+				die_errno("Could not finish '%s'",
+					  filename);
 		}
 		return;
 	}
diff --git a/builtin-grep.c b/builtin-grep.c
index 73fc922..e558368 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -594,7 +594,7 @@ static int file_callback(const struct option *opt, const char *arg, int unset)
 
 	patterns = fopen(arg, "r");
 	if (!patterns)
-		die("'%s': %s", arg, strerror(errno));
+		die_errno("cannot open '%s'", arg);
 	while (strbuf_getline(&sb, patterns, '\n') == 0) {
 		/* ignore empty line like grep does */
 		if (sb.len == 0)
diff --git a/builtin-merge.c b/builtin-merge.c
index 8d101ef..436263b 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -294,9 +294,9 @@ static void squash_message(void)
 			NULL, NULL, rev.date_mode, 0);
 	}
 	if (write(fd, out.buf, out.len) < 0)
-		die("Writing SQUASH_MSG: %s", strerror(errno));
+		die_errno("Writing SQUASH_MSG");
 	if (close(fd))
-		die("Finishing SQUASH_MSG: %s", strerror(errno));
+		die_errno("Finishing SQUASH_MSG");
 	strbuf_release(&out);
 }
 
@@ -428,8 +428,8 @@ static void merge_name(const char *remote, struct strbuf *msg)
 
 		fp = fopen(git_path("FETCH_HEAD"), "r");
 		if (!fp)
-			die("could not open %s for reading: %s",
-				git_path("FETCH_HEAD"), strerror(errno));
+			die_errno("could not open '%s' for reading",
+				  git_path("FETCH_HEAD"));
 		strbuf_getline(&line, fp, '\n');
 		fclose(fp);
 		ptr = strstr(line.buf, "\tnot-for-merge\t");
diff --git a/builtin-mv.c b/builtin-mv.c
index 8b81d4b..024dfeb 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -209,7 +209,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			printf("Renaming %s to %s\n", src, dst);
 		if (!show_only && mode != INDEX &&
 				rename(src, dst) < 0 && !ignore_errors)
-			die ("renaming %s failed: %s", src, strerror(errno));
+			die_errno ("renaming '%s' failed", src);
 
 		if (mode == WORKING_DIRECTORY)
 			continue;
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 9742b45..60355d4 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -536,11 +536,9 @@ static void write_pack_file(void)
 				 base_name, sha1_to_hex(sha1));
 			free_pack_by_name(tmpname);
 			if (adjust_perm(pack_tmp_name, mode))
-				die("unable to make temporary pack file readable: %s",
-				    strerror(errno));
+				die_errno("unable to make temporary pack file readable");
 			if (rename(pack_tmp_name, tmpname))
-				die("unable to rename temporary pack file: %s",
-				    strerror(errno));
+				die_errno("unable to rename temporary pack file");
 
 			/*
 			 * Packs are runtime accessed in their mtime
@@ -566,11 +564,9 @@ static void write_pack_file(void)
 			snprintf(tmpname, sizeof(tmpname), "%s-%s.idx",
 				 base_name, sha1_to_hex(sha1));
 			if (adjust_perm(idx_tmp_name, mode))
-				die("unable to make temporary index file readable: %s",
-				    strerror(errno));
+				die_errno("unable to make temporary index file readable");
 			if (rename(idx_tmp_name, tmpname))
-				die("unable to rename temporary index file: %s",
-				    strerror(errno));
+				die_errno("unable to rename temporary index file");
 
 			free(idx_tmp_name);
 			free(pack_tmp_name);
@@ -1880,7 +1876,7 @@ static void read_object_list_from_stdin(void)
 			if (!ferror(stdin))
 				die("fgets returned NULL, not EOF, not error!");
 			if (errno != EINTR)
-				die("fgets: %s", strerror(errno));
+				die_errno("fgets");
 			clearerr(stdin);
 			continue;
 		}
diff --git a/builtin-rm.c b/builtin-rm.c
index 0cc4912..57975db 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -257,7 +257,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!removed)
-				die("git rm: %s: %s", path, strerror(errno));
+				die_errno("git rm: '%s'", path);
 		}
 	}
 
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index be3b092..8fe5ab9 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -59,7 +59,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 	po.out = fd;
 	po.git_cmd = 1;
 	if (start_command(&po))
-		die("git pack-objects failed (%s)", strerror(errno));
+		die_errno("git pack-objects failed");
 
 	/*
 	 * We feed the pack-objects we just spawned with revision
diff --git a/builtin-tag.c b/builtin-tag.c
index dc3db62..7b51095 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -308,8 +308,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 		path = git_pathdup("TAG_EDITMSG");
 		fd = open(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 		if (fd < 0)
-			die("could not create file '%s': %s",
-						path, strerror(errno));
+			die_errno("could not create file '%s'", path);
 
 		if (!is_null_sha1(prev))
 			write_tag_body(fd, prev);
@@ -446,8 +445,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 					die("cannot read %s", msgfile);
 			} else {
 				if (strbuf_read_file(&buf, msgfile, 1024) < 0)
-					die("could not open or read '%s': %s",
-						msgfile, strerror(errno));
+					die_errno("could not open or read '%s'",
+						msgfile);
 			}
 		}
 	}
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 9a77323..41e9ac5 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -68,7 +68,7 @@ static void add_object_buffer(struct object *object, char *buffer, unsigned long
 		if (ret <= 0) {
 			if (!ret)
 				die("early EOF");
-			die("read error on input: %s", strerror(errno));
+			die_errno("read error on input");
 		}
 		len += ret;
 	} while (len < min);
diff --git a/csum-file.c b/csum-file.c
index 2ddb12a..4d50cc5 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -26,7 +26,7 @@ static void flush(struct sha1file *f, void * buf, unsigned int count)
 		}
 		if (!ret)
 			die("sha1 file '%s' write error. Out of diskspace", f->name);
-		die("sha1 file '%s' write error (%s)", f->name, strerror(errno));
+		die_errno("sha1 file '%s' write error", f->name);
 	}
 }
 
@@ -55,8 +55,7 @@ int sha1close(struct sha1file *f, unsigned char *result, unsigned int flags)
 		if (flags & CSUM_FSYNC)
 			fsync_or_die(f->fd, f->name);
 		if (close(f->fd))
-			die("%s: sha1 file error on close (%s)",
-			    f->name, strerror(errno));
+			die_errno("%s: sha1 file error on close", f->name);
 		fd = 0;
 	} else
 		fd = f->fd;
diff --git a/daemon.c b/daemon.c
index b2babcc..0c2f326 100644
--- a/daemon.c
+++ b/daemon.c
@@ -862,7 +862,7 @@ static int service_loop(int socknum, int *socklist)
 					case ECONNABORTED:
 						continue;
 					default:
-						die("accept returned %s", strerror(errno));
+						die_errno("accept returned");
 					}
 				}
 				handle(incoming, (struct sockaddr *)&ss, sslen);
@@ -878,7 +878,7 @@ static void sanitize_stdfds(void)
 	while (fd != -1 && fd < 2)
 		fd = dup(fd);
 	if (fd == -1)
-		die("open /dev/null or dup failed: %s", strerror(errno));
+		die_errno("open /dev/null or dup failed");
 	if (fd > 2)
 		close(fd);
 }
@@ -889,12 +889,12 @@ static void daemonize(void)
 		case 0:
 			break;
 		case -1:
-			die("fork failed: %s", strerror(errno));
+			die_errno("fork failed");
 		default:
 			exit(0);
 	}
 	if (setsid() == -1)
-		die("setsid failed: %s", strerror(errno));
+		die_errno("setsid failed");
 	close(0);
 	close(1);
 	close(2);
@@ -905,9 +905,9 @@ static void store_pid(const char *path)
 {
 	FILE *f = fopen(path, "w");
 	if (!f)
-		die("cannot open pid file %s: %s", path, strerror(errno));
+		die_errno("cannot open pid file '%s'", path);
 	if (fprintf(f, "%"PRIuMAX"\n", (uintmax_t) getpid()) < 0 || fclose(f) != 0)
-		die("failed to write pid file %s: %s", path, strerror(errno));
+		die_errno("failed to write pid file '%s'", path);
 }
 
 static int serve(char *listen_addr, int listen_port, struct passwd *pass, gid_t gid)
@@ -1107,8 +1107,7 @@ int main(int argc, char **argv)
 		socklen_t slen = sizeof(ss);
 
 		if (!freopen("/dev/null", "w", stderr))
-			die("failed to redirect stderr to /dev/null: %s",
-			    strerror(errno));
+			die_errno("failed to redirect stderr to /dev/null");
 
 		if (getpeername(0, peer, &slen))
 			peer = NULL;
diff --git a/diff.c b/diff.c
index 4d0a5b9..48043f5 100644
--- a/diff.c
+++ b/diff.c
@@ -1975,7 +1975,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 	fd = git_mkstemps(temp->tmp_path, PATH_MAX, template.buf,
 			strlen(base) + 1);
 	if (fd < 0)
-		die("unable to create temp-file: %s", strerror(errno));
+		die_errno("unable to create temp-file");
 	if (convert_to_working_tree(path,
 			(const char *)blob, (size_t)size, &buf)) {
 		blob = buf.buf;
@@ -2021,7 +2021,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 		if (lstat(name, &st) < 0) {
 			if (errno == ENOENT)
 				goto not_a_valid_file;
-			die("stat(%s): %s", name, strerror(errno));
+			die_errno("stat(%s)", name);
 		}
 		if (S_ISLNK(st.st_mode)) {
 			struct strbuf sb = STRBUF_INIT;
diff --git a/dir.c b/dir.c
index bbfcb56..74b3bbf 100644
--- a/dir.c
+++ b/dir.c
@@ -759,7 +759,7 @@ int file_exists(const char *f)
 	if (!dir)
 		return NULL;
 	if (!getcwd(buffer, size))
-		die("can't find the current directory: %s", strerror(errno));
+		die_errno("can't find the current directory");
 
 	if (!is_absolute_path(dir))
 		dir = make_absolute_path(dir);
diff --git a/entry.c b/entry.c
index cc841ed..8ec880b 100644
--- a/entry.c
+++ b/entry.c
@@ -51,7 +51,7 @@ static void remove_subtree(const char *path)
 	char *name;
 
 	if (!dir)
-		die("cannot opendir %s (%s)", path, strerror(errno));
+		die_errno("cannot opendir '%s'", path);
 	strcpy(pathbuf, path);
 	name = pathbuf + strlen(path);
 	*name++ = '/';
@@ -61,15 +61,15 @@ static void remove_subtree(const char *path)
 			continue;
 		strcpy(name, de->d_name);
 		if (lstat(pathbuf, &st))
-			die("cannot lstat %s (%s)", pathbuf, strerror(errno));
+			die_errno("cannot lstat '%s'", pathbuf);
 		if (S_ISDIR(st.st_mode))
 			remove_subtree(pathbuf);
 		else if (unlink(pathbuf))
-			die("cannot unlink %s (%s)", pathbuf, strerror(errno));
+			die_errno("cannot unlink '%s'", pathbuf);
 	}
 	closedir(dir);
 	if (rmdir(path))
-		die("cannot rmdir %s (%s)", path, strerror(errno));
+		die_errno("cannot rmdir '%s'", path);
 }
 
 static int create_file(const char *path, unsigned int mode)
diff --git a/fast-import.c b/fast-import.c
index a2a2458..d31a4e8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2342,7 +2342,7 @@ static void import_marks(const char *input_file)
 	char line[512];
 	FILE *f = fopen(input_file, "r");
 	if (!f)
-		die("cannot read %s: %s", input_file, strerror(errno));
+		die_errno("cannot read '%s'", input_file);
 	while (fgets(line, sizeof(line), f)) {
 		uintmax_t mark;
 		char *end;
@@ -2448,7 +2448,7 @@ int main(int argc, const char **argv)
 				fclose(pack_edges);
 			pack_edges = fopen(a + 20, "a");
 			if (!pack_edges)
-				die("Cannot open %s: %s", a + 20, strerror(errno));
+				die_errno("Cannot open '%s'", a + 20);
 		} else if (!strcmp(a, "--force"))
 			force_update = 1;
 		else if (!strcmp(a, "--quiet"))
diff --git a/git.c b/git.c
index 7d7f949..b035676 100644
--- a/git.c
+++ b/git.c
@@ -200,7 +200,7 @@ static int handle_alias(int *argcp, const char ***argv)
 	}
 
 	if (subdir && chdir(subdir))
-		die("Cannot change to %s: %s", subdir, strerror(errno));
+		die_errno("Cannot change to '%s'", subdir);
 
 	errno = saved_errno;
 
@@ -257,11 +257,11 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 	/* Check for ENOSPC and EIO errors.. */
 	if (fflush(stdout))
-		die("write failure on standard output: %s", strerror(errno));
+		die_errno("write failure on standard output");
 	if (ferror(stdout))
 		die("unknown write failure on standard output");
 	if (fclose(stdout))
-		die("close failed on standard output: %s", strerror(errno));
+		die_errno("close failed on standard output");
 	return 0;
 }
 
diff --git a/index-pack.c b/index-pack.c
index 6e93ee6..cf6446f 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -143,7 +143,7 @@ static void flush(void)
 		if (ret <= 0) {
 			if (!ret)
 				die("early EOF");
-			die("read error on input: %s", strerror(errno));
+			die_errno("read error on input");
 		}
 		input_len += ret;
 		if (from_stdin)
@@ -178,13 +178,12 @@ static void use(int bytes)
 		} else
 			output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
 		if (output_fd < 0)
-			die("unable to create %s: %s", pack_name, strerror(errno));
+			die_errno("unable to create '%s'", pack_name);
 		pack_fd = output_fd;
 	} else {
 		input_fd = open(pack_name, O_RDONLY);
 		if (input_fd < 0)
-			die("cannot open packfile '%s': %s",
-			    pack_name, strerror(errno));
+			die_errno("cannot open packfile '%s'", pack_name);
 		output_fd = -1;
 		pack_fd = input_fd;
 	}
@@ -370,7 +369,7 @@ static void unlink_base_data(struct base_data *c)
 	do {
 		ssize_t n = pread(pack_fd, data + rdy, len - rdy, from + rdy);
 		if (n < 0)
-			die("cannot pread pack file: %s", strerror(errno));
+			die_errno("cannot pread pack file");
 		if (!n)
 			die("premature end of pack file, %lu bytes missing",
 			    len - rdy);
@@ -631,7 +630,7 @@ static void parse_pack_objects(unsigned char *sha1)
 
 	/* If input_fd is a file, we should have reached its end now. */
 	if (fstat(input_fd, &st))
-		die("cannot fstat packfile: %s", strerror(errno));
+		die_errno("cannot fstat packfile");
 	if (S_ISREG(st.st_mode) &&
 			lseek(input_fd, 0, SEEK_CUR) - input_len != st.st_size)
 		die("pack has junk at the end");
@@ -788,7 +787,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		fsync_or_die(output_fd, curr_pack_name);
 		err = close(output_fd);
 		if (err)
-			die("error while closing pack file: %s", strerror(errno));
+			die_errno("error while closing pack file");
 	}
 
 	if (keep_msg) {
@@ -801,16 +800,16 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 
 		if (keep_fd < 0) {
 			if (errno != EEXIST)
-				die("cannot write keep file '%s' (%s)",
-				    keep_name, strerror(errno));
+				die_errno("cannot write keep file '%s'",
+					  keep_name);
 		} else {
 			if (keep_msg_len > 0) {
 				write_or_die(keep_fd, keep_msg, keep_msg_len);
 				write_or_die(keep_fd, "\n", 1);
 			}
 			if (close(keep_fd) != 0)
-				die("cannot close written keep file '%s' (%s)",
-				    keep_name, strerror(errno));
+				die_errno("cannot close written keep file '%s'",
+				    keep_name);
 			report = "keep";
 		}
 	}
diff --git a/merge-recursive.c b/merge-recursive.c
index f5df9b9..5d9140b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -438,7 +438,7 @@ static void flush_buffer(int fd, const char *buf, unsigned long size)
 			/* Ignore epipe */
 			if (errno == EPIPE)
 				break;
-			die("merge-recursive: %s", strerror(errno));
+			die_errno("merge-recursive");
 		} else if (!ret) {
 			die("merge-recursive: disk full?");
 		}
@@ -554,7 +554,7 @@ static void update_file_flags(struct merge_options *o,
 				mode = 0666;
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 			if (fd < 0)
-				die("failed to open %s: %s", path, strerror(errno));
+				die_errno("failed to open '%s'", path);
 			flush_buffer(fd, buf, size);
 			close(fd);
 		} else if (S_ISLNK(mode)) {
@@ -562,7 +562,7 @@ static void update_file_flags(struct merge_options *o,
 			safe_create_leading_directories_const(path);
 			unlink(path);
 			if (symlink(lnk, path))
-				die("failed to symlink %s: %s", path, strerror(errno));
+				die_errno("failed to symlink '%s'", path);
 			free(lnk);
 		} else
 			die("do not know what to do with %06o %s '%s'",
diff --git a/pack-refs.c b/pack-refs.c
index 301fc60..7f43f8a 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -93,8 +93,7 @@ int pack_refs(unsigned int flags)
 				       LOCK_DIE_ON_ERROR);
 	cbdata.refs_file = fdopen(fd, "w");
 	if (!cbdata.refs_file)
-		die("unable to create ref-pack file structure (%s)",
-		    strerror(errno));
+		die_errno("unable to create ref-pack file structure");
 
 	/* perhaps other traits later as well */
 	fprintf(cbdata.refs_file, "# pack-refs with: peeled \n");
@@ -103,7 +102,7 @@ int pack_refs(unsigned int flags)
 	if (ferror(cbdata.refs_file))
 		die("failed to write ref-pack file");
 	if (fflush(cbdata.refs_file) || fsync(fd) || fclose(cbdata.refs_file))
-		die("failed to write ref-pack file (%s)", strerror(errno));
+		die_errno("failed to write ref-pack file");
 	/*
 	 * Since the lock file was fdopen()'ed and then fclose()'ed above,
 	 * assign -1 to the lock file descriptor so that commit_lock_file()
@@ -111,7 +110,7 @@ int pack_refs(unsigned int flags)
 	 */
 	packed.fd = -1;
 	if (commit_lock_file(&packed) < 0)
-		die("unable to overwrite old ref-pack file (%s)", strerror(errno));
+		die_errno("unable to overwrite old ref-pack file");
 	if (cbdata.flags & PACK_REFS_PRUNE)
 		prune_refs(cbdata.ref_to_prune);
 	return 0;
diff --git a/pack-write.c b/pack-write.c
index 7053538..741efcd 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -51,7 +51,7 @@ static int sha1_compare(const void *_a, const void *_b)
 		fd = open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
 	}
 	if (fd < 0)
-		die("unable to create %s: %s", index_name, strerror(errno));
+		die_errno("unable to create '%s'", index_name);
 	f = sha1fd(fd, index_name);
 
 	/* if last object's offset is >= 2^31 we should use index V2 */
@@ -174,11 +174,11 @@ void fixup_pack_header_footer(int pack_fd,
 	git_SHA1_Init(&new_sha1_ctx);
 
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
-		die("Failed seeking to start of %s: %s", pack_name, strerror(errno));
+		die_errno("Failed seeking to start of '%s'", pack_name);
 	if (read_in_full(pack_fd, &hdr, sizeof(hdr)) != sizeof(hdr))
-		die("Unable to reread header of %s: %s", pack_name, strerror(errno));
+		die_errno("Unable to reread header of '%s'", pack_name);
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
-		die("Failed seeking to start of %s: %s", pack_name, strerror(errno));
+		die_errno("Failed seeking to start of '%s'", pack_name);
 	git_SHA1_Update(&old_sha1_ctx, &hdr, sizeof(hdr));
 	hdr.hdr_entries = htonl(object_count);
 	git_SHA1_Update(&new_sha1_ctx, &hdr, sizeof(hdr));
@@ -195,7 +195,7 @@ void fixup_pack_header_footer(int pack_fd,
 		if (!n)
 			break;
 		if (n < 0)
-			die("Failed to checksum %s: %s", pack_name, strerror(errno));
+			die_errno("Failed to checksum '%s'", pack_name);
 		git_SHA1_Update(&new_sha1_ctx, buf, n);
 
 		aligned_sz -= n;
diff --git a/pkt-line.c b/pkt-line.c
index f5d0086..b691abe 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -28,7 +28,7 @@ ssize_t safe_write(int fd, const void *buf, ssize_t n)
 		}
 		if (!ret)
 			die("write error (disk full?)");
-		die("write error (%s)", strerror(errno));
+		die_errno("write error");
 	}
 	return nn;
 }
@@ -67,7 +67,7 @@ static void safe_read(int fd, void *buffer, unsigned size)
 {
 	ssize_t ret = read_in_full(fd, buffer, size);
 	if (ret < 0)
-		die("read error (%s)", strerror(errno));
+		die_errno("read error");
 	else if (ret < size)
 		die("The remote end hung up unexpectedly");
 }
diff --git a/read-cache.c b/read-cache.c
index 3f58711..f76b5bb 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -638,7 +638,7 @@ int add_file_to_index(struct index_state *istate, const char *path, int flags)
 {
 	struct stat st;
 	if (lstat(path, &st))
-		die("%s: unable to stat (%s)", path, strerror(errno));
+		die_errno("unable to stat '%s'", path);
 	return add_to_index(istate, path, &st, flags);
 }
 
@@ -1251,11 +1251,11 @@ int read_index_from(struct index_state *istate, const char *path)
 	if (fd < 0) {
 		if (errno == ENOENT)
 			return 0;
-		die("index file open failed (%s)", strerror(errno));
+		die_errno("index file open failed");
 	}
 
 	if (fstat(fd, &st))
-		die("cannot stat the open index (%s)", strerror(errno));
+		die_errno("cannot stat the open index");
 
 	errno = EINVAL;
 	mmap_size = xsize_t(st.st_size);
diff --git a/refs.c b/refs.c
index 24438c6..dffe395 100644
--- a/refs.c
+++ b/refs.c
@@ -1418,7 +1418,7 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 	logfile = git_path("logs/%s", ref);
 	logfd = open(logfile, O_RDONLY, 0);
 	if (logfd < 0)
-		die("Unable to read log %s: %s", logfile, strerror(errno));
+		die_errno("Unable to read log '%s'", logfile);
 	fstat(logfd, &st);
 	if (!st.st_size)
 		die("Log %s is empty.", logfile);
diff --git a/run-command.c b/run-command.c
index eb2efc3..ff3d8e2 100644
--- a/run-command.c
+++ b/run-command.c
@@ -101,8 +101,8 @@ int start_command(struct child_process *cmd)
 		}
 
 		if (cmd->dir && chdir(cmd->dir))
-			die("exec %s: cd to %s failed (%s)", cmd->argv[0],
-			    cmd->dir, strerror(errno));
+			die_errno("exec '%s': cd to '%s' failed", cmd->argv[0],
+			    cmd->dir);
 		if (cmd->env) {
 			for (; *cmd->env; cmd->env++) {
 				if (strchr(*cmd->env, '='))
diff --git a/setup.c b/setup.c
index ebd60de..4d27f28 100644
--- a/setup.c
+++ b/setup.c
@@ -81,7 +81,7 @@ void verify_filename(const char *prefix, const char *arg)
 	if (errno == ENOENT)
 		die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
 		    "Use '--' to separate paths from revisions", arg);
-	die("'%s': %s", arg, strerror(errno));
+	die_errno("failed to stat '%s'", arg);
 }
 
 /*
@@ -103,7 +103,7 @@ void verify_non_filename(const char *prefix, const char *arg)
 		die("ambiguous argument '%s': both revision and filename\n"
 		    "Use '--' to separate filenames from revisions", arg);
 	if (errno != ENOENT && errno != ENOTDIR)
-		die("'%s': %s", arg, strerror(errno));
+		die_errno("failed to stat '%s'", arg);
 }
 
 const char **get_pathspec(const char *prefix, const char **pathspec)
@@ -257,7 +257,7 @@ static int check_repository_format_gently(int *nongit_ok)
 		return NULL;
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
-		die("Error opening %s: %s", path, strerror(errno));
+		die_errno("Error opening '%s'", path);
 	buf = xmalloc(st.st_size + 1);
 	len = read_in_full(fd, buf, st.st_size);
 	close(fd);
@@ -389,7 +389,7 @@ static int check_repository_format_gently(int *nongit_ok)
 			die("Not a git repository (or any of the parent directories): %s", DEFAULT_GIT_DIR_ENVIRONMENT);
 		}
 		if (chdir(".."))
-			die("Cannot change to %s/..: %s", cwd, strerror(errno));
+			die_errno("Cannot change to '%s/..'", cwd);
 	}
 
 	inside_git_dir = 0;
diff --git a/sha1_file.c b/sha1_file.c
index e73cd4f..1964a6d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2287,7 +2287,7 @@ static void close_sha1_file(int fd)
 	if (fsync_object_files)
 		fsync_or_die(fd, "sha1 file");
 	if (close(fd) != 0)
-		die("error when closing sha1 file (%s)", strerror(errno));
+		die_errno("error when closing sha1 file");
 }
 
 /* Size of directory component, including the ending '/' */
diff --git a/shell.c b/shell.c
index b968be7..e4864e0 100644
--- a/shell.c
+++ b/shell.c
@@ -60,7 +60,7 @@ int main(int argc, char **argv)
 	while (devnull_fd >= 0 && devnull_fd <= 2)
 		devnull_fd = dup(devnull_fd);
 	if (devnull_fd == -1)
-		die("opening /dev/null failed (%s)", strerror(errno));
+		die_errno("opening /dev/null failed");
 	close (devnull_fd);
 
 	/*
diff --git a/test-sha1.c b/test-sha1.c
index 9b98d07..80daba9 100644
--- a/test-sha1.c
+++ b/test-sha1.c
@@ -32,7 +32,7 @@ int main(int ac, char **av)
 			if (sz == 0)
 				break;
 			if (sz < 0)
-				die("test-sha1: %s", strerror(errno));
+				die_errno("test-sha1");
 			this_sz += sz;
 			cp += sz;
 			room -= sz;
diff --git a/wrapper.c b/wrapper.c
index 7eb3218..c9be140 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -96,7 +96,7 @@
 		release_pack_memory(length, fd);
 		ret = mmap(start, length, prot, flags, fd, offset);
 		if (ret == MAP_FAILED)
-			die("Out of memory? mmap failed: %s", strerror(errno));
+			die_errno("Out of memory? mmap failed");
 	}
 	return ret;
 }
@@ -175,7 +175,7 @@ int xdup(int fd)
 {
 	int ret = dup(fd);
 	if (ret < 0)
-		die("dup failed: %s", strerror(errno));
+		die_errno("dup failed");
 	return ret;
 }
 
@@ -183,7 +183,7 @@ int xdup(int fd)
 {
 	FILE *stream = fdopen(fd, mode);
 	if (stream == NULL)
-		die("Out of memory? fdopen failed: %s", strerror(errno));
+		die_errno("Out of memory? fdopen failed");
 	return stream;
 }
 
@@ -193,7 +193,7 @@ int xmkstemp(char *template)
 
 	fd = mkstemp(template);
 	if (fd < 0)
-		die("Unable to create temporary file: %s", strerror(errno));
+		die_errno("Unable to create temporary file");
 	return fd;
 }
 
diff --git a/write_or_die.c b/write_or_die.c
index 4c29255..d45b536 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -41,14 +41,14 @@ void maybe_flush_or_die(FILE *f, const char *desc)
 		 */
 		if (errno == EPIPE || errno == EINVAL)
 			exit(0);
-		die("write failure on %s: %s", desc, strerror(errno));
+		die_errno("write failure on '%s'", desc);
 	}
 }
 
 void fsync_or_die(int fd, const char *msg)
 {
 	if (fsync(fd) < 0) {
-		die("%s: fsync error (%s)", msg, strerror(errno));
+		die_errno("fsync error on '%s'", msg);
 	}
 }
 
@@ -57,7 +57,7 @@ void write_or_die(int fd, const void *buf, size_t count)
 	if (write_in_full(fd, buf, count) < 0) {
 		if (errno == EPIPE)
 			exit(0);
-		die("write error (%s)", strerror(errno));
+		die_errno("write error");
 	}
 }
 
-- 
1.6.3.2.333.g27636
