Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C72C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0152073E
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="qVCTxQMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgHJVfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgHJVfK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:35:10 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EEBC061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:10 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c12so7982459qtn.9
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wVm26iTCCXeQuT8Vip9MqcUaktabSiUVttAJe6FADfU=;
        b=qVCTxQMP4hUzCO1ZLGaAzyrM/XCyhpJ47KM5Ma1XXKUJxalGOC1mL/qSAM1Qkvsf4f
         XzHP56oWVUAHHsZxWYQg/fIa5JZMg2WUs10csKzG6KtBRFvgT1F0Wxz95p57NVEWG/6F
         Td4ieF+t0KeFRc1vnSvL346KGcHcN+vnqsoIOybDdltspOgMZKder874xjCfl8teVQMm
         ScuLYEhVj8r32bqKj9g6ccvSloSYEJDoqcoHogrUsthmNAB+/N0QMFG5WYPw2s9rjfX0
         r7egN0e2I9OAzkMrKouqEAW7g3UMsMPcf8HYSQVl9TMyjcoI4q3o9GY0GOsmAaveM70E
         UaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wVm26iTCCXeQuT8Vip9MqcUaktabSiUVttAJe6FADfU=;
        b=abIfl8Bdo/YIgH+Uv7mOgnn7c/GOwpZ0t/UB4I02sKp3PLARGX4mZ+JPzRbGRFcHdf
         GSuepFUhl/GjBTr6xFxNIAOWm22UZHMgzQ6Ed2UqGMj5nypphXAVSzU+rRQzBgJAI/Lv
         jZl/csJJdFXTpoP1yPbFEkWeLE1Ryj37B4mm3ohvwlj1LwKZlUTTGJ6BFnfxR02O7xJF
         N0gMIBciFH2qkw9c4QpKrsFEV2+fOKxnn58dLFEwqchONSzh9ze+gxLNbcC9eXAand41
         2Gi0o2Ne1i9R3v5FKDWXqs1/2MQQnYmO2JNxMHlK6UT7zH8yNOQiy2iSElgCbeiCNSi/
         6TGg==
X-Gm-Message-State: AOAM532mZFtRdEEeZKW8DIPwMFtg3IwsePoPY5kjCvtdGaDSL8vvpaEV
        6BGK5gk5x7TmQCyfT+f/nLUej3iXA3o=
X-Google-Smtp-Source: ABdhPJw11l5s5OrUX7KjKcGq960UrKVnP627WCj3Ty1X9vX9uWijSAqwGbtw4GcVfeDUqI4tyLSVNQ==
X-Received: by 2002:ac8:428f:: with SMTP id o15mr27562365qtl.213.1597095308816;
        Mon, 10 Aug 2020 14:35:08 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:35:07 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [RFC PATCH 10/21] unpack-trees: add basic support for parallel checkout
Date:   Mon, 10 Aug 2020 18:33:18 -0300
Message-Id: <1b39a4099a69f2c42211d46d615055c783703fea.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new interface allows us to enqueue some of the entries being
checked out to later call write_entry() for them in parallel. For now,
the parallel checkout machinery is enabled by default and there is no
user configuration, but run_parallel_checkout() just writes the queued
entries in sequence (without spawning additional workers). The next
patch will actually implement the parallelism and, later, we will make
it configurable.

When there are path collisions among the entries being written (which
can happen e.g. with case-sensitive files in case-insensitive file
systems), the parallel checkout code detects the problem and mark the
checkout_item with CI_RETRY. Later, these items are sequentially feed to
checkout_entry() again. This is similar to the way the sequential code
deals with collisions, overwriting the previously checked out entries
with the subsequent ones. The only difference is that, once we start
writing the entries in parallel, we will no longer be able to determine
which of the colliding entries will survive on disk (for the sequential
algorithm, it is always the last one). Finally, just like the sequential
code, there is no additional overhead when there are no collisions.

Note: we continue the loop of write_checkout_item() even if the previous
call returned an error. This is how checkout_entry() is called in
builtin/checkout.c:checkout_paths() and unpack-trees.c:check-updates().
In the case of fatal errors, die() aborts the loop.

Co-authored-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

For consistency, the parallel code replicates the sequential behavior of
overwriting colliding entries. However, during parallel checkout it's
possible to distinguish a path collision from the case where a path was
already present in the working tree before checkout. So, in the event of
a collision, we could chose to write a single entry and skip overwriting
it with the next ones. Does that sounds reasonable, or are there other
problems in not writing the extra colliding entries?

 Makefile            |   1 +
 entry.c             |   4 +
 parallel-checkout.c | 340 ++++++++++++++++++++++++++++++++++++++++++++
 parallel-checkout.h |  20 +++
 unpack-trees.c      |   6 +-
 5 files changed, 370 insertions(+), 1 deletion(-)
 create mode 100644 parallel-checkout.c
 create mode 100644 parallel-checkout.h

