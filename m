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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C006207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 17:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752967AbdDZREL (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 13:04:11 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33084 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752911AbdDZREB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 13:04:01 -0400
Received: by mail-pg0-f67.google.com with SMTP id 63so1413932pgh.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X7n7O2LUOye/IS48t/JDNEPA8KDu0lOI1UQ9/OoRNrU=;
        b=nNRTikGJnqT5KGXJlANF+fMjA5DIUKUXjTlHF8fkXxpy6jzsOh/Bqg0cRnPm6nAhyn
         RGqJQtonDHOzrf7239a+PQvHkqAdMHDpb59erDQeMV68Ar/t/8CqzC88Lg+27uUhvILa
         hfkaeqEGcY0s3kIIu2syOI1s4jXH92LPZkVVbd/KEOQmRVvfa7a8K1zpQ5HaEmSLSbzI
         /0mlr+eYSvO/MAa9rhv0KpaJk4LCAOqvCiSnMPaReqeqT8fuHCkxN5TM0WY5vMpJrulw
         lmZx9umtOgovPNZmk6igqlYHRvyeEPxTAjxO0126mIbAvOwMHlb1JH1iE73SjCTOJQqb
         d7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X7n7O2LUOye/IS48t/JDNEPA8KDu0lOI1UQ9/OoRNrU=;
        b=VAqaVtzvvyfM0+BXVI062qayp2ee5JQ8aeICInVJFU6a88ZSsfkZZmZqkhZrF8v0Jj
         sPKrfqotaVlCpOHpDFf9mLn0+zwl0Ei/OhvFgO+U2/WkesGy89uOFiV49ZzzYOhEFrfq
         bbn8PSe8T1NPeF6anaPA8t/CrG4gGKMC9a7e29LUz3BtcggfkbivXSwBUePYbtEvfRjM
         n56H5PS0hK0cqm1YjgHIRfQfLKIWaUNMtWVERUiLXL20pFm+DJvDmJfomdIktwOtd8tx
         LyTySNIyynb+SkspOC7a0PZGaGi8cgwg23wJHkhrf6CQhNLFThODCNcDNAnMWBu/8wMw
         F37Q==
X-Gm-Message-State: AN3rC/4cFQcfsC/57xQJ1DLzYpDizzqA1NiDQ8NDKbPowtBYIpmXik+S
        auk03OMvnCeA1Q==
X-Received: by 10.84.148.203 with SMTP id y11mr1125520plg.10.1493226240158;
        Wed, 26 Apr 2017 10:04:00 -0700 (PDT)
Received: from Daniels-MacBook-Pro.local.net (c-76-102-227-215.hsd1.ca.comcast.net. [76.102.227.215])
        by smtp.gmail.com with ESMTPSA id q70sm1376479pgq.45.2017.04.26.10.03.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 10:03:59 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v11 5/5] remove_subtree(): reimplement using iterators
Date:   Wed, 26 Apr 2017 10:03:39 -0700
Message-Id: <1493226219-33423-6-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1493226219-33423-1-git-send-email-bnmvco@gmail.com>
References: <1493226219-33423-1-git-send-email-bnmvco@gmail.com>
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

