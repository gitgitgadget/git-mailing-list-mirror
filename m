Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD8651FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752332AbcLFVxS (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:53:18 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36633 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbcLFVxM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:53:12 -0500
Received: by mail-pg0-f48.google.com with SMTP id f188so153039615pgc.3
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=shEiNlrXEHlBzb2mZmj2tLpRHHgcEma8qB9EFHlO3JA=;
        b=iS1kTGTPY6VghSWaV75i/VJ41SPsjqQumMdaTUJ4zQSZBcObR8ySqqaRU4CC8bPXTN
         zgfqWWQdKK5pcVx3y/rArBOcTxqXB2ApEZ4UfgenC/ludTQsdwj1LWuYHOGnENduZXel
         /8rv++9ZTHJ4cqyQ+xmeCbVW76RwQlrP7UZnm1Am07MD0l4K32kL0SMhm8oTeUTjzo4P
         j1E/0BvO+lMjN7H73KHzNk7uDAq2cI8SduzqXZymjdZXkwJNi6CLQZB0GfFgqBwBTZlY
         GnB0Q8wxawy/nlWoC60tCCRt9YAWYQZ06Zxk4DhBfQVXVeTpiysJEJimQKrgeHuLUHBy
         fGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=shEiNlrXEHlBzb2mZmj2tLpRHHgcEma8qB9EFHlO3JA=;
        b=WMH6HTsSBEeLM6z1eVk620ILbvPS87Ak7rSDZ/tPQ2fGLg4HphqZaQqIrUjWVk9BSn
         68IwQd3cXC8f4oPrRrfMRjry8Z2AtqGm3cWMvEZgk0YJ+E+0JtKNjQVi4EkWrduXL9+K
         2vUg+NlZnKnsWCZ4IWy+3AOFVID4FzaOchp+GnmT65tGvoFf0kAqi8KGdtBSWvoAdqMl
         PBkyk/zsClgGr0Uq5ALjUUH0/2bhEzwztoRsNfDtbpYYvQDsI+RIKvFO5xFMJaXe/y1X
         Q0tXdtko5Ts8Vh96D27FIt/dv/e2iZ38+XssT2o57KRTs7Eeh9brNyy8QzXT5vrtbxNJ
         FS3Q==
X-Gm-Message-State: AKaTC038tjyx2we5bM4DjPG9k5YmeKzXPfW+S5aZAtvVTA7yEMuyBWyS+E/WLIbd2YcbwMAL
X-Received: by 10.99.45.134 with SMTP id t128mr116335854pgt.86.1481061140146;
        Tue, 06 Dec 2016 13:52:20 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y89sm36940228pfk.83.2016.12.06.13.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 13:52:19 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 02/17] dir: convert create_simplify to use the pathspec struct interface
Date:   Tue,  6 Dec 2016 13:51:31 -0800
Message-Id: <1481061106-117775-3-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'create_simplify()' to use the pathspec struct interface from
using the '_raw' entry in the pathspec.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 dir.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/dir.c b/dir.c
index bfa8c8a..7df292b 100644
--- a/dir.c
+++ b/dir.c
@@ -1787,25 +1787,24 @@ static int cmp_name(const void *p1, const void *p2)
 	return name_compare(e1->name, e1->len, e2->name, e2->len);
 }
 
-static struct path_simplify *create_simplify(const char **pathspec)
+static struct path_simplify *create_simplify(const struct pathspec *pathspec)
 {
-	int nr, alloc = 0;
+	int i;
 	struct path_simplify *simplify = NULL;
 
-	if (!pathspec)
+	if (!pathspec || !pathspec->nr)
 		return NULL;
 
-	for (nr = 0 ; ; nr++) {
+	ALLOC_ARRAY(simplify, pathspec->nr + 1);
+	for (i = 0; i < pathspec->nr; i++) {
 		const char *match;
-		ALLOC_GROW(simplify, nr + 1, alloc);
-		match = *pathspec++;
-		if (!match)
-			break;
-		simplify[nr].path = match;
-		simplify[nr].len = simple_length(match);
+		match = pathspec->items[i].match;
+		simplify[i].path = match;
+		simplify[i].len = pathspec->items[i].nowildcard_len;
 	}
-	simplify[nr].path = NULL;
-	simplify[nr].len = 0;
+	simplify[i].path = NULL;
+	simplify[i].len = 0;
+
 	return simplify;
 }
 
@@ -2036,7 +2035,7 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const stru
 	 * subset of positive ones, which has no impacts on
 	 * create_simplify().
 	 */
-	simplify = create_simplify(pathspec ? pathspec->_raw : NULL);
+	simplify = create_simplify(pathspec);
 	untracked = validate_untracked_cache(dir, len, pathspec);
 	if (!untracked)
 		/*
-- 
2.8.0.rc3.226.g39d4020

