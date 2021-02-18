Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529A4C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 01:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25A364DFF
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 01:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhBRBVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 20:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBRBVp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 20:21:45 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5E3C061756
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 17:21:05 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id f7so372361pgp.19
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 17:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=MCtGmKsWq6l9mU5dZCNe2JeoV3UiGaSgxC8OGhcuYss=;
        b=N5Si72cbtOv4utwJr/TjOsPQV0pIa0Cf6mLoOkpxTUcnDPF2K/Q8Tb/HLibl0A7I0r
         Hit47D1pWV+P5dzSBuh0m4jhXcruA1DMSMwpNX9BzEbcCwspMge17x5oFBOvaQJfn0kJ
         H8NvYGGkyROSN6/Q3s40eN8TfI8yqywfR95qYqFpFVEurSj9ubxIW7efxj81lPpT+WTF
         mkBmKDSVC0F8zxg8jLPXbF/tJchtYMj8wgaxCri5PwJxzN+ZQdZv8fnOPd+hGn2R8qzX
         Qt5bAkWX5qTuqVwgSHXJBhn8g5DlRurzjsvWV+oHQ1gDPISql58UBm6L4vGnNspp1MIU
         FtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=MCtGmKsWq6l9mU5dZCNe2JeoV3UiGaSgxC8OGhcuYss=;
        b=DVoUCWfs7QzPlM44uBa3qX/MhVeRxhtZ9+qp0kxxGiIOczUowzv+eB1FoPflBLN7fL
         4TUgwIxZ3HmQegvRKGyimiFw663AYBpVpXmqjwLdZSqXladxlL8XFLGjHJJLhtjIgs5t
         pRlznUOCitRXWjnXhheKjbjSzYK8LNe6WKfT30ah9X10y/4Jtbq3ZuCkiWr8leNId/c1
         CetRmp2/VryUReW5AxD7yKSaS2C4i4qVtWMlAIeX24wB8LOzVAIZWxJwHIl5SaHNs354
         oxICWG7B3H25q5HHWuPIVSmuaxOs8arI63jrK+1p6f6YNsiyidEwm6aEbc9BUxW/UwLm
         uNDw==
X-Gm-Message-State: AOAM531NhJSR0edX72jUdTis5ejikHnSp59EjCBnoP/uTZV2suToiw/A
        te4zrEssulQmqM1PNQZuYLFxsIfvaO5kkMU6gd0JRmPxEyOddJbYNuJrzSn4A3P9A15QVylyRf8
        f8D0CiT9hiyaE8ywmawsaYU7Ht6+zG4ORQvWj2hr1I/88lz+TWaC3myWWTDuUp1R254rzu6rQ4w
        ZS
X-Google-Smtp-Source: ABdhPJxjD03hXKajfqVk2pVyzcsJn6GdUkYHweTG+erHo/byXRCW03/wOJJ+DUA6KzS3gQoq5reiLcdNlTPmRpMZSXKv
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:ad8f:: with SMTP id
 s15mr1267126pjq.119.1613611264859; Wed, 17 Feb 2021 17:21:04 -0800 (PST)
Date:   Wed, 17 Feb 2021 17:21:00 -0800
Message-Id: <20210218012100.928957-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [RFC PATCH] push: perform negotiation before sending packfile
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The idea of adding negotiation to push has been floating around for a
while. Here's my implementation of my idea of reusing a lot of the fetch
mechanism to perform the negotiation.

The basic idea is that when a client pushes, the client will first
perform the negotiation steps that it normally does during a fetch,
except that it does not send any "want"s and it only uses the commits to
be pushed as negotiation tips (instead of all refs). Once the client has
received enough ACKs that all ancestral paths from all tips to the
original orphans are blocked by ACKed commits, it will proceed with the
push, using this information to determine the contents of the
to-be-pushed packfile. (This check is done by the server when doing a
user-triggered fetch.) This requires a minimal change on the server to
accept an argument that tells the server that it cannot take the
initiative to send the packfile, and to allow the client to not send any
"want"s.

The main features (which are implemented in this patch) are:

 - Minimal change to the fetch-serving part of the server, as described
   (new "wait-for-done" argument that inhibits the server taking the
   initiative to send the packfile, and to allow the client to not send
   any "want"s).
 - No change needed to the push-serving part of the server, although for
   performance, we would want something that can stop the ref
   advertisement since it is no longer needed (perhaps a simplification
   of my earlier work [1]).
 - Reuse of a lot of fetch code.
 - We inherit any fetch negotiation algorithm improvements (e.g. the
   "skipping" negotiator).

