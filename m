Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F15D21F453
	for <e@80x24.org>; Wed, 24 Apr 2019 15:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfDXPOt (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 11:14:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44499 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730578AbfDXPOs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 11:14:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id s10so9878691qtc.11
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 08:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N6SUva1olGMN+39zFmsX7r5s+yiam+eS1v58g+8eTRI=;
        b=GYMq7SrJlW3rlP91RiZWdrtluUUdv4BabRtkVwbpbCJwmQNeo61JOuq5dxR3l7jxk8
         yttQ0ARrHzDEeItDiRBWhRDL1Mb4yyxPCDwgkiizGJttwVn1O3ODhsUuD7uwS2q+g8/f
         JVF84s1rfpEsVJokmN+n8o871VbPyL40fx4av/R4FvIOMD8ogaUyad6dvsA34mdMbVJK
         9FfALqZK+5HexTQlrzAiyjfSvv4uqX3mhXaYfkvo9zsfZELSpNXntxi4skqmbYkx/XQo
         b1tKl6VaUycwCEFUiS7ZFkXcummpG/yzVLXJFzm3WIkkm7AoDIONonkJ56AA1WIJgYIT
         yJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N6SUva1olGMN+39zFmsX7r5s+yiam+eS1v58g+8eTRI=;
        b=cZmFqoQrFOYRPpaHohwlP1CROEtqA8fGxhtFmL06k9/jco3KftqYJ8JX349dEct7TF
         ZK6Irkl5EoKhA8+bBU1G2f4ZoY6ybVJPRUVoqDZy/pidIMzJKKFXSzFIYqDrKRdAwYzF
         Th61/mo7xAE03RV2MsS/+FdWgQvAo5DLNlPfQkhLaoEBQ0asQ7wSVgyh40f+dTxqXZBe
         1ldK2AUPipBIZfATYp1iqSrqNaytlDZqQ/9nu8WPdPVxjsaFSfKI5uVPWp3xO0J0cj82
         pVqGmGgm12KIkIJe5/rnyst4HUpVwGQqmHoRujT5W/dFUcOaiO5awzH0q56L+k5N3RVp
         oOTg==
X-Gm-Message-State: APjAAAUwaW3Uf1uIreWcu3ogtQoLvf7lCJfdrA3eNz1EWfrxY7T7bsN3
        9Tju2WXGHdGW39hy4DVrKTt+uMn3
X-Google-Smtp-Source: APXvYqxUEbPqu51GDx4NIGiFlDoiVTaF7kO/5vUvLV1WJLTdg6MWaRd3+yuechsWuDwuku6NUM/VIA==
X-Received: by 2002:ac8:240a:: with SMTP id c10mr25837869qtc.217.1556118887492;
        Wed, 24 Apr 2019 08:14:47 -0700 (PDT)
Received: from stolee-gitdev.corp.microsoft.com ([2001:4898:8010:2:9efc:3578:ef3e:58d5])
        by smtp.gmail.com with ESMTPSA id j129sm9671005qkd.51.2019.04.24.08.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 08:14:46 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, avarab@gmail.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 04/11] midx: simplify computation of pack name lengths
Date:   Wed, 24 Apr 2019 11:14:21 -0400
Message-Id: <20190424151428.170316-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.21.0.1096.g1c91fdc207
In-Reply-To: <20190424151428.170316-1-dstolee@microsoft.com>
References: <pull.92.v4.git.gitgitgadget@gmail.com>
 <20190424151428.170316-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before writing the multi-pack-index, we compute the length of the
pack-index names concatenated together. This forms the data in the
pack name chunk, and we precompute it to compute chunk offsets.
The value is also modified to fit alignment needs.

Previously, this computation was coupled with adding packs from
the existing multi-pack-index and the remaining packs in the object
dir not already covered by the multi-pack-index.

In anticipation of this becoming more complicated with the 'expire'
subcommand, simplify the computation by centralizing it to a single
loop before writing the file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/midx.c b/midx.c
index bb825ef816..f087bbbe82 100644
--- a/midx.c
+++ b/midx.c
@@ -383,7 +383,6 @@ struct pack_list {
 	uint32_t nr;
 	uint32_t alloc_list;
 	uint32_t alloc_names;
-	size_t pack_name_concat_len;
 	struct multi_pack_index *m;
 };
 
@@ -418,7 +417,6 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 		}
 
 		packs->names[packs->nr] = xstrdup(file_name);
-		packs->pack_name_concat_len += strlen(file_name) + 1;
 		packs->nr++;
 	}
 }
@@ -762,6 +760,7 @@ int write_midx_file(const char *object_dir)
 	uint32_t nr_entries, num_large_offsets = 0;
 	struct pack_midx_entry *entries = NULL;
 	int large_offsets_needed = 0;
+	int pack_name_concat_len = 0;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -777,7 +776,6 @@ int write_midx_file(const char *object_dir)
 	packs.alloc_names = packs.alloc_list;
 	packs.list = NULL;
 	packs.names = NULL;
-	packs.pack_name_concat_len = 0;
 	ALLOC_ARRAY(packs.list, packs.alloc_list);
 	ALLOC_ARRAY(packs.names, packs.alloc_names);
 
@@ -788,7 +786,6 @@ int write_midx_file(const char *object_dir)
 
 			packs.list[packs.nr] = NULL;
 			packs.names[packs.nr] = xstrdup(packs.m->pack_names[i]);
-			packs.pack_name_concat_len += strlen(packs.names[packs.nr]) + 1;
 			packs.nr++;
 		}
 	}
@@ -798,10 +795,6 @@ int write_midx_file(const char *object_dir)
 	if (packs.m && packs.nr == packs.m->num_packs)
 		goto cleanup;
 
-	if (packs.pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
-		packs.pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
-					      (packs.pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
-
 	ALLOC_ARRAY(pack_perm, packs.nr);
 	sort_packs_by_name(packs.names, packs.nr, pack_perm);
 
@@ -814,6 +807,13 @@ int write_midx_file(const char *object_dir)
 			large_offsets_needed = 1;
 	}
 
+	for (i = 0; i < packs.nr; i++)
+		pack_name_concat_len += strlen(packs.names[i]) + 1;
+
+	if (pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
+		pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
+					(pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
+
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	FREE_AND_NULL(midx_name);
@@ -831,7 +831,7 @@ int write_midx_file(const char *object_dir)
 
 	cur_chunk++;
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDFANOUT;
-	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + packs.pack_name_concat_len;
+	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + pack_name_concat_len;
 
 	cur_chunk++;
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;
-- 
2.21.0.1096.g1c91fdc207

