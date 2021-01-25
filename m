Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB27C433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC83422B3F
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbhAYSFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731307AbhAYRzw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:55:52 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D549C0617AB
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:22 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 190so70478wmz.0
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SpreOg0UdiWIA47xLMGMTTmZvzsRrDk/5CpRa4HSDDE=;
        b=isbbZCKzNyfykAmrO/Yiq7jWH4S+M1uvPx9nbqHufVjdICu7L2fJyQcdJpZhdfrer6
         ZKN+g8zrRKg+HzSzTukh47uFZY5v0vhYW7XlwrQkIjH1tOlyPEP2LrdzSIFwpNrywrLb
         aXUF3TtIuCbqmo19KAjIJkStd/lv5fvoxPy4uxuuB4YSvXaL3KESqF1Zz+JhBwzJ4WNz
         /oHoL+DVDCemklHhI9NQ7wCRWLC19ZvW+c/21sQzdVVrcur4lkYgpg9Teiv+/ZXOMtJa
         sDZoytvPuVO6BERRikMG2VZn0KneP2N+vkJSI/5sD5X7KEsKS3A5wvvXaE//bG2/7z2E
         6S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SpreOg0UdiWIA47xLMGMTTmZvzsRrDk/5CpRa4HSDDE=;
        b=dX33xroWCkWYxVeA/svs4WhfEcGlbwNXeIQ5hL6rVDGEc20GFzgzBQnSB6fJLZ6a1q
         ewHr4URsbuIZTRoLxGAKEijl7bHqPD3YAI9Frm5AARja8H6qIpsxNO9z+1s3nC23+VtJ
         VwMdh6CwtzbDNEi4Tj9JQLTEDzEJ58ElW5PqVvq5s559XZHOMrXK73i2kl9EYPIFq/92
         RMGg0p/dhzVor51SpMiZZIdP+rZFaCqrKPBVrM5D/Tb7OyvVhTHGoTKWzKnKgsEj2WsP
         PsnjD2NNXwVsEeOUZA2O42UeTK3AUNnkIyGScDbo4NZo+B3M/KNzcWkF/usAJ0HXQyLZ
         kHEw==
X-Gm-Message-State: AOAM5300N4iTDTMvnYGcsTXrdCT+w7rtN0mNLS0DGtPgdl7XSDffXmlL
        tzYgepQu8LxMCY2zAeqO0i/BH8cYe1M=
X-Google-Smtp-Source: ABdhPJwgLQWRQBbPoIiaMe0ZCrzz9Z4V84ZwTa3X1PoMmQ14DhVSdioN89SbFJPPuHQlyJNxG+Drdw==
X-Received: by 2002:a1c:25c2:: with SMTP id l185mr1184538wml.62.1611596540654;
        Mon, 25 Jan 2021 09:42:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t25sm8439wmj.39.2021.01.25.09.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:20 -0800 (PST)
Message-Id: <e1e2f2b75b2848e9b4c9cfc8fe89b11e6ad2b776.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:41:51 +0000
Subject: [PATCH 05/27] test-tool: read-cache --table --no-stat
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'test-tool read-cache --table' output is helpful to understand the
full contents of the index entries on-disk. This is particularly helpful
when trying to diagnose issues with a real repository example.

However, for test cases we might want to compare the index contents of
two repositories that were updated in similar ways, but will not
actually share the same stat data. Add the '--no-stat' option to remove
the timestamps and other stat data from the output. This allows us to
compare index contents directly.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-read-cache.c               | 44 ++++++++++++++----------
 t/t1092-sparse-checkout-compatibility.sh |  2 +-
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index cd7d106a675..f858d0d0a0c 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -2,16 +2,18 @@
 #include "cache.h"
 #include "config.h"
 
-static void print_cache_entry(struct cache_entry *ce)
+static void print_cache_entry(struct cache_entry *ce, unsigned stat)
 {
-	/* stat info */
-	printf("%08x %08x %08x %08x %08x %08x ",
-	       ce->ce_stat_data.sd_ctime.sec,
-	       ce->ce_stat_data.sd_ctime.nsec,
-	       ce->ce_stat_data.sd_mtime.sec,
-	       ce->ce_stat_data.sd_mtime.nsec,
-	       ce->ce_stat_data.sd_dev,
-	       ce->ce_stat_data.sd_ino);
+	if (stat) {
+		/* stat info */
+		printf("%08x %08x %08x %08x %08x %08x ",
+		ce->ce_stat_data.sd_ctime.sec,
+		ce->ce_stat_data.sd_ctime.nsec,
+		ce->ce_stat_data.sd_mtime.sec,
+		ce->ce_stat_data.sd_mtime.nsec,
+		ce->ce_stat_data.sd_dev,
+		ce->ce_stat_data.sd_ino);
+	}
 
 	/* mode in binary */
 	printf("0b%d%d%d%d ",
@@ -28,48 +30,52 @@ static void print_cache_entry(struct cache_entry *ce)
 	printf("%s\n", ce->name);
 }
 
-static void print_cache(struct index_state *cache)
+static void print_cache(struct index_state *cache, unsigned stat)
 {
 	int i;
 	for (i = 0; i < the_index.cache_nr; i++)
-		print_cache_entry(the_index.cache[i]);
+		print_cache_entry(the_index.cache[i], stat);
 }
 
 int cmd__read_cache(int argc, const char **argv)
 {
+	struct repository *r = the_repository;
 	int i, cnt = 1;
 	const char *name = NULL;
 	int table = 0;
+	int stat = 1;
 
 	for (++argv, --argc; *argv && starts_with(*argv, "--"); ++argv, --argc) {
 		if (skip_prefix(*argv, "--print-and-refresh=", &name))
 			continue;
-		if (!strcmp(*argv, "--table")) {
+		if (!strcmp(*argv, "--table"))
 			table = 1;
-		}
+		else if (!strcmp(*argv, "--no-stat"))
+			stat = 0;
 	}
 
 	if (argc == 1)
 		cnt = strtol(argv[0], NULL, 0);
 	setup_git_directory();
 	git_config(git_default_config, NULL);
+
 	for (i = 0; i < cnt; i++) {
-		read_cache();
+		repo_read_index(r);
 		if (name) {
 			int pos;
 
-			refresh_index(&the_index, REFRESH_QUIET,
+			refresh_index(r->index, REFRESH_QUIET,
 				      NULL, NULL, NULL);
-			pos = index_name_pos(&the_index, name, strlen(name));
+			pos = index_name_pos(r->index, name, strlen(name));
 			if (pos < 0)
 				die("%s not in index", name);
 			printf("%s is%s up to date\n", name,
-			       ce_uptodate(the_index.cache[pos]) ? "" : " not");
+			       ce_uptodate(r->index->cache[pos]) ? "" : " not");
 			write_file(name, "%d\n", i);
 		}
 		if (table)
-			print_cache(&the_index);
-		discard_cache();
+			print_cache(r->index, stat);
+		discard_index(r->index);
 	}
 	return 0;
 }
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 8876eae0fe3..3aa9b0d21b4 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -132,7 +132,7 @@ test_sparse_match () {
 
 test_expect_success 'expanded in-memory index matches full index' '
 	init_repos &&
-	test_sparse_match test-tool read-cache --expand --table-no-stat
+	test_sparse_match test-tool read-cache --expand --table --no-stat
 '
 
 test_expect_success 'status with options' '
-- 
gitgitgadget

