From: Giuseppe Scrivano <gscrivano@gnu.org>
Subject: [PATCH] Remove various dead assignments and dead increments found by the clang static analyzer
Date: Sat, 26 Sep 2009 16:46:00 +0200
Message-ID: <87ab0hepcn.fsf@master.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 26 16:52:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrYdI-0006SQ-OY
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 16:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbZIZOvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 10:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbZIZOvt
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 10:51:49 -0400
Received: from averell.mail.tiscali.it ([213.205.33.55]:37216 "EHLO
	averell.mail.tiscali.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbZIZOvr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 10:51:47 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Sep 2009 10:51:47 EDT
Received: from master.homenet (84.223.203.227) by averell.mail.tiscali.it (8.0.022)
        id 4AA780C800752896; Sat, 26 Sep 2009 16:46:07 +0200
Received: from gscrivano by master.homenet with local (Exim 4.69)
	(envelope-from <gscrivano@gnu.org>)
	id 1MrYXA-0001hc-A9; Sat, 26 Sep 2009 16:46:00 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129156>

Hello,

I tried the clang static analyzer on the git source code, this patch
fixes the found dead assignments/increments.


Regards,
Giuseppe Scrivano



>From 88fe9b63d159ad1fd0579564558fbf0f900bd8e3 Mon Sep 17 00:00:00 2001
From: Giuseppe Scrivano <gscrivano@gnu.org>
Date: Sat, 26 Sep 2009 16:34:56 +0200
Subject: [PATCH] Remove various dead assignments and dead increments found by the clang static analyzer

---
 archive.c                |    2 +-
 builtin-add.c            |    2 +-
 builtin-bisect--helper.c |    2 +-
 builtin-commit.c         |    2 +-
 builtin-fetch--tool.c    |    2 +-
 builtin-fetch-pack.c     |    2 +-
 builtin-grep.c           |    2 --
 builtin-help.c           |    2 +-
 builtin-ls-files.c       |    2 +-
 builtin-mktree.c         |    2 +-
 builtin-pack-objects.c   |    2 +-
 builtin-prune-packed.c   |    2 +-
 builtin-receive-pack.c   |    6 +++---
 builtin-rev-parse.c      |    2 +-
 builtin-send-pack.c      |    2 +-
 builtin-show-branch.c    |    4 ++--
 builtin-show-ref.c       |    2 +-
 builtin-write-tree.c     |    2 +-
 color.c                  |    2 +-
 compat/mkstemps.c        |    2 +-
 connect.c                |    1 -
 diff.c                   |    2 +-
 http-fetch.c             |    3 +--
 transport.c              |    4 ++--
 upload-pack.c            |    2 +-
 25 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/archive.c b/archive.c
index 73b8e8a..88feed7 100644
--- a/archive.c
+++ b/archive.c
@@ -357,7 +357,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	const struct archiver *ar = NULL;
 	struct archiver_args args;
 
-	argc = parse_archive_args(argc, argv, &ar, &args);
+	parse_archive_args(argc, argv, &ar, &args);
 	if (setup_prefix && prefix == NULL)
 		prefix = setup_git_directory();
 
diff --git a/builtin-add.c b/builtin-add.c
index cb6e590..2788315 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -193,7 +193,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	init_revisions(&rev, prefix);
 	rev.diffopt.context = 7;
 
-	argc = setup_revisions(argc, argv, &rev, NULL);
+	setup_revisions(argc, argv, &rev, NULL);
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 	out = open(file, O_CREAT | O_WRONLY, 0644);
 	if (out < 0)
diff --git a/builtin-bisect--helper.c b/builtin-bisect--helper.c
index 5b22639..f9c7695 100644
--- a/builtin-bisect--helper.c
+++ b/builtin-bisect--helper.c
@@ -17,7 +17,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options,
+	parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage, 0);
 
 	if (!next_all)
diff --git a/builtin-commit.c b/builtin-commit.c
index 200ffda..56b595f 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1035,7 +1035,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			parents = reduce_heads(parents);
 	} else {
 		reflog_msg = "commit";
-		pptr = &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
+		commit_list_insert(lookup_commit(head_sha1), pptr)->next;
 	}
 
 	/* Finally, get the commit message */
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 3dbdf7a..c47469f 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -169,7 +169,7 @@ static int append_fetch_head(FILE *fp,
 			note_len += sprintf(note + note_len, "%s ", kind);
 		note_len += sprintf(note + note_len, "'%s' of ", what);
 	}
-	note_len += sprintf(note + note_len, "%.*s", remote_len, remote);
+	sprintf(note + note_len, "%.*s", remote_len, remote);
 	fprintf(fp, "%s\t%s\t%s\n",
 		sha1_to_hex(commit ? commit->object.sha1 : sha1),
 		not_for_merge ? "not-for-merge" : "",
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 629735f..583f4e3 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -555,7 +555,7 @@ static int get_pack(int xd[2], char **pack_lockfile)
 	}
 	if (*hdr_arg)
 		*av++ = hdr_arg;
