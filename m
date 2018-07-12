Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49AED1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbeGLTvW (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:22 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34410 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbeGLTvW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:22 -0400
Received: by mail-qk0-f196.google.com with SMTP id b66-v6so16057261qkj.1
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YpuyZvESvtX83ZHEx6gKJAwtow/U6niNqb1DvWJFGFc=;
        b=mUZuftiANqCadzQxlXTCz6RlWJC//WpQdaCOLEFF2Q+3QdZCQnNo5ocDBI8BRvsZAx
         Rvd+xA6nVwgSFkcselEARocQPajCsmdzTwrC1TmQg8hIALVKb9SHUp+C5FKB47vlIkxq
         1x8ZR6qpFWHj3/Ha5zI7+73hXEpadtyclLlip4cg86QuS1uyTGiW5ctvZeDdWoQydKDN
         pKX5jodQwwKoxpQ+tec4MORrVvXGHbcuohF2+nCvrnKrbWL6viLDuYzD/BrXK3xr580f
         EsWi+uxD40htOy6OgGzZ+PO8sEuX/b8Kl2EQdJwr0JtXiJ/l41gbYG26hzSVPKJV9H/X
         Aufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YpuyZvESvtX83ZHEx6gKJAwtow/U6niNqb1DvWJFGFc=;
        b=lCczw7nySQsGbSE1pinV+w+H3BXcaIVR7Y+gdxDNqz6kblAxSzWL4afhPBGQ+afJUA
         EKGM48ikLaClTmQKK+62h62hbzshu1xBGUInt96Q0KH3Mu9AaAS7tVoVkP4xwYZzNmrP
         WplETLWqEpYE4npz1IGc1qkBXQB7VJlPo4y2MidHbTIgmDyzV5AuEtamGSg2mcA77rm9
         /7emkpvNJ/V/dt4F9qw4StgcMe5ToSsKRwf1+IdUtDhDwpBNq72eT/Yi9x4RgFBo05ED
         ZwLalKPA/CsyZ5VU9deeGD74bdH2ho58OrYSDryjyu6IYRTE3tJ6Wz3Hzd0EVN4/01dv
         lZwA==
X-Gm-Message-State: AOUpUlESU2NuGXwV6CL9sQC5wa3Q5mURkAo1yG3PZw9OuarsSVUuVp8v
        6+MmxoujrnjXp8jHVQT1SohjcXccjfc=
X-Google-Smtp-Source: AAOMgpcekG22Ti4xkspnlxxMpAALFkUjMGHzJeHk0YP8xn1iCRzpsBhIS+j44AksfULs1+Gs3U+AVw==
X-Received: by 2002:a37:fde:: with SMTP id 91-v6mr2970250qkp.278.1531424421159;
        Thu, 12 Jul 2018 12:40:21 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:20 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 09/23] multi-pack-index: read packfile list
Date:   Thu, 12 Jul 2018 15:39:26 -0400
Message-Id: <20180712193940.21065-10-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When constructing a multi-pack-index file for a given object directory,
read the files within the enclosed pack directory and find matches that
end with ".idx" and find the correct paired packfile using
add_packed_git().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 48 ++++++++++++++++++++++++++++++++++++-
 t/t5319-multi-pack-index.sh | 15 ++++++------
 2 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/midx.c b/midx.c
index c1ff5acf85..f742d7ccd7 100644
--- a/midx.c
+++ b/midx.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "csum-file.h"
+#include "dir.h"
 #include "lockfile.h"
+#include "packfile.h"
 #include "object-store.h"
 #include "midx.h"
 
@@ -109,12 +111,41 @@ static size_t write_midx_header(struct hashfile *f,
 	return MIDX_HEADER_SIZE;
 }
 
+struct pack_list {
+	struct packed_git **list;
+	uint32_t nr;
+	uint32_t alloc_list;
+};
+
+static void add_pack_to_midx(const char *full_path, size_t full_path_len,
+			     const char *file_name, void *data)
+{
+	struct pack_list *packs = (struct pack_list *)data;
+
+	if (ends_with(file_name, ".idx")) {
+		ALLOC_GROW(packs->list, packs->nr + 1, packs->alloc_list);
+
+		packs->list[packs->nr] = add_packed_git(full_path,
+							full_path_len,
+							0);
+		if (!packs->list[packs->nr]) {
+			warning(_("failed to add packfile '%s'"),
+				full_path);
+			return;
+		}
+
+		packs->nr++;
+	}
+}
+
 int write_midx_file(const char *object_dir)
 {
 	unsigned char num_chunks = 0;
 	char *midx_name;
+	uint32_t i;
 	struct hashfile *f = NULL;
 	struct lock_file lk;
+	struct pack_list packs;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -123,14 +154,29 @@ int write_midx_file(const char *object_dir)
 			  midx_name);
 	}
 
+	packs.nr = 0;
+	packs.alloc_list = 16;
+	packs.list = NULL;
+	ALLOC_ARRAY(packs.list, packs.alloc_list);
+
+	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &packs);
+
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	FREE_AND_NULL(midx_name);
 
-	write_midx_header(f, num_chunks, 0);
+	write_midx_header(f, num_chunks, packs.nr);
 
 	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	commit_lock_file(&lk);
 
+	for (i = 0; i < packs.nr; i++) {
+		if (packs.list[i]) {
+			close_pack(packs.list[i]);
+			free(packs.list[i]);
+		}
+	}
+
+	free(packs.list);
 	return 0;
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 1240127ec1..54117a7f49 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -4,8 +4,9 @@ test_description='multi-pack-indexes'
 . ./test-lib.sh
 
 midx_read_expect () {
+	NUM_PACKS=$1
 	cat >expect <<-EOF
-	header: 4d494458 1 0 0
+	header: 4d494458 1 0 $NUM_PACKS
 	object-dir: .
 	EOF
 	test-tool read-midx . >actual &&
@@ -15,7 +16,7 @@ midx_read_expect () {
 test_expect_success 'write midx with no packs' '
 	test_when_finished rm -f pack/multi-pack-index &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect
+	midx_read_expect 0
 '
 
 generate_objects () {
@@ -65,13 +66,13 @@ test_expect_success 'write midx with one v1 pack' '
 	pack=$(git pack-objects --index-version=1 pack/test <obj-list) &&
 	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx pack/multi-pack-index &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect
+	midx_read_expect 1
 '
 
 test_expect_success 'write midx with one v2 pack' '
 	git pack-objects --index-version=2,0x40 pack/test <obj-list &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect
+	midx_read_expect 1
 '
 
 test_expect_success 'add more objects' '
@@ -85,7 +86,7 @@ test_expect_success 'add more objects' '
 test_expect_success 'write midx with two packs' '
 	git pack-objects --index-version=1 pack/test-2 <obj-list &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect
+	midx_read_expect 2
 '
 
 test_expect_success 'add more packs' '
@@ -93,13 +94,13 @@ test_expect_success 'add more packs' '
 	do
 		generate_objects $j &&
 		commit_and_list_objects &&
-		git pack-objects --index-version=2 test-pack <obj-list
+		git pack-objects --index-version=2 pack/test-pack <obj-list
 	done
 '
 
 test_expect_success 'write midx with twelve packs' '
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect
+	midx_read_expect 12
 '
 
 test_done
-- 
2.18.0.118.gd4f65b8d14

