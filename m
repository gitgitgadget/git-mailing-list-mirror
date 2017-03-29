Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEDFE1FAFB
	for <e@80x24.org>; Wed, 29 Mar 2017 00:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932739AbdC2Acr (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 20:32:47 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34882 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932718AbdC2Acn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 20:32:43 -0400
Received: by mail-qt0-f194.google.com with SMTP id r5so123074qtb.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 17:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CnBgHdhDXkmmbU8Q1EIn7qWa9L7LHjOwdvwv0ew1atQ=;
        b=IC/PwenYFEuuypZKeGYKS5KJ5zilnQ8DYNsklbWAsNQL5esZZ/Lmavlh6/qSguMnUr
         7eAzbKttlWhQvWSDJGo3QVrHtLTybpzfBLd/myCBWYbWkKGDBJb9AAuZYy5oroE43XBT
         hDtIbrhZB56rB7FJzqmKisde1nY5LGskLBEDe37hgcj3MIXIeEQqfxpgKVPFWS747w+l
         gFgXvpHr7fG7ed4XKCXb75SCvxSBfjy732EgHFv06/fuu5utWvxNnG472oaqtBHHw8VU
         GUI986nYIxC2wFj4tHu661TltdY60JZcgGGZrqgwtPRuVGHk4DgyE3PGjBu3EbuD28HX
         VDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CnBgHdhDXkmmbU8Q1EIn7qWa9L7LHjOwdvwv0ew1atQ=;
        b=OJoSoWp5IB1swItP6gujC0wb2YPg8Ts5MPryE8VZooIzgR7fIJyvefP+VFnYYzau77
         9cw/aNwUCTrrzn3n1U9gmgdkJK4tEcJqSDoW4W4nZadvj3hqG9h/C38008z2C1sp+UEY
         XMbOrHKApyo+QN+qX4C1/V6CdsldDwOqujO+1CSlBx1JxFQoDzN426q1n2vHJgKFYi5I
         4bBGCa/yTA6e/Rb4YbH6qU6FFFgcKbZvCbis+07U31rGoxamApuprIkw04J9vJCLtSGq
         c0SGwsLDl0LREET0rkgUAtnn60O2zLaztQItWnb3zPSdjay+y+m9fcooN1SIEl706WsI
         Ywwg==
X-Gm-Message-State: AFeK/H0qxM8oAlIWM9OG6RinjRz1qAfdkYabyRVmA4hDOjSGPjh2XITdKC1iqDdykU8/jw==
X-Received: by 10.200.55.55 with SMTP id o52mr28493528qtb.279.1490747556603;
        Tue, 28 Mar 2017 17:32:36 -0700 (PDT)
Received: from Daniels-MacBook-Pro.local.net ([187.11.121.49])
        by smtp.gmail.com with ESMTPSA id x26sm3819420qtx.47.2017.03.28.17.32.33
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 28 Mar 2017 17:32:35 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v4 2/5] dir_iterator: iterate over dir after its contents
Date:   Tue, 28 Mar 2017 21:32:10 -0300
Message-Id: <1490747533-89143-3-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
References: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create an option for the dir_iterator API to iterate over subdirectories
only after having iterated through their contents. This feature was
predicted, although not implemented by 0fe5043 ("dir_iterator: new API
for iterating over a directory tree", 2016-06-18).

Add the "flags" parameter to dir_iterator_create, allowing for the
aforementioned "depth-first" iteration mode to be enabled. Currently,
the only acceptable flag is DIR_ITERATOR_DEPTH_FIRST.

This is useful for recursively removing a directory and calling rmdir()
on a directory only after all of its contents have been wiped.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 dir-iterator.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
 dir-iterator.h | 14 +++++++++++---
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index 853c040..545d333 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -48,6 +48,9 @@ struct dir_iterator_int {
 	 * that will be included in this iteration.
 	 */
 	struct dir_iterator_level *levels;
+
+	/* Holds the flags passed to dir_iterator_begin(). */
+	unsigned flags;
 };

 static inline void push_dir_level(struct dir_iterator_int *iter, struct dir_iterator_level *level)
@@ -114,12 +117,14 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			}

 			level->initialized = 1;
