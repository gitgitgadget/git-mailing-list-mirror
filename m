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
	by dcvr.yhbt.net (Postfix) with ESMTP id 612331F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbeGLTvb (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:31 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40585 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732395AbeGLTvb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:31 -0400
Received: by mail-qk0-f193.google.com with SMTP id c126-v6so7318692qkd.7
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NFWsKFt6wUP2ICuWoJWEB8lUIzIeHGXqc23b2rsJL1I=;
        b=DhS9oEKgbeHGaUqTyuXMWNtx8LnGWJUO73TY2PiSi4nsp1qpO2JhijrmFRhm5N38tC
         9qaJa8JWwZfUQsK4hMOfj6QfzHMVJJsvqz9L1ousp+M8xOsT5ezjhr+4jet2tYQTzfOs
         h0fJDgXnu4uN4gObsWczKUAkHHD1l2J2oGKQY1QgM9sPehv84QHmdVUG1t+JSgqpNzCA
         k1yZiI+4duWG+gBMStHpYafEn9+uvJaTmYRGtrBdPZ0zJtbLcGJmoZm5m9gKsa1E8OsR
         f7JFsCzyNxsFRimvpIcEvmtNNB2D7gWUWCMul1WW905HYHcRoTiVZ6xmIQrejRjEvqJv
         S1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NFWsKFt6wUP2ICuWoJWEB8lUIzIeHGXqc23b2rsJL1I=;
        b=t3w4p3gVGywuXPMS8ZNSrzike9M2nq0N8KxOl2gVD1KHWUHCXdxx+mApp/Uzo0ahle
         s/nczGesByMaywTK3wt6pvtIa0Dx8AXdDPeDhUSqfIJcgo9IbaUaBUmgRyFT8hKYiXpq
         LmHqvDMsb+qrKgnqc0HA4d5Tmeu04r0CFrHKxgq57wm/89twXSfpypNQb+jd2v2b+dxA
         lYxSkpMdydwtgDcYY9pZEjwD9WC1VrXCu6bKHOk02SXgQTbQe2GRNYUj/vQxTXI9PSNa
         p1CL0clS5wts4EIY5GMhpSaL81p4MSRvPnfWFUiyGGxVmBBeNqE41F4OGeuQR73S0hrh
         UWYg==
X-Gm-Message-State: AOUpUlFHis5EUTGKQC/ym7Du7eRvOMkW2pcuk3ZuTMlmcKTtyA6LRWiz
        SQiMHQKbIyqQwjp4T7Sse3oBIOm5ofs=
X-Google-Smtp-Source: AAOMgpcFpCE502Bcenf735zrJKMJdUrATPQCNJNHi3MT64qhoBnfxIJahMBvmxVq5VlSLaLmVL0M2w==
X-Received: by 2002:a37:ba02:: with SMTP id k2-v6mr3076401qkf.134.1531424430485;
        Thu, 12 Jul 2018 12:40:30 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:29 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 14/23] midx: write object id fanout chunk
Date:   Thu, 12 Jul 2018 15:39:31 -0400
Message-Id: <20180712193940.21065-15-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/pack-format.txt |  5 +++
 midx.c                                  | 53 +++++++++++++++++++++++--
 midx.h                                  |  1 +
 t/helper/test-read-midx.c               |  4 +-
 t/t5319-multi-pack-index.sh             | 16 ++++----
 5 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 78ee0489c6..3215f7bfcd 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -302,6 +302,11 @@ CHUNK DATA:
 	    name. This is the only chunk not guaranteed to be a multiple of four
 	    bytes in length, so should be the last chunk for alignment reasons.
 
+	OID Fanout (ID: {'O', 'I', 'D', 'F'})
+	    The ith entry, F[i], stores the number of OIDs with first
+	    byte at most i. Thus F[255] stores the total
+	    number of objects.
+
 	OID Lookup (ID: {'O', 'I', 'D', 'L'})
 	    The OIDs for all objects in the MIDX are stored in lexicographic
 	    order in this chunk.
diff --git a/midx.c b/midx.c
index 3f113e1beb..7a954eb0cd 100644
--- a/midx.c
+++ b/midx.c
@@ -18,11 +18,13 @@
 #define MIDX_HASH_LEN 20
 #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + MIDX_HASH_LEN)
 
-#define MIDX_MAX_CHUNKS 2
+#define MIDX_MAX_CHUNKS 3
 #define MIDX_CHUNK_ALIGNMENT 4
 #define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
+#define MIDX_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
 #define MIDX_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define MIDX_CHUNKLOOKUP_WIDTH (sizeof(uint32_t) + sizeof(uint64_t))
