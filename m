Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A4652095E
	for <e@80x24.org>; Sat, 25 Mar 2017 18:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbdCYSUW (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 14:20:22 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36084 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbdCYSUV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 14:20:21 -0400
Received: by mail-qt0-f194.google.com with SMTP id n37so2676591qtb.3
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 11:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8ZTwts1apdBTluPiQrf76EQuq5xzKrjYiSdv+FsgsMU=;
        b=FzTdMeyb9wD2XRLmgk+5alyrK6btqNA1/vea2bTVmuhOW6B/0J8bEv6x6b/KG0z1NJ
         wLojQbznvR+zsffH7fK+afsL4Kfx6Y2k688YtW/z3SFX9Q8LyJ84adX4HvnSnarGfzvE
         SydcebvT5T2E++G1OspO21lXqM3ZzFVpmUyPcbKAPPk2g/hu6h1SjxVxDuE72fS9ksy0
         kXI9uTzXHFMTy91DoIYrlBQK/XFdXvXk0H4O+7F/+UgtK95N8XXLJsq+0Dz+7AAZFLaQ
         5Zc9AjXL/0NJwHSrppkSi+8l3lLO1/gQyw5phpasrJ/zBPC0qy+C1u9n9lW5E67/IvBL
         7+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8ZTwts1apdBTluPiQrf76EQuq5xzKrjYiSdv+FsgsMU=;
        b=MfmVk/+z3k+KkKEsm8OYmP+gbzhjVUHEBYzh6eiEv+nmaWFGp9jXTctJmg9ThpCBRC
         f/vdEd2zT//povoG7Ydk9wAzBtgklDGA2sFhE12pkTt72qjXnSQOjRNwJR/iqgHKgwmj
         zKVyi92IeOS5o6rUbe1V8b2a7A9PSAxzzux9f75Tv9h3IE2d+UpiOjHDlomQfI7085o1
         Ljvp+y/o0S7tiwdslJpurU6qdlWs5YnA3+YvXhPPmu963OWTQum4ZA3Y5aADZamALlDK
         94qeX720O4gxDPyMCjhjbO4z+wTDshnVxwxBRgIEkNX9LxXOni+TZ7R39JsO1Oxepz3/
         f/XA==
X-Gm-Message-State: AFeK/H3snD+jGnbUwnExigLZzGMUmPCiNnOcY1weR0GogYmTkOB5ylfcRjQlphWyNg/76g==
X-Received: by 10.200.44.138 with SMTP id 10mr14657014qtw.12.1490465605914;
        Sat, 25 Mar 2017 11:13:25 -0700 (PDT)
Received: from localhost.localdomain ([189.103.231.223])
        by smtp.gmail.com with ESMTPSA id 141sm4197861qkj.1.2017.03.25.11.13.21
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 25 Mar 2017 11:13:24 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v3 1/2] [GSoC] dir_iterator: iterate over dir after its contents
Date:   Sat, 25 Mar 2017 15:12:30 -0300
Message-Id: <1490465551-71056-2-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1490465551-71056-1-git-send-email-bnmvco@gmail.com>
References: <1490465551-71056-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create an option for the dir_iterator API to iterate over a directory
path only after having iterated through its contents. This feature was
predicted, although not implemented by 0fe5043 ("dir_iterator: new API
for iterating over a directory tree", 2016-06-18).

This is useful for recursively removing a directory and calling rmdir()
on a directory only after all of its contents have been wiped.

An "options" member has been added to the dir_iterator struct. It
contains the "iterate_dirs_after_files" flag, that enables the feature
when set to 1. Default behavior continues to be iterating over directory
paths before its contents.

Two inline functions have been added to dir_iterator's code to avoid
code repetition inside dir_iterator_advance() and make code more clear.

No particular functions or wrappers for setting the options struct's
fields have been added to avoid either breaking the current dir_iterator
API or over-engineering an extremely simple option architecture.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 dir-iterator.c | 100 ++++++++++++++++++++++++++++++++++++++++++++-------------
 dir-iterator.h |   7 ++++
 2 files changed, 84 insertions(+), 23 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index 34182a9..833d56a 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -50,6 +50,43 @@ struct dir_iterator_int {
 	struct dir_iterator_level *levels;
 };

+static inline void push_dir_level(struct dir_iterator_int *iter, struct dir_iterator_level *level)
+{
+	level->dir_state = DIR_STATE_RECURSE;
+	ALLOC_GROW(iter->levels, iter->levels_nr + 1,
+		   iter->levels_alloc);
+	level = &iter->levels[iter->levels_nr++];
+	level->initialized = 0;
+}
+
+static inline int pop_dir_level(struct dir_iterator_int *iter, struct dir_iterator_level *level)
+{
+	return --iter->levels_nr;
+}
+
+static inline int set_iterator_data(struct dir_iterator_int *iter, struct dir_iterator_level *level)
+{
+	if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
+		if (errno != ENOENT)
+			warning("error reading path '%s': %s",
+				iter->base.path.buf,
+				strerror(errno));
+		return -1;
+	}
+
+	/*
+	 * We have to set these each time because
+	 * the path strbuf might have been realloc()ed.
+	 */
+	iter->base.relative_path =
+		iter->base.path.buf + iter->levels[0].prefix_len;
+	iter->base.basename =
+		iter->base.path.buf + level->prefix_len;
+	level->dir_state = DIR_STATE_ITER;
+
+	return 0;
+}
+
 int dir_iterator_advance(struct dir_iterator *dir_iterator)
 {
 	struct dir_iterator_int *iter =
@@ -77,18 +114,16 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			}

 			level->initialized = 1;
