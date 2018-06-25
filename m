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
	by dcvr.yhbt.net (Postfix) with ESMTP id 32DA11F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934487AbeFYOf0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:35:26 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33511 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934471AbeFYOfY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:35:24 -0400
Received: by mail-qk0-f195.google.com with SMTP id c131-v6so7601634qkb.0
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DbDdswp/pEqEaW6ZMeY63uYKkhYQcDwhumgR3DeLO1g=;
        b=t4FxyRkFg7rsvIFm4h/sAwbSjXTgPKgChI029pT0aZsMO2dO6T7mDXmLQ8FDgjQqbO
         oD/N7zpuJ6EqcZQUjZlgWCu4L0YtWQN84oinDQbisonOieS4QR64t3jdPk/VMLySZjf5
         YFmISaICAs2Sr3q3dUPckSDIJNVP6cd4aKNkhzTHqQY26WI15UXmdD7rs8ZO411tmuRf
         F+k8HsSt/0JAQaTV71NdfBZIxF0NFt2w3nDruU1YqqWRQmr3KKceQTrYyKQ2BDNmQtuR
         75yfxKvOfMK4pzbAqLgy9hbNMiQQ67dYBaqjPSQdgePlRm7c1cGsMCOdTssrObnm5+zw
         zKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DbDdswp/pEqEaW6ZMeY63uYKkhYQcDwhumgR3DeLO1g=;
        b=gZdIeAT0Kd0JtrdB5xXv1lr0PTnzP2DxNcG/3KUmrDBhmT2bxPVkyo6if0yja1C30x
         dITL0Pak9qbTrXN/QRMfM40LAw79A0H90N9C4T4e7T4urRmzmE7xqP86DH9y6oN7VYUM
         LGqyEPNSU5g78Pux4V2biScgVVNrPJXpJK9kwzRirEAybSrb+oephnQ4Sdv/cBrPNxhY
         e40Ai1DUc4qO0CLaU6VIN9f5/mxM1YlqOTcpx7Oigw9myZU8hmF82kEP/0ocvLjvAx2Y
         O+Z1GblS3iScLsSdv/RDB8jgRZa1b+/rxLajlz1xVkySyxrwFhgYeZYQ/IwTQcKgpLxr
         e2ng==
X-Gm-Message-State: APt69E1OwcW9+IttiBhsXLiIOMbTNrm9V6qFsfZPRL4L5ynZoROgDb3+
        RgZagDnSDjWvQ+e4EesWRjCy6+Xm
X-Google-Smtp-Source: ADUXVKIizwCO9yv4CNobo+ovr6MQB8RPS35IbbxQYelC0Mw7tNgz37ALGKxt6hcRPEsfvj2mIk2VVA==
X-Received: by 2002:a37:9704:: with SMTP id z4-v6mr11120059qkd.272.1529937323093;
        Mon, 25 Jun 2018 07:35:23 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:35:22 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 15/24] midx: write object offsets
Date:   Mon, 25 Jun 2018 10:34:25 -0400
Message-Id: <20180625143434.89044-16-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The final pair of chunks for the multi-pack-index file stores the object
offsets. We default to using 32-bit offsets as in the pack-index version
1 format, but if there exists an offset larger than 32-bits, we use a
trick similar to the pack-index version 2 format by storing all offsets
at least 2^31 in a 64-bit table; we use the 32-bit table to point into
that 64-bit table as necessary.

We only store these 64-bit offsets if necessary, so create a test that
manipulates a version 2 pack-index to fake a large offset. This allows
us to test that the large offset table is created, but the data does not
match the actual packfile offsets. The multi-pack-index offset does match
the (corrupted) pack-index offset, so a future feature will compare these
offsets during a 'verify' step.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/pack-format.txt |  15 +++-
 midx.c                                  | 100 +++++++++++++++++++++++-
 object-store.h                          |   2 +
 t/helper/test-read-midx.c               |   4 +
 t/t5319-multi-pack-index.sh             |  45 ++++++++---
 5 files changed, 151 insertions(+), 15 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 3215f7bfcd..cab5bdd2ff 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -311,7 +311,20 @@ CHUNK DATA:
 	    The OIDs for all objects in the MIDX are stored in lexicographic
 	    order in this chunk.
 
