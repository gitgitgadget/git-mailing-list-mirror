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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BA201F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932871AbeFGOEH (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:04:07 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36651 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932865AbeFGOEA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:04:00 -0400
Received: by mail-qk0-f196.google.com with SMTP id a195-v6so6611539qkg.3
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z8SRsao8yJEA58Ano/QH8BbyLubFH3AcoIm+IpuxJ0k=;
        b=fX3cy0Dd5yXH1aqTqpmBe11hMDBpWdQp6ZcO08q3fqUKZRiUbUXC3Kat8TAG07scXT
         kxaRNADmR7cC2SX2nHsZIG8UbNUSkMZY6p9XTPVl2r80XPsyyUDUQF2/7rISArf1OMHM
         VXys6joevKgt/QSjLAoEhlgM21QOnEEn1qRywFcuADS90o/XEqwPC6SYd+Ld8mRLEvNo
         NWqrfISP0xHMr+oUXR+YvbpE/iolgiywt9AtmACutPe7FZ/lMZG7vXqzeYqWEYABeqc6
         nEu92A2WFvXO11y/n/aRfSUX55ycj5zSkIcsLRIUQ/ZbWe1rG6P0RlstE5G/ra/FVJO1
         Zlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z8SRsao8yJEA58Ano/QH8BbyLubFH3AcoIm+IpuxJ0k=;
        b=WiufGR+WRNAs3UVYcYNmnCcGioldkWk0vPTqsw9ZmnYre5cRXjs1F4IB+2Ka38i/T0
         eIqlu3urer04d1Fr3zt0dPBZKAzNxlg3SCpPkX0MAIoMsT7D/aLv39hphP4KdQtiTY6b
         qi/7P7O24uK/dPl8tuvHAAJusrkqG4EvtwhkkV9rRObQlKMuWbXEHTzQly6UbEiz2lW8
         TyLYRa4r1WpH7uS8uag0RdA9XssqWH4iqL9JLVYQuEGTG/GiFO/mD4zaFWTcFsla/dCV
         nkunhVBdF4XiwPfmS47Qwfge2OCaMvpO9U1TG3FRFfb2Rflc7WyxrXOrrcEfsjQPhLbQ
         dWFA==
X-Gm-Message-State: APt69E1UhMBlSXNFfJfNL0JmdKYLOvDimtiof1rUOHehodY4t9nrRah+
        0UNqsYkCvxNKnKkmo4b7L2VxLgYI
X-Google-Smtp-Source: ADUXVKJfg1TQ2WdemC6oi1yuB0ATeUeAB8SnWsUv/VPuMsDNJweIzYtDBDokrVJ/HCOQwtrY4rwbEA==
X-Received: by 2002:a37:ef0d:: with SMTP id j13-v6mr1585892qkk.120.1528380239900;
        Thu, 07 Jun 2018 07:03:59 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:03:59 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 14/23] midx: write object offsets
Date:   Thu,  7 Jun 2018 10:03:29 -0400
Message-Id: <20180607140338.32440-15-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The final pair of chunks for the multi-pack-index (MIDX) file stores the
object offsets. We default to using 32-bit offsets as in the pack-index
version 1 format, but if there exists an offset larger than 32-bits, we
use a trick similar to the pack-index version 2 format by storing all
offsets at least 2^31 in a 64-bit table; we use the 32-bit table to
point into that 64-bit table as necessary.

We only store these 64-bit offsets if necessary, so create a test that
manipulates a version 2 pack-index to fake a large offset. This allows
us to test that the large offset table is created, but the data does not
match the actual packfile offsets. The MIDX offset does match the
(corrupted) pack-index offset, so a later commit will compare these
offsets during a 'verify' step.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/pack-format.txt |  15 +++-
 builtin/midx.c                          |   4 +
 midx.c                                  | 100 +++++++++++++++++++++++-
 object-store.h                          |   2 +
 t/t5319-midx.sh                         |  45 ++++++++---
 5 files changed, 151 insertions(+), 15 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 77e88f85e4..0256cfb5e0 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -316,7 +316,20 @@ CHUNK DATA:
 	    The OIDs for all objects in the MIDX are stored in lexicographic
 	    order in this chunk.
 
-	(This section intentionally left incomplete.)
+	Object Offsets (ID: {'O', 'O', 'F', 'F'}) (N * 8 bytes)
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
 
diff --git a/builtin/midx.c b/builtin/midx.c
index e1fd0e0de4..607d2b3544 100644
--- a/builtin/midx.c
+++ b/builtin/midx.c
@@ -39,6 +39,10 @@ static int read_midx_file(const char *object_dir)
 		printf(" oid_fanout");
 	if (m->chunk_oid_lookup)
 		printf(" oid_lookup");
+	if (m->chunk_object_offsets)
+		printf(" object_offsets");
+	if (m->chunk_large_offsets)
+		printf(" large_offsets");
 
 	printf("\nnum_objects: %d\n", m->num_objects);
 
diff --git a/midx.c b/midx.c
index 9458ced208..a49300bf75 100644
--- a/midx.c
+++ b/midx.c
@@ -14,14 +14,19 @@
 #define MIDX_HASH_LEN 20
 #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + MIDX_HASH_LEN)
 
-#define MIDX_MAX_CHUNKS 4
+#define MIDX_MAX_CHUNKS 6
 #define MIDX_CHUNK_ALIGNMENT 4
 #define MIDX_CHUNKID_PACKLOOKUP 0x504c4f4f /* "PLOO" */
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
@@ -106,6 +111,14 @@ struct midxed_git *load_midxed_git(const char *object_dir)
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
 				die("terminating MIDX chunk id appears earlier than expected");
 				break;
