Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 854B31F404
	for <e@80x24.org>; Sun,  7 Jan 2018 18:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754480AbeAGSPm (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:42 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44248 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754415AbeAGSPT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:19 -0500
Received: by mail-qk0-f195.google.com with SMTP id v188so11712522qkh.11
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gQw+S5Gb2caeDxpcuxOQg74GDh5YiskteDmqyjAjZVg=;
        b=pw59/wNrzAR7xWMpQCn49bAGSp0bgy3WxWBAA2gtNllq+4TWe2dFx8oAb1M1XiaMdh
         09peXO1YWRoHl/zyIjvSpc0t7VFz12PvSG5NzIRSUnuMY/TimbvB06JmiX9CqAIiitUT
         Afn+mR5k53/NKPpjLqwF6T4e4sp0hH9wseYTN8LO2DXKABbbW6RHG2f/Sq8gYCu+CrRN
         Cj2LcQ4RGU8ItSEXvCAu3csWXci5yyqUC6qKtvoi1QVZhcu9d4VSX/GimVQz1DYfokRR
         oUf9NGwvyes2NImKMv49Gnt+z8CjnI08HyC+Ihq4r6b2BfDB2ZArsiFPFep9YzzV/rM/
         AAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gQw+S5Gb2caeDxpcuxOQg74GDh5YiskteDmqyjAjZVg=;
        b=AyQdV6q7vA+ZpWj0HZCCelKJr8IvWdcUie4+It6E0AQRZdG/ZuGat9svhBAKayiB+l
         nSxE7QeSx03Xagzlm4gMEJQRS+61QK9Bn7Asj1ku4PXXU9Z24hpBYgp6XbAE5wYEAX6f
         qiyi4QHyUW2KAW6vHfPB2sGRH49yWUcZA3ZyI37wPp/miHoAxhu+sw2aGMKUsU+OKzY2
         1S9eeihQ11CqaTIy2lLebOy8VWBaxqx+b3WQRPBLLBAaccTfHr/UdOdxN5UVnfFRVO+M
         mKXb4WtH8I4KaCtEV9i2utEdmJvUP/5O9gWqdJaix1yjNfVAtn3NPE+zLdtv6S3H90Eg
         W3Ag==
X-Gm-Message-State: AKGB3mIKfWIr+EphrRF2c2GIZW5kWq6x4WJ6b7q1sD7Y2Lk1/kDeZdKY
        2DmOb+A53Uh35IxfCY/l+otAegzX9g0=
X-Google-Smtp-Source: ACJfBounMNFe8MOovTRJBBkiW/Uc9Jh9B1rpypNAglFvQx5GvJ/9tC4S1H+S+nRUwenG+T4zGl4epw==
X-Received: by 10.55.130.69 with SMTP id e66mr13486738qkd.76.1515348918863;
        Sun, 07 Jan 2018 10:15:18 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:18 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 10/18] midx: use existing midx when writing
Date:   Sun,  7 Jan 2018 13:14:51 -0500
Message-Id: <20180107181459.222909-11-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a new MIDX file, it is faster to use an existing MIDX file
to load the object list and pack offsets and to only inspect pack-indexes
for packs not already covered by the MIDX file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/midx.c | 34 +++++++++++++++++++++++++++++++---
 midx.c         | 23 +++++++++++++++++++++++
 midx.h         |  2 ++
 3 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/builtin/midx.c b/builtin/midx.c