-	*av++ = NULL;
+	*av = NULL;
 
 	cmd.in = demux.out;
 	cmd.git_cmd = 1;
diff --git a/builtin-grep.c b/builtin-grep.c
index 761799d..d36b59e 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -400,7 +400,6 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 				if (sizeof(randarg) <= len)
 					die("maximum length of args exceeded");
 				push_arg(argptr);
-				argptr += len;
 			}
 		}
 		else {
@@ -410,7 +409,6 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 			if (sizeof(randarg) <= len)
 				die("maximum length of args exceeded");
 			push_arg(argptr);
-			argptr += len;
 		}
 	}
 	for (p = opt->pattern_list; p; p = p->next) {
diff --git a/builtin-help.c b/builtin-help.c
index e1eba77..76307fd 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -419,7 +419,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	setup_git_directory_gently(&nongit);
 	git_config(git_help_config, NULL);
 
-	argc = parse_options(argc, argv, prefix, builtin_help_options,
+	parse_options(argc, argv, prefix, builtin_help_options,
 			builtin_help_usage, 0);
 
 	if (show_all) {
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index f473220..80212f4 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -481,7 +481,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		prefix_offset = strlen(prefix);
 	git_config(git_default_config, NULL);
 
-	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
+	parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
 	if (show_tag || show_valid_bit) {
 		tag_cached = "H ";
diff --git a/builtin-mktree.c b/builtin-mktree.c
index 098395f..36053cf 100644
--- a/builtin-mktree.c
+++ b/builtin-mktree.c
@@ -155,7 +155,7 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 		OPT_END()
 	};
 
-	ac = parse_options(ac, av, prefix, option, mktree_usage, 0);
+	parse_options(ac, av, prefix, option, mktree_usage, 0);
 
 	while (!got_eof) {
 		while (1) {
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 02f9246..bea7141 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -2307,7 +2307,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	 */
 
 	if (!pack_to_stdout)
-		base_name = argv[i++];
+		base_name = argv[i];
 
 	if (pack_to_stdout != !base_name)
 		usage(pack_usage);
diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index be99eb0..9a8fcfe 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -78,7 +78,7 @@ int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, prune_packed_options,
+	parse_options(argc, argv, prefix, prune_packed_options,
 			     prune_packed_usage, 0);
 
 	prune_packed_objects(opts);
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index b771fe9..957e7f0 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -391,7 +391,7 @@ static void run_update_post_hook(struct command *cmd)
 		argc++;
 	}
 	argv[argc] = NULL;
-	status = run_command_v_opt(argv, RUN_COMMAND_NO_STDIN
+	run_command_v_opt(argv, RUN_COMMAND_NO_STDIN
 			| RUN_COMMAND_STDOUT_TO_STDERR);
 }
 
@@ -506,7 +506,7 @@ static const char *unpack(void)
 		if (receive_fsck_objects)
 			unpacker[i++] = "--strict";
 		unpacker[i++] = hdr_arg;
-		unpacker[i++] = NULL;
+		unpacker[i] = NULL;
 		code = run_command_v_opt(unpacker, RUN_GIT_CMD);
 		if (!code)
 			return NULL;
@@ -528,7 +528,7 @@ static const char *unpack(void)
 		keeper[i++] = "--fix-thin";
 		keeper[i++] = hdr_arg;
 		keeper[i++] = keep_arg;
-		keeper[i++] = NULL;
+		keeper[i] = NULL;
 		memset(&ip, 0, sizeof(ip));
 		ip.argv = keeper;
 		ip.out = -1;
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 45bead6..4a66ba4 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -396,7 +396,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	/* put an OPT_END() */
 	ALLOC_GROW(opts, onb + 1, osz);
 	memset(opts + onb, 0, sizeof(opts[onb]));
-	argc = parse_options(argc, argv, prefix, opts, usage,
+	parse_options(argc, argv, prefix, opts, usage,
 			keep_dashdash ? PARSE_OPT_KEEP_DASHDASH : 0 |
 			stop_at_non_option ? PARSE_OPT_STOP_AT_NON_OPTION : 0);
 
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 37e528e..5afd542 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -55,7 +55,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 	if (args->use_ofs_delta)
 		argv[i++] = "--delta-base-offset";
 	if (args->quiet)
-		argv[i++] = "-q";
+		argv[i] = "-q";
 	memset(&po, 0, sizeof(po));
 	po.argv = argv;
 	po.in = -1;
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 3510a86..e567eb5 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -191,9 +191,9 @@ static void name_commits(struct commit_list *list,
 					break;
 				}
 				if (nth == 1)
-					en += sprintf(en, "^");
+					sprintf(en, "^");
 				else
-					en += sprintf(en, "^%d", nth);
+					sprintf(en, "^%d", nth);
 				name_commit(p, xstrdup(newname), 0);
 				i++;
 				name_first_parent_chain(p);
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index c46550c..8a0ae6c 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -201,7 +201,7 @@ static const struct option show_ref_options[] = {
 
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
-	argc = parse_options(argc, argv, prefix, show_ref_options,
+	parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, PARSE_OPT_NO_INTERNAL_HELP);
 
 	if (exclude_arg)
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index b223af4..848c3e4 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -34,7 +34,7 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 	};
 
 	git_config(git_default_config, NULL);
-	argc = parse_options(argc, argv, unused_prefix, write_tree_options,
+	parse_options(argc, argv, unused_prefix, write_tree_options,
 			     write_tree_usage, 0);
 
 	ret = write_cache_as_tree(sha1, flags, prefix);
diff --git a/color.c b/color.c
index 62977f4..5b31588 100644
--- a/color.c
+++ b/color.c
@@ -110,7 +110,7 @@ void color_parse_mem(const char *value, int value_len, const char *var,
 			}
 		}
 		if (bg >= 0) {
-			if (sep++)
+			if (sep)
 				*dst++ = ';';
 			if (bg < 8) {
 				*dst++ = '4';
diff --git a/compat/mkstemps.c b/compat/mkstemps.c
index 14179c8..dbf916e 100644
--- a/compat/mkstemps.c
+++ b/compat/mkstemps.c
@@ -45,7 +45,7 @@ int gitmkstemps(char *pattern, int suffix_len)
 		template[2] = letters[v % num_letters]; v /= num_letters;
 		template[3] = letters[v % num_letters]; v /= num_letters;
 		template[4] = letters[v % num_letters]; v /= num_letters;
-		template[5] = letters[v % num_letters]; v /= num_letters;
+		template[5] = letters[v % num_letters];
 
 		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, 0600);
 		if (fd > 0)
diff --git a/connect.c b/connect.c
index 7945e38..da6c7c1 100644
--- a/connect.c
+++ b/connect.c
@@ -18,7 +18,6 @@ static int check_ref(const char *name, int len, unsigned int flags)
 
 	/* Skip the "refs/" part */
 	name += 5;
-	len -= 5;
 
 	/* REF_NORMAL means that we don't want the magic fake tag refs */
 	if ((flags & REF_NORMAL) && check_ref_format(name) < 0)
diff --git a/diff.c b/diff.c
index e1be189..e75f58e 100644
--- a/diff.c
+++ b/diff.c
@@ -901,7 +901,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 
 	/* Find the longest filename and max number of changes */
 	reset = diff_get_color_opt(options, DIFF_RESET);
-	set   = diff_get_color_opt(options, DIFF_PLAIN);
+	diff_get_color_opt(options, DIFF_PLAIN);
 	add_c = diff_get_color_opt(options, DIFF_FILE_NEW);
 	del_c = diff_get_color_opt(options, DIFF_FILE_OLD);
 
diff --git a/http-fetch.c b/http-fetch.c
index e8f44ba..6879904 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -3,7 +3,6 @@
 
 int main(int argc, const char **argv)
 {
-	const char *prefix;
 	struct walker *walker;
 	int commits_on_stdin = 0;
 	int commits;
@@ -19,7 +18,7 @@ int main(int argc, const char **argv)
 	int get_verbosely = 0;
 	int get_recover = 0;
 
-	prefix = setup_git_directory();
+	setup_git_directory();
 
 	git_config(git_default_config, NULL);
 
diff --git a/transport.c b/transport.c
index 644a30a..8ec0df6 100644
--- a/transport.c
+++ b/transport.c
@@ -308,7 +308,7 @@ static int rsync_transport_push(struct transport *transport,
 	args[i++] = "info";
 	args[i++] = get_object_directory();
 	args[i++] = buf.buf;
-	args[i++] = NULL;
+	args[i] = NULL;
 
 	if (run_command(&rsync))
 		return error("Could not push objects to %s",
@@ -334,7 +334,7 @@ static int rsync_transport_push(struct transport *transport,
 		args[i++] = "--ignore-existing";
 	args[i++] = temp_dir.buf;
 	args[i++] = rsync_url(transport->url);
-	args[i++] = NULL;
+	args[i] = NULL;
 	if (run_command(&rsync))
 		result = error("Could not push to %s",
 				rsync_url(transport->url));
diff --git a/upload-pack.c b/upload-pack.c
index 38ddac2..fb3436c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -241,7 +241,7 @@ static void create_pack_file(void)
 		argv[arg++] = "--delta-base-offset";
 	if (use_include_tag)
 		argv[arg++] = "--include-tag";
-	argv[arg++] = NULL;
+	argv[arg] = NULL;
 
 	memset(&pack_objects, 0, sizeof(pack_objects));
 	pack_objects.in = shallow_nr ? rev_list.out : -1;
-- 
1.6.3.3
