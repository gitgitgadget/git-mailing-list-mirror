Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFA431FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 23:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753170AbcLHX6c (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 18:58:32 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35726 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753095AbcLHX6b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 18:58:31 -0500
Received: by mail-pg0-f53.google.com with SMTP id p66so834562pga.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 15:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CG9U/8D0+kDFhfYKVlchAd6/KxeYS4Q1T8ylqdWsa7o=;
        b=TVIpHDiOS9mwqTUBxnNModk6D37mEMCcCIJWXinrtZ9hbi+vwmDRl06sO4CksBWBmT
         /QpJt/yKsLlBwqmgooV3SP1zpWgV7u8s5oZ78Mlo43+k90fBWXN3u4+OBBOShADH/TRt
         0IJfTfM+Ue3tD/TqowFZkX7LIfHa0kDKAZpR9+fouFl1y9enKf/ZNISxabCYTkqC0Lsf
         sKB8UweM7gVyA5Qw+DurSys2DL+2IFfJ0YTu/5EEhGrL8NsdgU6K4WFQpvJRnTO8S8H5
         7VhSHFfrL3NXaZaZJmmbpN+anrR5RbVzIKTab7G4R9AkFaMpBHdU6qAz209uOeDTbw5S
         flmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CG9U/8D0+kDFhfYKVlchAd6/KxeYS4Q1T8ylqdWsa7o=;
        b=kozrDE9SFDJJzzO+wtkY0nQ8vlCyYhzH2R2qs7U5KblRKl3VhSQQJLQoFHWNORQsiy
         NSQwM6qktCpxuhz8BKPYbvN+jYKiGCHF+vLTms1MT5w//RrSu/2jYmG4j2VqUe5a736I
         kxC/Kgn935GgdTmFuibf98GBcjOjW5MgTZI8K1igEtxXI3Ufib2WLuefSM0nwM5Us1UJ
         pGKfaxIHUqparchF4DJfZkmDUjtXrK2IcvuPqBpMciuvMy3sSAV9/R0eRALFXcvqN0C6
         b1sbQZCW84eo9h11Q+neTwSzERfu8CsKfSpIwztjRACMzeKYiaAXynHZ6X+vUDeOQPmh
         x4ew==
X-Gm-Message-State: AKaTC009I7csVMLyjgDvDf4m7sV7bgzOi3fEnRtbZWVt4z15uydviUYNibWlxgeHbyhuaYDS
X-Received: by 10.98.147.135 with SMTP id r7mr77137295pfk.117.1481241510665;
        Thu, 08 Dec 2016 15:58:30 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id a7sm52505499pfl.87.2016.12.08.15.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 15:58:29 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, j6t@kdbg.org,
        pclouds@gmail.com
Subject: [PATCH v2 0/4] road to reentrant real_path
Date:   Thu,  8 Dec 2016 15:58:10 -0800
Message-Id: <1481241494-6861-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480964316-99305-1-git-send-email-bmwill@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for all of the comments on v1 of the series.  Hopefully this series
addresses the issues with windows and actually passes the first test :)

Some changes in v2:
* the 1st component of a path should now be handled correctly on windows as well
  as unix.
* Pushed the static strbuf to the callers of real_path_internal
* renamed real_path_internal to strbuf_realpath
* added real_pathdup
* migrated some callers of real_path to real_pathdup and strbuf_realpath

Brandon Williams (4):
  real_path: resolve symlinks by hand
  real_path: convert real_path_internal to strbuf_realpath
  real_path: create real_pathdup
  real_path: have callers use real_pathdup and strbuf_realpath

 abspath.c         | 215 ++++++++++++++++++++++++++++++++++++------------------
 builtin/init-db.c |   6 +-
 cache.h           |   3 +
 environment.c     |   2 +-
 setup.c           |  15 ++--
 sha1_file.c       |   2 +-
 submodule.c       |   2 +-
 transport.c       |   2 +-
 worktree.c        |   2 +-
 9 files changed, 163 insertions(+), 86 deletions(-)

--- interdiff from v1

