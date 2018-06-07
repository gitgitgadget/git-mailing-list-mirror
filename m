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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FFC31F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932861AbeFGOD4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:03:56 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42450 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932829AbeFGODz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:03:55 -0400
Received: by mail-qt0-f194.google.com with SMTP id y31-v6so9911548qty.9
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kTkZrxHvHRn6AdKsG9hbaUmwGtIQut5bRUKrTzFZHd8=;
        b=VhvVaViVb2Wd0OArGBbtYQ7KBJ1YPZSWen+Xv72/0FgwEwPDWGRBD/w99QsOUU/YX7
         3AtIa5CGBjlIOP5rLbbT+/XTL/R+7Rhxw5dAFJNmHZSd58JOmVTGIA88/O9asGGWv5FA
         D5S0X/qIp9cbQTC4Btb66Qzqc7RVRdO9vl2D7fiK6R+Dv8Wazh53ate0dD5vbbYODtyx
         fT22r1xM6Urt3qjxgyg+etOM0OBHA6AkswK1Ku1sGjj5KsmqcmiguITUo/1ueDn61Xet
         shOh7keRZASo/ZobqU5LnUEUKd2uve0Mvjc6YMH1uAOfWj9PDY468a6hB59WPnQNaOLJ
         8mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kTkZrxHvHRn6AdKsG9hbaUmwGtIQut5bRUKrTzFZHd8=;
        b=fm82H4Nq2b7xkCreB1oujpCeHMGHB+EtzxgNwGE0WGs4E1Wn9PAW0V4jgXfveqHg1Z
         uMeOb9tkFDljMMIzaudi80ij2XK+VDDFUBJHYneVP8g1zxXc2ZksviHlk03cjG1LTLVH
         DE4atOTiQHPF7iHysr13O07aR/aFEWGlH6VX3H7uDkBYXayynS4rldzxY/PA9BN0nVNv
         QsXxL2uOCdOkU5WZFSUAKvHFsvhL7wsT+fjtEnfnbXjEZiB6SB9P7AfIlHom5SP3fEzF
         /xWutCOiLqA+O5gmBGDqNf6lwdBPqe3zHBFoG8AmJjId2LNi47fR6cza7z7zxYVw2mFP
         1JtA==
X-Gm-Message-State: APt69E0Tz1/3BqfMArND40+I2EmUv0UDIocOAwRqLGhvKxUfnTj2oApe
        xrcd1GRWyuiGrguCsHFStwGrdn7u
X-Google-Smtp-Source: ADUXVKL5B0lR7/enYHvdBD42H8BSTcdA50Tc8Lnx8Q9hSZOJMrGp93Uiw1sHm26IZside40CzNei/A==
X-Received: by 2002:aed:21ce:: with SMTP id m14-v6mr1868784qtc.292.1528380234676;
        Thu, 07 Jun 2018 07:03:54 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:03:54 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 10/23] midx: write a lookup into the pack names chunk
Date:   Thu,  7 Jun 2018 10:03:25 -0400
Message-Id: <20180607140338.32440-11-dstolee@microsoft.com>
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
 builtin/midx.c                          |  7 ++++
 midx.c                                  | 56 +++++++++++++++++++++++--
 object-store.h                          |  2 +
 t/t5319-midx.sh                         | 11 +++--
 5 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 2b37be7b33..29bf87283a 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -296,6 +296,11 @@ CHUNK LOOKUP:
 
 CHUNK DATA:
 
+	Packfile Name Lookup (ID: {'P', 'L', 'O', 'O'}) (P * 4 bytes)
+	    P * 4 bytes storing the offset in the packfile name chunk for
+	    the null-terminated string containing the filename for the
+	    ith packfile.
+
 	Packfile Names (ID: {'P', 'N', 'A', 'M'})
 	    Stores the packfile names as concatenated, null-terminated strings.
 	    Packfiles must be listed in lexicographic order for fast lookups by
