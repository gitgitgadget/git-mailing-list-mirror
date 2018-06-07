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
	by dcvr.yhbt.net (Postfix) with ESMTP id CB2AB1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932875AbeFGOEI (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:04:08 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33073 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932838AbeFGOD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:03:59 -0400
Received: by mail-qk0-f194.google.com with SMTP id h7-v6so6622103qkm.0
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pqGWM3N02WaByKeflnK66q7LceSt4XbSpbCRCh1n3ms=;
        b=Kji6IpfWWgLko9x/Alvu73X6reuLr6A0uMtzsBW43riGCRRR2sxBtVNS8gniHjJhgc
         54WJo7A+FOCEZc/YK4mTOV6N9hH19qSjs4K2UtwpGa/pdr8P2EiV0yGVL57cGUkMatam
         LmCowrbS5W3JEYzMRVoGqHA1HROfdYfPmaXReFK8AKLl7QgmgnyAcuSpMw9KwITiiH3m
         pOZBg3HPt/7VkBlUBvRqOfTMTD5XEJJ9cYH/oWubhv8NhFdbaPCVjWVqCyTjBj+E6nXu
         FBDBC7r6R9Ud0WVWk0aQXCNQ9aseLx25zQ4SoYMg2rSgX31uqWGM98ZTy92UGtTqXn78
         aB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pqGWM3N02WaByKeflnK66q7LceSt4XbSpbCRCh1n3ms=;
        b=kWf/NANlBsp1CDwkev1WcOS3Oe2S5mAWmd0C/QJshPvOChNwVIZQY72tqfyFoMEQ6N
         XE8gbadteK2zn+vEHM2c1TP2v85y4DbA/QvnYi4UfSTOzxVZKrpdpRCpkuroKmYvNYHz
         LUjr/EYrDn+Lv7eQRwseZ288ppk/T+/1VgoaZHUSBaHrXiIehCuTKudIj8uT7Z4Jy2En
         Wi+E0HGRNT/W+F465+Z47HsVCBNKfu4iQhDA3mZzXcyUnd5wnTCgsTVCvuX67lzQdksJ
         msEaZklx8FIWZC2rO4sq41V9MjDvAokI2sbtv+n6+E4oRupjqt9dIIl9hHEsk66qUZfR
         u0vg==
X-Gm-Message-State: APt69E2YUh+KgnGBXFHrh5QO8CobyF6jX3psVor8BJeT//Yoba5cQm94
        +ecxMMfh9BnkpRlKWZyqANDXs0VQ
X-Google-Smtp-Source: ADUXVKLXvekK/vv8eZKIidW1BTH0ooGxTANtfwn5eTP9/sFfQ32SszcxsnO241wCGyadBS4DUY62BQ==
X-Received: by 2002:a37:8c87:: with SMTP id o129-v6mr1668285qkd.0.1528380238636;
        Thu, 07 Jun 2018 07:03:58 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:03:57 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 13/23] midx: write object id fanout chunk
Date:   Thu,  7 Jun 2018 10:03:28 -0400
Message-Id: <20180607140338.32440-14-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/pack-format.txt |  5 +++
 builtin/midx.c                          |  4 +-
 midx.c                                  | 53 +++++++++++++++++++++++--
 object-store.h                          |  1 +
 t/t5319-midx.sh                         | 18 +++++----
 5 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index de9ac778b6..77e88f85e4 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -307,6 +307,11 @@ CHUNK DATA:
 	    name. This is the only chunk not guaranteed to be a multiple of four
 	    bytes in length, so should be the last chunk for alignment reasons.
 
+	OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
+	    The ith entry, F[i], stores the number of OIDs with first
+	    byte at most i. Thus F[255] stores the total
+	    number of objects (N).
+
 	OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
 	    The OIDs for all objects in the MIDX are stored in lexicographic
 	    order in this chunk.
diff --git a/builtin/midx.c b/builtin/midx.c
index 86edd30174..e1fd0e0de4 100644
--- a/builtin/midx.c
+++ b/builtin/midx.c
@@ -35,10 +35,12 @@ static int read_midx_file(const char *object_dir)
 		printf(" pack_lookup");
 	if (m->chunk_pack_names)
 		printf(" pack_names");
