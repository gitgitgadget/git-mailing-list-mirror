Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B1D920958
	for <e@80x24.org>; Sat, 25 Mar 2017 11:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbdCYL1v (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 07:27:51 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36133 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdCYL1u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 07:27:50 -0400
Received: by mail-qk0-f195.google.com with SMTP id n141so1865969qke.3
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 04:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lolrS5Simr9B6UBedn9HBIqYlpz1/5csilUdFCmyVjo=;
        b=Mz3Eg0hTg8azGHxOtyEsNNQMyDf9v2cXIvz1ZJCVZi5xD3fYahapFsVUNzisex05R7
         tBsguvd31zPgYoHJYfAUSIHDXgDMCq25RdZwurN/FBs8CGgNp6FF+9oHQWfQ5fFM7Ao8
         a9dfP0bYZI7cfLHaOAtP1giukA/w0NAgrfLpEayaTRnnCSn5nHeBYY80/XUflw7CqxyE
         mi1L5rOpbfqWOO1Y09nEznRoLPQKmmyssXSPZBFlyHx3nOscihTgLoAjvjUgWft/Tl2U
         rsYp8YUoWyofypDLqJUM52FW4P2STt1Z9TNXFeo4fyN6VjiYSzWtiLp88V6h4muCyjFa
         6MQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lolrS5Simr9B6UBedn9HBIqYlpz1/5csilUdFCmyVjo=;
        b=C9t/3wLRawplTiiLeerud8NTUsMNsam4BVveNJ0W+e9BC5d1FkhgGSUxzbQc1biI7g
         WLGkhMicWz6u+CDJvdGK0C3ocgYerNDCZCubEuOjbsiGyFUkKw6VhnjR/jM6V/+Bwtwl
         fkwu8ZjhgKG5/x1oBB11+u6Y4GLcd1bPK2u7qoyENcpYreApnIyzmdNvJaJvYQl6ZRCb
         npkJ9Pf+nNxpORvyivz981i1Qd6dI7Zis5JChrMVizv7t0QRh543KB4A7UuvumVQMGoW
         3sR+tnSdxDBnnYLBZhMqRCQocyzjKdWVC0NUalVeju5UrUvH2X006v2np3enCaBzud3L
         wIsQ==
X-Gm-Message-State: AFeK/H3YdOg6Xuj+roUHPK80ssC2GjP059+f65qY7yfDGu7ERxoGVpXbscg1GA0qTQdY5Q==
X-Received: by 10.55.122.134 with SMTP id v128mr11427668qkc.115.1490441269469;
        Sat, 25 Mar 2017 04:27:49 -0700 (PDT)
Received: from localhost.localdomain ([201.52.189.180])
        by smtp.gmail.com with ESMTPSA id l13sm3464740qtl.50.2017.03.25.04.27.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 25 Mar 2017 04:27:48 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com, sbeller@google.com,
        Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v2] [GSoC] remove_subtree(): reimplement using iterators
Date:   Sat, 25 Mar 2017 08:27:37 -0300
Message-Id: <1490441257-44727-1-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
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

This is a second-version patch of the Google Summer of Code microproject for
refactoring recursive readdir() calls to use dir_iterator instead. v1 can be
found in:

https://public-inbox.org/git/CAGZ79kZwT-9mHTiOJ5CEjk2wDFkn6+NcogjX0=vjhsAh16ANYg@mail.gmail.com/T/#mae023e7a7d7626f00e0923833c4359f5af493730

Additionally, for debugging purposes I turned remove_subtree() into a no-op
and ran git tests. Some failures were at:

* t2000-checkout-cache-clash.sh
* t2003-checkout-cache-mkdir.sh

If you guys could check those files out and warn me if any additional tests
would be welcome, please let me know.

Thanks.

 entry.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/entry.c b/entry.c
index c6eea240b..3cb92592d 100644
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
@@ -46,29 +48,13 @@ static void create_directories(const char *path, int path_len,

 static void remove_subtree(struct strbuf *path)
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
+	struct dir_iterator *diter = dir_iterator_begin(path->buf);
+
+	while (dir_iterator_advance(diter) == ITER_OK) {
+		if (unlink(diter->path.buf))
 			die_errno("cannot unlink '%s'", path->buf);
-		strbuf_setlen(path, origlen);
 	}
-	closedir(dir);
+
 	if (rmdir(path->buf))
 		die_errno("cannot rmdir '%s'", path->buf);
 }
--
2.12.1.433.g82305b74f.dirty

