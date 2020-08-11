Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530F0C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 22:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27CFE206DA
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 22:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t8AwfNTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgHKWwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 18:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgHKWwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 18:52:40 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43865C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 15:52:40 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id k12so321911pfu.19
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 15:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JLTNJIdPFGHLYtuov9coTWsHN6K98zxqpsaIAmq3saU=;
        b=t8AwfNTWjVzS9/jV+hYafK11zPDWq9ZE2BrBQu0dCe8M/geU5rrtlKSBvHj6DCMJV4
         24Ga4hMS7MG3j6t4NsLcanB7sKQvOSqlmfmpZ0AQos9LXXP34DWlE9VgD0dCaQ/X5Eco
         FwokfaLvG+v2FGfDpOTFxhu5SdnxChz9+ZE9agBzGsBODA7CcLUsDwao3w/rEfQ9cTOc
         uknM87YkZxhp2j0sTRRSp6tjnAybY8/aavk5LarLmw6UbfJpBbywZ3DZs8ZyWV/QZV0V
         bklPlJItl8uZMIJItJUHv+js0KyI2pH0G7jEcGze08b7zH2fyWayuFkxC8Q0VTJkYtss
         x6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JLTNJIdPFGHLYtuov9coTWsHN6K98zxqpsaIAmq3saU=;
        b=aVj3hPSIJ5l/EfLUT5D1SlDGdXdNEle8xgzmS7NOpBW2pIapZ5iqUXcpiKMuVRAmOF
         L4v6Wj8nDtEnZMqSiFeEgKOb0g0RG0pYP+d4c1kWmIHmwOHsOwdYx4VP0MZ/awvXtCBy
         444zk6xp4+Vf5eKJ1Dn71QZpIwjcVdcn9jox3/3bwQcru3Q9g90gA+xERmlB7ZvddNKe
         XIv8XEA+Eix60R190faiXzbQbIerxCQ9FtR+BwXUZBTAo+pnq0ujoPKxenzbYjWKBhsR
         WcVbnuKYKWbrl6Gm4vddr2apW8WMGv+kVN7/a1xGWGtCG3uovFifGeFY1ShSMqbq8dad
         3KUA==
X-Gm-Message-State: AOAM530TbLB+OAZG9Ws4ojH+N6VJcE4UBIBtA4j4uMbtdlzzfg5QwN1Y
        CR4EZW4DMNBNCC44nzw0WbXCvrywK8sjArDJwJc9yis+YhdfydNwcHZ6G5jfZElPq2mxMRNNuUW
        PkjhPUO1QoHtZ/zGOt9mEG+wCjP09EaTSvjG9oJSeTj0eOzdZ/dmCGyn+E2YA1SugYJI+brs7+W
        Q3
X-Google-Smtp-Source: ABdhPJzAEF7RedwnN2kjOkhhooFw4X2FHR4TJZWN16xIwcuWmCChAwxvmZO/M7xLEr2YMnwxKM2ViW1XzD89L72sw51C
X-Received: by 2002:a17:90b:3684:: with SMTP id mj4mr3185121pjb.195.1597186359421;
 Tue, 11 Aug 2020 15:52:39 -0700 (PDT)
Date:   Tue, 11 Aug 2020 15:52:22 -0700
In-Reply-To: <cover.1597184948.git.jonathantanmy@google.com>
Message-Id: <e8f16d69089a5011c355d5939c56fa53b7a1eb2d.1597184949.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com> <cover.1597184948.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2 7/7] fetch-pack: remove no_dependents code
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that Git has switched to using a subprocess to lazy-fetch missing
objects, remove the no_dependents code as it is no longer used.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch-pack.c |   4 --
 fetch-pack.c         | 110 ++++++++++++-------------------------------
 fetch-pack.h         |  14 ------
 remote-curl.c        |   6 ---
 transport.c          |   4 --
 transport.h          |   7 ---
 6 files changed, 30 insertions(+), 115 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index bbb5c96167..58b7c1fbdc 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -153,10 +153,6 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.from_promisor = 1;
 			continue;
 		}