-	(This section intentionally left incomplete.)
+	Object Offsets (ID: {'O', 'O', 'F', 'F'})
+	    Stores two 4-byte values for every object.
+	    1: The pack-int-id for the pack storing this object.
+	    2: The offset within the pack.
+		If all offsets are less than 2^31, then the large offset chunk
+		will not exist and offsets are stored as in IDX v1.
+		If there is at least one offset value larger than 2^32-1, then
+		the large offset chunk must exist. If the large offset chunk
+		exists and the 31st bit is on, then removing that bit reveals
+		the row in the large offsets containing the 8-byte offset of
+		this object.
+
+	[Optional] Object Large Offsets (ID: {'L', 'O', 'F', 'F'})
+	    8-byte offsets into large packfiles.
 
 TRAILER:
 
diff --git a/midx.c b/midx.c
index 0f773e2585..71ca493107 100644
--- a/midx.c
+++ b/midx.c
@@ -14,13 +14,18 @@
 #define MIDX_HASH_LEN 20
 #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + MIDX_HASH_LEN)
 
-#define MIDX_MAX_CHUNKS 3
+#define MIDX_MAX_CHUNKS 5
 #define MIDX_CHUNK_ALIGNMENT 4
 #define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
 #define MIDX_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
 #define MIDX_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
+#define MIDX_CHUNKID_OBJECTOFFSETS 0x4f4f4646 /* "OOFF" */
+#define MIDX_CHUNKID_LARGEOFFSETS 0x4c4f4646 /* "LOFF" */
 #define MIDX_CHUNKLOOKUP_WIDTH (sizeof(uint32_t) + sizeof(uint64_t))
 #define MIDX_CHUNK_FANOUT_SIZE (sizeof(uint32_t) * 256)
