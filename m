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
	by dcvr.yhbt.net (Postfix) with ESMTP id 538CC1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbeGLTv3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:29 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44490 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732395AbeGLTv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:29 -0400
Received: by mail-qt0-f195.google.com with SMTP id b15-v6so25154561qtp.11
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gNMhFDJq4yvw7eLPpdv5Mw106woRqpn+cZcohIvY0cA=;
        b=bs41lK+fZ910BCaYsgqj1wJjRo0h+eZPs+sqZtZKesQ+eMY03IcblH2xCdLe4aZnMB
         akCk/E2TXMvEV0l/MBA7Z/ZJt/Sb/XGaE9O2AXeL8sasWJZVt96LzxGirDWXQ1f8Qwv+
         muSdBu6cjJsBTMcwgGhyYMb+0wccvAFWpKFnz+8x108Lz/YRQIGR5udJCApk6UzjaWHf
         Bvs6HmkzJr7nmj1306s1+Tu6ojEtsuYCEYr4qo7+qw7TYYGg46j2fZqcZ9E95NMqUXIy
         WN+6D61E8tNtHsJWLMIohJPsBza9C7PN80w3pTHxgYlaZmfR3HEnOntalIti/G2m35cO
         +2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gNMhFDJq4yvw7eLPpdv5Mw106woRqpn+cZcohIvY0cA=;
        b=nlAHKWLdt8mr6dJMJ2ntLcaQmEGm2GzCo9RvfPtMOYIS3oeZbfNPlGBOurlIavCSJX
         gLT7BAESfbJvTUSYY7r3gGDrKc8n6J3QEuRse2THO/l5heqWcPGI0W3c6JUzXwOKfpjP
         qtbDURLxClsy9PfQJMkvk8Sg0m6P2gDki+S10R/A4CrzRAM90FrTzRZPXklhIIYp2rv0
         RTIeu69VwfPD0toUbd3hxUobpx6Xlmx46J4alOYVCM4DjdPX+mDU/jEb9ipMOdHYRKFc
         a5f7Ehut/GuelW+kvIrforjmPJyNg5WMFVoKn+M13mfwbG7SglLNjwFXDJL5fDRvbMl7
         9rlw==
X-Gm-Message-State: AOUpUlFD5qvJ8C0AOvcDs0PFmcfj2Dzv2CZa9FLc2J9Vqo8ARdvUe+Fx
        bvdgGkXBsB4a7LNRAH9BuTXo2TFxZ1s=
X-Google-Smtp-Source: AAOMgpdDRBSitJuAf+U1X/0bxcQ4i70seB3Ym6FRpPNPmWPVGnqODLg/aXERmgfmNQUkrWhDkPGO4Q==
X-Received: by 2002:ac8:12c8:: with SMTP id b8-v6mr3132913qtj.372.1531424428475;
        Thu, 12 Jul 2018 12:40:28 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:28 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 13/23] midx: write object ids in a chunk
Date:   Thu, 12 Jul 2018 15:39:30 -0400
Message-Id: <20180712193940.21065-14-dstolee@microsoft.com>
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
 Documentation/technical/pack-format.txt |  4 +++
 midx.c                                  | 47 +++++++++++++++++++++++--
 midx.h                                  |  1 +
 t/helper/test-read-midx.c               |  2 ++
 t/t5319-multi-pack-index.sh             |  4 +--
 5 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 6c5a77475f..78ee0489c6 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -302,6 +302,10 @@ CHUNK DATA:
 	    name. This is the only chunk not guaranteed to be a multiple of four
 	    bytes in length, so should be the last chunk for alignment reasons.
 
+	OID Lookup (ID: {'O', 'I', 'D', 'L'})
+	    The OIDs for all objects in the MIDX are stored in lexicographic
+	    order in this chunk.
+
 	(This section intentionally left incomplete.)
 
 TRAILER:
diff --git a/midx.c b/midx.c
index 29f8de5ee6..3f113e1beb 100644
--- a/midx.c
+++ b/midx.c
@@ -18,9 +18,10 @@
 #define MIDX_HASH_LEN 20
 #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + MIDX_HASH_LEN)
 
-#define MIDX_MAX_CHUNKS 1
+#define MIDX_MAX_CHUNKS 2
 #define MIDX_CHUNK_ALIGNMENT 4
 #define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
+#define MIDX_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define MIDX_CHUNKLOOKUP_WIDTH (sizeof(uint32_t) + sizeof(uint64_t))
 
 static char *get_midx_filename(const char *object_dir)
