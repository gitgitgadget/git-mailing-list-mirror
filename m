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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2412C20958
	for <e@80x24.org>; Fri, 24 Mar 2017 04:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbdCXEHS (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 00:07:18 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34598 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdCXEHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 00:07:16 -0400
Received: by mail-qt0-f195.google.com with SMTP id x35so447279qtc.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 21:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=n4Mms4nNXklMFT3cqdcuDoRIsUxV/sCs86pkO1Z9Ox8=;
        b=S6d2B2QS3oGMAXFHEDV3V/ipzOc3MB6DuHc5TMMtgsfSZ+lj3egDWkFbnv76ikOGk7
         WYOop0Pmj/hQ6FiBGAHyI/lRC5DG3S639ZjfqozuoJOtHnFIUEdKlaLuK68UxGXdzunZ
         9JJGJ/Cb+a4kUJMjjdJhQPrwVc/xiTH0AMB3y6lzDUvl6h9kqwVpLULyUONGLRkUWgZJ
         RaODdxYK84p7seEhscDVaOJX2AL+UPRu3M+U0s27RivDf7S1SwEi5RyjM0cNJDpB+yX2
         x0OGTfF+JjhYsC450yUucztW4FuPqPVHJRmIEmJdDvByhPE1pgiR+ps80OeZxEVv17Xx
         aIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=n4Mms4nNXklMFT3cqdcuDoRIsUxV/sCs86pkO1Z9Ox8=;
        b=VlVeGU16FURrHWXm0V9z4WndYtEu8Pn9d2hXmYcUDjfdDyCACoCBiwOSOesKQu/Tbp
         iYYLm4Wz5qrQeZhB7riIfyYeY0OXhBr3n6DkY8DiW50BvavrtQIekaGqKs3QODB9uL4e
         aNnmPf8463LfRA/IoRU6ZXjJtzU3+SPSQ8fkqzPm8NBm1Tqq4JcLOq+gVTby9hb+rLFJ
         1lgM0CgdGpEFYGp+/3D+LNLKjXOU1iPmVBDIAiNdYcdUB370ZuZmcPpcfnoXvmnFTPQ4
         B/5I8Ez99pgSTdH4y80K8kEvjoe2GN4dCZs6Vc83jXfF2+GB9dcr0jo8j5K2rT10iXin
         ej0g==
X-Gm-Message-State: AFeK/H2II5ZdE8JlqIs9j92CyDj/hG/shxHLVWmdB1kbG/W5mSG5O+4hUuRkLEdMw1xu5Q==
X-Received: by 10.200.50.112 with SMTP id y45mr5631516qta.75.1490328434563;
        Thu, 23 Mar 2017 21:07:14 -0700 (PDT)
Received: from localhost.localdomain ([201.52.189.180])
        by smtp.gmail.com with ESMTPSA id i125sm746322qkf.52.2017.03.23.21.07.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 21:07:13 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org, bnmvco@gmail.com
Subject: [PATCH] [GSoC] remove_subtree(): reimplement using iterators
Date:   Fri, 24 Mar 2017 01:07:00 -0300
Message-Id: <1490328420-75901-1-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Uses dir_iterator to traverse through remove_subtree()'s directory tree,
avoiding the need for recursive calls to readdir() and simplifying code.

Suggested in the GSoC microproject list, as well as:
https://public-inbox.org/git/xmqqk27m4h3h.fsf@gitster.mtv.corp.google.com/

A conversion similar in purpose was previously done at 46d092a
("for_each_reflog(): reimplement using iterators", 2016-05-21).

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---

Hey there! This is my microproject for Google Summer of Code on git.
It has passed on Travis CI (https://travis-ci.org/theiostream/git),
although I would appreciate any suggestion to improve test coverage
for the affected function.

This is, to my knowledge, one of the few microprojects that have not
yet been started by someone on this list, but please let me know if
someone else is already on it.

Thank you.

 entry.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/entry.c b/entry.c
index c6eea24..a88c219 100644
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
@@ -46,29 +48,17 @@ static void create_directories(const char *path, int path_len,

 static void remove_subtree(struct strbuf *path)
 {
-	DIR *dir = opendir(path->buf);
-	struct dirent *de;
+	struct dir_iterator *diter = dir_iterator_begin(path->buf);
 	int origlen = path->len;

-	if (!dir)
-		die_errno("cannot opendir '%s'", path->buf);
-	while ((de = readdir(dir)) != NULL) {
-		struct stat st;
-
-		if (is_dot_or_dotdot(de->d_name))
-			continue;
-
+	while (dir_iterator_advance(diter) == ITER_OK) {
 		strbuf_addch(path, '/');
-		strbuf_addstr(path, de->d_name);
-		if (lstat(path->buf, &st))
-			die_errno("cannot lstat '%s'", path->buf);
-		if (S_ISDIR(st.st_mode))
-			remove_subtree(path);
-		else if (unlink(path->buf))
+		strbuf_addstr(path, diter->relative_path);
+		if (unlink(path->buf))
 			die_errno("cannot unlink '%s'", path->buf);
 		strbuf_setlen(path, origlen);
 	}
-	closedir(dir);
+
 	if (rmdir(path->buf))
 		die_errno("cannot rmdir '%s'", path->buf);
 }
--
2.7.4 (Apple Git-66)

