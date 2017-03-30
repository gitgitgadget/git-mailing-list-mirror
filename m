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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B2AE20958
	for <e@80x24.org>; Thu, 30 Mar 2017 03:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932530AbdC3Dci (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 23:32:38 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:32968 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932113AbdC3Dch (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 23:32:37 -0400
Received: by mail-qk0-f195.google.com with SMTP id p22so4755273qka.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 20:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=14qSeJ6zt/PNdh26i8+rAwV1fCm8pvkUwdUpGRejbQ0=;
        b=qst31tNpCM4XXbqVXC/RYOvhnKuicoonxWAibKmfqrRhIpJeyvexmawOArM3oCKVkL
         Ai53NjrG6b1CApf9X8HubBfb7CbjM2iKq6KVQ7hF7fISe3/5QT6y9XJIefFxFhzqxz2B
         vspNtrmjOiFOPlXJ7RSOMEnyFBzslI9BtTYZPfd99w3FlRGVyv8zdG1C7lCtQ/Hp+TTP
         B3L7/LMw2wCZN35EJbaKWgB7ZTzTFPIU5hqVCLJv1LWDTlpXcWtIu7Sme73diS+/qWYc
         IIZ+WytuN4DJd672DW7rOSP6q6GrysYgJprgzLT/L8nODqSIvLPgugJOyBXytTP2waMB
         Ymnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=14qSeJ6zt/PNdh26i8+rAwV1fCm8pvkUwdUpGRejbQ0=;
        b=ozLEZRbl/kLbWuUrWcSNtvIinuK0qWpidhxHAsCl+yVKA6dUAP4e5iH7y0aUY/VNpn
         27k+9lD06q2oWwr1NHZC90kol+SnvUFqZuTI94x1e9rJotUD+sYlrpIqhP4WmZcw+hax
         8lzIBW+0PXB3/6IEeeOltpB7KuA/osCTMrC9JsbTom0jkxyC+wM64Z7EmDU2ibJoG3y5
         eK2UtbSbH89woknunAdFeqO86eYwOpqJjelpz7t8re9O5xubFatIG0sV6CCrDZT35Rs3
         DEhpbpa8BhF+iPbasGxjhDlZUi6P63o6iOmFPO/BQcDInUum33VshHGOwZknGKfHG7Qy
         0rcg==
X-Gm-Message-State: AFeK/H3nRzULQGO2KgXfMl2E/6nnNvCOjlpD3DROR2a9u3KTqBmNfxaeB2Xm5z9xuuXooA==
X-Received: by 10.55.195.68 with SMTP id a65mr4342421qkj.62.1490844755383;
        Wed, 29 Mar 2017 20:32:35 -0700 (PDT)
Received: from localhost.localdomain ([201.52.189.180])
        by smtp.gmail.com with ESMTPSA id d136sm624095qke.32.2017.03.29.20.32.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 20:32:34 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v5 3/6] dir_iterator: iterate over dir after its contents
Date:   Thu, 30 Mar 2017 00:32:07 -0300
Message-Id: <1490844730-47634-4-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
References: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
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

Amend a call to dir_iterator_begin() to pass the flags parameter
introduced.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 dir-iterator.c       | 53 ++++++++++++++++++++++++++++++++++++++++++++++++----
 dir-iterator.h       | 17 ++++++++++++-----
 refs/files-backend.c |  2 +-
 3 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index 3ac984b..05d53d2 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -47,6 +47,9 @@ struct dir_iterator_int {
 	 * that will be included in this iteration.
 	 */
 	struct dir_iterator_level *levels;
+
+	/* Holds the flags passed to dir_iterator_begin(). */
+	unsigned flags;
 };
 
 static inline void push_dir_level(struct dir_iterator_int *iter, struct dir_iterator_level *level)
@@ -113,12 +116,14 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 					iter->base.path.buf, strerror(errno));
 				/* Popping the level is handled below */
 			}