diff --git a/Makefile b/Makefile
index 65f8cfb236..caab8e6401 100644
--- a/Makefile
+++ b/Makefile
@@ -933,6 +933,7 @@ LIB_OBJS += pack-revindex.o
 LIB_OBJS += pack-write.o
 LIB_OBJS += packfile.o
 LIB_OBJS += pager.o
+LIB_OBJS += parallel-checkout.o
 LIB_OBJS += parse-options-cb.o
 LIB_OBJS += parse-options.o
 LIB_OBJS += patch-delta.o
diff --git a/entry.c b/entry.c
index f9835afba3..47c2c20d5a 100644
--- a/entry.c
+++ b/entry.c
@@ -7,6 +7,7 @@
 #include "progress.h"
 #include "fsmonitor.h"
 #include "entry.h"
+#include "parallel-checkout.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -538,6 +539,9 @@ int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
 		ca = &ca_buf;
 	}
 
+	if (!enqueue_checkout(ce, ca))
+		return 0;
+
 	return write_entry(ce, path.buf, ca, state, 0);
 }
 
diff --git a/parallel-checkout.c b/parallel-checkout.c
new file mode 100644
index 0000000000..e3b44eeb34
--- /dev/null
+++ b/parallel-checkout.c
@@ -0,0 +1,340 @@
+#include "cache.h"
+#include "entry.h"
+#include "parallel-checkout.h"
+#include "streaming.h"
+
+enum ci_status {
+	CI_PENDING = 0,
+	CI_SUCCESS,
+	CI_RETRY,
+	CI_FAILED,
+};
+
+struct checkout_item {
+	/* pointer to a istate->cache[] entry. Not owned by us. */
+	struct cache_entry *ce;
+	struct conv_attrs ca;
+	struct stat st;
+	enum ci_status status;
+};
+
+struct parallel_checkout {
+	struct checkout_item *items;
+	size_t nr, alloc;
+};
+
+static struct parallel_checkout *parallel_checkout = NULL;
+
+enum pc_status {
+	PC_UNINITIALIZED = 0,
+	PC_ACCEPTING_ENTRIES,
+	PC_RUNNING,
+	PC_HANDLING_RESULTS,
+};
+
+static enum pc_status pc_status = PC_UNINITIALIZED;
+
+void init_parallel_checkout(void)
+{
+	if (parallel_checkout)
+		BUG("parallel checkout already initialized");
+
+	parallel_checkout = xcalloc(1, sizeof(*parallel_checkout));
+	pc_status = PC_ACCEPTING_ENTRIES;
+}
+
+static void finish_parallel_checkout(void)
+{
+	if (!parallel_checkout)
+		BUG("cannot finish parallel checkout: not initialized yet");
+
+	free(parallel_checkout->items);
+	FREE_AND_NULL(parallel_checkout);
+	pc_status = PC_UNINITIALIZED;
+}
+
+static int is_eligible_for_parallel_checkout(const struct cache_entry *ce,
+					     const struct conv_attrs *ca)
+{
+	enum conv_attrs_classification c;
+
+	if (!S_ISREG(ce->ce_mode))
+		return 0;
+
+	c = classify_conv_attrs(ca);
+	switch (c) {
+	case CA_CLASS_INCORE:
+		return 1;
+
+	case CA_CLASS_INCORE_FILTER:
+		/*
+		 * It would be safe to allow concurrent instances of
+		 * single-file smudge filters, like rot13, but we should not
+		 * assume that all filters are parallel-process safe. So we
+		 * don't allow this.
+		 */
+		return 0;
+
+	case CA_CLASS_INCORE_PROCESS:
+		/*
+		 * The parallel queue and the delayed queue are not compatible,
+		 * so they must be kept completely separated. And we can't tell
+		 * if a long-running process will delay its response without
+		 * actually asking it to perform the filtering. Therefore, this
+		 * type of filter is not allowed in parallel checkout.
+		 *
+		 * Furthermore, there should only be one instance of the
+		 * long-running process filter as we don't know how it is
+		 * managing its own concurrency. So, spreading the entries that
+		 * requisite such a filter among the parallel workers would
+		 * require a lot more inter-process communication. We would
+		 * probably have to designate a single process to interact with
+		 * the filter and send all the necessary data to it, for each
+		 * entry.
+		 */
+		return 0;
+
+	case CA_CLASS_STREAMABLE:
+		return 1;
+
+	default:
+		BUG("unsupported conv_attrs classification '%d'", c);
+	}
+}
+
+int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca)
+{
+	struct checkout_item *ci;
+
+	if (!parallel_checkout || pc_status != PC_ACCEPTING_ENTRIES ||
+	    !is_eligible_for_parallel_checkout(ce, ca))
+		return -1;
+
+	ALLOC_GROW(parallel_checkout->items, parallel_checkout->nr + 1,
+		   parallel_checkout->alloc);
+
+	ci = &parallel_checkout->items[parallel_checkout->nr++];
+	ci->ce = ce;
+	memcpy(&ci->ca, ca, sizeof(ci->ca));
+
+	return 0;
+}
+
+static int handle_results(struct checkout *state)
+{
+	int ret = 0;
+	size_t i;
+
+	pc_status = PC_HANDLING_RESULTS;
+
+	for (i = 0; i < parallel_checkout->nr; ++i) {
+		struct checkout_item *ci = &parallel_checkout->items[i];
+		struct stat *st = &ci->st;
+
+		switch(ci->status) {
+		case CI_SUCCESS:
+			update_ce_after_write(state, ci->ce, st);
+			break;
+		case CI_RETRY:
+			/*
+			 * The fails for which we set CI_RETRY are the ones
+			 * that might have been caused by a path collision. So
+			 * we let checkout_entry_ca() retry writing, as it will
+			 * properly handle collisions and the creation of
+			 * leading dirs in the entry's path.
+			 */
+			ret |= checkout_entry_ca(ci->ce, &ci->ca, state, NULL, NULL);
+			break;
+		case CI_FAILED:
+			ret = -1;
+			break;
+		case CI_PENDING:
+			BUG("parallel checkout finished with pending entries");
+		default:
+			BUG("unknown checkout item status in parallel checkout");
+		}
+	}
+
+	return ret;
+}
+
+static int reset_fd(int fd, const char *path)
+{
+	if (lseek(fd, 0, SEEK_SET) != 0)
+		return error_errno("failed to rewind descriptor of %s", path);
+	if (ftruncate(fd, 0))
+		return error_errno("failed to truncate file %s", path);
+	return 0;
+}
+
+static int write_checkout_item_to_fd(int fd, struct checkout *state,
+				     struct checkout_item *ci, const char *path)
+{
+	int ret;
+	struct stream_filter *filter;
+	struct strbuf buf = STRBUF_INIT;
+	char *new_blob;
+	unsigned long size;
+	size_t newsize = 0;
+	ssize_t wrote;
+
+	/* Sanity check */
+	assert(is_eligible_for_parallel_checkout(ci->ce, &ci->ca));
+
+	filter = get_stream_filter_ca(&ci->ca, &ci->ce->oid);
+	if (filter) {
+		if (stream_blob_to_fd(fd, &ci->ce->oid, filter, 1)) {
+			/* On error, reset fd to try writing without streaming */
+			if (reset_fd(fd, path))
+				return -1;
+		} else {
+			return 0;
+		}
+	}
+
+	new_blob = read_blob_entry(ci->ce, &size);
+	if (!new_blob)
+		return error("unable to read sha1 file of %s (%s)", path,
+			     oid_to_hex(&ci->ce->oid));
+
+	/*
+	 * checkout metadata is used to give context for external process
+	 * filters. Files requiring such filters are not eligible for parallel
+	 * checkout, so pass NULL.
+	 */
+	ret = convert_to_working_tree_ca(&ci->ca, ci->ce->name, new_blob, size,
+					 &buf, NULL);
+
+	if (ret) {
+		free(new_blob);
+		new_blob = strbuf_detach(&buf, &newsize);
+		size = newsize;
+	}
+
+	wrote = write_in_full(fd, new_blob, size);
+	free(new_blob);
+	if (wrote < 0)
+		return error("unable to write file %s", path);
+
+	return 0;
+}
+
+static int close_and_clear(int *fd)
+{
+	int ret = 0;
+
+	if (*fd >= 0) {
+		ret = close(*fd);
+		*fd = -1;
+	}
+
+	return ret;
+}
+
+static int check_leading_dirs(const char *path, int len, int prefix_len)
+{
+	const char *slash = path + len;
+
+	while (slash > path && *slash != '/')
+		slash--;
+
+	return has_dirs_only_path(path, slash - path, prefix_len);
+}
+
+static void write_checkout_item(struct checkout *state, struct checkout_item *ci)
+{
+	unsigned int mode = (ci->ce->ce_mode & 0100) ? 0777 : 0666;
+	int fd = -1, fstat_done = 0;
+	struct strbuf path = STRBUF_INIT;
+
+	strbuf_add(&path, state->base_dir, state->base_dir_len);
+	strbuf_add(&path, ci->ce->name, ce_namelen(ci->ce));
+
+	/*
+	 * At this point, leading dirs should have already been created. But if
+	 * a symlink being checked out has collided with one of the dirs, due to
+	 * file system folding rules, it's possible that the dirs are no longer
+	 * present. So we have to check again, and report any path collisions.
+	 */
+	if (!check_leading_dirs(path.buf, path.len, state->base_dir_len)) {
+		ci->status = CI_RETRY;
+		goto out;
+	}
+
+	fd = open(path.buf, O_WRONLY | O_CREAT | O_EXCL, mode);
+
+	if (fd < 0) {
+		if (errno == EEXIST || errno == EISDIR) {
+			/*
+			 * Errors which probably represent a path collision.
+			 * Suppress the error message and mark the ci to be
+			 * retried later, sequentially. ENOTDIR and ENOENT are
+			 * also interesting, but check_leading_dirs() should
+			 * have already caught these cases.
+			 */
+			ci->status = CI_RETRY;
+		} else {
+			error_errno("failed to open file %s", path.buf);
+			ci->status = CI_FAILED;
+		}
+		goto out;
+	}
+
+	if (write_checkout_item_to_fd(fd, state, ci, path.buf)) {
+		/* Error was already reported. */
+		ci->status = CI_FAILED;
+		goto out;
+	}
+
+	fstat_done = fstat_checkout_output(fd, state, &ci->st);
+
+	if (close_and_clear(&fd)) {
+		error_errno("unable to close file %s", path.buf);
+		ci->status = CI_FAILED;
+		goto out;
+	}
+
+	if (state->refresh_cache && !fstat_done && lstat(path.buf, &ci->st) < 0) {
+		error_errno("unable to stat just-written file %s",  path.buf);
+		ci->status = CI_FAILED;
+		goto out;
+	}
+
+	ci->status = CI_SUCCESS;
+
+out:
+	/*
+	 * No need to check close() return. At this point, either fd is already
+	 * closed, or we are on an error path, that has already been reported.
+	 */
+	close_and_clear(&fd);
+	strbuf_release(&path);
+}
+
+static int run_checkout_sequentially(struct checkout *state)
+{
+	size_t i;
+
+	for (i = 0; i < parallel_checkout->nr; ++i) {
+		struct checkout_item *ci = &parallel_checkout->items[i];
+		write_checkout_item(state, ci);
+	}
+
+	return handle_results(state);
+}
+
+
+int run_parallel_checkout(struct checkout *state)
+{
+	int ret;
+
+	if (!parallel_checkout)
+		BUG("cannot run parallel checkout: not initialized yet");
+
+	pc_status = PC_RUNNING;
+
+	ret = run_checkout_sequentially(state);
+
+	finish_parallel_checkout();
+	return ret;
+}
diff --git a/parallel-checkout.h b/parallel-checkout.h
new file mode 100644
index 0000000000..8eef59ffcd
--- /dev/null
+++ b/parallel-checkout.h
@@ -0,0 +1,20 @@
+#ifndef PARALLEL_CHECKOUT_H
+#define PARALLEL_CHECKOUT_H
+
+struct cache_entry;
+struct checkout;
+struct conv_attrs;
+
+void init_parallel_checkout(void);
+
+/*
+ * Return -1 if parallel checkout is currently not enabled or if the entry is
+ * not eligible for parallel checkout. Otherwise, enqueue the entry for later
+ * write and return 0.
+ */
+int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca);
+
+/* Write all the queued entries, returning 0 on success.*/
+int run_parallel_checkout(struct checkout *state);
+
+#endif /* PARALLEL_CHECKOUT_H */
diff --git a/unpack-trees.c b/unpack-trees.c
index a511fadd89..1b1da7485a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -17,6 +17,7 @@
 #include "object-store.h"
 #include "promisor-remote.h"
 #include "entry.h"
+#include "parallel-checkout.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -438,7 +439,6 @@ static int check_updates(struct unpack_trees_options *o,
 	if (should_update_submodules())
 		load_gitmodules_file(index, &state);
 
-	enable_delayed_checkout(&state);
 	if (has_promisor_remote()) {
 		/*
 		 * Prefetch the objects that are to be checked out in the loop
@@ -461,6 +461,9 @@ static int check_updates(struct unpack_trees_options *o,
 					   to_fetch.oid, to_fetch.nr);
 		oid_array_clear(&to_fetch);
 	}
+
+	enable_delayed_checkout(&state);
+	init_parallel_checkout();
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
@@ -474,6 +477,7 @@ static int check_updates(struct unpack_trees_options *o,
 		}
 	}
 	stop_progress(&progress);
+	errs |= run_parallel_checkout(&state);
 	errs |= finish_delayed_checkout(&state, NULL);
 	git_attr_set_direction(GIT_ATTR_CHECKIN);
 
-- 
2.27.0

