Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4614C4332E
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B02812253D
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbhADXv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbhADXv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:51:27 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E6AC0617A3
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 15:50:41 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id j12so27703568ota.7
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 15:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IhFkzsBZ+eashqkkejacoo3lS8AN2lYp5V5hCqaa9DE=;
        b=GmxZyC7H1WO+8suE0OO5DxL/+Al6JgNqb3OJuJ9xh0JaETnEZG6UzpJe8b76/LR2o7
         44PJOt9VkSCbw2YhMa8L36qdUafxxx+14mzIGizI5QMxudOzCEsAzd6qmKigAEqrM7cF
         B0LUff3HriBed8+NyHjDeFxl3OHDxkRNQxQXuh6h3M05/8gi8M0L24ic7m2d3+4mLpaJ
         xcrlrSZhelTa+285v/6b2Q4Gx2fbOePp45iS7xwqdGEmy1jQNP7g0YTpZZ4X4odRDWF4
         4FUs1r/RULS9xgI1V4IDQ5AlBDWTut5I+yUIB7SsjD9jMdg7uTbT81T4renp1M2i3xOE
         YD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IhFkzsBZ+eashqkkejacoo3lS8AN2lYp5V5hCqaa9DE=;
        b=m5OTy26j3KusuuE7U2FgoJQRQJ51tmnBRCh9bBfMMVFerwCdttbp//To7qZUM4AwYY
         CpKbYjQIouZBareGpmNhDKxVebiZHsuH4Tk+MFDdJ+adfn1B8Brb+/E814gwDt+8vNzS
         UOzArox4PA8lIDTW7KMk2oJ56OqGKD5J6FpHNm33AE5yQSKUUKP/ylt4kGVUXK7QWPr4
         aHnYgokAKLMvJSIyPNUCLoBeY3iIewZmtX5NFc7WUakCVHeGtWN/asO4c/O3wnz89Bby
         6oNUWEquEmqI/J1aPQqIYgvBEqaD1edHo4DBHVV0ri/VXPNo9WEVb6diDAVQgmbPrmWP
         kN3g==
X-Gm-Message-State: AOAM533j+aquTOqRa/jkuWyLGxwG+KGw1IgWcYx55TvLxCoTUEaNsaMc
        +AiZrpc/oOOxYOpkPx1JDKN8Yo8w/8o=
X-Google-Smtp-Source: ABdhPJyets1aX6uMlQKUIVFCx904UBYSPkgZNkEJqRjkwXIubtYLRCyCdkbQ41BdrRlAzL09KLrqiA==
X-Received: by 2002:a9d:2aaa:: with SMTP id e39mr51641199otb.10.1609804240679;
        Mon, 04 Jan 2021 15:50:40 -0800 (PST)
Received: from tiger.attlocal.net ([2600:1700:bae0:2de0::26])
        by smtp.gmail.com with ESMTPSA id o135sm13359600ooo.38.2021.01.04.15.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:50:40 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 11/17] merge-ort: implement apply_dir_rename() and check_dir_renamed()
Date:   Mon,  4 Jan 2021 15:50:00 -0800
Message-Id: <20210104235006.2867404-12-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.106.g3ff750dc32.dirty
In-Reply-To: <20210104235006.2867404-1-newren@gmail.com>
References: <20210104235006.2867404-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both of these are copied from merge-recursive.c, with just minor tweaks
due to using strmap API and not having a non_unique_new_dir field.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 9c9be645ea..f7f2470c96 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1154,7 +1154,29 @@ struct collision_info {
 static char *apply_dir_rename(struct strmap_entry *rename_info,
 			      const char *old_path)
 {
-	die("Not yet implemented!");
+	struct strbuf new_path = STRBUF_INIT;
+	const char *old_dir = rename_info->key;
+	const char *new_dir = rename_info->value;
+	int oldlen, newlen, new_dir_len;
+
+	oldlen = strlen(old_dir);
+	if (*new_dir == '\0')
+		/*
+		 * If someone renamed/merged a subdirectory into the root
+		 * directory (e.g. 'some/subdir' -> ''), then we want to
+		 * avoid returning
+		 *     '' + '/filename'
+		 * as the rename; we need to make old_path + oldlen advance
+		 * past the '/' character.
+		 */
+		oldlen++;
+	new_dir_len = strlen(new_dir);
+	newlen = new_dir_len + (strlen(old_path) - oldlen) + 1;
+	strbuf_grow(&new_path, newlen);
+	strbuf_add(&new_path, new_dir, new_dir_len);
+	strbuf_addstr(&new_path, &old_path[oldlen]);
+
+	return strbuf_detach(&new_path, NULL);
 }
 
 static void get_renamed_dir_portion(const char *old_path, const char *new_path,
@@ -1399,7 +1421,18 @@ static void handle_directory_level_conflicts(struct merge_options *opt)
 static struct strmap_entry *check_dir_renamed(const char *path,
 					      struct strmap *dir_renames)
 {
-	die("Not yet implemented!");
+	char *temp = xstrdup(path);
+	char *end;
+	struct strmap_entry *e = NULL;
+
+	while ((end = strrchr(temp, '/'))) {
+		*end = '\0';
+		e = strmap_get_entry(dir_renames, temp);
+		if (e)
+			break;
+	}
+	free(temp);
+	return e;
 }
 
 static void compute_collisions(struct strmap *collisions,
-- 
2.29.1.106.g3ff750dc32.dirty

