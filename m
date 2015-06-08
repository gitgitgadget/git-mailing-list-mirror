From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/14] tempfile: a new module for handling temporary files
Date: Mon,  8 Jun 2015 11:07:33 +0200
Message-ID: <f7681cfc8ee4f1f5eba50f315f8e0ed0fed883a8.1433751986.git.mhagger@alum.mit.edu>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 11:08:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1t2k-0002f0-2C
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 11:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbbFHJIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 05:08:25 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48885 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752817AbbFHJIH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 05:08:07 -0400
X-AuditID: 1207440d-f79026d000000bad-f7-55755b6ba666
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 15.0B.02989.B6B55755; Mon,  8 Jun 2015 05:07:55 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5897ojQ010669
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 05:07:54 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433751986.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsUixO6iqJsdXRpqsHmGqEXXlW4mi4beK8wW
	t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE748rSb6wF
	x04yVbxa+5WlgfFvG1MXIyeHhICJxN+rR9ggbDGJC/fWA9lcHEIClxklrj38ywThnGCS6Hu1
	gB2kik1AV2JRTzNYt4iAo8SJB9dZQWxmAQeJzZ8bGUFsYQEviae7NoLVswioSvyYcIQFxOYV
	iJKYvvoI1GY5ifPHfzKD2JwCFhK/vu4CinMALTOX+DGXdQIj7wJGhlWMcok5pbm6uYmZOcWp
	ybrFyYl5ealFukZ6uZkleqkppZsYISHEu4Px/zqZQ4wCHIxKPLwHFpWECrEmlhVX5h5ilORg
	UhLl/RhRGirEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhJfJAijHm5JYWZValA+TkuZgURLnVVui
	7ickkJ5YkpqdmlqQWgSTleHgUJLg3RwF1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFha
	khEPio74YmB8gKR4gPY2gLTzFhck5gJFIVpPMSpKifPujgRKCIAkMkrz4MbCEsMrRnGgL4V5
	O0CqeIBJBa77FdBgJqDB378WgwwuSURISTUwVj1K8Vuyr/fnAq2NDAv2h/AvWZhxUeniWkUX
	jx6lbZzX2R6t3NJ0+tHjVm8ds2MzRG17Rb3LXPOm5mcZqH//tb6Be6LIvcqIN4/7P554EbP1
	+ftdjjs2H94dnNLMJBaby/3e+KVk+09Gsfe+G8KbIxateKds8KPR9+wpydOHNuzj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271003>

A lot of work went into defining the state diagram for lockfiles and
ensuring correct, race-resistant cleanup in all circumstances.

Most of that infrastructure can be applied directly to *any* temporary
file. So extract a new "tempfile" module from the "lockfile" module.
Reimplement lockfile on top of tempfile.

This first step is a pretty direct transplant of code. Subsequent
commits will improve the boundary between the two modules and add
users of the new module.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Makefile                 |   1 +
 builtin/add.c            |   1 +
 builtin/apply.c          |   1 +
 builtin/checkout-index.c |   1 +
 builtin/checkout.c       |   1 +
 builtin/clone.c          |   1 +
 builtin/commit.c         |  13 +--
 builtin/describe.c       |   1 +
 builtin/diff.c           |   1 +
 builtin/gc.c             |   1 +
 builtin/merge.c          |   1 +
 builtin/mv.c             |   1 +
 builtin/read-tree.c      |   1 +
 builtin/receive-pack.c   |   1 +
 builtin/reflog.c         |   1 +
 builtin/reset.c          |   1 +
 builtin/rm.c             |   1 +
 builtin/update-index.c   |   1 +
 bundle.c                 |   3 +-
 cache-tree.c             |   1 +
 config.c                 |  15 ++--
 credential-store.c       |   3 +-
 fast-import.c            |   1 +
 fetch-pack.c             |   1 +
 lockfile.c               | 179 ++++++----------------------------------
 lockfile.h               |  76 +++--------------
 merge-recursive.c        |   1 +
 merge.c                  |   1 +
 read-cache.c             |   3 +-
 refs.c                   |  15 ++--
 rerere.c                 |   1 +
 sequencer.c              |   1 +
 sha1_file.c              |   1 +
 shallow.c                |   7 +-
 tempfile.c               | 166 ++++++++++++++++++++++++++++++++++++++
 tempfile.h               | 206 +++++++++++++++++++++++++++++++++++++++++++++++
 test-scrap-cache-tree.c  |   1 +
 37 files changed, 465 insertions(+), 247 deletions(-)
 create mode 100644 tempfile.c
 create mode 100644 tempfile.h

diff --git a/Makefile b/Makefile
index 54ec511..2573f89 100644
--- a/Makefile
+++ b/Makefile
@@ -786,6 +786,7 @@ LIB_OBJS += string-list.o
 LIB_OBJS += submodule.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
+LIB_OBJS += tempfile.o
 LIB_OBJS += trace.o
 LIB_OBJS += trailer.o
 LIB_OBJS += transport.o
diff --git a/builtin/add.c b/builtin/add.c
index df5135b..aaa9ce4 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "builtin.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "dir.h"
 #include "pathspec.h"
