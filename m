Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD322C2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58AB720BED
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="LGn0tmou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgIVWzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:55:05 -0400
Received: from avasout04.plus.net ([212.159.14.19]:45137 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgIVWzF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:55:05 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 18:55:04 EDT
Received: from [10.0.2.15] ([147.147.167.35])
        by smtp with ESMTPA
        id Kr4OkIdpgrXCcKr4Pk6mi1; Tue, 22 Sep 2020 23:47:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1600814853; bh=Cq61n+mvz8pfnsVWQfx8dfkBzl9oDbvRSQpPAAr/QBY=;
        h=To:Cc:From:Subject:Date;
        b=LGn0tmouJ8S9hoXRPxF+RNxfRE1C1NnrLytwKxEtG6fAcCokIQ8JVmLfZbMU9u44z
         S7FjgSkPvwV8AHsvwGs7uq4gSGIEPP3ZYuaIF2vC5rlE9LrA6vlm7r51tUQNTrkrIY
         sJzx97XjEGcchKudBUjZ27CDpA6PKcmd7Ysw96sDaersmz/pnuZrSp8kL4m+de/vP0
         sshaAygz58r3uMnEPPn5LeRXywyyImOG46UTyTlbp12ltlCjBeh6i6FF4qAhejufAm
         REba598EePBSJ27dQ/UcJsuYl+qPM+u75CvRh/wjUNBDo1UTEgdyqe1It4mBpLMytP
         iGSUNvk14TbWA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Q+xJH7+a c=1 sm=1 tr=0
 a=XpjFJPif6dwr03fZd+AQaQ==:117 a=XpjFJPif6dwr03fZd+AQaQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=yWYgLYp-HxzJ46leDaQA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     hanwen@google.com
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] reftable: fix some sparse warnings
Message-ID: <eaf4629b-d8c4-0ddc-8c85-6600399a8229@ramsayjones.plus.com>
Date:   Tue, 22 Sep 2020 23:47:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfF3WchJ0hZ7lgc4WBitTQefT8AH1vixsNePza9hOqipwkDC5J2haQSBmVfPLLLetFv8+InpuzSPi/ze93ObmVN6xhBkRkU+wFM1lNS0jHaPL9asACK1o
 uuSKxSeQQvTElxQvw84yi93fR8Vm8z+O1OCXp2owLRbiB1shFsX37TJ7919Hd3C3WcgS5P4YxRTg1g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Han-Wen Nienhuys,

If you need to re-roll your 'hn/reftable' branch, could you please squash this
into the relevant patches.

This patch is based on top of 'seen' and removes 20 sparse warnings (19 of the
"symbol 'whatever' was not declared. Should it be static?" type and a single
"Using plain integer as NULL pointer").

However, this branch also adds many symbols to the output of my 'static-check.pl'
script (this patch actually removes 19 of those symbols :) ).

