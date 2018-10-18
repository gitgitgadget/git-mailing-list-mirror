Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFAB01F453
	for <e@80x24.org>; Thu, 18 Oct 2018 20:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeJSEqZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 00:46:25 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:42149 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSEqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 00:46:25 -0400
Received: by mail-vk1-f201.google.com with SMTP id w73-v6so8678164vkd.9
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iCKvsRsr5nJXYVe96HFASrsxna2OJL0z0AVVQei1yiQ=;
        b=dfxhZgyzufhMk8Ac0MPYOrF6iIZXLFqdRaC+ibhhQqVpAczHdVoGr3SmAWzWC3opNZ
         iTBIFt7JTeH7epfeCsuShjvgUslbkJ1BIU7krD478fg9S4raY3UZNArcXBKufYXWdCRr
         Hplh245LUcuvxOwHoQcVryv2F/DnMfcGUrsNVjHsmjdIKVfUBfCyCkE8jvu4QMWKqwgq
         6xzQ/JaFpVccHThiVtVHvC8/PFv5pk+6+sdMTeq44HP6WVCbfgel+J7uu9uFjQOjhgaz
         Ceq0aqdtkvyruOxLuffEY55LAdCHREEOlx/4de4BB8GA5tf6ArQglx+uX+ouE5uLv5V8
         x3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iCKvsRsr5nJXYVe96HFASrsxna2OJL0z0AVVQei1yiQ=;
        b=A6Ydq4Wl43aiBltcNZGvEqJh5WkUd2KZGm3X4wSs/EIegBiMgSk2VpgkL9HRLMsR06
         fsC1gB74HyJozKrqt1EcoWF5dcH2Xzl7zmRm5v/ENW7s3q20EZrREgYcdt1CmX0YUdx8
         BiYCw7hmA3Fs2Q0fqZyjrurORWalY1DfAqg1CPxqP/pk28Z8fFyWJN5rTukLdZC5ITFw
         z84V/AUcUoVZI0Ar9C48tLh4NrR46Znes/SXuaYEMQfq05MF66rhw7H5LquQ1ehczsCC
         tZdvC4+Hsr5zdTcv4IG3rjzWQUQXJoRwZvqLAnrmYUpfe/BGnfinUEWI6miVawjQpHhC
         AmdQ==
X-Gm-Message-State: ABuFfohOveTB18sANMtl85vcxg0aVAhn7HAJlmV01InuWKfLfl9KoITO
        bOMoL7jkSHlFvjnguKwkog7/fn8WIeTwjHNw9tOVoPihpyzllFwFJCy11VV8RsE+RPngCwSfC2o
        G7neGPvN3e/1NZK+zOevYU8+sGKksGqKcrbm31gZqq393BlTPsVqlgG2SVlWf6BbPK9jRtlfcfQ
        Tv
X-Google-Smtp-Source: ACcGV63VF/Jgtr2cuoWruX/iEXH5/ns2RiSn1p9vcubTWXGVct1dstaqzeVWKOJoIs8Qi2s7XKDNvEUf9H97kFFFEbdY
X-Received: by 2002:a1f:85cd:: with SMTP id h196mr6676207vkd.2.1539895417800;
 Thu, 18 Oct 2018 13:43:37 -0700 (PDT)
Date:   Thu, 18 Oct 2018 13:43:28 -0700
In-Reply-To: <cover.1539893192.git.jonathantanmy@google.com>
Message-Id: <3853c006257c418ee5179aa7c35c9e9e31eeef1f.1539893192.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181016215850.47821-1-jonathantanmy@google.com> <cover.1539893192.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 2/3] upload-pack: make want_obj not global
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because upload_pack_v2() can be invoked multiple times in the same
process, the static variable want_obj may not be empty when it is
invoked. To make further analysis of this situation easier, make the
variable local; analysis will be done in a subsequent patch.