diff --git a/builtin/apply.c b/builtin/apply.c
index 146be97..ea34626 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -7,6 +7,7 @@
  *
  */
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "cache-tree.h"
 #include "quote.h"
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 8028c37..ad5ac18 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -5,6 +5,7 @@
  *
  */
 #include "builtin.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "quote.h"
 #include "cache-tree.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9b49f0e..82c179d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "parse-options.h"
 #include "refs.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index b878252..494ebd2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -9,6 +9,7 @@
  */
 
 #include "builtin.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "parse-options.h"
 #include "fetch-pack.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index 254477f..c9fbe42 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -6,6 +6,7 @@
  */
 
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "cache-tree.h"
 #include "color.h"
@@ -344,7 +345,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			die(_("unable to create temporary index"));
 
 		old_index_env = getenv(INDEX_ENVIRONMENT);
-		setenv(INDEX_ENVIRONMENT, index_lock.filename.buf, 1);
+		setenv(INDEX_ENVIRONMENT, index_lock.tempfile.filename.buf, 1);
 
 		if (interactive_add(argc, argv, prefix, patch_interactive) != 0)
 			die(_("interactive add failed"));
@@ -355,7 +356,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			unsetenv(INDEX_ENVIRONMENT);
 
 		discard_cache();
-		read_cache_from(index_lock.filename.buf);
+		read_cache_from(index_lock.tempfile.filename.buf);
 		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
 			if (reopen_lock_file(&index_lock) < 0)
 				die(_("unable to write index file"));
@@ -365,7 +366,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			warning(_("Failed to update main cache tree"));
 
 		commit_style = COMMIT_NORMAL;
-		return index_lock.filename.buf;
+		return index_lock.tempfile.filename.buf;
 	}
 
 	/*
@@ -388,7 +389,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
 			die(_("unable to write new_index file"));
 		commit_style = COMMIT_NORMAL;
-		return index_lock.filename.buf;
+		return index_lock.tempfile.filename.buf;
 	}
 
 	/*
@@ -475,9 +476,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		die(_("unable to write temporary index file"));
 
 	discard_cache();
-	read_cache_from(false_lock.filename.buf);
+	read_cache_from(false_lock.tempfile.filename.buf);
 
-	return false_lock.filename.buf;
+	return false_lock.tempfile.filename.buf;
 }
 
 static int run_status(FILE *fp, const char *index_file, const char *prefix, int nowarn,
diff --git a/builtin/describe.c b/builtin/describe.c
index a36c829..2b54eb5 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "commit.h"
 #include "tag.h"
diff --git a/builtin/diff.c b/builtin/diff.c
index 4326fa5..e815ec7 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2006 Junio C Hamano
  */
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "color.h"
 #include "commit.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index 36fe333..6e18d35 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -11,6 +11,7 @@
  */
 
 #include "builtin.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "parse-options.h"
 #include "run-command.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index 85c54dc..584f18c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -9,6 +9,7 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "builtin.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "run-command.h"
 #include "diff.h"
diff --git a/builtin/mv.c b/builtin/mv.c
index d1d4316..9752126 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2006 Johannes Schindelin
  */
 #include "builtin.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "dir.h"
 #include "cache-tree.h"
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 43b47f7..7317e6f 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -5,6 +5,7 @@
  */
 
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "object.h"
 #include "tree.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 94d0571..13edfac 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "pack.h"
 #include "refs.h"
diff --git a/builtin/reflog.c b/builtin/reflog.c
index c2eb8ff..a1aa7e6 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "commit.h"
 #include "refs.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index 4c08ddc..9271200 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -8,6 +8,7 @@
  * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
  */
 #include "builtin.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "tag.h"
 #include "object.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index 80b972f..bc3c132 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds 2006
  */
 #include "builtin.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "dir.h"
 #include "cache-tree.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7431938..aa81943 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "quote.h"
 #include "cache-tree.h"
diff --git a/bundle.c b/bundle.c
index f732c92..d5985a1 100644
--- a/bundle.c
+++ b/bundle.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "bundle.h"
 #include "object.h"
@@ -255,7 +256,7 @@ static int write_pack_data(int bundle_fd, struct lock_file *lock, struct rev_inf
 	 * so set the lock fd to -1 so commit_lock_file()
 	 * won't fail trying to close it.
 	 */
-	lock->fd = -1;
+	lock->tempfile.fd = -1;
 
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object *object = revs->pending.objects[i].item;
diff --git a/cache-tree.c b/cache-tree.c
index 32772b9..014a7e9 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/config.c b/config.c
index ab46462..2d79ba1 100644
--- a/config.c
+++ b/config.c
@@ -6,6 +6,7 @@
  *
  */
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "exec_cmd.h"
 #include "strbuf.h"
@@ -2056,9 +2057,9 @@ int git_config_set_multivar_in_file(const char *config_filename,
 			MAP_PRIVATE, in_fd, 0);
 		close(in_fd);
 
-		if (chmod(lock->filename.buf, st.st_mode & 07777) < 0) {
+		if (chmod(lock->tempfile.filename.buf, st.st_mode & 07777) < 0) {
 			error("chmod on %s failed: %s",
-				lock->filename.buf, strerror(errno));
+				lock->tempfile.filename.buf, strerror(errno));
 			ret = CONFIG_NO_WRITE;
 			goto out_free;
 		}
@@ -2138,7 +2139,7 @@ out_free:
 	return ret;
 
 write_err_out:
-	ret = write_error(lock->filename.buf);
+	ret = write_error(lock->tempfile.filename.buf);
 	goto out_free;
 
 }
