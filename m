Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00069C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 00:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED0161090
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 00:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhDSAPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 20:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhDSAPg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 20:15:36 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0787FC06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 17:15:08 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id y136so2229857qkb.1
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 17:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kiaXRHg92mj71jrMsvh824L/EZwZeBs5PTKYvISldZA=;
        b=ptwhqu8mU1NVYOpi0Y6/gDEO0whbOG6oGtKKAcSaP9cmqBioTmLK4OYThztUVNyCKO
         3haM/cUy7IGIzWWU0EDtVAgD7tXcPRD67JNKs2LpiZin/8BqJsKf+r50txmwx8TEgtpK
         Uj5p0icSRCQlJIHADMzKZhFbOfoa9sRSBpCqjmXsgYc9xgpRYdnOdt6d2AstRaKX5P0p
         IHGiqOhoaY/2foNUMd7ZkHwStyjif0LFcoS3Dp1PMkUhtGY4YOgpHelMIbeaxZToo63i
         dv+8hbmui8wTHUk9LYEnNTPnW02FwTAKArX85/mQVtxruLiqWyhw2C0+Fp4IVt9mX/hQ
         4yRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kiaXRHg92mj71jrMsvh824L/EZwZeBs5PTKYvISldZA=;
        b=eIHVETKAvMWLSis+YpssNbOn5MyQKZ7hFRCX+wFsjTPIVQlgJ+CpaaV/u8nC0NVs29
         1ldPMswpq1iA8XqTKoK0FGM505vvdxun1k3yk1+5N0FCuevybh++APdofwMuPRDU8NvI
         TSu8Is9h4+W91TdB2ZriF5THcr2sKFyIYfRpTdTUzVQmUbxrQ5iTRH+rbszDvCR29KcF
         XvtEC+XnL4XyfW/CHI7zErsaU3kIJ9hAdIm5KD5aNHzkp6U/0FWZ8Jx2G3o9VYxnpGcN
         IiSvxLaiDxo5mwxbZc5D9koY3wbGqZ1uX299RbSUyuPQwiiFOWugJyOYS1OSSA3e0CcO
         IzxA==
X-Gm-Message-State: AOAM531Y18Eya6aWbOWNBRJKugYOhPs7iLKRbbGsHL/VE/pf1TcaZU2l
        B1ULz4tCyTIWrScxjho/qxEtqjWaqZPdAw==
X-Google-Smtp-Source: ABdhPJxtg94EzVuRf16N5kwUwzmWvPRMdyKoI6kfDjQeK61NBAgvyDGo8INzDiZo9f9VBuebbQpaiA==
X-Received: by 2002:ae9:f70d:: with SMTP id s13mr9488482qkg.346.1618791307065;
        Sun, 18 Apr 2021 17:15:07 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id f12sm8272062qti.63.2021.04.18.17.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 17:15:06 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        git@jeffhostetler.com
Subject: [PATCH v3 1/5] unpack-trees: add basic support for parallel checkout
Date:   Sun, 18 Apr 2021 21:14:53 -0300
Message-Id: <7096822c143ed4aed66e811227740610f4d6ac8a.1618790794.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1618790794.git.matheus.bernardino@usp.br>
References: <cover.1618790794.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new interface allows us to enqueue some of the entries being
checked out to later uncompress them, apply in-process filters, and
write out the files in parallel. For now, the parallel checkout
machinery is enabled by default and there is no user configuration, but
run_parallel_checkout() just writes the queued entries in sequence
(without spawning additional workers). The next patch will actually
implement the parallelism and, later, we will make it configurable.

Note that, to avoid potential data races, not all entries are eligible
for parallel checkout. Also, paths that collide on disk (e.g.
case-sensitive paths in case-insensitive file systems), are detected by
the parallel checkout code and skipped, so that they can be safely
sequentially handled later. The collision detection works like the
following:

- If the collision was at basename (e.g. 'a/b' and 'a/B'), the framework
  detects it by looking for EEXIST and EISDIR errors after an
  open(O_CREAT | O_EXCL) failure.