Looking at the first such symbol:

  $ git grep -n block_writer_register_restart
  reftable/block.c:40:int block_writer_register_restart(struct block_writer *w, int n, int restart,
  reftable/block.c:93:    if (block_writer_register_restart(w, start.len - out.len, is_restart,
  reftable/block.c:105:int block_writer_register_restart(struct block_writer *w, int n, int is_restart,
  $ 

... it looks like you forward declare the function on line 40, use it in line 93
and define it in line 105, all in the single 'block.c' source file. This would
suggest that this symbol is local to this file and should be marked as 'static'.
(Also, unless you have mutually recursive functions, I would avoid the need to
forward declare this function).

Just for your information, you may want to look at the following 27 symbols:

  $ diff nsc ssc1
  ...
  > reftable/block.o	- block_writer_register_restart
  > reftable/merged.o	- merged_table_seek_record
  > reftable/merged.o	- reftable_merged_table_hash_id
  > reftable/merged.o	- reftable_merged_table_max_update_index
  > reftable/merged.o	- reftable_merged_table_min_update_index
  > reftable/merged.o	- reftable_merged_table_seek_log_at
  > reftable/pq.o	- pq_less
  > reftable/publicbasics.o	- reftable_error_to_errno
  > reftable/publicbasics.o	- reftable_set_alloc
  > reftable/reader.o	- reftable_reader_seek_log_at
  > reftable/record.o	- reftable_record_yield
  > reftable/record.o	- reftable_ref_record_vtable
  > reftable/refname.o	- modification_has_ref
  > reftable/refname.o	- modification_has_ref_with_prefix
  > reftable/refname.o	- validate_refname
  > reftable/stack.o	- reftable_addition_close
  > reftable/stack.o	- reftable_stack_auto_compact
  > reftable/stack.o	- reftable_stack_reload_maybe_reuse
  > reftable/stack.o	- stack_check_addition
  > reftable/stack.o	- stack_try_add
  > reftable/stack.o	- stack_write_compact
  > reftable/test_framework.o	- new_test_case
  > reftable/writer.o	- reftable_writer_add_logs
  > reftable/writer.o	- reftable_writer_add_refs
  > reftable/writer.o	- writer_clear_index
  > reftable/writer.o	- writer_finish_public_section
  > reftable/writer.o	- writer_flush_block
  ...
  $ 

To be clear, all of the above symbols are defined, as an external symbol, in
the given object file, but not called/referenced outside of that file.

Thanks!

ATB,
Ramsay Jones


 reftable/blocksource.c    | 8 ++++----
 reftable/iter.c           | 6 +++---
 reftable/merged.c         | 2 +-
 reftable/publicbasics.c   | 6 +++---
 reftable/reader.c         | 2 +-
 reftable/record.c         | 6 +++---
 reftable/test_framework.c | 8 ++++----
 reftable/writer.c         | 2 +-
 8 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index f12cea2472..7f29b864f9 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -39,7 +39,7 @@ static uint64_t strbuf_size(void *b)
 	return ((struct strbuf *)b)->len;
 }
 
-struct reftable_block_source_vtable strbuf_vtable = {
+static struct reftable_block_source_vtable strbuf_vtable = {
 	.size = &strbuf_size,
 	.read_block = &strbuf_read_block,
 	.return_block = &strbuf_return_block,
@@ -60,11 +60,11 @@ static void malloc_return_block(void *b, struct reftable_block *dest)
 	reftable_free(dest->data);
 }
 
-struct reftable_block_source_vtable malloc_vtable = {
+static struct reftable_block_source_vtable malloc_vtable = {
 	.return_block = &malloc_return_block,
 };
 
-struct reftable_block_source malloc_block_source_instance = {
+static struct reftable_block_source malloc_block_source_instance = {
 	.ops = &malloc_vtable,
 };
 
@@ -112,7 +112,7 @@ static int file_read_block(void *v, struct reftable_block *dest, uint64_t off,
 	return size;
 }
 
-struct reftable_block_source_vtable file_vtable = {
+static struct reftable_block_source_vtable file_vtable = {
 	.size = &file_size,
 	.read_block = &file_read_block,
 	.return_block = &file_return_block,
diff --git a/reftable/iter.c b/reftable/iter.c
index 6631408ef8..2cff447323 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -29,7 +29,7 @@ static void empty_iterator_close(void *arg)
 {
 }
 
-struct reftable_iterator_vtable empty_vtable = {
+static struct reftable_iterator_vtable empty_vtable = {
 	.next = &empty_iterator_next,
 	.close = &empty_iterator_close,
 };
@@ -126,7 +126,7 @@ static int filtering_ref_iterator_next(void *iter_arg,
 	return err;
 }
 
-struct reftable_iterator_vtable filtering_ref_iterator_vtable = {
+static struct reftable_iterator_vtable filtering_ref_iterator_vtable = {
 	.next = &filtering_ref_iterator_next,
 	.close = &filtering_ref_iterator_close,
 };
@@ -228,7 +228,7 @@ int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
 	return err;
 }
 
-struct reftable_iterator_vtable indexed_table_ref_iter_vtable = {
+static struct reftable_iterator_vtable indexed_table_ref_iter_vtable = {
 	.next = &indexed_table_ref_iter_next,
 	.close = &indexed_table_ref_iter_close,
 };
diff --git a/reftable/merged.c b/reftable/merged.c
index 22b071cb5d..63fa69bc27 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -155,7 +155,7 @@ static int merged_iter_next_void(void *p, struct reftable_record *rec)
 	return merged_iter_next(mi, rec);
 }
 
-struct reftable_iterator_vtable merged_iter_vtable = {
+static struct reftable_iterator_vtable merged_iter_vtable = {
 	.next = &merged_iter_next_void,
 	.close = &merged_iter_close,
 };
diff --git a/reftable/publicbasics.c b/reftable/publicbasics.c
index a31463ff9a..12d547d70d 100644
--- a/reftable/publicbasics.c
+++ b/reftable/publicbasics.c
@@ -59,9 +59,9 @@ int reftable_error_to_errno(int err)
 	}
 }
 
-void *(*reftable_malloc_ptr)(size_t sz) = &malloc;
-void *(*reftable_realloc_ptr)(void *, size_t) = &realloc;
-void (*reftable_free_ptr)(void *) = &free;
+static void *(*reftable_malloc_ptr)(size_t sz) = &malloc;
+static void *(*reftable_realloc_ptr)(void *, size_t) = &realloc;
+static void (*reftable_free_ptr)(void *) = &free;
 
 void *reftable_malloc(size_t sz)
 {
diff --git a/reftable/reader.c b/reftable/reader.c
index fae2dbb64e..c7f56b5fdc 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -376,7 +376,7 @@ static void table_iter_close(void *p)
 	block_iter_close(&ti->bi);
 }
 
-struct reftable_iterator_vtable table_iter_vtable = {
+static struct reftable_iterator_vtable table_iter_vtable = {
 	.next = &table_iter_next_void,
 	.close = &table_iter_close,
 };
diff --git a/reftable/record.c b/reftable/record.c
index 21c9bba077..3b6884131b 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -539,7 +539,7 @@ static int not_a_deletion(const void *p)
 	return 0;
 }
 
-struct reftable_record_vtable reftable_obj_record_vtable = {
+static struct reftable_record_vtable reftable_obj_record_vtable = {
 	.key = &reftable_obj_record_key,
 	.type = BLOCK_TYPE_OBJ,
 	.copy_from = &reftable_obj_record_copy_from,
@@ -821,7 +821,7 @@ static int reftable_log_record_is_deletion_void(const void *p)
 		(const struct reftable_log_record *)p);
 }
 
-struct reftable_record_vtable reftable_log_record_vtable = {
+static struct reftable_record_vtable reftable_log_record_vtable = {
 	.key = &reftable_log_record_key,
 	.type = BLOCK_TYPE_LOG,
 	.copy_from = &reftable_log_record_copy_from,
@@ -947,7 +947,7 @@ static int reftable_index_record_decode(void *rec, struct strbuf key,
 	return start.len - in.len;
 }
 
-struct reftable_record_vtable reftable_index_record_vtable = {
+static struct reftable_record_vtable reftable_index_record_vtable = {
 	.key = &reftable_index_record_key,
 	.type = BLOCK_TYPE_INDEX,
 	.copy_from = &reftable_index_record_copy_from,
diff --git a/reftable/test_framework.c b/reftable/test_framework.c
index f304a2773a..b5870bea08 100644
--- a/reftable/test_framework.c
+++ b/reftable/test_framework.c
@@ -11,9 +11,9 @@ license that can be found in the LICENSE file or at
 #include "system.h"
 #include "basics.h"
 
-struct test_case **test_cases;
-int test_case_len;
-int test_case_cap;
+static struct test_case **test_cases;
+static int test_case_len;
+static int test_case_cap;
 
 struct test_case *new_test_case(const char *name, void (*testfunc)(void))
 {
@@ -56,7 +56,7 @@ int test_main(int argc, const char *argv[])
 		reftable_free(test_cases[i]);
 	}
 	reftable_free(test_cases);
-	test_cases = 0;
+	test_cases = NULL;
 	test_case_len = 0;
 	test_case_cap = 0;
 	return 0;
diff --git a/reftable/writer.c b/reftable/writer.c
index 44ddcc6757..f569d15ff0 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -589,7 +589,7 @@ void writer_clear_index(struct reftable_writer *w)
 	w->index_cap = 0;
 }
 
-const int debug = 0;
+static const int debug;
 
 static int writer_flush_nonempty_block(struct reftable_writer *w)
 {
-- 
2.28.0
