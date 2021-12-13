Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DA5C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhLMQB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbhLMQB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:01:57 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1156EC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:01:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q3so27860758wru.5
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RcgBFyWwgZa1ROCpS0L84QF2gIigNt1K2hN96KYh83E=;
        b=f/f3G7FC4M6O6dKU3D3qMkcRooEuOzr+87FwUed4nYio9KdZYBDm9P8SiBT2eykBoK
         0zPiqugi5OfqKMa71uPaocvoQDtlEV68iZi2HU3xAFapvF1zyXBCB8qPJWB/Taj3QcBR
         SH6KRmA4wz1bCPN8Vq6ekVJeq+QJ0pIA3Y0w9bEIi48NpmSWSbqFb8VQrnbGV9G3cbMW
         Ftk2Rvbxdds6UPMO5iagy/t/31x0p2+DVnaGU9jy8Eb1d3QofpjVPWWmizcZUep7+JEM
         EVi6Hzas/H8965BJ3TFGVJnFD1umkuzdOz6F47YLPrIMfKTdwpiNNEYKwPa3KAgBupJ9
         Bb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RcgBFyWwgZa1ROCpS0L84QF2gIigNt1K2hN96KYh83E=;
        b=OoECEKc0R+wHxjF3REZLeB7Vc/EqlDcCOJQUrhzc2jSxjx9uuS9CdxCUThqZOGQaGp
         Zt+VuEjZ2TLfYriAYneS2vehedZ9o83vtoTAQP/kPGSRshbx+PeYQRCn3uh4amDrLPb4
         42dzeb0XcEI4sA8A6/A1xzHnZNS4auHx3yuaBkaMWVUMeIYoT22KxSLaQTr9QLLlxGnw
         f4jP0UAGRsCqvy2A0NNHP1d1YUYXYBd/8PrXT7HPqbv8f+V5qmaON+AGRb0w05ZDSDDI
         h1y3OVNRJm2yZMsqN60Ar67AVA+tAkCxAWtSF8eF9z60Y3UMKhjchYYvt1tTP1cwCPaC
         P6LA==
X-Gm-Message-State: AOAM5327HGn0eDydSbngHIphnXTWMsZuG3MerCR511w1OUck/APOhGLH
        tBhZNMNLMQV7hOG5PgF+agajZSHvFb8=
X-Google-Smtp-Source: ABdhPJzd5JfwtcDs0lPsnp8jdb1hzTrc2lHMQo8bcQaS48bVQd4RINpLfEN5l4dTnyOU7GlylFyshQ==
X-Received: by 2002:a5d:6244:: with SMTP id m4mr33120029wrv.186.1639411313099;
        Mon, 13 Dec 2021 08:01:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a198sm8679538wme.1.2021.12.13.08.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:01:52 -0800 (PST)
Message-Id: <975a570d388fca79546987f4683fcd33419aad98.1639411309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
        <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Dec 2021 16:01:40 +0000
Subject: [PATCH v3 02/11] reftable: fix resource leak in error path
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Add test coverage for corrupt zlib data.

This problem was discovered by a Coverity scan.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/block.c          | 28 ++++++++++------
 reftable/readwrite_test.c | 67 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 9 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 855e3f5c947..37a85b9576d 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -188,13 +188,16 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 	uint32_t full_block_size = table_block_size;
 	uint8_t typ = block->data[header_off];
 	uint32_t sz = get_be24(block->data + header_off + 1);
-
+	int err = 0;
 	uint16_t restart_count = 0;
 	uint32_t restart_start = 0;
 	uint8_t *restart_bytes = NULL;
+	uint8_t *uncompressed = NULL;
 
