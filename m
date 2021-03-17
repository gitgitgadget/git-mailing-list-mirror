Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC35C433E9
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD91264F40
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbhCQVNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhCQVMi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:12:38 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F13C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:12:38 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id n79so40481194qke.3
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ONlH2Rg1Sv1pcolXOr+M/27K7ZRL1v+EO6AZdzIXZg=;
        b=Bdlcy55f4FZ8QFDrGOMnzqVG9tpq24MiYSV8gaihglMqIwUM1Kq1zsCXU3DNhG1mgs
         eOV7pbm2sxgQ/CsI2Y62b5FosaPywNqmtYv3NtiCq+1RBgAxakOemv3TRs296qhx10Ri
         1EZn/BZY3k5m6HE4rT/Ejo+Uo16T664+UxUsPft3wnFqPN+ZDiPnX7q2rxpdvWDG+as3
         wjyGgoL4/xfib7PpsOMiU8RtFbRYT7IikqBujF0VgRQs6jeltZ5kHDkJvW1lsi2e6KKn
         DQMjGns/FDWwbURUs/gd6GwrMvsoBYzv7ydENLeltCkB3XE+E5jxaRXZQ85HWbk5xwmX
         2gFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ONlH2Rg1Sv1pcolXOr+M/27K7ZRL1v+EO6AZdzIXZg=;
        b=pBg8V14JirdqF9PavNjVMusM9OWsJI4MwDo1ZqFKT8sC+ZOy7ea9nURyA9GgfwTDUX
         cBDWqHSEzODC+19Cm+TqjNEymapFmccvsHFjJc7Nx6QEymAWtyaxgf7bqIGKKTZyyZdm
         A12wc9dhNBP+OGOOYJwg3/SZtakQtmL7OrjzQadvlKo/KSqMGAmFXw7ITywOna3usvB2
         boetzHET+lPt33O6KxVhV4nu4vPnwY1Ph6rjSyS7IzXgl/dXYOHX7f3XSjfGgPCz0mS7
         JOOCuhpB9s6xZJ4M+PZIJPE/B9Su6C2zUcESstq6xCrq0s3GQXGF9fstIJPK0/X5RnRG
         kBmQ==
X-Gm-Message-State: AOAM531CiMEyDYzV0pucW6SPETtwaI/uRoRIsjfXbTf9aTP+IGuk5/MH
        wGjuUFWRrjqGmFWOfEN7u34TcvxU81PZag==
X-Google-Smtp-Source: ABdhPJzuvRyeHDYtr9yvfb//E2moyyLU8P1sKWs8gMkVW5g6YfWR+Z28TVrDGHJYdPSJ73WyEUHSBQ==
X-Received: by 2002:a37:46c5:: with SMTP id t188mr1268978qka.47.1616015554820;
        Wed, 17 Mar 2021 14:12:34 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id f9sm131138qkk.115.2021.03.17.14.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:12:34 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com
Subject: [PATCH 2/5] parallel-checkout: make it truly parallel
Date:   Wed, 17 Mar 2021 18:12:20 -0300
Message-Id: <fca797698c78e2248bd2645bd0dce23ec4df35ae.1616015337.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1616015337.git.matheus.bernardino@usp.br>
References: <cover.1616015337.git.matheus.bernardino@usp.br>
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
 builtin/checkout--helper.c | 142 ++++++++++++++++++++
 git.c                      |   2 +
 parallel-checkout.c        | 267 +++++++++++++++++++++++++++++++++----
 parallel-checkout.h        |  73 +++++++++-
 7 files changed, 460 insertions(+), 27 deletions(-)
 create mode 100644 builtin/checkout--helper.c

diff --git a/.gitignore b/.gitignore
index 3dcdb6bb5a..26f8ddfc55 100644
--- a/.gitignore
+++ b/.gitignore
@@ -33,6 +33,7 @@
 /git-check-mailmap
 /git-check-ref-format
 /git-checkout
+/git-checkout--helper
 /git-checkout-index
 /git-cherry
 /git-cherry-pick
