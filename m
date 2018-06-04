Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61CDC1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 17:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbeFDR37 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 13:29:59 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41863 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbeFDR34 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 13:29:56 -0400
Received: by mail-pg0-f65.google.com with SMTP id l65-v6so4368858pgl.8
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a2L0iNM7KWHIsGSMzVEqVkqLLc8rMstdCj7xn1rzdsM=;
        b=bTeTd9M9Nn+DyFiQyii/pfcjqsoI0HK2oszVYgE2gIlWLzTgqrZnRyeU0zvFAbIX9D
         KXorJhERSTeCHijQavg+oE16agEiy0TIDBJ2KPstio6GoUNYTkyMUh8QT2eXjXiUV9KY
         bomETT3xtemFlUnUJlfzq+e7cIqq9qIWhW+YwbSuTrRJgG0TGvHGUl3Heop7bVW7m+7J
         c/LaLMeCSqqcGomkdht9mKsE0TBaRalb1stZwUgBBdZy4G0Ce7lifoiJu09Bnb8SpXeU
         aiix1IJ+s/YKEHOyUsngl5hdnew5SqZNBRqdOgAnXxS3jLSJ1zFB8bS2Vyk3oQteE2fC
         Jamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a2L0iNM7KWHIsGSMzVEqVkqLLc8rMstdCj7xn1rzdsM=;
        b=hDfqqyvlEuuVlPgtYVweaplJnn8O6fzmxMiUqDC/hhWDRyM81Np4Hul4gByUxwSSAK
         gPv9sETGsdVMGbFvxQKgr8B/6cH2QP9KNb2yWe5g2LK4H0yK/d6pagDXe1JwAEEA20T1
         3HuSRhFnPH8KnvB1SG6NGSGOroRuBoEt88g5HX7eL5mK8mmR+3gfEo+pvFdt5OGWjkgi
         qsCla+RPg7zFWXsW68QKc1yGqP/JhzfokDMLmZJ5KkDIclM0eNLlRZmL9trRUeysDz0I
         gUOvteRDKyeFK4kSoG/VqbZQOj39t4LPR2I1sr4T4Fa7PfIxU36LwT0chHv/Zq9xwcZt
         MgqQ==
X-Gm-Message-State: APt69E1S6EktpGPzZ4wKq1aq/CNUYdwaL0zB2lGN5WK97FENCAwEPyAe
        S7T2l1ul+xb9hx1dc5fe6HaJ0Je8sPU=
X-Google-Smtp-Source: ADUXVKLeIl8lKLnWVUwTlz2X6DdGk2CpF2v0o5wztY0X3HnKL4MJ2MfIktNTIfefkL8QD6u/vfdoog==
X-Received: by 2002:a62:5d83:: with SMTP id n3-v6mr9939603pfj.68.1528133394613;
        Mon, 04 Jun 2018 10:29:54 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id x2-v6sm4491994pfn.11.2018.06.04.10.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 10:29:53 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        bmwill@google.com
Subject: [PATCH 6/6] fetch-pack: introduce negotiator API
Date:   Mon,  4 Jun 2018 10:29:36 -0700
Message-Id: <c7e504a4664bb6008de970671af13eda7d85dc5b.1527894919.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1527894919.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the new files fetch-negotiator.{h,c}, which contains an API
behind which the details of negotiation are abstracted. Currently, only
one algorithm is available: the existing one.

This patch is written to be more easily reviewed: static functions are
moved verbatim from fetch-pack.c to negotiator/default.c, and it can be
seen that the lines replaced by negotiator->X() calls are present in the
X() functions respectively.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Makefile             |   2 +
 fetch-negotiator.c   |   7 ++
 fetch-negotiator.h   |  45 ++++++++++
 fetch-pack.c         | 207 ++++++++++---------------------------------
 negotiator/default.c | 173 ++++++++++++++++++++++++++++++++++++
 negotiator/default.h |   8 ++
 object.h             |   3 +-
 7 files changed, 282 insertions(+), 163 deletions(-)
 create mode 100644 fetch-negotiator.c
 create mode 100644 fetch-negotiator.h
 create mode 100644 negotiator/default.c
 create mode 100644 negotiator/default.h

diff --git a/Makefile b/Makefile
index 4bca65383..8f1df08ac 100644
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
index 000000000..756c35d15
--- /dev/null
+++ b/fetch-negotiator.c
@@ -0,0 +1,7 @@
+#include "fetch-negotiator.h"
+#include "negotiator/default.h"
+
+void fetch_negotiator_init(struct fetch_negotiator *negotiator)
+{
+	default_negotiator_init(negotiator);
+}
diff --git a/fetch-negotiator.h b/fetch-negotiator.h
new file mode 100644
index 000000000..b717b80dd
--- /dev/null
+++ b/fetch-negotiator.h
@@ -0,0 +1,45 @@
+#ifndef FETCH_NEGOTIATOR
+#define FETCH_NEGOTIATOR
+
+#include "cache.h"
+#include "commit.h"
+
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
index 54dd3feb8..a399a62e1 100644
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
@@ -739,7 +625,7 @@ static int add_loose_objects_to_set(const struct object_id *oid,
 	return 0;
 }
 
