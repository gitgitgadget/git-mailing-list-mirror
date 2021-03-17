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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616B3C4332D
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ED4464F50
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhCQN2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhCQN2s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 09:28:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7924DC06175F
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:28:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e9so1815016wrw.10
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jI0c6IHLJzOwG3N4LGmnbajKDd/cYx+1zw642J9NzAE=;
        b=NgkrEyNd8z0afKp8TnS1/nZkLl92mQ+y4oERZRc4GLpjjnQrwnmJESmTY9N9nEVvaA
         Wjp/yeWQAV2OIs/6LhM7cZ9vsrTHHi4ZtSbTBGOeJKFDi7g5xBT5tL4XWaG0zmCMDSpG
         PcC0Jaez/c3/mcN7gnorD3+L1g6QkAEo9wL8LF0t2LRNdUMJIQ2SPYGZfO192IttvWRb
         JlY4d0F1ENi0cASX5Y+59yClhJ2MIuuowVVEENZz8omEJ2GLcT4NyqEA62MqNCoKmPWF
         VGterBKIxA4osWJk/bC7aE43PsBYy5NR+F0METmUO8mukd+8oxaHCjwa1TCXTtHNdbZf
         /PGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jI0c6IHLJzOwG3N4LGmnbajKDd/cYx+1zw642J9NzAE=;
        b=KiHu0D2Rm4QIHgArJKl9CQJ1ottnBb7rxTe1dQAzGt6JkvHxnwUxpwY+O8jqwe7bsx
         E0bAAkf6N+ouxLUkmv2y48mLKwKzd4v82v+MhND45xwBzusjZthprHN2MWP2abrgFExa
         u06MUOzab/iFiOkpx3UREtqmYtTfMdJ+eRv/MyDZCyur5hwvCKN82Yc/CJjj056e6mks
         rDYALPjvtu9oNRk4BnPT/3ObfIch3ORjkY40ZcIXz7AWENwBQb3kdDEnFMTm79UKINug
         qeGjcav7mz35PAWAYUToO5j8qb8hBdbia9Kw40Slh1kFueB2mngHBZL9xDEhvYTvwTwr
         RJKA==
X-Gm-Message-State: AOAM532VWpTTWIDVBi3q+zJ7tMd3t/YHos6uu09piRSYD3W5VbOoerpD
        zJfL01YznxKQYfdAcFWUm2lCD4FsvtaftA==
X-Google-Smtp-Source: ABdhPJxZUhE1lejdLW6SOnW5v7kEcBxAibK9o6tVzyi4H+/67F8fOC1ffNGeFJIb19IQw7W3zlr+Ag==
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr4494979wrr.425.1615987715952;
        Wed, 17 Mar 2021 06:28:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm26061448wrt.70.2021.03.17.06.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:28:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        dstolee@microsoft.com
Subject: [RFC/PATCH 4/5] test-tool read-cache: --table is redundant to ls-files
Date:   Wed, 17 Mar 2021 14:28:13 +0100
Message-Id: <20210317132814.30175-5-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
References: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-read-cache.c | 43 --------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index b52c174acc..2499999af3 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -1,54 +1,16 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "config.h"
-#include "blob.h"
-#include "commit.h"
-#include "tree.h"
-#include "sparse-index.h"
-
-static void print_cache_entry(struct cache_entry *ce)
-{
-	const char *type;
-	printf("%06o ", ce->ce_mode & 0177777);
-
-	if (S_ISSPARSEDIR(ce->ce_mode))
-		type = tree_type;
-	else if (S_ISGITLINK(ce->ce_mode))
-		type = commit_type;
-	else
-		type = blob_type;
-
-	printf("%s %s\t%s\n",
-	       type,
-	       oid_to_hex(&ce->oid),
-	       ce->name);
-}
-
-static void print_cache(struct index_state *istate)
-{
-	int i;
-	for (i = 0; i < istate->cache_nr; i++)
-		print_cache_entry(istate->cache[i]);
-}
 
 int cmd__read_cache(int argc, const char **argv)
 {
 	struct repository *r = the_repository;
 	int i, cnt = 1;
 	const char *name = NULL;
-	int table = 0, expand = 0;
-
-	initialize_the_repository();
-	prepare_repo_settings(r);
-	r->settings.command_requires_full_index = 0;
 
 	for (++argv, --argc; *argv && starts_with(*argv, "--"); ++argv, --argc) {
 		if (skip_prefix(*argv, "--print-and-refresh=", &name))
 			continue;
-		if (!strcmp(*argv, "--table"))
-			table = 1;
-		else if (!strcmp(*argv, "--expand"))
-			expand = 1;
 	}
 
 	if (argc == 1)
@@ -59,9 +21,6 @@ int cmd__read_cache(int argc, const char **argv)
 	for (i = 0; i < cnt; i++) {
 		repo_read_index(r);
 
-		if (expand)
-			ensure_full_index(r->index);
-
 		if (name) {
 			int pos;
 
@@ -74,8 +33,6 @@ int cmd__read_cache(int argc, const char **argv)
 			       ce_uptodate(r->index->cache[pos]) ? "" : " not");
 			write_file(name, "%d\n", i);
 		}
-		if (table)
-			print_cache(r->index);
 		discard_index(r->index);
 	}
 	return 0;
-- 
2.31.0.260.g719c683c1d

