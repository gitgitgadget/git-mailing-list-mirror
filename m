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
	by dcvr.yhbt.net (Postfix) with ESMTP id 319151F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934467AbeFYOfQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:35:16 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42222 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934420AbeFYOfO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:35:14 -0400
Received: by mail-qt0-f193.google.com with SMTP id y31-v6so12103883qty.9
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MTXOe1HaOdpsNeJtUdgLLV+ra1gro0djdYgO7LABfXQ=;
        b=qgavNF4XTRGAcPgHkpgOhsGunirCS7QcsGASKSh6Qv+Q++77+wFC++DTF4x0maszX9
         VPwKLsDZWGBXD8ugYO0XvS5fq5Le6+RAijST79b3lh4CT+12CeBEPsa/7itXM3IvurQQ
         91urpwis/HdKnlqZ+Lld5suns4rdzbuxJTL+RIUl0uW/vvCN9fFshhHS6N7wmd2oj904
         u8tbZJ7pZG2+g5PnihJ2pq5purDdh9FaSR6P+Lri8gCYSucIb/SrqONK6+4PtpySjueY
         ZRHvHx0mYyyg9s2vZ+4mDwT7UH3Kzf3+X1RjsGTz4zSPNeyyrLJPqYdE44OvLDOx/NhF
         iRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MTXOe1HaOdpsNeJtUdgLLV+ra1gro0djdYgO7LABfXQ=;
        b=uODzcPvp4MNPXUJsD1wykj2rSGA/13BmbMsA4+svZk/ZccM0HRpC8e4Bjoj2ltNrTe
         NIhN9jy977lvmy4fKQ1yvr429btr8hMOQu7UfxsWdWcWs2DxErG6DcLFK89gEhBI4G0F
         M+Dm80trxHFJIoZd/VQ/A3e51yBl39WyHRwIfA4BLk12VY/MYeI/6xj/ulAflGnhPn0x
         nJtOart21MAwFi3BPt58jtS/4Ua+KwImM6uFZ20hMmKgirKgFSqlTunWVMMBl3U732/r
         ys16MD3P9BFNsal8TRlnby+cKjyN4JOoCzDyv4txZOWfPx956iJ4cmTc8y16h0t+mKmK
         E3JA==
X-Gm-Message-State: APt69E2dfGqgzhcWc9QeeVf4JwioE1rJdrUqlLYsmbtdav9+jxrUGEsm
        Qi0NFC3JsTY68sDt53DfWnf5Qjbr
X-Google-Smtp-Source: ADUXVKJXSjFPXl/y3at+THKoCavETJ6rK9p3BZihQ2DE2Pa4qtY5qvCqclQz0qvgexl7QYbL7JnIbg==
X-Received: by 2002:ac8:1987:: with SMTP id u7-v6mr5617634qtj.296.1529937313330;
        Mon, 25 Jun 2018 07:35:13 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:35:12 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 11/24] midx: read pack names into array
Date:   Mon, 25 Jun 2018 10:34:21 -0400
Message-Id: <20180625143434.89044-12-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 31 +++++++++++++++++++++++++++++++
 object-store.h              |  1 +
 t/helper/test-read-midx.c   |  5 +++++
 t/t5319-multi-pack-index.sh |  7 ++++++-
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 2fad99d1b8..8bbc966f6b 100644
--- a/midx.c
+++ b/midx.c
@@ -33,6 +33,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 	uint32_t hash_version;
 	char *midx_name = get_midx_filename(object_dir);
 	uint32_t i;
+	const char *cur_pack_name;
 
 	fd = git_open(midx_name);
 
@@ -116,6 +117,22 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 	if (!m->chunk_pack_names)
 		die(_("multi-pack-index missing required pack-name chunk"));
 
+	m->pack_names = xcalloc(m->num_packs, sizeof(const char *));
+
+	cur_pack_name = (const char *)m->chunk_pack_names;
+	for (i = 0; i < m->num_packs; i++) {
+		m->pack_names[i] = cur_pack_name;
+
+		cur_pack_name += strlen(cur_pack_name) + 1;
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
@@ -210,6 +227,20 @@ static void sort_packs_by_name(char **pack_names, uint32_t nr_packs, uint32_t *p
 	FREE_AND_NULL(pairs);
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
diff --git a/object-store.h b/object-store.h
index c87d051849..88169b33e9 100644
--- a/object-store.h
+++ b/object-store.h
@@ -99,6 +99,7 @@ struct multi_pack_index {
 
 	const unsigned char *chunk_pack_names;
 
+	const char **pack_names;
 	char object_dir[FLEX_ARRAY];
 };
 
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index a9232d8219..0b53a9e8b5 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -9,6 +9,7 @@
 
 static int read_midx_file(const char *object_dir)
 {
+	uint32_t i;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir);
 
 	if (!m)
@@ -27,6 +28,10 @@ static int read_midx_file(const char *object_dir)
 
 	printf("\n");
 
+	printf("packs:\n");
+	for (i = 0; i < m->num_packs; i++)
+		printf("%s\n", m->pack_names[i]);
+
 	printf("object_dir: %s\n", m->object_dir);
 
 	return 0;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 1b2778961c..800fa7749c 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -8,8 +8,13 @@ midx_read_expect() {
 	cat >expect <<- EOF
 	header: 4d494458 1 1 $NUM_PACKS
 	chunks: pack_names
-	object_dir: .
+	packs:
 	EOF
+	if [ $NUM_PACKS -ge 1 ]
+	then
+		ls pack/ | grep idx | sort >> expect
+	fi
+	printf "object_dir: .\n" >>expect &&
 	test-tool read-midx . >actual &&
 	test_cmp expect actual
 }
-- 
2.18.0.24.g1b579a2ee9