- If the collision was at dirname (e.g. 'a/b' and 'A'), it is detected
  at the has_dirs_only_path() check, which is done for the leading path
  of each item in the parallel checkout queue.

Both verifications rely on the fact that, before enqueueing an entry for
parallel checkout, checkout_entry() makes sure that there is no file at
the entry's path and that its leading components are all real
directories. So, any later change in these conditions indicates that
there was a collision (either between two parallel-eligible entries or
between an eligible and an ineligible one).

After all parallel-eligible entries have been processed, the collided
(and thus, skipped) entries are sequentially fed to checkout_entry()
again. This is similar to the way the current code deals with
collisions, overwriting the previously checked out entries with the
subsequent ones. The only difference is that, since we no longer create
the files in the same order that they appear on index, we are not able
to determine which of the colliding entries will survive on disk (for
the classic code, it is always the last entry).

Co-authored-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Makefile            |   1 +
 entry.c             |  17 ++-
 parallel-checkout.c | 365 ++++++++++++++++++++++++++++++++++++++++++++
 parallel-checkout.h |  32 ++++
 unpack-trees.c      |   6 +-
 5 files changed, 418 insertions(+), 3 deletions(-)
 create mode 100644 parallel-checkout.c
 create mode 100644 parallel-checkout.h

diff --git a/Makefile b/Makefile
index a6a73c5741..99734cc2ea 100644
--- a/Makefile
+++ b/Makefile
@@ -946,6 +946,7 @@ LIB_OBJS += pack-revindex.o
 LIB_OBJS += pack-write.o
 LIB_OBJS += packfile.o
 LIB_OBJS += pager.o
+LIB_OBJS += parallel-checkout.o
 LIB_OBJS += parse-options-cb.o
 LIB_OBJS += parse-options.o
 LIB_OBJS += patch-delta.o
diff --git a/entry.c b/entry.c
index 2dc94ba5cc..d7ed38aa40 100644
--- a/entry.c
+++ b/entry.c
@@ -7,6 +7,7 @@
 #include "progress.h"
 #include "fsmonitor.h"
 #include "entry.h"
+#include "parallel-checkout.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -426,8 +427,17 @@ static void mark_colliding_entries(const struct checkout *state,
 	for (i = 0; i < state->istate->cache_nr; i++) {
 		struct cache_entry *dup = state->istate->cache[i];
 
-		if (dup == ce)
-			break;
+		if (dup == ce) {
+			/*
+			 * Parallel checkout doesn't create the files in index
+			 * order. So the other side of the collision may appear
+			 * after the given cache_entry in the array.
+			 */
+			if (parallel_checkout_status() == PC_RUNNING)
+				continue;
+			else
+				break;
+		}
 
 		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
 			continue;
@@ -536,6 +546,9 @@ int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
 		ca = &ca_buf;
 	}
 
+	if (!enqueue_checkout(ce, ca))
+		return 0;
+
 	return write_entry(ce, path.buf, ca, state, 0);
 }
 
