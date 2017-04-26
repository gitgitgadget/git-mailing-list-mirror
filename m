Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA9B207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 17:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752838AbdDZREE (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 13:04:04 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36372 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbdDZRD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 13:03:57 -0400
Received: by mail-pf0-f196.google.com with SMTP id v14so1366091pfd.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IzckXmmtgGPmh+66tbntWw9fTo+H/usQddtPP7Qzyk8=;
        b=cloMx73OqpcNlux8SNyD/U/39M9kyRJoTyfnSzwQ1xDi9lHJlJE8LutY2xewBIj7/V
         +C0vtf7ZLI6KiSOOHzBnG5kPkQUCfjxbztuGSWAvGoYkO21ZbvcN4eTuDvURyK2OKnXt
         1lnVk14YrKLlidPgtmhD38VPSi5UtcSR+BzVHbPqI29+xT7yV93YPiv7bOS+GgnUXh4e
         BGeoXwoqg+z7SpXOoEVeLSBtL5MgfTn7CV6oLa1PFSGXegdOYso3hyuz8qIexFVT0vTA
         vv9nSHIGKuq4lyQWrI2GsPetLjSKClEdL56G5lX1YY3uEx84lnw4fYNjemBVuDkV1VKH
         lvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IzckXmmtgGPmh+66tbntWw9fTo+H/usQddtPP7Qzyk8=;
        b=DKwGB455oN9wCuQG1aycdbnYXWvfbiNVC1t6zdNLtNPWIuuBYGU+GTSUOYiuSljKpd
         aFxp9r+Eur3zcFtDCSfFo9EHE/PrMau9JvBUgQwXGlhF7s2iaZghrUjQUTzscyrNUDP8
         PZTPIPbqycM+HWT/U8otMPmzxZrGvxgxjXJ7zfnyItdEWdSRoNpWuO8/Go5B8IxQJGuB
         ZXGgPfIibF1lZs189Vumrzh0oOeXCqeQ5TKxZWnS64Vfr0XmW5sgrZGd7ebEfRctF2+F
         aurmDxQbwHds2lOVn7agngP2DJK2uxcgoX+pRZ9phxnLCXAueM2pFc9fxvXUc0HOijpB
         ut4A==
X-Gm-Message-State: AN3rC/41OJzNeV5YYN55RN3ncT85obTEgoDRUmP2pq65pQjHlxQD0PZS
        QccZr/8MdGT3ZA==
X-Received: by 10.98.95.197 with SMTP id t188mr815807pfb.229.1493226236383;
        Wed, 26 Apr 2017 10:03:56 -0700 (PDT)
Received: from Daniels-MacBook-Pro.local.net (c-76-102-227-215.hsd1.ca.comcast.net. [76.102.227.215])
        by smtp.gmail.com with ESMTPSA id q70sm1376479pgq.45.2017.04.26.10.03.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 10:03:55 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v11 3/5] dir_iterator: refactor dir_iterator_advance
Date:   Wed, 26 Apr 2017 10:03:37 -0700
Message-Id: <1493226219-33423-4-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1493226219-33423-1-git-send-email-bnmvco@gmail.com>
References: <1493226219-33423-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out reusable helpers out of dir_iterator_advance(). Make
dir_iterator_advance()'s code more legible and allow some behavior to
be reusable.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 dir-iterator.c | 66 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index 34182a9..d168cb2 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -50,6 +50,44 @@ struct dir_iterator_int {
 	struct dir_iterator_level *levels;
 };
 
+static void push_dir_level(struct dir_iterator_int *iter, struct dir_iterator_level *level)
+{
+	level->dir_state = DIR_STATE_RECURSE;
+	ALLOC_GROW(iter->levels, iter->levels_nr + 1,
+		   iter->levels_alloc);
+	level = &iter->levels[iter->levels_nr++];
+	level->initialized = 0;
+}
+
+static int pop_dir_level(struct dir_iterator_int *iter)
+{
+	return --iter->levels_nr;
+}
+
+static int adjust_iterator_data(struct dir_iterator_int *iter,
+		struct dir_iterator_level *level)
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
@@ -84,11 +122,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 				 * over; now prepare to iterate into
 				 * it.
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
@@ -104,7 +138,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			 * This level is exhausted (or wasn't opened
 			 * successfully); pop up a level.
 			 */
-			if (--iter->levels_nr == 0)
+			if (pop_dir_level(iter) == 0)
 				return dir_iterator_abort(dir_iterator);
 
 			continue;
@@ -129,7 +163,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 						iter->base.path.buf, strerror(errno));
 
 				level->dir = NULL;
-				if (--iter->levels_nr == 0)
+				if (pop_dir_level(iter) == 0)
 					return dir_iterator_abort(dir_iterator);
 				break;
 			}
@@ -138,23 +172,9 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 				continue;
 
 			strbuf_addstr(&iter->base.path, de->d_name);
-			if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
-				if (errno != ENOENT)
-					warning("error reading path '%s': %s",
-						iter->base.path.buf,
-						strerror(errno));
-				continue;
-			}
 
-			/*
-			 * We have to set these each time because
-			 * the path strbuf might have been realloc()ed.
-			 */
-			iter->base.relative_path =
-				iter->base.path.buf + iter->levels[0].prefix_len;
-			iter->base.basename =
-				iter->base.path.buf + level->prefix_len;
-			level->dir_state = DIR_STATE_ITER;
+			if (adjust_iterator_data(iter, level))
+				continue;
 
 			return ITER_OK;
 		}
-- 
2.7.4 (Apple Git-66)

