Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A235C43460
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 16:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6136461154
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 16:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhDHQRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbhDHQRb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 12:17:31 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A7EC061761
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 09:17:17 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id i9so979426qvo.3
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yxhb2LdOI4S6bbnYJRma3s2wxKcNQQ206Mt45aoJ3fk=;
        b=rRWLGWLLr4FrIVDej/yRvee66+XdLmwHz1KM90yF0JTwcHC6nZf56R0McDfKwb3evV
         uGy9uENkB1qMr7HoKKiwRPclcpcautKz/xzh8GBQuN0G80te243pqhew81UVpj/9qmQ4
         jjyTFpaToX7cM82rqaSVFyT+qSQJgUWgMUJRXAhJ6e/AeTGuK9g7NS1/OSThctCIOZAP
         03QeN0Q5OoQTpCwwYZzxtRvAX+P3A5VbjtKr/3+5s/jtd7k93/BmRoXrOC3MkwfMHhq0
         ITd7+mVFLZTxSD+82kt4Y92w7kYiXtDTcAQ6dXyU5IXADOgbxOgS+X4joTkvZ+QJpycR
         X55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yxhb2LdOI4S6bbnYJRma3s2wxKcNQQ206Mt45aoJ3fk=;
        b=FDnF3e/5Yw8wDoJfWEJlFnY1C+RanHmXkfNXfx9eMOhSHby6IaDECnrP9TLgayXj+F
         qR4h+DOc1N66P0lfRF4IxVYa/qq6MxhhKZD6i++sI2guOi1ZysAT9TJEhIjCiLDmD2K5
         Z77T5LsMRgnjHSXhjfpOS9RBsO0gzJjmpVWUolpTzug0xpaz31lQTsvjjNIiNMEPP++l
         /K5Q3LCelHKG3+e5/o62i8OwtBqIgfZlQhZPMVH7+KTUue7ZyM7saGndIxEWj1eJOEDC
         CiCOuck6CdKLUVrjKDs+2XLPtGCdArcWtzpd/o1OVMksQM/acBz3xip8O8IgB1wg3lBZ
         68SQ==
X-Gm-Message-State: AOAM532LLvjWcwBalp8fVgswR3zmsm24GToCb+Yf4riEWep8jma0HvI+
        lKm36DZEIJmT1T+1DAkn/CKUlnEZjOWd/A==
X-Google-Smtp-Source: ABdhPJwbAXfpChjr7aNi1GPFoeLTuhotmESNCK7mUB47XrJQndEkUCX0XyvBOURnJFdRuE6Qv0QRYA==
X-Received: by 2002:ad4:5bc2:: with SMTP id t2mr9680428qvt.9.1617898636151;
        Thu, 08 Apr 2021 09:17:16 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id d18sm18087369qtd.85.2021.04.08.09.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 09:17:15 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com
Subject: [PATCH v2 2/5] parallel-checkout: make it truly parallel
Date:   Thu,  8 Apr 2021 13:17:01 -0300
Message-Id: <0d65b517bd3db5074b8ad6b51d25b6c488ff0774.1617893234.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1617893234.git.matheus.bernardino@usp.br>
References: <cover.1617893234.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use multiple worker processes to distribute the queued entries and call
write_pc_item() in parallel for them. The items are distributed
uniformly in contiguous chunks. This minimizes the chances of two
workers writing to the same directory simultaneously, which could affect
performance due to lock contention in the kernel. Work stealing (or any
other format of re-distribution) is not implemented yet.

The protocol between the main process and the workers is quite simple.
They exchange binary messages packed in pkt-line format, and use
PKT-FLUSH to mark the end of input (from both sides). The main process
starts the communication by sending N pkt-lines, each corresponding to
an item that needs to be written. These packets contain all the
necessary information to load, smudge, and write the blob associated
with each item. Then it waits for the worker to send back N pkt-lines
containing the results for each item. The resulting packet must contain:
the identification number of the item that it refers to, the status of
the operation, and the lstat() data gathered after writing the file (iff
the operation was successful).

