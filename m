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
	by dcvr.yhbt.net (Postfix) with ESMTP id 245071F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932864AbeFGOD6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:03:58 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45619 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932838AbeFGODy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:03:54 -0400
Received: by mail-qt0-f196.google.com with SMTP id i18-v6so9912402qtp.12
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sq1oSyG8U8G413iqc4yS1Lfc+ihf0pI41f9mJCQpwoI=;
        b=lF3T80BeMBvM/vpIUkMa4Giefc2GhjG9ksYsF0vTtZSZgOonMuekRagQSwEteDdHJK
         OsI5OGGwEPrq0SPyiXalZTt7u7lCSfXMgCMa0UINSqE7X45ohSweK6Tnu8ICguswgjM/
         8b5EaZhLvP/DN8ku4WkgRCxL74imjlAnrLCdgJuWOZZ2UCa9IXAN3ALAaN3HllJCG998
         nEESNxqO5WgaVNV1Jsvi3sQVl5sDrGvvHSeHANu5yCcjJ+SnyuhIj9YMZRkYDCFJkvd9
         65YlJPzhwJXLUM1liks+kV4guI8JoZY4Xoc9HS13BTJF+rZatkTkIjfL8QwV7QoezAvc
         SOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sq1oSyG8U8G413iqc4yS1Lfc+ihf0pI41f9mJCQpwoI=;
        b=ZD+5BboZZi+1zFXfzFqU1KL/bPbBuhaERy2YXEIDKFE92aJFqhRfTeWsfkeA6/i34q
         ASR9r08PVpvXVXmAvJIYz0dUn5P2L409F8LSDwLKquxrmFBWQGAFmCL9K2yIzBd8lyWt
         gVOgXIFtl0bsa+I+9wy1Jg1jiLiMc8Hlu3mgEIIqtGF9dBe903xTPsnlxf/Vv4Rc7/6F
         MnjdReZSstDOC+ODuvtI+cFsjTTV+mTJ/5nyeBJqrcel+jL8qcUZGUIO/HNecgpXtsvo
         MQnPZgQolnxlnWW71DPnD4GzkOyLjDgejS/18iSaGlQmJsF0y8U1lWH1XiHfelldpC+Z
         0XPg==
X-Gm-Message-State: APt69E3eBBslAewhmC7InJUC315ZT0LJOw2+Z/ZvoQzLhB2K4inB0+k3
        WSa7MH0XzKTT4yFYsngBCU12wq5V
X-Google-Smtp-Source: ADUXVKLUspYOW7RZ6U+VVruMj2Lagw+rANZHqfGnROOWpL7+ASgbN45VpB5rQzcrEbrpwFjtLPg3sg==
X-Received: by 2002:aed:3b3b:: with SMTP id p56-v6mr1812209qte.372.1528380233546;
        Thu, 07 Jun 2018 07:03:53 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:03:52 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 09/23] midx: write pack names in chunk
Date:   Thu,  7 Jun 2018 10:03:24 -0400
Message-Id: <20180607140338.32440-10-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The multi-pack-index (MIDX) needs to track which pack-files are covered
by the MIDX file. Store these in our first required chunk. Since
filenames are not well structured, add padding to keep good alignment in
later chunks.

Modify the 'git midx read' subcommand to output the existence of the
pack-file name chunk. Modify t5319-midx.sh to reflect this new output
and the new expected number of chunks.

Defense in depth: A pattern we are using in the multi-pack-index feature
is to verify the data as we write it. We want to ensure we never write
invalid data to the multi-pack-index. There are many checks during the
write of a MIDX file that double-check that the values we are writing
fit the format definitions. If any value is incorrect, then we notice
before writing invalid data. This mainly helps developers while working
on the feature, but it can also identify issues that only appear when
dealing with very large data sets. These large sets are hard to encode
into test cases.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/pack-format.txt |   6 +
 builtin/midx.c                          |   7 +
 midx.c                                  | 176 +++++++++++++++++++++++-
 object-store.h                          |   2 +
 t/t5319-midx.sh                         |   3 +-
 5 files changed, 188 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 17666b4bfc..2b37be7b33 100644
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
diff --git a/builtin/midx.c b/builtin/midx.c
index c7002f664a..fe56560853 100644
--- a/builtin/midx.c
+++ b/builtin/midx.c
@@ -28,6 +28,13 @@ static int read_midx_file(const char *object_dir)
 	       m->num_chunks,
 	       m->num_packs);
 
+	printf("chunks:");
+
+	if (m->chunk_pack_names)
+		printf(" pack_names");
+
+	printf("\n");
+
 	printf("object_dir: %s\n", m->object_dir);
 
 	return 0;
diff --git a/midx.c b/midx.c
index 9fb89c80a2..d4f4a01a51 100644
--- a/midx.c
+++ b/midx.c
@@ -13,6 +13,11 @@
 #define MIDX_HASH_LEN 20
 #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + MIDX_HASH_LEN)
 
