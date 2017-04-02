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
	by dcvr.yhbt.net (Postfix) with ESMTP id 48A0C20966
	for <e@80x24.org>; Sun,  2 Apr 2017 20:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbdDBUFo (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 16:05:44 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33923 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbdDBUFm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 16:05:42 -0400
Received: by mail-qk0-f193.google.com with SMTP id 10so16968380qkh.1
        for <git@vger.kernel.org>; Sun, 02 Apr 2017 13:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IT7db9dexXxcNTmGl1/4KNU7ywsaBIMok9fUdHoIh/8=;
        b=RLNkUSlPoUVYwT+Auj8Pxg7i2v3eQjxqYO5gOHW8G8qUcc+M/78bntH3XDbpFgDic3
         cyED8fCmzZs3v3PH0Skk7gKoAbgs8d2jGpNpujUuK5mKdkUuPVmeI6GTU8mXqgxWUZh1
         fAQSh/0QuyLclOysSaU/LopwZI2mdEjcrGEaMAN8gXMlgs5B5fgt0TF7K894ib5u707d
         chPBOtFqXrcICpJrrHfK1DnQibb5/Pn5KSAuIJAKlHOqH6MfgSzgM5CT0ynifqwGRAnV
         5JZdcxcbxcq464cKYEkqjiV4Jq4SbXndyQO295s9/dprUyziHUFC+fJCdsKeiBCVvf5b
         jE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IT7db9dexXxcNTmGl1/4KNU7ywsaBIMok9fUdHoIh/8=;
        b=NDKl7fMqMzJBjHrOWHkwTxHLoUlsXcX0qa7zHDNxv7ttt9LRtW4ZSMSxzhNAvlWS9f
         5DwSRUxbqW4gYX8yLSUdh87m3ZBzXoD3s+QjIgZ5fYb1fiOPJfFfF8+6tga/UlRw2Z/l
         yNW5meqU9uBg06AhpaQWupe/0uRKLFxzGkb1sTKdXHz4SwtZ1FZy6tg1hX92mEj6FUUV
         WeSuI+GlfM4Z87QGy2og+FdmQxqjKaPbm486gh9mhOpHFFSK9fcXwl+y/r06ufpUEeYk
         MwWCr5fi7grn+iM4Io6Q149gRxw5xmLTTe1tWslG8ByygVBbDjxWyuQI57NWcc8Udqvi
         vuHg==
X-Gm-Message-State: AFeK/H0+p9LLUBi02psuLc0Cf3oAT7oECbokZWJAvJKhlbHp+6PToYlJvGHbHwV+XGX8Zw==
X-Received: by 10.55.167.72 with SMTP id q69mr13437357qke.320.1491163541344;
        Sun, 02 Apr 2017 13:05:41 -0700 (PDT)
Received: from localhost.localdomain (186-245-85-163.user3g.veloxzone.com.br. [186.245.85.163])
        by smtp.gmail.com with ESMTPSA id 137sm8162258qkd.19.2017.04.02.13.05.37
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 02 Apr 2017 13:05:40 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <daniel.calibeta@gmail.com>,
        Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v7 5/5] remove_subtree(): reimplement using iterators
Date:   Sun,  2 Apr 2017 17:03:08 -0300
Message-Id: <1491163388-41255-6-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1491163388-41255-1-git-send-email-bnmvco@gmail.com>
References: <1491163388-41255-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Ferreira <daniel.calibeta@gmail.com>

Use dir_iterator to traverse through remove_subtree()'s directory tree,
avoiding the need for recursive calls to readdir(). Simplify
remove_subtree()'s code.

A conversion similar in purpose was previously done at 46d092a
("for_each_reflog(): reimplement using iterators", 2016-05-21).

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 entry.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/entry.c b/entry.c
index d2b512d..bd06f41 100644
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
@@ -45,33 +47,17 @@ static void create_directories(const char *path, int path_len,
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
+	struct dir_iterator *diter = dir_iterator_begin(path, DIR_ITERATOR_POST_ORDER_TRAVERSAL | DIR_ITERATOR_LIST_ROOT_DIR);
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
@@ -312,7 +298,7 @@ int checkout_entry(struct cache_entry *ce,
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