The new local variable in upload_pack_v2() is static to preserve
existing behavior; this is not necessary in upload_pack() because
upload_pack() is only invoked once per process.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 upload-pack.c | 116 ++++++++++++++++++++++++++++----------------------
 1 file changed, 66 insertions(+), 50 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index cb2401f90d..451bf47e7f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -52,7 +52,6 @@ static int no_progress, daemon_mode;
 #define ALLOW_ANY_SHA1	07
 static unsigned int allow_unadvertised_object_request;
 static int shallow_nr;
-static struct object_array want_obj;
 static struct object_array extra_edge_obj;
 static unsigned int timeout;
 static int keepalive = 5;
@@ -98,7 +97,8 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 	return 0;
 }
 
-static void create_pack_file(const struct object_array *have_obj)
+static void create_pack_file(const struct object_array *have_obj,
+			     const struct object_array *want_obj)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
 	char data[8193], progress[128];
@@ -159,9 +159,9 @@ static void create_pack_file(const struct object_array *have_obj)
 	if (shallow_nr)
 		for_each_commit_graft(write_one_shallow, pipe_fd);
 
-	for (i = 0; i < want_obj.nr; i++)
+	for (i = 0; i < want_obj->nr; i++)
 		fprintf(pipe_fd, "%s\n",
-			oid_to_hex(&want_obj.objects[i].item->oid));
+			oid_to_hex(&want_obj->objects[i].item->oid));
 	fprintf(pipe_fd, "--not\n");
 	for (i = 0; i < have_obj->nr; i++)
 		fprintf(pipe_fd, "%s\n",
@@ -337,19 +337,21 @@ static int got_oid(const char *hex, struct object_id *oid,
 	return 0;
 }
 
-static int ok_to_give_up(const struct object_array *have_obj)
+static int ok_to_give_up(const struct object_array *have_obj,
+			 struct object_array *want_obj)
 {
 	uint32_t min_generation = GENERATION_NUMBER_ZERO;
 
 	if (!have_obj->nr)
 		return 0;
 
-	return can_all_from_reach_with_flag(&want_obj, THEY_HAVE,
+	return can_all_from_reach_with_flag(want_obj, THEY_HAVE,
 					    COMMON_KNOWN, oldest_have,
 					    min_generation);
 }
 
-static int get_common_commits(struct object_array *have_obj)
+static int get_common_commits(struct object_array *have_obj,
+			      struct object_array *want_obj)
 {
 	struct object_id oid;
 	char last_hex[GIT_MAX_HEXSZ + 1];
@@ -367,7 +369,7 @@ static int get_common_commits(struct object_array *have_obj)
 
 		if (!line) {
 			if (multi_ack == 2 && got_common
-			    && !got_other && ok_to_give_up(have_obj)) {
+			    && !got_other && ok_to_give_up(have_obj, want_obj)) {
 				sent_ready = 1;
 				packet_write_fmt(1, "ACK %s ready\n", last_hex);
 			}
@@ -388,7 +390,7 @@ static int get_common_commits(struct object_array *have_obj)
 			switch (got_oid(arg, &oid, have_obj)) {
 			case -1: /* they have what we do not */
 				got_other = 1;
-				if (multi_ack && ok_to_give_up(have_obj)) {
+				if (multi_ack && ok_to_give_up(have_obj, want_obj)) {
 					const char *hex = oid_to_hex(&oid);
 					if (multi_ack == 2) {
 						sent_ready = 1;
@@ -581,7 +583,7 @@ static int has_unreachable(struct object_array *src)
 	return 1;
 }
 
-static void check_non_tip(void)
+static void check_non_tip(struct object_array *want_obj)
 {
 	int i;
 
@@ -592,14 +594,14 @@ static void check_non_tip(void)
 	 */
 	if (!stateless_rpc && !(allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1))
 		goto error;
-	if (!has_unreachable(&want_obj))
+	if (!has_unreachable(want_obj))
 		/* All the non-tip ones are ancestors of what we advertised */
 		return;
 
 error:
 	/* Pick one of them (we know there at least is one) */
-	for (i = 0; i < want_obj.nr; i++) {
-		struct object *o = want_obj.objects[i].item;
+	for (i = 0; i < want_obj->nr; i++) {
+		struct object *o = want_obj->objects[i].item;
 		if (!is_our_ref(o))
 			die("git upload-pack: not our ref %s",
 			    oid_to_hex(&o->oid));
@@ -620,7 +622,8 @@ static void send_shallow(struct commit_list *result)
 	}
 }
 
-static void send_unshallow(const struct object_array *shallows)
+static void send_unshallow(const struct object_array *shallows,
+			   struct object_array *want_obj)
 {
 	int i;
 
@@ -644,7 +647,7 @@ static void send_unshallow(const struct object_array *shallows)
 			parents = ((struct commit *)object)->parents;
 			while (parents) {
 				add_object_array(&parents->item->object,
-						 NULL, &want_obj);
+						 NULL, want_obj);
 				parents = parents->next;
 			}
 			add_object_array(object, NULL, &extra_edge_obj);
@@ -655,7 +658,7 @@ static void send_unshallow(const struct object_array *shallows)
 }
 
 static void deepen(int depth, int deepen_relative,
-		   struct object_array *shallows)
+		   struct object_array *shallows, struct object_array *want_obj)
 {
 	if (depth == INFINITE_DEPTH && !is_repository_shallow(the_repository)) {
 		int i;
@@ -678,38 +681,40 @@ static void deepen(int depth, int deepen_relative,
 	} else {
 		struct commit_list *result;
 
-		result = get_shallow_commits(&want_obj, depth,
+		result = get_shallow_commits(want_obj, depth,
 					     SHALLOW, NOT_SHALLOW);
 		send_shallow(result);
 		free_commit_list(result);
 	}
 
-	send_unshallow(shallows);
+	send_unshallow(shallows, want_obj);
 }
 
 static void deepen_by_rev_list(int ac, const char **av,
-			       struct object_array *shallows)
+			       struct object_array *shallows,
+			       struct object_array *want_obj)
 {
 	struct commit_list *result;
 
 	result = get_shallow_commits_by_rev_list(ac, av, SHALLOW, NOT_SHALLOW);
 	send_shallow(result);
 	free_commit_list(result);
-	send_unshallow(shallows);
+	send_unshallow(shallows, want_obj);
 }
 
 /* Returns 1 if a shallow list is sent or 0 otherwise */
 static int send_shallow_list(int depth, int deepen_rev_list,
 			     timestamp_t deepen_since,
 			     struct string_list *deepen_not,
-			     struct object_array *shallows)
+			     struct object_array *shallows,
+			     struct object_array *want_obj)
 {
 	int ret = 0;
 
 	if (depth > 0 && deepen_rev_list)
 		die("git upload-pack: deepen and deepen-since (or deepen-not) cannot be used together");
 	if (depth > 0) {
-		deepen(depth, deepen_relative, shallows);
+		deepen(depth, deepen_relative, shallows, want_obj);
 		ret = 1;
 	} else if (deepen_rev_list) {
 		struct argv_array av = ARGV_ARRAY_INIT;
@@ -726,11 +731,11 @@ static int send_shallow_list(int depth, int deepen_rev_list,
 			}
 			argv_array_push(&av, "--not");
 		}
-		for (i = 0; i < want_obj.nr; i++) {
-			struct object *o = want_obj.objects[i].item;
+		for (i = 0; i < want_obj->nr; i++) {
+			struct object *o = want_obj->objects[i].item;
 			argv_array_push(&av, oid_to_hex(&o->oid));
 		}
-		deepen_by_rev_list(av.argc, av.argv, shallows);
+		deepen_by_rev_list(av.argc, av.argv, shallows, want_obj);
 		argv_array_clear(&av);
 		ret = 1;
 	} else {
@@ -815,7 +820,7 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
 	return 0;
 }
 
-static void receive_needs(void)
+static void receive_needs(struct object_array *want_obj)
 {
 	struct object_array shallows = OBJECT_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
@@ -893,7 +898,7 @@ static void receive_needs(void)
 			if (!((allow_unadvertised_object_request & ALLOW_ANY_SHA1) == ALLOW_ANY_SHA1
 			      || is_our_ref(o)))
 				has_non_tip = 1;
-			add_object_array(o, NULL, &want_obj);
+			add_object_array(o, NULL, want_obj);
 		}
 	}
 
@@ -905,7 +910,7 @@ static void receive_needs(void)
 	 * by another process that handled the initial request.
 	 */
 	if (has_non_tip)
-		check_non_tip();
+		check_non_tip(want_obj);
 
 	if (!use_sideband && daemon_mode)
 		no_progress = 1;
@@ -914,7 +919,7 @@ static void receive_needs(void)
 		return;
 
 	if (send_shallow_list(depth, deepen_rev_list, deepen_since,
-			      &deepen_not, &shallows))
+			      &deepen_not, &shallows, want_obj))
 		packet_flush(1);
 	object_array_clear(&shallows);
 }
@@ -1040,6 +1045,7 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 void upload_pack(struct upload_pack_options *options)
 {
 	struct string_list symref = STRING_LIST_INIT_DUP;
+	struct object_array want_obj = OBJECT_ARRAY_INIT;
 
 	stateless_rpc = options->stateless_rpc;
 	timeout = options->timeout;
@@ -1063,11 +1069,11 @@ void upload_pack(struct upload_pack_options *options)
 	if (options->advertise_refs)
 		return;
 
-	receive_needs();
+	receive_needs(&want_obj);
 	if (want_obj.nr) {
 		struct object_array have_obj = OBJECT_ARRAY_INIT;
-		get_common_commits(&have_obj);
-		create_pack_file(&have_obj);
+		get_common_commits(&have_obj, &want_obj);
+		create_pack_file(&have_obj, &want_obj);
 	}
 }
 
@@ -1117,7 +1123,7 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	string_list_clear(&data->deepen_not, 0);
 }
 
-static int parse_want(const char *line)
+static int parse_want(const char *line, struct object_array *want_obj)
 {
 	const char *arg;
 	if (skip_prefix(line, "want ", &arg)) {
@@ -1139,7 +1145,7 @@ static int parse_want(const char *line)
 
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
-			add_object_array(o, NULL, &want_obj);
+			add_object_array(o, NULL, want_obj);
 		}
 
 		return 1;
@@ -1148,7 +1154,8 @@ static int parse_want(const char *line)
 	return 0;
 }
 
-static int parse_want_ref(const char *line, struct string_list *wanted_refs)
+static int parse_want_ref(const char *line, struct string_list *wanted_refs,
+			  struct object_array *want_obj)
 {
 	const char *arg;
 	if (skip_prefix(line, "want-ref ", &arg)) {
@@ -1167,7 +1174,7 @@ static int parse_want_ref(const char *line, struct string_list *wanted_refs)
 		o = parse_object_or_die(&oid, arg);
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
-			add_object_array(o, NULL, &want_obj);
+			add_object_array(o, NULL, want_obj);
 		}
 
 		return 1;
@@ -1192,16 +1199,18 @@ static int parse_have(const char *line, struct oid_array *haves)
 }
 
 static void process_args(struct packet_reader *request,
-			 struct upload_pack_data *data)
+			 struct upload_pack_data *data,
+			 struct object_array *want_obj)
 {
 	while (packet_reader_read(request) != PACKET_READ_FLUSH) {
 		const char *arg = request->line;
 		const char *p;
 
 		/* process want */
-		if (parse_want(arg))
+		if (parse_want(arg, want_obj))
 			continue;
-		if (allow_ref_in_want && parse_want_ref(arg, &data->wanted_refs))
+		if (allow_ref_in_want &&
+		    parse_want_ref(arg, &data->wanted_refs, want_obj))
 			continue;
 		/* process have line */
 		if (parse_have(arg, &data->haves))
@@ -1296,7 +1305,8 @@ static int process_haves(struct oid_array *haves, struct oid_array *common,
 }
 
 static int send_acks(struct oid_array *acks, struct strbuf *response,
-		     const struct object_array *have_obj)
+		     const struct object_array *have_obj,
+		     struct object_array *want_obj)
 {
 	int i;
 
@@ -1311,7 +1321,7 @@ static int send_acks(struct oid_array *acks, struct strbuf *response,
 				 oid_to_hex(&acks->oid[i]));
 	}
 
-	if (ok_to_give_up(have_obj)) {
+	if (ok_to_give_up(have_obj, want_obj)) {
 		/* Send Ready */
 		packet_buf_write(response, "ready\n");
 		return 1;
@@ -1321,7 +1331,8 @@ static int send_acks(struct oid_array *acks, struct strbuf *response,
 }
 
 static int process_haves_and_send_acks(struct upload_pack_data *data,
-				       struct object_array *have_obj)
+				       struct object_array *have_obj,
+				       struct object_array *want_obj)
 {
 	struct oid_array common = OID_ARRAY_INIT;
 	struct strbuf response = STRBUF_INIT;
@@ -1330,7 +1341,7 @@ static int process_haves_and_send_acks(struct upload_pack_data *data,
 	process_haves(&data->haves, &common, have_obj);
 	if (data->done) {
 		ret = 1;
-	} else if (send_acks(&common, &response, have_obj)) {
+	} else if (send_acks(&common, &response, have_obj, want_obj)) {
 		packet_buf_delim(&response);
 		ret = 1;
 	} else {
@@ -1366,7 +1377,8 @@ static void send_wanted_ref_info(struct upload_pack_data *data)
 	packet_delim(1);
 }
 
-static void send_shallow_info(struct upload_pack_data *data)
+static void send_shallow_info(struct upload_pack_data *data,
+			      struct object_array *want_obj)
 {
 	/* No shallow info needs to be sent */
 	if (!data->depth && !data->deepen_rev_list && !data->shallows.nr &&
@@ -1377,9 +1389,10 @@ static void send_shallow_info(struct upload_pack_data *data)
 
 	if (!send_shallow_list(data->depth, data->deepen_rev_list,
 			       data->deepen_since, &data->deepen_not,
-			       &data->shallows) &&
+			       &data->shallows, want_obj) &&
 	    is_repository_shallow(the_repository))
-		deepen(INFINITE_DEPTH, data->deepen_relative, &data->shallows);
+		deepen(INFINITE_DEPTH, data->deepen_relative, &data->shallows,
+		       want_obj);
 
 	packet_delim(1);
 }
@@ -1398,6 +1411,8 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 	struct upload_pack_data data;
 	/* NEEDSWORK: make this non-static */
 	static struct object_array have_obj;
+	/* NEEDSWORK: make this non-static */
+	static struct object_array want_obj;
 
 	git_config(upload_pack_config, NULL);
 
@@ -1407,7 +1422,7 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_PROCESS_ARGS:
-			process_args(request, &data);
+			process_args(request, &data, &want_obj);
 
 			if (!want_obj.nr) {
 				/*
@@ -1429,17 +1444,18 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 			}
 			break;
 		case FETCH_SEND_ACKS:
-			if (process_haves_and_send_acks(&data, &have_obj))
+			if (process_haves_and_send_acks(&data, &have_obj,
+							&want_obj))
 				state = FETCH_SEND_PACK;
 			else
 				state = FETCH_DONE;
 			break;
 		case FETCH_SEND_PACK:
 			send_wanted_ref_info(&data);
-			send_shallow_info(&data);
+			send_shallow_info(&data, &want_obj);
 
 			packet_write_fmt(1, "packfile\n");
-			create_pack_file(&have_obj);
+			create_pack_file(&have_obj, &want_obj);
 			state = FETCH_DONE;
 			break;
 		case FETCH_DONE:
-- 
2.19.0.271.gfe8321ec05.dirty