+#define MIDX_CHUNK_OFFSET_WIDTH (2 * sizeof(uint32_t))
+#define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
+#define MIDX_LARGE_OFFSET_NEEDED 0x80000000
 
 static char *get_midx_filename(const char *object_dir)
 {
@@ -113,6 +118,14 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 				m->chunk_oid_lookup = m->data + chunk_offset;
 				break;
 
+			case MIDX_CHUNKID_OBJECTOFFSETS:
+				m->chunk_object_offsets = m->data + chunk_offset;
+				break;
+
+			case MIDX_CHUNKID_LARGEOFFSETS:
+				m->chunk_large_offsets = m->data + chunk_offset;
+				break;
+
 			case 0:
 				die(_("terminating multi-pack-index chunk id appears earlier than expected"));
 				break;
@@ -132,6 +145,8 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 		die(_("multi-pack-index missing required OID fanout chunk"));
 	if (!m->chunk_oid_lookup)
 		die(_("multi-pack-index missing required OID lookup chunk"));
+	if (!m->chunk_object_offsets)
+		die(_("multi-pack-index missing required object offsets chunk"));
 
 	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
 
@@ -466,6 +481,56 @@ static size_t write_midx_oid_lookup(struct hashfile *f, unsigned char hash_len,
 	return written;
 }
 
+static size_t write_midx_object_offsets(struct hashfile *f, int large_offset_needed,
+					struct pack_midx_entry *objects, uint32_t nr_objects)
+{
+	struct pack_midx_entry *list = objects;
+	uint32_t i, nr_large_offset = 0;
+	size_t written = 0;
+
+	for (i = 0; i < nr_objects; i++) {
+		struct pack_midx_entry *obj = list++;
+
+		hashwrite_be32(f, obj->pack_int_id);
+
+		if (large_offset_needed && obj->offset >> 31)
+			hashwrite_be32(f, MIDX_LARGE_OFFSET_NEEDED | nr_large_offset++);
+		else if (!large_offset_needed && obj->offset >> 32)
+			BUG("object %s requires a large offset (%"PRIx64") but the MIDX is not writing large offsets!",
+			    oid_to_hex(&obj->oid),
+			    obj->offset);
+		else
+			hashwrite_be32(f, (uint32_t)obj->offset);
+
+		written += MIDX_CHUNK_OFFSET_WIDTH;
+	}
+
+	return written;
+}
+
+static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_offset,
+				       struct pack_midx_entry *objects, uint32_t nr_objects)
+{
+	struct pack_midx_entry *list = objects;
+	size_t written = 0;
+
+	while (nr_large_offset) {
+		struct pack_midx_entry *obj = list++;
+		uint64_t offset = obj->offset;
+
+		if (!(offset >> 31))
+			continue;
+
+		hashwrite_be32(f, offset >> 32);
+		hashwrite_be32(f, offset & 0xffffffffUL);
+		written += 2 * sizeof(uint32_t);
+
+		nr_large_offset--;
+	}
+
+	return written;
+}
+
 int write_midx_file(const char *object_dir)
 {
 	unsigned char cur_chunk, num_chunks = 0;
@@ -478,8 +543,9 @@ int write_midx_file(const char *object_dir)
 	uint64_t written = 0;
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
-	uint32_t nr_entries;
+	uint32_t nr_entries, num_large_offsets = 0;
 	struct pack_midx_entry *entries = NULL;
+	int large_offsets_needed = 0;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -506,13 +572,19 @@ int write_midx_file(const char *object_dir)
 	sort_packs_by_name(packs.names, packs.nr, pack_perm);
 
 	entries = get_sorted_entries(packs.list, pack_perm, packs.nr, &nr_entries);
+	for (i = 0; i < nr_entries; i++) {
+		if (entries[i].offset > 0x7fffffff)
+			num_large_offsets++;
+		if (entries[i].offset > 0xffffffff)
+			large_offsets_needed = 1;
+	}
 
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	FREE_AND_NULL(midx_name);
 
 	cur_chunk = 0;
-	num_chunks = 3;
+	num_chunks = large_offsets_needed ? 5 : 4;
 
 	written = write_midx_header(f, num_chunks, packs.nr);
 
@@ -528,9 +600,21 @@ int write_midx_file(const char *object_dir)
 	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + MIDX_CHUNK_FANOUT_SIZE;
 
 	cur_chunk++;
-	chunk_ids[cur_chunk] = 0;
+	chunk_ids[cur_chunk] = MIDX_CHUNKID_OBJECTOFFSETS;
 	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_entries * MIDX_HASH_LEN;
 
+	cur_chunk++;
+	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_entries * MIDX_CHUNK_OFFSET_WIDTH;
+	if (large_offsets_needed) {
+		chunk_ids[cur_chunk] = MIDX_CHUNKID_LARGEOFFSETS;
+
+		cur_chunk++;
+		chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] +
+					   num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH;
+	}
+
+	chunk_ids[cur_chunk] = 0;
+
 	for (i = 0; i <= num_chunks; i++) {
 		if (i && chunk_offsets[i] < chunk_offsets[i - 1])
 			BUG("incorrect chunk offsets: %"PRIu64" before %"PRIu64,
@@ -568,6 +652,14 @@ int write_midx_file(const char *object_dir)
 				written += write_midx_oid_lookup(f, MIDX_HASH_LEN, entries, nr_entries);
 				break;
 
+			case MIDX_CHUNKID_OBJECTOFFSETS:
+				written += write_midx_object_offsets(f, large_offsets_needed, entries, nr_entries);
+				break;
+
+			case MIDX_CHUNKID_LARGEOFFSETS:
+				written += write_midx_large_offsets(f, num_large_offsets, entries, nr_entries);
+				break;
+
 			default:
 				BUG("trying to write unknown chunk id %"PRIx32,
 				    chunk_ids[i]);
diff --git a/object-store.h b/object-store.h
index 3357e51100..07bcc80e02 100644
--- a/object-store.h
+++ b/object-store.h
@@ -100,6 +100,8 @@ struct multi_pack_index {
 	const unsigned char *chunk_pack_names;
 	const uint32_t *chunk_oid_fanout;
 	const unsigned char *chunk_oid_lookup;
+	const unsigned char *chunk_object_offsets;
+	const unsigned char *chunk_large_offsets;
 
 	const char **pack_names;
 	char object_dir[FLEX_ARRAY];
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index d1bb7290ae..20771d1c1d 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -29,6 +29,10 @@ static int read_midx_file(const char *object_dir)
 		printf(" oid_fanout");
 	if (m->chunk_oid_lookup)
 		printf(" oid_lookup");
+	if (m->chunk_object_offsets)
+		printf(" object_offsets");
+	if (m->chunk_large_offsets)
+		printf(" large_offsets");
 
 	printf("\nnum_objects: %d\n", m->num_objects);
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index ad0d447522..ccde83bca4 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -6,25 +6,28 @@ test_description='multi-pack-indexes'
 midx_read_expect() {
 	NUM_PACKS=$1
 	NUM_OBJECTS=$2
+	NUM_CHUNKS=$3
+	OBJECT_DIR=$4
+	EXTRA_CHUNKS="$5"
 	cat >expect <<- EOF
-	header: 4d494458 1 3 $NUM_PACKS
-	chunks: pack_names oid_fanout oid_lookup
+	header: 4d494458 1 $NUM_CHUNKS $NUM_PACKS
+	chunks: pack_names oid_fanout oid_lookup object_offsets$EXTRA_CHUNKS
 	num_objects: $NUM_OBJECTS
 	packs:
 	EOF
 	if [ $NUM_PACKS -ge 1 ]
 	then
-		ls pack/ | grep idx | sort >> expect
+		ls $OBJECT_DIR/pack/ | grep idx | sort >> expect
 	fi
-	printf "object_dir: .\n" >>expect &&
-	test-tool read-midx . >actual &&
+	printf "object_dir: $OBJECT_DIR\n" >>expect &&
+	test-tool read-midx $OBJECT_DIR >actual &&
 	test_cmp expect actual
 }
 
 test_expect_success 'write midx with no packs' '
 	test_when_finished rm pack/multi-pack-index &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 0 0
+	midx_read_expect 0 0 4 .
 '
 
 test_expect_success 'create objects' '
@@ -55,13 +58,13 @@ test_expect_success 'write midx with one v1 pack' '
 	pack=$(git pack-objects --index-version=1 pack/test <obj-list) &&
 	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx pack/multi-pack-index &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 1 17
+	midx_read_expect 1 17 4 .
 '
 
 test_expect_success 'write midx with one v2 pack' '
 	git pack-objects --index-version=2,0x40 pack/test <obj-list &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 1 17
+	midx_read_expect 1 17 4 .
 '
 
 test_expect_success 'Add more objects' '
@@ -91,7 +94,7 @@ test_expect_success 'Add more objects' '
 test_expect_success 'write midx with two packs' '
 	git pack-objects --index-version=1 pack/test-2 <obj-list2 &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 2 33
+	midx_read_expect 2 33 4 .
 '
 
 test_expect_success 'Add more packs' '
@@ -122,7 +125,29 @@ test_expect_success 'Add more packs' '
 
 test_expect_success 'write midx with twelve packs' '
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 12 73
+	midx_read_expect 12 73 4 .
+'
+
+
+# usage: corrupt_data <file> <pos> [<data>]
+corrupt_data() {
+	file=$1
+	pos=$2
+	data="${3:-\0}"
+	printf "$data" | dd of="$file" bs=1 seek="$pos" conv=notrunc
+}
+
+# Force 64-bit offsets by manipulating the idx file.
+# This makes the IDX file _incorrect_ so be careful to clean up after!
+test_expect_success 'force some 64-bit offsets with pack-objects' '
+	mkdir objects64 &&
+	mkdir objects64/pack &&
+	pack64=$(git pack-objects --index-version=2,0x40 objects64/pack/test-64 <obj-list) &&
+	idx64=objects64/pack/test-64-$pack64.idx &&
+	chmod u+w $idx64 &&
+	corrupt_data $idx64 2899 "\02" &&
+	midx64=$(git multi-pack-index write --object-dir=objects64) &&
+	midx_read_expect 1 62 5 objects64 " large_offsets"
 '
 
 test_done
-- 
2.18.0.24.g1b579a2ee9