@@ -127,6 +140,8 @@ struct midxed_git *load_midxed_git(const char *object_dir)
 		die("MIDX missing required OID fanout chunk");
 	if (!m->chunk_oid_lookup)
 		die("MIDX missing required OID lookup chunk");
+	if (!m->chunk_object_offsets)
+		die("MIDX missing required object offsets chunk");
 
 	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
 
@@ -442,6 +457,56 @@ static size_t write_midx_oid_lookup(struct hashfile *f, unsigned char hash_len,
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
+		hashwrite_be32(f, offset & 0xffffffff);
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
@@ -462,7 +527,8 @@ int write_midx_file(const char *object_dir)
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
 	struct pack_midx_entry *entries;
-	uint32_t nr_entries;
+	uint32_t nr_entries, num_large_offsets = 0;
+	int large_offsets_needed = 0;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -522,13 +588,19 @@ int write_midx_file(const char *object_dir)
 	sort_packs_by_name(pack_names, nr_packs, pack_perm);
 
 	entries = get_sorted_entries(packs, pack_perm, nr_packs, &nr_entries);
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
-	num_chunks = 4;
+	num_chunks = large_offsets_needed ? 6 : 5;
 
 	written = write_midx_header(f, num_chunks, nr_packs);
 
@@ -548,9 +620,21 @@ int write_midx_file(const char *object_dir)
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
@@ -592,6 +676,14 @@ int write_midx_file(const char *object_dir)
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
index c613ff2571..9b671f1b0a 100644
--- a/object-store.h
+++ b/object-store.h
@@ -104,6 +104,8 @@ struct midxed_git {
 	const unsigned char *chunk_pack_names;
 	const uint32_t *chunk_oid_fanout;
 	const unsigned char *chunk_oid_lookup;
+	const unsigned char *chunk_object_offsets;
+	const unsigned char *chunk_large_offsets;
 
 	const char **pack_names;
 	char object_dir[FLEX_ARRAY];
diff --git a/t/t5319-midx.sh b/t/t5319-midx.sh
index d4ae988479..709652c635 100755
--- a/t/t5319-midx.sh
+++ b/t/t5319-midx.sh
@@ -6,18 +6,21 @@ test_description='multi-pack-indexes'
 midx_read_expect() {
 	NUM_PACKS=$1
 	NUM_OBJECTS=$2
+	NUM_CHUNKS=$3
+	OBJECT_DIR=$4
+	EXTRA_CHUNKS="$5"
 	cat >expect <<- EOF
-	header: 4d494458 1 1 4 $NUM_PACKS
-	chunks: pack_lookup pack_names oid_fanout oid_lookup
+	header: 4d494458 1 1 $NUM_CHUNKS $NUM_PACKS
+	chunks: pack_lookup pack_names oid_fanout oid_lookup object_offsets$EXTRA_CHUNKS
 	num_objects: $NUM_OBJECTS
 	packs:
 	EOF
 	if [ $NUM_PACKS -ge 1 ]
 	then
-		ls pack/ | grep idx | sort >> expect
+		ls $OBJECT_DIR/pack/ | grep idx | sort >> expect
 	fi
-	printf "object_dir: .\n" >>expect &&
-	git midx read --object-dir=. >actual &&
+	printf "object_dir: $OBJECT_DIR\n" >>expect &&
+	git midx read --object-dir=$OBJECT_DIR >actual &&
 	test_cmp expect actual
 }
 
@@ -25,7 +28,7 @@ test_expect_success 'write midx with no packs' '
 	git midx --object-dir=. write &&
 	test_when_finished rm pack/multi-pack-index &&
 	test_path_is_file pack/multi-pack-index &&
-	midx_read_expect 0 0
+	midx_read_expect 0 0 5 .
 '
 
 test_expect_success 'create objects' '
@@ -56,14 +59,14 @@ test_expect_success 'write midx with one v1 pack' '
 	pack=$(git pack-objects --index-version=1 pack/test <obj-list) &&
 	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx pack/multi-pack-index &&
 	git midx --object-dir=. write &&
-	midx_read_expect 1 17
+	midx_read_expect 1 17 5 .
 '
 
 test_expect_success 'write midx with one v2 pack' '
 	pack=$(git pack-objects --index-version=2,0x40 pack/test <obj-list) &&
 	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx &&
 	git midx --object-dir=. write &&
-	midx_read_expect 1 17
+	midx_read_expect 1 17 5 .
 '
 
 test_expect_success 'Add more objects' '
@@ -94,7 +97,7 @@ test_expect_success 'write midx with two packs' '
 	pack1=$(git pack-objects --index-version=1 pack/test-1 <obj-list) &&
 	pack2=$(git pack-objects --index-version=1 pack/test-2 <obj-list2) &&
 	git midx --object-dir=. write &&
-	midx_read_expect 2 33
+	midx_read_expect 2 33 5 .
 '
 
 test_expect_success 'Add more packs' '
@@ -125,7 +128,29 @@ test_expect_success 'Add more packs' '
 
 test_expect_success 'write midx with twelve packs' '
 	git midx --object-dir=. write &&
-	midx_read_expect 12 73
+	midx_read_expect 12 73 5 .
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
+	midx64=$(git midx write --object-dir=objects64) &&
+	midx_read_expect 1 62 6 objects64 " large_offsets"
 '
 
 test_done
-- 
2.18.0.rc1

