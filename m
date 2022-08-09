Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397ABC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 12:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242093AbiHIMJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 08:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239621AbiHIMJk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 08:09:40 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F5524BC6
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 05:09:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g12so10606074pfb.3
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 05:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GknY/nbU/jyJ0fgOy6V5DJzxlHE0C/cySH0mxuAJuE8=;
        b=MM7pwzMB5Ll5IlsTSjAhjts5KqFntRZ6J7gdkEcQl8R5FUGF5z2sB7T+YLLad2ZLJL
         1eN8q587gjQj5TfOZt7bYlKyF39f3dsBdMMHEGvfMdf0wtp5Af47xNBEwHhzPDswKSrE
         x9wCvYg2dmjRglebZR9vgQJO6ez+FUGpw0uaOqPGkfJqzjyOQTiR00pIDp1bxv4KLy7L
         r5jRI48cR3plxBsTseTfwujfoAiA7Rii6JEtde7YyrNCGcS/I9dmMk6VT9mHQQj9doRL
         JlXoBZAKjsNC0taXuHWnddfs3V9St5XW/TqNUa+Uo+Hq5QhyPpQCnHzFZ0J9BqcQyiJx
         pQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GknY/nbU/jyJ0fgOy6V5DJzxlHE0C/cySH0mxuAJuE8=;
        b=LyAg4JeZ67oaVIyGuGJRys4L/r/m9pP3eqRFJuWPDNnFZsL4xoZMabtSkgQWbPA8uk
         TBuw9LsnOlsqyy6GH9bzaYbT1Q3gJyJ2godOtAEZvyXYPeMzabO+4lbgBI3O/MY0lhZM
         OtxWyUlfw886mLuwwF2pjub6Ow0zctqRRy8ga4KDysCrSOKkggDXRl7oRzn71ydUWso5
         G+zuiS1A5DqEFSI1dYVAki6v5qrZ2QbdGULVvy0jN+woCujj3j+AfPD8VXOMU6yFlQuk
         jET6QBL1vT01Mm9Rs+EexWr/QDff4ll7wUfE+rNkVWgV+kk11ekmz0QlMViP14n1rS8z
         igSg==
X-Gm-Message-State: ACgBeo2j3wmsmD/rDCNXJJShAu64ykIGnCl6JhjdYDf7Awzvv7/DHBua
        D1mrYK7FubIBHVh1ZIhyJo6mlHwssr/q5A==
X-Google-Smtp-Source: AA6agR5f7CMK5GWrL9Dj3ljXmduUntJNh+ODaNCEH46zfW2mOSL/pFWey/RlREsTvPkyzJLjz3BF9A==
X-Received: by 2002:a63:17:0:b0:41d:7ab5:c9e6 with SMTP id 23-20020a630017000000b0041d7ab5c9e6mr7788844pga.493.1660046978247;
        Tue, 09 Aug 2022 05:09:38 -0700 (PDT)
Received: from ffyuanda.localdomain ([120.239.67.140])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b0016d10267927sm10511485pll.203.2022.08.09.05.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 05:09:38 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v3 3/9] mv: free the with_slash in check_dir_in_index()
Date:   Tue,  9 Aug 2022 20:09:04 +0800
Message-Id: <20220809120910.2021413-4-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

with_slash may be a malloc'd pointer, and when it is, free it.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 7c11b8f995..0a999640c9 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -133,6 +133,7 @@ static int index_range_of_same_dir(const char *src, int length,
  */
 static int empty_dir_has_sparse_contents(const char *name)
 {
+	int ret = 0;
 	const char *with_slash = add_slash(name);
 	int length = strlen(with_slash);
 
@@ -142,14 +143,18 @@ static int empty_dir_has_sparse_contents(const char *name)
 	if (pos < 0) {
 		pos = -pos - 1;
 		if (pos >= the_index.cache_nr)
-			return 0;
+			goto free_return;
 		ce = active_cache[pos];
 		if (strncmp(with_slash, ce->name, length))
-			return 0;
+			goto free_return;
 		if (ce_skip_worktree(ce))
-			return 1;
+			ret = 1;
 	}
-	return 0;
+
+free_return:
+	if (with_slash != name)
+		free((char *)with_slash);
+	return ret;
 }
 
 int cmd_mv(int argc, const char **argv, const char *prefix)
-- 
2.37.0

