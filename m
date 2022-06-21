Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FC0CCA481
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 13:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiFUNeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351445AbiFUNbB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 09:31:01 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C052AC71
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 06:25:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a15so5911954pfv.13
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 06:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SwAqmWL3uzzEszhth1nDt8QRizxHE8JmPjl4J8Uz4/Q=;
        b=UHmuTvz6miUHN1o4CVvweoaGtBDex7JxJehRwMBT4i8yojCNZ4KUjqIlYqaTtN0QPn
         s+KslNRVxHf3lnOqZKhopGHSO80Ffxn+tcAVOUIhi+LYO08NdsuLYjxmgKLFoX29hM0l
         AgU864g+PqE4Lnz240DcSRzdtPmBlbFlC+Miwom+ShLZyuK6SPNxb2crRnVKb2fkQnEC
         3tM7HuOUmaEDPfW3398bk+hGixhRT12bZdtmwBkzCFU5P0At6Cse3l4Fjti25tmLV12G
         RKRpvE0pEzutfxzgaQPujEhZCdNqElY+w2SxE/FhFCaq/w8M/rQ646wG8OWLB35uwX6U
         TUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SwAqmWL3uzzEszhth1nDt8QRizxHE8JmPjl4J8Uz4/Q=;
        b=urPyZDWy4fj91BmMvKBhJ+r9BviQH1GEsh+Wri5dWn+RUUHFXSDySmnNgRSrkbUgGe
         pQp5qx8NSO7WpThavEZm6P6MnAKuRWckiZzHegqWINC8SrdjPFhecDBrBrbsaCFYs29R
         S+5Sz72kJ3lLkzgCbOiJrNB6VhI/xtutpF9nrq/9x/SlZkIndSGLVlZi9rj8H+2g6r6C
         UYLX4ExxlqDHrj233++fjj0BjpExwWqLPG8BiUkvRoMeF/ttmRHAbl30P0EpmUpiU3fz
         KULV66v4Q6TqOXLr8lGXPPoARuVxp1OUeooK5rXSLh0A1gNDx/BE5oFArTrQp6tJvnKK
         4wtw==
X-Gm-Message-State: AJIora9wQp5/BQybdSXpoBcg6vFde5sO+a+aC4x9iqid6/+WPW3fkS5S
        KTBGIrzYoD54aET4pvs73X31HZdBcwv80upj
X-Google-Smtp-Source: AGRyM1usRoe1alOz/OqbqYnYiaub6wGyh472ZZdzq1BKh02JoOtv2BLIrGISRwZGiCIoll4fabkpyQ==
X-Received: by 2002:a63:149:0:b0:40c:f753:2fb0 with SMTP id 70-20020a630149000000b0040cf7532fb0mr3103419pgb.172.1655817926886;
        Tue, 21 Jun 2022 06:25:26 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.41])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b0016a058b7547sm8602426pln.294.2022.06.21.06.25.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2022 06:25:26 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 5/5] bitmap: add trace2 outputs during open "bitmap" file
Date:   Tue, 21 Jun 2022 21:25:05 +0800
Message-Id: <8735ae99798a43650acb9a1df7ba2072c7758476.1655817253.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g270d558070.dirty
In-Reply-To: <cover.1655817253.git.dyroneteng@gmail.com>
References: <cover.1655817253.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's supported for a repo to use bitmap in both single-pack bitmap
way or a multi-pack(MIDX) bitmap. Either of two bitmap kinds can
exist in the repository, or both can be stored but let the config
controls which kind of bitmap is used (like "core.multipackIndex",
etc.). Because of this, sometimes the bitmap debug path is not
obvious enough, for example, when executing:

 $ git rev-list  --test-bitmap  HEAD
 fatal: failed to load bitmap indexes

When the output look like this, it's unclear which kind(s) of
.bitmap exist, and which were read. For example, it's possible a MIDX
bitmap exists, but was not read (e.g., because
core.multiPackIndex=false), among many other scenarios.

Therefore, we added some trace2 code so that when we read the bitmap
we can be more clear about the decision path, such as whether it is
working on MIDX or single-pack bitmap at present, or the related config
is enabled or not. This may help with logging, user troubleshooting, and
development debugging.

Here are some brief output (omitted some unrelated or repetitive rows
and columns, using "..." instead of) examples on two scenarios when
executing:

  $ GIT_TRACE2_PERF=1 git rev-list --test-bitmap HEAD

Scenario 1:
  core.multipackIndex [false], MIDX bitmap exists [Y], single-pack bitmap exists [N]

  ...
  ... | main                     | data         | r1  | ... | config       | core.multipackindex:false
  ... | d0 | main                | region_enter | r1  | ... | pack-bitmap  | label:open_bitmap
  ... | d0 | main                | data         | r1  | ... | bitmap       | ..path:.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
  ... | main                     | region_leave | r1  | ... | pack-bitmap  | label:open_bitmap
  ... | main                     | error        |     | ... |              | failed to load bitmap indexes
  fatal: failed to load bitmap indexes
  ... | d0 | main                | exit         |     | ... |              | code:128
  ...