+#define MIDX_MAX_CHUNKS 1
+#define MIDX_CHUNK_ALIGNMENT 4
+#define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
+#define MIDX_CHUNKLOOKUP_WIDTH (sizeof(uint32_t) + sizeof(uint64_t))
+
 static char *get_midx_filename(const char *object_dir)
 {
 	struct strbuf midx_name = STRBUF_INIT;
@@ -29,6 +34,7 @@ struct midxed_git *load_midxed_git(const char *object_dir)
 	size_t midx_size;
 	void *midx_map;
 	const char *midx_name = get_midx_filename(object_dir);
+	uint32_t i;
 
 	fd = git_open(midx_name);
 	if (fd < 0)
@@ -74,6 +80,31 @@ struct midxed_git *load_midxed_git(const char *object_dir)
 	m->num_chunks = *(m->data + 6);
 	m->num_packs = get_be32(m->data + 8);
 
+	for (i = 0; i < m->num_chunks; i++) {
+		uint32_t chunk_id = get_be32(m->data + 12 + MIDX_CHUNKLOOKUP_WIDTH * i);
+		uint64_t chunk_offset = get_be64(m->data + 16 + MIDX_CHUNKLOOKUP_WIDTH * i);
+
+		switch (chunk_id) {
+			case MIDX_CHUNKID_PACKNAMES:
+				m->chunk_pack_names = m->data + chunk_offset;
+				break;
+
+			case 0:
+				die("terminating MIDX chunk id appears earlier than expected");
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
+		die("MIDX missing required pack-name chunk");
+
 	return m;
 
 cleanup_fail:
@@ -99,18 +130,88 @@ static size_t write_midx_header(struct hashfile *f,
 	return MIDX_HEADER_SIZE;
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
+		bzero(padding, sizeof(padding));
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
 	struct hashfile *f;
 	struct lock_file lk;
 	struct packed_git **packs = NULL;
+	char **pack_names = NULL;
+	uint32_t *pack_perm;
 	uint32_t i, nr_packs = 0, alloc_packs = 0;
+	uint32_t alloc_pack_names = 0;
 	DIR *dir;
 	struct dirent *de;
 	struct strbuf pack_dir = STRBUF_INIT;
 	size_t pack_dir_len;
+	uint64_t pack_name_concat_len = 0;
+	uint64_t written = 0;
+	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
+	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -132,12 +233,14 @@ int write_midx_file(const char *object_dir)
 	strbuf_addch(&pack_dir, '/');
 	pack_dir_len = pack_dir.len;
 	ALLOC_ARRAY(packs, alloc_packs);
+	ALLOC_ARRAY(pack_names, alloc_pack_names);
 	while ((de = readdir(dir)) != NULL) {
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
 
 		if (ends_with(de->d_name, ".idx")) {
 			ALLOC_GROW(packs, nr_packs + 1, alloc_packs);
+			ALLOC_GROW(pack_names, nr_packs + 1, alloc_pack_names);
 
 			strbuf_setlen(&pack_dir, pack_dir_len);
 			strbuf_addstr(&pack_dir, de->d_name);
@@ -145,21 +248,83 @@ int write_midx_file(const char *object_dir)
 			packs[nr_packs] = add_packed_git(pack_dir.buf,
 							 pack_dir.len,
 							 0);
-			if (!packs[nr_packs])
+			if (!packs[nr_packs]) {
 				warning("failed to add packfile '%s'",
 					pack_dir.buf);
-			else
-				nr_packs++;
+				continue;
+			}
+
+			pack_names[nr_packs] = xstrdup(de->d_name);
+			pack_name_concat_len += strlen(de->d_name) + 1;
+			nr_packs++;
 		}
 	}
+
 	closedir(dir);
 	strbuf_release(&pack_dir);
 
+	if (pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
+		pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
+					(pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
+
+	ALLOC_ARRAY(pack_perm, nr_packs);
+	sort_packs_by_name(pack_names, nr_packs, pack_perm);
+
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	FREE_AND_NULL(midx_name);
 
-	write_midx_header(f, num_chunks, nr_packs);
+	cur_chunk = 0;
+	num_chunks = 1;
+
+	written = write_midx_header(f, num_chunks, nr_packs);
+
+	chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
+	chunk_offsets[cur_chunk] = written + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
+
+	cur_chunk++;
+	chunk_ids[cur_chunk] = 0;
+	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + pack_name_concat_len;
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
+			BUG("inccrrect chunk offset (%"PRIu64" != %"PRIu64") for chunk id %"PRIx32,
+			    chunk_offsets[i],
+			    written,
+			    chunk_ids[i]);
+
+		switch (chunk_ids[i]) {
+			case MIDX_CHUNKID_PACKNAMES:
+				written += write_midx_pack_names(f, pack_names, nr_packs);
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
@@ -170,5 +335,6 @@ int write_midx_file(const char *object_dir)
 	}
 
 	FREE_AND_NULL(packs);
+	FREE_AND_NULL(pack_names);
 	return 0;
 }
diff --git a/object-store.h b/object-store.h
index 77cb82621a..199cf4bd44 100644
--- a/object-store.h
+++ b/object-store.h
@@ -100,6 +100,8 @@ struct midxed_git {
 	uint32_t num_packs;
 	uint32_t num_objects;
 
+	const unsigned char *chunk_pack_names;
+
 	char object_dir[FLEX_ARRAY];
 };
 
diff --git a/t/t5319-midx.sh b/t/t5319-midx.sh
index abe545c7c4..fdf4f84a90 100755
--- a/t/t5319-midx.sh
+++ b/t/t5319-midx.sh
@@ -6,7 +6,8 @@ test_description='multi-pack-indexes'
 midx_read_expect() {
 	NUM_PACKS=$1
 	cat >expect <<- EOF
-	header: 4d494458 1 1 0 $NUM_PACKS
+	header: 4d494458 1 1 1 $NUM_PACKS
+	chunks: pack_names
 	object_dir: .
 	EOF
 	git midx read --object-dir=. >actual &&
-- 
2.18.0.rc1

