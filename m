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
	by dcvr.yhbt.net (Postfix) with ESMTP id C82B21FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 13:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763544AbdDSNPc (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 09:15:32 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36708 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763541AbdDSNPb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 09:15:31 -0400
Received: by mail-qt0-f195.google.com with SMTP id t52so3094115qtb.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 06:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IzckXmmtgGPmh+66tbntWw9fTo+H/usQddtPP7Qzyk8=;
        b=KuX2NV1UVf35Qcv2F+rG6GtMZbTFKYXhZekbbQFWXUvGW2l7GPjxK2Kwy8uJsq06GP
         Hp0Ib8OtCR5bJGRyesMdjrbQFQVlTq3C7IiuiDROF0oi3M1CQF+RmFwDJhLnsvm9nAuL
         vF+lzhXKO/CUY9z/9CpOw2u9qA85UAq5Xu7BmQ3fjgFlZx8zAJkYU3FMzw4liKTUXJ4o
         Q3zn7XtUr6kY5ifuDi5v10eOHwBvlwz21Q2msf3aF0Fi6GJtKsOymDd34JxP7w17xNQx
         KlJ/UyEBir/1PD/mIjoQu1UEP/9+6OFcy9+Kmj9iNJZZXkE/uE2m3cByCNVGRqTGIBWS
         b1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IzckXmmtgGPmh+66tbntWw9fTo+H/usQddtPP7Qzyk8=;
        b=Aa2EsIjTV7smnqlwbmkqWSbUJ+7ofAqZRlEmmyhgaov6Qb518K1zrd0poPm3iwCGhm
         lqGUUnw75CBzHXz9qEbasI7APYfkosbixZxWyXogX4yW1GUFVpGe8skk/SomOwC8yS+h
         iyOpgGSVkLIbLKpmJuVm+o0On7pagBITvvH5lgT+r4JWK+Lmn9cNbgZ1Bzasshfn8FAb
         KxXOrHcXo6R8z/gpIy4XOIpX/qh1xRS6M/Iuvu8TqD9havYKWqHMUH7EY8JNutsj5jlC
         0g5kEH2IDeRd9EZO4SEsLaOpTLoIMjit2o/yhoggIo5y7xc8NotE0fer2NgLW8LDp7Gk
         zW6Q==
X-Gm-Message-State: AN3rC/4bgyQF3GdkiagXaoa+Av+kz6tPw3/haar+El1X9dY5No7aWOFO
        nhkCIME+NkV/NA==
X-Received: by 10.237.59.198 with SMTP id s6mr2315034qte.126.1492607729895;
        Wed, 19 Apr 2017 06:15:29 -0700 (PDT)
Received: from localhost.localdomain ([201.52.189.180])
        by smtp.gmail.com with ESMTPSA id k133sm1835587qke.25.2017.04.19.06.15.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 19 Apr 2017 06:15:29 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v10 3/5] dir_iterator: refactor dir_iterator_advance
Date:   Wed, 19 Apr 2017 10:14:10 -0300
Message-Id: <1492607652-36341-4-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1492607652-36341-1-git-send-email-bnmvco@gmail.com>
References: <1492607652-36341-1-git-send-email-bnmvco@gmail.com>
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

