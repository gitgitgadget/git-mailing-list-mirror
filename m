From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH 5/8] Make git-update-index a builtin
Date: Tue, 13 Jun 2006 22:21:57 +0200
Organization: Chalmers
Message-ID: <448F1E65.7020909@etek.chalmers.se>
References: <448EF791.7070504@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Tue Jun 13 22:22:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqFOu-0006Y1-Sk
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 22:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWFMUWE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Jun 2006 16:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWFMUWE
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 16:22:04 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:28558 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932212AbWFMUWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 16:22:01 -0400
Received: from [192.168.0.82] (213.66.93.165) by pne-smtpout2-sn2.hy.skanova.net (7.2.072.1)
        id 44897AB8000E725C; Tue, 13 Jun 2006 22:21:57 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.4) Gecko/20060603 Thunderbird/1.5.0.4 Mnenhy/0.7.4.666
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <448EF791.7070504@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21811>

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---
 Makefile                                 |    6 +++---
 update-index.c =3D> builtin-update-index.c |   19 ++++++++++++-------
 builtin.h                                |    1 +
 git.c                                    |    3 ++-
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 181255f..906fc0f 100644
--- a/Makefile
+++ b/Makefile
@@ -157,7 +157,7 @@ PROGRAMS =3D \
 	git-send-pack$X git-shell$X \
 	git-show-index$X git-ssh-fetch$X \
 	git-ssh-upload$X git-unpack-file$X \
-	git-unpack-objects$X git-update-index$X git-update-server-info$X \
+	git-unpack-objects$X git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X \
 	git-update-ref$X git-symbolic-ref$X \
 	git-name-rev$X git-pack-redundant$X git-repo-config$X git-var$X \
@@ -170,7 +170,7 @@ BUILT_INS =3D git-log$X git-whatchanged$X=20
 	git-init-db$X git-tar-tree$X git-upload-tar$X git-format-patch$X \
 	git-ls-files$X git-ls-tree$X git-get-tar-commit-id$X \
 	git-read-tree$X git-commit-tree$X git-write-tree$X \
-	git-apply$X git-show-branch$X git-diff-files$X \
+	git-apply$X git-show-branch$X git-diff-files$X git-update-index$X \
 	git-diff-index$X git-diff-stages$X git-diff-tree$X git-cat-file$X
=20
 # what 'all' will build and 'install' will install, in gitexecdir
@@ -221,7 +221,7 @@ BUILTIN_OBJS =3D \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-p=
ush.o \
 	builtin-grep.o builtin-add.o builtin-rev-list.o builtin-check-ref-for=
mat.o \
 	builtin-rm.o builtin-init-db.o builtin-rev-parse.o \
-	builtin-tar-tree.o builtin-upload-tar.o \
+	builtin-tar-tree.o builtin-upload-tar.o builtin-update-index.o \
 	builtin-ls-files.o builtin-ls-tree.o builtin-write-tree.o \
 	builtin-read-tree.o builtin-commit-tree.o builtin-mailinfo.o \
 	builtin-apply.o builtin-show-branch.o builtin-diff-files.o \
diff --git a/update-index.c b/builtin-update-index.c
similarity index 97%
rename from update-index.c
rename to builtin-update-index.c
index fbccc4a..325cd09 100644
--- a/update-index.c
+++ b/builtin-update-index.c
@@ -8,6 +8,7 @@ #include "strbuf.h"
 #include "quote.h"
 #include "cache-tree.h"
 #include "tree-walk.h"
+#include "builtin.h"
=20
 /*
  * Default to not allowing changes to the list of files. The
@@ -186,8 +187,6 @@ static void chmod_path(int flip, const c
 	die("git-update-index: cannot chmod %cx '%s'", flip, path);
 }
=20
-static struct lock_file lock_file;
-
 static void update_one(const char *path, const char *prefix, int prefi=
x_length)
 {
 	const char *p =3D prefix_path(prefix, prefix_length, path);
@@ -238,7 +237,7 @@ static void read_index_info(int line_ter
 		 * (2) mode SP type SP sha1          TAB path
 		 * The second format is to stuff git-ls-tree output
 		 * into the index file.
-		 *=20
+		 *
 		 * (3) mode         SP sha1 SP stage TAB path
 		 * This format is to put higher order stages into the
 		 * index file and matches git-ls-files --stage output.
@@ -477,7 +476,7 @@ static int do_reupdate(int ac, const cha
 	return 0;
 }
=20
-int main(int argc, const char **argv)
+int cmd_update_index(int argc, const char **argv, char **envp)
 {
 	int i, newfd, entries, has_errors =3D 0, line_termination =3D '\n';
 	int allow_options =3D 1;
@@ -486,12 +485,16 @@ int main(int argc, const char **argv)
 	int prefix_length =3D prefix ? strlen(prefix) : 0;
 	char set_executable_bit =3D 0;
 	unsigned int refresh_flags =3D 0;
+	struct lock_file *lock_file;
=20
 	git_config(git_default_config);
=20
-	newfd =3D hold_lock_file_for_update(&lock_file, get_index_file());
+	/* We can't free this memory, it becomes part of a linked list parsed=
 atexit() */
+	lock_file =3D xmalloc(sizeof(struct lock_file));
+
+	newfd =3D hold_lock_file_for_update(lock_file, get_index_file());
 	if (newfd < 0)
-		die("unable to create new index file");
+		die("unable to create new cachefile");
=20
 	entries =3D read_cache();
 	if (entries < 0)
@@ -645,9 +648,11 @@ int main(int argc, const char **argv)
  finish:
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
-		    commit_lock_file(&lock_file))
+		    commit_lock_file(lock_file))
 			die("Unable to write new index file");
 	}
=20
+	rollback_lock_file(lock_file);
+
 	return has_errors ? 1 : 0;
 }
diff --git a/builtin.h b/builtin.h
index c934d7a..9ee5ea6 100644
--- a/builtin.h
+++ b/builtin.h
@@ -47,6 +47,7 @@ extern int cmd_diff_stages(int argc, con
 extern int cmd_diff_tree(int argc, const char **argv, char **envp);
 extern int cmd_cat_file(int argc, const char **argv, char **envp);
 extern int cmd_rev_parse(int argc, const char **argv, char **envp);
+extern int cmd_update_index(int argc, const char **argv, char **envp);
=20
 extern int cmd_write_tree(int argc, const char **argv, char **envp);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char =
*prefix);
diff --git a/git.c b/git.c
index 31196f5..4a931fb 100644
--- a/git.c
+++ b/git.c
@@ -182,7 +182,8 @@ static void handle_internal_command(int=20
 		{ "write-tree", cmd_write_tree },
 		{ "mailsplit", cmd_mailsplit },
 		{ "mailinfo", cmd_mailinfo },
-		{ "stripspace", cmd_stripspace }
+		{ "stripspace", cmd_stripspace },
+		{ "update-index", cmd_update_index }
 	};
 	int i;
=20
--=20
1.4.0
