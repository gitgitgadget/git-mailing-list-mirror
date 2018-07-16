Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12DB11F597
	for <e@80x24.org>; Mon, 16 Jul 2018 18:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeGPTMr (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 15:12:47 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:50695 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeGPTMr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 15:12:47 -0400
Received: by mail-yb0-f202.google.com with SMTP id x13-v6so34088725ybl.17
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=7UYbJOD+n/AgeYBBO7uLBtDlL/mNqK1lX/B2+4XPoew=;
        b=uvfCzcF4ilx5Fgn2oHze5I5Y0hll9PePMWE7rgWfXhqzMTH2dQLhGQphnyDCjARn1Q
         reyMeJqV909TAXGV2H6J1+++UvJ7Lwq5GpoLw5aVgXIhHvIpQhuiJ38mbbJDVeJiP8B7
         YwRmFBH3yFyMPKzwrhMv3l3wj/uuSeKp1fwZTqEqDMzk09CypFpL32B/TeWdzK0esvWC
         HvYtlJBHZY3uKYZJ+/3xPDn6L+G0XTkWsVKFEnWA2vkP6UZ8rEcdl78UxcXfmVfHY/Df
         2y7NiSEFEuDM8W7q6nCsMd98348KpOcyPwTBBbs3ZIwYzXGV9q6Hezeu6njyH7MOd+5f
         Rsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=7UYbJOD+n/AgeYBBO7uLBtDlL/mNqK1lX/B2+4XPoew=;
        b=Q9311qwSEjDr02lI98b6wutsz0D1uJf7IOT8Wz9lz4EzcpIny5ESYJJRl0SLX0psJN
         /jS7bPHKipIDL6mhuuE+Rpj9LcTvyZEFrfjbOTypKIFUG7IJ8AfScEL/liiLRN+2veer
         O1V3szE5LHSn7dDH0tojo24WrW0w0ju3fCVbC+iGK4rSbYT4/tMcDwN6lVvvD+TPmGJ1
         B/DL2Pec4i//HBSg7gePlx8r7C8KISi71nmPumjEjCKGHREouoUMigZjxp7QSc8j3OWL
         7doq+ltjLH5u2VlR04hWvasBLwhri45NC4cwj5b3ApgnUeJrLWxioza0Jy7RKt0p6eaN
         kR8w==
X-Gm-Message-State: AOUpUlE/Fxgf6AHC1Xm/OdSrUrZLKEoTV56LPGnnto35Gcwb7BNixEQ5
        acjAZbem4k5CkG3y8pw870W14FPTOIe36URAAXa4tlrpX5Unu52gWTd/maP+yIp0U0kzCmYs7Jn
        NQ3slo3Vc4dF63f4idpzBr535OOSnSeinc3CNQHh+r5tR0HCVMcBAuOwH499K0XutjKKgKNPMaW
        +W
X-Google-Smtp-Source: AAOMgpe2c27OpE5PASx1YPORvX/q3Y/XmUTdPR6vXpdAVoi1CS8omyTxjp3OTDWpGnBsEQKYrqY9lD6dOLuCmDa/41/9
MIME-Version: 1.0
X-Received: by 2002:a81:ec3:: with SMTP id 186-v6mr5275151ywo.156.1531766644981;
 Mon, 16 Jul 2018 11:44:04 -0700 (PDT)
Date:   Mon, 16 Jul 2018 11:44:01 -0700
Message-Id: <20180716184401.168576-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH] negotiator/skipping: skip commits during fetch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new negotiation algorithm used during fetch that skips
commits in an effort to find common ancestors faster. The skips grow
similarly to the Fibonacci sequence as the commit walk proceeds further
away from the tips. The skips may cause unnecessary commits to be
included in the packfile, but the negotiation step typically ends more
quickly.

Usage of this algorithm is guarded behind the configuration flag
fetch.negotiationAlgorithm.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is on jt/fetch-pack-negotiator, but also applies cleanly on
jt/fetch-nego-tip.

A previous version of this had rough backtracking after a "match" is
found, but that backtracking implementation was complicated and inexact,
so I've removed it.

At $DAY_JOB we have been using this patch with some success, so I'm
sending it to this mailing list.
---
 Documentation/config.txt             |   9 +
 Makefile                             |   1 +
 fetch-negotiator.c                   |   8 +-
 fetch-negotiator.h                   |   3 +-
 fetch-pack.c                         |   7 +-
 negotiator/skipping.c                | 250 +++++++++++++++++++++++++++
 negotiator/skipping.h                |   8 +
 t/t5552-skipping-fetch-negotiator.sh | 179 +++++++++++++++++++
 8 files changed, 461 insertions(+), 4 deletions(-)
 create mode 100644 negotiator/skipping.c
 create mode 100644 negotiator/skipping.h
 create mode 100755 t/t5552-skipping-fetch-negotiator.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a9..53443fb9db 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1491,6 +1491,15 @@ fetch.output::
 	`full` and `compact`. Default value is `full`. See section
 	OUTPUT in linkgit:git-fetch[1] for detail.
 