+	if (m->chunk_oid_fanout)
+		printf(" oid_fanout");
 	if (m->chunk_oid_lookup)
 		printf(" oid_lookup");
 
-	printf("\n");
+	printf("\nnum_objects: %d\n", m->num_objects);
 
 	printf("packs:\n");
 	for (i = 0; i < m->num_packs; i++)
diff --git a/midx.c b/midx.c
index d06bc6876a..9458ced208 100644
--- a/midx.c
+++ b/midx.c
@@ -14,12 +14,14 @@
 #define MIDX_HASH_LEN 20
 #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + MIDX_HASH_LEN)
 
-#define MIDX_MAX_CHUNKS 3
+#define MIDX_MAX_CHUNKS 4
 #define MIDX_CHUNK_ALIGNMENT 4
 #define MIDX_CHUNKID_PACKLOOKUP 0x504c4f4f /* "PLOO" */
 #define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
+#define MIDX_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
 #define MIDX_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define MIDX_CHUNKLOOKUP_WIDTH (sizeof(uint32_t) + sizeof(uint64_t))
+#define MIDX_CHUNK_FANOUT_SIZE (sizeof(uint32_t) * 256)
 
 static char *get_midx_filename(const char *object_dir)
 {
@@ -96,6 +98,10 @@ struct midxed_git *load_midxed_git(const char *object_dir)
 				m->chunk_pack_names = m->data + chunk_offset;
 				break;
 
+			case MIDX_CHUNKID_OIDFANOUT:
+				m->chunk_oid_fanout = (uint32_t *)(m->data + chunk_offset);
+				break;
+
 			case MIDX_CHUNKID_OIDLOOKUP:
 				m->chunk_oid_lookup = m->data + chunk_offset;
 				break;
@@ -117,9 +123,13 @@ struct midxed_git *load_midxed_git(const char *object_dir)
 		die("MIDX missing required pack lookup chunk");
 	if (!m->chunk_pack_names)
 		die("MIDX missing required pack-name chunk");
+	if (!m->chunk_oid_fanout)
+		die("MIDX missing required OID fanout chunk");
 	if (!m->chunk_oid_lookup)
 		die("MIDX missing required OID lookup chunk");
 
+	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
+
 	m->pack_names = xcalloc(m->num_packs, sizeof(const char *));
 	for (i = 0; i < m->num_packs; i++) {
 		if (i) {
@@ -377,6 +387,35 @@ static size_t write_midx_pack_names(struct hashfile *f,
 	return written;
 }
 
+static size_t write_midx_oid_fanout(struct hashfile *f,
+				    struct pack_midx_entry *objects,
+				    uint32_t nr_objects)
+{
+	struct pack_midx_entry *list = objects;
+	struct pack_midx_entry *last = objects + nr_objects;
+	uint32_t count = 0;
+	uint32_t i;
+
+	/*
+	* Write the first-level table (the list is sorted,
+	* but we use a 256-entry lookup to be able to avoid
+	* having to do eight extra binary search iterations).
+	*/
+	for (i = 0; i < 256; i++) {
+		struct pack_midx_entry *next = list;
+
+		while (next < last && next->oid.hash[0] == i) {
+			count++;
+			next++;
+		}
+
+		hashwrite_be32(f, count);
+		list = next;
+	}
+
+	return MIDX_CHUNK_FANOUT_SIZE;
+}
+
 static size_t write_midx_oid_lookup(struct hashfile *f, unsigned char hash_len,
 				    struct pack_midx_entry *objects,
 				    uint32_t nr_objects)
@@ -489,7 +528,7 @@ int write_midx_file(const char *object_dir)
 	FREE_AND_NULL(midx_name);
 
 	cur_chunk = 0;
-	num_chunks = 3;
+	num_chunks = 4;
 
 	written = write_midx_header(f, num_chunks, nr_packs);
 
@@ -501,9 +540,13 @@ int write_midx_file(const char *object_dir)
 	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_packs * sizeof(uint32_t);
 
 	cur_chunk++;
-	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;
+	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDFANOUT;
 	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + pack_name_concat_len;
 
+	cur_chunk++;
+	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;
+	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + MIDX_CHUNK_FANOUT_SIZE;
+
 	cur_chunk++;
 	chunk_ids[cur_chunk] = 0;
 	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_entries * MIDX_HASH_LEN;
@@ -541,6 +584,10 @@ int write_midx_file(const char *object_dir)
 				written += write_midx_pack_names(f, pack_names, nr_packs);
 				break;
 
+			case MIDX_CHUNKID_OIDFANOUT:
+				written += write_midx_oid_fanout(f, entries, nr_entries);
+				break;
+
 			case MIDX_CHUNKID_OIDLOOKUP:
 				written += write_midx_oid_lookup(f, MIDX_HASH_LEN, entries, nr_entries);
 				break;
diff --git a/object-store.h b/object-store.h
index 7d14d3586e..c613ff2571 100644
--- a/object-store.h
+++ b/object-store.h
@@ -102,6 +102,7 @@ struct midxed_git {
 
 	const uint32_t *chunk_pack_lookup;
 	const unsigned char *chunk_pack_names;
+	const uint32_t *chunk_oid_fanout;
 	const unsigned char *chunk_oid_lookup;
 
 	const char **pack_names;
diff --git a/t/t5319-midx.sh b/t/t5319-midx.sh
index e71aa52b80..d4ae988479 100755
--- a/t/t5319-midx.sh
+++ b/t/t5319-midx.sh
@@ -5,9 +5,11 @@ test_description='multi-pack-indexes'
 
 midx_read_expect() {
 	NUM_PACKS=$1
+	NUM_OBJECTS=$2
 	cat >expect <<- EOF
-	header: 4d494458 1 1 3 $NUM_PACKS
-	chunks: pack_lookup pack_names oid_lookup
+	header: 4d494458 1 1 4 $NUM_PACKS
+	chunks: pack_lookup pack_names oid_fanout oid_lookup
+	num_objects: $NUM_OBJECTS
 	packs:
 	EOF
 	if [ $NUM_PACKS -ge 1 ]
@@ -23,7 +25,7 @@ test_expect_success 'write midx with no packs' '
 	git midx --object-dir=. write &&
 	test_when_finished rm pack/multi-pack-index &&
 	test_path_is_file pack/multi-pack-index &&
-	midx_read_expect 0
+	midx_read_expect 0 0
 '
 
 test_expect_success 'create objects' '
@@ -54,18 +56,18 @@ test_expect_success 'write midx with one v1 pack' '
 	pack=$(git pack-objects --index-version=1 pack/test <obj-list) &&
 	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx pack/multi-pack-index &&
 	git midx --object-dir=. write &&
-	midx_read_expect 1
+	midx_read_expect 1 17
 '
 
 test_expect_success 'write midx with one v2 pack' '
 	pack=$(git pack-objects --index-version=2,0x40 pack/test <obj-list) &&
 	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx &&
 	git midx --object-dir=. write &&
-	midx_read_expect 1
+	midx_read_expect 1 17
 '
 
 test_expect_success 'Add more objects' '
-	for i in `test_seq 6 5`
+	for i in `test_seq 6 10`
 	do
 		iii=$(printf '%03i' $i)
 		test-tool genrandom "bar" 200 > wide_delta_$iii &&
@@ -92,7 +94,7 @@ test_expect_success 'write midx with two packs' '
 	pack1=$(git pack-objects --index-version=1 pack/test-1 <obj-list) &&
 	pack2=$(git pack-objects --index-version=1 pack/test-2 <obj-list2) &&
 	git midx --object-dir=. write &&
-	midx_read_expect 2
+	midx_read_expect 2 33
 '
 
 test_expect_success 'Add more packs' '
@@ -123,7 +125,7 @@ test_expect_success 'Add more packs' '
 
 test_expect_success 'write midx with twelve packs' '
 	git midx --object-dir=. write &&
-	midx_read_expect 12
+	midx_read_expect 12 73
 '
 
 test_done
-- 
2.18.0.rc1

