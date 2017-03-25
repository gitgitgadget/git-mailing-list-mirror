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
	by dcvr.yhbt.net (Postfix) with ESMTP id 62B302095E
	for <e@80x24.org>; Sat, 25 Mar 2017 18:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbdCYSOb (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 14:14:31 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33611 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbdCYSOa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 14:14:30 -0400
Received: by mail-qk0-f194.google.com with SMTP id p22so2754312qka.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S9G6xVcp1rp5soQBOQaJ5gnQjlH3pb8lOt0U9C2Cq2c=;
        b=NScboMp9o0tPu1oERdwWckgRAtX87HXH28JzB+mLlDrOrhLrDxc74jJ3O+KerHGya7
         BSjdbLoqedr0rTmBiHMbsJaRzEMYflxRvR0OBu4DiJdK4VKlJhPwBa8Jn55UmoobGhQg
         LTz6pEXJmU3iPi0F8qT3iRa9Vlz/0TQQzZfSP4E1zsVr9kbl7R1NFLQG/i4yTKkapfpA
         ZcPiC5Yfj+y2BVVyPPqgjdJF+cRaWziE7aKi66/U4fqM1DhxgKC3uHZm2juEYuYoS5Xn
         1NrMQJCbmtCqPiWYnfQi9KmMpLvU/VEPVlviwrEB4GS9r+qRfN0Uts9jgQVS51eOITvr
         g5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S9G6xVcp1rp5soQBOQaJ5gnQjlH3pb8lOt0U9C2Cq2c=;
        b=JHyIHaUSRvijxtQeRKWT2hf3e5f4iBKK+NGDFnCFJsXb4hLK7cS8C63Hb172RMpg18
         10nNAlHHlGcIZtnoJ3i2/UxUUUDvpKNpTWhY3SXlLYOBWK1w7OXnCNj7YC9Sp3/TN/Vf
         SDmj6yeiUHmdBdCZ4dAeVyDf4W/7INM947Y0cHpTWSHm2nmC/g8qL0qu9EBBrYAdchXb
         QFg9ZS7aU+o5Dwc68luBaP8cDFEXUoHipzUiqamP6qljWVoJGRR/kvoRdelTADlsN+Q1
         p+HnbwX/RWsI/M7UtC9e1N9FeKegJeijVLNzbhMLwq7nvHI8sw5r/jfyg5eDZmnGk0dw
         C/7Q==
X-Gm-Message-State: AFeK/H2SnOog6zZ3eSkzWAevHCMCLJhQ1tG7jm0YKuJYYKy1I/QnX/+2fegvJaT5R+J40A==
X-Received: by 10.55.167.72 with SMTP id q69mr14122140qke.320.1490465611164;
        Sat, 25 Mar 2017 11:13:31 -0700 (PDT)
Received: from localhost.localdomain ([189.103.231.223])
        by smtp.gmail.com with ESMTPSA id 141sm4197861qkj.1.2017.03.25.11.13.27
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 25 Mar 2017 11:13:30 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v3 2/2] [GSoC] remove_subtree(): reimplement using iterators
Date:   Sat, 25 Mar 2017 15:12:31 -0300
Message-Id: <1490465551-71056-3-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1490465551-71056-1-git-send-email-bnmvco@gmail.com>
References: <1490465551-71056-1-git-send-email-bnmvco@gmail.com>
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
 entry.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/entry.c b/entry.c
index c6eea24..670ffeb 100644
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
+	diter->options.iterate_dirs_after_files = 1;
+
+	while (dir_iterator_advance(diter) == ITER_OK) {
+		if (S_ISDIR(diter->st.st_mode)) {
+			if (rmdir(diter->path.buf))
+				die_errno("cannot rmdir '%s'", path->buf);
+		} else if (unlink(diter->path.buf))
 			die_errno("cannot unlink '%s'", path->buf);
-		strbuf_setlen(path, origlen);
 	}
-	closedir(dir);
+
 	if (rmdir(path->buf))
 		die_errno("cannot rmdir '%s'", path->buf);
 }
--
2.7.4 (Apple Git-66)