@@ -101,6 +102,10 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 				m->chunk_pack_names = m->data + chunk_offset;
 				break;
 
+			case MIDX_CHUNKID_OIDLOOKUP:
+				m->chunk_oid_lookup = m->data + chunk_offset;
+				break;
+
 			case 0:
 				die(_("terminating multi-pack-index chunk id appears earlier than expected"));
 				break;
@@ -116,6 +121,8 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 
 	if (!m->chunk_pack_names)
 		die(_("multi-pack-index missing required pack-name chunk"));
+	if (!m->chunk_oid_lookup)
+		die(_("multi-pack-index missing required OID lookup chunk"));
 
 	m->pack_names = xcalloc(m->num_packs, sizeof(*m->pack_names));
 
@@ -382,6 +389,32 @@ static size_t write_midx_pack_names(struct hashfile *f,
 	return written;
 }
 
+static size_t write_midx_oid_lookup(struct hashfile *f, unsigned char hash_len,
+				    struct pack_midx_entry *objects,
+				    uint32_t nr_objects)
+{
+	struct pack_midx_entry *list = objects;
+	uint32_t i;
+	size_t written = 0;
+
+	for (i = 0; i < nr_objects; i++) {
+		struct pack_midx_entry *obj = list++;
+
+		if (i < nr_objects - 1) {
+			struct pack_midx_entry *next = list;
+			if (oidcmp(&obj->oid, &next->oid) >= 0)
+				BUG("OIDs not in order: %s >= %s",
+				    oid_to_hex(&obj->oid),
+				    oid_to_hex(&next->oid));
+		}
+
+		hashwrite(f, obj->oid.hash, (int)hash_len);
+		written += hash_len;
+	}
+
+	return written;
+}
+
 int write_midx_file(const char *object_dir)
 {
 	unsigned char cur_chunk, num_chunks = 0;
@@ -428,7 +461,7 @@ int write_midx_file(const char *object_dir)
 	FREE_AND_NULL(midx_name);
 
 	cur_chunk = 0;
-	num_chunks = 1;
+	num_chunks = 2;
 
 	written = write_midx_header(f, num_chunks, packs.nr);
 
@@ -436,9 +469,13 @@ int write_midx_file(const char *object_dir)
 	chunk_offsets[cur_chunk] = written + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
 
 	cur_chunk++;
-	chunk_ids[cur_chunk] = 0;
+	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;
 	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + packs.pack_name_concat_len;
 
+	cur_chunk++;
+	chunk_ids[cur_chunk] = 0;
+	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_entries * MIDX_HASH_LEN;
+
 	for (i = 0; i <= num_chunks; i++) {
 		if (i && chunk_offsets[i] < chunk_offsets[i - 1])
 			BUG("incorrect chunk offsets: %"PRIu64" before %"PRIu64,
@@ -468,6 +505,10 @@ int write_midx_file(const char *object_dir)
 				written += write_midx_pack_names(f, packs.names, packs.nr);
 				break;
 
+			case MIDX_CHUNKID_OIDLOOKUP:
+				written += write_midx_oid_lookup(f, MIDX_HASH_LEN, entries, nr_entries);
+				break;
+
 			default:
 				BUG("trying to write unknown chunk id %"PRIx32,
 				    chunk_ids[i]);
diff --git a/midx.h b/midx.h
index 17b56172e3..4d3bceafc5 100644
--- a/midx.h
+++ b/midx.h
@@ -15,6 +15,7 @@ struct multi_pack_index {
 	uint32_t num_objects;
 
 	const unsigned char *chunk_pack_names;
+	const unsigned char *chunk_oid_lookup;
 
 	const char **pack_names;
 	char object_dir[FLEX_ARRAY];
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 76a60d7882..de6d452a7c 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -22,6 +22,8 @@ static int read_midx_file(const char *object_dir)
 
 	if (m->chunk_pack_names)
 		printf(" pack-names");
+	if (m->chunk_oid_lookup)
+		printf(" oid-lookup");
 
 	printf("\n");
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index e8da082c64..4813610115 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -7,8 +7,8 @@ midx_read_expect () {
 	NUM_PACKS=$1
 	{
 		cat <<-EOF &&
-		header: 4d494458 1 1 $NUM_PACKS
-		chunks: pack-names
+		header: 4d494458 1 2 $NUM_PACKS
+		chunks: pack-names oid-lookup
 		packs:
 		EOF
 		if test $NUM_PACKS -ge 1
-- 
2.18.0.118.gd4f65b8d14