-		if (!strcmp("--no-dependents", arg)) {
-			args.no_dependents = 1;
-			continue;
-		}
 		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
 			parse_list_objects_filter(&args.filter_options, arg);
 			continue;
diff --git a/fetch-pack.c b/fetch-pack.c
index 707bbc31fd..3212957dae 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -285,10 +285,8 @@ static int find_common(struct fetch_negotiator *negotiator,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
-	if (!args->no_dependents) {
-		mark_tips(negotiator, args->negotiation_tips);
-		for_each_cached_alternate(negotiator, insert_one_alternate_object);
-	}
+	mark_tips(negotiator, args->negotiation_tips);
+	for_each_cached_alternate(negotiator, insert_one_alternate_object);
 
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
@@ -305,12 +303,8 @@ static int find_common(struct fetch_negotiator *negotiator,
 		 * We use lookup_object here because we are only
 		 * interested in the case we *know* the object is
 		 * reachable and we have already scanned it.
-		 *
-		 * Do this only if args->no_dependents is false (if it is true,
-		 * we cannot trust the object flags).
 		 */
-		if (!args->no_dependents &&
-		    ((o = lookup_object(the_repository, remote)) != NULL) &&
+		if (((o = lookup_object(the_repository, remote)) != NULL) &&
 				(o->flags & COMPLETE)) {
 			continue;
 		}
@@ -410,8 +404,6 @@ static int find_common(struct fetch_negotiator *negotiator,
 	trace2_region_enter("fetch-pack", "negotiation_v0_v1", the_repository);
 	flushes = 0;
 	retval = -1;
-	if (args->no_dependents)
-		goto done;
 	while ((oid = negotiator->next(negotiator))) {
 		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
 		print_verbose(args, "have %s", oid_to_hex(oid));
@@ -666,9 +658,7 @@ struct loose_object_iter {
 
 /*
  * Mark recent commits available locally and reachable from a local ref as
- * COMPLETE. If args->no_dependents is false, also mark COMPLETE remote refs as
- * COMMON_REF (otherwise, we are not planning to participate in negotiation, and
- * thus do not need COMMON_REF marks).
+ * COMPLETE.
  *
  * The cutoff time for recency is determined by this heuristic: it is the
  * earliest commit time of the objects in refs that are commits and that we know
@@ -969,12 +959,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	struct fetch_negotiator negotiator_alloc;
 	struct fetch_negotiator *negotiator;
 
-	if (args->no_dependents) {
-		negotiator = NULL;
-	} else {
-		negotiator = &negotiator_alloc;
-		fetch_negotiator_init(r, negotiator);
-	}
+	negotiator = &negotiator_alloc;
+	fetch_negotiator_init(r, negotiator);
 
 	sort_ref_list(&ref, ref_compare_name);
 	QSORT(sought, nr_sought, cmp_ref_by_name);
@@ -1062,15 +1048,11 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (!server_supports_hash(the_hash_algo->name, NULL))
 		die(_("Server does not support this repository's object format"));
 
-	if (!args->no_dependents) {
-		mark_complete_and_common_ref(negotiator, args, &ref);
-		filter_refs(args, &ref, sought, nr_sought);
-		if (everything_local(args, &ref)) {
-			packet_flush(fd[1]);
-			goto all_done;
-		}
-	} else {
-		filter_refs(args, &ref, sought, nr_sought);
+	mark_complete_and_common_ref(negotiator, args, &ref);
+	filter_refs(args, &ref, sought, nr_sought);
+	if (everything_local(args, &ref)) {
+		packet_flush(fd[1]);
+		goto all_done;
 	}
 	if (find_common(negotiator, args, fd, &oid, ref) < 0)
 		if (!args->keep_pack)
@@ -1119,7 +1101,7 @@ static void add_shallow_requests(struct strbuf *req_buf,
 		packet_buf_write(req_buf, "deepen-relative\n");
 }
 
-static void add_wants(int no_dependents, const struct ref *wants, struct strbuf *req_buf)
+static void add_wants(const struct ref *wants, struct strbuf *req_buf)
 {
 	int use_ref_in_want = server_supports_feature("fetch", "ref-in-want", 0);
 
@@ -1136,12 +1118,8 @@ static void add_wants(int no_dependents, const struct ref *wants, struct strbuf
 		 * We use lookup_object here because we are only
 		 * interested in the case we *know* the object is
 		 * reachable and we have already scanned it.
-		 *
-		 * Do this only if args->no_dependents is false (if it is true,
-		 * we cannot trust the object flags).
 		 */
-		if (!no_dependents &&
-		    ((o = lookup_object(the_repository, remote)) != NULL) &&
+		if (((o = lookup_object(the_repository, remote)) != NULL) &&
 		    (o->flags & COMPLETE)) {
 			continue;
 		}
@@ -1275,19 +1253,14 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	}
 
 	/* add wants */
-	add_wants(args->no_dependents, wants, &req_buf);
+	add_wants(wants, &req_buf);
 
-	if (args->no_dependents) {
-		packet_buf_write(&req_buf, "done");
-		ret = 1;
-	} else {
-		/* Add all of the common commits we've found in previous rounds */
-		add_common(&req_buf, common);
+	/* Add all of the common commits we've found in previous rounds */
+	add_common(&req_buf, common);
 
-		/* Add initial haves */
-		ret = add_haves(negotiator, seen_ack, &req_buf,
-				haves_to_send, in_vain);
-	}
+	/* Add initial haves */
+	ret = add_haves(negotiator, seen_ack, &req_buf,
+			haves_to_send, in_vain);
 
 	/* Send request */
 	packet_buf_flush(&req_buf);
@@ -1547,12 +1520,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
 	int i;
 
-	if (args->no_dependents) {
-		negotiator = NULL;
-	} else {
-		negotiator = &negotiator_alloc;
-		fetch_negotiator_init(r, negotiator);
-	}
+	negotiator = &negotiator_alloc;
+	fetch_negotiator_init(r, negotiator);
 
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
@@ -1576,21 +1545,16 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				args->deepen = 1;
 
 			/* Filter 'ref' by 'sought' and those that aren't local */
-			if (!args->no_dependents) {
-				mark_complete_and_common_ref(negotiator, args, &ref);
-				filter_refs(args, &ref, sought, nr_sought);
-				if (everything_local(args, &ref))
-					state = FETCH_DONE;
-				else
-					state = FETCH_SEND_REQUEST;
-
-				mark_tips(negotiator, args->negotiation_tips);
-				for_each_cached_alternate(negotiator,
-							  insert_one_alternate_object);
-			} else {
-				filter_refs(args, &ref, sought, nr_sought);
+			mark_complete_and_common_ref(negotiator, args, &ref);
+			filter_refs(args, &ref, sought, nr_sought);
+			if (everything_local(args, &ref))
+				state = FETCH_DONE;
+			else
 				state = FETCH_SEND_REQUEST;
-			}
+
+			mark_tips(negotiator, args->negotiation_tips);
+			for_each_cached_alternate(negotiator,
+						  insert_one_alternate_object);
 			break;
 		case FETCH_SEND_REQUEST:
 			if (!negotiation_started) {
@@ -1911,20 +1875,6 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 	if (nr_sought)
 		nr_sought = remove_duplicates_in_refs(sought, nr_sought);
 
-	if (args->no_dependents && !args->filter_options.choice) {
-		/*
-		 * The protocol does not support requesting that only the
-		 * wanted objects be sent, so approximate this by setting a
-		 * "blob:none" filter if no filter is already set. This works
-		 * for all object types: note that wanted blobs will still be
-		 * sent because they are directly specified as a "want".
-		 *
-		 * NEEDSWORK: Add an option in the protocol to request that
-		 * only the wanted objects be sent, and implement it.
-		 */
-		parse_list_objects_filter(&args->filter_options, "blob:none");
-	}
-
 	if (version != protocol_v2 && !ref) {
 		packet_flush(fd[1]);
 		die(_("no matching remote head"));
diff --git a/fetch-pack.h b/fetch-pack.h
index 85d1e39fe7..bbe2938059 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -42,20 +42,6 @@ struct fetch_pack_args {
 	unsigned deepen:1;
 	unsigned from_promisor:1;
 
-	/*
-	 * Attempt to fetch only the wanted objects, and not any objects
-	 * referred to by them. Due to protocol limitations, extraneous
-	 * objects may still be included. (When fetching non-blob
-	 * objects, only blobs are excluded; when fetching a blob, the
-	 * blob itself will still be sent. The client does not need to
-	 * know whether a wanted object is a blob or not.)
-	 *
-	 * If 1, fetch_pack() will also not modify any object flags.
-	 * This allows fetch_pack() to safely be called by any function,
-	 * regardless of which object flags it uses (if any).
-	 */
-	unsigned no_dependents:1;
-
 	/*
 	 * Because fetch_pack() overwrites the shallow file upon a
 	 * successful deepening non-clone fetch, if this struct
diff --git a/remote-curl.c b/remote-curl.c
index 5cbc6e5002..a0c81a64bc 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -40,7 +40,6 @@ struct options {
 		push_cert : 2,
 		deepen_relative : 1,
 		from_promisor : 1,
-		no_dependents : 1,
 		atomic : 1,
 		object_format : 1;
 	const struct git_hash_algo *hash_algo;
@@ -186,9 +185,6 @@ static int set_option(const char *name, const char *value)
 	} else if (!strcmp(name, "from-promisor")) {
 		options.from_promisor = 1;
 		return 0;
-	} else if (!strcmp(name, "no-dependents")) {
-		options.no_dependents = 1;
-		return 0;
 	} else if (!strcmp(name, "filter")) {
 		options.filter = xstrdup(value);
 		return 0;
@@ -1171,8 +1167,6 @@ static int fetch_git(struct discovery *heads,
 		argv_array_push(&args, "--deepen-relative");
 	if (options.from_promisor)
 		argv_array_push(&args, "--from-promisor");
-	if (options.no_dependents)
-		argv_array_push(&args, "--no-dependents");
 	if (options.filter)
 		argv_array_pushf(&args, "--filter=%s", options.filter);
 	argv_array_push(&args, url.buf);
diff --git a/transport.c b/transport.c
index b41386eccb..32e1f21f0c 100644
--- a/transport.c
+++ b/transport.c
@@ -232,9 +232,6 @@ static int set_git_option(struct git_transport_options *opts,
 	} else if (!strcmp(name, TRANS_OPT_FROM_PROMISOR)) {
 		opts->from_promisor = !!value;
 		return 0;
-	} else if (!strcmp(name, TRANS_OPT_NO_DEPENDENTS)) {
-		opts->no_dependents = !!value;
-		return 0;
 	} else if (!strcmp(name, TRANS_OPT_LIST_OBJECTS_FILTER)) {
 		list_objects_filter_die_if_populated(&opts->filter_options);
 		parse_list_objects_filter(&opts->filter_options, value);
@@ -359,7 +356,6 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.cloning = transport->cloning;
 	args.update_shallow = data->options.update_shallow;
 	args.from_promisor = data->options.from_promisor;
-	args.no_dependents = data->options.no_dependents;
 	args.filter_options = data->options.filter_options;
 	args.stateless_rpc = transport->stateless_rpc;
 	args.server_options = transport->server_options;
diff --git a/transport.h b/transport.h
index b3c30133ea..7aa1f33145 100644
--- a/transport.h
+++ b/transport.h
@@ -16,7 +16,6 @@ struct git_transport_options {
 	unsigned update_shallow : 1;
 	unsigned deepen_relative : 1;
 	unsigned from_promisor : 1;
-	unsigned no_dependents : 1;
 
 	/*
 	 * If this transport supports connect or stateless-connect,
@@ -201,12 +200,6 @@ void transport_check_allowed(const char *type);
 /* Indicate that these objects are being fetched by a promisor */
 #define TRANS_OPT_FROM_PROMISOR "from-promisor"
 
-/*
- * Indicate that only the objects wanted need to be fetched, not their
- * dependents
- */
-#define TRANS_OPT_NO_DEPENDENTS "no-dependents"
-
 /* Filter objects for partial clone and fetch */
 #define TRANS_OPT_LIST_OBJECTS_FILTER "filter"
 
-- 
2.28.0.236.gb10cc79966-goog