@@ -2239,9 +2240,9 @@ int git_config_rename_section_in_file(const char *config_filename,
 
 	fstat(fileno(config_file), &st);
 
-	if (chmod(lock->filename.buf, st.st_mode & 07777) < 0) {
+	if (chmod(lock->tempfile.filename.buf, st.st_mode & 07777) < 0) {
 		ret = error("chmod on %s failed: %s",
-				lock->filename.buf, strerror(errno));
+				lock->tempfile.filename.buf, strerror(errno));
 		goto out;
 	}
 
@@ -2262,7 +2263,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 				}
 				store.baselen = strlen(new_name);
 				if (!store_write_section(out_fd, new_name)) {
-					ret = write_error(lock->filename.buf);
+					ret = write_error(lock->tempfile.filename.buf);
 					goto out;
 				}
 				/*
@@ -2288,7 +2289,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 			continue;
 		length = strlen(output);
 		if (write_in_full(out_fd, output, length) != length) {
-			ret = write_error(lock->filename.buf);
+			ret = write_error(lock->tempfile.filename.buf);
 			goto out;
 		}
 	}
diff --git a/credential-store.c b/credential-store.c
index f692509..96f258f 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "credential.h"
 #include "string-list.h"
@@ -52,7 +53,7 @@ static void print_entry(struct credential *c)
 static void print_line(struct strbuf *buf)
 {
 	strbuf_addch(buf, '\n');
-	write_or_die(credential_lock.fd, buf->buf, buf->len);
+	write_or_die(credential_lock.tempfile.fd, buf->buf, buf->len);
 }
 
 static void rewrite_credential_file(const char *fn, struct credential *c,
diff --git a/fast-import.c b/fast-import.c
index 6378726..32a3e21 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -153,6 +153,7 @@ Format of STDIN stream:
 
 #include "builtin.h"
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "object.h"
 #include "blob.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index a912935..ec668c8 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "refs.h"
 #include "pkt-line.h"
diff --git a/lockfile.c b/lockfile.c
index 5a93bc7..b453016 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -2,37 +2,8 @@
  * Copyright (c) 2005, Junio C Hamano
  */
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
-#include "sigchain.h"
-
-static struct lock_file *volatile lock_file_list;
-
-static void remove_lock_files(int skip_fclose)
-{
-	pid_t me = getpid();
-
-	while (lock_file_list) {
-		if (lock_file_list->owner == me) {
-			/* fclose() is not safe to call in a signal handler */
-			if (skip_fclose)
-				lock_file_list->fp = NULL;
-			rollback_lock_file(lock_file_list);
-		}
-		lock_file_list = lock_file_list->next;
-	}
-}
-
-static void remove_lock_files_on_exit(void)
-{
-	remove_lock_files(0);
-}
-
-static void remove_lock_files_on_signal(int signo)
-{
-	remove_lock_files(1);
-	sigchain_pop(signo);
-	raise(signo);
-}
 
 /*
  * path = absolute or relative path name
@@ -101,60 +72,17 @@ static void resolve_symlink(struct strbuf *path)
 /* Make sure errno contains a meaningful value on error */
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
-	size_t pathlen = strlen(path);
-
-	if (!lock_file_list) {
-		/* One-time initialization */
-		sigchain_push_common(remove_lock_files_on_signal);
-		atexit(remove_lock_files_on_exit);
-	}
-
-	if (lk->active)
-		die("BUG: cannot lock_file(\"%s\") using active struct lock_file",
-		    path);
-	if (!lk->on_list) {
-		/* Initialize *lk and add it to lock_file_list: */
-		lk->fd = -1;
-		lk->fp = NULL;
-		lk->active = 0;
-		lk->owner = 0;
-		strbuf_init(&lk->filename, pathlen + LOCK_SUFFIX_LEN);
-		lk->next = lock_file_list;
-		lock_file_list = lk;
-		lk->on_list = 1;
-	} else if (lk->filename.len) {
-		/* This shouldn't happen, but better safe than sorry. */
-		die("BUG: lock_file(\"%s\") called with improperly-reset lock_file object",
-		    path);
-	}
+	int fd;
+	struct strbuf filename = STRBUF_INIT;
 
-	if (flags & LOCK_NO_DEREF) {
-		strbuf_add_absolute_path(&lk->filename, path);
-	} else {
-		struct strbuf resolved_path = STRBUF_INIT;
+	strbuf_addstr(&filename, path);
+	if (!(flags & LOCK_NO_DEREF))
+		resolve_symlink(&filename);
 
-		strbuf_add(&resolved_path, path, pathlen);
-		resolve_symlink(&resolved_path);
-		strbuf_add_absolute_path(&lk->filename, resolved_path.buf);
-		strbuf_release(&resolved_path);
-	}
-
-	strbuf_addstr(&lk->filename, LOCK_SUFFIX);
-	lk->fd = open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
-	if (lk->fd < 0) {
-		strbuf_reset(&lk->filename);
-		return -1;
-	}
-	lk->owner = getpid();
-	lk->active = 1;
-	if (adjust_shared_perm(lk->filename.buf)) {
-		int save_errno = errno;
-		error("cannot fix permission bits on %s", lk->filename.buf);
-		rollback_lock_file(lk);
-		errno = save_errno;
-		return -1;
-	}
-	return lk->fd;
+	strbuf_addstr(&filename, LOCK_SUFFIX);
+	fd = create_tempfile(&lk->tempfile, filename.buf);
+	strbuf_release(&filename);
+	return fd;
 }
 
 static int sleep_microseconds(long us)