-	if (!reftable_is_block_type(typ))
-		return REFTABLE_FORMAT_ERROR;
+	if (!reftable_is_block_type(typ)) {
+		err =  REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
 
 	if (typ == BLOCK_TYPE_LOG) {
 		int block_header_skip = 4 + header_off;
@@ -203,7 +206,7 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 		uLongf src_len = block->len - block_header_skip;
 		/* Log blocks specify the *uncompressed* size in their header.
 		 */
-		uint8_t *uncompressed = reftable_malloc(sz);
+		uncompressed = reftable_malloc(sz);
 
 		/* Copy over the block header verbatim. It's not compressed. */
 		memcpy(uncompressed, block->data, block_header_skip);
@@ -212,16 +215,19 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 		if (Z_OK !=
 		    uncompress2(uncompressed + block_header_skip, &dst_len,
 				block->data + block_header_skip, &src_len)) {
-			reftable_free(uncompressed);
-			return REFTABLE_ZLIB_ERROR;
+			err = REFTABLE_ZLIB_ERROR;
+			goto done;
 		}
 
-		if (dst_len + block_header_skip != sz)
-			return REFTABLE_FORMAT_ERROR;
+		if (dst_len + block_header_skip != sz) {
+			err = REFTABLE_FORMAT_ERROR;
+			goto done;
+		}
 
 		/* We're done with the input data. */
 		reftable_block_done(block);
 		block->data = uncompressed;
+		uncompressed = NULL;
 		block->len = sz;
 		block->source = malloc_block_source();
 		full_block_size = src_len + block_header_skip;
@@ -251,7 +257,11 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 	br->restart_count = restart_count;
 	br->restart_bytes = restart_bytes;
 
-	return 0;
+done:
+	if (uncompressed) {
+		reftable_free(uncompressed);
+	}
+	return err;
 }
 
 static uint32_t block_reader_restart_offset(struct block_reader *br, int i)
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 5f6bcc2f775..42caf0bde4c 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -254,6 +254,72 @@ static void test_log_write_read(void)
 	reader_close(&rd);
 }
 
+static void test_log_zlib_corruption(void)
+{
+	struct reftable_write_options opts = {
+		.block_size = 256,
+	};
+	struct reftable_iterator it = { NULL };
+	struct reftable_reader rd = { NULL };
+	struct reftable_block_source source = { NULL };
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+	const struct reftable_stats *stats = NULL;
+	uint8_t hash1[GIT_SHA1_RAWSZ] = { 1 };
+	uint8_t hash2[GIT_SHA1_RAWSZ] = { 2 };
+	char message[100] = { 0 };
+	int err, i, n;
+
+	struct reftable_log_record log = {
+		.refname = "refname",
+		.value_type = REFTABLE_LOG_UPDATE,
+		.value = {
+			.update = {
+				.new_hash = hash1,
+				.old_hash = hash2,
+				.name = "My Name",
+				.email = "myname@invalid",
+				.message = message,
+			},
+		},
+	};
+
+	for (i = 0; i < sizeof(message)-1; i++) {
+		message[i] = (uint8_t)(rand() % 64 + ' ');
+	}
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	err = reftable_writer_add_log(w, &log);
+	EXPECT_ERR(err);
+
+	n = reftable_writer_close(w);
+	EXPECT(n == 0);
+
+	stats = writer_stats(w);
+	EXPECT(stats->log_stats.blocks > 0);
+	reftable_writer_free(w);
+	w = NULL;
+
+	/* corrupt the data. */
+	buf.buf[50] ^= 0x99;
+
+	block_source_from_strbuf(&source, &buf);
+
+	err = init_reader(&rd, &source, "file.log");
+	EXPECT_ERR(err);
+
+	err = reftable_reader_seek_log(&rd, &it, "refname");
+	EXPECT(err == REFTABLE_ZLIB_ERROR);
+
+	reftable_iterator_destroy(&it);
+
+	/* cleanup. */
+	strbuf_release(&buf);
+	reader_close(&rd);
+}
+
 static void test_table_read_write_sequential(void)
 {
 	char **names;
@@ -633,6 +699,7 @@ static void test_corrupt_table(void)
 
 int readwrite_test_main(int argc, const char *argv[])
 {
+	RUN_TEST(test_log_zlib_corruption);
 	RUN_TEST(test_corrupt_table);
 	RUN_TEST(test_corrupt_table_empty);
 	RUN_TEST(test_log_write_read);
-- 
gitgitgadget

