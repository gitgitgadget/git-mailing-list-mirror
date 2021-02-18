Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0801FC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9EA664DFF
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbhBRQxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbhBROKo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 09:10:44 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5702BC06121E
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:57 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o10so2856651wmc.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1PgZT6EaPlfpce1Ua+iT0ZDtcNGb1Q1tQze+1iKn424=;
        b=SKzem4ODfNr3fEkwSuN1E9DXYMXwVMgraB3eOYSDtYCXQHeyWLUuRlNX81P3KbuX9M
         MaOsJUGPsOdzy3k29xF3YG55fsxjjNFrw/Ckah1cu6VFw3DBOAY67qkb+Zk8F/h2G8yL
         y9CaunQiQ6a0k0GNLOdA4qim85iM5jnQBoiwzAPRCpnEyVdaUu8BNc/pdks+MCZXaLmK
         1zJy6YuoOGFjlL7PBWvNMuTS73gUHX1OnAGYbdOiVDxGiILK7f6FEenyY5cPwgof+b31
         VkEtIdV0KLXtxiTmR+EXZeJmKXucxESUkEH/nxpz7RD81rJRHqy170dc9fiNxPckNkPW
         KijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1PgZT6EaPlfpce1Ua+iT0ZDtcNGb1Q1tQze+1iKn424=;
        b=jqIKIULVLWyrkP9dPPel6aSfc6Rr85FPBYBT4FJK8DLf/LSYmK9GpBO6zDniJNISTJ
         h7Ob3bwaFyDGsOm9UST2eoBVEnMjKGzD2IMa0saA11FdQkDr+WFFva+ateanupM0hEH6
         GwmOC2+yenaGePa9GvLxAHvhA7CtAwgTECw0f2fxgEkj0j7EwggBE2XCJKtOED9/7XHO
         r92GDm7E/SKoaf3kuKnDJueLEhkfMdPUAFvaHga2bvLNhruXD0vE/37vPAbpV5mifNEK
         1Jm4Ol/lWV4kSA8R+aOYdEZmyvog2T5kK1zKGarHmvoBMvGCTd2IwVhZ/x3NJ+APJ7oa
         mY+w==
X-Gm-Message-State: AOAM532+zlJDqly2WoPDUdf0ZtPuQtYULTP9j1rumvWI57LxEs0wu/DP
        kHzf3b2DQk1G35ZiBlLj4QdzXAgXK/Q=
X-Google-Smtp-Source: ABdhPJxNa3L0xcRE7g9Inde45ov1IzJxVBhqs1lkvlOUcMMdTHJwlUx9esUlaSO28lsqsJHR1ZbseA==
X-Received: by 2002:a1c:4b05:: with SMTP id y5mr3800275wma.37.1613657276032;
        Thu, 18 Feb 2021 06:07:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8sm8786971wrr.55.2021.02.18.06.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 06:07:55 -0800 (PST)
Message-Id: <64010031db0e44c8c040fa1a53f568574dd5a940.1613657259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
        <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Feb 2021 14:07:36 +0000
Subject: [PATCH v4 14/17] midx: use chunk-format read API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Instead of parsing the table of contents directly, use the chunk-format
API methods read_table_of_contents() and pair_chunk(). In particular, we
can use the return value of pair_chunk() to generate an error when a
required chunk is missing.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 73 +++++++++++++------------------------
 t/t5319-multi-pack-index.sh |  6 +--
 2 files changed, 29 insertions(+), 50 deletions(-)

diff --git a/midx.c b/midx.c
index d2fd9c10feea..d7ea0d1375fa 100644
--- a/midx.c
+++ b/midx.c
@@ -28,7 +28,6 @@
 #define MIDX_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define MIDX_CHUNKID_OBJECTOFFSETS 0x4f4f4646 /* "OOFF" */
 #define MIDX_CHUNKID_LARGEOFFSETS 0x4c4f4646 /* "LOFF" */
-#define MIDX_CHUNKLOOKUP_WIDTH (sizeof(uint32_t) + sizeof(uint64_t))
 #define MIDX_CHUNK_FANOUT_SIZE (sizeof(uint32_t) * 256)
 #define MIDX_CHUNK_OFFSET_WIDTH (2 * sizeof(uint32_t))
 #define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
@@ -53,6 +52,19 @@ static char *get_midx_filename(const char *object_dir)
 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
 }
 
