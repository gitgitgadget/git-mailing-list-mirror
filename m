Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E34CC4727E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 16:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32436208B6
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 16:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQk9K/hd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732775AbgJAQLl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 12:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732563AbgJAQLU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 12:11:20 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC49C0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 09:11:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w5so6455685wrp.8
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z3dSgdh+7hFzWN1s5WXlE+nNW0ZHU0jRSYr7NZjp3jw=;
        b=YQk9K/hdrTs6pJgaFIbJXTdy2b4jWOL4864ZcOAkx0VgOWVagZSFeXxb0VbuYIc2Dy
         vYvxWsm+vEfMgG5m+q07f60ABBSRNMjsUC0YFKRuSU0m2QeJOzBinvp7d180IA1QwcmQ
         Ezal4PDRqs4DbuZTMpNHQrYc4LztE/oUd8Sba9zspgJfr/pXIRU/pjO96BxUm2DOc8qx
         4OHixC8WDE6UrdGg+BodWE1Zi+KmmRzW9mNXPCVB2rsC8Pm7eePAckgzVkEumxewtnv8
         3lYWMhwR2sRYrjo0b/l+ndymQpGg7AgZQOaQ345kkVgwTB5H6bNk4vWkacq80Rt83WVt
         UmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z3dSgdh+7hFzWN1s5WXlE+nNW0ZHU0jRSYr7NZjp3jw=;
        b=UX29UkMgjFYI0pTuvQIP6ZMSc68b3qLuL8MvfcYAyv/RHopjtHLFMWkRSywwdQpRyE
         y3UEfOEdtsc4nAtj+mBJqf5wnQA2NbZisTduEfJY5CupHLTX7C5Rm6HDmHWMba7qpUJI
         Wl/nzsuaXH1RNshk1Ao07sXKEkasdA/KtMTEmZ+C18yzwa/8SNGeV5Yg6XY5Kq7SDg+3
         jho2FDXGIiagPV+jyyhfa6Nb7Pq6fC3lB2ZWq3VL6Hivr9quCPr58eSSMkiyXhFql6dj
         4aFWMbsIIx0yo2Sb6oDwDuEwdFg6t1JlwliKuzAnrQBhy3Cuo7FAX0LECzpEOVXlp2yz
         pWmQ==
X-Gm-Message-State: AOAM532t391/m5C7T10dKRN72J9MBxO2SB3X51DU/MahxzrVJK1/PzBf
        5XOskyRo1PTxI38ClCZC1cPvAw0A0HQ=
X-Google-Smtp-Source: ABdhPJzXPiH8lgeou+sWlgaUNMbqiK71ThK/PNfG36e34m+o8mSh98UhDHfguntwz+1AdORb9Dh5RQ==
X-Received: by 2002:adf:e690:: with SMTP id r16mr9701313wrm.15.1601568678851;
        Thu, 01 Oct 2020 09:11:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r19sm590122wmh.7.2020.10.01.09.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 09:11:18 -0700 (PDT)
Message-Id: <c535f838d62b90b4f24919323fdfaecfdadb2e2b.1601568664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
        <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Oct 2020 16:11:03 +0000
Subject: [PATCH v2 13/13] reftable: "test-tool dump-reftable" command.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This command dumps individual tables or a stack of of tables.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                 |  2 ++
 reftable/iter.c          |  6 +++---
 reftable/reader.c        | 22 +++++++++++-----------
 t/helper/test-reftable.c |  5 +++++
 t/helper/test-tool.c     |  1 +
 t/helper/test-tool.h     |  1 +
 6 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 05021f79a1..5f92e5cfc2 100644
--- a/Makefile
+++ b/Makefile
@@ -2391,6 +2391,8 @@ REFTABLE_OBJS += reftable/writer.o
 REFTABLE_OBJS += reftable/zlib-compat.o
 
 REFTABLE_TEST_OBJS += reftable/block_test.o
+REFTABLE_TEST_OBJS += reftable/dump.o
+REFTABLE_TEST_OBJS += reftable/merged_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/refname_test.o
 REFTABLE_TEST_OBJS += reftable/reftable_test.o
diff --git a/reftable/iter.c b/reftable/iter.c
index 2cff447323..80bc65e07d 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -59,7 +59,7 @@ void reftable_iterator_destroy(struct reftable_iterator *it)
 int reftable_iterator_next_ref(struct reftable_iterator *it,
 			       struct reftable_ref_record *ref)
 {
-	struct reftable_record rec = { 0 };
+	struct reftable_record rec = { NULL };
 	reftable_record_from_ref(&rec, ref);
 	return iterator_next(it, &rec);
 }
