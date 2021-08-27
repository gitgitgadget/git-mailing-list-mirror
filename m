Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431CCC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 05:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1127D60560
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 05:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244270AbhH0Fe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 01:34:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62115 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244264AbhH0Fe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 01:34:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1957CD87F9;
        Fri, 27 Aug 2021 01:33:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QVxtTJ/e0ACN1llZeims8lguPmHo0zdtsgYWNI
        gi4X4=; b=OSgAeISF8bSFK2wHCa/tySt1QKrr1oRGqUxMM22BxPTRWPuSeub1Ms
        Qv8PNZIY3iQsFXAtrD29pmKFb67FJDB89rfdZgZlf45vZgDB4Pd4HlJIe0mZhYIf
        p39tEwi0ATVagpAUpRBFBDQG1ZUg/6CIDVaQ4eAB47h/6dD0AfZdQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10A8AD87F8;
        Fri, 27 Aug 2021 01:33:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 872AAD87F7;
        Fri, 27 Aug 2021 01:33:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 18/28] reftable: implement stack, a mutable database
 of reftable files.
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
        <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
        <patch-v4-18.28-374c22efbd9-20210823T120208Z-avarab@gmail.com>
Date:   Thu, 26 Aug 2021 22:33:35 -0700
In-Reply-To: <patch-v4-18.28-374c22efbd9-20210823T120208Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 23 Aug
 2021 14:12:29
        +0200")
Message-ID: <xmqqwno7bgeo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5397597E-06F8-11EC-A877-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This step does not compile under -pedantic because it assumes that
__FUNCTION__ is available unconditionally (unlike trace.h where it
allows __FUNCTION__ to be used iff compiler supports it).

Here is a workaround that needs to be split and squashed into the
steps that introduce these test source files.

Subject: [PATCH] SQUASH???
 https://github.com/git/git/runs/3439941236?check_suite_focus=true#step:5:700

---
 reftable/basics_test.c    | 10 ++---
 reftable/block_test.c     |  2 +-
 reftable/merged_test.c    |  6 +--
 reftable/pq_test.c        |  2 +-
 reftable/readwrite_test.c | 30 +++++++--------
 reftable/record_test.c    | 18 ++++-----
 reftable/refname_test.c   |  2 +-
 reftable/stack_test.c     | 80 +++++++++++++++++++--------------------
 reftable/test_framework.h |  2 +-
 reftable/tree_test.c      |  2 +-
 10 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/reftable/basics_test.c b/reftable/basics_test.c
index 1fcd229725..ac1aed8a76 100644
--- a/reftable/basics_test.c
+++ b/reftable/basics_test.c
@@ -24,7 +24,7 @@ static int binsearch_func(size_t i, void *void_args)
 	return args->key < args->arr[i];
 }
 
-static void test_binsearch(void)
+static void test_binsearch(const char *fn_name)
 {
 	int arr[] = { 2, 4, 6, 8, 10 };
 	size_t sz = ARRAY_SIZE(arr);
@@ -49,13 +49,13 @@ static void test_binsearch(void)
 	}
 }
 
-static void test_names_length(void)
+static void test_names_length(const char *fn_name)
 {
 	char *a[] = { "a", "b", NULL };
 	EXPECT(names_length(a) == 2);
 }
 
-static void test_parse_names_normal(void)
+static void test_parse_names_normal(const char *fn_name)
 {
 	char in[] = "a\nb\n";
 	char **out = NULL;
@@ -66,7 +66,7 @@ static void test_parse_names_normal(void)
 	free_names(out);
 }
 
-static void test_parse_names_drop_empty(void)
+static void test_parse_names_drop_empty(const char *fn_name)
 {
 	char in[] = "a\n\n";
 	char **out = NULL;
@@ -76,7 +76,7 @@ static void test_parse_names_drop_empty(void)
 	free_names(out);
 }
 