@@ -302,84 +230,31 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 
 FILE *fdopen_lock_file(struct lock_file *lk, const char *mode)
 {
-	if (!lk->active)
-		die("BUG: fdopen_lock_file() called for unlocked object");
-	if (lk->fp)
-		die("BUG: fdopen_lock_file() called twice for file '%s'", lk->filename.buf);
-
-	lk->fp = fdopen(lk->fd, mode);
-	return lk->fp;
+	return fdopen_tempfile(&lk->tempfile, mode);
 }
 
 char *get_locked_file_path(struct lock_file *lk)
 {
-	if (!lk->active)
+	if (!lk->tempfile.active)
 		die("BUG: get_locked_file_path() called for unlocked object");
-	if (lk->filename.len <= LOCK_SUFFIX_LEN)
+	if (lk->tempfile.filename.len <= LOCK_SUFFIX_LEN)
 		die("BUG: get_locked_file_path() called for malformed lock object");
-	return xmemdupz(lk->filename.buf, lk->filename.len - LOCK_SUFFIX_LEN);
+	return xmemdupz(lk->tempfile.filename.buf, lk->tempfile.filename.len - LOCK_SUFFIX_LEN);
 }
 
 int close_lock_file(struct lock_file *lk)
 {
-	int fd = lk->fd;
-	FILE *fp = lk->fp;
-	int err;
-
-	if (fd < 0)
-		return 0;
-
-	lk->fd = -1;
-	if (fp) {
-		lk->fp = NULL;
-
-		/*
-		 * Note: no short-circuiting here; we want to fclose()
-		 * in any case!
-		 */
-		err = ferror(fp) | fclose(fp);
-	} else {
-		err = close(fd);
-	}
-
-	if (err) {
-		int save_errno = errno;
-		rollback_lock_file(lk);
-		errno = save_errno;
-		return -1;
-	}
-
-	return 0;
+	return close_tempfile(&lk->tempfile);
 }
 
 int reopen_lock_file(struct lock_file *lk)
 {
-	if (0 <= lk->fd)
-		die(_("BUG: reopen a lockfile that is still open"));
-	if (!lk->active)
-		die(_("BUG: reopen a lockfile that has been committed"));
-	lk->fd = open(lk->filename.buf, O_WRONLY);
-	return lk->fd;
+	return reopen_tempfile(&lk->tempfile);
 }
 
 int commit_lock_file_to(struct lock_file *lk, const char *path)
 {
-	if (!lk->active)
-		die("BUG: attempt to commit unlocked object to \"%s\"", path);
-
-	if (close_lock_file(lk))
-		return -1;
-
-	if (rename(lk->filename.buf, path)) {
-		int save_errno = errno;
-		rollback_lock_file(lk);
-		errno = save_errno;
-		return -1;
-	}
-
-	lk->active = 0;
-	strbuf_reset(&lk->filename);
-	return 0;
+	return rename_tempfile(&lk->tempfile, path);
 }
 
 int commit_lock_file(struct lock_file *lk)
@@ -387,16 +262,17 @@ int commit_lock_file(struct lock_file *lk)
 	static struct strbuf result_file = STRBUF_INIT;
 	int err;
 
-	if (!lk->active)
+	if (!lk->tempfile.active)
 		die("BUG: attempt to commit unlocked object");
 
-	if (lk->filename.len <= LOCK_SUFFIX_LEN ||
-	    strcmp(lk->filename.buf + lk->filename.len - LOCK_SUFFIX_LEN, LOCK_SUFFIX))
+	if (lk->tempfile.filename.len <= LOCK_SUFFIX_LEN ||
+	    strcmp(lk->tempfile.filename.buf + lk->tempfile.filename.len - LOCK_SUFFIX_LEN,
+		   LOCK_SUFFIX))
 		die("BUG: lockfile filename corrupt");
 
 	/* remove ".lock": */
-	strbuf_add(&result_file, lk->filename.buf,
-		   lk->filename.len - LOCK_SUFFIX_LEN);
+	strbuf_add(&result_file, lk->tempfile.filename.buf,
+		   lk->tempfile.filename.len - LOCK_SUFFIX_LEN);
 	err = commit_lock_file_to(lk, result_file.buf);
 	strbuf_reset(&result_file);
 	return err;
@@ -404,12 +280,5 @@ int commit_lock_file(struct lock_file *lk)
 
 void rollback_lock_file(struct lock_file *lk)
 {
-	if (!lk->active)
-		return;
-
-	if (!close_lock_file(lk)) {
-		unlink_or_warn(lk->filename.buf);
-		lk->active = 0;
-		strbuf_reset(&lk->filename);
-	}
+	delete_tempfile(&lk->tempfile);
 }
diff --git a/lockfile.h b/lockfile.h
index 4cd03c2..5b313ef 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -29,6 +29,8 @@
  * the file or the new contents of the file (assuming that the
  * filesystem implements `rename(2)` atomically).
  *
+ * Most of the heavy lifting is done by the tempfile module (see
+ * "tempfile.h").
  *
  * Calling sequence
  * ----------------
@@ -74,70 +76,18 @@
  * `hold_lock_file_for_update()` or `hold_lock_file_for_append()`.
  *
  * If the program exits before `commit_lock_file()`,
- * `commit_lock_file_to()`, or `rollback_lock_file()` is called, an
- * `atexit(3)` handler will close and remove the lockfile, thereby
- * rolling back any uncommitted changes.
+ * `commit_lock_file_to()`, or `rollback_lock_file()` is called, the
+ * tempfile module will close and remove the lockfile, thereby rolling
+ * back any uncommitted changes.
  *
  * If you need to close the file descriptor you obtained from a
  * `hold_lock_file_for_*()` function yourself, do so by calling