@@ -67,7 +67,7 @@ int reftable_iterator_next_ref(struct reftable_iterator *it,
 int reftable_iterator_next_log(struct reftable_iterator *it,
 			       struct reftable_log_record *log)
 {
-	struct reftable_record rec = { 0 };
+	struct reftable_record rec = { NULL };
 	reftable_record_from_log(&rec, log);
 	return iterator_next(it, &rec);
 }
@@ -95,7 +95,7 @@ static int filtering_ref_iterator_next(void *iter_arg,
 		}
 
 		if (fri->double_check) {
-			struct reftable_iterator it = { 0 };
+			struct reftable_iterator it = { NULL };
 
 			err = reftable_table_seek_ref(&fri->tab, &it,
 						      ref->refname);
diff --git a/reftable/reader.c b/reftable/reader.c
index c7f56b5fdc..8d3f63b0d8 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -161,8 +161,8 @@ static int parse_footer(struct reftable_reader *r, uint8_t *footer,
 int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
 		const char *name)
 {
-	struct reftable_block footer = { 0 };
-	struct reftable_block header = { 0 };
+	struct reftable_block footer = { NULL };
+	struct reftable_block header = { NULL };
 	int err = 0;
 
 	memset(r, 0, sizeof(struct reftable_reader));
@@ -270,7 +270,7 @@ int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
 {
 	int32_t guess_block_size = r->block_size ? r->block_size :
 							 DEFAULT_BLOCK_SIZE;
-	struct reftable_block block = { 0 };
+	struct reftable_block block = { NULL };
 	uint8_t block_typ = 0;
 	int err = 0;
 	uint32_t header_off = next_off ? 0 : header_size(r->version);
@@ -477,9 +477,9 @@ static int reader_seek_indexed(struct reftable_reader *r,
 			       struct reftable_record *rec)
 {
 	struct reftable_index_record want_index = { .last_key = STRBUF_INIT };
-	struct reftable_record want_index_rec = { 0 };
+	struct reftable_record want_index_rec = { NULL };
 	struct reftable_index_record index_result = { .last_key = STRBUF_INIT };
-	struct reftable_record index_result_rec = { 0 };
+	struct reftable_record index_result_rec = { NULL };
 	struct table_iter index_iter = TABLE_ITER_INIT;
 	struct table_iter next = TABLE_ITER_INIT;
 	int err = 0;
@@ -584,7 +584,7 @@ int reftable_reader_seek_ref(struct reftable_reader *r,
 	struct reftable_ref_record ref = {
 		.refname = (char *)name,
 	};
-	struct reftable_record rec = { 0 };
+	struct reftable_record rec = { NULL };
 	reftable_record_from_ref(&rec, &ref);
 	return reader_seek(r, it, &rec);
 }
@@ -597,7 +597,7 @@ int reftable_reader_seek_log_at(struct reftable_reader *r,
 		.refname = (char *)name,
 		.update_index = update_index,
 	};
-	struct reftable_record rec = { 0 };
+	struct reftable_record rec = { NULL };
 	reftable_record_from_log(&rec, &log);
 	return reader_seek(r, it, &rec);
 }
@@ -644,10 +644,10 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
 		.hash_prefix = oid,
 		.hash_prefix_len = r->object_id_len,
 	};
-	struct reftable_record want_rec = { 0 };
-	struct reftable_iterator oit = { 0 };
-	struct reftable_obj_record got = { 0 };
-	struct reftable_record got_rec = { 0 };
+	struct reftable_record want_rec = { NULL };
+	struct reftable_iterator oit = { NULL };
+	struct reftable_obj_record got = { NULL };
+	struct reftable_record got_rec = { NULL };
 	int err = 0;
 	struct indexed_table_ref_iter *itr = NULL;
 
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index def8883439..aff4fbccda 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -13,3 +13,8 @@ int cmd__reftable(int argc, const char **argv)
 	tree_test_main(argc, argv);
 	return 0;
 }
+
+int cmd__dump_reftable(int argc, const char **argv)
+{
+	return reftable_dump_main(argc, (char *const *)argv);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index c7ab5bc4a6..ce27041ab2 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -54,6 +54,7 @@ static struct test_cmd cmds[] = {
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
 	{ "reftable", cmd__reftable },
+	{ "dump-reftable", cmd__dump_reftable },
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index fa2b11ace6..8b5790d93f 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -17,6 +17,7 @@ int cmd__dump_cache_tree(int argc, const char **argv);
 int cmd__dump_fsmonitor(int argc, const char **argv);
 int cmd__dump_split_index(int argc, const char **argv);
 int cmd__dump_untracked_cache(int argc, const char **argv);
+int cmd__dump_reftable(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
-- 
gitgitgadget