+static int midx_read_oid_fanout(const unsigned char *chunk_start,
+				size_t chunk_size, void *data)
+{
+	struct multi_pack_index *m = data;
+	m->chunk_oid_fanout = (uint32_t *)chunk_start;
+
+	if (chunk_size != 4 * 256) {
+		error(_("multi-pack-index OID fanout is of the wrong size"));
+		return 1;
+	}
+	return 0;
+}
+
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local)
 {
 	struct multi_pack_index *m = NULL;
@@ -64,6 +76,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	char *midx_name = get_midx_filename(object_dir);
 	uint32_t i;
 	const char *cur_pack_name;
+	struct chunkfile *cf = NULL;
 
 	fd = git_open(midx_name);
 
@@ -113,58 +126,23 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 
 	m->num_packs = get_be32(m->data + MIDX_BYTE_NUM_PACKS);
 
-	for (i = 0; i < m->num_chunks; i++) {
-		uint32_t chunk_id = get_be32(m->data + MIDX_HEADER_SIZE +
-					     MIDX_CHUNKLOOKUP_WIDTH * i);
-		uint64_t chunk_offset = get_be64(m->data + MIDX_HEADER_SIZE + 4 +
-						 MIDX_CHUNKLOOKUP_WIDTH * i);
-
-		if (chunk_offset >= m->data_len)
-			die(_("invalid chunk offset (too large)"));
-
-		switch (chunk_id) {
-			case MIDX_CHUNKID_PACKNAMES:
-				m->chunk_pack_names = m->data + chunk_offset;
-				break;
-
-			case MIDX_CHUNKID_OIDFANOUT:
-				m->chunk_oid_fanout = (uint32_t *)(m->data + chunk_offset);
-				break;
-
-			case MIDX_CHUNKID_OIDLOOKUP:
-				m->chunk_oid_lookup = m->data + chunk_offset;
-				break;
-
-			case MIDX_CHUNKID_OBJECTOFFSETS:
-				m->chunk_object_offsets = m->data + chunk_offset;
-				break;
-
-			case MIDX_CHUNKID_LARGEOFFSETS:
-				m->chunk_large_offsets = m->data + chunk_offset;
-				break;
-
-			case 0:
-				die(_("terminating multi-pack-index chunk id appears earlier than expected"));
-				break;
-
-			default:
-				/*
-				 * Do nothing on unrecognized chunks, allowing future
-				 * extensions to add optional chunks.
-				 */
-				break;
-		}
-	}
+	cf = init_chunkfile(NULL);
 
-	if (!m->chunk_pack_names)
+	if (read_table_of_contents(cf, m->data, midx_size,
+				   MIDX_HEADER_SIZE, m->num_chunks))
+		goto cleanup_fail;
+
+	if (pair_chunk(cf, MIDX_CHUNKID_PACKNAMES, &m->chunk_pack_names) == CHUNK_NOT_FOUND)
 		die(_("multi-pack-index missing required pack-name chunk"));
-	if (!m->chunk_oid_fanout)
+	if (read_chunk(cf, MIDX_CHUNKID_OIDFANOUT, midx_read_oid_fanout, m) == CHUNK_NOT_FOUND)
 		die(_("multi-pack-index missing required OID fanout chunk"));
-	if (!m->chunk_oid_lookup)
+	if (pair_chunk(cf, MIDX_CHUNKID_OIDLOOKUP, &m->chunk_oid_lookup) == CHUNK_NOT_FOUND)
 		die(_("multi-pack-index missing required OID lookup chunk"));
-	if (!m->chunk_object_offsets)
+	if (pair_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS, &m->chunk_object_offsets) == CHUNK_NOT_FOUND)
 		die(_("multi-pack-index missing required object offsets chunk"));
 
+	pair_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets);
+
 	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
 
 	m->pack_names = xcalloc(m->num_packs, sizeof(*m->pack_names));
@@ -190,6 +168,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 cleanup_fail:
 	free(m);
 	free(midx_name);
+	free(cf);
 	if (midx_map)
 		munmap(midx_map, midx_size);
 	if (0 <= fd)
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 297de502a94f..ad4e878b65b8 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -314,12 +314,12 @@ test_expect_success 'verify bad OID version' '
 
 test_expect_success 'verify truncated chunk count' '
 	corrupt_midx_and_verify $MIDX_BYTE_CHUNK_COUNT "\01" $objdir \
-		"missing required"
+		"final chunk has non-zero id"
 '
 
 test_expect_success 'verify extended chunk count' '
 	corrupt_midx_and_verify $MIDX_BYTE_CHUNK_COUNT "\07" $objdir \
-		"terminating multi-pack-index chunk id appears earlier than expected"
+		"terminating chunk id appears earlier than expected"
 '
 
 test_expect_success 'verify missing required chunk' '
@@ -329,7 +329,7 @@ test_expect_success 'verify missing required chunk' '
 
 test_expect_success 'verify invalid chunk offset' '
 	corrupt_midx_and_verify $MIDX_BYTE_CHUNK_OFFSET "\01" $objdir \
-		"invalid chunk offset (too large)"
+		"improper chunk offset(s)"
 '
 
 test_expect_success 'verify packnames out of order' '
-- 
gitgitgadget

