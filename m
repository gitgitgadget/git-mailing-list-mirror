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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F4C51F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbeGLTv0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:26 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35209 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbeGLTvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:25 -0400
Received: by mail-qk0-f194.google.com with SMTP id u21-v6so16068082qku.2
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C5Lkka3rehqfaGEgy8xUdraHojUVz8u+vLDsJv4Bae8=;
        b=hjla5dYv4IM1L3pG3BxNmU6umsPFh38nWVSO2QIUX+Ou61X+6lBUeGjKCGl4cSxdvT
         6OxRYjiYGZLHVV+2BeiVG+SIWvdof94+lzvb5IZg3MLDhdIZXmO/N3UXSmuPR4NHtIYK
         Lq2NS96M4VGGlBEShJGF9/cDC9sqd4OTWwqOKoa1jWD7P1pVXcq9GTsS4Qfm9EKCDuLG
         dUPtDF6qOXPznhwxyLpCiiffWR2oiUKGWTu8uvmYXbV9hfrB5TqL3L74mwvZhpCr+hMK
         LnpDAAdQfJfDmiDcHWkfQ7YOAce5r/uJ0QZn92nV73RssXe4QtEupxGjUX9Ew2j8g470
         VHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C5Lkka3rehqfaGEgy8xUdraHojUVz8u+vLDsJv4Bae8=;
        b=nUGcbhqe+TGnIK/3+/7ASoCQEkgH7saXTet+SPvTQouzV29aVhLgmOJkxqc+j4xyop
         f8wswpC1PqiApRuw11vI77UowKlyg8RpdgOJeL/mvWOFCgkQPOpKX58Nl73K4GTOij4s
         v8x19Q4yUGtuTL42AZdjMfmBOEMIFgNk2reSJgdafMtk9/L5/Rv46AEwWEuf0hTMxa8Z
         dWVqXLKY/i2ALyy/PxWL0/8ASbPwtnjrHfwpa0EVS+fdK8Z87mAk0uHc38K2NlmmnGrH
         0p4rNALJ/YgV25AbHr+0mErlsseCyWKyQZFQiidYwFFxoFyYbavlPY+FXMTW9OERANl3
         VoLg==
X-Gm-Message-State: AOUpUlHyCId65NEF74tgJr8Dsg1VE5IZK160eMB59f/48HuQypsit2BX
        5Oxl4WDCtZx49b84EfI05g/HXf2rbX4=
X-Google-Smtp-Source: AAOMgpe1x5fQrtomO96c4tlrb3Hd5WBb8Im75VXwj2RUwyxJmCgyEjeKfr17suM9DkGkauiL7HC2IQ==
X-Received: by 2002:a37:4ecb:: with SMTP id c194-v6mr2918628qkb.345.1531424423016;
        Thu, 12 Jul 2018 12:40:23 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:22 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 10/23] multi-pack-index: write pack names in chunk
Date:   Thu, 12 Jul 2018 15:39:27 -0400
Message-Id: <20180712193940.21065-11-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The multi-pack-index needs to track which packfiles it indexes. Store
these in our first required chunk. Since filenames are not well
structured, add padding to keep good alignment in later chunks.

Modify the 'git multi-pack-index read' subcommand to output the
existence of the pack-file name chunk. Modify t5319-multi-pack-index.sh
to reflect this new output and the new expected number of chunks.

Defense in depth: A pattern we are using in the multi-pack-index feature
is to verify the data as we write it. We want to ensure we never write
invalid data to the multi-pack-index. There are many checks that verify
that the values we are writing fit the format definitions. This mainly
helps developers while working on the feature, but it can also identify
issues that only appear when dealing with very large data sets. These
large sets are hard to encode into test cases.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/pack-format.txt |   6 +
 midx.c                                  | 174 +++++++++++++++++++++++-
 midx.h                                  |   2 +
 t/helper/test-read-midx.c               |   7 +
 t/t5319-multi-pack-index.sh             |   3 +-
 5 files changed, 189 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index e060e693f4..6c5a77475f 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -296,6 +296,12 @@ CHUNK LOOKUP:
 
 CHUNK DATA:
 
+	Packfile Names (ID: {'P', 'N', 'A', 'M'})
+	    Stores the packfile names as concatenated, null-terminated strings.
+	    Packfiles must be listed in lexicographic order for fast lookups by
+	    name. This is the only chunk not guaranteed to be a multiple of four
+	    bytes in length, so should be the last chunk for alignment reasons.
+
 	(This section intentionally left incomplete.)
 
 TRAILER:
diff --git a/midx.c b/midx.c
index f742d7ccd7..ca7a32bf95 100644
--- a/midx.c
+++ b/midx.c
@@ -17,6 +17,11 @@
 #define MIDX_HASH_LEN 20
 #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + MIDX_HASH_LEN)
 