- * `close_lock_file()`. You should never call `close(2)` or
- * `fclose(3)` yourself, otherwise the `struct lock_file` structure
- * would still think that the file descriptor needs to be closed, and
- * a commit or rollback would result in duplicate calls to `close(2)`.
- * Worse yet, if you close and then later open another file descriptor
- * for a completely different purpose, then a commit or rollback might
- * close that unrelated file descriptor.
+ * `close_lock_file()`. See "tempfile.h" for more information.
  *
  *
- * State diagram and cleanup
- * -------------------------
- *
- * This module keeps track of all locked files in `lock_file_list` for
- * use at cleanup. This list and the `lock_file` objects that comprise
- * it must be kept in self-consistent states at all time, because the
- * program can be interrupted any time by a signal, in which case the
- * signal handler will walk through the list attempting to clean up
- * any open lock files.
- *
- * The possible states of a `lock_file` object are as follows:
- *
- * - Uninitialized. In this state the object's `on_list` field must be
- *   zero but the rest of its contents need not be initialized. As
- *   soon as the object is used in any way, it is irrevocably
- *   registered in `lock_file_list`, and `on_list` is set.
- *
- * - Locked, lockfile open (after `hold_lock_file_for_update()`,
- *   `hold_lock_file_for_append()`, or `reopen_lock_file()`). In this
- *   state:
- *
- *   - the lockfile exists
- *   - `active` is set
- *   - `filename` holds the filename of the lockfile
- *   - `fd` holds a file descriptor open for writing to the lockfile
- *   - `fp` holds a pointer to an open `FILE` object if and only if
- *     `fdopen_lock_file()` has been called on the object
- *   - `owner` holds the PID of the process that locked the file
- *
- * - Locked, lockfile closed (after successful `close_lock_file()`).
- *   Same as the previous state, except that the lockfile is closed
- *   and `fd` is -1.
- *
- * - Unlocked (after `commit_lock_file()`, `commit_lock_file_to()`,
- *   `rollback_lock_file()`, a failed attempt to lock, or a failed
- *   `close_lock_file()`).  In this state:
- *
- *   - `active` is unset
- *   - `filename` is empty (usually, though there are transitory
- *     states in which this condition doesn't hold). Client code should
- *     *not* rely on the filename being empty in this state.
- *   - `fd` is -1
- *   - the object is left registered in the `lock_file_list`, and
- *     `on_list` is set.
- *
- * A lockfile is owned by the process that created it. The `lock_file`
- * has an `owner` field that records the owner's PID. This field is
- * used to prevent a forked process from closing a lockfile created by
- * its parent.
+ * Under the covers, a lockfile is just a tempfile with a few helper
+ * functions. In particular, the state diagram and the cleanup
+ * machinery are all implemented in the tempfile module.
  *
  *
  * Error handling
@@ -156,13 +106,7 @@
  */
 
 struct lock_file {
-	struct lock_file *volatile next;
-	volatile sig_atomic_t active;
-	volatile int fd;
-	FILE *volatile fp;
-	volatile pid_t owner;
-	char on_list;
-	struct strbuf filename;
+	struct tempfile tempfile;
 };
 
 /* String appended to a filename to derive the lockfile name: */
diff --git a/merge-recursive.c b/merge-recursive.c
index 44d85be..2768124 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "advice.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "cache-tree.h"
 #include "commit.h"
diff --git a/merge.c b/merge.c
index fcff632..f23e3e7 100644
--- a/merge.c
+++ b/merge.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "commit.h"
 #include "run-command.h"
diff --git a/read-cache.c b/read-cache.c
index 723d48d..e20e003 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -5,6 +5,7 @@
  */
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "cache-tree.h"
 #include "refs.h"
@@ -2112,7 +2113,7 @@ static int commit_locked_index(struct lock_file *lk)
 static int do_write_locked_index(struct index_state *istate, struct lock_file *lock,
 				 unsigned flags)
 {
-	int ret = do_write_index(istate, lock->fd, 0);
+	int ret = do_write_index(istate, lock->tempfile.fd, 0);
 	if (ret)
 		return ret;
 	assert((flags & (COMMIT_LOCK | CLOSE_LOCK)) !=
diff --git a/refs.c b/refs.c
index a742d79..d98b0f5 100644
--- a/refs.c
+++ b/refs.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "refs.h"
 #include "object.h"
@@ -3178,11 +3179,11 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 		errno = EINVAL;
 		return -1;
 	}
-	if (write_in_full(lock->lk->fd, sha1_to_hex(sha1), 40) != 40 ||
-	    write_in_full(lock->lk->fd, &term, 1) != 1 ||
+	if (write_in_full(lock->lk->tempfile.fd, sha1_to_hex(sha1), 40) != 40 ||
+	    write_in_full(lock->lk->tempfile.fd, &term, 1) != 1 ||
 	    close_ref(lock) < 0) {
 		int save_errno = errno;
-		error("Couldn't write %s", lock->lk->filename.buf);
+		error("Couldn't write %s", lock->lk->tempfile.filename.buf);
 		unlock_ref(lock);
 		errno = save_errno;
 		return -1;
@@ -4239,7 +4240,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
 		if (!cb.newlog) {
 			error("cannot fdopen %s (%s)",
-			      reflog_lock.filename.buf, strerror(errno));
+			      reflog_lock.tempfile.filename.buf, strerror(errno));
 			goto failure;
 		}
 	}
@@ -4264,12 +4265,12 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 			status |= error("couldn't write %s: %s", log_file,
 					strerror(errno));
 		} else if (update &&
-			   (write_in_full(lock->lk->fd,
+			   (write_in_full(lock->lk->tempfile.fd,
 				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
-			 write_str_in_full(lock->lk->fd, "\n") != 1 ||
+			 write_str_in_full(lock->lk->tempfile.fd, "\n") != 1 ||
 			 close_ref(lock) < 0)) {
 			status |= error("couldn't write %s",
-					lock->lk->filename.buf);
+					lock->lk->tempfile.filename.buf);
 			rollback_lock_file(&reflog_lock);
 		} else if (commit_lock_file(&reflog_lock)) {
 			status |= error("unable to commit reflog '%s' (%s)",
diff --git a/rerere.c b/rerere.c
index 94aea9a..c435668 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "string-list.h"
 #include "rerere.h"
diff --git a/sequencer.c b/sequencer.c
index c4f4b7d..d85765f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "sequencer.h"
 #include "dir.h"
diff --git a/sha1_file.c b/sha1_file.c
index 7e38148..1e67e16 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -8,6 +8,7 @@
  */
 #include "cache.h"
 #include "string-list.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "delta.h"
 #include "pack.h"
diff --git a/shallow.c b/shallow.c
index 257d811..59ee321 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "commit.h"
 #include "tag.h"
@@ -267,8 +268,8 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 	if (write_shallow_commits(&sb, 0, extra)) {
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
 			die_errno("failed to write to %s",
-				  shallow_lock->filename.buf);
-		*alternate_shallow_file = shallow_lock->filename.buf;
+				  shallow_lock->tempfile.filename.buf);
+		*alternate_shallow_file = shallow_lock->tempfile.filename.buf;
 	} else
 		/*
 		 * is_repository_shallow() sees empty string as "no
@@ -314,7 +315,7 @@ void prune_shallow(int show_only)
 	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
 			die_errno("failed to write to %s",
-				  shallow_lock.filename.buf);
+				  shallow_lock.tempfile.filename.buf);
 		commit_lock_file(&shallow_lock);
 	} else {
 		unlink(git_path("shallow"));
diff --git a/tempfile.c b/tempfile.c
new file mode 100644
index 0000000..bde7fd3
--- /dev/null
+++ b/tempfile.c
@@ -0,0 +1,166 @@
+#include "cache.h"
+#include "tempfile.h"
+#include "sigchain.h"
+
+static struct tempfile *volatile tempfile_list;
+
+static void remove_tempfiles(int skip_fclose)
+{
+	pid_t me = getpid();
+
+	while (tempfile_list) {
+		if (tempfile_list->owner == me) {
+			/* fclose() is not safe to call in a signal handler */
+			if (skip_fclose)
+				tempfile_list->fp = NULL;
+			delete_tempfile(tempfile_list);
+		}
+		tempfile_list = tempfile_list->next;
+	}
+}
+
+static void remove_tempfiles_on_exit(void)
+{
+	remove_tempfiles(0);
+}
+
+static void remove_tempfiles_on_signal(int signo)
+{
+	remove_tempfiles(1);
+	sigchain_pop(signo);
+	raise(signo);
+}
+
+/* Make sure errno contains a meaningful value on error */
+int create_tempfile(struct tempfile *tempfile, const char *path)
+{
+	size_t pathlen = strlen(path);
+
+	if (!tempfile_list) {
+		/* One-time initialization */
+		sigchain_push_common(remove_tempfiles_on_signal);
+		atexit(remove_tempfiles_on_exit);
+	}
+
+	if (tempfile->active)
+		die("BUG: cannot tempfile(\"%s\") using active struct tempfile",
+		    path);
+	if (!tempfile->on_list) {
+		/* Initialize *tempfile and add it to tempfile_list: */
+		tempfile->fd = -1;
+		tempfile->fp = NULL;
+		tempfile->active = 0;
+		tempfile->owner = 0;
+		strbuf_init(&tempfile->filename, pathlen);
+		tempfile->next = tempfile_list;
+		tempfile_list = tempfile;
+		tempfile->on_list = 1;
+	} else if (tempfile->filename.len) {
+		/* This shouldn't happen, but better safe than sorry. */
+		die("BUG: tempfile(\"%s\") called with improperly-reset tempfile object",
+		    path);
+	}
+
+	strbuf_add_absolute_path(&tempfile->filename, path);
+	tempfile->fd = open(tempfile->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
+	if (tempfile->fd < 0) {
+		strbuf_reset(&tempfile->filename);
+		return -1;
+	}
+	tempfile->owner = getpid();
+	tempfile->active = 1;
+	if (adjust_shared_perm(tempfile->filename.buf)) {
+		int save_errno = errno;
+		error("cannot fix permission bits on %s", tempfile->filename.buf);
+		delete_tempfile(tempfile);
+		errno = save_errno;
+		return -1;
+	}
+	return tempfile->fd;
+}
+
+FILE *fdopen_tempfile(struct tempfile *tempfile, const char *mode)
+{
+	if (!tempfile->active)
+		die("BUG: fdopen_tempfile() called for unlocked object");
+	if (tempfile->fp)
+		die("BUG: fdopen_tempfile() called twice for file '%s'",
+		    tempfile->filename.buf);
+
+	tempfile->fp = fdopen(tempfile->fd, mode);
+	return tempfile->fp;
+}
+
+int close_tempfile(struct tempfile *tempfile)
+{
+	int fd = tempfile->fd;
+	FILE *fp = tempfile->fp;
+	int err;
+
+	if (fd < 0)
+		return 0;
+
+	tempfile->fd = -1;
+	if (fp) {
+		tempfile->fp = NULL;
+
+		/*
+		 * Note: no short-circuiting here; we want to fclose()
+		 * in any case!
+		 */
+		err = ferror(fp) | fclose(fp);
+	} else {
+		err = close(fd);
+	}
+
+	if (err) {
+		int save_errno = errno;
+		delete_tempfile(tempfile);
+		errno = save_errno;
+		return -1;
+	}
+
+	return 0;
+}
+
+int reopen_tempfile(struct tempfile *tempfile)
+{
+	if (0 <= tempfile->fd)
+		die(_("BUG: reopen a temporary file that is still open"));
+	if (!tempfile->active)
+		die(_("BUG: reopen a temporary file that has been removed"));
+	tempfile->fd = open(tempfile->filename.buf, O_WRONLY);
+	return tempfile->fd;
+}
+
+int rename_tempfile(struct tempfile *tempfile, const char *path)
+{
+	if (!tempfile->active)
+		die("BUG: attempt to rename inactive temporary file to \"%s\"", path);
+
+	if (close_tempfile(tempfile))
+		return -1;
+
+	if (rename(tempfile->filename.buf, path)) {
+		int save_errno = errno;
+		delete_tempfile(tempfile);
+		errno = save_errno;
+		return -1;
+	}
+
+	tempfile->active = 0;
+	strbuf_reset(&tempfile->filename);
+	return 0;
+}
+
+void delete_tempfile(struct tempfile *tempfile)
+{
+	if (!tempfile->active)
+		return;
+
+	if (!close_tempfile(tempfile)) {
+		unlink_or_warn(tempfile->filename.buf);
+		tempfile->active = 0;
+		strbuf_reset(&tempfile->filename);
+	}
+}
diff --git a/tempfile.h b/tempfile.h
new file mode 100644
index 0000000..f83deac
--- /dev/null
+++ b/tempfile.h
@@ -0,0 +1,206 @@
+#ifndef TEMPFILE_H
+#define TEMPFILE_H
+
+/*
+ * Handle temporary files.
+ *
+ * The tempfile API allows temporary files to be created, deleted, and
+ * atomically renamed. Temporary files that are still active when the
+ * program ends are cleaned up automatically. Lockfiles (see
+ * "lockfile.h") are built on top of this API.
+ *
+ *
+ * Calling sequence
+ * ----------------
+ *
+ * The caller:
+ *
+ * * Allocates a `struct tempfile` either as a static variable or on
+ *   the heap, initialized to zeros. Once you use the structure to
+ *   call `create_tempfile()`, it belongs to the tempfile subsystem
+ *   and its storage must remain valid throughout the life of the
+ *   program (i.e. you cannot use an on-stack variable to hold this
+ *   structure).
+ *
+ * * Attempts to create a temporary file by calling
+ *   `create_tempfile()`.
+ *
+ * * Writes new content to the file by either:
+ *
+ *   * writing to the file descriptor returned by `create_tempfile()`
+ *     (also available via `tempfile->fd`).
+ *
+ *   * calling `fdopen_tempfile()` to get a `FILE` pointer for the
+ *     open file and writing to the file using stdio.
+ *
+ * When finished writing, the caller can:
+ *
+ * * Close the file descriptor and remove the temporary file by
+ *   calling `delete_tempfile()`.
+ *
+ * * Close the temporary file and rename it atomically to a specified
+ *   filename by calling `rename_tempfile()`. This relinquishes
+ *   control of the file.
+ *
+ * * Close the file descriptor without removing or renaming the
+ *   temporary file by calling `close_tempfile()`, and later call
+ *   `delete_tempfile()` or `rename_tempfile()`.
+ *
+ * Even after the temporary file is renamed or deleted, the `tempfile`
+ * object must not be freed or altered by the caller. However, it may
+ * be reused; just pass it to another call of `create_tempfile()`.
+ *
+ * If the program exits before `rename_tempfile()` or
+ * `delete_tempfile()` is called, an `atexit(3)` handler will close
+ * and remove the temporary file.
+ *
+ * If you need to close the file descriptor yourself, do so by calling
+ * `close_tempfile()`. You should never call `close(2)` or `fclose(3)`
+ * yourself, otherwise the `struct tempfile` structure would still
+ * think that the file descriptor needs to be closed, and a later
+ * cleanup would result in duplicate calls to `close(2)`. Worse yet,
+ * if you close and then later open another file descriptor for a
+ * completely different purpose, then the unrelated file descriptor
+ * might get closed.
+ *
+ *
+ * State diagram and cleanup
+ * -------------------------
+ *
+ * If the program exits while a temporary file is active, we want to
+ * make sure that we remove it. This is done by remembering the active
+ * temporary files in a linked list, `tempfile_list`. An `atexit(3)`
+ * handler and a signal handler are registered, to clean up any active
+ * temporary files.
+ *
+ * Because the signal handler can run at any time, `tempfile_list` and
+ * the `tempfile` objects that comprise it must be kept in
+ * self-consistent states at all times.
+ *
+ * The possible states of a `tempfile` object are as follows:
+ *
+ * - Uninitialized. In this state the object's `on_list` field must be
+ *   zero but the rest of its contents need not be initialized. As
+ *   soon as the object is used in any way, it is irrevocably
+ *   registered in `tempfile_list`, and `on_list` is set.
+ *
+ * - Active, file open (after `create_tempfile()` or
+ *   `reopen_tempfile()`). In this state:
+ *
+ *   - the temporary file exists
+ *   - `active` is set
+ *   - `filename` holds the filename of the temporary file
+ *   - `fd` holds a file descriptor open for writing to it
+ *   - `fp` holds a pointer to an open `FILE` object if and only if
+ *     `fdopen_tempfile()` has been called on the object
+ *   - `owner` holds the PID of the process that created the file
+ *
+ * - Active, file closed (after successful `close_tempfile()`). Same
+ *   as the previous state, except that the temporary file is closed,
+ *   `fd` is -1, and `fp` is `NULL`.
+ *
+ * - Inactive (after `delete_tempfile()`, `rename_tempfile()`, a
+ *   failed attempt to create a temporary file, or a failed
+ *   `close_tempfile()`). In this state:
+ *
+ *   - `active` is unset
+ *   - `filename` is empty (usually, though there are transitory
+ *     states in which this condition doesn't hold). Client code should
+ *     *not* rely on the filename being empty in this state.
+ *   - `fd` is -1 and `fp` is `NULL`
+ *   - the object is left registered in the `tempfile_list`, and
+ *     `on_list` is set.
+ *
+ * A temporary file is owned by the process that created it. The
+ * `tempfile` has an `owner` field that records the owner's PID. This
+ * field is used to prevent a forked process from deleting a temporary
+ * file created by its parent.
+ *
+ *
+ * Error handling
+ * --------------
+ *
+ * `create_tempfile()` returns a file descriptor on success or -1 on
+ * failure. On errors, `errno` describes the reason for failure.
+ *
+ * `delete_tempfile()`, `rename_tempfile()`, and `close_tempfile()`
+ * return 0 on success. On failure they set `errno` appropriately, do
+ * their best to delete the temporary file, and return -1.
+ */
+
+struct tempfile {
+	struct tempfile *volatile next;
+	volatile sig_atomic_t active;
+	volatile int fd;
+	FILE *volatile fp;
+	volatile pid_t owner;
+	char on_list;
+	struct strbuf filename;
+};
+
+/*
+ * Attempt to create a temporary file at the specified `path`. Return
+ * a file descriptor for writing to it, or -1 on error. It is an error
+ * if a file already exists at that path.
+ */
+extern int create_tempfile(struct tempfile *tempfile, const char *path);
+
+/*
+ * Associate a stdio stream with the temporary file (which must still
+ * be open). Return `NULL` (*without* deleting the file) on error. The
+ * stream is closed automatically when `close_tempfile()` is called or
+ * when the file is deleted or renamed.
+ */
+extern FILE *fdopen_tempfile(struct tempfile *tempfile, const char *mode);
+
+/*
+ * If the temporary file is still open, close it (and the file pointer
+ * too, if it has been opened using `fdopen_tempfile()`) without
+ * deleting the file. Return 0 upon success. On failure to `close(2)`,
+ * return a negative value and delete the file. Usually
+ * `delete_tempfile()` or `rename_tempfile()` should eventually be
+ * called if `close_tempfile()` succeeds.
+ */
+extern int close_tempfile(struct tempfile *tempfile);
+
+/*
+ * Re-open a temporary file that has been closed using
+ * `close_tempfile()` but not yet deleted or renamed. This can be used
+ * to implement a sequence of operations like the following:
+ *
+ * * Create temporary file.
+ *
+ * * Write new contents to file, then `close_tempfile()` to cause the
+ *   contents to be written to disk.
+ *
+ * * Pass the name of the temporary file to another program to allow
+ *   it (and nobody else) to inspect or even modify the file's
+ *   contents.
+ *
+ * * `reopen_tempfile()` to reopen the temporary file. Make further
+ *   updates to the contents.
+ *
+ * * `rename_tempfile()` to move the file to its permanent location.
+ */
+extern int reopen_tempfile(struct tempfile *tempfile);
+
+/*
+ * Close the file descriptor and/or file pointer and remove the
+ * temporary file associated with `tempfile`. It is a NOOP to call
+ * `delete_tempfile()` for a `tempfile` object that has already been
+ * deleted or renamed.
+ */
+extern void delete_tempfile(struct tempfile *tempfile);
+
+/*
+ * Close the file descriptor and/or file pointer if they are still
+ * open, and atomically rename the temporary file to `path`. `path`
+ * must be on the same filesystem as the lock file. Return 0 on
+ * success. On failure, delete the temporary file and return -1, with
+ * `errno` set to the value from the failing call to `close(2)` or
+ * `rename(2)`. It is a bug to call `rename_tempfile()` for a
+ * `tempfile` object that is not currently active.
+ */
+extern int rename_tempfile(struct tempfile *tempfile, const char *path);
+
+#endif /* TEMPFILE_H */
diff --git a/test-scrap-cache-tree.c b/test-scrap-cache-tree.c
index 6efee31..c21e575 100644
--- a/test-scrap-cache-tree.c
+++ b/test-scrap-cache-tree.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "tree.h"
 #include "cache-tree.h"
-- 
2.1.4
