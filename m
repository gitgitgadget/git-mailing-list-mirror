From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v0 3/3] Build in git-rebase.sh
Date: Thu, 21 May 2009 19:47:09 +1000
Message-ID: <1242899229-27603-3-git-send-email-pclouds@gmail.com>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com>
 <1242899229-27603-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 11:48:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M74t0-0007Sp-0u
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 11:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696AbZEUJr4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 05:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752748AbZEUJr4
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 05:47:56 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:41883 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983AbZEUJru (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 05:47:50 -0400
Received: by rv-out-0506.google.com with SMTP id f9so325308rvb.1
        for <git@vger.kernel.org>; Thu, 21 May 2009 02:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=sJRk62BMXt+vUS2OGXNSUHknoCwwiVKZpAOiEJyl3i4=;
        b=hmZUG1GLHpFyZ2hm5nb0F9AGenpymlX0txNUK4BMlRbEqeVq+38O3YS79XXVpwe3Wk
         q4LseqOXRB8xlqnGO2t9bbI3QMvtdskAPHtA0kJc9LMdkgY98kJLtB0n6bT/0WgIBYrU
         rdgD4GM/XXHbFLZJ2XLhJLpGGpCg0icfyygmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=nL23HJTwgB1bb2kp4cuSaXIDC9Eh/Yc+y9OdCG59wOMCVTY1+Ke9dXcnCWdXV9ORU/
         57lYMe88kc7nJBVwfI6+FnLOscD7E2iU2HVd7wuUSbboVgw9At9n3Vk5SbG37oOCrMgJ
         vU/8d4nHn7VFBcsxT4ezR76uG2b8yhji1GhH8=
Received: by 10.140.134.15 with SMTP id h15mr1028105rvd.156.1242899272344;
        Thu, 21 May 2009 02:47:52 -0700 (PDT)
Received: from dektop ([121.91.24.237])
        by mx.google.com with ESMTPS id g31sm6096199rvb.53.2009.05.21.02.47.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 May 2009 02:47:50 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu, 21 May 2009 19:47:36 +1000
X-Mailer: git-send-email test
In-Reply-To: <1242899229-27603-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119668>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Regression: "-M" is gone. Don't really want to mess up struct option f=
or "-M"

 Makefile                       |    2 +-
 builtin-rebase.c               |  992 ++++++++++++++++++++++++++++++++=
++++++++
 builtin.h                      |    1 +
 contrib/examples/git-rebase.sh |  530 +++++++++++++++++++++
 git-rebase.sh                  |  530 ---------------------
 git.c                          |    1 +
 6 files changed, 1525 insertions(+), 531 deletions(-)
 create mode 100644 builtin-rebase.c
 create mode 100755 contrib/examples/git-rebase.sh
 delete mode 100755 git-rebase.sh

diff --git a/Makefile b/Makefile
index fdb39fa..fec6c40 100644
--- a/Makefile
+++ b/Makefile
@@ -302,7 +302,6 @@ SCRIPT_SH +=3D git-parse-remote.sh
 SCRIPT_SH +=3D git-pull.sh
 SCRIPT_SH +=3D git-quiltimport.sh
 SCRIPT_SH +=3D git-rebase--interactive.sh
-SCRIPT_SH +=3D git-rebase.sh
 SCRIPT_SH +=3D git-repack.sh
 SCRIPT_SH +=3D git-request-pull.sh
 SCRIPT_SH +=3D git-sh-setup.sh
@@ -597,6 +596,7 @@ BUILTIN_OBJS +=3D builtin-prune-packed.o
 BUILTIN_OBJS +=3D builtin-prune.o
 BUILTIN_OBJS +=3D builtin-push.o
 BUILTIN_OBJS +=3D builtin-read-tree.o
+BUILTIN_OBJS +=3D builtin-rebase.o
 BUILTIN_OBJS +=3D builtin-receive-pack.o
 BUILTIN_OBJS +=3D builtin-reflog.o
 BUILTIN_OBJS +=3D builtin-remote.o
diff --git a/builtin-rebase.c b/builtin-rebase.c
new file mode 100644
index 0000000..51c3121
--- /dev/null
+++ b/builtin-rebase.c
@@ -0,0 +1,992 @@
+#include "builtin.h"
+#include "cache.h"
+#include "parse-options.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "revision.h"
+#include "commit.h"
+#include "run-command.h"
+#include "dir.h"
+#include "refs.h"
+#include "quote.h"
+#include "log-tree.h"
+
+static char const * const rebase_usage[] =3D {
+	"git rebase [-i | --interactive] [options] [--onto <newbase>]\n"
+	"	<upstream> [<branch>]",
+	"git rebase [-i | --interactive] [options] --onto <newbase>\n"
+	"	--root [<branch>]",
+	"git rebase --continue | --skip | --abort",
+	NULL
+};
+
+static const char *resolve_msg =3D
+	"When you have resolved this problem, run \"git rebase --continue\".\=
n"
+	"If you would prefer to skip this patch, instead run \"git rebase --s=
kip\".\n"
+	"To restore the original branch and stop rebasing run \"git rebase --=
abort\".\n";
+
+#define REBASE_ABORT		0x0001
+#define REBASE_CONTINUE		0x0002
+#define REBASE_FORCE		0x0004
+#define REBASE_IGNORE_DATE	0x0008
+#define REBASE_INTERACTIVE	0x0010
+#define REBASE_MERGE		0x0020
+#define REBASE_STAT		0x0040
+#define REBASE_NO_VERIFY	0x0080
+#define REBASE_PRESERVE_MERGES	0x0100
+#define REBASE_ROOT		0x0200
+#define REBASE_SKIP		0x0400
+#define REBASE_VERBOSE		0x0800
+
+struct rebase_opt {
+	int flags;
+	int context;
+	const char *onto;
+	const char *upstream;
+	const char *branch;
+	const char *strategy;
+	const char *whitespace;
+};
+
+static int rebase_config(const char *var, const char *value, void *dat=
a)
+{
+	if (!strcmp(var, "rebase.stat")) {
+		if (git_config_bool(var, value))
+			((struct rebase_opt*)data)->flags |=3D REBASE_STAT;
+		return 0;
+	}
+	return 0;
+}
+
+/* utility functions */
+
+static char *load_string(char *git_pathname)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *path =3D git_path(git_pathname);
+
+	if (strbuf_read_file(&sb, path,  41) =3D=3D -1)
+		die("Could not read %s", path);
+
+	while (sb.len && sb.buf[sb.len-1] =3D=3D '\n') {
+		sb.len--;
+		sb.buf[sb.len] =3D '\0';
+	}
+
+	return sb.buf;
+}
+
+static void save_string(char *git_pathname, const char *str)
+{
+	const char *path =3D git_path(git_pathname);
+	int fd =3D open(path, O_CREAT | O_WRONLY, 0600);
+	if (fd < 0)
+		die("Could not open %s for writing", path);
+	write_in_full(fd, str, strlen(str));
+	write_in_full(fd, "\n", 1);
+	close(fd);
+}
+
+static void load_sha1(char *git_pathname, unsigned char *sha1)
+{
+	char *buf =3D load_string(git_pathname);
+	if (get_sha1_hex(buf, sha1) =3D=3D -1)
+		die("Invalid SHA-1 in %s", git_path(git_pathname));
+	free(buf);
+}
+
+static void save_sha1(char *git_pathname, const unsigned char *sha1)
+{
+	save_string(git_pathname, sha1_to_hex(sha1));
+}
+
+static int load_int(char *git_pathname)
+{
+	char *buf =3D load_string(git_pathname);
+	int ret;
+
+	if (sscanf(buf, "%d", &ret) !=3D 1)
+		die("Failed to read number from %s", git_path(git_pathname));
+	free(buf);
+	return ret;
+}
+
+static void save_int(char *git_pathname, int number)
+{
+	const char *path =3D git_path(git_pathname);
+	FILE *fp =3D fopen(path, "w");
+	if (!fp)
+		die("Could not open %s for writing", path);
+	fprintf(fp, "%d\n", number);
+	fclose(fp);
+}
+
+static void get_commit(const char *name, unsigned char *sha1, struct c=
ommit **cmt)
+{
+	if (get_sha1(name, sha1))
+		die("Failed to resolve SHA-1 from %s", name);
+	*cmt =3D lookup_commit(sha1);
+	if (!*cmt)
+		die("%s is not a commitish", name);
+}
+
+static int continue_merge(int msgnum, unsigned char *prev_head)
+{
+	const char *argv_diff[] =3D { "--quiet", "--ignore-submodules", "HEAD=
", "--", NULL };
+	struct strbuf result_line =3D STRBUF_INIT;
+	unsigned char cmt[20];
+	struct rev_info rev;
+	struct stat st;
+	int i, result;
+
+	if (stat(git_path("rebase-merge"), &st) || !S_ISDIR(st.st_mode))
+		die("%s directory does not exist", git_path("rebase-merge"));
+
+	/* git-am or git-merge-* may have been run, can no longer trust the o=
ld cache */
+	discard_cache();
+	if (read_cache() < 0)
+		die("Could not read the index");
+
+	for (i =3D 0;i < active_nr;i++)
+		if (ce_stage(active_cache[i]))
+			die("You still have unmerged paths in your index\n"
+			    "did you forget to use git add?\n"
+			    "%s",
+			    resolve_msg);
+
+	init_revisions(&rev, NULL);
+	rev.abbrev =3D 0;
+	setup_revisions(4, argv_diff, &rev, NULL);
+	result =3D run_diff_index(&rev, 0);
+	load_sha1("rebase-merge/current", cmt);
+
+	if (DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES)) {
+		struct child_process cp;
+		const char *argv[5] =3D {"commit", "--no-verify", "-C", sha1_to_hex(=
cmt), NULL };
+
+		memset(&cp, 0, sizeof(cp));
+		cp.git_cmd =3D 1;
+		cp.argv =3D argv;
+		if (run_command(&cp))
+			die("Commit failed, please do not call \"git commit\"\n"
+			    "directly, but instead do one of the following:\n"
+			    "%s", resolve_msg);
+		strbuf_addf(&result_line, "Committed: %04d ", msgnum);
+	}
+	else
+		strbuf_addf(&result_line, "Already applied: %04d ", msgnum);
+
+	parse_commit(lookup_commit(cmt));
+	format_commit_message(lookup_commit(cmt), "%f", &result_line, 0);
+	puts(result_line.buf);
+	strbuf_release(&result_line);
+
+	if (get_sha1("HEAD^0", prev_head))
+		die("Could not resolve HEAD commit");
+	save_sha1("rebase-merge/prev_head", prev_head);
+	msgnum++;
+	save_int("rebase-merge/msgnum", msgnum);
+	return msgnum;
+}
+
+static void call_merge(const char *strategy, int msgnum)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	struct strbuf sb2 =3D STRBUF_INIT;
+	struct strbuf sb_env1 =3D STRBUF_INIT;
+	struct strbuf sb_env2 =3D STRBUF_INIT;
+	unsigned char cmt[20];
+	unsigned char head[20];
+	struct child_process cp;
+	const char *full_ref;
+	int end, result, type;
+	const char *argv[5];
+	char *onto_name, *head_hex, *cmt_hex;
+
+	strbuf_addf(&sb, "rebase-merge/cmt.%d", msgnum);
+	load_sha1(sb.buf, cmt);
+	save_sha1("rebase-merge/current", cmt);
+
+	full_ref =3D resolve_ref("HEAD", head, 1, &type);
+	if (!lookup_commit(head))
+		die("HEAD does not point to a commit");
+	msgnum =3D load_int("rebase-merge/msgnum");
+	end =3D load_int("rebase-merge/end");
+
+	strbuf_setlen(&sb, 0);
+	strbuf_addf(&sb, "%s~%d",
+		    !strncmp(full_ref, "refs/heads/", 11) ? full_ref + 11 : full_ref=
,
+		    end - msgnum);
+	strbuf_addf(&sb_env1, "GITHEAD_%s", sha1_to_hex(cmt));
+	setenv(sb_env1.buf, sb.buf, 1);
+
+	onto_name =3D load_string("rebase-merge/onto_name");
+	strbuf_setlen(&sb, 0);
+	strbuf_addf(&sb_env2, "GITHEAD_%s", sha1_to_hex(head));
+	setenv(sb_env2.buf, onto_name, 1);
+	free(onto_name);
+
+	strbuf_setlen(&sb, 0);
+	strbuf_addf(&sb, "merge-%s", strategy);
+	strbuf_addf(&sb2, "%s^", sha1_to_hex(cmt));
+	head_hex =3D xstrdup(sha1_to_hex(head));
+	cmt_hex =3D xstrdup(sha1_to_hex(cmt));
+	argv[0] =3D sb.buf;
+	argv[1] =3D sb2.buf;
+	argv[2] =3D "--";
+	argv[3] =3D head_hex;
+	argv[4] =3D cmt_hex;
+	argv[5] =3D NULL;
+	memset(&cp, 0, sizeof(cp));
+	cp.git_cmd =3D 1;
+	cp.argv =3D argv;
+	result =3D run_command(&cp);
+	free(head_hex);
+	free(cmt_hex);
+	strbuf_release(&sb);
+	strbuf_release(&sb2);
+	switch (result) {
+	case 0:
+		unsetenv(sb_env1.buf);
+		strbuf_release(&sb_env1);
+		unsetenv(sb_env2.buf);
+		strbuf_release(&sb_env2);
+		break;
+	case -1:
+		argv[0] =3D "rerere";
+		argv[1] =3D NULL;
+		run_command(&cp);
+		die(resolve_msg);
+
+	case -2:
+		fprintf(stderr, "Strategy: %d %s failed, try another", result, strat=
egy);
+		die(resolve_msg);
+
+	default:
+		cmt_hex =3D xstrdup(sha1_to_hex(cmt));
+		die("Unknown exit code (%d) from command: git-merge-%s %s^ -- HEAD %=
s",
+		    result, strategy, cmt_hex, cmt_hex);
+	}
+}
+
+static void move_to_original_branch(const unsigned char *onto,
+				    const unsigned char *orig_head,
+				    const char *head_name)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	unsigned char head[20];
+
+	if (strncmp(head_name, "refs/", 5))
+		return;
+
+	strbuf_addf(&sb, "rebase finished: %s onto %s", head_name, sha1_to_he=
x(onto));
+	if (get_sha1("HEAD", head))
+		die("Could not resolve HEAD");
+	update_ref(sb.buf, head_name, head, orig_head, 0, DIE_ON_ERR);
+	create_symref("HEAD", head_name, NULL);
+	strbuf_release(&sb);
+}
+
+static int finish_rebase_merge(const unsigned char *onto,
+			       const unsigned char *orig_head,
+			       const char *head_name)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	move_to_original_branch(onto, orig_head, head_name);
+	strbuf_addstr(&sb, git_path("rebase-merge"));
+	remove_dir_recursively(&sb, 0);
+	strbuf_release(&sb);
+	puts("All done.");
+	return 0;
+}
+
+static void check_rebase_in_progress()
+{
+	struct stat st;
+	if ((!stat(git_path("rebase-merge"), &st) && S_ISDIR(st.st_mode)) ||
+	    (!stat(git_path("rebase-apply"), &st) && S_ISDIR(st.st_mode)))
+		return;
+	die("No rebase in progress?");
+}
+
+static int cmd_continue(const struct rebase_opt *opt)
+{
+	struct stat st;
+	struct rev_info rev;
+	struct child_process cp;
+	const char *argv_am[] =3D { "am", "--resolved", "--3way", "--resolvem=
sg", resolve_msg, NULL };
+	char *head_name;
+	unsigned char onto[20], orig_head[20];
+	int ret;
+
+	check_rebase_in_progress();
+
+	if (read_cache() < 0)
+		die("Could not read the index");
+
+	init_revisions(&rev, NULL);
+	rev.abbrev =3D 0;
+	DIFF_OPT_SET(&rev.diffopt, QUIET);
+	DIFF_OPT_SET(&rev.diffopt, IGNORE_SUBMODULES);
+	run_diff_files(&rev, DIFF_SILENT_ON_REMOVED);
+	if (DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES)) {
+		printf("You must edit all merge conflicts and then\n"
+		       "mark them as resolved using git add\n");
+		return 1;
+	}
+
+	if (!stat(git_path("rebase-merge"), &st) && S_ISDIR(st.st_mode)) {
+		unsigned char prev_head[20], onto[20], orig_head[20];
+		char *head_name;
+		int msgnum, end;
+
+		load_sha1("rebase-merge/prev_head", prev_head);
+		load_sha1("rebase-merge/onto", onto);
+		end =3D load_int("rebase-merge/end");
+		msgnum =3D load_int("rebase-merge/msgnum");
+
+		msgnum =3D continue_merge(msgnum, prev_head);
+		while (msgnum <=3D end) {
+			call_merge(opt->strategy, msgnum);
+			msgnum =3D continue_merge(msgnum, prev_head);
+		}
+
+		load_sha1("rebase-merge/orig-head", orig_head);
+		head_name =3D load_string("rebase-merge/head-name");
+
+		ret =3D finish_rebase_merge(onto, orig_head, head_name);
+		free(head_name);
+		return ret;
+	}
+
+	head_name =3D load_string("rebase-apply/head-name");
+	load_sha1("rebase-apply/onto", onto);
+	load_sha1("rebase-apply/orig-head", orig_head);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.git_cmd =3D 1;
+	cp.argv =3D argv_am;
+	ret =3D run_command(&cp);
+	if (IS_RUN_COMMAND_ERR(ret))
+		die("Could not run git am");
+	if (!ret)
+		move_to_original_branch(onto, orig_head, head_name);
+	free(head_name);
+	return ret < 0 ? -ret : 0;
+}
+
+static int cmd_abort()
+{
+	const char *argv_rerere[] =3D { "rerere", "clear", NULL };
+	const char *argv_reset[] =3D { "reset", "--hard", NULL /* placeholder=
 */, NULL };
+	struct child_process cp;
+	struct stat st;
+	unsigned char onto[20], orig_head[20];
+	char *head_name;
+	struct strbuf sb =3D STRBUF_INIT;
+
+	check_rebase_in_progress();
+	memset(&cp, 0, sizeof(cp));
+	cp.git_cmd =3D 1;
+	cp.argv =3D argv_rerere;
+	run_command(&cp);
+
+	if (!stat(git_path("rebase-merge"), &st) && S_ISDIR(st.st_mode)) {
+		strbuf_addstr(&sb, git_path("rebase-merge"));
+		head_name =3D load_string("rebase-merge/head-name");
+		load_sha1("rebase-merge/onto", onto);
+		load_sha1("rebase-merge/orig-head", orig_head);
+		move_to_original_branch(onto, orig_head, head_name);
+	}
+	else {
+		strbuf_addstr(&sb, git_path("rebase-apply"));
+		head_name =3D load_string("rebase-apply/head-name");
+		load_sha1("rebase-apply/onto", onto);
+		load_sha1("rebase-apply/orig-head", orig_head);
+		move_to_original_branch(onto, orig_head, head_name);
+	}
+	free(head_name);
+
+	cp.argv =3D argv_reset;
+	argv_reset[2] =3D sha1_to_hex(orig_head);
+	if (run_command(&cp))
+		die("Failed running git reset");
+	remove_dir_recursively(&sb, 0);
+	strbuf_release(&sb);
+	return 0;
+}
+
+static int cmd_skip(const struct rebase_opt *opt)
+{
+	const char *argv_reset[] =3D { "reset", "--hard", "HEAD", NULL };
+	const char *argv_am[] =3D { "am", "-3", "--skip", "--resolvemsg", res=
olve_msg, NULL };
+	struct child_process cp;
+	char *head_name;
+	unsigned char orig_head[20], onto[20];
+	struct stat st;
+	int ret;
+
+	check_rebase_in_progress();
+	memset(&cp, 0, sizeof(cp));
+	cp.git_cmd =3D 1;
+	cp.argv =3D argv_reset;
+	ret =3D run_command(&cp);
+	if (IS_RUN_COMMAND_ERR(ret))
+		die("Failed to run git reset");
+	if (ret)
+		return -ret;
+	if (!stat(git_path("rebase-merge"), &st) && S_ISDIR(st.st_mode)) {
+		const char *argv_rerere[] =3D { "rerere", "clear", NULL };
+		unsigned char prev_head[20], onto[20], orig_head[20];
+		int msgnum, end;
+		char *head_name;
+
+		cp.argv =3D argv_rerere;
+		run_command(&cp);
+		load_sha1("rebase-merge/prev_head", prev_head);
+		end =3D load_int("rebase-merge/end");
+		msgnum =3D load_int("rebase-merge/msgnum") + 1;
+		load_sha1("rebase-merge/onto", onto);
+		while (msgnum <=3D end) {
+			call_merge(opt->strategy, msgnum);
+			msgnum =3D continue_merge(msgnum, prev_head);
+		}
+
+		load_sha1("rebase-merge/orig-head", orig_head);
+		head_name =3D load_string("rebase-merge/head-name");
+
+		ret =3D finish_rebase_merge(onto, orig_head, head_name);
+		free(head_name);
+		return ret;
+	}
+
+	head_name =3D load_string("rebase-apply/head-name");
+	load_sha1("rebase-apply/onto", onto);
+	load_sha1("rebase-apply/orig-head", orig_head);
+
+	cp.argv =3D argv_am;
+	ret =3D run_command(&cp);
+	if (IS_RUN_COMMAND_ERR(ret))
+		die("Failed to run git am");
+	if (ret)
+		return -ret;
+
+	move_to_original_branch(onto, orig_head, head_name);
+	free(head_name);
+	return ret < 0 ? -ret : 0;
+}
+
+static void run_interactive(int argc, const char **argv)
+{
+	int ret, i;
+	struct child_process cp;
+	for (i =3D 1;i < argc;i++) {
+		if (!strcmp(argv[i], "-i") || !strcmp(argv[i], "--interactive"))
+			break;
+		if (!strcmp(argv[i], "-p") || !strcmp(argv[i], "--preserve-merges"))=
 {
+			setenv("GIT_EDITOR", ":", 1);
+			break;
+		}
+	}
+
+	if (i =3D=3D argc) {
+		struct stat st;
+		if (stat(git_path("rebase-merge/interactive"), &st) ||
+		    !S_ISREG(st.st_mode))
+			return;
+	}
+
+	memset(&cp, 0, sizeof(cp));
+	cp.git_cmd =3D 1;
+	cp.argv =3D argv;
+	argv[0] =3D "rebase--interactive";
+	ret =3D run_command(&cp);
+	if (IS_RUN_COMMAND_ERR(ret))
+		die("Failed to run git rebase--interactive");
+	exit(ret);
+}
+
+/* from diff.c */
+static void strip_prefix(int prefix_length, const char **namep, const =
char **otherp)
+{
+	/* Strip the prefix but do not molest /dev/null and absolute paths */
+	if (*namep && **namep !=3D '/')
+		*namep +=3D prefix_length;
+	if (*otherp && **otherp !=3D '/')
+		*otherp +=3D prefix_length;
+}
+
+static void die_dirty_cache(struct diff_queue_struct *q,
+			    struct diff_options *opt,
+			    void *data)
+{
+	int i;
+
+	if (!q->nr)
+		return;
+
+	fprintf(stderr,"cannot rebase: your index contains uncommitted change=
s\n");
+
+	for (i =3D 0; i < q->nr; i++) {
+		struct diff_filepair *p =3D q->queue[i];
+
+		fprintf(stderr, "%c ",p->status);
+
+		if (p->status =3D=3D DIFF_STATUS_COPIED ||
+		    p->status =3D=3D DIFF_STATUS_RENAMED) {
+			const char *name_a, *name_b;
+			name_a =3D p->one->path;
+			name_b =3D p->two->path;
+			strip_prefix(opt->prefix_length, &name_a, &name_b);
+			write_name_quoted(name_a, stderr, '\t');
+			write_name_quoted(name_b, stderr, '\n');
+		} else {
+			const char *name_a, *name_b;
+			name_a =3D p->one->mode ? p->one->path : p->two->path;
+			name_b =3D NULL;
+			strip_prefix(opt->prefix_length, &name_a, &name_b);
+			write_name_quoted(name_a, stderr, '\n');
+		}
+	}
+	exit(1);
+}
+
+static void abort_continue_skip(const struct rebase_opt *opt)
+{
+	int count =3D 0;
+	if (opt->flags & REBASE_CONTINUE) count++;
+	if (opt->flags & REBASE_SKIP) count++;
+	if (opt->flags & REBASE_ABORT) count++;
+	if (count > 1)
+		die("--continue, --skip and --abort are mutually exclusive");
+	if (!count)
+		return;
+
+	/* REBASE_STAT may be set by git config */
+	if (opt->flags & ~(REBASE_CONTINUE | REBASE_SKIP | REBASE_ABORT | REB=
ASE_STAT))
+		die("--continue, --skip and --abort do not take any other argument")=
;
+
+	if (opt->flags & REBASE_CONTINUE) exit(cmd_continue(opt));
+	if (opt->flags & REBASE_ABORT) exit(cmd_abort());
+	if (opt->flags & REBASE_SKIP) exit(cmd_skip(opt));
+
+	die("Unexpected operation");
+}
+
+static int cmd_apply_rebase(const struct rebase_opt *opt,
+			    struct object *onto,
+			    struct object *upstream,
+			    struct object *orig_head,
+			    const char *onto_name,
+			    const char *head_name)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *argv_fp[] =3D { "format-patch", "-k", "--stdout", "--full=
-index",
+				  "--ignore-if-in-upstream", NULL /* placeholder */, NULL };
+	const char *argv_am[] =3D { "am", "--rebasing", "--resolvemsg", resol=
ve_msg,
+				  NULL, NULL, /* --whitespace */
+				  NULL,	      /* -Cn */
+				  NULL,	      /* --ignore-date */
+				  NULL };
+	const char **argp;
+	struct child_process cp_fp, cp_am;
+	int fd[2], ret;
+	char context_buf[10];
+
+	strbuf_addstr(&sb, sha1_to_hex(upstream->sha1));
+	strbuf_addstr(&sb, "..");
+	strbuf_addstr(&sb, sha1_to_hex(orig_head->sha1));
+
+	memset(&cp_fp, 0, sizeof(cp_fp));
+	memset(&cp_am, 0, sizeof(cp_am));
+
+	if (pipe(fd))
+		die("Failed to make pipe");
+
+	cp_fp.git_cmd =3D 1;
+	cp_fp.argv =3D argv_fp;
+	cp_fp.out =3D fd[1];
+	argv_fp[5] =3D sb.buf;
+
+	argp =3D argv_am+4;
+	if (opt->whitespace) {
+		*argp++ =3D "--whitespace";
+		*argp++ =3D opt->whitespace;
+	}
+	if (opt->flags & REBASE_IGNORE_DATE)
+		*argp++ =3D "--ignore-date";
+	if (opt->context >=3D 0) {
+		snprintf(context_buf, 10, "-C%d", opt->context);
+		*argp++ =3D context_buf;
+	}
+	cp_am.git_cmd =3D 1;
+	cp_am.argv =3D argv_am;
+	cp_am.in =3D fd[0];
+
+	if (start_command(&cp_fp))
+		die("Could not run git format-patch");
+	if (start_command(&cp_am))
+		die("Could not run git am");
+
+	ret =3D finish_command(&cp_am);
+	strbuf_release(&sb);
+	close(fd[0]);
+	close(fd[1]);
+
+	if (IS_RUN_COMMAND_ERR(ret))
+		die("Failed to run 'git format-patch|git am'");
+	if (!ret)
+		move_to_original_branch(onto->sha1, orig_head->sha1, head_name);
+	else {
+		struct stat st;
+
+		if (!stat(git_path("rebase-apply"), &st) && S_ISDIR(st.st_mode)) {
+			save_string("rebase-apply/head-name", head_name);
+			save_sha1("rebase-apply/onto", onto->sha1);
+			save_sha1("rebase-apply/orig-head", orig_head->sha1);
+		}
+	}
+	return ret;
+}
+
+static int cmd_merge_rebase(const struct rebase_opt *opt,
+			    struct object *onto,
+			    struct object *upstream,
+			    struct object *orig_head,
+			    const char *onto_name,
+			    const char *head_name)
+{
+	int msgnum, end =3D 0;
+	struct rev_info revs;
+	struct commit *cmt;
+	struct strbuf sb =3D STRBUF_INIT;
+	unsigned char prev_head[20];
+
+	/* git rev-list --reverse --no-merges $onto..$orig_head */
+	init_revisions(&revs, NULL);
+	revs.abbrev =3D 0;
+	revs.reverse =3D 1;
+	revs.no_merges =3D 1;
+	upstream->flags |=3D UNINTERESTING;
+	add_pending_object(&revs, upstream, NULL);
+	orig_head->flags &=3D ~UNINTERESTING;
+	add_pending_object(&revs, orig_head, NULL);
+
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+
+	memcpy(prev_head, orig_head->sha1, 20);
+
+	mkdir(git_path("rebase-merge"), 0700);
+	save_sha1  ("rebase-merge/onto",      onto->sha1);
+	save_string("rebase-merge/onto_name", onto_name);
+	save_sha1  ("rebase-merge/prev_head", prev_head);
+	save_sha1  ("rebase-merge/orig-head", orig_head->sha1);
+	save_string("rebase-merge/head-name", head_name);
+
+	strbuf_addstr(&sb, "rebase-merge/cmt.");
+	while ((cmt =3D get_revision(&revs)) !=3D NULL) {
+		end++;
+		strbuf_addf(&sb, "%d", end);
+		save_sha1(sb.buf, cmt->object.sha1);
+		strbuf_setlen(&sb, 17);
+	}
+	strbuf_release(&sb);
+
+	msgnum =3D 1;
+
+	save_int("rebase-merge/msgnum", msgnum);
+	save_int("rebase-merge/end", end);
+
+	while (msgnum <=3D end) {
+		call_merge(opt->strategy, msgnum);
+		msgnum =3D continue_merge(msgnum, prev_head);
+	}
+
+	return finish_rebase_merge(onto->sha1, orig_head->sha1, head_name);
+}
+
+int cmd_rebase(int argc, const char **argv, const char *prefix)
+{
+	struct rebase_opt opt;
+	struct option options[] =3D {
+		OPT_STRING(0,"onto",           &opt.onto, "newbase", "starting point=
 at which to create new commits"),
+		OPT_STRING('s',"strategy",     &opt.strategy, "strategy", "merge str=
ategy to be used"),
+		OPT_STRING(0,"whitespace",     &opt.whitespace, "action", "to be pas=
sed to \"git apply\""),
+		OPT_INTEGER('C', NULL,         &opt.context, "surrounding context li=
nes to be matched"),
+		OPT_BIT   ('i', "interactive", &opt.flags, "interactive mode", REBAS=
E_INTERACTIVE),
+		OPT_BIT   ('v', "verbose",     &opt.flags, "be verbose", REBASE_VERB=
OSE | REBASE_STAT),
+		OPT_BIT   ('f', "force-rebase",&opt.flags, "force rebase", REBASE_FO=
RCE),
+		OPT_BIT   ('p', "preserve-merges",&opt.flags, "preserve merges durin=
g rebase", REBASE_PRESERVE_MERGES),
+		OPT_BIT   ('m', "merge",       &opt.flags, "use merge strategies to =
rebase", REBASE_MERGE),
+		OPT_BIT   (0,   "no-verify",   &opt.flags, "bypass pre-rebase hook",=
 REBASE_NO_VERIFY),
+		OPT_NEGBIT('n', "no-stat",     &opt.flags, "do not show diffstat as =
part of rebase process", REBASE_STAT),
+		OPT_BIT   (0,   "committer-date-is-author-date", &opt.flags, "to be =
passed to \"git am\"", REBASE_IGNORE_DATE),
+		OPT_BIT   (0,   "ignore-date", &opt.flags, "to be passed to \"git am=
\"", REBASE_IGNORE_DATE),
+		OPT_BIT   (0,   "stat",        &opt.flags, "show diffstat as part of=
 rebase process", REBASE_STAT),
+		OPT_BIT   (0,   "root",        &opt.flags, "rebase all reachable com=
mits from <branch>", REBASE_ROOT),
+		OPT_BIT   (0,   "continue",    &opt.flags, "restart rebase after hav=
ing resolved a merge conflict", REBASE_CONTINUE),
+		OPT_BIT   (0,   "skip",        &opt.flags, "restart rebase by skippi=
ng the current patch", REBASE_SKIP),
+		OPT_BIT   (0,   "abort",       &opt.flags, "restore original branch =
and abort rebase", REBASE_ABORT),
+		OPT_END()
+	};
+
+	unsigned char upstream_sha1[20], branch_sha1[20], onto_sha1[20], head=
_sha1[20];
+	struct commit *upstream_cmt, *branch_cmt, *onto_cmt, *head_cmt;
+	const char *argv_checkout_onto[] =3D { "checkout", "-q", NULL /* plac=
eholder */, NULL };
+	int (*rebase_func)(const struct rebase_opt *, struct object *,
+			   struct object *, struct object *,
+			   const char *, const char *);
+	const char *switch_to =3D NULL;
+	struct commit_list *mb_cmts;
+	struct child_process cp;
+	struct rev_info revs;
+	struct stat st;
+	char *head_name;
+	char *buf;
+	int do_merge;
+
+	if (!stat(git_path("rebase-apply/applying"), &st) && S_ISREG(st.st_mo=
de))
+		die("It looks like git-am is in progress. Cannot rebase.");
+
+	setenv("GIT_REFLOG_ACTION", "rebase", 1);
+	memset(&opt, 0, sizeof(opt));
+	opt.context =3D -1;
+	git_config(rebase_config, &opt);
+
+	run_interactive(argc, argv);
+
+	if (argc =3D=3D 1) {
+		int rebase_merge_exists =3D !stat(git_path("rebase-merge"), &st) && =
S_ISDIR(st.st_mode);
+		int rebase_apply_exists =3D !stat(git_path("rebase-apply"), &st) && =
S_ISDIR(st.st_mode);
+		if (rebase_merge_exists || rebase_apply_exists) {
+			if (rebase_merge_exists ||
+			    (!stat(git_path("rebase-apply/rebasing"), &st) && S_ISREG(st.st=
_mode)))
+				die("A rebase is in progress, try --continue, --skip or --abort.")=
;
+			die("No arguments given and %s already exists.", git_path("rebase-a=
pply"));
+		}
+		else
+			usage_with_options(rebase_usage, options);
+	}
+
+	argc =3D parse_options(argc, argv, options, rebase_usage, 0);
+
+	do_merge =3D (opt.flags & REBASE_MERGE) || opt.strategy;
+	if (!opt.strategy)
+		opt.strategy =3D "recursive";
+
+	abort_continue_skip(&opt);
+
+	if (opt.whitespace &&
+	    (!strcmp(opt.whitespace, "fix") ||
+	     !strcmp(opt.whitespace, "strip")))
+		opt.flags |=3D REBASE_FORCE;
+
+	if (opt.flags & REBASE_ROOT) {
+		if (argc > 1)
+			die("Invalid argument");
+		if (argc)
+			opt.branch =3D *argv;
+		if (!opt.onto)
+			die("--root must be used with --onto");
+	}
+	else {
+		/* without --root only takes either 1 or 2 arguments */
+		if (argc =3D=3D 0 || argc > 2 ||
+		    (argc =3D=3D 2 && (opt.flags & REBASE_ROOT)))
+			die("Invalid argument");
+		if (argc) {
+			opt.upstream =3D *argv++;
+			if (argc)
+				opt.branch =3D *argv;
+		}
+	}
+
+	/* No rebase ongoing */
+	if (do_merge) {
+		if (!stat(git_path("rebase-merge"), &st) && S_ISREG(st.st_mode))
+			die("previous rebase directory rebase-merge still exists."
+			    "Try git rebase (--continue | --abort | --skip)");
+	}
+	else {
+		if (!mkdir(git_path("rebase-apply"), 0700))
+			rmdir(git_path("rebase-apply"));
+		else
+			die("It seems that I cannot create a rebase-apply directory, and\n"
+			    "I wonder if you are in the middle of the patch application or =
another\n"
+			    "rebase. If that is not the case, please\n"
+			    "\trm -fr \"%s\"/rebase_apply\n"
+			    "and run me again. I am stopping in case you still have somethi=
ng\n"
+			    "valuable there.",
+			    get_git_dir());
+	}
+
+	/* worktree clean */
+	if (read_cache() < 0)
+		die("Could not read the index");
+	if (refresh_cache(REFRESH_IGNORE_SUBMODULES))
+		die("cannot rebase: you have unstaged changes");
+
+	/* cache clean */
+	init_revisions(&revs, NULL);
+	revs.abbrev =3D 0;
+	revs.diffopt.output_format =3D DIFF_FORMAT_CALLBACK;
+	revs.diffopt.format_callback =3D die_dirty_cache;
+	DIFF_OPT_SET(&revs.diffopt, IGNORE_SUBMODULES);
+	DIFF_OPT_SET(&revs.diffopt, RECURSIVE);
+	if (get_sha1("HEAD", head_sha1))
+		die("Could not resolve HEAD");
+	head_cmt =3D lookup_commit(head_sha1);
+	add_pending_object(&revs, &head_cmt->object, NULL);
+	run_diff_index(&revs, 1);
+
+	if (!(opt.flags & REBASE_NO_VERIFY) &&
+	    run_hook(NULL, "pre-rebase", opt.flags & REBASE_ROOT ? "--root" :=
 opt.upstream, opt.branch, NULL)) {
+		die("The pre-rebase hook refused to rebase.");
+	}
+
+	/* commit validation */
+	if (!(opt.flags & REBASE_ROOT))
+		get_commit(opt.upstream, upstream_sha1, &upstream_cmt);
+	get_commit("HEAD", head_sha1, &head_cmt);
+	if (opt.onto)
+		get_commit(opt.onto, onto_sha1, &onto_cmt);
+	else {
+		opt.onto =3D opt.upstream;
+		memcpy(onto_sha1, upstream_sha1, 20);
+		onto_cmt =3D upstream_cmt;
+	}
+
+	if (opt.branch) {
+		struct strbuf sb =3D STRBUF_INIT;
+		const char *full_ref;
+		int type;
+
+		switch_to =3D opt.branch;
+		strbuf_addf(&sb, "refs/heads/%s", opt.branch);
+		full_ref =3D resolve_ref(sb.buf, branch_sha1, 1, &type);
+		if (full_ref)
+			head_name =3D xstrdup(full_ref);
+		else {
+			if (!get_sha1(opt.branch, branch_sha1))
+				head_name =3D xstrdup("detached HEAD");
+			else
+				die("Failed to parse %s", opt.branch);
+		}
+		strbuf_release(&sb);
+	}
+	else {
+		const char *full_ref;
+		int type;
+
+		opt.branch =3D "HEAD";
+		full_ref =3D resolve_ref(opt.branch, branch_sha1, 1, &type);
+		if (full_ref) {
+			head_name =3D xstrdup(full_ref);
+			if (!strncmp(full_ref, "refs/heads/", 11))
+				opt.branch =3D head_name+11;
+		}
+		else {
+			head_name =3D xstrdup("detached HEAD");
+			if (get_sha1(opt.branch, branch_sha1))
+				die("Could not resolve HEAD");
+		}
+	}
+
+	branch_cmt =3D lookup_commit(branch_sha1);
+	if (!branch_cmt)
+		die("Failed to lookup commit for %s", branch_sha1);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.git_cmd =3D 1;
+
+	/*
+	 * Now we are rebasing commits upstream_sha1..branch_sha1
+	 * (or with --root, everything leading up to branch_sha1)
+	 * on top of onto_sha1
+	 */
+
+	/*
+	 * Check if we are already based on onto_sha1 with linear history,
+	 * but this should be done only when upstream and onto are the same.
+	 */
+	if (!(opt.flags & REBASE_ROOT) && !memcmp(upstream_sha1, onto_sha1, 2=
0)) {
+		struct commit *cmt =3D branch_cmt;
+		while (1) {
+			if (parse_commit(cmt))
+				die("Could not parse commit");
+
+			if (!cmt->parents || cmt->parents->next)
+				break;
+
+			if (cmt->parents->item !=3D onto_cmt) {
+				cmt =3D cmt->parents->item;
+				continue;
+			}
+
+			if (opt.flags & REBASE_FORCE) {
+				printf("Current branch %s is up to date, rebase forced.\n", opt.br=
anch);
+				break;
+			}
+			if (switch_to) {
+				const char *argv_checkout[] =3D { "checkout", switch_to, NULL };
+				cp.argv =3D argv_checkout;
+				if (run_command(&cp))
+					die("Failed to switch to branch %s", switch_to);
+			}
+			fprintf(stderr, "Current branch %s is up to date.\n", opt.branch);
+			return 0;
+		}
+	}
+
+	/* Detach HEAD and reset the tree */
+	printf("First, rewinding head to replay your work on top of it...\n")=
;
+	buf =3D xmalloc(43);
+	memcpy(buf, sha1_to_hex(onto_sha1), 40);
+	buf[40] =3D '^';
+	buf[41] =3D '0';
+	buf[42] =3D '\0';
+	argv_checkout_onto[2] =3D buf;
+	cp.argv =3D argv_checkout_onto;
+	if (run_command(&cp))
+		die("could not detach HEAD");
+	update_ref(NULL, "ORIG_HEAD", branch_sha1, NULL, REF_NODEREF, DIE_ON_=
ERR);
+
+	/* diffstat */
+	mb_cmts =3D get_merge_bases(onto_cmt, branch_cmt, 0);
+	if (mb_cmts && (opt.flags & REBASE_STAT)) {
+		struct rev_info diffrev;
+		struct commit *mb_cmt =3D mb_cmts->item;
+
+		if (opt.flags & REBASE_VERBOSE)
+			printf("Changes from %s to %s:\n", sha1_to_hex(mb_cmt->object.sha1)=
, opt.onto);
+		init_revisions(&diffrev, NULL);
+		diffrev.abbrev =3D 0;
+		DIFF_OPT_SET(&diffrev.diffopt, RECURSIVE);
+		diffrev.diffopt.output_format =3D DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT=
_SUMMARY;
+		if (parse_commit(mb_cmt) || parse_commit(onto_cmt))
+			die("Could not parse commits");
+		diff_tree_sha1(mb_cmt->tree->object.sha1, onto_cmt->tree->object.sha=
1, "", &diffrev.diffopt);
+		log_tree_diff_flush(&diffrev);
+	}
+
+	/*
+	 * If the opt.onto is a proper descendant of the tip of the branch,
+	 * then we just fast forward it.
+	 */
+	if (mb_cmts && mb_cmts->item =3D=3D branch_cmt) {
+		fprintf(stderr, "Fast-forwarded %s to %s", opt.branch, opt.onto);
+		move_to_original_branch(onto_sha1, branch_sha1, head_name);
+		return 0;
+	}
+
+	/*
+	 * if --root, revision range will be onto..orig_head
+	 * otherwise upstream..orig_head
+	 */
+
+	rebase_func =3D do_merge ? cmd_merge_rebase : cmd_apply_rebase;
+	return rebase_func(&opt, &onto_cmt->object,
+			   opt.flags & REBASE_ROOT ? &onto_cmt->object : &upstream_cmt->obj=
ect,
+			   &branch_cmt->object, opt.onto, head_name);
+}
diff --git a/builtin.h b/builtin.h
index 425ff8e..53bf2b0 100644
--- a/builtin.h
+++ b/builtin.h
@@ -80,6 +80,7 @@ extern int cmd_prune(int argc, const char **argv, con=
st char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *p=
refix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *pref=
ix);
+extern int cmd_rebase(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_receive_pack(int argc, const char **argv, const char *p=
refix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_remote(int argc, const char **argv, const char *prefix)=
;
diff --git a/contrib/examples/git-rebase.sh b/contrib/examples/git-reba=
se.sh
new file mode 100755
index 0000000..b83fd3f
--- /dev/null
+++ b/contrib/examples/git-rebase.sh
@@ -0,0 +1,530 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano.
+#
+
+USAGE=3D'[--interactive | -i] [-v] [--force-rebase | -f] [--onto <newb=
ase>] [<upstream>|--root] [<branch>]'
+LONG_USAGE=3D'git-rebase replaces <branch> with a new branch of the
+same name.  When the --onto option is provided the new branch starts
+out with a HEAD equal to <newbase>, otherwise it is equal to <upstream=
>
+It then attempts to create a new commit for each commit from the origi=
nal
+<branch> that does not exist in the <upstream> branch.
+
+It is possible that a merge failure will prevent this process from bei=
ng
+completely automatic.  You will have to resolve any such merge failure
+and run git rebase --continue.  Another option is to bypass the commit
+that caused the merge failure with git rebase --skip.  To restore the
+original <branch> and remove the .git/rebase-apply working files, use =
the
+command git rebase --abort instead.
+
+Note that if <branch> is not specified on the command line, the
+currently checked out branch is used.
+
+Example:       git-rebase master~1 topic
+
+        A---B---C topic                   A'\''--B'\''--C'\'' topic
+       /                   -->           /
+  D---E---F---G master          D---E---F---G master
+'
+
+SUBDIRECTORY_OK=3DYes
+OPTIONS_SPEC=3D
+. git-sh-setup
+set_reflog_action rebase
+require_work_tree
+cd_to_toplevel
+
+OK_TO_SKIP_PRE_REBASE=3D
+RESOLVEMSG=3D"
+When you have resolved this problem run \"git rebase --continue\".
+If you would prefer to skip this patch, instead run \"git rebase --ski=
p\".
+To restore the original branch and stop rebasing run \"git rebase --ab=
ort\".
+"
+unset newbase
+strategy=3Drecursive
+do_merge=3D
+dotest=3D"$GIT_DIR"/rebase-merge
+prec=3D4
+verbose=3D
+diffstat=3D$(git config --bool rebase.stat)
+git_am_opt=3D
+rebase_root=3D
+force_rebase=3D
+
+continue_merge () {
+	test -n "$prev_head" || die "prev_head must be defined"
+	test -d "$dotest" || die "$dotest directory does not exist"
+
+	unmerged=3D$(git ls-files -u)
+	if test -n "$unmerged"
+	then
+		echo "You still have unmerged paths in your index"
+		echo "did you forget to use git add?"
+		die "$RESOLVEMSG"
+	fi
+
+	cmt=3D`cat "$dotest/current"`
+	if ! git diff-index --quiet --ignore-submodules HEAD --
+	then
+		if ! git commit --no-verify -C "$cmt"
+		then
+			echo "Commit failed, please do not call \"git commit\""
+			echo "directly, but instead do one of the following: "
+			die "$RESOLVEMSG"
+		fi
+		printf "Committed: %0${prec}d " $msgnum
+	else
+		printf "Already applied: %0${prec}d " $msgnum
+	fi
+	git rev-list --pretty=3Doneline -1 "$cmt" | sed -e 's/^[^ ]* //'
+
+	prev_head=3D`git rev-parse HEAD^0`
+	# save the resulting commit so we can read-tree on it later
+	echo "$prev_head" > "$dotest/prev_head"
+
+	# onto the next patch:
+	msgnum=3D$(($msgnum + 1))
+	echo "$msgnum" >"$dotest/msgnum"
+}
+
+call_merge () {
+	cmt=3D"$(cat "$dotest/cmt.$1")"
+	echo "$cmt" > "$dotest/current"
+	hd=3D$(git rev-parse --verify HEAD)
+	cmt_name=3D$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
+	msgnum=3D$(cat "$dotest/msgnum")
+	end=3D$(cat "$dotest/end")
+	eval GITHEAD_$cmt=3D'"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
+	eval GITHEAD_$hd=3D'$(cat "$dotest/onto_name")'
+	export GITHEAD_$cmt GITHEAD_$hd
+	git-merge-$strategy "$cmt^" -- "$hd" "$cmt"
+	rv=3D$?
+	case "$rv" in
+	0)
+		unset GITHEAD_$cmt GITHEAD_$hd
+		return
+		;;
+	1)
+		git rerere
+		die "$RESOLVEMSG"
+		;;
+	2)
+		echo "Strategy: $rv $strategy failed, try another" 1>&2
+		die "$RESOLVEMSG"
+		;;
+	*)
+		die "Unknown exit code ($rv) from command:" \
+			"git-merge-$strategy $cmt^ -- HEAD $cmt"
+		;;
+	esac
+}
+
+move_to_original_branch () {
+	test -z "$head_name" &&
+		head_name=3D"$(cat "$dotest"/head-name)" &&
+		onto=3D"$(cat "$dotest"/onto)" &&
+		orig_head=3D"$(cat "$dotest"/orig-head)"
+	case "$head_name" in
+	refs/*)
+		message=3D"rebase finished: $head_name onto $onto"
+		git update-ref -m "$message" \
+			$head_name $(git rev-parse HEAD) $orig_head &&
+		git symbolic-ref HEAD $head_name ||
+		die "Could not move back to $head_name"
+		;;
+	esac
+}
+
+finish_rb_merge () {
+	move_to_original_branch
+	rm -r "$dotest"
+	echo "All done."
+}
+
+is_interactive () {
+	while test $# !=3D 0
+	do
+		case "$1" in
+			-i|--interactive)
+				interactive_rebase=3Dexplicit
+				break
+			;;
+			-p|--preserve-merges)
+				interactive_rebase=3Dimplied
+			;;
+		esac
+		shift
+	done
+
+	if [ "$interactive_rebase" =3D implied ]; then
+		GIT_EDITOR=3D:
+		export GIT_EDITOR
+	fi
+
+	test -n "$interactive_rebase" || test -f "$dotest"/interactive
+}
+
+run_pre_rebase_hook () {
+	if test -z "$OK_TO_SKIP_PRE_REBASE" &&
+	   test -x "$GIT_DIR/hooks/pre-rebase"
+	then
+		"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} || {
+			echo >&2 "The pre-rebase hook refused to rebase."
+			exit 1
+		}
+	fi
+}
+
+test -f "$GIT_DIR"/rebase-apply/applying &&
+	die 'It looks like git-am is in progress. Cannot rebase.'
+
+is_interactive "$@" && exec git-rebase--interactive "$@"
+
+if test $# -eq 0
+then
+	test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply || usage
+	test -d "$dotest" -o -f "$GIT_DIR"/rebase-apply/rebasing &&
+		die 'A rebase is in progress, try --continue, --skip or --abort.'
+	die "No arguments given and $GIT_DIR/rebase-apply already exists."
+fi
+
+while test $# !=3D 0
+do
+	case "$1" in
+	--no-verify)
+		OK_TO_SKIP_PRE_REBASE=3Dyes
+		;;
+	--continue)
+		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
+			die "No rebase in progress?"
+
+		git diff-files --quiet --ignore-submodules || {
+			echo "You must edit all merge conflicts and then"
+			echo "mark them as resolved using git add"
+			exit 1
+		}
+		if test -d "$dotest"
+		then
+			prev_head=3D$(cat "$dotest/prev_head")
+			end=3D$(cat "$dotest/end")
+			msgnum=3D$(cat "$dotest/msgnum")
+			onto=3D$(cat "$dotest/onto")
+			continue_merge
+			while test "$msgnum" -le "$end"
+			do
+				call_merge "$msgnum"
+				continue_merge
+			done
+			finish_rb_merge
+			exit
+		fi
+		head_name=3D$(cat "$GIT_DIR"/rebase-apply/head-name) &&
+		onto=3D$(cat "$GIT_DIR"/rebase-apply/onto) &&
+		orig_head=3D$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
+		git am --resolved --3way --resolvemsg=3D"$RESOLVEMSG" &&
+		move_to_original_branch
+		exit
+		;;
+	--skip)
+		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
+			die "No rebase in progress?"
+
+		git reset --hard HEAD || exit $?
+		if test -d "$dotest"
+		then
+			git rerere clear
+			prev_head=3D$(cat "$dotest/prev_head")
+			end=3D$(cat "$dotest/end")
+			msgnum=3D$(cat "$dotest/msgnum")
+			msgnum=3D$(($msgnum + 1))
+			onto=3D$(cat "$dotest/onto")
+			while test "$msgnum" -le "$end"
+			do
+				call_merge "$msgnum"
+				continue_merge
+			done
+			finish_rb_merge
+			exit
+		fi
+		head_name=3D$(cat "$GIT_DIR"/rebase-apply/head-name) &&
+		onto=3D$(cat "$GIT_DIR"/rebase-apply/onto) &&
+		orig_head=3D$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
+		git am -3 --skip --resolvemsg=3D"$RESOLVEMSG" &&
+		move_to_original_branch
+		exit
+		;;
+	--abort)
+		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
+			die "No rebase in progress?"
+
+		git rerere clear
+		if test -d "$dotest"
+		then
+			move_to_original_branch
+		else
+			dotest=3D"$GIT_DIR"/rebase-apply
+			move_to_original_branch
+		fi
+		git reset --hard $(cat "$dotest/orig-head")
+		rm -r "$dotest"
+		exit
+		;;
+	--onto)
+		test 2 -le "$#" || usage
+		newbase=3D"$2"
+		shift
+		;;
+	-M|-m|--m|--me|--mer|--merg|--merge)
+		do_merge=3Dt
+		;;
+	-s=3D*|--s=3D*|--st=3D*|--str=3D*|--stra=3D*|--strat=3D*|--strate=3D*=
|\
+		--strateg=3D*|--strategy=3D*|\
+	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
+		case "$#,$1" in
+		*,*=3D*)
+			strategy=3D`expr "z$1" : 'z-[^=3D]*=3D\(.*\)'` ;;
+		1,*)
+			usage ;;
+		*)
+			strategy=3D"$2"
+			shift ;;
+		esac
+		do_merge=3Dt
+		;;
+	-n|--no-stat)
+		diffstat=3D
+		;;
+	--stat)
+		diffstat=3Dt
+		;;
+	-v|--verbose)
+		verbose=3Dt
+		diffstat=3Dt
+		;;
+	--whitespace=3D*)
+		git_am_opt=3D"$git_am_opt $1"
+		case "$1" in
+		--whitespace=3Dfix|--whitespace=3Dstrip)
+			force_rebase=3Dt
+			;;
+		esac
+		;;
+	--committer-date-is-author-date|--ignore-date)
+		git_am_opt=3D"$git_am_opt $1"
+		force_rebase=3Dt
+		;;
+	-C*)
+		git_am_opt=3D"$git_am_opt $1"
+		;;
+	--root)
+		rebase_root=3Dt
+		;;
+	-f|--f|--fo|--for|--forc|force|--force-r|--force-re|--force-reb|--for=
ce-reba|--force-rebas|--force-rebase)
+		force_rebase=3Dt
+		;;
+	-*)
+		usage
+		;;
+	*)
+		break
+		;;
+	esac
+	shift
+done
+test $# -gt 2 && usage
+
+# Make sure we do not have $GIT_DIR/rebase-apply
+if test -z "$do_merge"
+then
+	if mkdir "$GIT_DIR"/rebase-apply 2>/dev/null
+	then
+		rmdir "$GIT_DIR"/rebase-apply
+	else
+		echo >&2 '
+It seems that I cannot create a rebase-apply directory, and
+I wonder if you are in the middle of patch application or another
+rebase.  If that is not the case, please
+	rm -fr '"$GIT_DIR"'/rebase-apply
+and run me again.  I am stopping in case you still have something
+valuable there.'
+		exit 1
+	fi
+else
+	if test -d "$dotest"
+	then
+		die "previous rebase directory $dotest still exists." \
+			'Try git rebase (--continue | --abort | --skip)'
+	fi
+fi
+
+# The tree must be really really clean.
+if ! git update-index --ignore-submodules --refresh; then
+	echo >&2 "cannot rebase: you have unstaged changes"
+	exit 1
+fi
+diff=3D$(git diff-index --cached --name-status -r --ignore-submodules =
HEAD --)
+case "$diff" in
+?*)	echo >&2 "cannot rebase: your index contains uncommitted changes"
+	echo >&2 "$diff"
+	exit 1
+	;;
+esac
+
+if test -z "$rebase_root"
+then
+	# The upstream head must be given.  Make sure it is valid.
+	upstream_name=3D"$1"
+	shift
+	upstream=3D`git rev-parse --verify "${upstream_name}^0"` ||
+	die "invalid upstream $upstream_name"
+	unset root_flag
+	upstream_arg=3D"$upstream_name"
+else
+	test -z "$newbase" && die "--root must be used with --onto"
+	unset upstream_name
+	unset upstream
+	root_flag=3D"--root"
+	upstream_arg=3D"$root_flag"
+fi
+
+# Make sure the branch to rebase onto is valid.
+onto_name=3D${newbase-"$upstream_name"}
+onto=3D$(git rev-parse --verify "${onto_name}^0") || exit
+
+# If a hook exists, give it a chance to interrupt
+run_pre_rebase_hook "$upstream_arg" "$@"
+
+# If the branch to rebase is given, that is the branch we will rebase
+# $branch_name -- branch being rebased, or HEAD (already detached)
+# $orig_head -- commit object name of tip of the branch before rebasin=
g
+# $head_name -- refs/heads/<that-branch> or "detached HEAD"
+switch_to=3D
+case "$#" in
+1)
+	# Is it "rebase other $branchname" or "rebase other $commit"?
+	branch_name=3D"$1"
+	switch_to=3D"$1"
+
+	if git show-ref --verify --quiet -- "refs/heads/$1" &&
+	   branch=3D$(git rev-parse -q --verify "refs/heads/$1")
+	then
+		head_name=3D"refs/heads/$1"
+	elif branch=3D$(git rev-parse -q --verify "$1")
+	then
+		head_name=3D"detached HEAD"
+	else
+		usage
+	fi
+	;;
+*)
+	# Do not need to switch branches, we are already on it.
+	if branch_name=3D`git symbolic-ref -q HEAD`
+	then
+		head_name=3D$branch_name
+		branch_name=3D`expr "z$branch_name" : 'zrefs/heads/\(.*\)'`
+	else
+		head_name=3D"detached HEAD"
+		branch_name=3DHEAD ;# detached
+	fi
+	branch=3D$(git rev-parse --verify "${branch_name}^0") || exit
+	;;
+esac
+orig_head=3D$branch
+
+# Now we are rebasing commits $upstream..$branch (or with --root,
+# everything leading up to $branch) on top of $onto
+
+# Check if we are already based on $onto with linear history,
+# but this should be done only when upstream and onto are the same.
+mb=3D$(git merge-base "$onto" "$branch")
+if test "$upstream" =3D "$onto" && test "$mb" =3D "$onto" &&
+	# linear history?
+	! (git rev-list --parents "$onto".."$branch" | grep " .* ") > /dev/nu=
ll
+then
+	if test -z "$force_rebase"
+	then
+		# Lazily switch to the target branch if needed...
+		test -z "$switch_to" || git checkout "$switch_to"
+		echo >&2 "Current branch $branch_name is up to date."
+		exit 0
+	else
+		echo "Current branch $branch_name is up to date, rebase forced."
+	fi
+fi
+
+# Detach HEAD and reset the tree
+echo "First, rewinding head to replay your work on top of it..."
+git checkout -q "$onto^0" || die "could not detach HEAD"
+git update-ref ORIG_HEAD $branch
+
+if test -n "$diffstat"
+then
+	if test -n "$verbose"
+	then
+		echo "Changes from $mb to $onto:"
+	fi
+	# We want color (if set), but no pager
+	GIT_PAGER=3D'' git diff --stat --summary "$mb" "$onto"
+fi
+
+# If the $onto is a proper descendant of the tip of the branch, then
+# we just fast forwarded.
+if test "$mb" =3D "$branch"
+then
+	echo >&2 "Fast-forwarded $branch_name to $onto_name."
+	move_to_original_branch
+	exit 0
+fi
+
+if test -n "$rebase_root"
+then
+	revisions=3D"$onto..$orig_head"
+else
+	revisions=3D"$upstream..$orig_head"
+fi
+
+if test -z "$do_merge"
+then
+	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
+		$root_flag "$revisions" |
+	git am $git_am_opt --rebasing --resolvemsg=3D"$RESOLVEMSG" &&
+	move_to_original_branch
+	ret=3D$?
+	test 0 !=3D $ret -a -d "$GIT_DIR"/rebase-apply &&
+		echo $head_name > "$GIT_DIR"/rebase-apply/head-name &&
+		echo $onto > "$GIT_DIR"/rebase-apply/onto &&
+		echo $orig_head > "$GIT_DIR"/rebase-apply/orig-head
+	exit $ret
+fi
+
+# start doing a rebase with git-merge
+# this is rename-aware if the recursive (default) strategy is used
+
+mkdir -p "$dotest"
+echo "$onto" > "$dotest/onto"
+echo "$onto_name" > "$dotest/onto_name"
+prev_head=3D$orig_head
+echo "$prev_head" > "$dotest/prev_head"
+echo "$orig_head" > "$dotest/orig-head"
+echo "$head_name" > "$dotest/head-name"
+
+msgnum=3D0
+for cmt in `git rev-list --reverse --no-merges "$revisions"`
+do
+	msgnum=3D$(($msgnum + 1))
+	echo "$cmt" > "$dotest/cmt.$msgnum"
+done
+
+echo 1 >"$dotest/msgnum"
+echo $msgnum >"$dotest/end"
+
+end=3D$msgnum
+msgnum=3D1
+
+while test "$msgnum" -le "$end"
+do
+	call_merge "$msgnum"
+	continue_merge
+done
+
+finish_rb_merge
diff --git a/git-rebase.sh b/git-rebase.sh
deleted file mode 100755
index b83fd3f..0000000
--- a/git-rebase.sh
+++ /dev/null
@@ -1,530 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Junio C Hamano.
-#
-
-USAGE=3D'[--interactive | -i] [-v] [--force-rebase | -f] [--onto <newb=
ase>] [<upstream>|--root] [<branch>]'
-LONG_USAGE=3D'git-rebase replaces <branch> with a new branch of the
-same name.  When the --onto option is provided the new branch starts
-out with a HEAD equal to <newbase>, otherwise it is equal to <upstream=
>
-It then attempts to create a new commit for each commit from the origi=
nal
-<branch> that does not exist in the <upstream> branch.
-
-It is possible that a merge failure will prevent this process from bei=
ng
-completely automatic.  You will have to resolve any such merge failure
-and run git rebase --continue.  Another option is to bypass the commit
-that caused the merge failure with git rebase --skip.  To restore the
-original <branch> and remove the .git/rebase-apply working files, use =
the
-command git rebase --abort instead.
-
-Note that if <branch> is not specified on the command line, the
-currently checked out branch is used.
-
-Example:       git-rebase master~1 topic
-
-        A---B---C topic                   A'\''--B'\''--C'\'' topic
-       /                   -->           /
-  D---E---F---G master          D---E---F---G master
-'
-
-SUBDIRECTORY_OK=3DYes
-OPTIONS_SPEC=3D
-. git-sh-setup
-set_reflog_action rebase
-require_work_tree
-cd_to_toplevel
-
-OK_TO_SKIP_PRE_REBASE=3D
-RESOLVEMSG=3D"
-When you have resolved this problem run \"git rebase --continue\".
-If you would prefer to skip this patch, instead run \"git rebase --ski=
p\".
-To restore the original branch and stop rebasing run \"git rebase --ab=
ort\".
-"
-unset newbase
-strategy=3Drecursive
-do_merge=3D
-dotest=3D"$GIT_DIR"/rebase-merge
-prec=3D4
-verbose=3D
-diffstat=3D$(git config --bool rebase.stat)
-git_am_opt=3D
-rebase_root=3D
-force_rebase=3D
-
-continue_merge () {
-	test -n "$prev_head" || die "prev_head must be defined"
-	test -d "$dotest" || die "$dotest directory does not exist"
-
-	unmerged=3D$(git ls-files -u)
-	if test -n "$unmerged"
-	then
-		echo "You still have unmerged paths in your index"
-		echo "did you forget to use git add?"
-		die "$RESOLVEMSG"
-	fi
-
-	cmt=3D`cat "$dotest/current"`
-	if ! git diff-index --quiet --ignore-submodules HEAD --
-	then
-		if ! git commit --no-verify -C "$cmt"
-		then
-			echo "Commit failed, please do not call \"git commit\""
-			echo "directly, but instead do one of the following: "
-			die "$RESOLVEMSG"
-		fi
-		printf "Committed: %0${prec}d " $msgnum
-	else
-		printf "Already applied: %0${prec}d " $msgnum
-	fi
-	git rev-list --pretty=3Doneline -1 "$cmt" | sed -e 's/^[^ ]* //'
-
-	prev_head=3D`git rev-parse HEAD^0`
-	# save the resulting commit so we can read-tree on it later
-	echo "$prev_head" > "$dotest/prev_head"
-
-	# onto the next patch:
-	msgnum=3D$(($msgnum + 1))
-	echo "$msgnum" >"$dotest/msgnum"
-}
-
-call_merge () {
-	cmt=3D"$(cat "$dotest/cmt.$1")"
-	echo "$cmt" > "$dotest/current"
-	hd=3D$(git rev-parse --verify HEAD)
-	cmt_name=3D$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
-	msgnum=3D$(cat "$dotest/msgnum")
-	end=3D$(cat "$dotest/end")
-	eval GITHEAD_$cmt=3D'"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
-	eval GITHEAD_$hd=3D'$(cat "$dotest/onto_name")'
-	export GITHEAD_$cmt GITHEAD_$hd
-	git-merge-$strategy "$cmt^" -- "$hd" "$cmt"
-	rv=3D$?
-	case "$rv" in
-	0)
-		unset GITHEAD_$cmt GITHEAD_$hd
-		return
-		;;
-	1)
-		git rerere
-		die "$RESOLVEMSG"
-		;;
-	2)
-		echo "Strategy: $rv $strategy failed, try another" 1>&2
-		die "$RESOLVEMSG"
-		;;
-	*)
-		die "Unknown exit code ($rv) from command:" \
-			"git-merge-$strategy $cmt^ -- HEAD $cmt"
-		;;
-	esac
-}
-
-move_to_original_branch () {
-	test -z "$head_name" &&
-		head_name=3D"$(cat "$dotest"/head-name)" &&
-		onto=3D"$(cat "$dotest"/onto)" &&
-		orig_head=3D"$(cat "$dotest"/orig-head)"
-	case "$head_name" in
-	refs/*)
-		message=3D"rebase finished: $head_name onto $onto"
-		git update-ref -m "$message" \
-			$head_name $(git rev-parse HEAD) $orig_head &&
-		git symbolic-ref HEAD $head_name ||
-		die "Could not move back to $head_name"
-		;;
-	esac
-}
-
-finish_rb_merge () {
-	move_to_original_branch
-	rm -r "$dotest"
-	echo "All done."
-}
-
-is_interactive () {
-	while test $# !=3D 0
-	do
-		case "$1" in
-			-i|--interactive)
-				interactive_rebase=3Dexplicit
-				break
-			;;
-			-p|--preserve-merges)
-				interactive_rebase=3Dimplied
-			;;
-		esac
-		shift
-	done
-
-	if [ "$interactive_rebase" =3D implied ]; then
-		GIT_EDITOR=3D:
-		export GIT_EDITOR
-	fi
-
-	test -n "$interactive_rebase" || test -f "$dotest"/interactive
-}
-
-run_pre_rebase_hook () {
-	if test -z "$OK_TO_SKIP_PRE_REBASE" &&
-	   test -x "$GIT_DIR/hooks/pre-rebase"
-	then
-		"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} || {
-			echo >&2 "The pre-rebase hook refused to rebase."
-			exit 1
-		}
-	fi
-}
-
-test -f "$GIT_DIR"/rebase-apply/applying &&
-	die 'It looks like git-am is in progress. Cannot rebase.'
-
-is_interactive "$@" && exec git-rebase--interactive "$@"
-
-if test $# -eq 0
-then
-	test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply || usage
-	test -d "$dotest" -o -f "$GIT_DIR"/rebase-apply/rebasing &&
-		die 'A rebase is in progress, try --continue, --skip or --abort.'
-	die "No arguments given and $GIT_DIR/rebase-apply already exists."
-fi
-
-while test $# !=3D 0
-do
-	case "$1" in
-	--no-verify)
-		OK_TO_SKIP_PRE_REBASE=3Dyes
-		;;
-	--continue)
-		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
-			die "No rebase in progress?"
-
-		git diff-files --quiet --ignore-submodules || {
-			echo "You must edit all merge conflicts and then"
-			echo "mark them as resolved using git add"
-			exit 1
-		}
-		if test -d "$dotest"
-		then
-			prev_head=3D$(cat "$dotest/prev_head")
-			end=3D$(cat "$dotest/end")
-			msgnum=3D$(cat "$dotest/msgnum")
-			onto=3D$(cat "$dotest/onto")
-			continue_merge
-			while test "$msgnum" -le "$end"
-			do
-				call_merge "$msgnum"
-				continue_merge
-			done
-			finish_rb_merge
-			exit
-		fi
-		head_name=3D$(cat "$GIT_DIR"/rebase-apply/head-name) &&
-		onto=3D$(cat "$GIT_DIR"/rebase-apply/onto) &&
-		orig_head=3D$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
-		git am --resolved --3way --resolvemsg=3D"$RESOLVEMSG" &&
-		move_to_original_branch
-		exit
-		;;
-	--skip)
-		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
-			die "No rebase in progress?"
-
-		git reset --hard HEAD || exit $?
-		if test -d "$dotest"
-		then
-			git rerere clear
-			prev_head=3D$(cat "$dotest/prev_head")
-			end=3D$(cat "$dotest/end")
-			msgnum=3D$(cat "$dotest/msgnum")
-			msgnum=3D$(($msgnum + 1))
-			onto=3D$(cat "$dotest/onto")
-			while test "$msgnum" -le "$end"
-			do
-				call_merge "$msgnum"
-				continue_merge
-			done
-			finish_rb_merge
-			exit
-		fi
-		head_name=3D$(cat "$GIT_DIR"/rebase-apply/head-name) &&
-		onto=3D$(cat "$GIT_DIR"/rebase-apply/onto) &&
-		orig_head=3D$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
-		git am -3 --skip --resolvemsg=3D"$RESOLVEMSG" &&
-		move_to_original_branch
-		exit
-		;;
-	--abort)
-		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
-			die "No rebase in progress?"
-
-		git rerere clear
-		if test -d "$dotest"
-		then
-			move_to_original_branch
-		else
-			dotest=3D"$GIT_DIR"/rebase-apply
-			move_to_original_branch
-		fi
-		git reset --hard $(cat "$dotest/orig-head")
-		rm -r "$dotest"
-		exit
-		;;
-	--onto)
-		test 2 -le "$#" || usage
-		newbase=3D"$2"
-		shift
-		;;
-	-M|-m|--m|--me|--mer|--merg|--merge)
-		do_merge=3Dt
-		;;
-	-s=3D*|--s=3D*|--st=3D*|--str=3D*|--stra=3D*|--strat=3D*|--strate=3D*=
|\
-		--strateg=3D*|--strategy=3D*|\
-	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
-		case "$#,$1" in
-		*,*=3D*)
-			strategy=3D`expr "z$1" : 'z-[^=3D]*=3D\(.*\)'` ;;
-		1,*)
-			usage ;;
-		*)
-			strategy=3D"$2"
-			shift ;;
-		esac
-		do_merge=3Dt
-		;;
-	-n|--no-stat)
-		diffstat=3D
-		;;
-	--stat)
-		diffstat=3Dt
-		;;
-	-v|--verbose)
-		verbose=3Dt
-		diffstat=3Dt
-		;;
-	--whitespace=3D*)
-		git_am_opt=3D"$git_am_opt $1"
-		case "$1" in
-		--whitespace=3Dfix|--whitespace=3Dstrip)
-			force_rebase=3Dt
-			;;
-		esac
-		;;
-	--committer-date-is-author-date|--ignore-date)
-		git_am_opt=3D"$git_am_opt $1"
-		force_rebase=3Dt
-		;;
-	-C*)
-		git_am_opt=3D"$git_am_opt $1"
-		;;
-	--root)
-		rebase_root=3Dt
-		;;
-	-f|--f|--fo|--for|--forc|force|--force-r|--force-re|--force-reb|--for=
ce-reba|--force-rebas|--force-rebase)
-		force_rebase=3Dt
-		;;
-	-*)
-		usage
-		;;
-	*)
-		break
-		;;
-	esac
-	shift
-done
-test $# -gt 2 && usage
-
-# Make sure we do not have $GIT_DIR/rebase-apply
-if test -z "$do_merge"
-then
-	if mkdir "$GIT_DIR"/rebase-apply 2>/dev/null
-	then
-		rmdir "$GIT_DIR"/rebase-apply
-	else
-		echo >&2 '
-It seems that I cannot create a rebase-apply directory, and
-I wonder if you are in the middle of patch application or another
-rebase.  If that is not the case, please
-	rm -fr '"$GIT_DIR"'/rebase-apply
-and run me again.  I am stopping in case you still have something
-valuable there.'
-		exit 1
-	fi
-else
-	if test -d "$dotest"
-	then
-		die "previous rebase directory $dotest still exists." \
-			'Try git rebase (--continue | --abort | --skip)'
-	fi
-fi
-
-# The tree must be really really clean.
-if ! git update-index --ignore-submodules --refresh; then
-	echo >&2 "cannot rebase: you have unstaged changes"
-	exit 1
-fi
-diff=3D$(git diff-index --cached --name-status -r --ignore-submodules =
HEAD --)
-case "$diff" in
-?*)	echo >&2 "cannot rebase: your index contains uncommitted changes"
-	echo >&2 "$diff"
-	exit 1
-	;;
-esac
-
-if test -z "$rebase_root"
-then
-	# The upstream head must be given.  Make sure it is valid.
-	upstream_name=3D"$1"
-	shift
-	upstream=3D`git rev-parse --verify "${upstream_name}^0"` ||
-	die "invalid upstream $upstream_name"
-	unset root_flag
-	upstream_arg=3D"$upstream_name"
-else
-	test -z "$newbase" && die "--root must be used with --onto"
-	unset upstream_name
-	unset upstream
-	root_flag=3D"--root"
-	upstream_arg=3D"$root_flag"
-fi
-
-# Make sure the branch to rebase onto is valid.
-onto_name=3D${newbase-"$upstream_name"}
-onto=3D$(git rev-parse --verify "${onto_name}^0") || exit
-
-# If a hook exists, give it a chance to interrupt
-run_pre_rebase_hook "$upstream_arg" "$@"
-
-# If the branch to rebase is given, that is the branch we will rebase
-# $branch_name -- branch being rebased, or HEAD (already detached)
-# $orig_head -- commit object name of tip of the branch before rebasin=
g
-# $head_name -- refs/heads/<that-branch> or "detached HEAD"
-switch_to=3D
-case "$#" in
-1)
-	# Is it "rebase other $branchname" or "rebase other $commit"?
-	branch_name=3D"$1"
-	switch_to=3D"$1"
-
-	if git show-ref --verify --quiet -- "refs/heads/$1" &&
-	   branch=3D$(git rev-parse -q --verify "refs/heads/$1")
-	then
-		head_name=3D"refs/heads/$1"
-	elif branch=3D$(git rev-parse -q --verify "$1")
-	then
-		head_name=3D"detached HEAD"
-	else
-		usage
-	fi
-	;;
-*)
-	# Do not need to switch branches, we are already on it.
-	if branch_name=3D`git symbolic-ref -q HEAD`
-	then
-		head_name=3D$branch_name
-		branch_name=3D`expr "z$branch_name" : 'zrefs/heads/\(.*\)'`
-	else
-		head_name=3D"detached HEAD"
-		branch_name=3DHEAD ;# detached
-	fi
-	branch=3D$(git rev-parse --verify "${branch_name}^0") || exit
-	;;
-esac
-orig_head=3D$branch
-
-# Now we are rebasing commits $upstream..$branch (or with --root,
-# everything leading up to $branch) on top of $onto
-
-# Check if we are already based on $onto with linear history,
-# but this should be done only when upstream and onto are the same.
-mb=3D$(git merge-base "$onto" "$branch")
-if test "$upstream" =3D "$onto" && test "$mb" =3D "$onto" &&
-	# linear history?
-	! (git rev-list --parents "$onto".."$branch" | grep " .* ") > /dev/nu=
ll
-then
-	if test -z "$force_rebase"
-	then
-		# Lazily switch to the target branch if needed...
-		test -z "$switch_to" || git checkout "$switch_to"
-		echo >&2 "Current branch $branch_name is up to date."
-		exit 0
-	else
-		echo "Current branch $branch_name is up to date, rebase forced."
-	fi
-fi
-
-# Detach HEAD and reset the tree
-echo "First, rewinding head to replay your work on top of it..."
-git checkout -q "$onto^0" || die "could not detach HEAD"
-git update-ref ORIG_HEAD $branch
-
-if test -n "$diffstat"
-then
-	if test -n "$verbose"
-	then
-		echo "Changes from $mb to $onto:"
-	fi
-	# We want color (if set), but no pager
-	GIT_PAGER=3D'' git diff --stat --summary "$mb" "$onto"
-fi
-
-# If the $onto is a proper descendant of the tip of the branch, then
-# we just fast forwarded.
-if test "$mb" =3D "$branch"
-then
-	echo >&2 "Fast-forwarded $branch_name to $onto_name."
-	move_to_original_branch
-	exit 0
-fi
-
-if test -n "$rebase_root"
-then
-	revisions=3D"$onto..$orig_head"
-else
-	revisions=3D"$upstream..$orig_head"
-fi
-
-if test -z "$do_merge"
-then
-	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-		$root_flag "$revisions" |
-	git am $git_am_opt --rebasing --resolvemsg=3D"$RESOLVEMSG" &&
-	move_to_original_branch
-	ret=3D$?
-	test 0 !=3D $ret -a -d "$GIT_DIR"/rebase-apply &&
-		echo $head_name > "$GIT_DIR"/rebase-apply/head-name &&
-		echo $onto > "$GIT_DIR"/rebase-apply/onto &&
-		echo $orig_head > "$GIT_DIR"/rebase-apply/orig-head
-	exit $ret
-fi
-
-# start doing a rebase with git-merge
-# this is rename-aware if the recursive (default) strategy is used
-
-mkdir -p "$dotest"
-echo "$onto" > "$dotest/onto"
-echo "$onto_name" > "$dotest/onto_name"
-prev_head=3D$orig_head
-echo "$prev_head" > "$dotest/prev_head"
-echo "$orig_head" > "$dotest/orig-head"
-echo "$head_name" > "$dotest/head-name"
-
-msgnum=3D0
-for cmt in `git rev-list --reverse --no-merges "$revisions"`
-do
-	msgnum=3D$(($msgnum + 1))
-	echo "$cmt" > "$dotest/cmt.$msgnum"
-done
-
-echo 1 >"$dotest/msgnum"
-echo $msgnum >"$dotest/end"
-
-end=3D$msgnum
-msgnum=3D1
-
-while test "$msgnum" -le "$end"
-do
-	call_merge "$msgnum"
-	continue_merge
-done
-
-finish_rb_merge
diff --git a/git.c b/git.c
index 5a00726..39456a0 100644
--- a/git.c
+++ b/git.c
@@ -336,6 +336,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 		{ "push", cmd_push, RUN_SETUP },
 		{ "read-tree", cmd_read_tree, RUN_SETUP },
+		{ "rebase", cmd_rebase, RUN_SETUP | NEED_WORK_TREE },
 		{ "receive-pack", cmd_receive_pack },
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "remote", cmd_remote, RUN_SETUP },
--=20
test
