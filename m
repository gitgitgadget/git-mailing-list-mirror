Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AE5C1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 19:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfBHTv2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 14:51:28 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:41780 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfBHTv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 14:51:27 -0500
Received: by mail-qk1-f180.google.com with SMTP id u188so2848921qkh.8
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 11:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xSP7r0M+OMChiAGBMUbLG8vwkfLldxuGlk1kMONcZBc=;
        b=BkHcY7obLoVBhKalGCSeGlOkxOoHhD7JhU+VQzPrIyMYtS35COW66FWjhhufM5Shmj
         KDiabn/uQGhAfbxRs91jOPzY8nn+3/6vTKcmEVCrICH+KMwr2VRYhJeybMOv3ReZoWPE
         VgMnYhSEhzKW4ZNweJcg3nvcc8CxwjLEu3KAxpnk1hO1L5eHqNziqIZfVkj+KMeAR9E/
         A7cgX527CnckvhGa1upHUANKfsqZ01d2LX/xPXiKOEOJ1kpuK7Gb+dBL3KzE25y59dZG
         dLqZ5G+Q91pk1pB6jGEEpABSq7iMcLLsLxT6cmNnH3uT2o+NitZqAOj4dFwxw/l8e9QQ
         xYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xSP7r0M+OMChiAGBMUbLG8vwkfLldxuGlk1kMONcZBc=;
        b=hhqAjhQqSuW7IDzBdFCvsywqBYJzQ1Rwj+uro8EG7BOQg/TuVuEw6S37qxaaKYLT/B
         sliIWp/idZIEUuxwFfCQg6QaEAPi2QZ6a6toxCmecv38NJqOutBfq7oE4YKLA6HAvqKp
         eiXJ+CZdiDWSx6htSZF2UJfAh/LC0FkGezVq/yvoOkQrnBF2OysOF3Qw48jeT/CI3bU8
         jH9m8HJAFfcONnWtRaDc4lx2U8Nps+rghm73s9M7U4khM6IA7HgrSZg3uP/e9/QYq9vc
         pvCik5who5veqxCTzEcKzxQeNtoSKebHJtbkB4jo4GYYlCVkDJ9cChsIS6ivy+OfnzjJ
         6dpA==
X-Gm-Message-State: AHQUAuY8J/J5u2l03NGv+qjrSFI7qNsqvPueMJ7DFZ2R/U9F+uRHssl9
        BU0Duha6+Gg+MuOTeL14qCm5wykq9bw=
X-Google-Smtp-Source: AHgI3Ibl/RvqNvaID/leGxWPsyE4Vb1WjzfvmGfGzxIscCgVNF29MIkrdKCZ9Cof/5ZSKND7pblTqQ==
X-Received: by 2002:a37:6c05:: with SMTP id h5mr17380723qkc.175.1549655486126;
        Fri, 08 Feb 2019 11:51:26 -0800 (PST)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id 12sm8253054qka.83.2019.02.08.11.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 11:51:25 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, kewillf@microsoft.com
Subject: [PATCH v1 1/3] read-cache: add post-indexchanged hook
Date:   Fri,  8 Feb 2019 14:51:13 -0500
Message-Id: <20190208195115.12156-2-peartben@gmail.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190208195115.12156-1-peartben@gmail.com>
References: <20190208195115.12156-1-peartben@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Add a post-indexchanged hook that is invoked after the index is written in
do_write_locked_index().

This hook is meant primarily for notification, and cannot affect
the outcome of git commands that trigger the index write.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/reset.c        |  1 +
 builtin/update-index.c |  2 ++
 cache.h                |  4 +++-
 read-cache.c           | 14 ++++++++++++--
 unpack-trees.c         |  2 ++
 5 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 4d18a461fa..e173afcaac 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -380,6 +380,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
 			if (read_from_tree(&pathspec, &oid, intent_to_add))
 				return 1;
+			the_index.updated_skipworktree = 1;
 			if (!quiet && get_git_work_tree()) {
 				uint64_t t_begin, t_delta_in_ms;
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 02ace602b9..cf731640fa 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1071,6 +1071,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	if (entries < 0)
 		die("cache corrupted");
 
+	the_index.updated_skipworktree = 1;
+
 	/*
 	 * Custom copy of parse_options() because we want to handle
 	 * filename arguments as they come.
diff --git a/cache.h b/cache.h
index 27fe635f62..46eb862d3e 100644
--- a/cache.h
+++ b/cache.h
@@ -338,7 +338,9 @@ struct index_state {
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
 		 initialized : 1,
-		 drop_cache_tree : 1;
+		 drop_cache_tree : 1,
+		 updated_workdir : 1,
+		 updated_skipworktree : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
 	struct object_id oid;
diff --git a/read-cache.c b/read-cache.c
index 0e0c93edc9..0fcfa8a075 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -17,6 +17,7 @@
 #include "commit.h"
 #include "blob.h"
 #include "resolve-undo.h"
+#include "run-command.h"
 #include "strbuf.h"
 #include "varint.h"
 #include "split-index.h"
@@ -2999,8 +3000,17 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	if (ret)
 		return ret;
 	if (flags & COMMIT_LOCK)
-		return commit_locked_index(lock);
-	return close_lock_file_gently(lock);
+		ret = commit_locked_index(lock);
+	else
+		ret = close_lock_file_gently(lock);
+
+	run_hook_le(NULL, "post-indexchanged",
+			istate->updated_workdir ? "1" : "0",
+			istate->updated_skipworktree ? "1" : "0", NULL);
+	istate->updated_workdir = 0;
+	istate->updated_skipworktree = 0;
+
+	return ret;
 }
 
 static int write_split_index(struct index_state *istate,
diff --git a/unpack-trees.c b/unpack-trees.c
index 3563daae1a..8665a4a7c0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1637,6 +1637,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 						  WRITE_TREE_SILENT |
 						  WRITE_TREE_REPAIR);
 		}
+
+		o->result.updated_workdir = 1;
 		discard_index(o->dst_index);
 		*o->dst_index = o->result;
 	} else {
-- 
2.20.1.windows.1