-static void test_common_prefix(void)
+static void test_common_prefix(const char *fn_name)
 {
 	struct strbuf s1 = STRBUF_INIT;
 	struct strbuf s2 = STRBUF_INIT;
diff --git a/reftable/block_test.c b/reftable/block_test.c
index 4b3ea262dc..8e21189f8d 100644
--- a/reftable/block_test.c
+++ b/reftable/block_test.c
@@ -16,7 +16,7 @@ license that can be found in the LICENSE file or at
 #include "test_framework.h"
 #include "reftable-tests.h"
 
-static void test_block_read_write(void)
+static void test_block_read_write(const char *fn_name)
 {
 	const int header_off = 21; /* random */
 	char *names[30];
diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index 1e2afe37b8..f58e44003e 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -95,7 +95,7 @@ static void readers_destroy(struct reftable_reader **readers, size_t n)
 	reftable_free(readers);
 }
 
-static void test_merged_between(void)
+static void test_merged_between(const char *fn_name)
 {
 	uint8_t hash1[GIT_SHA1_RAWSZ] = { 1, 2, 3, 0 };
 
@@ -137,7 +137,7 @@ static void test_merged_between(void)
 	reftable_free(bs);
 }
 
-static void test_merged(void)
+static void test_merged(const char *fn_name)
 {
 	uint8_t hash1[GIT_SHA1_RAWSZ] = { 1 };
 	uint8_t hash2[GIT_SHA1_RAWSZ] = { 2 };
@@ -237,7 +237,7 @@ static void test_merged(void)
 	reftable_free(bs);
 }
 
-static void test_default_write_opts(void)
+static void test_default_write_opts(const char *fn_name)
 {
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
diff --git a/reftable/pq_test.c b/reftable/pq_test.c
index ad21673e85..3537def65c 100644
--- a/reftable/pq_test.c
+++ b/reftable/pq_test.c
@@ -15,7 +15,7 @@ license that can be found in the LICENSE file or at
 #include "reftable-tests.h"
 #include "test_framework.h"
 
-static void test_pq(void)
+static void test_pq(const char *fn_name)
 {
 	char *names[54] = { NULL };
 	int N = ARRAY_SIZE(names) - 1;
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 5f6bcc2f77..5534f7fb67 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -20,7 +20,7 @@ license that can be found in the LICENSE file or at
 
 static const int update_index = 5;
 
-static void test_buffer(void)
+static void test_buffer(const char *fn_name)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_block_source source = { NULL };
@@ -114,7 +114,7 @@ static void write_table(char ***names, struct strbuf *buf, int N,
 	reftable_writer_free(w);
 }
 
-static void test_log_buffer_size(void)
+static void test_log_buffer_size(const char *fn_name)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_write_options opts = {
@@ -155,7 +155,7 @@ static void test_log_buffer_size(void)
 	strbuf_release(&buf);
 }
 
-static void test_log_write_read(void)
+static void test_log_write_read(const char *fn_name)
 {
 	int N = 2;
 	char **names = reftable_calloc(sizeof(char *) * (N + 1));
@@ -254,7 +254,7 @@ static void test_log_write_read(void)
 	reader_close(&rd);
 }
 
-static void test_table_read_write_sequential(void)
+static void test_table_read_write_sequential(const char *fn_name)
 {
 	char **names;
 	struct strbuf buf = STRBUF_INIT;
@@ -296,7 +296,7 @@ static void test_table_read_write_sequential(void)
 	reader_close(&rd);
 }
 
-static void test_table_write_small_table(void)
+static void test_table_write_small_table(const char *fn_name)
 {
 	char **names;
 	struct strbuf buf = STRBUF_INIT;
@@ -307,7 +307,7 @@ static void test_table_write_small_table(void)
 	free_names(names);
 }
 
-static void test_table_read_api(void)
+static void test_table_read_api(const char *fn_name)
 {
 	char **names;
 	struct strbuf buf = STRBUF_INIT;
@@ -406,17 +406,17 @@ static void test_table_read_write_seek(int index, int hash_id)
 	reader_close(&rd);
 }
 
-static void test_table_read_write_seek_linear(void)
+static void test_table_read_write_seek_linear(const char *fn_name)
 {
 	test_table_read_write_seek(0, GIT_SHA1_FORMAT_ID);
 }
 
-static void test_table_read_write_seek_linear_sha256(void)
+static void test_table_read_write_seek_linear_sha256(const char *fn_name)
 {
 	test_table_read_write_seek(0, GIT_SHA256_FORMAT_ID);
 }
 
-static void test_table_read_write_seek_index(void)
+static void test_table_read_write_seek_index(const char *fn_name)
 {
 	test_table_read_write_seek(1, GIT_SHA1_FORMAT_ID);
 }
@@ -522,17 +522,17 @@ static void test_table_refs_for(int indexed)
 	reader_close(&rd);
 }
 
-static void test_table_refs_for_no_index(void)
+static void test_table_refs_for_no_index(const char *fn_name)
 {
 	test_table_refs_for(0);
 }
 
-static void test_table_refs_for_obj_index(void)
+static void test_table_refs_for_obj_index(const char *fn_name)
 {
 	test_table_refs_for(1);
 }
 
-static void test_write_empty_table(void)
+static void test_write_empty_table(const char *fn_name)
 {
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
@@ -568,7 +568,7 @@ static void test_write_empty_table(void)
 	strbuf_release(&buf);
 }
 
-static void test_write_key_order(void)
+static void test_write_key_order(const char *fn_name)
 {
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
@@ -604,7 +604,7 @@ static void test_write_key_order(void)
 	strbuf_release(&buf);
 }
 
-static void test_corrupt_table_empty(void)
+static void test_corrupt_table_empty(const char *fn_name)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_block_source source = { NULL };
@@ -616,7 +616,7 @@ static void test_corrupt_table_empty(void)
 	EXPECT(err == REFTABLE_FORMAT_ERROR);
 }
 
-static void test_corrupt_table(void)
+static void test_corrupt_table(const char *fn_name)
 {
 	uint8_t zeros[1024] = { 0 };
 	struct strbuf buf = STRBUF_INIT;
diff --git a/reftable/record_test.c b/reftable/record_test.c
index f4ad7cace4..f88a72b154 100644
--- a/reftable/record_test.c
+++ b/reftable/record_test.c
@@ -36,7 +36,7 @@ static void test_copy(struct reftable_record *rec)
 	reftable_record_destroy(&copy);
 }
 
-static void test_varint_roundtrip(void)
+static void test_varint_roundtrip(const char *fn_name)
 {
 	uint64_t inputs[] = { 0,
 			      1,
@@ -68,7 +68,7 @@ static void test_varint_roundtrip(void)
 	}
 }
 
-static void test_common_prefix(void)
+static void test_common_prefix(const char *fn_name)
 {
 	struct {
 		const char *a, *b;
@@ -101,7 +101,7 @@ static void set_hash(uint8_t *h, int j)
 	}
 }
 
-static void test_reftable_ref_record_roundtrip(void)
+static void test_reftable_ref_record_roundtrip(const char *fn_name)
 {
 	int i = 0;
 
@@ -164,7 +164,7 @@ static void test_reftable_ref_record_roundtrip(void)
 	}
 }
 
