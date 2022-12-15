Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0BCC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 08:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiLOIw7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 03:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLOIwo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 03:52:44 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C5128714
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:35 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h10so2308143wrx.3
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REhBwwEAcN2xjU5gGrSvsaNfDkxGIV2peZZlOOg9rkE=;
        b=oriB7m+EjA3JOMQDv+QEr3jfDxdReNzphqdcDpeYxiSmC3vlyxaT7mlHcK/4HXWSKt
         ylWPGEZtTveSqkcmitnfIsChe4t4eG6Xa2Ts7Eybcg0xcF5pE8XiulZUKA6MEORYkPRS
         3UZ+5FhcD/2sxVe2NlxUJhCLX9Egt11CvQEh0Be3Db4XWun8eLiCOub1dFHA+asdLSgq
         WpGVszxxuhvdoREmemVWB/KgEfqcYG2hlEhcdCIrBa81gfjO2roGZW5vVAkPxe2c9auH
         CjlGrgYUoyYxsgEHQeOXui3XnRS2Vi1P+ZHCalNWFxeXEj3BRheVSfMTU9fUfqfXJbS6
         xb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REhBwwEAcN2xjU5gGrSvsaNfDkxGIV2peZZlOOg9rkE=;
        b=H5szGIETZ0AQnlZDn3RZ3OoiC3E9ewnUWyJmtxiJz15G+mzzuoqGW66DclOkzDqSqg
         PPEmfCLwUEBjBWl99iOW6kpk65+5WHDFXYrClJn765JMB9VIcV1rwV6KDetBEUnRfedB
         y/X0Pc6NRQ+oXouCZGY/1V/yRuOuSJ6bXjBJxnx9IOgHaadG0r8kvRvFGRoAxA9i5zyZ
         GUv8Ns89lE8eWi0blWLa4uiyWhrJNxPud46sOIqqDfPPZNXmISn/NrYum2add1O7aTXf
         I8mjFiBMcTocoY7qH6AmJHbmJjploxlsKKURQumRWxm1DSgduPZFNX/ClirbehSNR0Ur
         OJeA==
X-Gm-Message-State: ANoB5pkLu2RZ2mI7pJ/1MjXlrthOfOmkZ7+jtoMK9nDqo/szstUNUWCc
        j2Zp31cE+Lwninp1E56jDt3gQfmn8dcK0Q==
X-Google-Smtp-Source: AA0mqf5dypXE8p2nHh+SSUqn283RTr487aDLZxV8rslc2hYAyN/Btdqm9sTbbEmvHybcUSUg7Ct6fg==
X-Received: by 2002:adf:dbc4:0:b0:242:bef:80a7 with SMTP id e4-20020adfdbc4000000b002420bef80a7mr18754142wrj.49.1671094353481;
        Thu, 15 Dec 2022 00:52:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r10-20020a0560001b8a00b0024274a5db0asm5464905wru.2.2022.12.15.00.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:52:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 09/12] builtin/merge-index.c: don't USE_THE_INDEX_VARIABLE
Date:   Thu, 15 Dec 2022 09:52:13 +0100
Message-Id: <patch-v10-09.12-fc9a05ee034-20221215T084803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
References: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com> <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove "USE_THE_INDEX_VARIABLE" and instead pass "the_index" around
between the functions in this file. In a subsequent commit we'll
libify this, and don't want to use "USE_THE_INDEX_VARIABLE" in any
more places in the top-level *.c files. Doing this first makes that
diff a lot smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-index.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index cd160779cbf..c269d76cc8f 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "parse-options.h"
 #include "run-command.h"
@@ -7,7 +6,7 @@ static const char *pgm;
 static int one_shot, quiet;
 static int err;
 
-static int merge_entry(int pos, const char *path)
+static int merge_entry(struct index_state *istate, int pos, const char *path)
 {
 	int found;
 	const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
@@ -15,11 +14,11 @@ static int merge_entry(int pos, const char *path)
 	char ownbuf[4][60];
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
-	if (pos >= the_index.cache_nr)
+	if (pos >= istate->cache_nr)
 		die(_("'%s' is not in the cache"), path);
 	found = 0;
 	do {
-		const struct cache_entry *ce = the_index.cache[pos];
+		const struct cache_entry *ce = istate->cache[pos];
 		int stage = ce_stage(ce);
 
 		if (strcmp(ce->name, path))
@@ -29,7 +28,7 @@ static int merge_entry(int pos, const char *path)
 		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
 		arguments[stage] = hexbuf[stage];
 		arguments[stage + 4] = ownbuf[stage];
-	} while (++pos < the_index.cache_nr);
+	} while (++pos < istate->cache_nr);
 	if (!found)
 		die(_("'%s' is not in the cache"), path);
 
@@ -46,27 +45,27 @@ static int merge_entry(int pos, const char *path)
 	return found;
 }
 
-static void merge_one_path(const char *path)
+static void merge_one_path(struct index_state *istate, const char *path)
 {
-	int pos = index_name_pos(&the_index, path, strlen(path));
+	int pos = index_name_pos(istate, path, strlen(path));
 
 	/*
 	 * If it already exists in the cache as stage0, it's
 	 * already merged and there is nothing to do.
 	 */
 	if (pos < 0)
-		merge_entry(-pos-1, path);
+		merge_entry(istate, -pos-1, path);
 }
 
-static void merge_all(void)
+static void merge_all(struct index_state *istate)
 {
 	int i;
 
-	for (i = 0; i < the_index.cache_nr; i++) {
-		const struct cache_entry *ce = the_index.cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
 		if (!ce_stage(ce))
 			continue;
-		i += merge_entry(i, ce->name)-1;
+		i += merge_entry(istate, i, ce->name)-1;
 	}
 }
 
@@ -119,13 +118,13 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	repo_read_index(the_repository);
 
 	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
+	ensure_full_index(the_repository->index);
 
 	if (all)
-		merge_all();
+		merge_all(the_repository->index);
 	else
 		for (size_t i = 0; i < argc; i++)
-			merge_one_path(argv[i]);
+			merge_one_path(the_repository->index, argv[i]);
 
 	if (err && !quiet)
 		die(_("merge program failed"));
-- 
2.39.0.rc2.1048.g0e5493b8d5b