diff --git a/Makefile b/Makefile
index f7b9ab49f9..29df386d8a 100644
--- a/Makefile
+++ b/Makefile
@@ -1054,6 +1054,7 @@ BUILTIN_OBJS += builtin/check-attr.o
 BUILTIN_OBJS += builtin/check-ignore.o
 BUILTIN_OBJS += builtin/check-mailmap.o
 BUILTIN_OBJS += builtin/check-ref-format.o
+BUILTIN_OBJS += builtin/checkout--helper.o
 BUILTIN_OBJS += builtin/checkout-index.o
 BUILTIN_OBJS += builtin/checkout.o
 BUILTIN_OBJS += builtin/clean.o
diff --git a/builtin.h b/builtin.h
index b6ce981b73..a3a3f7abb1 100644
--- a/builtin.h
+++ b/builtin.h
@@ -123,6 +123,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix);
 int cmd_bundle(int argc, const char **argv, const char *prefix);
 int cmd_cat_file(int argc, const char **argv, const char *prefix);
 int cmd_checkout(int argc, const char **argv, const char *prefix);
+int cmd_checkout__helper(int argc, const char **argv, const char *prefix);
 int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 int cmd_check_attr(int argc, const char **argv, const char *prefix);
 int cmd_check_ignore(int argc, const char **argv, const char *prefix);
