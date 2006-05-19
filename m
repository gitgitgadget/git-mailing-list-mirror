From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] Builtin git-init-db
Date: Fri, 19 May 2006 13:03:57 +0300
Message-ID: <20060519130357.6ae83cff.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 19 12:02:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fh1oN-0008OH-QD
	for gcvg-git@gmane.org; Fri, 19 May 2006 12:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWESKCA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 06:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWESKCA
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 06:02:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:28142 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932251AbWESKB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 06:01:59 -0400
Received: by nf-out-0910.google.com with SMTP id o63so33727nfa
        for <git@vger.kernel.org>; Fri, 19 May 2006 03:01:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=YeQw53UVSuwVqum2xZBJvCDIELHPR0RUJgyX461wnalma2pQhdOcV+dfF3sRwBHfEZzhQJ23lKI6U1rW9ztZdI66O2y+yeesnBPUeQxqxGG0EmtuC9rXc/BpR7T3tWqD8hXKxPBQDmKGie1SuLTOFqClShMp8JU3kGpYDXRlLjE=
Received: by 10.49.87.3 with SMTP id p3mr1282003nfl;
        Fri, 19 May 2006 03:01:57 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id l22sm1565907nfc.2006.05.19.03.01.55;
        Fri, 19 May 2006 03:01:57 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20345>

Basically this just renames init-db.c to builtin-init-db.c and makes
some strings const.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>

---

ea0920d755efa314e2be014e2a1eccda89d8f850
 Makefile                       |   13 ++++++-------
 init-db.c => builtin-init-db.c |   12 +++++++-----
 builtin.h                      |    1 +
 git.c                          |    1 +
 4 files changed, 15 insertions(+), 12 deletions(-)
 rename init-db.c => builtin-init-db.c (96%)

ea0920d755efa314e2be014e2a1eccda89d8f850
diff --git a/Makefile b/Makefile
index 2149fb8..a4e9643 100644
--- a/Makefile
+++ b/Makefile
@@ -154,7 +154,7 @@ PROGRAMS = \
 	git-convert-objects$X git-diff-files$X \
 	git-diff-index$X git-diff-stages$X \
 	git-diff-tree$X git-fetch-pack$X git-fsck-objects$X \
-	git-hash-object$X git-index-pack$X git-init-db$X git-local-fetch$X \
+	git-hash-object$X git-index-pack$X git-local-fetch$X \
 	git-ls-files$X git-ls-tree$X git-mailinfo$X git-merge-base$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-pack-objects$X git-patch-id$X \
 	git-peek-remote$X git-prune-packed$X git-read-tree$X \
@@ -170,7 +170,8 @@ PROGRAMS = \
 
 BUILT_INS = git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X \
-	git-grep$X git-rev-list$X git-check-ref-format$X
+	git-grep$X git-rev-list$X git-check-ref-format$X \
+	git-init-db$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -218,7 +219,8 @@ LIB_OBJS = \
 
 BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
-	builtin-grep.o builtin-rev-list.o builtin-check-ref-format.o
+	builtin-grep.o builtin-rev-list.o builtin-check-ref-format.o \
+	builtin-init-db.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
@@ -473,6 +475,7 @@ strip: $(PROGRAMS) git$X
 
 git$X: git.c common-cmds.h $(BUILTIN_OBJS) $(GITLIBS)
 	$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
+		-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' \
 		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
@@ -565,10 +568,6 @@ git-http-push$X: revision.o http.o http-
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-init-db.o: init-db.c
-	$(CC) -c $(ALL_CFLAGS) \
-		-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $*.c
-
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(GITLIBS)
 $(DIFF_OBJS): diffcore.h
diff --git a/init-db.c b/builtin-init-db.c
similarity index 96%
rename from init-db.c
rename to builtin-init-db.c
index ff29496..2a1384c 100644
--- a/init-db.c
+++ b/builtin-init-db.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "builtin.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates/"
@@ -116,7 +117,7 @@ static void copy_templates_1(char *path,
 	}
 }
 
-static void copy_templates(const char *git_dir, int len, char *template_dir)
+static void copy_templates(const char *git_dir, int len, const char *template_dir)
 {
 	char path[PATH_MAX];
 	char template_path[PATH_MAX];
@@ -163,7 +164,7 @@ static void copy_templates(const char *g
 	closedir(dir);
 }
 
-static void create_default_files(const char *git_dir, char *template_path)
+static void create_default_files(const char *git_dir, const char *template_path)
 {
 	unsigned len = strlen(git_dir);
 	static char path[PATH_MAX];
@@ -234,15 +235,16 @@ static const char init_db_usage[] =
  * On the other hand, it might just make lookup slower and messier. You
  * be the judge.  The default case is to have one DB per managed directory.
  */
-int main(int argc, char **argv)
+int cmd_init_db(int argc, const char **argv, char **envp)
 {
 	const char *git_dir;
 	const char *sha1_dir;
-	char *path, *template_dir = NULL;
+	const char *template_dir = NULL;
+	char *path;
 	int len, i;
 
 	for (i = 1; i < argc; i++, argv++) {
-		char *arg = argv[1];
+		const char *arg = argv[1];
 		if (!strncmp(arg, "--template=", 11))
 			template_dir = arg+11;
 		else if (!strcmp(arg, "--shared"))
diff --git a/builtin.h b/builtin.h
index ff559de..6054126 100644
--- a/builtin.h
+++ b/builtin.h
@@ -26,5 +26,6 @@ extern int cmd_push(int argc, const char
 extern int cmd_grep(int argc, const char **argv, char **envp);
 extern int cmd_rev_list(int argc, const char **argv, char **envp);
 extern int cmd_check_ref_format(int argc, const char **argv, char **envp);
+extern int cmd_init_db(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/git.c b/git.c
index d0650bb..3216d31 100644
--- a/git.c
+++ b/git.c
@@ -51,6 +51,7 @@ static void handle_internal_command(int 
 		{ "diff", cmd_diff },
 		{ "grep", cmd_grep },
 		{ "rev-list", cmd_rev_list },
+		{ "init-db", cmd_init_db },
 		{ "check-ref-format", cmd_check_ref_format }
 	};
 	int i;
-- 
1.3.3.gff62-dirty
