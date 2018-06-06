Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4612B1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 20:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeFFUre (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 16:47:34 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44236 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeFFUrc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 16:47:32 -0400
Received: by mail-pg0-f66.google.com with SMTP id p21-v6so3573841pgd.11
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 13:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vZYsiTXeYh5AD+mYi47t49QaIt1vn7ch4Um3rUU1b2A=;
        b=AXiHErs4aa3x87ETDg4VCcjXzKQF1mZMyE351LK6CJ8GjMrXBMDuvo2pJZCOBB//ND
         OZ7OrwGyveS8ZJYGXenq0XNIvTbnYkU4A1O+YXUNFODeFK75Enyzgu0lVRY/W1qIl93r
         He8QVLClTCzF165GYP+9VBTQgG5mcEeSbZFNBmosNp2JtiB0W1Rmt/+p/EG7stSLl84n
         44QnT+qYxRpwCIfC15lhI9IZUbGwP8CmV0Zhf+XTrRvozLoEVQYK7WBPy3qsGjQLcgNU
         jnmCy6xuWecCY50COy7SHnnZNEVV3dUc34lUda2crEqyZNy/a0llrE17peldnjR2mt76
         KPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vZYsiTXeYh5AD+mYi47t49QaIt1vn7ch4Um3rUU1b2A=;
        b=r07e7RTEgsH1xKgyv+i5ye6cwaHmRLSFQXfgCb6Mbp0rrBUX7YvKBK+N8bSyZF36hg
         4wjEV9xmP6NlQJp8+xbC0v/EL43vxQG8tu1rnRshvshn07CCuqDSPpaJgZh6zihqwJpD
         kK10u+bk1UTOj8EHTnO2yS5NNA1ktmndJ2G7/R8U1eT66MPzqFFKWAV4yd/RHCF6aENL
         64Ea2DYjEw6o78lUkOmMf5aGmMs6NeMqWKJ2bouTPN/klsjJYIp/KKZr7bQCrvkYuKjy
         8zhIwqytc1iI4ippGnyCsodW5xl3kJq45Ka6rMQGU1oWlqk9nTsCzC9TPjV26vMETytd
         tJAA==
X-Gm-Message-State: APt69E2ds0byH6Nl6+aD8tN+kMLbCChLzGac96By9XuFWWfuYeSqBLG5
        QWNgPbkYPKNvc9b2ACA3660LT54yZJE=
X-Google-Smtp-Source: ADUXVKLEW31ZdBjCKSCMFzUxMsI1XZFp1WTR6TOoEycKJ13eGuRPxWNh0KVA0y/ltHthMowYMI+EGg==
X-Received: by 2002:a65:590e:: with SMTP id f14-v6mr3800518pgu.282.1528318050419;
        Wed, 06 Jun 2018 13:47:30 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id m1-v6sm20703323pfh.155.2018.06.06.13.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 13:47:28 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com
Subject: [PATCH v2 5/8] fetch-pack: make negotiation-related vars local
Date:   Wed,  6 Jun 2018 13:47:11 -0700
Message-Id: <955d9f62d2c8400791501d71c72fea4ef2dc1cff.1528317619.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1528317619.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com> <cover.1528317619.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reduce the number of global variables by making the priority queue and
the count of non-common commits in it local, passing them as a struct to
various functions where necessary.

This also helps in the case that fetch_pack() is invoked twice in the
same process (when tag following is required when using a transport that
does not support tag following), in that different priority queues will
now be used in each invocation, instead of reusing the possibly
non-empty one.

The struct containing these variables is named "data" to ease review of
a subsequent patch in this series - in that patch, this struct
definition and several functions will be moved to a negotiation-specific
file, and this allows the move to be verbatim.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 104 +++++++++++++++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 45 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 114207b8e..c31644bb9 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -50,8 +50,12 @@ static int marked;
  */
 #define MAX_IN_VAIN 256
 
-static struct prio_queue rev_list = { compare_commits_by_commit_date };
-static int non_common_revs, multi_ack, use_sideband;
+struct data {
+	struct prio_queue rev_list;
+	int non_common_revs;
+};
+
+static int multi_ack, use_sideband;
 /* Allow specifying sha1 if it is a ref tip. */
 #define ALLOW_TIP_SHA1	01
 /* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
@@ -93,7 +97,8 @@ static void cache_one_alternate(const char *refname,
 	cache->items[cache->nr++] = obj;
 }
 
-static void for_each_cached_alternate(void (*cb)(struct object *))
+static void for_each_cached_alternate(struct data *data,
+				      void (*cb)(struct data *, struct object *))
 {
 	static int initialized;
 	static struct alternate_object_cache cache;
@@ -105,10 +110,10 @@ static void for_each_cached_alternate(void (*cb)(struct object *))
 	}
 
 	for (i = 0; i < cache.nr; i++)
-		cb(cache.items[i]);
+		cb(data, cache.items[i]);
 }
 
-static void rev_list_push(struct commit *commit, int mark)
+static void rev_list_push(struct data *data, struct commit *commit, int mark)
 {
 	if (!(commit->object.flags & mark)) {
 		commit->object.flags |= mark;
@@ -116,19 +121,20 @@ static void rev_list_push(struct commit *commit, int mark)
 		if (parse_commit(commit))
 			return;
 
-		prio_queue_put(&rev_list, commit);
+		prio_queue_put(&data->rev_list, commit);
 
 		if (!(commit->object.flags & COMMON))
-			non_common_revs++;
+			data->non_common_revs++;
 	}
 }
 
-static int rev_list_insert_ref(const char *refname, const struct object_id *oid)
+static int rev_list_insert_ref(struct data *data, const char *refname,
+			       const struct object_id *oid)
 {
 	struct object *o = deref_tag(parse_object(oid), refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
-		rev_list_push((struct commit *)o, SEEN);
+		rev_list_push(data, (struct commit *)o, SEEN);
 
 	return 0;
 }
@@ -136,7 +142,7 @@ static int rev_list_insert_ref(const char *refname, const struct object_id *oid)
 static int rev_list_insert_ref_oid(const char *refname, const struct object_id *oid,
 				   int flag, void *cb_data)
 {
-	return rev_list_insert_ref(refname, oid);
+	return rev_list_insert_ref(cb_data, refname, oid);
 }
 
 static int clear_marks(const char *refname, const struct object_id *oid,
@@ -156,7 +162,7 @@ static int clear_marks(const char *refname, const struct object_id *oid,
    when only the server does not yet know that they are common).
 */
 
-static void mark_common(struct commit *commit,
+static void mark_common(struct data *data, struct commit *commit,
 		int ancestors_only, int dont_parse)
 {
 	if (commit != NULL && !(commit->object.flags & COMMON)) {
@@ -166,12 +172,12 @@ static void mark_common(struct commit *commit,
 			o->flags |= COMMON;
 
 		if (!(o->flags & SEEN))
-			rev_list_push(commit, SEEN);
+			rev_list_push(data, commit, SEEN);
 		else {
 			struct commit_list *parents;
 
 			if (!ancestors_only && !(o->flags & POPPED))
-				non_common_revs--;
+				data->non_common_revs--;
 			if (!o->parsed && !dont_parse)
 				if (parse_commit(commit))
 					return;
@@ -179,7 +185,7 @@ static void mark_common(struct commit *commit,
 			for (parents = commit->parents;
 					parents;
 					parents = parents->next)
-				mark_common(parents->item, 0, dont_parse);
+				mark_common(data, parents->item, 0, dont_parse);
 		}
 	}
 }
@@ -188,7 +194,7 @@ static void mark_common(struct commit *commit,
   Get the next rev to send, ignoring the common.
 */
 
-static const struct object_id *get_rev(void)
+static const struct object_id *get_rev(struct data *data)
 {
 	struct commit *commit = NULL;
 
@@ -196,16 +202,16 @@ static const struct object_id *get_rev(void)
 		unsigned int mark;
 		struct commit_list *parents;
 
-		if (rev_list.nr == 0 || non_common_revs == 0)
+		if (data->rev_list.nr == 0 || data->non_common_revs == 0)
 			return NULL;
 
-		commit = prio_queue_get(&rev_list);
+		commit = prio_queue_get(&data->rev_list);
 		parse_commit(commit);
 		parents = commit->parents;
 
 		commit->object.flags |= POPPED;
 		if (!(commit->object.flags & COMMON))
-			non_common_revs--;
+			data->non_common_revs--;
 
 		if (commit->object.flags & COMMON) {
 			/* do not send "have", and ignore ancestors */
@@ -220,9 +226,9 @@ static const struct object_id *get_rev(void)
 
 		while (parents) {
 			if (!(parents->item->object.flags & SEEN))
-				rev_list_push(parents->item, mark);
+				rev_list_push(data, parents->item, mark);
 			if (mark & COMMON)
-				mark_common(parents->item, 1, 0);
+				mark_common(data, parents->item, 1, 0);
 			parents = parents->next;
 		}
 	}
@@ -296,9 +302,9 @@ static void send_request(struct fetch_pack_args *args,
 		write_or_die(fd, buf->buf, buf->len);
 }
 
-static void insert_one_alternate_object(struct object *obj)
+static void insert_one_alternate_object(struct data *data, struct object *obj)
 {
-	rev_list_insert_ref(NULL, &obj->oid);
+	rev_list_insert_ref(data, NULL, &obj->oid);
 }
 
 #define INITIAL_FLUSH 16
@@ -321,7 +327,7 @@ static int next_flush(int stateless_rpc, int count)
 	return count;
 }
 
-static int find_common(struct fetch_pack_args *args,
+static int find_common(struct data *data, struct fetch_pack_args *args,
 		       int fd[2], struct object_id *result_oid,
 		       struct ref *refs)
 {
@@ -337,8 +343,8 @@ static int find_common(struct fetch_pack_args *args,
 	if (args->stateless_rpc && multi_ack == 1)
 		die(_("--stateless-rpc requires multi_ack_detailed"));
 
-	for_each_ref(rev_list_insert_ref_oid, NULL);
-	for_each_cached_alternate(insert_one_alternate_object);
+	for_each_ref(rev_list_insert_ref_oid, data);
+	for_each_cached_alternate(data, insert_one_alternate_object);
 
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
@@ -456,7 +462,7 @@ static int find_common(struct fetch_pack_args *args,
 	retval = -1;
 	if (args->no_dependents)
 		goto done;
-	while ((oid = get_rev())) {
+	while ((oid = get_rev(data))) {
 		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
 		print_verbose(args, "have %s", oid_to_hex(oid));
 		in_vain++;
@@ -514,7 +520,7 @@ static int find_common(struct fetch_pack_args *args,
 					} else if (!args->stateless_rpc
 						   || ack != ACK_common)
 						in_vain = 0;
-					mark_common(commit, 0, 1);
+					mark_common(data, commit, 0, 1);
 					retval = 0;
 					got_continue = 1;
 					if (ack == ACK_ready)
@@ -704,7 +710,7 @@ static void filter_refs(struct fetch_pack_args *args,
 	*refs = newlist;
 }
 
-static void mark_alternate_complete(struct object *obj)
+static void mark_alternate_complete(struct data *unused, struct object *obj)
 {
 	mark_complete(&obj->oid);
 }
@@ -741,7 +747,8 @@ static int add_loose_objects_to_set(const struct object_id *oid,
  * earliest commit time of the objects in refs that are commits and that we know
  * the commit time of.
  */
-static void mark_complete_and_common_ref(struct fetch_pack_args *args,
+static void mark_complete_and_common_ref(struct data *data,
+					 struct fetch_pack_args *args,
 					 struct ref **refs)
 {
 	struct ref *ref;
@@ -792,7 +799,7 @@ static void mark_complete_and_common_ref(struct fetch_pack_args *args,
 	if (!args->no_dependents) {
 		if (!args->deepen) {
 			for_each_ref(mark_complete_oid, NULL);
-			for_each_cached_alternate(mark_alternate_complete);
+			for_each_cached_alternate(NULL, mark_alternate_complete);
 			commit_list_sort_by_date(&complete);
 			if (cutoff)
 				mark_recent_complete_commits(args, cutoff);
@@ -810,9 +817,10 @@ static void mark_complete_and_common_ref(struct fetch_pack_args *args,
 				continue;
 
 			if (!(o->flags & SEEN)) {
-				rev_list_push((struct commit *)o, COMMON_REF | SEEN);
+				rev_list_push(data, (struct commit *)o,
+					      COMMON_REF | SEEN);
 
-				mark_common((struct commit *)o, 1, 1);
+				mark_common(data, (struct commit *)o, 1, 1);
 			}
 		}
 	}
@@ -995,6 +1003,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	struct object_id oid;
 	const char *agent_feature;
 	int agent_len;
+	struct data data = { { compare_commits_by_commit_date } };
 
 	sort_ref_list(&ref, ref_compare_name);
 	QSORT(sought, nr_sought, cmp_ref_by_name);
@@ -1070,13 +1079,13 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (marked)
 		for_each_ref(clear_marks, NULL);
 	marked = 1;
-	mark_complete_and_common_ref(args, &ref);
+	mark_complete_and_common_ref(&data, args, &ref);
 	filter_refs(args, &ref, sought, nr_sought);
 	if (everything_local(args, &ref)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
-	if (find_common(args, fd, &oid, ref) < 0)
+	if (find_common(&data, args, fd, &oid, ref) < 0)
 		if (!args->keep_pack)
 			/* When cloning, it is not unusual to have
 			 * no common commit.
@@ -1157,13 +1166,14 @@ static void add_common(struct strbuf *req_buf, struct oidset *common)
 	}
 }
 
-static int add_haves(struct strbuf *req_buf, int *haves_to_send, int *in_vain)
+static int add_haves(struct data *data, struct strbuf *req_buf,
+		     int *haves_to_send, int *in_vain)
 {
 	int ret = 0;
 	int haves_added = 0;
 	const struct object_id *oid;
 
-	while ((oid = get_rev())) {
+	while ((oid = get_rev(data))) {
 		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
 		if (++haves_added >= *haves_to_send)
 			break;
@@ -1182,7 +1192,8 @@ static int add_haves(struct strbuf *req_buf, int *haves_to_send, int *in_vain)
 	return ret;
 }
 
-static int send_fetch_request(int fd_out, const struct fetch_pack_args *args,
+static int send_fetch_request(struct data *data, int fd_out,
+			      const struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
 			      int *haves_to_send, int *in_vain)
 {
@@ -1238,7 +1249,7 @@ static int send_fetch_request(int fd_out, const struct fetch_pack_args *args,
 		add_common(&req_buf, common);
 
 		/* Add initial haves */
-		ret = add_haves(&req_buf, haves_to_send, in_vain);
+		ret = add_haves(data, &req_buf, haves_to_send, in_vain);
 	}
 
 	/* Send request */
@@ -1275,7 +1286,8 @@ static int process_section_header(struct packet_reader *reader,
 	return ret;
 }
 
-static int process_acks(struct packet_reader *reader, struct oidset *common)
+static int process_acks(struct data *data, struct packet_reader *reader,
+			struct oidset *common)
 {
 	/* received */
 	int received_ready = 0;
@@ -1294,7 +1306,7 @@ static int process_acks(struct packet_reader *reader, struct oidset *common)
 				struct commit *commit;
 				oidset_insert(common, &oid);
 				commit = lookup_commit(&oid);
-				mark_common(commit, 0, 1);
+				mark_common(data, commit, 0, 1);
 			}
 			continue;
 		}
@@ -1372,6 +1384,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct packet_reader reader;
 	int in_vain = 0;
 	int haves_to_send = INITIAL_FLUSH;
+	struct data data = { { compare_commits_by_commit_date } };
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE);
 
@@ -1392,18 +1405,19 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			marked = 1;
 
 			/* Filter 'ref' by 'sought' and those that aren't local */
-			mark_complete_and_common_ref(args, &ref);
+			mark_complete_and_common_ref(&data, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);
 			if (everything_local(args, &ref))
 				state = FETCH_DONE;
 			else
 				state = FETCH_SEND_REQUEST;
 
-			for_each_ref(rev_list_insert_ref_oid, NULL);
-			for_each_cached_alternate(insert_one_alternate_object);
+			for_each_ref(rev_list_insert_ref_oid, &data);
+			for_each_cached_alternate(&data,
+						  insert_one_alternate_object);
 			break;
 		case FETCH_SEND_REQUEST:
-			if (send_fetch_request(fd[1], args, ref, &common,
+			if (send_fetch_request(&data, fd[1], args, ref, &common,
 					       &haves_to_send, &in_vain))
 				state = FETCH_GET_PACK;
 			else
@@ -1411,7 +1425,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			break;
 		case FETCH_PROCESS_ACKS:
 			/* Process ACKs/NAKs */
-			switch (process_acks(&reader, &common)) {
+			switch (process_acks(&data, &reader, &common)) {
 			case 2:
 				state = FETCH_GET_PACK;
 				break;
-- 
2.17.0.768.g1526ddbba1.dirty