diff --git a/builtin/checkout--helper.c b/builtin/checkout--helper.c
new file mode 100644
index 0000000000..df9a6fab1e
--- /dev/null
+++ b/builtin/checkout--helper.c
@@ -0,0 +1,142 @@
+#include "builtin.h"
+#include "config.h"
+#include "entry.h"
+#include "parallel-checkout.h"
+#include "parse-options.h"
+#include "pkt-line.h"
+
+static void packet_to_pc_item(char *line, int len,
+			      struct parallel_checkout_item *pc_item)
+{
+	struct pc_item_fixed_portion *fixed_portion;
+	char *encoding, *variant;
+
+	if (len < sizeof(struct pc_item_fixed_portion))
+		BUG("checkout worker received too short item (got %dB, exp %dB)",
+		    len, (int)sizeof(struct pc_item_fixed_portion));
+
+	fixed_portion = (struct pc_item_fixed_portion *)line;
+
+	if (len - sizeof(struct pc_item_fixed_portion) !=
+		fixed_portion->name_len + fixed_portion->working_tree_encoding_len)
+		BUG("checkout worker received corrupted item");
+
+	variant = line + sizeof(struct pc_item_fixed_portion);
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
+		int len;
+		char *line = packet_read_line(0, &len);
+
+		if (!line)
+			break;
+
+		ALLOC_GROW(items, nr + 1, alloc);
+		packet_to_pc_item(line, len, &items[nr++]);
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
+static const char * const checkout_helper_usage[] = {
+	N_("git checkout--helper [<options>]"),
+	NULL
+};
+
+int cmd_checkout__helper(int argc, const char **argv, const char *prefix)
+{
+	struct checkout state = CHECKOUT_INIT;
+	struct option checkout_helper_options[] = {
+		OPT_STRING(0, "prefix", &state.base_dir, N_("string"),
+			N_("when creating files, prepend <string>")),
+		OPT_END()
+	};
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(checkout_helper_usage,
+				   checkout_helper_options);
+
+	git_config(git_default_config, NULL);
+	argc = parse_options(argc, argv, prefix, checkout_helper_options,
+			     checkout_helper_usage, 0);
+	if (argc > 0)
+		usage_with_options(checkout_helper_usage, checkout_helper_options);
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
index 9bc077a025..a9cd4b1e9a 100644
--- a/git.c
+++ b/git.c
@@ -490,6 +490,8 @@ static struct cmd_struct commands[] = {
 	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
 	{ "check-ref-format", cmd_check_ref_format, NO_PARSEOPT  },
 	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
+	{ "checkout--helper", cmd_checkout__helper,
+		RUN_SETUP | NEED_WORK_TREE | SUPPORT_SUPER_PREFIX },
 	{ "checkout-index", cmd_checkout_index,
 		RUN_SETUP | NEED_WORK_TREE},
 	{ "cherry", cmd_cherry, RUN_SETUP },
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 80a60eb2d3..df447aa3a6 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -1,28 +1,13 @@
 #include "cache.h"
 #include "entry.h"
 #include "parallel-checkout.h"
+#include "pkt-line.h"
+#include "run-command.h"
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
@@ -121,10 +106,12 @@ int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca)
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
@@ -237,7 +224,8 @@ static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
 	/*
 	 * checkout metadata is used to give context for external process
 	 * filters. Files requiring such filters are not eligible for parallel
-	 * checkout, so pass NULL.
+	 * checkout, so pass NULL. Note: if that changes, the metadata must also
+	 * be passed from the main process to the workers.
 	 */
 	ret = convert_to_working_tree_ca(&pc_item->ca, pc_item->ce->name,
 					 new_blob, size, &buf, NULL);
@@ -268,8 +256,8 @@ static int close_and_clear(int *fd)
 	return ret;
 }
 
-static void write_pc_item(struct parallel_checkout_item *pc_item,
-			  struct checkout *state)
+void write_pc_item(struct parallel_checkout_item *pc_item,
+		   struct checkout *state)
 {
 	unsigned int mode = (pc_item->ce->ce_mode & 0100) ? 0777 : 0666;
 	int fd = -1, fstat_done = 0;
@@ -343,6 +331,221 @@ static void write_pc_item(struct parallel_checkout_item *pc_item,
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
+	for (i = 0; i < nr; i++)
+		send_one_item(fd, &parallel_checkout.items[start + i]);
+	packet_flush(fd);
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
+		strvec_push(&cp->args, "checkout--helper");
+		if (state->base_dir_len)
+			strvec_pushf(&cp->args, "--prefix=%s", state->base_dir);
+		if (start_command(cp))
+			die(_("failed to spawn checkout worker"));
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
+		if (finish_command(&workers[i].cp))
+			error(_("checkout worker %d finished with error"), i);
+	}
+
+	free(workers);
+}
+
+#define ASSERT_PC_ITEM_RESULT_SIZE(got, exp) \
+{ \
+	if (got != exp) \
+		BUG("corrupted result from checkout worker (got %dB, exp %dB)", \
+		    got, exp); \
+} while(0)
+
+static void parse_and_save_result(const char *line, int len,
+				  struct pc_worker *worker)
+{
+	struct pc_item_result *res;
+	struct parallel_checkout_item *pc_item;
+	struct stat *st = NULL;
+
+	if (len < PC_ITEM_RESULT_BASE_SIZE)
+		BUG("too short result from checkout worker (got %dB, exp %dB)",
+		    len, (int)PC_ITEM_RESULT_BASE_SIZE);
+
+	res = (struct pc_item_result *)line;
+
+	/*
+	 * Worker should send either the full result struct on success, or
+	 * just the base (i.e. no stat data), otherwise.
+	 */
+	if (res->status == PC_ITEM_WRITTEN) {
+		ASSERT_PC_ITEM_RESULT_SIZE(len, (int)sizeof(struct pc_item_result));
+		st = &res->st;
+	} else {
+		ASSERT_PC_ITEM_RESULT_SIZE(len, (int)PC_ITEM_RESULT_BASE_SIZE);
+	}
+
+	if (!worker->nr_items_to_complete || res->id != worker->next_item_to_complete)
+		BUG("checkout worker sent unexpected item id");
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
+				int len;
+				const char *line = packet_read_line(pfd->fd, &len);
+
+				if (!line) {
+					pfd->fd = -1;
+					active_workers--;
+				} else {
+					parse_and_save_result(line, len, worker);
+				}
+			} else if (pfd->revents & POLLHUP) {
+				pfd->fd = -1;
+				active_workers--;
+			} else if (pfd->revents & (POLLNVAL | POLLERR)) {
+				die(_("error polling from checkout worker"));
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
@@ -351,16 +554,28 @@ static void write_items_sequentially(struct checkout *state)
 		write_pc_item(&parallel_checkout.items[i], state);
 }
 
+#define DEFAULT_NUM_WORKERS 2
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
index 4ad2a519b3..35e5e69a96 100644
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
+ * Interface with checkout--helper
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

