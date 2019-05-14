Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C76E51F461
	for <e@80x24.org>; Tue, 14 May 2019 18:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfENSsG (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 14:48:06 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39255 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfENSsD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 14:48:03 -0400
Received: by mail-yb1-f193.google.com with SMTP id x5so47844ybn.6
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pszLTzp5Z406tJwGmtSnZ3WOd8K6Ad+41tRmaMknIvU=;
        b=Mtxkwb4zqZqNues35pZQ4nG+TV6OQMMB1JSO2apn85LI2WbUH6T6m/69PaOfMlAjcZ
         H5zCjvM4JblyKFytkCPD466nOqjgCX1AUOo6DbDRJ7hVU9fj30ROtnVaelvFnghVPUGA
         Ajf6txA8np2cZs7aJ/FvGaapGMrEw7ke+FFgx8tfNYMmlVDFXyBChkJiEdLzAP/zYGkM
         Wirj8SQogCXe5umLY0mwaYPprph1C1qNL2SgDUT3jQGlBF6w6F0ECSUqxi5NSHjxqyvK
         /PShrtMQv7QImjoGmSNNnmSIoeqi5qqpDXrZXtx1SBj3GbHXr0doZulvPjAPal282017
         00IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pszLTzp5Z406tJwGmtSnZ3WOd8K6Ad+41tRmaMknIvU=;
        b=t0h4O6uckEN544qFAsBxgHyTCfXrxQGmfbPN95v+q0VIxJIWBdPZr6CHFliB/69P4n
         z3vNjy3lkoi55jNwemB2gAK1uoeNuMJpHPfQBrrThSsgIsEt6ruJ/gz1OLH0ZZ7p6vcE
         WPTxZfeCaGomLtAnnmQhaBlgLN2mB0diYvaLm+6bzTswhYsxxPPI/78BGtJ3C1APrQTe
         uLdpPOEKaBjUdTsEBVyrkzrHQdkiw0UMg7YOWHyf7BnvsRbTeg4vFD3S4Z8cSCuUGgGE
         8zSNIxFJbSsOOCljfg8R3J7ruFSYNSQp84UVdq5wR/fxFmhpqv3fUREdZfGuhBzVwgnd
         nTMg==
X-Gm-Message-State: APjAAAW3kUpE9Mj/82caXNOoQY8GvNbzkBVtIEPnphGhVjjtrQGqkPQ0
        dlj0GR1XMqBgWRlchCFeQNJocddgCXU=
X-Google-Smtp-Source: APXvYqzEygPmt32XJ3odliOfBhBdGHHlI6ub8VLqZrWLzooUuHewlQxf+7L96h7hbiIE5IILahCDoA==
X-Received: by 2002:a25:f506:: with SMTP id a6mr18246992ybe.33.1557859682748;
        Tue, 14 May 2019 11:48:02 -0700 (PDT)
Received: from linux.mshome.net ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id u17sm3438627ywu.94.2019.05.14.11.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:48:02 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v6 04/11] midx: simplify computation of pack name lengths
Date:   Tue, 14 May 2019 18:47:47 +0000
Message-Id: <20190514184754.3196-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.22.0.rc0
In-Reply-To: <20190514184754.3196-1-dstolee@microsoft.com>
References: <20190424151428.170316-1-dstolee@microsoft.com>
 <20190514184754.3196-1-dstolee@microsoft.com>
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
index 3b7da1a360..62404620ad 100644
--- a/midx.c
+++ b/midx.c
@@ -433,7 +433,6 @@ struct pack_list {
 	uint32_t nr;
 	uint32_t alloc_list;
 	uint32_t alloc_names;
-	size_t pack_name_concat_len;
 	struct multi_pack_index *m;
 };
 
@@ -468,7 +467,6 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 		}
 
 		packs->names[packs->nr] = xstrdup(file_name);
-		packs->pack_name_concat_len += strlen(file_name) + 1;
 		packs->nr++;
 	}
 }
@@ -812,6 +810,7 @@ int write_midx_file(const char *object_dir)
 	uint32_t nr_entries, num_large_offsets = 0;
 	struct pack_midx_entry *entries = NULL;
 	int large_offsets_needed = 0;
+	int pack_name_concat_len = 0;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -827,7 +826,6 @@ int write_midx_file(const char *object_dir)
 	packs.alloc_names = packs.alloc_list;
 	packs.list = NULL;
 	packs.names = NULL;
-	packs.pack_name_concat_len = 0;
 	ALLOC_ARRAY(packs.list, packs.alloc_list);
 	ALLOC_ARRAY(packs.names, packs.alloc_names);
 
@@ -838,7 +836,6 @@ int write_midx_file(const char *object_dir)
 
 			packs.list[packs.nr] = NULL;
 			packs.names[packs.nr] = xstrdup(packs.m->pack_names[i]);
-			packs.pack_name_concat_len += strlen(packs.names[packs.nr]) + 1;
 			packs.nr++;
 		}
 	}
@@ -848,10 +845,6 @@ int write_midx_file(const char *object_dir)
 	if (packs.m && packs.nr == packs.m->num_packs)
 		goto cleanup;
 
-	if (packs.pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
-		packs.pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
-					      (packs.pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
-
 	ALLOC_ARRAY(pack_perm, packs.nr);
 	sort_packs_by_name(packs.names, packs.nr, pack_perm);
 
@@ -864,6 +857,13 @@ int write_midx_file(const char *object_dir)
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
@@ -881,7 +881,7 @@ int write_midx_file(const char *object_dir)
 
 	cur_chunk++;
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDFANOUT;
-	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + packs.pack_name_concat_len;
+	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + pack_name_concat_len;
 
 	cur_chunk++;
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;
-- 
2.22.0.rc0