diff --git a/abspath.c b/abspath.c
index 6f546e0..df37356 100644
--- a/abspath.c
+++ b/abspath.c
@@ -14,13 +14,13 @@ int is_directory(const char *path)
 /* removes the last path component from 'path' except if 'path' is root */
 static void strip_last_component(struct strbuf *path)
 {
-	if (path->len > 1) {
+	if (path->len > offset_1st_component(path->buf)) {
 		char *last_slash = find_last_dir_sep(path->buf);
 		strbuf_setlen(path, last_slash - path->buf);
 	}
 }
 
-/* gets the next component in 'remaining' and places it in 'next' */
+/* get (and remove) the next component in 'remaining' and place it in 'next' */
 static void get_next_component(struct strbuf *next, struct strbuf *remaining)
 {
 	char *start = NULL;
@@ -31,10 +31,10 @@ static void get_next_component(struct strbuf *next, struct strbuf *remaining)
 	/* look for the next component */
 	/* Skip sequences of multiple path-separators */
 	for (start = remaining->buf; is_dir_sep(*start); start++)
-		/* nothing */;
+		; /* nothing */
 	/* Find end of the path component */
 	for (end = start; *end && !is_dir_sep(*end); end++)
-		/* nothing */;
+		; /* nothing */
 
 	strbuf_add(next, start, end - start);
 	/* remove the component from 'remaining' */
@@ -48,21 +48,17 @@ static void get_next_component(struct strbuf *next, struct strbuf *remaining)
  * Return the real path (i.e., absolute path, with symlinks resolved
  * and extra slashes removed) equivalent to the specified path.  (If
  * you want an absolute path but don't mind links, use
- * absolute_path().)  The return value is a pointer to a static
- * buffer.
+ * absolute_path().)  Places the resolved realpath in the provided strbuf.
  *
  * The directory part of path (i.e., everything up to the last
  * dir_sep) must denote a valid, existing directory, but the last
  * component need not exist.  If die_on_error is set, then die with an
  * informative error message if there is a problem.  Otherwise, return
  * NULL on errors (without generating any output).
- *
- * If path is our buffer, then return path, as it's already what the
- * user wants.
  */
-static const char *real_path_internal(const char *path, int die_on_error)
+char *strbuf_realpath(struct strbuf *resolved, const char *path,
+		      int die_on_error)
 {
-	static struct strbuf resolved = STRBUF_INIT;
 	struct strbuf remaining = STRBUF_INIT;
 	struct strbuf next = STRBUF_INIT;
 	struct strbuf symlink = STRBUF_INIT;
@@ -70,10 +66,6 @@ static const char *real_path_internal(const char *path, int die_on_error)
 	int num_symlinks = 0;
 	struct stat st;
 
-	/* We've already done it */
-	if (path == resolved.buf)
-		return path;
-
 	if (!*path) {
 		if (die_on_error)
 			die("The empty string is not a valid path");
@@ -81,17 +73,18 @@ static const char *real_path_internal(const char *path, int die_on_error)
 			goto error_out;
 	}
 
-	strbuf_reset(&resolved);
+	strbuf_reset(resolved);
 
 	if (is_absolute_path(path)) {
 		/* absolute path; start with only root as being resolved */
-		strbuf_addch(&resolved, '/');
-		strbuf_addstr(&remaining, path + 1);
+		int offset = offset_1st_component(path);
+		strbuf_add(resolved, path, offset);
+		strbuf_addstr(&remaining, path + offset);
 	} else {
 		/* relative path; can use CWD as the initial resolved path */
-		if (strbuf_getcwd(&resolved)) {
+		if (strbuf_getcwd(resolved)) {
 			if (die_on_error)
-				die_errno("Could not get current working directory");
+				die_errno("unable to get current working directory");
 			else
 				goto error_out;
 		}
@@ -108,21 +101,21 @@ static const char *real_path_internal(const char *path, int die_on_error)
 			continue; /* '.' component */
 		} else if (next.len == 2 && !strcmp(next.buf, "..")) {
 			/* '..' component; strip the last path component */
-			strip_last_component(&resolved);
+			strip_last_component(resolved);
 			continue;
 		}
 
 		/* append the next component and resolve resultant path */
-		if (resolved.buf[resolved.len - 1] != '/')
-			strbuf_addch(&resolved, '/');
-		strbuf_addbuf(&resolved, &next);
+		if (!is_dir_sep(resolved->buf[resolved->len - 1]))
+			strbuf_addch(resolved, '/');
+		strbuf_addbuf(resolved, &next);
 
-		if (lstat(resolved.buf, &st)) {
+		if (lstat(resolved->buf, &st)) {
 			/* error out unless this was the last component */
 			if (!(errno == ENOENT && !remaining.len)) {
 				if (die_on_error)
 					die_errno("Invalid path '%s'",
-						  resolved.buf);
+						  resolved->buf);
 				else
 					goto error_out;
 			}
@@ -138,29 +131,29 @@ static const char *real_path_internal(const char *path, int die_on_error)
 					goto error_out;
 			}
 
-			len = strbuf_readlink(&symlink, resolved.buf,
+			len = strbuf_readlink(&symlink, resolved->buf,
 					      st.st_size);
 			if (len < 0) {
 				if (die_on_error)
 					die_errno("Invalid symlink '%s'",
-						  resolved.buf);
+						  resolved->buf);
 				else
 					goto error_out;
 			}
 
 			if (is_absolute_path(symlink.buf)) {
-				/*
-				 * absolute symlink
-				 * reset resolved path to root
-				 */
-				strbuf_setlen(&resolved, 1);
+				/* absolute symlink; set resolved to root */
+				int offset = offset_1st_component(symlink.buf);
+				strbuf_reset(resolved);
+				strbuf_add(resolved, symlink.buf, offset);
+				strbuf_remove(&symlink, 0, offset);
 			} else {
 				/*
 				 * relative symlink
 				 * strip off the last component since it will
 				 * be replaced with the contents of the symlink
 				 */
-				strip_last_component(&resolved);
+				strip_last_component(resolved);
 			}
 
 			/*
@@ -180,25 +173,42 @@ static const char *real_path_internal(const char *path, int die_on_error)
 		}
 	}
 
-	retval = resolved.buf;
+	retval = resolved->buf;
 
 error_out:
-	//strbuf_release(&resolved);
 	strbuf_release(&remaining);
 	strbuf_release(&next);
 	strbuf_release(&symlink);
 
+	if (!retval)
+		strbuf_reset(resolved);
+
 	return retval;
 }
 
 const char *real_path(const char *path)
 {
-	return real_path_internal(path, 1);
+	static struct strbuf realpath = STRBUF_INIT;
+	return strbuf_realpath(&realpath, path, 1);
 }
 
 const char *real_path_if_valid(const char *path)
 {
-	return real_path_internal(path, 0);
+	static struct strbuf realpath = STRBUF_INIT;
+	return strbuf_realpath(&realpath, path, 0);
+}
+
+char *real_pathdup(const char *path)
+{
+	struct strbuf realpath = STRBUF_INIT;
+	char *retval = NULL;
+
+	if(strbuf_realpath(&realpath, path, 0))
+		retval = strbuf_detach(&realpath, NULL);
+
+	strbuf_release(&realpath);
+
+	return retval;
 }
 
 /*
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 2399b97..76d68fa 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -338,7 +338,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 {
 	int reinit;
 	int exist_ok = flags & INIT_DB_EXIST_OK;
-	char *original_git_dir = xstrdup(real_path(git_dir));
+	char *original_git_dir = real_pathdup(git_dir);
 
 	if (real_git_dir) {
 		struct stat st;
@@ -489,7 +489,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
 
 	if (real_git_dir && !is_absolute_path(real_git_dir))
-		real_git_dir = xstrdup(real_path(real_git_dir));
+		real_git_dir = real_pathdup(real_git_dir);
 
 	if (argc == 1) {
 		int mkdir_tried = 0;
@@ -560,7 +560,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		const char *git_dir_parent = strrchr(git_dir, '/');
 		if (git_dir_parent) {
 			char *rel = xstrndup(git_dir, git_dir_parent - git_dir);
-			git_work_tree_cfg = xstrdup(real_path(rel));
+			git_work_tree_cfg = real_pathdup(rel);
 			free(rel);
 		}
 		if (!git_work_tree_cfg)
diff --git a/cache.h b/cache.h
index a50a61a..e12a5d9 100644
--- a/cache.h
+++ b/cache.h
@@ -1064,8 +1064,11 @@ static inline int is_absolute_path(const char *path)
 	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
 }
 int is_directory(const char *);
+char *strbuf_realpath(struct strbuf *resolved, const char *path,
+		      int die_on_error);
 const char *real_path(const char *path);
 const char *real_path_if_valid(const char *path);
+char *real_pathdup(const char *path);
 const char *absolute_path(const char *path);
 const char *remove_leading_path(const char *in, const char *prefix);
 const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
diff --git a/environment.c b/environment.c
index 0935ec6..9b943d2 100644
--- a/environment.c
+++ b/environment.c
@@ -259,7 +259,7 @@ void set_git_work_tree(const char *new_work_tree)
 		return;
 	}
 	git_work_tree_initialized = 1;
-	work_tree = xstrdup(real_path(new_work_tree));
+	work_tree = real_pathdup(new_work_tree);
 }
 
 const char *get_git_work_tree(void)
diff --git a/setup.c b/setup.c
index fe572b8..0d9fdd0 100644
--- a/setup.c
+++ b/setup.c
@@ -254,10 +254,12 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
 		if (!is_absolute_path(data.buf))
 			strbuf_addf(&path, "%s/", gitdir);
 		strbuf_addbuf(&path, &data);
-		strbuf_addstr(sb, real_path(path.buf));
+		strbuf_realpath(sb, path.buf, 1);
 		ret = 1;
-	} else
+	} else {
 		strbuf_addstr(sb, gitdir);
+	}
+
 	strbuf_release(&data);
 	strbuf_release(&path);
 	return ret;
@@ -692,7 +694,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
 		if (offset != cwd->len && !is_absolute_path(gitdir))
-			gitdir = xstrdup(real_path(gitdir));
+			gitdir = real_pathdup(gitdir);
 		if (chdir(cwd->buf))
 			die_errno("Could not come back to cwd");
 		return setup_explicit_git_dir(gitdir, cwd, nongit_ok);
@@ -800,11 +802,12 @@ static int canonicalize_ceiling_entry(struct string_list_item *item,
 		/* Keep entry but do not canonicalize it */
 		return 1;
 	} else {
-		const char *real_path = real_path_if_valid(ceil);
-		if (!real_path)
+		char *real_path = real_pathdup(ceil);
+		if (!real_path) {
 			return 0;
+		}
 		free(item->string);
-		item->string = xstrdup(real_path);
+		item->string = real_path;
 		return 1;
 	}
 }
diff --git a/sha1_file.c b/sha1_file.c
index 9c86d19..6a03cc3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -291,7 +291,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	struct strbuf pathbuf = STRBUF_INIT;
 
 	if (!is_absolute_path(entry) && relative_base) {
-		strbuf_addstr(&pathbuf, real_path(relative_base));
+		strbuf_realpath(&pathbuf, relative_base, 1);
 		strbuf_addch(&pathbuf, '/');
 	}
 	strbuf_addstr(&pathbuf, entry);
diff --git a/submodule.c b/submodule.c
index 6f7d883..c85ba50 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1227,7 +1227,7 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
-	const char *real_work_tree = xstrdup(real_path(work_tree));
+	const char *real_work_tree = real_pathdup(work_tree);
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
diff --git a/transport.c b/transport.c
index d57e8de..236c6f6 100644
--- a/transport.c
+++ b/transport.c
@@ -1130,7 +1130,7 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
 	const struct ref *extra;
 	struct alternate_refs_data *cb = data;
 
-	other = xstrdup(real_path(e->path));
+	other = real_pathdup(e->path);
 	len = strlen(other);
 
 	while (other[len-1] == '/')
diff --git a/worktree.c b/worktree.c
index f7869f8..c90e013 100644
--- a/worktree.c
+++ b/worktree.c
@@ -255,7 +255,7 @@ struct worktree *find_worktree(struct worktree **list,
 		return wt;
 
 	arg = prefix_filename(prefix, strlen(prefix), arg);
-	path = xstrdup(real_path(arg));
+	path = real_pathdup(arg);
 	for (; *list; list++)
 		if (!fspathcmp(path, real_path((*list)->path)))
 			break;

-- 
2.8.0.rc3.226.g39d4020