+fetch.negotiationAlgorithm::
+	Control how information about the commits in the local repository is
+	sent when negotiating the contents of the packfile to be sent by the
+	server. Set to "skipping" to use an algorithm that skips commits in an
+	effort to converge faster, but may result in a larger-than-necessary
+	packfile; any other value instructs Git to use the default algorithm
+	that never skips commits (unless the server has acknowledged it or one
+	of its descendants).
+
 format.attach::
 	Enable multipart/mixed attachments as the default for
 	'format-patch'.  The value can also be a double quoted string
diff --git a/Makefile b/Makefile
index 96f84d1dcf..617475622b 100644
--- a/Makefile
+++ b/Makefile
@@ -893,6 +893,7 @@ LIB_OBJS += merge-recursive.o
 LIB_OBJS += mergesort.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += negotiator/default.o
+LIB_OBJS += negotiator/skipping.o
 LIB_OBJS += notes.o
 LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index 2675d120fe..5d283049f4 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -1,8 +1,14 @@
 #include "git-compat-util.h"
 #include "fetch-negotiator.h"
 #include "negotiator/default.h"
+#include "negotiator/skipping.h"
 
-void fetch_negotiator_init(struct fetch_negotiator *negotiator)
+void fetch_negotiator_init(struct fetch_negotiator *negotiator,
+			   const char *algorithm)
 {
+	if (algorithm && !strcmp(algorithm, "skipping")) {
+		skipping_negotiator_init(negotiator);
+		return;
+	}
 	default_negotiator_init(negotiator);
 }
diff --git a/fetch-negotiator.h b/fetch-negotiator.h
index b1290aa9c6..ddb44a22dc 100644
--- a/fetch-negotiator.h
+++ b/fetch-negotiator.h
@@ -52,6 +52,7 @@ struct fetch_negotiator {
 	void *data;
 };
 
-void fetch_negotiator_init(struct fetch_negotiator *negotiator);
+void fetch_negotiator_init(struct fetch_negotiator *negotiator,
+			   const char *algorithm);
 
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index 1e50d90082..50773fdde3 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -33,6 +33,7 @@ static int agent_supported;
 static int server_supports_filtering;
 static struct lock_file shallow_lock;
 static const char *alternate_shallow_file;
+static char *negotiation_algorithm;
 
 /* Remember to update object flag allocation in object.h */
 #define COMPLETE	(1U << 0)
@@ -905,7 +906,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	const char *agent_feature;
 	int agent_len;
 	struct fetch_negotiator negotiator;
-	fetch_negotiator_init(&negotiator);
+	fetch_negotiator_init(&negotiator, negotiation_algorithm);
 
 	sort_ref_list(&ref, ref_compare_name);
 	QSORT(sought, nr_sought, cmp_ref_by_name);
@@ -1287,7 +1288,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	int in_vain = 0;
 	int haves_to_send = INITIAL_FLUSH;
 	struct fetch_negotiator negotiator;
-	fetch_negotiator_init(&negotiator);
+	fetch_negotiator_init(&negotiator, negotiation_algorithm);
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE);
 
@@ -1366,6 +1367,8 @@ static void fetch_pack_config(void)
 	git_config_get_bool("repack.usedeltabaseoffset", &prefer_ofs_delta);
 	git_config_get_bool("fetch.fsckobjects", &fetch_fsck_objects);
 	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
