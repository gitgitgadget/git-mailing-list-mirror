Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74B7C433E0
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F0F220799
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbhAANHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jan 2021 08:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbhAANHx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jan 2021 08:07:53 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA29C061575
        for <git@vger.kernel.org>; Fri,  1 Jan 2021 05:07:12 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id y17so21948877wrr.10
        for <git@vger.kernel.org>; Fri, 01 Jan 2021 05:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hEvygSnZL6ttE2KBbl6h90vJppdhYj3k6Qfru0A/68c=;
        b=Qz7jC94nUZCVPSo6QJbwsLW8LalpWkNCZ54Ea1PyBmYQA9dMgEOfraz3LMUj/1Xkek
         Hk0vApmaxM0PUdrInoELWBOOsqX6tgws/Ou664Rvf9fsg3nDLU5byQThZuYOR4Ymnhc8
         EgAGRk7hU8LYCuVGQyLyMZJNEJCSGv2o0CGZBfoEDaxqXakHn10uDiZhxZuoc7uXb+Da
         7AcRZFUakOr86yyDuU9cQCPk87dIK5Ea3ihHrOOMiXW95jqIUJYx6FKlT6xG80ZnN752
         3hoTw4O30SKu4iPnlt9qzhK8BOU3EcOd8K94yAL4a03h9L+kOkAtaQRLMS2I2cIIiYYJ
         G8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hEvygSnZL6ttE2KBbl6h90vJppdhYj3k6Qfru0A/68c=;
        b=cofAeOjE+Fb5SldYTBaHeL95Eje0081O8ceUlGLnpBIPyUjUSBq+9FHmc0gIVJQQGt
         ZBP1xcMkHUkHcjR+vACoZIG+YKOkF8g0D3oJhaKgkUYMcNMwpjuY7i8j6M4NpNa3yqny
         L7mRdtyX1H+WKtGZ+TA/2AHIMuvqc5SwGAgVF4g2tR7P4yJT14LXAvoFo9cExfL0Kp6f
         HRIHR6qDLrkZNXYaYXbzofO5RnYqcT/R8RQlHIOkuj+86TRYEkTUr8POz6H5RlGlohPh
         n5+x8eokB4eqFlOBwqKa48DaJZVsl3ZwdZK0kkVXBASseC7uZQSivvzTRmooMbXSZNtJ
         v24A==
X-Gm-Message-State: AOAM533arZGpwCcKvsLf5P52Maq7hSh88yEzAdiGGXAPI2uMhSOFXifc
        bWWZ8C/E1C1yVThlcXlRewqe6nm9EJI=
X-Google-Smtp-Source: ABdhPJxoX8eH/WuwX6vjG0SP8teIg9F67iudrsPpC55AtsJRAFQDvxeOpbSOZ5asLJFd8/Qp7+EqHQ==
X-Received: by 2002:a5d:4712:: with SMTP id y18mr69172975wrq.229.1609506430962;
        Fri, 01 Jan 2021 05:07:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y13sm71664477wrl.63.2021.01.01.05.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 05:07:10 -0800 (PST)
Message-Id: <68d88b651c74659eb171e88d701b89d11e7f5f24.1609506428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.1609506428.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 13:06:57 +0000
Subject: [PATCH 01/12] merge-index: drop index compatibility macros
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Replace uses of the old macros for the_index and instead pass around a
'struct index_state' pointer. This allows dropping the compatibility
flag.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/merge-index.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 38ea6ad6ca2..8c7e6b0e6a2 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "run-command.h"
 
@@ -6,18 +5,19 @@ static const char *pgm;
 static int one_shot, quiet;
 static int err;
 
-static int merge_entry(int pos, const char *path)
+static int merge_entry(struct index_state *istate,
+		       int pos, const char *path)
 {
 	int found;
 	const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
 	char hexbuf[4][GIT_MAX_HEXSZ + 1];
 	char ownbuf[4][60];
 
-	if (pos >= active_nr)
+	if (pos >= istate->cache_nr)
 		die("git merge-index: %s not in the cache", path);
 	found = 0;
 	do {
-		const struct cache_entry *ce = active_cache[pos];
+		const struct cache_entry *ce = istate->cache[pos];
 		int stage = ce_stage(ce);
 
 		if (strcmp(ce->name, path))
@@ -27,7 +27,7 @@ static int merge_entry(int pos, const char *path)
 		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
 		arguments[stage] = hexbuf[stage];
 		arguments[stage + 4] = ownbuf[stage];
-	} while (++pos < active_nr);
+	} while (++pos < istate->cache_nr);
 	if (!found)
 		die("git merge-index: %s not in the cache", path);
 
@@ -43,32 +43,34 @@ static int merge_entry(int pos, const char *path)
 	return found;
 }
 
-static void merge_one_path(const char *path)
+static void merge_one_path(struct index_state *istate,
+			   const char *path)
 {
-	int pos = cache_name_pos(path, strlen(path));
+	int pos = index_name_pos(istate, path, strlen(path));
 
 	/*
 	 * If it already exists in the cache as stage0, it's
 	 * already merged and there is nothing to do.
 	 */
 	if (pos < 0)
-		merge_entry(-pos-1, path);
+		merge_entry(istate, -pos - 1, path);
 }
 
-static void merge_all(void)
+static void merge_all(struct index_state *istate)
 {
 	int i;
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
 		if (!ce_stage(ce))
 			continue;
-		i += merge_entry(i, ce->name)-1;
+		i += merge_entry(istate, i, ce->name)-1;
 	}
 }
 
 int cmd_merge_index(int argc, const char **argv, const char *prefix)
 {
 	int i, force_file = 0;
+	struct index_state *istate;
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -78,7 +80,8 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	if (argc < 3)
 		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
 
-	read_cache();
+	repo_read_index(the_repository);
+	istate = the_repository->index;
 
 	i = 1;
 	if (!strcmp(argv[i], "-o")) {
@@ -98,12 +101,12 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "-a")) {
-				merge_all();
+				merge_all(istate);
 				continue;
 			}
 			die("git merge-index: unknown option %s", arg);
 		}
-		merge_one_path(arg);
+		merge_one_path(istate, arg);
 	}
 	if (err && !quiet)
 		die("merge program failed");
-- 
gitgitgadget