What hasn't been done yet:

 - Refactor negotiation tip code that I copied over from builtin/fetch.c
   to builtin/fetch-pack.c.
 - Non-main-path cases (e.g. if the server doesn't support this new
   "wait-for-done")
 - Certain optimizations like avoiding the ls-refs call when negotiating
 - Config option on the client to enable/disable this feature
 - Do we need statistics in the commit message to show the performance
   gains?
 - Anything else that comes up upon more scrutiny

Any comments are welcome, especially if you have ideas about the overall
design or implementation, and/or if you've thought about similar things
before.

[1] https://lore.kernel.org/git/20201109224732.2549561-1-jonathantanmy@google.com/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch-pack.c  | 57 +++++++++++++++++++++++++++++++++++++++++++
 fetch-pack.c          | 49 ++++++++++++++++++++++++++++++++++---
 fetch-pack.h          |  6 +++++
 object.h              |  2 +-
 send-pack.c           | 51 +++++++++++++++++++++++++++++++++++---
 t/t5510-fetch.sh      | 19 +++++++++++++++
 t/t5516-fetch-push.sh | 24 ++++++++++++++++++
 transport.c           |  1 +
 transport.h           |  5 ++++
 upload-pack.c         | 16 +++++++++---
 10 files changed, 217 insertions(+), 13 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 58b7c1fbdc..c8c942b42c 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -5,6 +5,8 @@
 #include "connect.h"
 #include "oid-array.h"
 #include "protocol.h"
+#include "oidset.h"
+#include "refs.h"
 
 static const char fetch_pack_usage[] =
 "git fetch-pack [--all] [--stdin] [--quiet | -q] [--keep | -k] [--thin] "
@@ -40,6 +42,39 @@ static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
 	(*sought)[*nr - 1] = ref;
 }
 
+static int add_oid(const char *refname, const struct object_id *oid, int flags,
+		   void *cb_data)
+{
+	struct oid_array *oids = cb_data;
+
+	oid_array_append(oids, oid);
+	return 0;
+}
+
+static void add_negotiation_tips(struct fetch_pack_args *args, struct string_list *negotiation_tip)
+{
+	struct oid_array *oids = xcalloc(1, sizeof(*oids));
+	int i;
+
+	for (i = 0; i < negotiation_tip->nr; i++) {
+		const char *s = negotiation_tip->items[i].string;
+		int old_nr;
+		if (!has_glob_specials(s)) {
+			struct object_id oid;
+			if (get_oid(s, &oid))
+				die("%s is not a valid object", s);
+			oid_array_append(oids, &oid);
+			continue;
+		}
+		old_nr = oids->nr;
+		for_each_glob_ref(add_oid, s, oids);
+		if (old_nr == oids->nr)
+			warning("Ignoring --negotiation-tip=%s because it does not match any refs",
+				s);
+	}
+	args->negotiation_tips = oids;
+}
+
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, ret;
@@ -54,6 +89,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	struct fetch_pack_args args;
 	struct oid_array shallow = OID_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
+	struct string_list negotiation_tip = STRING_LIST_INIT_DUP;
+	struct oidset acked_commits = OIDSET_INIT;
 	struct packet_reader reader;
 	enum protocol_version version;
 
@@ -161,10 +198,20 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			list_objects_filter_set_no_filter(&args.filter_options);
 			continue;
 		}
