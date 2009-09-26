From: Giuseppe Scrivano <gscrivano@gnu.org>
Subject: Re: [PATCH] Remove various dead assignments and dead increments found  by the clang static analyzer
Date: Sat, 26 Sep 2009 21:15:58 +0200
Message-ID: <87ske9cya9.fsf@master.homenet>
References: <87ab0hepcn.fsf@master.homenet>
	<alpine.DEB.1.00.0909261756510.4985@pacific.mpi-cbg.de>
	<871vltefdj.fsf@master.homenet>
	<fabb9a1e0909261134qd90dba1n9637fe4adc253fc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 26 21:16:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mrckh-0002Nx-Op
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 21:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbZIZTQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 15:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbZIZTQE
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 15:16:04 -0400
Received: from joe.mail.tiscali.it ([213.205.33.54]:49614 "EHLO
	joe.mail.tiscali.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbZIZTQC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 15:16:02 -0400
Received: from master.homenet (84.223.203.227) by joe.mail.tiscali.it (8.0.022)
        id 49EC55CD047B438F; Sat, 26 Sep 2009 21:16:05 +0200
Received: from gscrivano by master.homenet with local (Exim 4.69)
	(envelope-from <gscrivano@gnu.org>)
	id 1MrckQ-0005Wy-Un; Sat, 26 Sep 2009 21:15:58 +0200
In-Reply-To: <fabb9a1e0909261134qd90dba1n9637fe4adc253fc1@mail.gmail.com>
	(Sverre Rabbelier's message of "Sat, 26 Sep 2009 20:34:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129167>

Here is a cleaned patch.  I think these assignments can be removed
without any problem.

Cheers,
Giuseppe



>From 7501d82998132b15ad5cda78c0650f4f4a0b0e93 Mon Sep 17 00:00:00 2001
From: Giuseppe Scrivano <gscrivano@gnu.org>
Date: Sat, 26 Sep 2009 21:11:21 +0200
Subject: [PATCH] Remove various dead assignments and dead increments found by the clang static analyzer

---
 builtin-commit.c       |    2 +-
 builtin-fetch--tool.c  |    2 +-
 builtin-fetch-pack.c   |    2 +-
 builtin-grep.c         |    2 --
 builtin-pack-objects.c |    2 +-
 builtin-receive-pack.c |    8 ++++----
 builtin-send-pack.c    |    2 +-
 builtin-show-branch.c  |    4 ++--
 color.c                |    2 +-
 compat/mkstemps.c      |    2 +-
 connect.c              |    1 -
 diff.c                 |    2 +-
 http-fetch.c           |    3 +--
 transport.c            |    4 ++--
 upload-pack.c          |    2 +-
 15 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 200ffda..331d2a0 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1035,7 +1035,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			parents = reduce_heads(parents);
 	} else {
 		reflog_msg = "commit";
-		pptr = &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
+		commit_list_insert(lookup_commit(head_sha1), pptr);
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
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index b771fe9..82d1564 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -368,7 +368,7 @@ static char update_post_hook[] = "hooks/post-update";
 static void run_update_post_hook(struct command *cmd)
 {
 	struct command *cmd_p;
-	int argc, status;
+	int argc;
 	const char **argv;
 
 	for (argc = 0, cmd_p = cmd; cmd_p; cmd_p = cmd_p->next) {
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