index ee9234583d..aff2085771 100644
--- a/builtin/midx.c
+++ b/builtin/midx.c
@@ -73,7 +73,7 @@ static int midx_read(void)
 static int build_midx_from_packs(
 	const char *pack_dir,
 	const char **pack_names, uint32_t nr_packs,
-	const char **midx_id)
+	const char **midx_id, struct midxed_git *midx)
 {
 	struct packed_git **packs;
 	const char **installed_pack_names;
@@ -86,6 +86,9 @@ static int build_midx_from_packs(
 	struct strbuf pack_path = STRBUF_INIT;
 	int baselen;
 
+	if (midx)
+		nr_total_packs += midx->num_packs;
+
 	if (!nr_total_packs) {
 		*midx_id = NULL;
 		return 0;
@@ -94,6 +97,12 @@ static int build_midx_from_packs(
 	ALLOC_ARRAY(packs, nr_total_packs);
 	ALLOC_ARRAY(installed_pack_names, nr_total_packs);
 
+	if (midx) {
+		for (i = 0; i < midx->num_packs; i++)
+			installed_pack_names[nr_installed_packs++] = midx->pack_names[i];
+		pack_offset = midx->num_packs;
+	}
+
 	strbuf_addstr(&pack_path, pack_dir);
 	strbuf_addch(&pack_path, '/');
 	baselen = pack_path.len;
@@ -101,6 +110,9 @@ static int build_midx_from_packs(
 		strbuf_setlen(&pack_path, baselen);
 		strbuf_addstr(&pack_path, pack_names[i]);
 
+		if (midx && contains_pack(midx, pack_names[i]))
+			continue;
+
 		strbuf_strip_suffix(&pack_path, ".pack");
 		strbuf_addstr(&pack_path, ".idx");
 
@@ -120,13 +132,24 @@ static int build_midx_from_packs(
 	if (!nr_objects || !nr_installed_packs) {
 		FREE_AND_NULL(packs);
 		FREE_AND_NULL(installed_pack_names);
-		*midx_id = NULL;
+
+		if (opts.has_existing)
+			*midx_id = oid_to_hex(&opts.old_midx_oid);
+		else
+			*midx_id = NULL;
+
 		return 0;
 	}
 
+	if (midx)
+		nr_objects += midx->num_objects;
+
 	ALLOC_ARRAY(objects, nr_objects);
 	nr_objects = 0;
 
+	for (i = 0; midx && i < midx->num_objects; i++)
+		nth_midxed_object_entry(midx, i, &objects[nr_objects++]);
+
 	for (i = pack_offset; i < nr_installed_packs; i++) {
 		struct packed_git *p = packs[i];
 
@@ -184,6 +207,10 @@ static int midx_write(void)
 	const char *midx_id = 0;
 	DIR *dir;
 	struct dirent *de;
+	struct midxed_git *midx = NULL;
+
+	if (opts.has_existing)
+		midx = get_midxed_git(opts.pack_dir, &opts.old_midx_oid);
 
 	dir = opendir(opts.pack_dir);
 	if (!dir) {
@@ -212,7 +239,8 @@ static int midx_write(void)
 	if (!nr_packs)
 		goto cleanup;
 
-	if (build_midx_from_packs(opts.pack_dir, pack_names, nr_packs, &midx_id))
+	if (build_midx_from_packs(opts.pack_dir, pack_names,
+				  nr_packs, &midx_id, midx))
 		die("failed to build MIDX");
 
 	if (midx_id == NULL)
diff --git a/midx.c b/midx.c
index 4e0df0285a..53eb29dac3 100644
--- a/midx.c
+++ b/midx.c
@@ -257,6 +257,29 @@ const struct object_id *nth_midxed_object_oid(struct object_id *oid,
 	return oid;
 }
 
+int contains_pack(struct midxed_git *m, const char *pack_name)
+{
+	uint32_t first = 0, last = m->num_packs;
+
+	while (first < last) {
+		uint32_t mid = first + (last - first) / 2;
+		const char *current;
+		int cmp;
+
+		current = m->pack_names[mid];
+		cmp = strcmp(pack_name, current);
+		if (!cmp)
+			return 1;
+		if (cmp > 0) {
+			first = mid + 1;
+			continue;
+		}
+		last = mid;
+	}
+
+	return 0;
+}
+
 static int midx_sha1_compare(const void *_a, const void *_b)
 {
 	struct pack_midx_entry *a = *(struct pack_midx_entry **)_a;
diff --git a/midx.h b/midx.h
index 9255909ae8..1e7a94651c 100644
--- a/midx.h
+++ b/midx.h
@@ -100,6 +100,8 @@ extern const struct object_id *nth_midxed_object_oid(struct object_id *oid,
 						     struct midxed_git *m,
 						     uint32_t n);
 
+extern int contains_pack(struct midxed_git *m, const char *pack_name);
+
 /*
  * Write a single MIDX file storing the given entries for the
  * given list of packfiles. If midx_name is null, then a temp
-- 
2.15.0