Scenario 2:
  core.multipackIndex [false], MIDX bitmap exists [Y], single-pack bitmap exists [Y]

  ... | d0 | main                | region_enter | r0  | ... | pack-bitmap  | label:open_bitmap
  ... | d0 | main                | data         | r0  | ... | bitmap       | ..path:/home/tenglong.tl/test/dyrone_bitmap/.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
  ... | main                     | region_leave | r0  | ... | pack-bitmap  | label:open_bitmap
  Bitmap v1 test (1 entries loaded)
  Found bitmap for d864fefa87415d6cd289c72aa9ffd45b4a8ffd84. 64 bits / 11030517 checksum
  ... | main                     | region_enter | r0  | ... | progress     | label:Verifying bitmap entries
  Verifying bitmap entries: 100% (3/3), done.
  ... | main                     | data         | r0  | ... | progress     | ..total_objects:3
  ... | main                     | region_leave | r0  | ... | progress     | label:Verifying bitmap entries
  OK!
  ... | d0 | main                | exit         |     | ... |              | code:0
  ...

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c   | 21 ++++++++++++++++-----
 repo-settings.c | 22 ++++++++++++----------
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index a54d5a0c9f..c39d722592 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -312,9 +312,12 @@ char *pack_bitmap_filename(struct packed_git *p)
 static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 			      struct multi_pack_index *midx)
 {
+	int fd;
 	struct stat st;
+
 	char *bitmap_name = midx_bitmap_filename(midx);
-	int fd = git_open(bitmap_name);
+	trace2_data_string("midx", the_repository, "path", bitmap_name);
+	fd = git_open(bitmap_name);
 
 	free(bitmap_name);
 
@@ -346,8 +349,10 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	if (load_bitmap_header(bitmap_git) < 0)
 		goto cleanup;
 
-	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum))
+	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum)) {
+		error(_("midx and bitmap checksum don't match"));
 		goto cleanup;
+	}
 
 	if (load_midx_revindex(bitmap_git->midx) < 0) {
 		warning(_("multi-pack bitmap is missing required reverse index"));
@@ -374,6 +379,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		return -1;
 
 	bitmap_name = pack_bitmap_filename(packfile);
+	trace2_data_string("bitmap", the_repository, "path", bitmap_name);
 	fd = git_open(bitmap_name);
 	free(bitmap_name);
 
@@ -509,11 +515,16 @@ static int open_midx_bitmap(struct repository *r,
 static int open_bitmap(struct repository *r,
 		       struct bitmap_index *bitmap_git)
 {
-	assert(!bitmap_git->map);
+	int ret = 0;
 
+	assert(!bitmap_git->map);
+	trace2_region_enter("pack-bitmap", "open_bitmap", r);
 	if (!open_midx_bitmap(r, bitmap_git))
-		return 0;
-	return open_pack_bitmap(r, bitmap_git);
+		goto done;
+	ret = open_pack_bitmap(r, bitmap_git);
+done:
+	trace2_region_leave("pack-bitmap", "open_bitmap", r);
+	return ret;
 }
 
 struct bitmap_index *prepare_bitmap_git(struct repository *r)
diff --git a/repo-settings.c b/repo-settings.c
index b4fbd16cdc..115d96ece3 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -4,10 +4,12 @@
 #include "midx.h"
 
 static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
-			  int def)
+			  int def, int trace)
 {
 	if (repo_config_get_bool(r, key, dest))
 		*dest = def;
+	if (trace)
+		trace2_data_string("config", r, key, *dest ? "true" : "false");
 }
 
 void prepare_repo_settings(struct repository *r)
@@ -29,8 +31,8 @@ void prepare_repo_settings(struct repository *r)
 	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
 
 	/* Booleans config or default, cascades to other settings */
-	repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
-	repo_cfg_bool(r, "feature.experimental", &experimental, 0);
+	repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0, 0);
+	repo_cfg_bool(r, "feature.experimental", &experimental, 0, 0);
 
 	/* Defaults modified by feature.* */
 	if (experimental) {
@@ -42,13 +44,13 @@ void prepare_repo_settings(struct repository *r)
 	}
 
 	/* Boolean config or default, does not cascade (simple)  */
-	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
-	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
-	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
-	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
-	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
-	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
-	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
+	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1, 0);
+	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1, 0);
+	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1, 0);
+	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0, 0);
+	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1, 0);
+	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1, 1);
+	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0, 0);
 
 	/*
 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
-- 
2.35.1.582.g270d558070.dirty

