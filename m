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
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A8820958
	for <e@80x24.org>; Thu, 30 Mar 2017 03:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932329AbdC3Dcb (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 23:32:31 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34804 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932113AbdC3Dca (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 23:32:30 -0400
Received: by mail-qk0-f193.google.com with SMTP id 10so4769172qkh.1
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 20:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hjc3s3MRlBN6r/F8mwYpVVHD2QcZKf8MuhcOpW7hH8A=;
        b=isvQg86W1ugfqivYvnRxJY1UmUzqP3BaxDGWcQQ2yId0TWANCECSVHImkS1IF4S/lP
         24bv9s5ba//CH/39A6tbWUNpsc2u/hwbxxdRNR4y2ZlbPjyto88hiFLdRVTVdqM0/eOL
         UfEw9T73b5HBENt+WQErJYSHjuH2LZ1sWElUBB/Vv9pn30Uckeyn7AdHYiqEEqZfgRpN
         k4bYIjjWmB+V7IZs+nBFJgLTc8WbxlRpm3U3Fkj0UP1dN9ujF1ldIBpqdX1A1GTh6saF
         zSb+jOgjGGDTmVO8d14NhD+r1vUkCYd6zfUXsJp3asft6fW0SQ+4OWDf3KwCSqca72CU
         aWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hjc3s3MRlBN6r/F8mwYpVVHD2QcZKf8MuhcOpW7hH8A=;
        b=tgonmO5oTcId0O6DU8sdm2/RGDGcKU62AVcU9Qp0f4Vw7Oif/YTX2tpoCrPLHGgU/o
         LvGGnzX8qo/xjcr3lPP5o3UspidXpMRh/vUee4nUNyVeT/ZitfBNLN91lFSqcENMNdFw
         2OYJON2utFZm440iZ5uDuJhrFmmGohkocIcpq7uu5BKyXZ2wThXD+umpn2CKuh5/nH+8
         5AuxVfwxxkoehJdej8igh5ZuW5X6IvcAhpWlTGmEWUy3V+/rgz5zAkOXJEvNOdVZxGOM
         jZ4TCDuCIy5YZUYzpZn1bF22zYhORoKWPJ8xInGWZWVHB9vKNUPmsI7WjSomJJ0Kjgu8
         RMXw==
X-Gm-Message-State: AFeK/H3NztzKDSj2KO34ggNYow205xyu+IhyQ660BTME6vJzrgt8bLXQFQ8ESoJXqlpj6Q==
X-Received: by 10.55.22.16 with SMTP id g16mr4444307qkh.102.1490844748912;
        Wed, 29 Mar 2017 20:32:28 -0700 (PDT)
Received: from localhost.localdomain ([201.52.189.180])
        by smtp.gmail.com with ESMTPSA id d136sm624095qke.32.2017.03.29.20.32.25
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 20:32:27 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v5 1/6] dir_iterator: add helpers to dir_iterator_advance
Date:   Thu, 30 Mar 2017 00:32:05 -0300
Message-Id: <1490844730-47634-2-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
References: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create inline helpers to dir_iterator_advance(). Make
dir_iterator_advance()'s code more legible and allow some behavior to
be reusable.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 dir-iterator.c | 65 +++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index 34182a9..ce8bf81 100644
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
+static inline int pop_dir_level(struct dir_iterator_int *iter)
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
@@ -84,11 +121,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
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
@@ -104,7 +137,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			 * This level is exhausted (or wasn't opened
 			 * successfully); pop up a level.
 			 */
-			if (--iter->levels_nr == 0)
+			if (pop_dir_level(iter) == 0)
 				return dir_iterator_abort(dir_iterator);

 			continue;
@@ -129,7 +162,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 						iter->base.path.buf, strerror(errno));

 				level->dir = NULL;
-				if (--iter->levels_nr == 0)
+				if (pop_dir_level(iter) == 0)
 					return dir_iterator_abort(dir_iterator);
 				break;
 			}
@@ -138,23 +171,9 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
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
+			if (set_iterator_data(iter, level))
+				continue;

 			return ITER_OK;
 		}
--
2.7.4 (Apple Git-66)