-		} else if (S_ISDIR(iter->base.st.st_mode)) {
+		} else if (S_ISDIR(iter->base.st.st_mode) &&
+		!iter->base.options.iterate_dirs_after_files) {
 			if (level->dir_state == DIR_STATE_ITER) {
 				/*
 				 * The directory was just iterated
 				 * over; now prepare to iterate into
-				 * it.
+				 * it (unless an option is set for us
+				 * to do otherwise).
 				 */
-				level->dir_state = DIR_STATE_RECURSE;
-				ALLOC_GROW(iter->levels, iter->levels_nr + 1,
-					   iter->levels_alloc);
-				level = &iter->levels[iter->levels_nr++];
-				level->initialized = 0;
+				push_dir_level(iter, level);
 				continue;
 			} else {
 				/*
@@ -104,7 +139,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			 * This level is exhausted (or wasn't opened
 			 * successfully); pop up a level.
 			 */
-			if (--iter->levels_nr == 0)
+			if (pop_dir_level(iter, level) == 0)
 				return dir_iterator_abort(dir_iterator);

 			continue;
@@ -120,16 +155,33 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			de = readdir(level->dir);

 			if (!de) {
-				/* This level is exhausted; pop up a level. */
+				/* This level is exhausted  */
 				if (errno) {
 					warning("error reading directory %s: %s",
 						iter->base.path.buf, strerror(errno));
+				} else if (iter->base.options.iterate_dirs_after_files) {
+					/* If we are handling dirpaths after their contents,
+					 * we have to iterate over the directory now that we'll
+					 * have finished iterating into it. */
+					level->dir = NULL;
+
+					if (pop_dir_level(iter, level) == 0)
+						return dir_iterator_abort(dir_iterator);
+
+					level = &iter->levels[iter->levels_nr - 1];
+					/* Remove a trailing slash */
+					strbuf_strip_suffix(&iter->base.path, "/");
+
+					if (set_iterator_data(iter, level))
+						continue;
+
+					return ITER_OK;
 				} else if (closedir(level->dir))
 					warning("error closing directory %s: %s",
 						iter->base.path.buf, strerror(errno));

 				level->dir = NULL;
-				if (--iter->levels_nr == 0)
+				if (pop_dir_level(iter, level) == 0)
 					return dir_iterator_abort(dir_iterator);
 				break;
 			}
@@ -138,26 +190,26 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 				continue;

 			strbuf_addstr(&iter->base.path, de->d_name);
-			if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
-				if (errno != ENOENT)
-					warning("error reading path '%s': %s",
-						iter->base.path.buf,
-						strerror(errno));
+
+			if (set_iterator_data(iter, level))
 				continue;
-			}

 			/*
-			 * We have to set these each time because
-			 * the path strbuf might have been realloc()ed.
+			 * If we want to iterate dirs after files, we shall
+			 * begin looking into them *before* we return the dir
+			 * itself.
 			 */
-			iter->base.relative_path =
-				iter->base.path.buf + iter->levels[0].prefix_len;
-			iter->base.basename =
-				iter->base.path.buf + level->prefix_len;
-			level->dir_state = DIR_STATE_ITER;
+			if (S_ISDIR(iter->base.st.st_mode) &&
+			iter->base.options.iterate_dirs_after_files) {
+				push_dir_level(iter, level);
+				goto continue_outer_loop;
+			}

 			return ITER_OK;
 		}
+
+continue_outer_loop:
+		;
 	}
 }

@@ -190,6 +242,8 @@ struct dir_iterator *dir_iterator_begin(const char *path)
 	if (!path || !*path)
 		die("BUG: empty path passed to dir_iterator_begin()");

+	iter->base.options.iterate_dirs_after_files = 0;
+
 	strbuf_init(&iter->base.path, PATH_MAX);
 	strbuf_addstr(&iter->base.path, path);

diff --git a/dir-iterator.h b/dir-iterator.h
index 27739e6..4304913 100644
--- a/dir-iterator.h
+++ b/dir-iterator.h
@@ -38,7 +38,14 @@
  * dir_iterator_advance() again.
  */

+struct dir_iterator_options {
+	unsigned iterate_dirs_after_files : 1;
+};
+
 struct dir_iterator {
+	/* Options for dir_iterator */
+	struct dir_iterator_options options;
+
 	/* The current path: */
 	struct strbuf path;

--
2.7.4 (Apple Git-66)