+#define MIDX_MAX_CHUNKS 1
+#define MIDX_CHUNK_ALIGNMENT 4
+#define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
+#define MIDX_CHUNKLOOKUP_WIDTH (sizeof(uint32_t) + sizeof(uint64_t))
+
 static char *get_midx_filename(const char *object_dir)
 {
 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
@@ -31,6 +36,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 	void *midx_map = NULL;
 	uint32_t hash_version;
 	char *midx_name = get_midx_filename(object_dir);
+	uint32_t i;
 
 	fd = git_open(midx_name);
 
@@ -82,6 +88,33 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 
 	m->num_packs = get_be32(m->data + MIDX_BYTE_NUM_PACKS);
 
+	for (i = 0; i < m->num_chunks; i++) {
+		uint32_t chunk_id = get_be32(m->data + MIDX_HEADER_SIZE +
+					     MIDX_CHUNKLOOKUP_WIDTH * i);
+		uint64_t chunk_offset = get_be64(m->data + MIDX_HEADER_SIZE + 4 +
+						 MIDX_CHUNKLOOKUP_WIDTH * i);
+
+		switch (chunk_id) {
+			case MIDX_CHUNKID_PACKNAMES:
+				m->chunk_pack_names = m->data + chunk_offset;
+				break;
+
+			case 0:
+				die(_("terminating multi-pack-index chunk id appears earlier than expected"));
+				break;
+
+			default:
+				/*
+				 * Do nothing on unrecognized chunks, allowing future
+				 * extensions to add optional chunks.
+				 */
+				break;
+		}
+	}
+
+	if (!m->chunk_pack_names)
+		die(_("multi-pack-index missing required pack-name chunk"));
+
 	return m;
 
 cleanup_fail:
@@ -113,8 +146,11 @@ static size_t write_midx_header(struct hashfile *f,
 
 struct pack_list {
 	struct packed_git **list;
+	char **names;
 	uint32_t nr;
 	uint32_t alloc_list;
+	uint32_t alloc_names;
+	size_t pack_name_concat_len;
 };
 
 static void add_pack_to_midx(const char *full_path, size_t full_path_len,
@@ -124,6 +160,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 
 	if (ends_with(file_name, ".idx")) {
 		ALLOC_GROW(packs->list, packs->nr + 1, packs->alloc_list);
+		ALLOC_GROW(packs->names, packs->nr + 1, packs->alloc_names);
 
 		packs->list[packs->nr] = add_packed_git(full_path,
 							full_path_len,
@@ -134,18 +171,89 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 			return;
 		}
 
+		packs->names[packs->nr] = xstrdup(file_name);
+		packs->pack_name_concat_len += strlen(file_name) + 1;
 		packs->nr++;
 	}
 }
 
+struct pack_pair {
+	uint32_t pack_int_id;
+	char *pack_name;
+};
+
+static int pack_pair_compare(const void *_a, const void *_b)
+{
+	struct pack_pair *a = (struct pack_pair *)_a;
+	struct pack_pair *b = (struct pack_pair *)_b;
+	return strcmp(a->pack_name, b->pack_name);
+}
+
+static void sort_packs_by_name(char **pack_names, uint32_t nr_packs, uint32_t *perm)
+{
+	uint32_t i;
+	struct pack_pair *pairs;
+
+	ALLOC_ARRAY(pairs, nr_packs);
+
+	for (i = 0; i < nr_packs; i++) {
+		pairs[i].pack_int_id = i;
+		pairs[i].pack_name = pack_names[i];
+	}
+
+	QSORT(pairs, nr_packs, pack_pair_compare);
+
+	for (i = 0; i < nr_packs; i++) {
+		pack_names[i] = pairs[i].pack_name;
+		perm[pairs[i].pack_int_id] = i;
+	}
+
+	free(pairs);
+}
+
+static size_t write_midx_pack_names(struct hashfile *f,
+				    char **pack_names,
+				    uint32_t num_packs)
+{
+	uint32_t i;
+	unsigned char padding[MIDX_CHUNK_ALIGNMENT];
+	size_t written = 0;
+
+	for (i = 0; i < num_packs; i++) {
+		size_t writelen = strlen(pack_names[i]) + 1;
+
+		if (i && strcmp(pack_names[i], pack_names[i - 1]) <= 0)
+			BUG("incorrect pack-file order: %s before %s",
+			    pack_names[i - 1],
+			    pack_names[i]);
+
+		hashwrite(f, pack_names[i], writelen);
+		written += writelen;
+	}
+
+	/* add padding to be aligned */
+	i = MIDX_CHUNK_ALIGNMENT - (written % MIDX_CHUNK_ALIGNMENT);
+	if (i < MIDX_CHUNK_ALIGNMENT) {
+		memset(padding, 0, sizeof(padding));
+		hashwrite(f, padding, i);
+		written += i;
+	}
+
+	return written;
+}
+
 int write_midx_file(const char *object_dir)
 {
-	unsigned char num_chunks = 0;
+	unsigned char cur_chunk, num_chunks = 0;
 	char *midx_name;
 	uint32_t i;
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct pack_list packs;
+	uint32_t *pack_perm = NULL;
+	uint64_t written = 0;
+	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
+	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -156,16 +264,76 @@ int write_midx_file(const char *object_dir)
 
 	packs.nr = 0;
 	packs.alloc_list = 16;
+	packs.alloc_names = 16;
 	packs.list = NULL;
+	packs.pack_name_concat_len = 0;
 	ALLOC_ARRAY(packs.list, packs.alloc_list);
+	ALLOC_ARRAY(packs.names, packs.alloc_names);
 
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &packs);
 
+	if (packs.pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
+		packs.pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
+					      (packs.pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
+
+	ALLOC_ARRAY(pack_perm, packs.nr);
+	sort_packs_by_name(packs.names, packs.nr, pack_perm);
+
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	FREE_AND_NULL(midx_name);
 
-	write_midx_header(f, num_chunks, packs.nr);
+	cur_chunk = 0;
+	num_chunks = 1;
+
+	written = write_midx_header(f, num_chunks, packs.nr);
+
+	chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
+	chunk_offsets[cur_chunk] = written + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
+
+	cur_chunk++;
+	chunk_ids[cur_chunk] = 0;
+	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + packs.pack_name_concat_len;
+
+	for (i = 0; i <= num_chunks; i++) {
+		if (i && chunk_offsets[i] < chunk_offsets[i - 1])
+			BUG("incorrect chunk offsets: %"PRIu64" before %"PRIu64,
+			    chunk_offsets[i - 1],
+			    chunk_offsets[i]);
+
+		if (chunk_offsets[i] % MIDX_CHUNK_ALIGNMENT)
+			BUG("chunk offset %"PRIu64" is not properly aligned",
+			    chunk_offsets[i]);
+
+		hashwrite_be32(f, chunk_ids[i]);
+		hashwrite_be32(f, chunk_offsets[i] >> 32);
+		hashwrite_be32(f, chunk_offsets[i]);
+
+		written += MIDX_CHUNKLOOKUP_WIDTH;
+	}
+
+	for (i = 0; i < num_chunks; i++) {
+		if (written != chunk_offsets[i])
+			BUG("incorrect chunk offset (%"PRIu64" != %"PRIu64") for chunk id %"PRIx32,
+			    chunk_offsets[i],
+			    written,
+			    chunk_ids[i]);
+
+		switch (chunk_ids[i]) {
+			case MIDX_CHUNKID_PACKNAMES:
+				written += write_midx_pack_names(f, packs.names, packs.nr);
+				break;
+
+			default:
+				BUG("trying to write unknown chunk id %"PRIx32,
+				    chunk_ids[i]);
+		}
+	}
+
+	if (written != chunk_offsets[num_chunks])
+		BUG("incorrect final offset %"PRIu64" != %"PRIu64,
+		    written,
+		    chunk_offsets[num_chunks]);
 
 	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	commit_lock_file(&lk);
@@ -175,8 +343,10 @@ int write_midx_file(const char *object_dir)
 			close_pack(packs.list[i]);
 			free(packs.list[i]);
 		}
+		free(packs.names[i]);
 	}
 
 	free(packs.list);
+	free(packs.names);
 	return 0;
 }
diff --git a/midx.h b/midx.h
index 0e05051bca..38af01fa3b 100644
--- a/midx.h
+++ b/midx.h
@@ -14,6 +14,8 @@ struct multi_pack_index {
 	uint32_t num_packs;
 	uint32_t num_objects;
 
+	const unsigned char *chunk_pack_names;
+
 	char object_dir[FLEX_ARRAY];
 };
 
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 988a487169..3f2d2cfa78 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -17,6 +17,13 @@ static int read_midx_file(const char *object_dir)
 	       m->num_chunks,
 	       m->num_packs);
 
+	printf("chunks:");
+
+	if (m->chunk_pack_names)
+		printf(" pack-names");
+
+	printf("\n");
+
 	printf("object-dir: %s\n", m->object_dir);
 
 	return 0;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 54117a7f49..7512d55c92 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -6,7 +6,8 @@ test_description='multi-pack-indexes'
 midx_read_expect () {
 	NUM_PACKS=$1
 	cat >expect <<-EOF
-	header: 4d494458 1 0 $NUM_PACKS
+	header: 4d494458 1 1 $NUM_PACKS
+	chunks: pack-names
 	object-dir: .
 	EOF
 	test-tool read-midx . >actual &&
-- 
2.18.0.118.gd4f65b8d14

