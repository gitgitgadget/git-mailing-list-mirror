Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94657C4332D
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54627207E2
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhA0PfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbhA0PE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 10:04:28 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B85C06174A
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:14 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d16so2210085wro.11
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LCLkBb3Btx9eKiXsYizy8uFBjs8FNfUy9ILboNO8EaA=;
        b=sVUFjqch5xA1521sO0sTwQdWV8zefqBsBabx65LJzKdNRmxuvlNAfoKCKqplppwI1B
         T9R+1JsAt/ZkWvL6JRfFnANR5BFeRCs8d0cNzkAanI/ROKv55zWsW9oMGfWyyUZn4ocI
         rHvyvC+cTdGPgDJkHoJnccjShP47YTH8PBc11jsJoQ+1DtxZmQtDtvaSzmXnNw/6w5UK
         N3GRgidkqHtg8R8XUBlgzRIl6I2tC5cMkYuNtVixdMWcJPd2kesYV4DB9hUaBb80xjIf
         xwohYYpGqrW1KI8lBazLs68m2OKPOFvBtuELbmq66eEpFL9FuDR6HPObFJokSXe2duy+
         FEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LCLkBb3Btx9eKiXsYizy8uFBjs8FNfUy9ILboNO8EaA=;
        b=OBplYGOHwAjUaOfSbIIJ+/SeFdP6fA9C8nIhQACaxmcqwN4RiZSllizd9yoIJlsncG
         MuMf9PlScxA+ZO3tkhk/Qt0nci6CSnASHqHCh5W0kL0auSG2/2bgiTEGfg4Cr+Q/iJ2/
         2ovJoxSr9G5cCTxYFH+cemKiorwgSvRdE/ZYw+wNT+OEQn1dtp6YsXPi1auKs4FyhdXC
         xb8kLbD45IWhKP2bCw2p8UQyXDBI3UNbWw1P4cBWhfA3ks0/2XUKYgNIQah1/UZptKP0
         yNByP76KAuGX/bJ0GkmA8YmmmPl5NKBT6jZeLLfqTNtEbqJHGAFJrp/Bl0Hcl6jwEHOV
         k+aA==
X-Gm-Message-State: AOAM533Kx4YhVOoBWxMizatH6MC3McEiknSuESvCesChlNN6hoJTbKzU
        VAng1U1ibTT0qGkeI5YfUfotrplfHqs=
X-Google-Smtp-Source: ABdhPJzj6rLIikuzzkQMINFHUV5LA+qZ/eCA03TUyBJQzMrSLMZmxM3mIRVUoHI4EwdiYsH5Nd4LQw==
X-Received: by 2002:a5d:4383:: with SMTP id i3mr11604164wrq.293.1611759733187;
        Wed, 27 Jan 2021 07:02:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r10sm2719659wmd.15.2021.01.27.07.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:02:12 -0800 (PST)
Message-Id: <750c03253c95cf9fdbcf41bb65058956920ee83e.1611759716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 15:01:53 +0000
Subject: [PATCH v2 14/17] midx: use chunk-format read API
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
 midx.c                      | 71 +++++++++++++------------------------
 t/t5319-multi-pack-index.sh |  6 ++--
 2 files changed, 28 insertions(+), 49 deletions(-)

diff --git a/midx.c b/midx.c
index 3585e04a706..e94dcd34b7f 100644
--- a/midx.c
+++ b/midx.c
@@ -54,6 +54,19 @@ static char *get_midx_filename(const char *object_dir)
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
@@ -65,6 +78,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	char *midx_name = get_midx_filename(object_dir);
 	uint32_t i;
 	const char *cur_pack_name;
+	struct chunkfile *cf = NULL;
 
 	fd = git_open(midx_name);
 
@@ -114,58 +128,23 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 
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
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 297de502a94..ad4e878b65b 100755
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