-static void test_reftable_log_record_equal(void)
+static void test_reftable_log_record_equal(const char *fn_name)
 {
 	struct reftable_log_record in[2] = {
 		{
@@ -184,7 +184,7 @@ static void test_reftable_log_record_equal(void)
 	reftable_log_record_release(&in[1]);
 }
 
-static void test_reftable_log_record_roundtrip(void)
+static void test_reftable_log_record_roundtrip(const char *fn_name)
 {
 	int i;
 	struct reftable_log_record in[2] = {
@@ -258,7 +258,7 @@ static void test_reftable_log_record_roundtrip(void)
 	}
 }
 
-static void test_u24_roundtrip(void)
+static void test_u24_roundtrip(const char *fn_name)
 {
 	uint32_t in = 0x112233;
 	uint8_t dest[3];
@@ -268,7 +268,7 @@ static void test_u24_roundtrip(void)
 	EXPECT(in == out);
 }
 
-static void test_key_roundtrip(void)
+static void test_key_roundtrip(const char *fn_name)
 {
 	uint8_t buffer[1024] = { 0 };
 	struct string_view dest = {
@@ -300,7 +300,7 @@ static void test_key_roundtrip(void)
 	strbuf_release(&roundtrip);
 }
 
-static void test_reftable_obj_record_roundtrip(void)
+static void test_reftable_obj_record_roundtrip(const char *fn_name)
 {
 	uint8_t testHash1[GIT_SHA1_RAWSZ] = { 1, 2, 3, 4, 0 };
 	uint64_t till9[] = { 1, 2, 3, 4, 500, 600, 700, 800, 9000 };
@@ -358,7 +358,7 @@ static void test_reftable_obj_record_roundtrip(void)
 	}
 }
 
-static void test_reftable_index_record_roundtrip(void)
+static void test_reftable_index_record_roundtrip(const char *fn_name)
 {
 	struct reftable_index_record in = {
 		.offset = 42,
diff --git a/reftable/refname_test.c b/reftable/refname_test.c
index 8645cd93bb..81772179f9 100644
--- a/reftable/refname_test.c
+++ b/reftable/refname_test.c
@@ -26,7 +26,7 @@ struct testcase {
 	int error_code;
 };
 
-static void test_conflict(void)
+static void test_conflict(const char *fn_name)
 {
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 890a5c0199..c90b3a4bd9 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -62,9 +62,9 @@ static char *get_tmp_dir(const char *prefix)
 	return dir;
 }
 
-static void test_read_file(void)
+static void test_read_file(const char *fn_name)
 {
-	char *fn = get_tmp_template(__FUNCTION__);
+	char *fn = get_tmp_template(fn_name);
 	int fd = mkstemp(fn);
 	char out[1024] = "line1\n\nline2\nline3";
 	int n, err;
@@ -88,7 +88,7 @@ static void test_read_file(void)
 	remove(fn);
 }
 
-static void test_parse_names(void)
+static void test_parse_names(const char *fn_name)
 {
 	char buf[] = "line\n";
 	char **names = NULL;
@@ -100,7 +100,7 @@ static void test_parse_names(void)
 	free_names(names);
 }
 
-static void test_names_equal(void)
+static void test_names_equal(const char *fn_name)
 {
 	char *a[] = { "a", "b", "c", NULL };
 	char *b[] = { "a", "b", "d", NULL };
@@ -131,9 +131,9 @@ static int write_test_log(struct reftable_writer *wr, void *arg)
 	return reftable_writer_add_log(wr, wla->log);
 }
 
-static void test_reftable_stack_add_one(void)
+static void test_reftable_stack_add_one(const char *fn_name)
 {
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(fn_name);
 
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
@@ -169,12 +169,12 @@ static void test_reftable_stack_add_one(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_uptodate(void)
+static void test_reftable_stack_uptodate(const char *fn_name)
 {
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st1 = NULL;
 	struct reftable_stack *st2 = NULL;
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(fn_name);
 
 	int err;
 	struct reftable_ref_record ref1 = {
@@ -216,9 +216,9 @@ static void test_reftable_stack_uptodate(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_transaction_api(void)
+static void test_reftable_stack_transaction_api(const char *fn_name)
 {
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(fn_name);
 
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
@@ -260,12 +260,12 @@ static void test_reftable_stack_transaction_api(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_validate_refname(void)
+static void test_reftable_stack_validate_refname(const char *fn_name)
 {
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
 	int err;
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(fn_name);
 
 	int i;
 	struct reftable_ref_record ref = {
@@ -303,9 +303,9 @@ static int write_error(struct reftable_writer *wr, void *arg)
 	return *((int *)arg);
 }
 
-static void test_reftable_stack_update_index_check(void)
+static void test_reftable_stack_update_index_check(const char *fn_name)
 {
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(fn_name);
 
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
@@ -335,9 +335,9 @@ static void test_reftable_stack_update_index_check(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_lock_failure(void)
+static void test_reftable_stack_lock_failure(const char *fn_name)
 {
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(fn_name);
 
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
@@ -354,7 +354,7 @@ static void test_reftable_stack_lock_failure(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_add(void)
+static void test_reftable_stack_add(const char *fn_name)
 {
 	int i = 0;
 	int err = 0;
@@ -362,7 +362,7 @@ static void test_reftable_stack_add(void)
 		.exact_log_message = 1,
 	};
 	struct reftable_stack *st = NULL;
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(fn_name);
 
 	struct reftable_ref_record refs[2] = { { NULL } };
 	struct reftable_log_record logs[2] = { { NULL } };
@@ -436,14 +436,14 @@ static void test_reftable_stack_add(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_log_normalize(void)
+static void test_reftable_stack_log_normalize(const char *fn_name)
 {
 	int err = 0;
 	struct reftable_write_options cfg = {
 		0,
 	};
 	struct reftable_stack *st = NULL;
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(fn_name);
 
 
 	uint8_t h1[GIT_SHA1_RAWSZ] = { 0x01 }, h2[GIT_SHA1_RAWSZ] = { 0x02 };
@@ -492,10 +492,10 @@ static void test_reftable_stack_log_normalize(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_tombstone(void)
+static void test_reftable_stack_tombstone(const char *fn_name)
 {
 	int i = 0;
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(fn_name);
 
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
@@ -575,9 +575,9 @@ static void test_reftable_stack_tombstone(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_hash_id(void)
+static void test_reftable_stack_hash_id(const char *fn_name)
 {
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(fn_name);
 
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
@@ -619,14 +619,14 @@ static void test_reftable_stack_hash_id(void)
 	clear_dir(dir);
 }
 
-static void test_log2(void)
+static void test_log2(const char *fn_name)
 {
 	EXPECT(1 == fastlog2(3));
 	EXPECT(2 == fastlog2(4));
 	EXPECT(2 == fastlog2(5));
 }
 
-static void test_sizes_to_segments(void)
+static void test_sizes_to_segments(const char *fn_name)
 {
 	uint64_t sizes[] = { 2, 3, 4, 5, 7, 9 };
 	/* .................0  1  2  3  4  5 */
@@ -644,7 +644,7 @@ static void test_sizes_to_segments(void)
 	reftable_free(segs);
 }
 
-static void test_sizes_to_segments_empty(void)
+static void test_sizes_to_segments_empty(const char *fn_name)
 {
 	int seglen = 0;
 	struct segment *segs = sizes_to_segments(&seglen, NULL, 0);
@@ -652,7 +652,7 @@ static void test_sizes_to_segments_empty(void)
 	reftable_free(segs);
 }
 
-static void test_sizes_to_segments_all_equal(void)
+static void test_sizes_to_segments_all_equal(const char *fn_name)
 {
 	uint64_t sizes[] = { 5, 5 };
 
@@ -665,7 +665,7 @@ static void test_sizes_to_segments_all_equal(void)
 	reftable_free(segs);
 }
 
-static void test_suggest_compaction_segment(void)
+static void test_suggest_compaction_segment(const char *fn_name)
 {
 	uint64_t sizes[] = { 128, 64, 17, 16, 9, 9, 9, 16, 16 };
 	/* .................0    1    2  3   4  5  6 */
@@ -675,7 +675,7 @@ static void test_suggest_compaction_segment(void)
 	EXPECT(min.end == 7);
 }
 
-static void test_suggest_compaction_segment_nothing(void)
+static void test_suggest_compaction_segment_nothing(const char *fn_name)
 {
 	uint64_t sizes[] = { 64, 32, 16, 8, 4, 2 };
 	struct segment result =
@@ -683,9 +683,9 @@ static void test_suggest_compaction_segment_nothing(void)
 	EXPECT(result.start == result.end);
 }
 
-static void test_reflog_expire(void)
+static void test_reflog_expire(const char *fn_name)
 {
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(fn_name);
 
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
@@ -761,12 +761,12 @@ static int write_nothing(struct reftable_writer *wr, void *arg)
 	return 0;
 }
 
-static void test_empty_add(void)
+static void test_empty_add(const char *fn_name)
 {
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
 	int err;
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(fn_name);
 
 	struct reftable_stack *st2 = NULL;
 
@@ -784,11 +784,11 @@ static void test_empty_add(void)
 	reftable_stack_destroy(st2);
 }
 
-static void test_reftable_stack_auto_compaction(void)
+static void test_reftable_stack_auto_compaction(const char *fn_name)
 {
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(fn_name);
 
 	int err, i;
 	int N = 100;
@@ -819,11 +819,11 @@ static void test_reftable_stack_auto_compaction(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_compaction_concurrent(void)
+static void test_reftable_stack_compaction_concurrent(const char *fn_name)
 {
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL;
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(fn_name);
 
 	int err, i;
 	int N = 3;
@@ -869,11 +869,11 @@ static void unclean_stack_close(struct reftable_stack *st)
 	FREE_AND_NULL(st->readers);
 }
 
-static void test_reftable_stack_compaction_concurrent_clean(void)
+static void test_reftable_stack_compaction_concurrent_clean(const char *fn_name)
 {
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL, *st3 = NULL;
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(fn_name);
 
 	int err, i;
 	int N = 3;
diff --git a/reftable/test_framework.h b/reftable/test_framework.h
index 774cb275bf..4a40a8780a 100644
--- a/reftable/test_framework.h
+++ b/reftable/test_framework.h
@@ -42,7 +42,7 @@ license that can be found in the LICENSE file or at
 #define RUN_TEST(f)                          \
 	fprintf(stderr, "running %s\n", #f); \
 	fflush(stderr);                      \
-	f();
+	f(#f);
 
 void set_test_hash(uint8_t *p, int i);
 
diff --git a/reftable/tree_test.c b/reftable/tree_test.c
index 09a970e17b..4883f0de65 100644
--- a/reftable/tree_test.c
+++ b/reftable/tree_test.c
@@ -31,7 +31,7 @@ static void check_increasing(void *arg, void *key)
 	c->last = key;
 }
 
-static void test_tree(void)
+static void test_tree(const char *fn_name)
 {
 	struct tree_node *root = NULL;
 
-- 
2.33.0-205-g1b5b9d966b

