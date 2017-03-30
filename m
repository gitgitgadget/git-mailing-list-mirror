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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CFB020958
	for <e@80x24.org>; Thu, 30 Mar 2017 03:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932623AbdC3Dcp (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 23:32:45 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34546 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932113AbdC3Dcn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 23:32:43 -0400
Received: by mail-qt0-f193.google.com with SMTP id x35so4658244qtc.1
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 20:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rv9KzTi+MIDsK0s7Qa3GtR0scK6h4gRd+A1ollvKDCI=;
        b=WXYl/zQ9CMNdSowYEpBKx3JJPWdvP2ITBV1SyVOsNOcV/CkX59xY47XtGHUpITtJsM
         s5/PvSErTeiFbJ+uCFxnrs0eXn9K/y2Vngxuj+a/HMD1h2N/Ajc+yEn5sDWqJG+vd1Ws
         eyH0nSsFA7U5YwverV9u9lKTT87u1B9h7L70wkU3nlqUJdP2O3CBUiQynrzI6g/yoCWl
         KnPWXGYbbL0UbQQJ7lnSTe9HxnRJm9Wct7qdds6yZku8vTb+4mUDzJzwWcXfQLNT9pec
         uFMLGz51gMBYH865K01fueuG4IZ98wT9sGz7YMj6+F4eEST5iMQ4xAWzr96CXbRqeqCc
         em9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rv9KzTi+MIDsK0s7Qa3GtR0scK6h4gRd+A1ollvKDCI=;
        b=gugRf7vuGie1jn6HI8ZkGrdDn3xwtPY9FQQ4k2fYk0giYnEj6NCNm9GLDFAuT/e7DI
         V9MNXxVSgedZGzT0HM4hI89Lv3cAuPcrNdC/st+4gQVg3J0K8Q96Ukoc0zZ45mitQ3Dl
         yggdK8n38Oirj5YcJRBuX4QSbNo4CR2y1cEr30vyytKoMR9olpKW+IZXQENsZpMoQAKf
         8+PArOzZhagrAK7fCq3kKlammawlwAgsI8XMKXd4IuMb2uUFbKgsPzuv+7VfWiymjRj8
         6lADzMCiPSpk5hCmMnnrFpbVMFY05p6T72CFuQCH5oFrbXBYCiF6LNk3w+Tic1iSpSCq
         FB7w==
X-Gm-Message-State: AFeK/H22TniRSBHNSM1E9/EcQcWNcJ0WF87mARHfCHphBi8oCWFKALl10JJwYCLO37Iq/A==
X-Received: by 10.200.3.81 with SMTP id w17mr3973267qtg.36.1490844762472;
        Wed, 29 Mar 2017 20:32:42 -0700 (PDT)
Received: from localhost.localdomain ([201.52.189.180])
        by smtp.gmail.com with ESMTPSA id d136sm624095qke.32.2017.03.29.20.32.38
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 20:32:41 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <daniel.calibeta@gmail.com>,
        Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v5 5/6] remove_subtree(): reimplement using iterators
Date:   Thu, 30 Mar 2017 00:32:09 -0300
Message-Id: <1490844730-47634-6-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
References: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
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
 entry.c | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/entry.c b/entry.c
index c6eea24..30197b2 100644
--- a/entry.c
+++ b/entry.c
@@ -2,6 +2,8 @@
 #include "blob.h"
 #include "dir.h"
 #include "streaming.h"
+#include "iterator.h"
+#include "dir-iterator.h"

 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -44,33 +46,20 @@ static void create_directories(const char *path, int path_len,
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
+	struct dir_iterator *diter = dir_iterator_begin(path, DIR_ITERATOR_POST_ORDER_TRAVERSAL);
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
+
+	if (rmdir(path))
+		die_errno("cannot rmdir '%s'", path);
 }

 static int create_file(const char *path, unsigned int mode)
@@ -282,7 +271,7 @@ int checkout_entry(struct cache_entry *ce,
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