diff --git a/builtin/midx.c b/builtin/midx.c
index fe56560853..3a261e9bbf 100644
--- a/builtin/midx.c
+++ b/builtin/midx.c
@@ -16,6 +16,7 @@ static struct opts_midx {
 
 static int read_midx_file(const char *object_dir)
 {
+	uint32_t i;
 	struct midxed_git *m = load_midxed_git(object_dir);
 
 	if (!m)
@@ -30,11 +31,17 @@ static int read_midx_file(const char *object_dir)
 
 	printf("chunks:");
 
+	if (m->chunk_pack_lookup)
+		printf(" pack_lookup");
 	if (m->chunk_pack_names)
 		printf(" pack_names");
 
 	printf("\n");
 
+	printf("packs:\n");
+	for (i = 0; i < m->num_packs; i++)
+		printf("%s\n", m->pack_names[i]);
+
 	printf("object_dir: %s\n", m->object_dir);
 
 	return 0;
diff --git a/midx.c b/midx.c
index d4f4a01a51..923acda72e 100644
--- a/midx.c
+++ b/midx.c
@@ -13,8 +13,9 @@
 #define MIDX_HASH_LEN 20
 #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + MIDX_HASH_LEN)
 
-#define MIDX_MAX_CHUNKS 1
+#define MIDX_MAX_CHUNKS 2
 #define MIDX_CHUNK_ALIGNMENT 4
+#define MIDX_CHUNKID_PACKLOOKUP 0x504c4f4f /* "PLOO" */
 #define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
 #define MIDX_CHUNKLOOKUP_WIDTH (sizeof(uint32_t) + sizeof(uint64_t))
 
@@ -85,6 +86,10 @@ struct midxed_git *load_midxed_git(const char *object_dir)
 		uint64_t chunk_offset = get_be64(m->data + 16 + MIDX_CHUNKLOOKUP_WIDTH * i);
 
 		switch (chunk_id) {
+			case MIDX_CHUNKID_PACKLOOKUP:
+				m->chunk_pack_lookup = (uint32_t *)(m->data + chunk_offset);
+				break;
+
 			case MIDX_CHUNKID_PACKNAMES:
 				m->chunk_pack_names = m->data + chunk_offset;
 				break;
@@ -102,9 +107,32 @@ struct midxed_git *load_midxed_git(const char *object_dir)
 		}
 	}
 
+	if (!m->chunk_pack_lookup)
+		die("MIDX missing required pack lookup chunk");
 	if (!m->chunk_pack_names)
 		die("MIDX missing required pack-name chunk");
 
+	m->pack_names = xcalloc(m->num_packs, sizeof(const char *));
+	for (i = 0; i < m->num_packs; i++) {
+		if (i) {
+			if (ntohl(m->chunk_pack_lookup[i]) <= ntohl(m->chunk_pack_lookup[i - 1])) {
+				error("MIDX pack lookup value %d before %d",
+				      ntohl(m->chunk_pack_lookup[i - 1]),
+				      ntohl(m->chunk_pack_lookup[i]));
+				goto cleanup_fail;
+			}
+		}
+
+		m->pack_names[i] = (const char *)(m->chunk_pack_names + ntohl(m->chunk_pack_lookup[i]));
+
+		if (i && strcmp(m->pack_names[i], m->pack_names[i - 1]) <= 0) {
+			error("MIDX pack names out of order: '%s' before '%s'",
+			      m->pack_names[i - 1],
+			      m->pack_names[i]);
+			goto cleanup_fail;
+		}
+	}
+
 	return m;
 
 cleanup_fail:
@@ -162,6 +190,20 @@ static void sort_packs_by_name(char **pack_names, uint32_t nr_packs, uint32_t *p
 	}
 }
 
+static size_t write_midx_pack_lookup(struct hashfile *f,
+				     char **pack_names,
+				     uint32_t nr_packs)
+{
+	uint32_t i, cur_len = 0;
+
+	for (i = 0; i < nr_packs; i++) {
+		hashwrite_be32(f, cur_len);
+		cur_len += strlen(pack_names[i]) + 1;
+	}
+
+	return sizeof(uint32_t) * (size_t)nr_packs;
+}
+
 static size_t write_midx_pack_names(struct hashfile *f,
 				    char **pack_names,
 				    uint32_t num_packs)
@@ -275,13 +317,17 @@ int write_midx_file(const char *object_dir)
 	FREE_AND_NULL(midx_name);
 
 	cur_chunk = 0;
-	num_chunks = 1;
+	num_chunks = 2;
 
 	written = write_midx_header(f, num_chunks, nr_packs);
 
-	chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
+	chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKLOOKUP;
 	chunk_offsets[cur_chunk] = written + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
 
+	cur_chunk++;
+	chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
+	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_packs * sizeof(uint32_t);
+
 	cur_chunk++;
 	chunk_ids[cur_chunk] = 0;
 	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + pack_name_concat_len;
@@ -311,6 +357,10 @@ int write_midx_file(const char *object_dir)
 			    chunk_ids[i]);
 
 		switch (chunk_ids[i]) {
+			case MIDX_CHUNKID_PACKLOOKUP:
+				written += write_midx_pack_lookup(f, pack_names, nr_packs);
+				break;
+
 			case MIDX_CHUNKID_PACKNAMES:
 				written += write_midx_pack_names(f, pack_names, nr_packs);
 				break;
diff --git a/object-store.h b/object-store.h
index 199cf4bd44..1ba50459ca 100644
--- a/object-store.h
+++ b/object-store.h
@@ -100,8 +100,10 @@ struct midxed_git {
 	uint32_t num_packs;
 	uint32_t num_objects;
 
+	const uint32_t *chunk_pack_lookup;
 	const unsigned char *chunk_pack_names;
 
+	const char **pack_names;
 	char object_dir[FLEX_ARRAY];
 };
 
diff --git a/t/t5319-midx.sh b/t/t5319-midx.sh
index fdf4f84a90..a31c387c8f 100755
--- a/t/t5319-midx.sh
+++ b/t/t5319-midx.sh
@@ -6,10 +6,15 @@ test_description='multi-pack-indexes'
 midx_read_expect() {
 	NUM_PACKS=$1
 	cat >expect <<- EOF
-	header: 4d494458 1 1 1 $NUM_PACKS
-	chunks: pack_names
-	object_dir: .
+	header: 4d494458 1 1 2 $NUM_PACKS
+	chunks: pack_lookup pack_names
+	packs:
 	EOF
+	if [ $NUM_PACKS -ge 1 ]
+	then
+		ls pack/ | grep idx | sort >> expect
+	fi
+	printf "object_dir: .\n" >>expect &&
 	git midx read --object-dir=. >actual &&
 	test_cmp expect actual
 }
-- 
2.18.0.rc1

