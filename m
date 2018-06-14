Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E2211F403
	for <e@80x24.org>; Thu, 14 Jun 2018 22:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965108AbeFNWyx (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 18:54:53 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:43891 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965105AbeFNWyt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 18:54:49 -0400
Received: by mail-it0-f73.google.com with SMTP id i9-v6so298098itb.8
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 15:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=pK1+CPQEAjy85oPYKJ6vDimDMc3+kP2eZOORqlca8w8=;
        b=p0KH3MBylhp/l+ctdLqr2yfss44A4iCT49B7P4O7G0HSykKsy6kfWbUUTFf1a3rH5+
         UxqWZV7wAzqAHgF4Um8pNe40ZKNl2aiswK9O4Pw5kDiWsBGu5YMSJMrncIJGET5z+0cI
         N3CP8GhFu3wErVtsXKyAivz1cIHCrDpapg33UPEpHYL9bkSHR6qHjWYAoRb12+Zd+CMd
         2BzFHtqnQxlzQry7lmYovuTSKOTYZFVxWv+5JL9RuyMo47mhIysKaub+73TWW/eA3f/R
         UQqESPK6Ee3IR5n+LbUfBGTLXUu5l3MA9mD4UZ/1JvMwiki509nznhkf5r8HePq3LOCg
         WMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=pK1+CPQEAjy85oPYKJ6vDimDMc3+kP2eZOORqlca8w8=;
        b=QVUTfpo4zSgptuI1cWNmIfYDMdH+bCfPqQn0kd2lUsFjUxN20ukVH+4OoJneu8YK93
         MZVx+0hKGygCkehraiBaNN3saWeKp9Vw3EAUWY+NuMW6pM0SIe8AbU4JcQe0IuqKnMbj
         WlUxXtitlMQw6O2WzKBVy+zVstsHSZIIzA207SMNmmpF67vUh9tsukFxzdclhoFMX28+
         kPYkjv56ZS8D8MFuE778zCJqDKAoxiZK3FXkHytkQbBtvC7L3UfRG/PEFdKkou1znFzh
         S08IsFTuOBMCSyfF3uIvFE0YSehNR5+DMDrHSUPsco3GLtza29Q+0S/lV/uz6rdknt46
         QKNQ==
X-Gm-Message-State: APt69E36HaFOSouxqVdrtycDoGWvWrpeB41F7ARgRVmU8l6v6GIkYdDN
        Vime8+LT65Qb2y+QSSyoA2ltL8GpW5psSIDfLlgvUsW7lphQmQa9TMYnYu73vx8YC8xef5pcjJZ
        b6J408ldZRvdrwvf6NFMor/SZFDuPA8WW+2qvvw1091Xzm+M90nUUCVBu4BluOoo00/rHZ+CPU1
        xA
X-Google-Smtp-Source: ADUXVKKIWCJqyclgj0IB3E3GOxlXbCyRSjtZcJdGrCV9mp73aDi4aqJWbUbNl+1V7RhMvMjw6cEwDbxf1Y4fbNUxBMOy
MIME-Version: 1.0
X-Received: by 2002:a24:b51b:: with SMTP id v27-v6mr1895518ite.17.1529016888932;
 Thu, 14 Jun 2018 15:54:48 -0700 (PDT)
Date:   Thu, 14 Jun 2018 15:54:28 -0700
In-Reply-To: <cover.1529016350.git.jonathantanmy@google.com>
Message-Id: <122fdd0266b139cac9be01c62592a370c037ffec.1529016350.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com> <cover.1529016350.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c4
Subject: [PATCH v3 7/7] fetch-pack: introduce negotiator API
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
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
 fetch-pack.c         | 205 ++++++++-----------------------------------
 negotiator/default.c | 176 +++++++++++++++++++++++++++++++++++++
 negotiator/default.h |   8 ++
 object.h             |   3 +-
 7 files changed, 292 insertions(+), 167 deletions(-)
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
index fb76d4017..4b13d3389 100644
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
 
-struct negotiation_state {
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
 
-static void for_each_cached_alternate(struct negotiation_state *ns,
-				      void (*cb)(struct negotiation_state *,
+static void for_each_cached_alternate(struct fetch_negotiator *negotiator,
+				      void (*cb)(struct fetch_negotiator *,
 					         struct object *))
 {
 	static int initialized;
@@ -111,33 +100,17 @@ static void for_each_cached_alternate(struct negotiation_state *ns,
 	}
 
 	for (i = 0; i < cache.nr; i++)
-		cb(ns, cache.items[i]);
-}
-
-static void rev_list_push(struct negotiation_state *ns,
-			  struct commit *commit, int mark)
-{
-	if (!(commit->object.flags & mark)) {
-		commit->object.flags |= mark;
-
-		if (parse_commit(commit))
-			return;
-
-		prio_queue_put(&ns->rev_list, commit);
-
-		if (!(commit->object.flags & COMMON))
-			ns->non_common_revs++;
-	}
+		cb(negotiator, cache.items[i]);
 }
 
-static int rev_list_insert_ref(struct negotiation_state *ns,
+static int rev_list_insert_ref(struct fetch_negotiator *negotiator,
 			       const char *refname,
 			       const struct object_id *oid)
 {
 	struct object *o = deref_tag(parse_object(oid), refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
-		rev_list_push(ns, (struct commit *)o, SEEN);
+		negotiator->add_tip(negotiator, (struct commit *)o);
 
 	return 0;
 }
@@ -148,98 +121,6 @@ static int rev_list_insert_ref_oid(const char *refname, const struct object_id *
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
-static void mark_common(struct negotiation_state *ns, struct commit *commit,
-		int ancestors_only, int dont_parse)
-{
-	if (commit != NULL && !(commit->object.flags & COMMON)) {
-		struct object *o = (struct object *)commit;
-
-		if (!ancestors_only)
-			o->flags |= COMMON;
-
-		if (!(o->flags & SEEN))
-			rev_list_push(ns, commit, SEEN);
-		else {
-			struct commit_list *parents;
-
-			if (!ancestors_only && !(o->flags & POPPED))
-				ns->non_common_revs--;
-			if (!o->parsed && !dont_parse)
-				if (parse_commit(commit))
-					return;
-
-			for (parents = commit->parents;
-					parents;
-					parents = parents->next)
-				mark_common(ns, parents->item, 0,
-					    dont_parse);
-		}
-	}
-}
-
-/*
-  Get the next rev to send, ignoring the common.
-*/
-
-static const struct object_id *get_rev(struct negotiation_state *ns)
-{
-	struct commit *commit = NULL;
-
-	while (commit == NULL) {
-		unsigned int mark;
-		struct commit_list *parents;
-
-		if (ns->rev_list.nr == 0 || ns->non_common_revs == 0)
-			return NULL;
-
-		commit = prio_queue_get(&ns->rev_list);
-		parse_commit(commit);
-		parents = commit->parents;
-
-		commit->object.flags |= POPPED;
-		if (!(commit->object.flags & COMMON))
-			ns->non_common_revs--;
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
-				rev_list_push(ns, parents->item, mark);
-			if (mark & COMMON)
-				mark_common(ns, parents->item, 1, 0);
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
@@ -306,10 +187,10 @@ static void send_request(struct fetch_pack_args *args,
 		write_or_die(fd, buf->buf, buf->len);
 }
 
-static void insert_one_alternate_object(struct negotiation_state *ns,
+static void insert_one_alternate_object(struct fetch_negotiator *negotiator,
 					struct object *obj)
 {
-	rev_list_insert_ref(ns, NULL, &obj->oid);
+	rev_list_insert_ref(negotiator, NULL, &obj->oid);
 }
 
 #define INITIAL_FLUSH 16
@@ -332,7 +213,7 @@ static int next_flush(int stateless_rpc, int count)
 	return count;
 }
 
-static int find_common(struct negotiation_state *ns,
+static int find_common(struct fetch_negotiator *negotiator,
 		       struct fetch_pack_args *args,
 		       int fd[2], struct object_id *result_oid,
 		       struct ref *refs)
@@ -349,8 +230,8 @@ static int find_common(struct negotiation_state *ns,
 	if (args->stateless_rpc && multi_ack == 1)
 		die(_("--stateless-rpc requires multi_ack_detailed"));
 
-	for_each_ref(rev_list_insert_ref_oid, ns);
-	for_each_cached_alternate(ns, insert_one_alternate_object);
+	for_each_ref(rev_list_insert_ref_oid, negotiator);
+	for_each_cached_alternate(negotiator, insert_one_alternate_object);
 
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
@@ -468,7 +349,7 @@ static int find_common(struct negotiation_state *ns,
 	retval = -1;
 	if (args->no_dependents)
 		goto done;
-	while ((oid = get_rev(ns))) {
+	while ((oid = negotiator->next(negotiator))) {
 		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
 		print_verbose(args, "have %s", oid_to_hex(oid));
 		in_vain++;
@@ -508,8 +389,7 @@ static int find_common(struct negotiation_state *ns,
 					int was_common;
 					if (!commit)
 						die(_("invalid commit %s"), oid_to_hex(result_oid));
-					was_common = commit->object.flags & COMMON;
-					mark_common(ns, commit, 0, 1);
+					was_common = negotiator->ack(negotiator, commit);
 					if (args->stateless_rpc
 					 && ack == ACK_common
 					 && !was_common) {
@@ -718,7 +598,7 @@ static void filter_refs(struct fetch_pack_args *args,
 	*refs = newlist;
 }
 
-static void mark_alternate_complete(struct negotiation_state *unused,
+static void mark_alternate_complete(struct fetch_negotiator *unused,
 				    struct object *obj)
 {
 	mark_complete(&obj->oid);
@@ -756,7 +636,7 @@ static int add_loose_objects_to_set(const struct object_id *oid,
  * earliest commit time of the objects in refs that are commits and that we know
  * the commit time of.
  */
-static void mark_complete_and_common_ref(struct negotiation_state *ns,
+static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 					 struct fetch_pack_args *args,
 					 struct ref **refs)
 {
@@ -825,12 +705,8 @@ static void mark_complete_and_common_ref(struct negotiation_state *ns,
 			if (!o || o->type != OBJ_COMMIT || !(o->flags & COMPLETE))
 				continue;
 
-			if (!(o->flags & SEEN)) {
-				rev_list_push(ns, (struct commit *)o,
-					      COMMON_REF | SEEN);
-
-				mark_common(ns, (struct commit *)o, 1, 1);
-			}
+			negotiator->known_common(negotiator,
+						 (struct commit *)o);
 		}
 	}
 
@@ -1012,7 +888,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	struct object_id oid;
 	const char *agent_feature;
 	int agent_len;
-	struct negotiation_state ns = { { compare_commits_by_commit_date } };
+	struct fetch_negotiator negotiator;
+	fetch_negotiator_init(&negotiator);
 
 	sort_ref_list(&ref, ref_compare_name);
 	QSORT(sought, nr_sought, cmp_ref_by_name);
@@ -1085,16 +962,13 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (!server_supports("deepen-relative") && args->deepen_relative)
 		die(_("Server does not support --deepen"));
 
-	if (marked)
-		for_each_ref(clear_marks, NULL);
-	marked = 1;
-	mark_complete_and_common_ref(&ns, args, &ref);
+	mark_complete_and_common_ref(&negotiator, args, &ref);
 	filter_refs(args, &ref, sought, nr_sought);
 	if (everything_local(args, &ref)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
-	if (find_common(&ns, args, fd, &oid, ref) < 0)
+	if (find_common(&negotiator, args, fd, &oid, ref) < 0)
 		if (!args->keep_pack)
 			/* When cloning, it is not unusual to have
 			 * no common commit.
@@ -1114,7 +988,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		die(_("git fetch-pack: fetch failed."));
 
  all_done:
-	clear_prio_queue(&ns.rev_list);
+	negotiator.release(&negotiator);
 	return ref;
 }
 
@@ -1176,14 +1050,15 @@ static void add_common(struct strbuf *req_buf, struct oidset *common)
 	}
 }
 
-static int add_haves(struct negotiation_state *ns, struct strbuf *req_buf,
+static int add_haves(struct fetch_negotiator *negotiator,
+		     struct strbuf *req_buf,
 		     int *haves_to_send, int *in_vain)
 {
 	int ret = 0;
 	int haves_added = 0;
 	const struct object_id *oid;
 
-	while ((oid = get_rev(ns))) {
+	while ((oid = negotiator->next(negotiator))) {
 		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
 		if (++haves_added >= *haves_to_send)
 			break;
@@ -1202,7 +1077,7 @@ static int add_haves(struct negotiation_state *ns, struct strbuf *req_buf,
 	return ret;
 }
 
-static int send_fetch_request(struct negotiation_state *ns, int fd_out,
+static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      const struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
 			      int *haves_to_send, int *in_vain)
@@ -1259,7 +1134,7 @@ static int send_fetch_request(struct negotiation_state *ns, int fd_out,
 		add_common(&req_buf, common);
 
 		/* Add initial haves */
-		ret = add_haves(ns, &req_buf, haves_to_send, in_vain);
+		ret = add_haves(negotiator, &req_buf, haves_to_send, in_vain);
 	}
 
 	/* Send request */
@@ -1296,7 +1171,7 @@ static int process_section_header(struct packet_reader *reader,
 	return ret;
 }
 
-static int process_acks(struct negotiation_state *ns,
+static int process_acks(struct fetch_negotiator *negotiator,
 			struct packet_reader *reader,
 			struct oidset *common)
 {
@@ -1317,7 +1192,7 @@ static int process_acks(struct negotiation_state *ns,
 				struct commit *commit;
 				oidset_insert(common, &oid);
 				commit = lookup_commit(&oid);
-				mark_common(ns, commit, 0, 1);
+				negotiator->ack(negotiator, commit);
 			}
 			continue;
 		}
@@ -1395,7 +1270,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct packet_reader reader;
 	int in_vain = 0;
 	int haves_to_send = INITIAL_FLUSH;
-	struct negotiation_state ns = { { compare_commits_by_commit_date } };
+	struct fetch_negotiator negotiator;
+	fetch_negotiator_init(&negotiator);
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE);
 
@@ -1411,24 +1287,21 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			if (args->depth > 0 || args->deepen_since || args->deepen_not)
 				args->deepen = 1;
 
-			if (marked)
-				for_each_ref(clear_marks, NULL);
-			marked = 1;
-
 			/* Filter 'ref' by 'sought' and those that aren't local */
-			mark_complete_and_common_ref(&ns, args, &ref);
+			mark_complete_and_common_ref(&negotiator, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);
 			if (everything_local(args, &ref))
 				state = FETCH_DONE;
 			else
 				state = FETCH_SEND_REQUEST;
 
-			for_each_ref(rev_list_insert_ref_oid, &ns);
-			for_each_cached_alternate(&ns,
+			for_each_ref(rev_list_insert_ref_oid, &negotiator);
+			for_each_cached_alternate(&negotiator,
 						  insert_one_alternate_object);
 			break;
 		case FETCH_SEND_REQUEST:
-			if (send_fetch_request(&ns, fd[1], args, ref, &common,
+			if (send_fetch_request(&negotiator, fd[1], args, ref,
+					       &common,
 					       &haves_to_send, &in_vain))
 				state = FETCH_GET_PACK;
 			else
@@ -1436,7 +1309,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			break;
 		case FETCH_PROCESS_ACKS:
 			/* Process ACKs/NAKs */
-			switch (process_acks(&ns, &reader, &common)) {
+			switch (process_acks(&negotiator, &reader, &common)) {
 			case 2:
 				state = FETCH_GET_PACK;
 				break;
@@ -1465,7 +1338,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		}
 	}
 
-	clear_prio_queue(&ns.rev_list);
+	negotiator.release(&negotiator);
 	oidset_clear(&common);
 	return ref;
 }
diff --git a/negotiator/default.c b/negotiator/default.c
new file mode 100644
index 000000000..382fc7772
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
+struct negotiation_state {
+	struct prio_queue rev_list;
+	int non_common_revs;
+};
+
+static void rev_list_push(struct negotiation_state *ns,
+			  struct commit *commit, int mark)
+{
+	if (!(commit->object.flags & mark)) {
+		commit->object.flags |= mark;
+
+		if (parse_commit(commit))
+			return;
+
+		prio_queue_put(&ns->rev_list, commit);
+
+		if (!(commit->object.flags & COMMON))
+			ns->non_common_revs++;
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
+ * This function marks a rev and its ancestors as common.
+ * In some cases, it is desirable to mark only the ancestors (for example
+ * when only the server does not yet know that they are common).
+ */
+static void mark_common(struct negotiation_state *ns, struct commit *commit,
+		int ancestors_only, int dont_parse)
+{
+	if (commit != NULL && !(commit->object.flags & COMMON)) {
+		struct object *o = (struct object *)commit;
+
+		if (!ancestors_only)
+			o->flags |= COMMON;
+
+		if (!(o->flags & SEEN))
+			rev_list_push(ns, commit, SEEN);
+		else {
+			struct commit_list *parents;
+
+			if (!ancestors_only && !(o->flags & POPPED))
+				ns->non_common_revs--;
+			if (!o->parsed && !dont_parse)
+				if (parse_commit(commit))
+					return;
+
+			for (parents = commit->parents;
+					parents;
+					parents = parents->next)
+				mark_common(ns, parents->item, 0,
+					    dont_parse);
+		}
+	}
+}
+
+/*
+ * Get the next rev to send, ignoring the common.
+ */
+static const struct object_id *get_rev(struct negotiation_state *ns)
+{
+	struct commit *commit = NULL;
+
+	while (commit == NULL) {
+		unsigned int mark;
+		struct commit_list *parents;
+
+		if (ns->rev_list.nr == 0 || ns->non_common_revs == 0)
+			return NULL;
+
+		commit = prio_queue_get(&ns->rev_list);
+		parse_commit(commit);
+		parents = commit->parents;
+
+		commit->object.flags |= POPPED;
+		if (!(commit->object.flags & COMMON))
+			ns->non_common_revs--;
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
+				rev_list_push(ns, parents->item, mark);
+			if (mark & COMMON)
+				mark_common(ns, parents->item, 1, 0);
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
+	clear_prio_queue(&((struct negotiation_state *)n->data)->rev_list);
+	FREE_AND_NULL(n->data);
+}
+
+void default_negotiator_init(struct fetch_negotiator *negotiator)
+{
+	struct negotiation_state *ns;
+	negotiator->known_common = known_common;
+	negotiator->add_tip = add_tip;
+	negotiator->next = next;
+	negotiator->ack = ack;
+	negotiator->release = release;
+	negotiator->data = ns = xcalloc(1, sizeof(*ns));
+	ns->rev_list.compare = compare_commits_by_commit_date;
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
2.17.0.582.gccdcbd54c4