For now, checkout always uses a hardcoded value of 2 workers, only to
demonstrate that the parallel checkout framework correctly divides and
writes the queued entries. The next patch will add user configurations
and define a more reasonable default, based on tests with the said
settings.

Co-authored-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 .gitignore                 |   1 +
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/checkout--worker.c | 145 ++++++++++++++++++
 git.c                      |   2 +
 parallel-checkout.c        | 300 +++++++++++++++++++++++++++++++++----
 parallel-checkout.h        |  73 ++++++++-
 7 files changed, 496 insertions(+), 27 deletions(-)
 create mode 100644 builtin/checkout--worker.c

diff --git a/.gitignore b/.gitignore
index 3dcdb6bb5a..96c794b1c7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -33,6 +33,7 @@
 /git-check-mailmap
 /git-check-ref-format
 /git-checkout
+/git-checkout--worker
 /git-checkout-index
 /git-cherry
 /git-cherry-pick
diff --git a/Makefile b/Makefile
index 99734cc2ea..84e15f58a0 100644
--- a/Makefile
+++ b/Makefile
@@ -1062,6 +1062,7 @@ BUILTIN_OBJS += builtin/check-attr.o
 BUILTIN_OBJS += builtin/check-ignore.o
 BUILTIN_OBJS += builtin/check-mailmap.o
 BUILTIN_OBJS += builtin/check-ref-format.o
+BUILTIN_OBJS += builtin/checkout--worker.o
 BUILTIN_OBJS += builtin/checkout-index.o
 BUILTIN_OBJS += builtin/checkout.o
 BUILTIN_OBJS += builtin/clean.o
diff --git a/builtin.h b/builtin.h
index b6ce981b73..16ecd5586f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -123,6 +123,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix);
 int cmd_bundle(int argc, const char **argv, const char *prefix);
 int cmd_cat_file(int argc, const char **argv, const char *prefix);
 int cmd_checkout(int argc, const char **argv, const char *prefix);