+#define MIDX_CHUNK_FANOUT_SIZE (sizeof(uint32_t) * 256)
 
 static char *get_midx_filename(const char *object_dir)
 {
@@ -102,6 +104,10 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 				m->chunk_pack_names = m->data + chunk_offset;
 				break;
 
+			case MIDX_CHUNKID_OIDFANOUT:
+				m->chunk_oid_fanout = (uint32_t *)(m->data + chunk_offset);
+				break;
+
 			case MIDX_CHUNKID_OIDLOOKUP:
 				m->chunk_oid_lookup = m->data + chunk_offset;
 				break;
@@ -121,9 +127,13 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 
 	if (!m->chunk_pack_names)
 		die(_("multi-pack-index missing required pack-name chunk"));
+	if (!m->chunk_oid_fanout)
+		die(_("multi-pack-index missing required OID fanout chunk"));
 	if (!m->chunk_oid_lookup)
 		die(_("multi-pack-index missing required OID lookup chunk"));
 
+	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
+
 	m->pack_names = xcalloc(m->num_packs, sizeof(*m->pack_names));
 
 	cur_pack_name = (const char *)m->chunk_pack_names;
@@ -389,6 +399,35 @@ static size_t write_midx_pack_names(struct hashfile *f,
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
@@ -461,7 +500,7 @@ int write_midx_file(const char *object_dir)
 	FREE_AND_NULL(midx_name);
 
 	cur_chunk = 0;
-	num_chunks = 2;
+	num_chunks = 3;
 
 	written = write_midx_header(f, num_chunks, packs.nr);
 
@@ -469,9 +508,13 @@ int write_midx_file(const char *object_dir)
 	chunk_offsets[cur_chunk] = written + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
 
 	cur_chunk++;
-	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;
+	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDFANOUT;
 	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + packs.pack_name_concat_len;
 
+	cur_chunk++;
+	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;
+	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + MIDX_CHUNK_FANOUT_SIZE;
+
 	cur_chunk++;
 	chunk_ids[cur_chunk] = 0;
 	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_entries * MIDX_HASH_LEN;
@@ -505,6 +548,10 @@ int write_midx_file(const char *object_dir)
 				written += write_midx_pack_names(f, packs.names, packs.nr);
 				break;
 
+			case MIDX_CHUNKID_OIDFANOUT:
+				written += write_midx_oid_fanout(f, entries, nr_entries);
+				break;
+
 			case MIDX_CHUNKID_OIDLOOKUP:
 				written += write_midx_oid_lookup(f, MIDX_HASH_LEN, entries, nr_entries);
 				break;
diff --git a/midx.h b/midx.h
index 4d3bceafc5..8572cf0f4b 100644
--- a/midx.h
+++ b/midx.h
@@ -15,6 +15,7 @@ struct multi_pack_index {
 	uint32_t num_objects;
 
 	const unsigned char *chunk_pack_names;
+	const uint32_t *chunk_oid_fanout;
 	const unsigned char *chunk_oid_lookup;
 
 	const char **pack_names;
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index de6d452a7c..f7c17b0940 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -22,10 +22,12 @@ static int read_midx_file(const char *object_dir)
 
 	if (m->chunk_pack_names)
 		printf(" pack-names");
+	if (m->chunk_oid_fanout)
+		printf(" oid-fanout");
 	if (m->chunk_oid_lookup)
 		printf(" oid-lookup");
 
-	printf("\n");
+	printf("\nnum_objects: %d\n", m->num_objects);
 
 	printf("packs:\n");
 	for (i = 0; i < m->num_packs; i++)
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 4813610115..1cf609958f 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -5,10 +5,12 @@ test_description='multi-pack-indexes'
 
 midx_read_expect () {
 	NUM_PACKS=$1
+	NUM_OBJECTS=$2
 	{
 		cat <<-EOF &&
-		header: 4d494458 1 2 $NUM_PACKS
-		chunks: pack-names oid-lookup
+		header: 4d494458 1 3 $NUM_PACKS
+		chunks: pack-names oid-fanout oid-lookup
+		num_objects: $NUM_OBJECTS
 		packs:
 		EOF
 		if test $NUM_PACKS -ge 1
@@ -24,7 +26,7 @@ midx_read_expect () {
 test_expect_success 'write midx with no packs' '
 	test_when_finished rm -f pack/multi-pack-index &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 0
+	midx_read_expect 0 0
 '
 
 generate_objects () {
@@ -74,13 +76,13 @@ test_expect_success 'write midx with one v1 pack' '
 	pack=$(git pack-objects --index-version=1 pack/test <obj-list) &&
 	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx pack/multi-pack-index &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 1
+	midx_read_expect 1 18
 '
 
 test_expect_success 'write midx with one v2 pack' '
 	git pack-objects --index-version=2,0x40 pack/test <obj-list &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 1
+	midx_read_expect 1 18
 '
 
 test_expect_success 'add more objects' '
@@ -94,7 +96,7 @@ test_expect_success 'add more objects' '
 test_expect_success 'write midx with two packs' '
 	git pack-objects --index-version=1 pack/test-2 <obj-list &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 2
+	midx_read_expect 2 34
 '
 
 test_expect_success 'add more packs' '
@@ -108,7 +110,7 @@ test_expect_success 'add more packs' '
 
 test_expect_success 'write midx with twelve packs' '
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 12
+	midx_read_expect 12 74 
 '
 
 test_done
-- 
2.18.0.118.gd4f65b8d14