-		} else if (S_ISDIR(iter->base.st.st_mode)) {
+		} else if (S_ISDIR(iter->base.st.st_mode) &&
+			!(iter->flags & DIR_ITERATOR_POST_ORDER_TRAVERSAL)) {
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
@@ -152,7 +157,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			de = readdir(level->dir);
 
 			if (!de) {
-				/* This level is exhausted; pop up a level. */
+				/* This level is exhausted  */
 				if (errno) {
 					warning("error reading directory %s: %s",
 						iter->base.path.buf, strerror(errno));
@@ -160,6 +165,32 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 					warning("error closing directory %s: %s",
 						iter->base.path.buf, strerror(errno));
 
+				if (iter->flags & DIR_ITERATOR_POST_ORDER_TRAVERSAL) {
+					/* If we are handling dirpaths after their contents,
+					 * we have to iterate over the directory now that we'll
+					 * have finished iterating into it. */
+					level->dir = NULL;
+
+					if (pop_dir_level(iter) == 0)
+						return dir_iterator_abort(dir_iterator);
+
+					level = &iter->levels[iter->levels_nr - 1];
+					/* Since we are iterating through the dirpath
+					 * after we have gone through it, we still need
+					 * to get rid of the trailing slash we appended.
+					 *
+					 * This may generate issues if we ever want to
+					 * iterate through the root directory AND have
+					 * post-order traversal enabled.
+					 */
+					strbuf_strip_suffix(&iter->base.path, "/");
+
+					if (set_iterator_data(iter, level))
+						continue;
+
+					return ITER_OK;
+				}
+
 				level->dir = NULL;
 				if (pop_dir_level(iter) == 0)
 					return dir_iterator_abort(dir_iterator);
@@ -174,6 +205,18 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			if (set_iterator_data(iter, level))
 				continue;
 
+			/*
+			 * If we want to iterate dirs after files, we shall
+			 * begin looking into them *before* we return the dir
+			 * itself.
+			 */
+			if (S_ISDIR(iter->base.st.st_mode) &&
+				(iter->flags & DIR_ITERATOR_POST_ORDER_TRAVERSAL)) {
+				push_dir_level(iter, level);
+
+				break;
+			}
+
 			return ITER_OK;
 		}
 	}
@@ -200,7 +243,7 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
 	return ITER_DONE;
 }
 
-struct dir_iterator *dir_iterator_begin(const char *path)
+struct dir_iterator *dir_iterator_begin(const char *path, unsigned flags)
 {
 	struct dir_iterator_int *iter = xcalloc(1, sizeof(*iter));
 	struct dir_iterator *dir_iterator = &iter->base;
@@ -208,6 +251,8 @@ struct dir_iterator *dir_iterator_begin(const char *path)
 	if (!path || !*path)
 		die("BUG: empty path passed to dir_iterator_begin()");
 
+	iter->flags = flags;
+
 	strbuf_init(&iter->base.path, PATH_MAX);
 	strbuf_addstr(&iter->base.path, path);
 
diff --git a/dir-iterator.h b/dir-iterator.h
index 27739e6..649ccf6 100644
--- a/dir-iterator.h
+++ b/dir-iterator.h
@@ -11,8 +11,7 @@
  * Every time dir_iterator_advance() is called, update the members of
  * the dir_iterator structure to reflect the next path in the
  * iteration. The order that paths are iterated over within a
- * directory is undefined, but directory paths are always iterated
- * over before the subdirectory contents.
+ * directory is undefined.
  *
  * A typical iteration looks like this:
  *
@@ -38,6 +37,13 @@
  * dir_iterator_advance() again.
  */
 
+/* Possible flags for dir_iterator_begin().
+ *
+ * DIR_ITERATOR_POST_ORDER_TRAVERSAL: ensures subdirectories and
+ * their contents are iterated through before the containing directory.
+ */
+#define DIR_ITERATOR_POST_ORDER_TRAVERSAL (1 << 0)
+
 struct dir_iterator {
 	/* The current path: */
 	struct strbuf path;
@@ -57,15 +63,16 @@ struct dir_iterator {
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
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 50188e9..b4bba74 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3346,7 +3346,7 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
 	files_downcast(ref_store, 0, "reflog_iterator_begin");
 
 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
-	iter->dir_iterator = dir_iterator_begin(git_path("logs"));
+	iter->dir_iterator = dir_iterator_begin(git_path("logs"), 0);
 	return ref_iterator;
 }
 
-- 
2.7.4 (Apple Git-66)