+int cmd_checkout__worker(int argc, const char **argv, const char *prefix);
 int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 int cmd_check_attr(int argc, const char **argv, const char *prefix);
 int cmd_check_ignore(int argc, const char **argv, const char *prefix);
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
new file mode 100644
index 0000000000..31e0de2f7e
--- /dev/null
+++ b/builtin/checkout--worker.c
@@ -0,0 +1,145 @@
+#include "builtin.h"
+#include "config.h"
+#include "entry.h"
+#include "parallel-checkout.h"
+#include "parse-options.h"
+#include "pkt-line.h"
+
+static void packet_to_pc_item(const char *buffer, int len,
+			      struct parallel_checkout_item *pc_item)
+{
+	const struct pc_item_fixed_portion *fixed_portion;
+	const char *variant;
+	char *encoding;
+
+	if (len < sizeof(struct pc_item_fixed_portion))
+		BUG("checkout worker received too short item (got %dB, exp %dB)",
+		    len, (int)sizeof(struct pc_item_fixed_portion));
+
+	fixed_portion = (struct pc_item_fixed_portion *)buffer;
+
+	if (len - sizeof(struct pc_item_fixed_portion) !=
+		fixed_portion->name_len + fixed_portion->working_tree_encoding_len)
+		BUG("checkout worker received corrupted item");
+
+	variant = buffer + sizeof(struct pc_item_fixed_portion);
+
+	/*
+	 * Note: the main process uses zero length to communicate that the
+	 * encoding is NULL. There is no use case that requires sending an
+	 * actual empty string, since convert_attrs() never sets
+	 * ca.working_tree_enconding to "".
+	 */
+	if (fixed_portion->working_tree_encoding_len) {
+		encoding = xmemdupz(variant,
+				    fixed_portion->working_tree_encoding_len);
+		variant += fixed_portion->working_tree_encoding_len;
+	} else {
+		encoding = NULL;
+	}
+
+	memset(pc_item, 0, sizeof(*pc_item));
+	pc_item->ce = make_empty_transient_cache_entry(fixed_portion->name_len);
+	pc_item->ce->ce_namelen = fixed_portion->name_len;
+	pc_item->ce->ce_mode = fixed_portion->ce_mode;
+	memcpy(pc_item->ce->name, variant, pc_item->ce->ce_namelen);
+	oidcpy(&pc_item->ce->oid, &fixed_portion->oid);
+
+	pc_item->id = fixed_portion->id;
+	pc_item->ca.crlf_action = fixed_portion->crlf_action;
+	pc_item->ca.ident = fixed_portion->ident;
+	pc_item->ca.working_tree_encoding = encoding;
+}
+
+static void report_result(struct parallel_checkout_item *pc_item)
+{
+	struct pc_item_result res;
+	size_t size;
+
+	res.id = pc_item->id;
+	res.status = pc_item->status;
+
+	if (pc_item->status == PC_ITEM_WRITTEN) {
+		res.st = pc_item->st;
+		size = sizeof(res);
+	} else {
+		size = PC_ITEM_RESULT_BASE_SIZE;
+	}
+
+	packet_write(1, (const char *)&res, size);
+}
+
+/* Free the worker-side malloced data, but not pc_item itself. */
+static void release_pc_item_data(struct parallel_checkout_item *pc_item)
+{
+	free((char *)pc_item->ca.working_tree_encoding);
+	discard_cache_entry(pc_item->ce);
+}
+
+static void worker_loop(struct checkout *state)
+{
+	struct parallel_checkout_item *items = NULL;
+	size_t i, nr = 0, alloc = 0;
+
+	while (1) {
+		int len = packet_read(0, NULL, NULL, packet_buffer,
+				      sizeof(packet_buffer), 0);
+
+		if (len < 0)
+			BUG("packet_read() returned negative value");
+		else if (!len)
+			break;
+
+		ALLOC_GROW(items, nr + 1, alloc);
+		packet_to_pc_item(packet_buffer, len, &items[nr++]);
+	}
+
+	for (i = 0; i < nr; i++) {
+		struct parallel_checkout_item *pc_item = &items[i];
+		write_pc_item(pc_item, state);
+		report_result(pc_item);
+		release_pc_item_data(pc_item);
+	}
+
+	packet_flush(1);
+
+	free(items);
+}
+
+static const char * const checkout_worker_usage[] = {
+	N_("git checkout--worker [<options>]"),
+	NULL
+};
+
+int cmd_checkout__worker(int argc, const char **argv, const char *prefix)
+{
+	struct checkout state = CHECKOUT_INIT;
+	struct option checkout_worker_options[] = {
+		OPT_STRING(0, "prefix", &state.base_dir, N_("string"),
+			N_("when creating files, prepend <string>")),
+		OPT_END()
+	};
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(checkout_worker_usage,
+				   checkout_worker_options);
+
+	git_config(git_default_config, NULL);
+	argc = parse_options(argc, argv, prefix, checkout_worker_options,
+			     checkout_worker_usage, 0);
+	if (argc > 0)
+		usage_with_options(checkout_worker_usage, checkout_worker_options);
+
+	if (state.base_dir)
+		state.base_dir_len = strlen(state.base_dir);
+
+	/*
+	 * Setting this on a worker won't actually update the index. We just
+	 * need to tell the checkout machinery to lstat() the written entries,
+	 * so that we can send this data back to the main process.
+	 */
+	state.refresh_cache = 1;
+
+	worker_loop(&state);
+	return 0;
+}
diff --git a/git.c b/git.c
index 9bc077a025..532b5b4136 100644
--- a/git.c
+++ b/git.c
@@ -490,6 +490,8 @@ static struct cmd_struct commands[] = {
 	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
 	{ "check-ref-format", cmd_check_ref_format, NO_PARSEOPT  },
 	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
+	{ "checkout--worker", cmd_checkout__worker,
+		RUN_SETUP | NEED_WORK_TREE | SUPPORT_SUPER_PREFIX },
 	{ "checkout-index", cmd_checkout_index,
 		RUN_SETUP | NEED_WORK_TREE},
 	{ "cherry", cmd_cherry, RUN_SETUP },
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 80c839837b..41c301bbda 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -1,28 +1,14 @@
 #include "cache.h"
 #include "entry.h"
 #include "parallel-checkout.h"
+#include "pkt-line.h"
+#include "run-command.h"
+#include "sigchain.h"
 #include "streaming.h"
 
-enum pc_item_status {
-	PC_ITEM_PENDING = 0,
-	PC_ITEM_WRITTEN,
-	/*
-	 * The entry could not be written because there was another file
-	 * already present in its path or leading directories. Since
-	 * checkout_entry_ca() removes such files from the working tree before
-	 * enqueueing the entry for parallel checkout, it means that there was
-	 * a path collision among the entries being written.
-	 */
-	PC_ITEM_COLLIDED,
-	PC_ITEM_FAILED,
-};
-
-struct parallel_checkout_item {
-	/* pointer to a istate->cache[] entry. Not owned by us. */
-	struct cache_entry *ce;
-	struct conv_attrs ca;
-	struct stat st;
-	enum pc_item_status status;
+struct pc_worker {
+	struct child_process cp;
+	size_t next_item_to_complete, nr_items_to_complete;
 };
 
 struct parallel_checkout {
@@ -59,6 +45,7 @@ static int is_eligible_for_parallel_checkout(const struct cache_entry *ce,
 					     const struct conv_attrs *ca)
 {
 	enum conv_attrs_classification c;
+	size_t packed_item_size;
 
 	/*
 	 * Symlinks cannot be checked out in parallel as, in case of path
@@ -69,6 +56,18 @@ static int is_eligible_for_parallel_checkout(const struct cache_entry *ce,
 	if (!S_ISREG(ce->ce_mode))
 		return 0;
 
+	packed_item_size = sizeof(struct pc_item_fixed_portion) + ce->ce_namelen +
+		(ca->working_tree_encoding ? strlen(ca->working_tree_encoding) : 0);
+
+	/*
+	 * The amount of data we send to the workers per checkout item is
+	 * typically small (75~300B). So unless we find an insanely huge path
+	 * of 64KB, we should never reach the 65KB limit of one pkt-line. If
+	 * that does happen, we let the sequential code handle the item.
+	 */
+	if (packed_item_size > LARGE_PACKET_DATA_MAX)
+		return 0;
+
 	c = classify_conv_attrs(ca);
 	switch (c) {
 	case CA_CLASS_INCORE:
@@ -121,10 +120,12 @@ int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca)
 	ALLOC_GROW(parallel_checkout.items, parallel_checkout.nr + 1,
 		   parallel_checkout.alloc);
 
-	pc_item = &parallel_checkout.items[parallel_checkout.nr++];
+	pc_item = &parallel_checkout.items[parallel_checkout.nr];
 	pc_item->ce = ce;
 	memcpy(&pc_item->ca, ca, sizeof(pc_item->ca));
 	pc_item->status = PC_ITEM_PENDING;
+	pc_item->id = parallel_checkout.nr;
+	parallel_checkout.nr++;
 
 	return 0;
 }
@@ -236,7 +237,8 @@ static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
 	/*
 	 * checkout metadata is used to give context for external process
 	 * filters. Files requiring such filters are not eligible for parallel
-	 * checkout, so pass NULL.
+	 * checkout, so pass NULL. Note: if that changes, the metadata must also
+	 * be passed from the main process to the workers.
 	 */
 	ret = convert_to_working_tree_ca(&pc_item->ca, pc_item->ce->name,
 					 new_blob, size, &buf, NULL);
@@ -268,8 +270,8 @@ static int close_and_clear(int *fd)
 	return ret;
 }
 
-static void write_pc_item(struct parallel_checkout_item *pc_item,
-			  struct checkout *state)
+void write_pc_item(struct parallel_checkout_item *pc_item,
+		   struct checkout *state)
 {
 	unsigned int mode = (pc_item->ce->ce_mode & 0100) ? 0777 : 0666;
 	int fd = -1, fstat_done = 0;
@@ -343,6 +345,240 @@ static void write_pc_item(struct parallel_checkout_item *pc_item,
 	strbuf_release(&path);
 }
 
+static void send_one_item(int fd, struct parallel_checkout_item *pc_item)
+{
+	size_t len_data;
+	char *data, *variant;
+	struct pc_item_fixed_portion *fixed_portion;
+	const char *working_tree_encoding = pc_item->ca.working_tree_encoding;
+	size_t name_len = pc_item->ce->ce_namelen;
+	size_t working_tree_encoding_len = working_tree_encoding ?
+					   strlen(working_tree_encoding) : 0;
+
+	/*
+	 * Any changes in the calculation of the message size must also be made
+	 * in is_eligible_for_parallel_checkout().
+	 */
+	len_data = sizeof(struct pc_item_fixed_portion) + name_len +
+		   working_tree_encoding_len;
+
+	data = xcalloc(1, len_data);
+
+	fixed_portion = (struct pc_item_fixed_portion *)data;
+	fixed_portion->id = pc_item->id;
+	fixed_portion->ce_mode = pc_item->ce->ce_mode;
+	fixed_portion->crlf_action = pc_item->ca.crlf_action;
+	fixed_portion->ident = pc_item->ca.ident;
+	fixed_portion->name_len = name_len;
+	fixed_portion->working_tree_encoding_len = working_tree_encoding_len;
+	/*
+	 * We use hashcpy() instead of oidcpy() because the hash[] positions
+	 * after `the_hash_algo->rawsz` might not be initialized. And Valgrind
+	 * would complain about passing uninitialized bytes to a syscall
+	 * (write(2)). There is no real harm in this case, but the warning could
+	 * hinder the detection of actual errors.
+	 */
+	hashcpy(fixed_portion->oid.hash, pc_item->ce->oid.hash);
+
+	variant = data + sizeof(*fixed_portion);
+	if (working_tree_encoding_len) {
+		memcpy(variant, working_tree_encoding, working_tree_encoding_len);
+		variant += working_tree_encoding_len;
+	}
+	memcpy(variant, pc_item->ce->name, name_len);
+
+	packet_write(fd, data, len_data);
+
+	free(data);
+}
+
+static void send_batch(int fd, size_t start, size_t nr)
+{
+	size_t i;
+	sigchain_push(SIGPIPE, SIG_IGN);
+	for (i = 0; i < nr; i++)
+		send_one_item(fd, &parallel_checkout.items[start + i]);
+	packet_flush(fd);
+	sigchain_pop(SIGPIPE);
+}
+
+static struct pc_worker *setup_workers(struct checkout *state, int num_workers)
+{
+	struct pc_worker *workers;
+	int i, workers_with_one_extra_item;
+	size_t base_batch_size, batch_beginning = 0;
+
+	ALLOC_ARRAY(workers, num_workers);
+
+	for (i = 0; i < num_workers; i++) {
+		struct child_process *cp = &workers[i].cp;
+
+		child_process_init(cp);
+		cp->git_cmd = 1;
+		cp->in = -1;
+		cp->out = -1;
+		cp->clean_on_exit = 1;
+		strvec_push(&cp->args, "checkout--worker");
+		if (state->base_dir_len)
+			strvec_pushf(&cp->args, "--prefix=%s", state->base_dir);
+		if (start_command(cp))
+			die("failed to spawn checkout worker");
+	}
+
+	base_batch_size = parallel_checkout.nr / num_workers;
+	workers_with_one_extra_item = parallel_checkout.nr % num_workers;
+
+	for (i = 0; i < num_workers; i++) {
+		struct pc_worker *worker = &workers[i];
+		size_t batch_size = base_batch_size;
+
+		/* distribute the extra work evenly */
+		if (i < workers_with_one_extra_item)
+			batch_size++;
+
+		send_batch(worker->cp.in, batch_beginning, batch_size);
+		worker->next_item_to_complete = batch_beginning;
+		worker->nr_items_to_complete = batch_size;
+
+		batch_beginning += batch_size;
+	}
+
+	return workers;
+}
+
+static void finish_workers(struct pc_worker *workers, int num_workers)
+{
+	int i;
+
+	/*
+	 * Close pipes before calling finish_command() to let the workers
+	 * exit asynchronously and avoid spending extra time on wait().
+	 */
+	for (i = 0; i < num_workers; i++) {
+		struct child_process *cp = &workers[i].cp;
+		if (cp->in >= 0)
+			close(cp->in);
+		if (cp->out >= 0)
+			close(cp->out);
+	}
+
+	for (i = 0; i < num_workers; i++) {
+		int rc = finish_command(&workers[i].cp);
+		if (rc > 128) {
+			/*
+			 * For a normal non-zero exit, the worker should have
+			 * already printed something useful to stderr. But a
+			 * death by signal should be mentioned to the user.
+			 */
+			error("checkout worker %d died of signal %d", i, rc - 128);
+		}
+	}
+
+	free(workers);
+}
+
+static inline void assert_pc_item_result_size(int got, int exp)
+{
+	if (got != exp)
+		BUG("wrong result size from checkout worker (got %dB, exp %dB)",
+		    got, exp);
+}
+
+static void parse_and_save_result(const char *buffer, int len,
+				  struct pc_worker *worker)
+{
+	struct pc_item_result *res;
+	struct parallel_checkout_item *pc_item;
+	struct stat *st = NULL;
+
+	if (len < PC_ITEM_RESULT_BASE_SIZE)
+		BUG("too short result from checkout worker (got %dB, exp >=%dB)",
+		    len, (int)PC_ITEM_RESULT_BASE_SIZE);
+
+	res = (struct pc_item_result *)buffer;
+
+	/*
+	 * Worker should send either the full result struct on success, or
+	 * just the base (i.e. no stat data), otherwise.
+	 */
+	if (res->status == PC_ITEM_WRITTEN) {
+		assert_pc_item_result_size(len, (int)sizeof(struct pc_item_result));
+		st = &res->st;
+	} else {
+		assert_pc_item_result_size(len, (int)PC_ITEM_RESULT_BASE_SIZE);
+	}
+
+	if (!worker->nr_items_to_complete)
+		BUG("received result from supposedly finished checkout worker");
+	if (res->id != worker->next_item_to_complete)
+		BUG("unexpected item id from checkout worker (got %"PRIuMAX", exp %"PRIuMAX")",
+		    (uintmax_t)res->id, (uintmax_t)worker->next_item_to_complete);
+
+	worker->next_item_to_complete++;
+	worker->nr_items_to_complete--;
+
+	pc_item = &parallel_checkout.items[res->id];
+	pc_item->status = res->status;
+	if (st)
+		pc_item->st = *st;
+}
+
+static void gather_results_from_workers(struct pc_worker *workers,
+					int num_workers)
+{
+	int i, active_workers = num_workers;
+	struct pollfd *pfds;
+
+	CALLOC_ARRAY(pfds, num_workers);
+	for (i = 0; i < num_workers; i++) {
+		pfds[i].fd = workers[i].cp.out;
+		pfds[i].events = POLLIN;
+	}
+
+	while (active_workers) {
+		int nr = poll(pfds, num_workers, -1);
+
+		if (nr < 0) {
+			if (errno == EINTR)
+				continue;
+			die_errno("failed to poll checkout workers");
+		}
+
+		for (i = 0; i < num_workers && nr > 0; i++) {
+			struct pc_worker *worker = &workers[i];
+			struct pollfd *pfd = &pfds[i];
+
+			if (!pfd->revents)
+				continue;
+
+			if (pfd->revents & POLLIN) {
+				int len = packet_read(pfd->fd, NULL, NULL,
+						      packet_buffer,
+						      sizeof(packet_buffer), 0);
+
+				if (len < 0) {
+					BUG("packet_read() returned negative value");
+				} else if (!len) {
+					pfd->fd = -1;
+					active_workers--;
+				} else {
+					parse_and_save_result(packet_buffer,
+							      len, worker);
+				}
+			} else if (pfd->revents & POLLHUP) {
+				pfd->fd = -1;
+				active_workers--;
+			} else if (pfd->revents & (POLLNVAL | POLLERR)) {
+				die("error polling from checkout worker");
+			}
+
+			nr--;
+		}
+	}
+
+	free(pfds);
+}
+
 static void write_items_sequentially(struct checkout *state)
 {
 	size_t i;
@@ -351,16 +587,28 @@ static void write_items_sequentially(struct checkout *state)
 		write_pc_item(&parallel_checkout.items[i], state);
 }
 
+static const int DEFAULT_NUM_WORKERS = 2;
+
 int run_parallel_checkout(struct checkout *state)
 {
-	int ret;
+	int ret, num_workers = DEFAULT_NUM_WORKERS;
 
 	if (parallel_checkout.status != PC_ACCEPTING_ENTRIES)
 		BUG("cannot run parallel checkout: uninitialized or already running");
 
 	parallel_checkout.status = PC_RUNNING;
 
-	write_items_sequentially(state);
+	if (parallel_checkout.nr < num_workers)
+		num_workers = parallel_checkout.nr;
+
+	if (num_workers <= 1) {
+		write_items_sequentially(state);
+	} else {
+		struct pc_worker *workers = setup_workers(state, num_workers);
+		gather_results_from_workers(workers, num_workers);
+		finish_workers(workers, num_workers);
+	}
+
 	ret = handle_results(state);
 
 	finish_parallel_checkout();
diff --git a/parallel-checkout.h b/parallel-checkout.h
index 4ad2a519b3..ec58716519 100644
--- a/parallel-checkout.h
+++ b/parallel-checkout.h
@@ -1,9 +1,14 @@
 #ifndef PARALLEL_CHECKOUT_H
 #define PARALLEL_CHECKOUT_H
 
+#include "convert.h"
+
 struct cache_entry;
 struct checkout;
-struct conv_attrs;
+
+/****************************************************************
+ * Users of parallel checkout
+ ****************************************************************/
 
 enum pc_status {
 	PC_UNINITIALIZED = 0,
@@ -29,4 +34,70 @@ int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca);
 /* Write all the queued entries, returning 0 on success.*/
 int run_parallel_checkout(struct checkout *state);
 
+/****************************************************************
+ * Interface with checkout--worker
+ ****************************************************************/
+
+enum pc_item_status {
+	PC_ITEM_PENDING = 0,
+	PC_ITEM_WRITTEN,
+	/*
+	 * The entry could not be written because there was another file
+	 * already present in its path or leading directories. Since
+	 * checkout_entry_ca() removes such files from the working tree before
+	 * enqueueing the entry for parallel checkout, it means that there was
+	 * a path collision among the entries being written.
+	 */
+	PC_ITEM_COLLIDED,
+	PC_ITEM_FAILED,
+};
+
+struct parallel_checkout_item {
+	/*
+	 * In main process ce points to a istate->cache[] entry. Thus, it's not
+	 * owned by us. In workers they own the memory, which *must be* released.
+	 */
+	struct cache_entry *ce;
+	struct conv_attrs ca;
+	size_t id; /* position in parallel_checkout.items[] of main process */
+
+	/* Output fields, sent from workers. */
+	enum pc_item_status status;
+	struct stat st;
+};
+
+/*
+ * The fixed-size portion of `struct parallel_checkout_item` that is sent to the
+ * workers. Following this will be 2 strings: ca.working_tree_encoding and
+ * ce.name; These are NOT null terminated, since we have the size in the fixed
+ * portion.
+ *
+ * Note that not all fields of conv_attrs and cache_entry are passed, only the
+ * ones that will be required by the workers to smudge and write the entry.
+ */
+struct pc_item_fixed_portion {
+	size_t id;
+	struct object_id oid;
+	unsigned int ce_mode;
+	enum convert_crlf_action crlf_action;
+	int ident;
+	size_t working_tree_encoding_len;
+	size_t name_len;
+};
+
+/*
+ * The fields of `struct parallel_checkout_item` that are returned by the
+ * workers. Note: `st` must be the last one, as it is omitted on error.
+ */
+struct pc_item_result {
+	size_t id;
+	enum pc_item_status status;
+	struct stat st;
+};
+
+#define PC_ITEM_RESULT_BASE_SIZE offsetof(struct pc_item_result, st)
+
+void write_pc_item(struct parallel_checkout_item *pc_item,
+		   struct checkout *state);
+
 #endif /* PARALLEL_CHECKOUT_H */
-- 
2.30.1

