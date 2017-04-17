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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A79120A04
	for <e@80x24.org>; Mon, 17 Apr 2017 20:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932270AbdDQUwH (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 16:52:07 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33147 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932177AbdDQUwC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 16:52:02 -0400
Received: by mail-qk0-f195.google.com with SMTP id d131so21145799qkc.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 13:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X7n7O2LUOye/IS48t/JDNEPA8KDu0lOI1UQ9/OoRNrU=;
        b=sZGinBbX0HMsTr+7vZkJDjpr0PuNhqK6hHiEWsDPq8XE3+o0lCkPB6n34uU8ayeBwN
         oOEHQnqYAed+vOvPuqHPpKZDetSiY/39Iarzhf3wZx+LpZeXD23oSOsoI+rsdV9YpCCR
         aZssqgHlRHiiJDS/iBE2BzTDV2S2/bnk/U3Un/j3LIN+4hqXTl3DHdUC5I449qmsUTdB
         9JXdHb+jIsUjSg8dnfSwOCVSL+I8GdI4jeOD0yGwx28osoGm9bqcEXMezhK90yT80Yl4
         cSpUe7J2wVK4huuXPa78nlQpsTt07RytMypUaPQ58f/cAbLDh3VzcxY1uo12xctFhKC+
         RMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X7n7O2LUOye/IS48t/JDNEPA8KDu0lOI1UQ9/OoRNrU=;
        b=ocpSq8iTEt+QNVHjeL8KLP9A9tMGurp4wq1NN5N5AoEVF1W2vYbQoZwR1zbPrZDWlo
         BVEw8h/e+9UWWa9DS8LVhDzA5rI+FZ+vvMVprR29E6fT5ayn8YbmbYzwSrlbDje9sv+L
         aEcL9uoxV2C/HV9tRm8OfH4gK6oGNXzRyQOUopWMEKFRCwtrecDFFC2YmWfHOSGKyVT2
         2jpGpu6KlQs0I8i5W9GWkumKeC7V6ewEAoalKXNsjNz6BJzcfnucD0Xp0QFdD6F2GZcJ
         ERRtlhcuGB593+GgAIc+l3JX2W9CUpUADkrX8OReHOkQUiNl1kHFq/GBiiutBEwfndv3
         Gpyg==
X-Gm-Message-State: AN3rC/4COf+XDBCdGxCfejTFi+rCcEAS+uNE/i4OYPwqLHrlmpBTZOM0
        uRLgGGAMzt9JzQ==
X-Received: by 10.55.174.4 with SMTP id x4mr10232569qke.7.1492462321950;
        Mon, 17 Apr 2017 13:52:01 -0700 (PDT)
Received: from localhost.localdomain ([179.222.191.2])
        by smtp.gmail.com with ESMTPSA id f203sm8093848qka.11.2017.04.17.13.51.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 17 Apr 2017 13:52:00 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v9 5/5] remove_subtree(): reimplement using iterators
Date:   Mon, 17 Apr 2017 17:51:36 -0300
Message-Id: <1492462296-4990-6-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1492462296-4990-1-git-send-email-bnmvco@gmail.com>
References: <1492462296-4990-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use dir_iterator to traverse through remove_subtree()'s directory tree,
avoiding the need for recursive calls to readdir(). Simplify
remove_subtree()'s code.

A conversion similar in purpose was previously done at 46d092a
("for_each_reflog(): reimplement using iterators", 2016-05-21).

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 entry.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/entry.c b/entry.c
index d2b512d..a939432 100644
--- a/entry.c
+++ b/entry.c
@@ -3,6 +3,8 @@
 #include "dir.h"
 #include "streaming.h"
 #include "submodule.h"
+#include "iterator.h"
+#include "dir-iterator.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -45,33 +47,21 @@ static void create_directories(const char *path, int path_len,
 	free(buf);
 }
 
-static void remove_subtree(struct strbuf *path)
+static void remove_subtree(const char *path)
 {
-	DIR *dir = opendir(path->buf);
-	struct dirent *de;
-	int origlen = path->len;
-
-	if (!dir)
-		die_errno("cannot opendir '%s'", path->buf);
-	while ((de = readdir(dir)) != NULL) {
-		struct stat st;
-
-		if (is_dot_or_dotdot(de->d_name))
-			continue;
-
-		strbuf_addch(path, '/');
-		strbuf_addstr(path, de->d_name);
-		if (lstat(path->buf, &st))
-			die_errno("cannot lstat '%s'", path->buf);
-		if (S_ISDIR(st.st_mode))
-			remove_subtree(path);
-		else if (unlink(path->buf))
-			die_errno("cannot unlink '%s'", path->buf);
-		strbuf_setlen(path, origlen);
+	struct dir_iterator *diter = dir_iterator_begin(path,
+		DIR_ITERATOR_POST_ORDER_TRAVERSAL | DIR_ITERATOR_LIST_ROOT_DIR);
+	if (!diter) {
+		die_errno("cannot remove path '%s'", path);
+	}
+
+	while (dir_iterator_advance(diter) == ITER_OK) {
+		if (S_ISDIR(diter->st.st_mode)) {
+			if (rmdir(diter->path.buf))
+				die_errno("cannot rmdir '%s'", diter->path.buf);
+		} else if (unlink(diter->path.buf))
+			die_errno("cannot unlink '%s'", diter->path.buf);
 	}
-	closedir(dir);
-	if (rmdir(path->buf))
-		die_errno("cannot rmdir '%s'", path->buf);
 }
 
 static int create_file(const char *path, unsigned int mode)
@@ -312,7 +302,7 @@ int checkout_entry(struct cache_entry *ce,
 				return 0;
 			if (!state->force)
 				return error("%s is a directory", path.buf);
-			remove_subtree(&path);
+			remove_subtree(path.buf);
 		} else if (unlink(path.buf))
 			return error_errno("unable to unlink old '%s'", path.buf);
 	} else if (state->not_new)
-- 
2.7.4 (Apple Git-66)

