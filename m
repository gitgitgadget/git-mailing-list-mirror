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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B2C91F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 00:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753813AbeGFAxy (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 20:53:54 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40140 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753547AbeGFAxw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 20:53:52 -0400
Received: by mail-qt0-f196.google.com with SMTP id h4-v6so8715986qtj.7
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 17:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Dr9bFsUoFphkouDb6c70dQrGQII7WHSzhfl9LBcqAg=;
        b=hh/V3MpHcMAUsr0yEhVi89clFbkgj9aPc6mqksez+O3+ZJQmHlIFgn9tozN9yeTCA4
         pmimFyNeHIRYeZFNHO2WhmNRJdCCW2gh7xdxEzujuqQzFCAAtsELYbPYVnHbYCEGy2mR
         ob8Y6GdTaj8269O2wb9D9gIpUvZfz0ebMxKrCMNuQDhi3aWTZTlTeW7BSzFoShFwnteu
         sdSuxWCUxHbPIgp28SacAhh3H3Eb3pOz8+XO4o6W2ukKKVnjLEP5yWGmXxHdFJ5Niv5Y
         PPIAHJvsjAZJFD26IhjmU59W1nTKgnNXWUX14MKN8/vfj7V+ta2d59qymKT1TcxQGUtN
         91sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Dr9bFsUoFphkouDb6c70dQrGQII7WHSzhfl9LBcqAg=;
        b=dUTTBt7V8GLg2B4hUbA2Qe9dW47tmypLZ3bsJk5oG3xJZJd2XazJW9fB7FS+MQI37W
         KiFPFnd5nxml6EtnSw5sRKK9O4xkOtWZpavVi0wnntqERp1en0T6GRYsp6rxx33LUeMF
         i3WOnwrxa54sYYVmS0Dt05wTY3NbniSy6YFh1SP05rqSIAFxE+IPGk+/9lucKKKpPtn2
         HGRKpR6aMdD5oSsLPohkYl6wAJPIEy8SUUjuA18kr89fFVhV3h3Ry3m2qy8bVDyOFnzw
         A1Telkg5lWrPSLKK2NgPfQv3jKyL5HAeflWe1m9WbjTWS5PsrDupqkdgiKuP9gB6TZY3
         w9zg==
X-Gm-Message-State: APt69E025leoz3weJZ4xEhV22wJhc3AUVSeczJh59q+iNok9A9IPvKlH
        5bKbJFYyUyOitirI2xf3e7XWRkvW
X-Google-Smtp-Source: AAOMgpd4FcJkCTdt5UnwqV95Qnj629Xjm67C4peaaQx2r7y6aDKPEBfOPTX7Ujx5lPQg5MwgYXd71g==
X-Received: by 2002:ac8:25f1:: with SMTP id f46-v6mr7602998qtf.20.1530838431688;
        Thu, 05 Jul 2018 17:53:51 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u25-v6sm4882791qku.3.2018.07.05.17.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 17:53:51 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v3 13/24] midx: write object ids in a chunk
Date:   Thu,  5 Jul 2018 20:53:10 -0400
Message-Id: <20180706005321.124643-14-dstolee@microsoft.com>
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
 Documentation/technical/pack-format.txt |  4 +++
 midx.c                                  | 47 +++++++++++++++++++++++--
 object-store.h                          |  1 +
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
index 028e3aa5e9..7606addab6 100644
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
@@ -103,6 +104,10 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 				m->chunk_pack_names = m->data + chunk_offset;
 				break;
 
+			case MIDX_CHUNKID_OIDLOOKUP:
+				m->chunk_oid_lookup = m->data + chunk_offset;
+				break;
+
 			case 0:
 				die(_("terminating multi-pack-index chunk id appears earlier than expected"));
 				break;
@@ -118,6 +123,8 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 
 	if (!m->chunk_pack_names)
 		die(_("multi-pack-index missing required pack-name chunk"));
+	if (!m->chunk_oid_lookup)
+		die(_("multi-pack-index missing required OID lookup chunk"));
 
 	m->pack_names = xcalloc(m->num_packs, sizeof(*m->pack_names));
 
@@ -384,6 +391,32 @@ static size_t write_midx_pack_names(struct hashfile *f,
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
+				oid_to_hex(&obj->oid),
+				oid_to_hex(&next->oid));
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
@@ -430,7 +463,7 @@ int write_midx_file(const char *object_dir)
 	FREE_AND_NULL(midx_name);
 
 	cur_chunk = 0;
-	num_chunks = 1;
+	num_chunks = 2;
 
 	written = write_midx_header(f, num_chunks, packs.nr);
 
@@ -438,9 +471,13 @@ int write_midx_file(const char *object_dir)
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
@@ -470,6 +507,10 @@ int write_midx_file(const char *object_dir)
 				written += write_midx_pack_names(f, packs.names, packs.nr);
 				break;
 
+			case MIDX_CHUNKID_OIDLOOKUP:
+				written += write_midx_oid_lookup(f, MIDX_HASH_LEN, entries, nr_entries);
+				break;
+
 			default:
 				BUG("trying to write unknown chunk id %"PRIx32,
 				    chunk_ids[i]);
diff --git a/object-store.h b/object-store.h
index 88169b33e9..25f8530eb4 100644
--- a/object-store.h
+++ b/object-store.h
@@ -98,6 +98,7 @@ struct multi_pack_index {
 	uint32_t num_objects;
 
 	const unsigned char *chunk_pack_names;
+	const unsigned char *chunk_oid_lookup;
 
 	const char **pack_names;
 	char object_dir[FLEX_ARRAY];
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 0b53a9e8b5..60bca5b668 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -25,6 +25,8 @@ static int read_midx_file(const char *object_dir)
 
 	if (m->chunk_pack_names)
 		printf(" pack_names");
+	if (m->chunk_oid_lookup)
+		printf(" oid_lookup");
 
 	printf("\n");
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 4610352b69..cbe84c74fc 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -6,8 +6,8 @@ test_description='multi-pack-indexes'
 midx_read_expect () {
 	NUM_PACKS=$1
 	cat >expect <<-EOF
-	header: 4d494458 1 1 $NUM_PACKS
-	chunks: pack_names
+	header: 4d494458 1 2 $NUM_PACKS
+	chunks: pack_names oid_lookup
 	packs:
 	EOF
 	if [ $NUM_PACKS -ge 1 ]
-- 
2.18.0.118.gd4f65b8d14