+		if (skip_prefix(arg, "--negotiation-tip=", &arg)) {
+			string_list_append(&negotiation_tip, arg);
+			continue;
+		}
+		if (!strcmp("--negotiate-only", arg)) {
+			args.acked_commits = &acked_commits;
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
 	if (deepen_not.nr)
 		args.deepen_not = &deepen_not;
+	if (negotiation_tip.nr)
+		add_negotiation_tips(&args, &negotiation_tip);
 
 	if (i < argc)
 		dest = argv[i++];
@@ -232,6 +279,16 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 
 	ref = fetch_pack(&args, fd, ref, sought, nr_sought,
 			 &shallow, pack_lockfiles_ptr, version);
+	if (args.acked_commits) {
+		struct oidset_iter iter;
+		const struct object_id *oid;
+		oidset_iter_init(args.acked_commits, &iter);
+
+		while ((oid = oidset_iter_next(&iter))) {
+			printf("%s\n", oid_to_hex(oid));
+		}
+		return 0;
+	}
 	if (pack_lockfiles.nr) {
 		int i;
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 1eaedcb5dc..4d2c6119f1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -23,6 +23,7 @@
 #include "fetch-negotiator.h"
 #include "fsck.h"
 #include "shallow.h"
+#include "commit-reach.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -44,6 +45,8 @@ static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 /* Remember to update object flag allocation in object.h */
 #define COMPLETE	(1U << 0)
 #define ALTERNATE	(1U << 1)
+#define COMMON		(1U << 6)
+#define REACH_SCRATCH	(1U << 7)
 
 /*
  * After sending this many "have"s if we do not get any new ACK , we
@@ -1224,6 +1227,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 		packet_buf_write(&req_buf, "ofs-delta");
 	if (sideband_all)
 		packet_buf_write(&req_buf, "sideband-all");
+	if (args->acked_commits)
+		packet_buf_write(&req_buf, "wait-for-done");
 
 	/* Add shallow-info and deepen request */
 	if (server_supports_feature("fetch", "shallow", 0))
@@ -1324,12 +1329,15 @@ enum common_found {
 	 * "ready" was received, indicating that the server is ready to send
 	 * the packfile without any further negotiation.
 	 */
-	READY
+	READY,
+
+	CLOSURE
 };
 
 static enum common_found process_acks(struct fetch_negotiator *negotiator,
 				      struct packet_reader *reader,
-				      struct oidset *common)
+				      struct oidset *common,
+				      struct object_array *negotiation_tips)
 {
 	/* received */
 	int received_ready = 0;
@@ -1351,6 +1359,8 @@ static enum common_found process_acks(struct fetch_negotiator *negotiator,
 				commit = lookup_commit(the_repository, &oid);
 				if (negotiator)
 					negotiator->ack(negotiator, commit);
+				if (negotiation_tips)
+					commit->object.flags |= COMMON;
 			}
 			continue;
 		}
@@ -1379,6 +1389,13 @@ static enum common_found process_acks(struct fetch_negotiator *negotiator,
 	if (!received_ready && reader->status != PACKET_READ_FLUSH)
 		die(_("expected no other sections to be sent after no 'ready'"));
 
+	if (negotiation_tips) {
+		if (can_all_from_reach_with_flag(negotiation_tips, COMMON,
+						    REACH_SCRATCH, 0,
+						    GENERATION_NUMBER_ZERO))
+			return CLOSURE;
+	}
+
 	return received_ready ? READY :
 		(received_ack ? COMMON_FOUND : NO_COMMON_FOUND);
 }
@@ -1509,6 +1526,14 @@ static void do_check_stateless_delimiter(const struct fetch_pack_args *args,
 				  _("git fetch-pack: expected response end packet"));
 }
 
+static int add_to_object_array(const struct object_id *oid, void *data)
+{
+	struct object_array *a = data;
+
+	add_object_array(parse_object(the_repository, oid), "", a);
+	return 0;
+}
+
 static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				    int fd[2],
 				    const struct ref *orig_ref,
@@ -1527,6 +1552,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct fetch_negotiator negotiator_alloc;
 	struct fetch_negotiator *negotiator;
 	int seen_ack = 0;
+	struct object_array negotiation_tips_object_array = OBJECT_ARRAY_INIT;
 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
 	int i;
 
@@ -1542,6 +1568,11 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		reader.me = "fetch-pack";
 	}
 
+	if (args->acked_commits)
+		oid_array_for_each((struct oid_array *) args->negotiation_tips,
+				   add_to_object_array,
+				   &negotiation_tips_object_array);
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
@@ -1557,7 +1588,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			mark_complete_and_common_ref(negotiator, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);
-			if (everything_local(args, &ref))
+			if (!args->acked_commits && everything_local(args, &ref))
 				state = FETCH_DONE;
 			else
 				state = FETCH_SEND_REQUEST;