+	git_config_get_string("fetch.negotiationalgorithm",
+			      &negotiation_algorithm);
 
 	git_config(git_default_config, NULL);
 }
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
new file mode 100644
index 0000000000..74d25e8825
--- /dev/null
+++ b/negotiator/skipping.c
@@ -0,0 +1,250 @@
+#include "cache.h"
+#include "skipping.h"
+#include "../commit.h"
+#include "../fetch-negotiator.h"
+#include "../prio-queue.h"
+#include "../refs.h"
+#include "../tag.h"
+
+/* Remember to update object flag allocation in object.h */
+/*
+ * Both us and the server know that both parties have this object.
+ */
+#define COMMON		(1U << 2)
+/*
+ * The server has told us that it has this object. We still need to tell the
+ * server that we have this object (or one of its descendants), but since we are
+ * going to do that, we do not need to tell the server about its ancestors.
+ */
+#define ADVERTISED	(1U << 3)
+/*
+ * This commit has entered the priority queue.
+ */
+#define SEEN		(1U << 4)
+/*
+ * This commit has left the priority queue.
+ */
+#define POPPED		(1U << 5)
+
+static int marked;
+
+/*
+ * An entry in the priority queue.
+ */
+struct entry {
+	struct commit *commit;
+
+	/*
+	 * Used only if commit is not COMMON.
+	 */
+	uint16_t original_ttl;
+	uint16_t ttl;
+};
+
+struct data {
+	struct prio_queue rev_list;
+
+	/*
+	 * The number of non-COMMON commits in rev_list.
+	 */
+	int non_common_revs;
+};
+
+static int compare(const void *a_, const void *b_, void *unused)
+{
+	const struct entry *a = a_;
+	const struct entry *b = b_;
+	return compare_commits_by_commit_date(a->commit, b->commit, NULL);
+}
+
+static struct entry *rev_list_push(struct data *data, struct commit *commit, int mark)
+{
+	struct entry *entry;
+	commit->object.flags |= mark | SEEN;
+
+	entry = xcalloc(1, sizeof(*entry));
+	entry->commit = commit;
+	prio_queue_put(&data->rev_list, entry);
+
+	if (!(mark & COMMON))
+		data->non_common_revs++;
+	return entry;
+}
+
+static int clear_marks(const char *refname, const struct object_id *oid,
+		       int flag, void *cb_data)
+{
+	struct object *o = deref_tag(parse_object(oid), refname, 0);
+
+	if (o && o->type == OBJ_COMMIT)
+		clear_commit_marks((struct commit *)o,
+				   COMMON | ADVERTISED | SEEN | POPPED);
+	return 0;
+}
+
+/*
+ * Mark this SEEN commit and all its SEEN ancestors as COMMON.
+ */
+static void mark_common(struct data *data, struct commit *c)
+{
+	struct commit_list *p;
+
+	if (c->object.flags & COMMON)
+		return;
+	c->object.flags |= COMMON;
+	if (!(c->object.flags & POPPED))
+		data->non_common_revs--;
+
+	if (!c->object.parsed)
+		return;
+	for (p = c->parents; p; p = p->next) {
+		if (p->item->object.flags & SEEN)
+			mark_common(data, p->item);
+	}
+}
+
+/*
+ * Ensure that the priority queue has an entry for to_push, and ensure that the
+ * entry has the correct flags and ttl.
+ *
+ * This function returns 1 if an entry was found or created, and 0 otherwise
+ * (because the entry for this commit had already been popped).
+ */
+static int push_parent(struct data *data, struct entry *entry,
+		       struct commit *to_push)
+{
+	struct entry *parent_entry;
+
+	if (to_push->object.flags & SEEN) {
+		int i;
+		if (to_push->object.flags & POPPED)
+			/*
+			 * The entry for this commit has already been popped,
+			 * due to clock skew. Pretend that this parent does not
+			 * exist.
+			 */
+			return 0;
+		/*
+		 * Find the existing entry and use it.
+		 */
+		for (i = 0; i < data->rev_list.nr; i++) {
+			parent_entry = data->rev_list.array[i].data;
+			if (parent_entry->commit == to_push)
+				goto parent_found;
+		}
+		BUG("missing parent in priority queue");
+parent_found:
+		;
+	} else {
+		parent_entry = rev_list_push(data, to_push, 0);
+	}
+
+	if (entry->commit->object.flags & (COMMON | ADVERTISED)) {
+		mark_common(data, to_push);
+	} else {
+		uint16_t new_original_ttl = entry->ttl
+			? entry->original_ttl : entry->original_ttl * 3 / 2 + 1;
+		uint16_t new_ttl = entry->ttl
+			? entry->ttl - 1 : new_original_ttl;
+		if (parent_entry->original_ttl < new_original_ttl) {
+			parent_entry->original_ttl = new_original_ttl;
+			parent_entry->ttl = new_ttl;
+		}
+	}
+
+	return 1;
+}
+
+static const struct object_id *get_rev(struct data *data)
+{
+	struct commit *to_send = NULL;
+
+	while (to_send == NULL) {
+		struct entry *entry;
+		struct commit *commit;
+		struct commit_list *p;
+		int parent_pushed = 0;
+
+		if (data->rev_list.nr == 0 || data->non_common_revs == 0)
+			return NULL;
+
+		entry = prio_queue_get(&data->rev_list);
+		commit = entry->commit;
+		commit->object.flags |= POPPED;
+		if (!(commit->object.flags & COMMON))
+			data->non_common_revs--;
+
+		if (!(commit->object.flags & COMMON) && !entry->ttl)
+			to_send = commit;
+
+		parse_commit(commit);
+		for (p = commit->parents; p; p = p->next)
+			parent_pushed |= push_parent(data, entry, p->item);
+
+		if (!(commit->object.flags & COMMON) && !parent_pushed)
+			/*
+			 * This commit has no parents, or all of its parents
+			 * have already been popped (due to clock skew), so send
+			 * it anyway.
+			 */
+			to_send = commit;
+
+		free(entry);
+	}
+
+	return &to_send->object.oid;
+}
+
+static void known_common(struct fetch_negotiator *n, struct commit *c)
+{
+	if (c->object.flags & SEEN)
+		return;
+	rev_list_push(n->data, c, ADVERTISED);
+}
+
+static void add_tip(struct fetch_negotiator *n, struct commit *c)
+{
+	n->known_common = NULL;
+	if (c->object.flags & SEEN)
+		return;
+	rev_list_push(n->data, c, 0);
+}
+
+static const struct object_id *next(struct fetch_negotiator *n)
+{
+	n->known_common = NULL;
+	n->add_tip = NULL;
+	return get_rev(n->data);
+}
+
+static int ack(struct fetch_negotiator *n, struct commit *c)
+{
+	int known_to_be_common = !!(c->object.flags & COMMON);
+	if (!(c->object.flags & SEEN))
+		die("received ack for commit %s not sent as 'have'\n",
+		    oid_to_hex(&c->object.oid));
+	mark_common(n->data, c);
+	return known_to_be_common;
+}
+
+static void release(struct fetch_negotiator *n)
+{
+	clear_prio_queue(&((struct data *)n->data)->rev_list);
+	FREE_AND_NULL(n->data);
+}
+
+void skipping_negotiator_init(struct fetch_negotiator *negotiator)
+{
+	struct data *data;
+	negotiator->known_common = known_common;
+	negotiator->add_tip = add_tip;
+	negotiator->next = next;
+	negotiator->ack = ack;
+	negotiator->release = release;
+	negotiator->data = data = xcalloc(1, sizeof(*data));
+	data->rev_list.compare = compare;
+
+	if (marked)
+		for_each_ref(clear_marks, NULL);
+	marked = 1;
+}
diff --git a/negotiator/skipping.h b/negotiator/skipping.h
new file mode 100644
index 0000000000..d7dfa6c6e4
--- /dev/null
+++ b/negotiator/skipping.h
@@ -0,0 +1,8 @@
+#ifndef NEGOTIATOR_SKIPPING_H
+#define NEGOTIATOR_SKIPPING_H
+
+struct fetch_negotiator;
+
+void skipping_negotiator_init(struct fetch_negotiator *negotiator);
+
+#endif
diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
new file mode 100755
index 0000000000..8c417f435f
--- /dev/null
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -0,0 +1,179 @@
+#!/bin/sh
+
+test_description='test skipping fetch negotiator'
+. ./test-lib.sh
+
+have_sent () {
+	while test "$#" -ne 0
+	do
+		grep "fetch> have $(git -C client rev-parse $1)" trace
+		if test $? -ne 0
+		then
+			echo "No have $(git -C client rev-parse $1) ($1)"
+			return 1
+		fi
+		shift
+	done
+}	
+
+have_not_sent () {
+	while test "$#" -ne 0
+	do
+		grep "fetch> have $(git -C client rev-parse $1)" trace
+		if test $? -eq 0
+		then
+			return 1
+		fi
+		shift
+	done
+}
+
+test_expect_success 'commits with no parents are sent regardless of skip distance' '
+	git init server &&
+	test_commit -C server to_fetch &&
+
+	git init client &&
+	for i in $(seq 7)
+	do
+		test_commit -C client c$i
+	done &&
+
+	# We send: "c7" (skip 1) "c5" (skip 2) "c2" (skip 4). After that, since
+	# "c1" has no parent, it is still sent as "have" even though it would
+	# normally be skipped.
+	test_config -C client fetch.negotiationalgorithm skipping &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
+	have_sent c7 c5 c2 c1 &&
+	have_not_sent c6 c4 c3
+'
+
+test_expect_success 'when two skips collide, favor the larger one' '
+	rm -rf server client trace &&
+	git init server &&
+	test_commit -C server to_fetch &&
+
+	git init client &&
+	for i in $(seq 11)
+	do
+		test_commit -C client c$i
+	done &&
+	git -C client checkout c5 &&
+	test_commit -C client c5side &&
+
+	# Before reaching c5, we send "c5side" (skip 1) and "c11" (skip 1) "c9"
+	# (skip 2) "c6" (skip 4). The larger skip (skip 4) takes precedence, so
+	# the next "have" sent will be "c1" (from "c6" skip 4) and not "c4"
+	# (from "c5side" skip 1).
+	test_config -C client fetch.negotiationalgorithm skipping &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
+	have_sent c5side c11 c9 c6 c1 &&
+	have_not_sent c10 c8 c7 c5 c4 c3 c2
+'
+
+test_expect_success 'use ref advertisement to filter out commits' '
+	rm -rf server client trace &&
+	git init server &&
+	test_commit -C server c1 &&
+	test_commit -C server c2 &&
+	test_commit -C server c3 &&
+	git -C server tag -d c1 c2 c3 &&
+
+	git clone server client &&
+	test_commit -C client c4 &&
+	test_commit -C client c5 &&
+	git -C client checkout c4^^ &&
+	test_commit -C client c2side &&
+
+	git -C server checkout --orphan anotherbranch &&
+	test_commit -C server to_fetch &&
+
+	# The server advertising "c3" (as "refs/heads/master") means that we do
+	# not need to send any ancestors of "c3", but we still need to send "c3"
+	# itself.
+	test_config -C client fetch.negotiationalgorithm skipping &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch origin to_fetch &&
+	have_sent c5 c4^ c2side &&
+	have_not_sent c4 c4^^ c4^^^
+'
+
+test_expect_success 'handle clock skew' '
+	rm -rf server client trace &&
+	git init server &&
+	test_commit -C server to_fetch &&
+
+	git init client &&
+
+	# 2 regular commits
+	test_tick=2000000000 &&
+	test_commit -C client c1 &&
+	test_commit -C client c2 &&
+
+	# 4 old commits
+	test_tick=1000000000 &&
+	git -C client checkout c1 &&
+	test_commit -C client old1 &&
+	test_commit -C client old2 &&
+	test_commit -C client old3 &&
+	test_commit -C client old4 &&
+
+	# "c2" and "c1" are popped first, then "old4" to "old1". "old1" would
+	# normally be skipped, but is treated as a commit without a parent here
+	# and sent, because (due to clock skew) its only parent has already been
+	# popped off the priority queue.
+	test_config -C client fetch.negotiationalgorithm skipping &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
+	have_sent c2 c1 old4 old2 old1 &&
+	have_not_sent old3
+'
+
+test_expect_success 'do not send "have" with ancestors of commits that server ACKed' '
+	rm -rf server client trace &&
+	git init server &&
+	test_commit -C server to_fetch &&
+
+	git init client &&
+	for i in $(seq 8)
+	do
+		git -C client checkout --orphan b$i &&
+		test_commit -C client b$i.c0
+	done &&
+	for j in $(seq 19)
+	do
+		for i in $(seq 8)
+		do
+			git -C client checkout b$i &&
+			test_commit -C client b$i.c$j
+		done
+	done &&
+
+	# Copy this branch over to the server and add a commit on it so that it
+	# is reachable but not advertised.
+	git -C server fetch --no-tags "$(pwd)/client" b1:refs/heads/b1 &&
+	git -C server checkout b1 &&
+	test_commit -C server commit-on-b1 &&
+
+	test_config -C client fetch.negotiationalgorithm skipping &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" to_fetch &&
+	grep "  fetch" trace &&
+
+	# fetch-pack sends 2 requests each containing 16 "have" lines before
+	# processing the first response. In these 2 requests, 4 commits from
+	# each branch are sent. Just check the first branch.
+	have_sent b1.c19 b1.c17 b1.c14 b1.c9 &&
+	have_not_sent b1.c18 b1.c16 b1.c15 b1.c13 b1.c12 b1.c11 b1.c10 &&
+
+	# While fetch-pack is processing the first response, it should read that
+	# the server ACKs b1.c19 and b1.c17.
+	grep "fetch< ACK $(git -C client rev-parse b1.c19) common" trace &&
+	grep "fetch< ACK $(git -C client rev-parse b1.c17) common" trace &&
+
+	# fetch-pack should thus not send any more commits in the b1 branch, but
+	# should still send the others (in this test, just check b2).
+	for i in $(seq 0 8)
+	do
+		have_not_sent b1.c$i
+	done &&
+	have_sent b2.c1 b2.c0
+'
+
+test_done
-- 
2.18.0.203.gfac676dfb9-goog