diff --git a/parallel-checkout.c b/parallel-checkout.c
new file mode 100644
index 0000000000..590e2a3046
--- /dev/null
+++ b/parallel-checkout.c
@@ -0,0 +1,365 @@
+#include "cache.h"
+#include "entry.h"
+#include "parallel-checkout.h"
+#include "streaming.h"
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
+	/* pointer to a istate->cache[] entry. Not owned by us. */
+	struct cache_entry *ce;
+	struct conv_attrs ca;
+	struct stat st;
+	enum pc_item_status status;
+};
+
+struct parallel_checkout {
+	enum pc_status status;
+	struct parallel_checkout_item *items; /* The parallel checkout queue. */
+	size_t nr, alloc;
+};
+
+static struct parallel_checkout parallel_checkout;
+
+enum pc_status parallel_checkout_status(void)
+{
+	return parallel_checkout.status;
+}
+
+void init_parallel_checkout(void)
+{
+	if (parallel_checkout.status != PC_UNINITIALIZED)
+		BUG("parallel checkout already initialized");
+
+	parallel_checkout.status = PC_ACCEPTING_ENTRIES;
+}
+
+static void finish_parallel_checkout(void)
+{
+	if (parallel_checkout.status == PC_UNINITIALIZED)
+		BUG("cannot finish parallel checkout: not initialized yet");
+
+	free(parallel_checkout.items);
+	memset(&parallel_checkout, 0, sizeof(parallel_checkout));
+}
+
+static int is_eligible_for_parallel_checkout(const struct cache_entry *ce,
+					     const struct conv_attrs *ca)
+{
+	enum conv_attrs_classification c;
+
+	/*
+	 * Symlinks cannot be checked out in parallel as, in case of path
+	 * collision, they could racily replace leading directories of other
+	 * entries being checked out. Submodules are checked out in child
+	 * processes, which have their own parallel checkout queues.
+	 */
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
+	struct parallel_checkout_item *pc_item;
+
+	if (parallel_checkout.status != PC_ACCEPTING_ENTRIES ||
+	    !is_eligible_for_parallel_checkout(ce, ca))
+		return -1;
+
+	ALLOC_GROW(parallel_checkout.items, parallel_checkout.nr + 1,
+		   parallel_checkout.alloc);
+
+	pc_item = &parallel_checkout.items[parallel_checkout.nr++];
+	pc_item->ce = ce;
+	memcpy(&pc_item->ca, ca, sizeof(pc_item->ca));
+	pc_item->status = PC_ITEM_PENDING;
+
+	return 0;
+}
+
+static int handle_results(struct checkout *state)
+{
+	int ret = 0;
+	size_t i;
+	int have_pending = 0;
+
+	/*
+	 * We first update the successfully written entries with the collected
+	 * stat() data, so that they can be found by mark_colliding_entries(),
+	 * in the next loop, when necessary.
+	 */
+	for (i = 0; i < parallel_checkout.nr; i++) {
+		struct parallel_checkout_item *pc_item = &parallel_checkout.items[i];
+		if (pc_item->status == PC_ITEM_WRITTEN)
+			update_ce_after_write(state, pc_item->ce, &pc_item->st);
+	}
+
+	for (i = 0; i < parallel_checkout.nr; i++) {
+		struct parallel_checkout_item *pc_item = &parallel_checkout.items[i];
+
+		switch(pc_item->status) {
+		case PC_ITEM_WRITTEN:
+			/* Already handled */
+			break;
+		case PC_ITEM_COLLIDED:
+			/*
+			 * The entry could not be checked out due to a path
+			 * collision with another entry. Since there can only
+			 * be one entry of each colliding group on the disk, we
+			 * could skip trying to check out this one and move on.
+			 * However, this would leave the unwritten entries with
+			 * null stat() fields on the index, which could
+			 * potentially slow down subsequent operations that
+			 * require refreshing it: git would not be able to
+			 * trust st_size and would have to go to the filesystem
+			 * to see if the contents match (see ie_modified()).
+			 *
+			 * Instead, let's pay the overhead only once, now, and
+			 * call checkout_entry_ca() again for this file, to
+			 * have its stat() data stored in the index. This also
+			 * has the benefit of adding this entry and its
+			 * colliding pair to the collision report message.
+			 * Additionally, this overwriting behavior is consistent
+			 * with what the sequential checkout does, so it doesn't
+			 * add any extra overhead.
+			 */
+			ret |= checkout_entry_ca(pc_item->ce, &pc_item->ca,
+						 state, NULL, NULL);
+			break;
+		case PC_ITEM_PENDING:
+			have_pending = 1;
+			/* fall through */
+		case PC_ITEM_FAILED:
+			ret = -1;
+			break;
+		default:
+			BUG("unknown checkout item status in parallel checkout");
+		}
+	}
+
+	if (have_pending)
+		error("parallel checkout finished with pending entries");
+
+	return ret;
+}
+
+static int reset_fd(int fd, const char *path)
+{
+	if (lseek(fd, 0, SEEK_SET) != 0)
+		return error_errno("failed to rewind descriptor of '%s'", path);
+	if (ftruncate(fd, 0))
+		return error_errno("failed to truncate file '%s'", path);
+	return 0;
+}
+
+static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
+			       const char *path)
+{
+	int ret;
+	struct stream_filter *filter;
+	struct strbuf buf = STRBUF_INIT;
+	char *blob;
+	unsigned long size;
+	ssize_t wrote;
+
+	/* Sanity check */
+	assert(is_eligible_for_parallel_checkout(pc_item->ce, &pc_item->ca));
+
+	filter = get_stream_filter_ca(&pc_item->ca, &pc_item->ce->oid);
+	if (filter) {
+		if (stream_blob_to_fd(fd, &pc_item->ce->oid, filter, 1)) {
+			/* On error, reset fd to try writing without streaming */
+			if (reset_fd(fd, path))
+				return -1;
+		} else {
+			return 0;
+		}
+	}
+
+	blob = read_blob_entry(pc_item->ce, &size);
+	if (!blob)
+		return error("cannot read object %s '%s'",
+			     oid_to_hex(&pc_item->ce->oid), pc_item->ce->name);
+
+	/*
+	 * checkout metadata is used to give context for external process
+	 * filters. Files requiring such filters are not eligible for parallel
+	 * checkout, so pass NULL.
+	 */
+	ret = convert_to_working_tree_ca(&pc_item->ca, pc_item->ce->name,
+					 blob, size, &buf, NULL);
+
+	if (ret) {
+		size_t newsize;
+		free(blob);
+		blob = strbuf_detach(&buf, &newsize);
+		size = newsize;
+	}
+
+	wrote = write_in_full(fd, blob, size);
+	free(blob);
+	if (wrote < 0)
+		return error("unable to write file '%s'", path);
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
+static void write_pc_item(struct parallel_checkout_item *pc_item,
+			  struct checkout *state)
+{
+	unsigned int mode = (pc_item->ce->ce_mode & 0100) ? 0777 : 0666;
+	int fd = -1, fstat_done = 0;
+	struct strbuf path = STRBUF_INIT;
+	const char *dir_sep;
+
+	strbuf_add(&path, state->base_dir, state->base_dir_len);
+	strbuf_add(&path, pc_item->ce->name, pc_item->ce->ce_namelen);
+
+	dir_sep = find_last_dir_sep(path.buf);
+
+	/*
+	 * The leading dirs should have been already created by now. But, in
+	 * case of path collisions, one of the dirs could have been replaced by
+	 * a symlink (checked out after we enqueued this entry for parallel
+	 * checkout). Thus, we must check the leading dirs again.
+	 */
+	if (dir_sep && !has_dirs_only_path(path.buf, dir_sep - path.buf,
+					   state->base_dir_len)) {
+		pc_item->status = PC_ITEM_COLLIDED;
+		goto out;
+	}
+
+	fd = open(path.buf, O_WRONLY | O_CREAT | O_EXCL, mode);
+
+	if (fd < 0) {
+		if (errno == EEXIST || errno == EISDIR) {
+			/*
+			 * Errors which probably represent a path collision.
+			 * Suppress the error message and mark the item to be
+			 * retried later, sequentially. ENOTDIR and ENOENT are
+			 * also interesting, but the above has_dirs_only_path()
+			 * call should have already caught these cases.
+			 */
+			pc_item->status = PC_ITEM_COLLIDED;
+		} else {
+			error_errno("failed to open file '%s'", path.buf);
+			pc_item->status = PC_ITEM_FAILED;
+		}
+		goto out;
+	}
+
+	if (write_pc_item_to_fd(pc_item, fd, path.buf)) {
+		/* Error was already reported. */
+		pc_item->status = PC_ITEM_FAILED;
+		close_and_clear(&fd);
+		unlink(path.buf);
+		goto out;
+	}
+
+	fstat_done = fstat_checkout_output(fd, state, &pc_item->st);
+
+	if (close_and_clear(&fd)) {
+		error_errno("unable to close file '%s'", path.buf);
+		pc_item->status = PC_ITEM_FAILED;
+		goto out;
+	}
+
+	if (state->refresh_cache && !fstat_done && lstat(path.buf, &pc_item->st) < 0) {
+		error_errno("unable to stat just-written file '%s'",  path.buf);
+		pc_item->status = PC_ITEM_FAILED;
+		goto out;
+	}
+
+	pc_item->status = PC_ITEM_WRITTEN;
+
+out:
+	strbuf_release(&path);
+}
+
+static void write_items_sequentially(struct checkout *state)
+{
+	size_t i;
+
+	for (i = 0; i < parallel_checkout.nr; i++)
+		write_pc_item(&parallel_checkout.items[i], state);
+}
+
+int run_parallel_checkout(struct checkout *state)
+{
+	int ret;
+
+	if (parallel_checkout.status != PC_ACCEPTING_ENTRIES)
+		BUG("cannot run parallel checkout: uninitialized or already running");
+
+	parallel_checkout.status = PC_RUNNING;
+
+	write_items_sequentially(state);
+	ret = handle_results(state);
+
+	finish_parallel_checkout();
+	return ret;
+}
diff --git a/parallel-checkout.h b/parallel-checkout.h
new file mode 100644
index 0000000000..4ad2a519b3
--- /dev/null
+++ b/parallel-checkout.h
@@ -0,0 +1,32 @@
+#ifndef PARALLEL_CHECKOUT_H
+#define PARALLEL_CHECKOUT_H
+
+struct cache_entry;
+struct checkout;
+struct conv_attrs;
+
+enum pc_status {
+	PC_UNINITIALIZED = 0,
+	PC_ACCEPTING_ENTRIES,
+	PC_RUNNING,
+};
+
+enum pc_status parallel_checkout_status(void);
+
+/*
+ * Put parallel checkout into the PC_ACCEPTING_ENTRIES state. Should be used
+ * only when in the PC_UNINITIALIZED state.
+ */
+void init_parallel_checkout(void);
+
+/*
+ * Return -1 if parallel checkout is currently not accepting entries or if the
+ * entry is not eligible for parallel checkout. Otherwise, enqueue the entry
+ * for later write and return 0.
+ */
+int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca);
+
+/* Write all the queued entries, returning 0 on success.*/
+int run_parallel_checkout(struct checkout *state);
+
+#endif /* PARALLEL_CHECKOUT_H */
diff --git a/unpack-trees.c b/unpack-trees.c
index 8a1afbc1e4..f0430d458d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -17,6 +17,7 @@
 #include "object-store.h"
 #include "promisor-remote.h"
 #include "entry.h"
+#include "parallel-checkout.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -441,7 +442,6 @@ static int check_updates(struct unpack_trees_options *o,
 	if (should_update_submodules())
 		load_gitmodules_file(index, &state);
 
-	enable_delayed_checkout(&state);
 	if (has_promisor_remote()) {
 		/*
 		 * Prefetch the objects that are to be checked out in the loop
@@ -464,6 +464,9 @@ static int check_updates(struct unpack_trees_options *o,
 					   to_fetch.oid, to_fetch.nr);
 		oid_array_clear(&to_fetch);
 	}
+
+	enable_delayed_checkout(&state);
+	init_parallel_checkout();
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
@@ -477,6 +480,7 @@ static int check_updates(struct unpack_trees_options *o,
 		}
 	}
 	stop_progress(&progress);
+	errs |= run_parallel_checkout(&state);
 	errs |= finish_delayed_checkout(&state, NULL);
 	git_attr_set_direction(GIT_ATTR_CHECKIN);
 
-- 
2.30.1