-		} else if (S_ISDIR(iter->base.st.st_mode)) {
+		} else if (S_ISDIR(iter->base.st.st_mode) &&
+		!iter->flags & DIR_ITERATOR_DEPTH_FIRST) {
 			if (level->dir_state == DIR_STATE_ITER) {
 				/*
 				 * The directory was just iterated
 				 * over; now prepare to iterate into
-				 * it.
+				 * it (unless an option is set for us
+				 * to do otherwise).
 				 */
 				push_dir_level(iter, level);
 				continue;
@@ -153,10 +158,27 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			de = readdir(level->dir);

 			if (!de) {
-				/* This level is exhausted; pop up a level. */
+				/* This level is exhausted  */
 				if (errno) {
 					warning("error reading directory %s: %s",
 						iter->base.path.buf, strerror(errno));
+				} else if (iter->flags & DIR_ITERATOR_DEPTH_FIRST) {
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
@@ -175,8 +197,22 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			if (set_iterator_data(iter, level))
 				continue;

+			/*
+			 * If we want to iterate dirs after files, we shall
+			 * begin looking into them *before* we return the dir
+			 * itself.
+			 */
+			if (S_ISDIR(iter->base.st.st_mode) &&
+			iter->flags & DIR_ITERATOR_DEPTH_FIRST) {
+				push_dir_level(iter, level);
+				goto continue_outer_loop;
+			}
+
 			return ITER_OK;
 		}
+
+continue_outer_loop:
+		;
 	}
 }

@@ -201,7 +237,7 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
 	return ITER_DONE;
 }

-struct dir_iterator *dir_iterator_begin(const char *path)
+struct dir_iterator *dir_iterator_begin(const char *path, unsigned flags)
 {
 	struct dir_iterator_int *iter = xcalloc(1, sizeof(*iter));
 	struct dir_iterator *dir_iterator = &iter->base;
@@ -209,6 +245,8 @@ struct dir_iterator *dir_iterator_begin(const char *path)
 	if (!path || !*path)
 		die("BUG: empty path passed to dir_iterator_begin()");

+	iter->flags = flags;
+
 	strbuf_init(&iter->base.path, PATH_MAX);
 	strbuf_addstr(&iter->base.path, path);

diff --git a/dir-iterator.h b/dir-iterator.h
index 27739e6..28ff3df 100644
--- a/dir-iterator.h
+++ b/dir-iterator.h
@@ -38,6 +38,13 @@
  * dir_iterator_advance() again.
  */

+/* Possible flags for dir_iterator_begin().
+ *
+ * DIR_ITERATOR_DEPTH_FIRST: ensures subdirectories and their contents
+ * are iterated through before the containing directory.
+ */
+#define DIR_ITERATOR_DEPTH_FIRST (1 << 1)
+
 struct dir_iterator {
 	/* The current path: */
 	struct strbuf path;
@@ -57,15 +64,16 @@ struct dir_iterator {
 };

 /*
- * Start a directory iteration over path. Return a dir_iterator that
- * holds the internal state of the iteration.
+ * Start a directory iteration over path, with options specified in
+ * 'flags'. Return a dir_iterator that holds the internal state of
+ * the iteration.
  *
  * The iteration includes all paths under path, not including path
  * itself and not including "." or ".." entries.
  *
  * path is the starting directory. An internal copy will be made.
  */
-struct dir_iterator *dir_iterator_begin(const char *path);
+struct dir_iterator *dir_iterator_begin(const char *path, unsigned flags);

 /*
  * Advance the iterator to the first or next item and return ITER_OK.
--
2.7.4 (Apple Git-66)