-static int everything_local(struct data *data,
+static int everything_local(struct fetch_negotiator *negotiator,
 			    struct fetch_pack_args *args,
 			    struct ref **refs,
 			    struct ref **sought, int nr_sought)
@@ -810,12 +696,8 @@ static int everything_local(struct data *data,
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
 
@@ -988,7 +870,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	struct object_id oid;
 	const char *agent_feature;
 	int agent_len;
-	struct data data = { { compare_commits_by_commit_date } };
+	struct fetch_negotiator negotiator;
+	fetch_negotiator_init(&negotiator);
 
 	sort_ref_list(&ref, ref_compare_name);
 	QSORT(sought, nr_sought, cmp_ref_by_name);
@@ -1061,19 +944,17 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (!server_supports("deepen-relative") && args->deepen_relative)
 		die(_("Server does not support --deepen"));
 
-	if (marked)
-		for_each_ref(clear_marks, NULL);
-	marked = 1;
-	if (everything_local(&data, args, &ref, sought, nr_sought)) {
+	if (everything_local(&negotiator, args, &ref, sought, nr_sought)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
-	if (find_common(&data, args, fd, &oid, ref) < 0)
+	if (find_common(&negotiator, args, fd, &oid, ref) < 0)
 		if (!args->keep_pack)
 			/* When cloning, it is not unusual to have
 			 * no common commit.
 			 */
 			warning(_("no common commits"));
+	negotiator.release(&negotiator);
 
 	if (args->stateless_rpc)
 		packet_flush(fd[1]);
@@ -1149,14 +1030,15 @@ static void add_common(struct strbuf *req_buf, struct oidset *common)
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
@@ -1175,7 +1057,7 @@ static int add_haves(struct data *data, struct strbuf *req_buf,
 	return ret;
 }
 
-static int send_fetch_request(struct data *data, int fd_out,
+static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      const struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
 			      int *haves_to_send, int *in_vain)
@@ -1232,7 +1114,7 @@ static int send_fetch_request(struct data *data, int fd_out,
 		add_common(&req_buf, common);
 
 		/* Add initial haves */
-		ret = add_haves(data, &req_buf, haves_to_send, in_vain);
+		ret = add_haves(negotiator, &req_buf, haves_to_send, in_vain);
 	}
 
 	/* Send request */
@@ -1269,7 +1151,8 @@ static int process_section_header(struct packet_reader *reader,
 	return ret;
 }
 
-static int process_acks(struct data *data, struct packet_reader *reader,
+static int process_acks(struct fetch_negotiator *negotiator,
+			struct packet_reader *reader,
 			struct oidset *common)
 {
 	/* received */
@@ -1289,7 +1172,7 @@ static int process_acks(struct data *data, struct packet_reader *reader,
 				struct commit *commit;
 				oidset_insert(common, &oid);
 				commit = lookup_commit(&oid);
-				mark_common(data, commit, 0, 1);
+				negotiator->ack(negotiator, commit);
 			}
 			continue;
 		}
@@ -1367,7 +1250,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct packet_reader reader;
 	int in_vain = 0;
 	int haves_to_send = INITIAL_FLUSH;
-	struct data data = { { compare_commits_by_commit_date } };
+	struct fetch_negotiator negotiator;
+	fetch_negotiator_init(&negotiator);
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE);
 
@@ -1383,22 +1267,20 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			if (args->depth > 0 || args->deepen_since || args->deepen_not)
 				args->deepen = 1;
 
-			if (marked)
-				for_each_ref(clear_marks, NULL);
-			marked = 1;
-
 			/* Filter 'ref' by 'sought' and those that aren't local */
-			if (everything_local(&data, args, &ref, sought, nr_sought))
+			if (everything_local(&negotiator, args, &ref, sought,
+					     nr_sought))
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
@@ -1406,7 +1288,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			break;
 		case FETCH_PROCESS_ACKS:
 			/* Process ACKs/NAKs */
-			switch (process_acks(&data, &reader, &common)) {
+			switch (process_acks(&negotiator, &reader, &common)) {
 			case 2:
 				state = FETCH_GET_PACK;
 				break;
@@ -1434,6 +1316,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			continue;
 		}
 	}
+	negotiator.release(&negotiator);
 
 	oidset_clear(&common);
 	return ref;
diff --git a/negotiator/default.c b/negotiator/default.c
new file mode 100644
index 000000000..48d290e06
--- /dev/null
+++ b/negotiator/default.c
@@ -0,0 +1,173 @@
+#include "default.h"
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
index 000000000..6c4b7e526
--- /dev/null
+++ b/negotiator/default.h
@@ -0,0 +1,8 @@
+#ifndef NEGOTIATOR_DEFAULT_H
+#define NEGOTIATOR_DEFAULT_H
+
+#include "fetch-negotiator.h"
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