@@ -1574,6 +1605,11 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 						    the_repository);
 			}
 			if (send_fetch_request(negotiator, fd[1], args, ref,
+					       /*
+						* If using acked_commits, we
+						* want an empty oidset here, so
+						* &common is used in all cases.
+						*/
 					       &common,
 					       &haves_to_send, &in_vain,
 					       reader.use_sideband,
@@ -1584,7 +1620,12 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			break;
 		case FETCH_PROCESS_ACKS:
 			/* Process ACKs/NAKs */
-			switch (process_acks(negotiator, &reader, &common)) {
+			switch (process_acks(negotiator, &reader,
+					     args->acked_commits ? args->acked_commits : &common,
+					     args->acked_commits ? &negotiation_tips_object_array : NULL)) {
+			case CLOSURE:
+				state = FETCH_DONE;
+				break;
 			case READY:
 				/*
 				 * Don't check for response delimiter; get_pack() will
diff --git a/fetch-pack.h b/fetch-pack.h
index 736a3dae46..3fc8ba6126 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -23,6 +23,12 @@ struct fetch_pack_args {
 	 */
 	const struct oid_array *negotiation_tips;
 
+	/*
+	 * If not NULL, fetch-pack will not fetch any packs but will only store
+	 * in here commits ACKed by the server during negotiation.
+	 */
+	struct oidset *acked_commits;
+
 	unsigned deepen_relative:1;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
diff --git a/object.h b/object.h
index 59daadce21..4806fa8e66 100644
--- a/object.h
+++ b/object.h
@@ -60,7 +60,7 @@ struct object_array {
 /*
  * object flag allocation:
  * revision.h:               0---------10         15             23------26
- * fetch-pack.c:             01
+ * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
  * upload-pack.c:                4       11-----14  16-----19
diff --git a/send-pack.c b/send-pack.c
index 9045f8a082..f846b408c7 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -56,7 +56,7 @@ static void feed_object(const struct object_id *oid, FILE *fh, int negative)
 /*
  * Make a pack stream and spit it out into file descriptor fd
  */
-static int pack_objects(int fd, struct ref *refs, struct oid_array *extra, struct send_pack_args *args)
+static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised, struct oid_array *negotiated, struct send_pack_args *args)
 {
 	/*
 	 * The child becomes pack-objects --revs; we feed
@@ -94,8 +94,10 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *extra, struc
 	 * parameters by writing to the pipe.
 	 */
 	po_in = xfdopen(po.in, "w");
-	for (i = 0; i < extra->nr; i++)
-		feed_object(&extra->oid[i], po_in, 1);
+	for (i = 0; i < advertised->nr; i++)
+		feed_object(&advertised->oid[i], po_in, 1);
+	for (i = 0; i < negotiated->nr; i++)
+		feed_object(&negotiated->oid[i], po_in, 1);
 
 	while (refs) {
 		if (!is_null_oid(&refs->old_oid))
@@ -409,11 +411,49 @@ static void reject_invalid_nonce(const char *nonce, int len)
 	}
 }
 
+static void get_commons_through_negotiation(const char *url,
+					    const struct ref *remote_refs,
+					    struct oid_array *commons)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+	const struct ref *ref;
+	int len = the_hash_algo->hexsz + 1; /* hash + NL */
+
+	child.git_cmd = 1;
+	child.no_stdin = 1;
+	child.out = -1;
+	strvec_pushl(&child.args, "fetch-pack", "--negotiate-only", NULL);
+	for (ref = remote_refs; ref; ref = ref->next)
+		strvec_pushf(&child.args, "--negotiation-tip=%s", oid_to_hex(&ref->new_oid));
+	strvec_push(&child.args, url);
+
+	if (start_command(&child))
+		die(_("send-pack: unable to fork off fetch-pack subprocess"));
+
+	do {
+		char hex_hash[GIT_MAX_HEXSZ + 1];
+		int read_len = read_in_full(child.out, hex_hash, len);
+		struct object_id oid;
+		const char *end;
+
+		if (!read_len)
+			return;
+		if (read_len != len)
+			die("invalid length read %d", read_len);
+		if (parse_oid_hex(hex_hash, &oid, &end) || *end != '\n')
+			die("invalid hash");
+		oid_array_append(commons, &oid);
+	} while (1);
+
+	finish_command(&child);
+}
+
 int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs,
 	      struct oid_array *extra_have)
 {
+	struct oid_array commons = OID_ARRAY_INIT;
 	int in = fd[0];
 	int out = fd[1];
 	struct strbuf req_buf = STRBUF_INIT;
@@ -437,6 +477,9 @@ int send_pack(struct send_pack_args *args,
 	const char *push_cert_nonce = NULL;
 	struct packet_reader reader;
 
+	if (getenv("GIT_TEST_PUSH_NEGOTIATION"))
+		get_commons_through_negotiation(args->url, remote_refs, &commons);
+
 	git_config_get_bool("transfer.advertisesid", &advertise_sid);
 
 	/* Does the other end support the reporting? */
@@ -625,7 +668,7 @@ int send_pack(struct send_pack_args *args,
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	if (need_pack_data && cmds_sent) {
-		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
+		if (pack_objects(out, remote_refs, extra_have, &commons, args) < 0) {
 			if (args->stateless_rpc)
 				close(out);
 			if (git_connection_is_socket(conn))
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 42f5503004..3b87a411a5 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1214,6 +1214,25 @@ test_expect_success '--negotiation-tip understands abbreviated SHA-1' '
 	check_negotiation_tip
 '
 
+test_expect_success '--negotiate-only' '
+	rm -rf server client trace &&
+
+	git init server &&
+	test_commit -C server one &&
+	test_commit -C server two &&
+
+	git clone "file://$(pwd)/server" client &&
+	test_commit -C client three &&
+
+	git -C client for-each-ref &&
+	git -C client fetch-pack \
+		--negotiate-only \
+		--negotiation-tip=$(git -C client rev-parse HEAD) \
+		"file://$(pwd)/server" >out &&
+	COMMON=$(git -C server rev-parse two) &&
+	grep "$COMMON" out
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 15262b4192..684f4a7fc8 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -191,6 +191,30 @@ test_expect_success 'fetch with pushInsteadOf (should not rewrite)' '
 	)
 '
 
+grep_wrote () {
+	object_count=$1
+	file_name=$2
+	grep 'write_pack_file/wrote.*"value":"'$1'"' $2
+}
+
+
+test_expect_success 'push with negotiation' '
+	mk_empty testrepo &&
+	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
+	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
+	echo now pushing without negotiation &&
+	GIT_TRACE2_EVENT="$(pwd)/event" git push testrepo refs/heads/main:refs/remotes/origin/main &&
+	grep_wrote 5 event && # 2 commits, 2 trees, 1 blob
+
+	rm event &&
+	mk_empty testrepo &&
+	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
+	git -C testrepo config receivePack.hideRefs refs/remotes/origin/first_commit &&
+	echo now pushing with negotiation &&
+	GIT_TEST_PUSH_NEGOTIATION=1 GIT_TRACE2_EVENT="$(pwd)/event" git push testrepo refs/heads/main:refs/remotes/origin/main &&
+	grep_wrote 2 event # 1 commit, 1 tree
+'
+
 test_expect_success 'push without wildcard' '
 	mk_empty testrepo &&
 
diff --git a/transport.c b/transport.c
index 679a35e7c1..0c2925bb12 100644
--- a/transport.c
+++ b/transport.c
@@ -370,6 +370,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.stateless_rpc = transport->stateless_rpc;
 	args.server_options = transport->server_options;
 	args.negotiation_tips = data->options.negotiation_tips;
+	args.acked_commits = data->options.acked_commits;
 
 	if (!data->got_remote_heads) {
 		int i;
diff --git a/transport.h b/transport.h
index 24558c027d..b6659f8aa6 100644
--- a/transport.h
+++ b/transport.h
@@ -46,6 +46,11 @@ struct git_transport_options {
 	 * transport_set_option().
 	 */
 	struct oid_array *negotiation_tips;
+
+	/*
+	 * See fetch-pack.h for more information.
+	 */
+	struct oidset *acked_commits;
 };
 
 enum transport_family {
diff --git a/upload-pack.c b/upload-pack.c
index 4ab55ce2b5..bdca9daf7d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -103,6 +103,7 @@ struct upload_pack_data {
 	unsigned use_ofs_delta : 1;
 	unsigned no_progress : 1;
 	unsigned use_include_tag : 1;
+	unsigned wait_for_done : 1;
 	unsigned allow_filter : 1;
 	unsigned allow_filter_fallback : 1;
 	unsigned long tree_filter_max_depth;
@@ -1503,6 +1504,10 @@ static void process_args(struct packet_reader *request,
 			data->done = 1;
 			continue;
 		}
+		if (!strcmp(arg, "wait-for-done")) {
+			data->wait_for_done = 1;
+			continue;
+		}
 
 		/* Shallow related arguments */
 		if (process_shallow(arg, &data->shallows))
@@ -1585,7 +1590,7 @@ static int send_acks(struct upload_pack_data *data, struct oid_array *acks)
 				    oid_to_hex(&acks->oid[i]));
 	}
 
-	if (ok_to_give_up(data)) {
+	if (!data->wait_for_done && ok_to_give_up(data)) {
 		/* Send Ready */
 		packet_writer_write(&data->writer, "ready\n");
 		return 1;
@@ -1675,10 +1680,13 @@ int upload_pack_v2(struct repository *r, struct strvec *keys,
 		case FETCH_PROCESS_ARGS:
 			process_args(request, &data);
 
-			if (!data.want_obj.nr) {
+			if (!data.want_obj.nr && !data.wait_for_done) {
 				/*
-				 * Request didn't contain any 'want' lines,
-				 * guess they didn't want anything.
+				 * Request didn't contain any 'want' lines (and
+				 * the request does not contain
+				 * "wait-for-done", in which it is reasonable
+				 * to just send 'have's without 'want's); guess
+				 * they didn't want anything.
 				 */
 				state = FETCH_DONE;
 			} else if (data.haves.nr) {
-- 
2.30.0.478.g8a0d178c01-goog

