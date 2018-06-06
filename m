Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 785E71F403
	for <e@80x24.org>; Wed,  6 Jun 2018 20:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752872AbeFFUrn (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 16:47:43 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41653 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeFFUrg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 16:47:36 -0400
Received: by mail-pg0-f65.google.com with SMTP id l65-v6so3572237pgl.8
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 13:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oZ1pT/KaUOnL212o0MHK9FUxFLHdTZ9z+CsVl2f4yJ4=;
        b=o4TJcivO9NqY4G3decx8lfQwCEieFmEd0PsXkdE3Tr1T27nty1YqtBc8cun/zw6QC4
         GRabQmcyIJWV7DoMqYDH2f/4By+yEcdQpMvYjdUPhkcrjf6SrWk+Fj6UO5r5pyg+bjmO
         YeuHyvakoy5KJZy8j4od0N14eYMecobq//aeMkMe5CcTLWJyfgNB0v0768fxT+ASI3rD
         473nKaz51ICH7zk9zmHbJBJYlg7og6P9X7cYUEC4H2zPVnT3yf5jFv5QjqZfAIav8GPr
         Trc35Eb8Q3Yt8Mw+tPp8mVwc7H/+CVCdGqBS1ETOeKWEM4nkWyYW6kMqMur54MKem5qW
         D4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oZ1pT/KaUOnL212o0MHK9FUxFLHdTZ9z+CsVl2f4yJ4=;
        b=r7HACGwuAuIIR9KizqWtmRRdJ9U25OMOB9vWcbBtZ9dYFMFfWI66tk02jl2H5DDkXm
         RJ4IvDX8rO/v3ErJjWW3zoRAqLsnBASv2cjBq3+zcsNX+0H39yL/FA4h6hraYNIJ5Nv9
         P3PEQkAan5jXnj/xX7RKXOxL7KohY4G0U22kV1mY4ejKUt6q0uHFk2APQl+ziQ7+4pTa
         zCvpdBpHVeTRl68Qq73XF0/9IEz0a9BayKgqRfDI92z4gcJ5O7xnoV/J0VAHZ7wOFjVG
         4grwhNV3GBCE4KPla0ppXi5IS3AX8DGRE2ZN8bm9IMZVy9gD3NIUoAKAdDXYU4V4izSk
         TuUA==
X-Gm-Message-State: APt69E2I6GmUb8LeRNmo4CNmabOWY80FwHn6dyddnQb82rt36zNHHV3L
        Hr9n20Gb0LmatNIX0vuzBk6CA8kMJVk=
X-Google-Smtp-Source: ADUXVKIuHEW4LYui/U+N6nmh+FgcXnd92pxAyOOQGrK+9aJqBBNeWXu8WM1jv+afG6RrLcWGkAgwEQ==
X-Received: by 2002:a65:5686:: with SMTP id v6-v6mr3828851pgs.141.1528318054034;
        Wed, 06 Jun 2018 13:47:34 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id m1-v6sm20703323pfh.155.2018.06.06.13.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 13:47:32 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com
Subject: [PATCH v2 7/8] fetch-pack: introduce negotiator API
Date:   Wed,  6 Jun 2018 13:47:13 -0700
Message-Id: <0afa68a31d2b0dea1ea2d30f0452c31bbec8356f.1528317619.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1528317619.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com> <cover.1528317619.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the new files fetch-negotiator.{h,c}, which contains an API
behind which the details of negotiation are abstracted. Currently, only
one algorithm is available: the existing one.

This patch is written to be easily reviewed: static functions are
moved verbatim from fetch-pack.c to negotiator/default.c, and it can be
seen that the lines replaced by negotiator->X() calls are present in the
X() functions respectively.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Makefile             |   2 +
 fetch-negotiator.c   |   8 ++
 fetch-negotiator.h   |  57 ++++++++++++
 fetch-pack.c         | 206 +++++++++----------------------------------
 negotiator/default.c | 176 ++++++++++++++++++++++++++++++++++++
 negotiator/default.h |   8 ++
 object.h             |   3 +-
 7 files changed, 297 insertions(+), 163 deletions(-)
 create mode 100644 fetch-negotiator.c
 create mode 100644 fetch-negotiator.h
 create mode 100644 negotiator/default.c
 create mode 100644 negotiator/default.h

diff --git a/Makefile b/Makefile
index 1d27f3636..96f84d1dc 100644
--- a/Makefile
+++ b/Makefile
@@ -859,6 +859,7 @@ LIB_OBJS += ewah/ewah_bitmap.o
 LIB_OBJS += ewah/ewah_io.o
 LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec-cmd.o
+LIB_OBJS += fetch-negotiator.o
 LIB_OBJS += fetch-object.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fsck.o
@@ -891,6 +892,7 @@ LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += mergesort.o
 LIB_OBJS += name-hash.o
+LIB_OBJS += negotiator/default.o
 LIB_OBJS += notes.o
 LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
diff --git a/fetch-negotiator.c b/fetch-negotiator.c
new file mode 100644
index 000000000..2675d120f
--- /dev/null
+++ b/fetch-negotiator.c
@@ -0,0 +1,8 @@
+#include "git-compat-util.h"
+#include "fetch-negotiator.h"
+#include "negotiator/default.h"
+
+void fetch_negotiator_init(struct fetch_negotiator *negotiator)
+{
+	default_negotiator_init(negotiator);
+}
diff --git a/fetch-negotiator.h b/fetch-negotiator.h
new file mode 100644
index 000000000..b1290aa9c
--- /dev/null
+++ b/fetch-negotiator.h
@@ -0,0 +1,57 @@
+#ifndef FETCH_NEGOTIATOR
+#define FETCH_NEGOTIATOR
+
+struct commit;
+
+/*
+ * An object that supplies the information needed to negotiate the contents of
+ * the to-be-sent packfile during a fetch.
+ *
+ * To set up the negotiator, call fetch_negotiator_init(), then known_common()
+ * (0 or more times), then add_tip() (0 or more times).
+ *
+ * Then, when "have" lines are required, call next(). Call ack() to report what
+ * the server tells us.
+ *
+ * Once negotiation is done, call release(). The negotiator then cannot be used
+ * (unless reinitialized with fetch_negotiator_init()).
+ */
+struct fetch_negotiator {
+	/*
+	 * Before negotiation starts, indicate that the server is known to have
+	 * this commit.
+	 */
+	void (*known_common)(struct fetch_negotiator *, struct commit *);
+
+	/*
+	 * Once this function is invoked, known_common() cannot be invoked any
+	 * more.
+	 *
+	 * Indicate that this commit and all its ancestors are to be checked
+	 * for commonality with the server.
+	 */
+	void (*add_tip)(struct fetch_negotiator *, struct commit *);
+
+	/*
+	 * Once this function is invoked, known_common() and add_tip() cannot
+	 * be invoked any more.
+	 *
+	 * Return the next commit that the client should send as a "have" line.
+	 */
+	const struct object_id *(*next)(struct fetch_negotiator *);
+
+	/*
+	 * Inform the negotiator that the server has the given commit. This
+	 * method must only be called on commits returned by next().
+	 */
+	int (*ack)(struct fetch_negotiator *, struct commit *);
+
+	void (*release)(struct fetch_negotiator *);
+
+	/* internal use */
+	void *data;
+};
+
+void fetch_negotiator_init(struct fetch_negotiator *negotiator);
+
+#endif
diff --git a/fetch-pack.c b/fetch-pack.c
index 4a4ec4da3..ad6f7ac32 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -15,10 +15,10 @@
 #include "connect.h"
 #include "transport.h"
 #include "version.h"
-#include "prio-queue.h"
 #include "sha1-array.h"
 #include "oidset.h"
 #include "packfile.h"
+#include "fetch-negotiator.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -36,13 +36,7 @@ static const char *alternate_shallow_file;
 
 /* Remember to update object flag allocation in object.h */
 #define COMPLETE	(1U << 0)
-#define COMMON		(1U << 1)
-#define COMMON_REF	(1U << 2)
-#define SEEN		(1U << 3)
-#define POPPED		(1U << 4)
-#define ALTERNATE	(1U << 5)
-
-static int marked;
+#define ALTERNATE	(1U << 1)
 
 /*
  * After sending this many "have"s if we do not get any new ACK , we
@@ -50,11 +44,6 @@ static int marked;
  */
 #define MAX_IN_VAIN 256
 
-struct data {
-	struct prio_queue rev_list;
-	int non_common_revs;
-};
-
 static int multi_ack, use_sideband;
 /* Allow specifying sha1 if it is a ref tip. */
 #define ALLOW_TIP_SHA1	01
@@ -97,8 +86,8 @@ static void cache_one_alternate(const char *refname,
 	cache->items[cache->nr++] = obj;
 }
 
-static void for_each_cached_alternate(struct data *data,
-				      void (*cb)(struct data *, struct object *))
+static void for_each_cached_alternate(struct fetch_negotiator *negotiator,
+				      void (*cb)(struct fetch_negotiator *, struct object *))
 {
 	static int initialized;
 	static struct alternate_object_cache cache;
@@ -110,31 +99,17 @@ static void for_each_cached_alternate(struct data *data,
 	}
 
 	for (i = 0; i < cache.nr; i++)
-		cb(data, cache.items[i]);
-}
-
-static void rev_list_push(struct data *data, struct commit *commit, int mark)
-{
-	if (!(commit->object.flags & mark)) {
-		commit->object.flags |= mark;
-
-		if (parse_commit(commit))
-			return;
-
-		prio_queue_put(&data->rev_list, commit);
-
-		if (!(commit->object.flags & COMMON))
-			data->non_common_revs++;
-	}
+		cb(negotiator, cache.items[i]);
 }
 
-static int rev_list_insert_ref(struct data *data, const char *refname,
+static int rev_list_insert_ref(struct fetch_negotiator *negotiator,
+			       const char *refname,
 			       const struct object_id *oid)
 {
 	struct object *o = deref_tag(parse_object(oid), refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
-		rev_list_push(data, (struct commit *)o, SEEN);
+		negotiator->add_tip(negotiator, (struct commit *)o);
 
 	return 0;
 }
@@ -145,97 +120,6 @@ static int rev_list_insert_ref_oid(const char *refname, const struct object_id *
 	return rev_list_insert_ref(cb_data, refname, oid);
 }
 
-static int clear_marks(const char *refname, const struct object_id *oid,
-		       int flag, void *cb_data)
-{
-	struct object *o = deref_tag(parse_object(oid), refname, 0);
-
-	if (o && o->type == OBJ_COMMIT)
-		clear_commit_marks((struct commit *)o,
-				   COMMON | COMMON_REF | SEEN | POPPED);
-	return 0;
-}
-
-/*
-   This function marks a rev and its ancestors as common.
-   In some cases, it is desirable to mark only the ancestors (for example
-   when only the server does not yet know that they are common).
-*/
-
-static void mark_common(struct data *data, struct commit *commit,
-		int ancestors_only, int dont_parse)
-{
-	if (commit != NULL && !(commit->object.flags & COMMON)) {
-		struct object *o = (struct object *)commit;
-
-		if (!ancestors_only)
-			o->flags |= COMMON;
-
-		if (!(o->flags & SEEN))
-			rev_list_push(data, commit, SEEN);
-		else {
-			struct commit_list *parents;
-
-			if (!ancestors_only && !(o->flags & POPPED))
-				data->non_common_revs--;
-			if (!o->parsed && !dont_parse)
-				if (parse_commit(commit))
-					return;
-
-			for (parents = commit->parents;
-					parents;
-					parents = parents->next)
-				mark_common(data, parents->item, 0, dont_parse);
-		}
-	}
-}
-
-/*
-  Get the next rev to send, ignoring the common.
-*/
-
-static const struct object_id *get_rev(struct data *data)
-{
-	struct commit *commit = NULL;
-
-	while (commit == NULL) {
-		unsigned int mark;
-		struct commit_list *parents;
-
-		if (data->rev_list.nr == 0 || data->non_common_revs == 0)
-			return NULL;
-
-		commit = prio_queue_get(&data->rev_list);
-		parse_commit(commit);
-		parents = commit->parents;
-
-		commit->object.flags |= POPPED;
-		if (!(commit->object.flags & COMMON))
-			data->non_common_revs--;
-
-		if (commit->object.flags & COMMON) {
-			/* do not send "have", and ignore ancestors */
-			commit = NULL;
-			mark = COMMON | SEEN;
-		} else if (commit->object.flags & COMMON_REF)
-			/* send "have", and ignore ancestors */
-			mark = COMMON | SEEN;
-		else
-			/* send "have", also for its ancestors */
-			mark = SEEN;
-
-		while (parents) {
-			if (!(parents->item->object.flags & SEEN))
-				rev_list_push(data, parents->item, mark);
-			if (mark & COMMON)
-				mark_common(data, parents->item, 1, 0);
-			parents = parents->next;
-		}
-	}
-
-	return &commit->object.oid;
-}
-
 enum ack_type {
 	NAK = 0,
 	ACK,
@@ -302,9 +186,10 @@ static void send_request(struct fetch_pack_args *args,
 		write_or_die(fd, buf->buf, buf->len);
 }
 
-static void insert_one_alternate_object(struct data *data, struct object *obj)
+static void insert_one_alternate_object(struct fetch_negotiator *negotiator,
+					struct object *obj)
 {
-	rev_list_insert_ref(data, NULL, &obj->oid);
+	rev_list_insert_ref(negotiator, NULL, &obj->oid);
 }
 
 #define INITIAL_FLUSH 16
@@ -327,7 +212,8 @@ static int next_flush(int stateless_rpc, int count)
 	return count;
 }
 
-static int find_common(struct data *data, struct fetch_pack_args *args,
+static int find_common(struct fetch_negotiator *negotiator,
+		       struct fetch_pack_args *args,
 		       int fd[2], struct object_id *result_oid,
 		       struct ref *refs)
 {
@@ -343,8 +229,8 @@ static int find_common(struct data *data, struct fetch_pack_args *args,
 	if (args->stateless_rpc && multi_ack == 1)
 		die(_("--stateless-rpc requires multi_ack_detailed"));
 
-	for_each_ref(rev_list_insert_ref_oid, data);
-	for_each_cached_alternate(data, insert_one_alternate_object);
+	for_each_ref(rev_list_insert_ref_oid, negotiator);
+	for_each_cached_alternate(negotiator, insert_one_alternate_object);
 
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
@@ -462,7 +348,7 @@ static int find_common(struct data *data, struct fetch_pack_args *args,
 	retval = -1;
 	if (args->no_dependents)
 		goto done;
-	while ((oid = get_rev(data))) {
+	while ((oid = negotiator->next(negotiator))) {
 		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
 		print_verbose(args, "have %s", oid_to_hex(oid));
 		in_vain++;
@@ -502,8 +388,7 @@ static int find_common(struct data *data, struct fetch_pack_args *args,
 					int was_common;
 					if (!commit)
 						die(_("invalid commit %s"), oid_to_hex(result_oid));
-					was_common = commit->object.flags & COMMON;
-					mark_common(data, commit, 0, 1);
+					was_common = negotiator->ack(negotiator, commit);
 					if (args->stateless_rpc
 					 && ack == ACK_common
 					 && !was_common) {
@@ -712,7 +597,8 @@ static void filter_refs(struct fetch_pack_args *args,
 	*refs = newlist;
 }
 
-static void mark_alternate_complete(struct data *unused, struct object *obj)
+static void mark_alternate_complete(struct fetch_negotiator *unused,
+				    struct object *obj)
 {
 	mark_complete(&obj->oid);
 }
@@ -749,7 +635,7 @@ static int add_loose_objects_to_set(const struct object_id *oid,
  * earliest commit time of the objects in refs that are commits and that we know
  * the commit time of.
  */
-static void mark_complete_and_common_ref(struct data *data,
+static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 					 struct fetch_pack_args *args,
 					 struct ref **refs)
 {
@@ -818,12 +704,8 @@ static void mark_complete_and_common_ref(struct data *data,
 			if (!o || o->type != OBJ_COMMIT || !(o->flags & COMPLETE))
 				continue;
 
-			if (!(o->flags & SEEN)) {
-				rev_list_push(data, (struct commit *)o,
-					      COMMON_REF | SEEN);
-
-				mark_common(data, (struct commit *)o, 1, 1);
-			}
+			negotiator->known_common(negotiator,
+						 (struct commit *)o);
 		}
 	}
 
@@ -1005,7 +887,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	struct object_id oid;
 	const char *agent_feature;
 	int agent_len;
-	struct data data = { { compare_commits_by_commit_date } };
+	struct fetch_negotiator negotiator;
+	fetch_negotiator_init(&negotiator);
 
 	sort_ref_list(&ref, ref_compare_name);
 	QSORT(sought, nr_sought, cmp_ref_by_name);
@@ -1078,16 +961,13 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (!server_supports("deepen-relative") && args->deepen_relative)
 		die(_("Server does not support --deepen"));
 
-	if (marked)
-		for_each_ref(clear_marks, NULL);
-	marked = 1;
-	mark_complete_and_common_ref(&data, args, &ref);
+	mark_complete_and_common_ref(&negotiator, args, &ref);
 	filter_refs(args, &ref, sought, nr_sought);
 	if (everything_local(args, &ref)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
-	if (find_common(&data, args, fd, &oid, ref) < 0)
+	if (find_common(&negotiator, args, fd, &oid, ref) < 0)
 		if (!args->keep_pack)
 			/* When cloning, it is not unusual to have
 			 * no common commit.
@@ -1107,6 +987,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		die(_("git fetch-pack: fetch failed."));
 
  all_done:
+	negotiator.release(&negotiator);
 	return ref;
 }
 
@@ -1168,14 +1049,15 @@ static void add_common(struct strbuf *req_buf, struct oidset *common)
 	}
 }
 
-static int add_haves(struct data *data, struct strbuf *req_buf,
+static int add_haves(struct fetch_negotiator *negotiator,
+		     struct strbuf *req_buf,
 		     int *haves_to_send, int *in_vain)
 {
 	int ret = 0;
 	int haves_added = 0;
 	const struct object_id *oid;
 
-	while ((oid = get_rev(data))) {
+	while ((oid = negotiator->next(negotiator))) {
 		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
 		if (++haves_added >= *haves_to_send)
 			break;
@@ -1194,7 +1076,7 @@ static int add_haves(struct data *data, struct strbuf *req_buf,
 	return ret;
 }
 
-static int send_fetch_request(struct data *data, int fd_out,
+static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      const struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
 			      int *haves_to_send, int *in_vain)
@@ -1251,7 +1133,7 @@ static int send_fetch_request(struct data *data, int fd_out,
 		add_common(&req_buf, common);
 
 		/* Add initial haves */
-		ret = add_haves(data, &req_buf, haves_to_send, in_vain);
+		ret = add_haves(negotiator, &req_buf, haves_to_send, in_vain);
 	}
 
 	/* Send request */
@@ -1288,7 +1170,8 @@ static int process_section_header(struct packet_reader *reader,
 	return ret;
 }
 
-static int process_acks(struct data *data, struct packet_reader *reader,
+static int process_acks(struct fetch_negotiator *negotiator,
+			struct packet_reader *reader,
 			struct oidset *common)
 {
 	/* received */
@@ -1308,7 +1191,7 @@ static int process_acks(struct data *data, struct packet_reader *reader,
 				struct commit *commit;
 				oidset_insert(common, &oid);
 				commit = lookup_commit(&oid);
-				mark_common(data, commit, 0, 1);
+				negotiator->ack(negotiator, commit);
 			}
 			continue;
 		}
@@ -1386,7 +1269,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct packet_reader reader;
 	int in_vain = 0;
 	int haves_to_send = INITIAL_FLUSH;
-	struct data data = { { compare_commits_by_commit_date } };
+	struct fetch_negotiator negotiator;
+	fetch_negotiator_init(&negotiator);
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE);
 
@@ -1402,24 +1286,21 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			if (args->depth > 0 || args->deepen_since || args->deepen_not)
 				args->deepen = 1;
 
-			if (marked)
-				for_each_ref(clear_marks, NULL);
-			marked = 1;
-
 			/* Filter 'ref' by 'sought' and those that aren't local */
-			mark_complete_and_common_ref(&data, args, &ref);
+			mark_complete_and_common_ref(&negotiator, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);
 			if (everything_local(args, &ref))
 				state = FETCH_DONE;
 			else
 				state = FETCH_SEND_REQUEST;
 
-			for_each_ref(rev_list_insert_ref_oid, &data);
-			for_each_cached_alternate(&data,
+			for_each_ref(rev_list_insert_ref_oid, &negotiator);
+			for_each_cached_alternate(&negotiator,
 						  insert_one_alternate_object);
 			break;
 		case FETCH_SEND_REQUEST:
-			if (send_fetch_request(&data, fd[1], args, ref, &common,
+			if (send_fetch_request(&negotiator, fd[1], args, ref,
+					       &common,
 					       &haves_to_send, &in_vain))
 				state = FETCH_GET_PACK;
 			else
@@ -1427,7 +1308,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			break;
 		case FETCH_PROCESS_ACKS:
 			/* Process ACKs/NAKs */
-			switch (process_acks(&data, &reader, &common)) {
+			switch (process_acks(&negotiator, &reader, &common)) {
 			case 2:
 				state = FETCH_GET_PACK;
 				break;
@@ -1456,6 +1337,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		}
 	}
 
+	negotiator.release(&negotiator);
 	oidset_clear(&common);
 	return ref;
 }
diff --git a/negotiator/default.c b/negotiator/default.c
new file mode 100644
index 000000000..b8f45cf78
--- /dev/null
+++ b/negotiator/default.c
@@ -0,0 +1,176 @@
+#include "cache.h"
+#include "default.h"
+#include "../commit.h"
+#include "../fetch-negotiator.h"
+#include "../prio-queue.h"
+#include "../refs.h"
+#include "../tag.h"
+
+/* Remember to update object flag allocation in object.h */
+#define COMMON		(1U << 2)
+#define COMMON_REF	(1U << 3)
+#define SEEN		(1U << 4)
+#define POPPED		(1U << 5)
+
+static int marked;
+
+struct data {
+	struct prio_queue rev_list;
+	int non_common_revs;
+};
+
+static void rev_list_push(struct data *data, struct commit *commit, int mark)
+{
+	if (!(commit->object.flags & mark)) {
+		commit->object.flags |= mark;
+
+		if (parse_commit(commit))
+			return;
+
+		prio_queue_put(&data->rev_list, commit);
+
+		if (!(commit->object.flags & COMMON))
+			data->non_common_revs++;
+	}
+}
+
+static int clear_marks(const char *refname, const struct object_id *oid,
+		       int flag, void *cb_data)
+{
+	struct object *o = deref_tag(parse_object(oid), refname, 0);
+
+	if (o && o->type == OBJ_COMMIT)
+		clear_commit_marks((struct commit *)o,
+				   COMMON | COMMON_REF | SEEN | POPPED);
+	return 0;
+}
+
+/*
+   This function marks a rev and its ancestors as common.
+   In some cases, it is desirable to mark only the ancestors (for example
+   when only the server does not yet know that they are common).
+*/
+
+static void mark_common(struct data *data, struct commit *commit,
+		int ancestors_only, int dont_parse)
+{
+	if (commit != NULL && !(commit->object.flags & COMMON)) {
+		struct object *o = (struct object *)commit;
+
+		if (!ancestors_only)
+			o->flags |= COMMON;
+
+		if (!(o->flags & SEEN))
+			rev_list_push(data, commit, SEEN);
+		else {
+			struct commit_list *parents;
+
+			if (!ancestors_only && !(o->flags & POPPED))
+				data->non_common_revs--;
+			if (!o->parsed && !dont_parse)
+				if (parse_commit(commit))
+					return;
+
+			for (parents = commit->parents;
+					parents;
+					parents = parents->next)
+				mark_common(data, parents->item, 0, dont_parse);
+		}
+	}
+}
+
+/*
+  Get the next rev to send, ignoring the common.
+*/
+
+static const struct object_id *get_rev(struct data *data)
+{
+	struct commit *commit = NULL;
+
+	while (commit == NULL) {
+		unsigned int mark;
+		struct commit_list *parents;
+
+		if (data->rev_list.nr == 0 || data->non_common_revs == 0)
+			return NULL;
+
+		commit = prio_queue_get(&data->rev_list);
+		parse_commit(commit);
+		parents = commit->parents;
+
+		commit->object.flags |= POPPED;
+		if (!(commit->object.flags & COMMON))
+			data->non_common_revs--;
+
+		if (commit->object.flags & COMMON) {
+			/* do not send "have", and ignore ancestors */
+			commit = NULL;
+			mark = COMMON | SEEN;
+		} else if (commit->object.flags & COMMON_REF)
+			/* send "have", and ignore ancestors */
+			mark = COMMON | SEEN;
+		else
+			/* send "have", also for its ancestors */
+			mark = SEEN;
+
+		while (parents) {
+			if (!(parents->item->object.flags & SEEN))
+				rev_list_push(data, parents->item, mark);
+			if (mark & COMMON)
+				mark_common(data, parents->item, 1, 0);
+			parents = parents->next;
+		}
+	}
+
+	return &commit->object.oid;
+}
+
+static void known_common(struct fetch_negotiator *n, struct commit *c)
+{
+	if (!(c->object.flags & SEEN)) {
+		rev_list_push(n->data, c, COMMON_REF | SEEN);
+		mark_common(n->data, c, 1, 1);
+	}
+}
+
+static void add_tip(struct fetch_negotiator *n, struct commit *c)
+{
+	n->known_common = NULL;
+	rev_list_push(n->data, c, SEEN);
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
+	mark_common(n->data, c, 0, 1);
+	return known_to_be_common;
+}
+
+static void release(struct fetch_negotiator *n)
+{
+	clear_prio_queue(&((struct data *)n->data)->rev_list);
+	FREE_AND_NULL(n->data);
+}
+
+void default_negotiator_init(struct fetch_negotiator *negotiator)
+{
+	struct data *data;
+	negotiator->known_common = known_common;
+	negotiator->add_tip = add_tip;
+	negotiator->next = next;
+	negotiator->ack = ack;
+	negotiator->release = release;
+	negotiator->data = data = xcalloc(1, sizeof(*data));
+	data->rev_list.compare = compare_commits_by_commit_date;
+
+	if (marked)
+		for_each_ref(clear_marks, NULL);
+	marked = 1;
+}
diff --git a/negotiator/default.h b/negotiator/default.h
new file mode 100644
index 000000000..d23a8f2fb
--- /dev/null
+++ b/negotiator/default.h
@@ -0,0 +1,8 @@
+#ifndef NEGOTIATOR_DEFAULT_H
+#define NEGOTIATOR_DEFAULT_H
+
+struct fetch_negotiator;
+
+void default_negotiator_init(struct fetch_negotiator *negotiator);
+
+#endif
diff --git a/object.h b/object.h
index 5c1395500..7db4941d6 100644
--- a/object.h
+++ b/object.h
@@ -28,7 +28,8 @@ struct object_array {
 /*
  * object flag allocation:
  * revision.h:               0---------10                                26
- * fetch-pack.c:             0----5
+ * fetch-pack.c:             01
+ * negotiator/default.c:       2--5
  * walker.c:                 0-2
  * upload-pack.c:                4       11----------------19
  * builtin/blame.c:                        12-13
-- 
2.17.0.768.g1526ddbba1.dirty

