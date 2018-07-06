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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B5361F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 00:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753943AbeGFAyD (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 20:54:03 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39738 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753912AbeGFAxy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 20:53:54 -0400
Received: by mail-qt0-f196.google.com with SMTP id q12-v6so8711854qtp.6
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 17:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ou63J6vLOAqeLKrYeFkeZtEXrCSvobbzVeI9ExMlhE0=;
        b=GZ4KT0uLuJSvhjB0Cr8B474UicOpXa9oT07S7v0/+QEwCK0Ahee1UM1JvMveIO311m
         vWZ6IUvG9l3GBxlJKqksRMQgcQvbYHAoXHJpN55nJ6CNB/EF+CvAFRQnDKuO+4hOvDyw
         B6QU8sCLDkAgAfeZ7/Cxl1LC6xPJdOngLiHS/1i1IwkE8glcSS2ywImzT4fwwBAnLuO+
         OWfvoTBzIQdmOGirB+5r8Dp3O4MGej27p9iPcWN65fuVdjs1w2EhuLU11v7e7uWyeoyB
         iXbzx2TeTwej31mxkWgef/usuxBWc9AUdLE+bgh0mIz9fP6DfguI+8+xpxqxsBMGvbYT
         PTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ou63J6vLOAqeLKrYeFkeZtEXrCSvobbzVeI9ExMlhE0=;
        b=b4bNOyktHvLe693hpQElOWxu1rzYOV4ot8aY//d2kKF5WMfGEVvhzVq4gsCikiOECK
         tGYzusMmnfCUh/IHlEfEBsCpW+9r9ixpcf1zAynt36seEtcwqO/mWRpqBdA2fhv573cd
         7vzBQskyXMAPkc/am2BtWPq/+kN/EYV7yAvUt0Kn4UKvw1sNWYYOLDZa4G013HJL3N86
         uCHlewbvGQG3xeQDwjTxBlJLT4gmpA9AWwPFe3xpS/rc7Sr62qs1w5+SPCMLQ1hF9pKl
         5TTMGHTU5acik170uhuC1p7Dx3NY4bYBppEcpIrqQ3pDpvCqI58EidCqGIEQlE2NkVTB
         O5wA==
X-Gm-Message-State: APt69E0BgDEh2Fa7EIgX2M2sHNyL5pg4O3ZrEKx1UagmIqk5wa9WgYql
        u5heBKJTa0O/sV53gS5roPHj9VqA
X-Google-Smtp-Source: AAOMgpfoniM4JtEq+KlXg08ut2nFgw319Q5lwc+OWz3pJPU5jIBc8K1UWFycdSSDAnaaptK4aPdY1w==
X-Received: by 2002:ac8:222a:: with SMTP id o39-v6mr7226365qto.399.1530838433661;
        Thu, 05 Jul 2018 17:53:53 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u25-v6sm4882791qku.3.2018.07.05.17.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 17:53:53 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v3 14/24] midx: write object id fanout chunk
Date:   Thu,  5 Jul 2018 20:53:11 -0400
Message-Id: <20180706005321.124643-15-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180706005321.124643-1-dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/pack-format.txt |  5 +++
 midx.c                                  | 53 +++++++++++++++++++++++--
 object-store.h                          |  1 +
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
index 7606addab6..404147bb9f 100644
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
@@ -104,6 +106,10 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 				m->chunk_pack_names = m->data + chunk_offset;
 				break;
 
+			case MIDX_CHUNKID_OIDFANOUT:
+				m->chunk_oid_fanout = (uint32_t *)(m->data + chunk_offset);
+				break;
+
 			case MIDX_CHUNKID_OIDLOOKUP:
 				m->chunk_oid_lookup = m->data + chunk_offset;
 				break;
@@ -123,9 +129,13 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 
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
@@ -391,6 +401,35 @@ static size_t write_midx_pack_names(struct hashfile *f,
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
@@ -463,7 +502,7 @@ int write_midx_file(const char *object_dir)
 	FREE_AND_NULL(midx_name);
 
 	cur_chunk = 0;
-	num_chunks = 2;
+	num_chunks = 3;
 
 	written = write_midx_header(f, num_chunks, packs.nr);
 
@@ -471,9 +510,13 @@ int write_midx_file(const char *object_dir)
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
@@ -507,6 +550,10 @@ int write_midx_file(const char *object_dir)
 				written += write_midx_pack_names(f, packs.names, packs.nr);
 				break;
 
+			case MIDX_CHUNKID_OIDFANOUT:
+				written += write_midx_oid_fanout(f, entries, nr_entries);
+				break;
+
 			case MIDX_CHUNKID_OIDLOOKUP:
 				written += write_midx_oid_lookup(f, MIDX_HASH_LEN, entries, nr_entries);
 				break;
diff --git a/object-store.h b/object-store.h
index 25f8530eb4..3357e51100 100644
--- a/object-store.h
+++ b/object-store.h
@@ -98,6 +98,7 @@ struct multi_pack_index {
 	uint32_t num_objects;
 
 	const unsigned char *chunk_pack_names;
+	const uint32_t *chunk_oid_fanout;
 	const unsigned char *chunk_oid_lookup;
 
 	const char **pack_names;
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 60bca5b668..d1bb7290ae 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -25,10 +25,12 @@ static int read_midx_file(const char *object_dir)
 
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
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index cbe84c74fc..23f653473a 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -5,9 +5,11 @@ test_description='multi-pack-indexes'
 
 midx_read_expect () {
 	NUM_PACKS=$1
+	NUM_OBJECTS=$2
 	cat >expect <<-EOF
-	header: 4d494458 1 2 $NUM_PACKS
-	chunks: pack_names oid_lookup
+	header: 4d494458 1 3 $NUM_PACKS
+	chunks: pack_names oid_fanout oid_lookup
+	num_objects: $NUM_OBJECTS
 	packs:
 	EOF
 	if [ $NUM_PACKS -ge 1 ]
@@ -22,7 +24,7 @@ midx_read_expect () {
 test_expect_success 'write midx with no packs' '
 	test_when_finished rm -f pack/multi-pack-index &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 0
+	midx_read_expect 0 0
 '
 
 test_expect_success 'create objects' '
@@ -53,13 +55,13 @@ test_expect_success 'write midx with one v1 pack' '
 	pack=$(git pack-objects --index-version=1 pack/test <obj-list) &&
 	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx pack/multi-pack-index &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 1
+	midx_read_expect 1 17
 '
 
 test_expect_success 'write midx with one v2 pack' '
 	git pack-objects --index-version=2,0x40 pack/test <obj-list &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 1
+	midx_read_expect 1 17
 '
 
 test_expect_success 'Add more objects' '
@@ -89,7 +91,7 @@ test_expect_success 'Add more objects' '
 test_expect_success 'write midx with two packs' '
 	git pack-objects --index-version=1 pack/test-2 <obj-list2 &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 2
+	midx_read_expect 2 33
 '
 
 test_expect_success 'Add more packs' '
@@ -120,7 +122,7 @@ test_expect_success 'Add more packs' '
 
 test_expect_success 'write midx with twelve packs' '
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 12
+	midx_read_expect 12 73
 '
 
 test_done
-- 
2.18.0.118.gd4f65b8d14

