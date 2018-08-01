Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1189E1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 20:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbeHAWAy (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 18:00:54 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:35762 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbeHAWAy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 18:00:54 -0400
Received: by mail-qt0-f201.google.com with SMTP id x26-v6so16807232qtb.2
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 13:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g+KOHVUMabnTtI+DzIsoNKphio3oba+xgJtCda2wv6I=;
        b=LOSmAb1UrwkiQDl/4gjPyabWLj4YLgXD3uMIu2vJZ/xMh+MUeCVXT3ipsQHufwdBdr
         woda6oe2exdmUzkdoJVU08CTyIu2YaL5mjCtvrgtBNY7gjqnfArYgGfB5mQa0OcdODRo
         aoJUnFKsi+twmKsRhh2dGC1IWhCjthrNFttY1Ay4L1GjeWriuH0IYcKRCRkkp2F77l1f
         RQbnAP7ruPjvkx1H1VFSGfNEZSn8JEzfMhNm9o9YjCsKr4Us4VCUP6D1kXRCjg/PB+iV
         0YHLIg/rEI3eL0ub2EkCQZNVaMCt0VL3JdQaFkwZ3jytVDud+aA+1nNjN5Mg1TJDfKFO
         fcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g+KOHVUMabnTtI+DzIsoNKphio3oba+xgJtCda2wv6I=;
        b=i7IxVuoOjuKR0JZD6IzSX5kN1OT53/So9f7+Cvo+3oA74OLnK3zI9C/DCTHAZbeRMt
         b64A6UyWOS4h2pg+EPc9xQ2mXOle3DZpz32pqP7IB/pCGznqxbfqlPVHONDCgg/DOYah
         zKabNJ2nmPEkeCxAVM90T3299yD3hopq94LccK/yeYT3zqKQjIQFo5xxI2FhALoSnliz
         ItExgnCHWgSejhMMLPd8ECfcReHfOzli74qTWmpgd8646wWOHo4ReJE62/vSm+sqpODT
         pga093wEx3oJILxOLXRK+jdzK4w0qv3Lo+99lqfwxQbkswstEiAZ31L9hoSWzmhcPbB7
         2iNg==
X-Gm-Message-State: AOUpUlEcNwRcTx9uOOxl4GJzJMr6UtBoZLhhi67pLWIubNBtt8B4oRJ+
        12h+V/ydSrp0wTF5FEeYDXohkJ3EtaTqVbBGyxEhjBVcarBhaVOMQituyTsmqRPE5xpxVH/8Uy0
        KZCHbO/NonO+vzGzIqEqdtxuTKEMcp6QCU38Vl8Qn/ZGe77X68fbSr2wzfgoNvxV/1znYcZIDYM
        W2
X-Google-Smtp-Source: AAOMgpcKXLcwyvuwvYezh2RN4F3VBBLSV3E0lQCKxjeDu6x6gFKhsB7o7bDJsNHNHNwKIQs31u6CuRXdFV/he9anwaf8
X-Received: by 2002:a0c:be06:: with SMTP id k6-v6mr15012828qvg.56.1533154404898;
 Wed, 01 Aug 2018 13:13:24 -0700 (PDT)
Date:   Wed,  1 Aug 2018 13:13:20 -0700
In-Reply-To: <20180729121900.GA16770@sigill.intra.peff.net>
Message-Id: <20180801201320.201133-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20180729121900.GA16770@sigill.intra.peff.net>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH] fetch-pack: unify ref in and out param
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com, bmwill@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a user fetches:
 - at least one up-to-date ref and at least one non-up-to-date ref,
 - using HTTP with protocol v0 (or something else that uses the fetch
   command of a remote helper)
some refs might not be updated after the fetch.

This bug was introduced in commit 989b8c4452 ("fetch-pack: put shallow
info in output parameter", 2018-06-28) which allowed transports to
report the refs that they have fetched in a new out-parameter
"fetched_refs". If they do so, transport_fetch_refs() makes this
information available to its caller.

Users of "fetched_refs" rely on the following 3 properties:
 (1) it is the complete list of refs that was passed to
     transport_fetch_refs(),
 (2) it has shallow information (REF_STATUS_REJECT_SHALLOW set if
     relevant), and
 (3) it has updated OIDs if ref-in-want was used (introduced after
     989b8c4452).

In an effort to satisfy (1), whenever transport_fetch_refs()
filters the refs sent to the transport, it re-adds the filtered refs to
whatever the transport supplies before returning it to the user.
However, the implementation in 989b8c4452 unconditionally re-adds the
filtered refs without checking if the transport refrained from reporting
anything in "fetched_refs" (which it is allowed to do), resulting in an
incomplete list, no longer satisfying (1).

An earlier effort to resolve this [1] solved the issue by readding the
filtered refs only if the transport did not refrain from reporting in
"fetched_refs", but after further discussion, it seems that the better
solution is to revert the API change that introduced "fetched_refs".
This API change was first suggested as part of a ref-in-want
implementation that allowed for ref patterns and, thus, there could be
drastic differences between the input refs and the refs actually fetched
[2]; we eventually decided to only allow exact ref names, but this API
change remained even though its necessity was decreased.

Therefore, revert this API change by reverting commit 989b8c4452, and
make receive_wanted_refs() update the OIDs in the sought array (like how
update_shallow() updates shallow information in the sought array)
instead. A test is also included to show that the user-visible bug
discussed at the beginning of this commit message no longer exists.

[1] https://public-inbox.org/git/20180801171806.GA122458@google.com/
[2] https://public-inbox.org/git/86a128c5fb710a41791e7183207c4d64889f9307.1485381677.git.jonathantanmy@google.com/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I now think that it's better to revert the API change introducing
"fetched_refs" (or as Peff describes it, "this whole 'return the fetched
refs' scheme from 989b8c4452"), so here is a patch doing so. I hope to
have covered all of Peff's and Junio's questions in the commit message.

As for Brandon's question:

> I haven't thought too much about what we would need to do in the event
> we add patterns to ref-in-want, but couldn't we possible mutate the
> input list again in this case and just simply add the resulting refs to
> the input list?

If we support ref patterns, we would need to support deletion of refs,
not just addition (because a ref might have existed in the initial ref
advertisement, but not when the packfile is delivered). But it should
be possible to add a flag stating "don't use this" to the ref, and
document that transport_fetch_refs() can append additional refs to the
tail of the input list. Upon hindsight, maybe this should have been the
original API change instead of the "fetched_refs" mechanism.
---
 builtin/clone.c             |  4 ++--
 builtin/fetch.c             | 28 ++++------------------------
 fetch-object.c              |  2 +-
 fetch-pack.c                | 30 +++++++++++++++---------------
 t/t5551-http-fetch-smart.sh | 18 ++++++++++++++++++
 transport-helper.c          |  6 ++----
 transport-internal.h        |  9 +--------
 transport.c                 | 34 ++++++----------------------------
 transport.h                 |  3 +--
 9 files changed, 50 insertions(+), 84 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5c439f139..76f7db47e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1156,7 +1156,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			}
 
 		if (!is_local && !complete_refs_before_fetch)
-			transport_fetch_refs(transport, mapped_refs, NULL);
+			transport_fetch_refs(transport, mapped_refs);
 
 		remote_head = find_ref_by_name(refs, "HEAD");
 		remote_head_points_at =
@@ -1198,7 +1198,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (is_local)
 		clone_local(path, git_dir);
 	else if (refs && complete_refs_before_fetch)
-		transport_fetch_refs(transport, mapped_refs, NULL);
+		transport_fetch_refs(transport, mapped_refs);
 
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
 			   branch_top.buf, reflog_msg.buf, transport,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ac06f6a57..d136ace87 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -936,13 +936,11 @@ static int quickfetch(struct ref *ref_map)
 	return check_connected(iterate_ref_map, &rm, &opt);
 }
 
-static int fetch_refs(struct transport *transport, struct ref *ref_map,
-		      struct ref **updated_remote_refs)
+static int fetch_refs(struct transport *transport, struct ref *ref_map)
 {
 	int ret = quickfetch(ref_map);
 	if (ret)
-		ret = transport_fetch_refs(transport, ref_map,
-					   updated_remote_refs);
+		ret = transport_fetch_refs(transport, ref_map);
 	if (!ret)
 		/*
 		 * Keep the new pack's ".keep" file around to allow the caller
@@ -1107,7 +1105,7 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
-	if (!fetch_refs(transport, ref_map, NULL))
+	if (!fetch_refs(transport, ref_map))
 		consume_refs(transport, ref_map);
 
 	if (gsecondary) {
@@ -1123,7 +1121,6 @@ static int do_fetch(struct transport *transport,
 	int autotags = (transport->remote->fetch_tags == 1);
 	int retcode = 0;
 	const struct ref *remote_refs;
-	struct ref *updated_remote_refs = NULL;
 	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 
 	if (tags == TAGS_DEFAULT) {
@@ -1174,24 +1171,7 @@ static int do_fetch(struct transport *transport,
 				   transport->url);
 		}
 	}
-
-	if (fetch_refs(transport, ref_map, &updated_remote_refs)) {
-		free_refs(ref_map);
-		retcode = 1;
-		goto cleanup;
-	}
-	if (updated_remote_refs) {
-		/*
-		 * Regenerate ref_map using the updated remote refs.  This is
-		 * to account for additional information which may be provided
-		 * by the transport (e.g. shallow info).
-		 */
-		free_refs(ref_map);
-		ref_map = get_ref_map(transport->remote, updated_remote_refs, rs,
-				      tags, &autotags);
-		free_refs(updated_remote_refs);
-	}
-	if (consume_refs(transport, ref_map)) {
+	if (fetch_refs(transport, ref_map) || consume_refs(transport, ref_map)) {
 		free_refs(ref_map);
 		retcode = 1;
 		goto cleanup;
diff --git a/fetch-object.c b/fetch-object.c
index 48fe63dd6..853624f81 100644
--- a/fetch-object.c
+++ b/fetch-object.c
@@ -19,7 +19,7 @@ static void fetch_refs(const char *remote_name, struct ref *ref)
 
 	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
 	transport_set_option(transport, TRANS_OPT_NO_DEPENDENTS, "1");
-	transport_fetch_refs(transport, ref, NULL);
+	transport_fetch_refs(transport, ref);
 	fetch_if_missing = original_fetch_if_missing;
 }
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 7ccb9c0d4..b80c13124 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1339,25 +1339,26 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 	args->deepen = 1;
 }
 
-static void receive_wanted_refs(struct packet_reader *reader, struct ref *refs)
+static void receive_wanted_refs(struct packet_reader *reader,
+				struct ref **sought, int nr_sought)
 {
 	process_section_header(reader, "wanted-refs", 0);
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
 		struct object_id oid;
 		const char *end;
-		struct ref *r = NULL;
+		int i;
 
 		if (parse_oid_hex(reader->line, &oid, &end) || *end++ != ' ')
 			die("expected wanted-ref, got '%s'", reader->line);
 
-		for (r = refs; r; r = r->next) {
-			if (!strcmp(end, r->name)) {
-				oidcpy(&r->old_oid, &oid);
+		for (i = 0; i < nr_sought; i++) {
+			if (!strcmp(end, sought[i]->name)) {
+				oidcpy(&sought[i]->old_oid, &oid);
 				break;
 			}
 		}
 
-		if (!r)
+		if (i == nr_sought)
 			die("unexpected wanted-ref: '%s'", reader->line);
 	}
 
@@ -1440,7 +1441,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				receive_shallow_info(args, &reader);
 
 			if (process_section_header(&reader, "wanted-refs", 1))
-				receive_wanted_refs(&reader, ref);
+				receive_wanted_refs(&reader, sought, nr_sought);
 
 			/* get the pack */
 			process_section_header(&reader, "packfile", 0);
@@ -1504,13 +1505,12 @@ static int remove_duplicates_in_refs(struct ref **ref, int nr)
 }
 
 static void update_shallow(struct fetch_pack_args *args,
-			   struct ref *refs,
+			   struct ref **sought, int nr_sought,
 			   struct shallow_info *si)
 {
 	struct oid_array ref = OID_ARRAY_INIT;
 	int *status;
 	int i;
-	struct ref *r;
 
 	if (args->deepen && alternate_shallow_file) {
 		if (*alternate_shallow_file == '\0') { /* --unshallow */
@@ -1552,8 +1552,8 @@ static void update_shallow(struct fetch_pack_args *args,
 	remove_nonexistent_theirs_shallow(si);
 	if (!si->nr_ours && !si->nr_theirs)
 		return;
-	for (r = refs; r; r = r->next)
-		oid_array_append(&ref, &r->old_oid);
+	for (i = 0; i < nr_sought; i++)
+		oid_array_append(&ref, &sought[i]->old_oid);
 	si->ref = &ref;
 
 	if (args->update_shallow) {
@@ -1587,12 +1587,12 @@ static void update_shallow(struct fetch_pack_args *args,
 	 * remote is also shallow, check what ref is safe to update
 	 * without updating .git/shallow
 	 */
-	status = xcalloc(ref.nr, sizeof(*status));
+	status = xcalloc(nr_sought, sizeof(*status));
 	assign_shallow_commits_to_refs(si, NULL, status);
 	if (si->nr_ours || si->nr_theirs) {
-		for (r = refs, i = 0; r; r = r->next, i++)
+		for (i = 0; i < nr_sought; i++)
 			if (status[i])
-				r->status = REF_STATUS_REJECT_SHALLOW;
+				sought[i]->status = REF_STATUS_REJECT_SHALLOW;
 	}
 	free(status);
 	oid_array_clear(&ref);
@@ -1655,7 +1655,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		args->connectivity_checked = 1;
 	}
 
-	update_shallow(args, ref_cpy, &si);
+	update_shallow(args, sought, nr_sought, &si);
 cleanup:
 	clear_shallow_info(&si);
 	return ref_cpy;
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 913089b14..989d034ac 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -369,6 +369,24 @@ test_expect_success 'custom http headers' '
 		submodule update sub
 '
 
+test_expect_success 'using fetch command in remote-curl updates refs' '
+	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/twobranch" &&
+	rm -rf "$SERVER" client &&
+
+	git init "$SERVER" &&
+	test_commit -C "$SERVER" foo &&
+	git -C "$SERVER" update-ref refs/heads/anotherbranch foo &&
+
+	git clone $HTTPD_URL/smart/twobranch client &&
+
+	test_commit -C "$SERVER" bar &&
+	git -C client -c protocol.version=0 fetch &&
+
+	git -C "$SERVER" rev-parse master >expect &&
+	git -C client rev-parse origin/master >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'GIT_REDACT_COOKIES redacts cookies' '
 	rm -rf clone &&
 	echo "Set-Cookie: Foo=1" >cookies &&
diff --git a/transport-helper.c b/transport-helper.c
index 8b5abca29..1f8ff7e94 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -651,16 +651,14 @@ static int connect_helper(struct transport *transport, const char *name,
 }
 
 static int fetch(struct transport *transport,
-		 int nr_heads, struct ref **to_fetch,
-		 struct ref **fetched_refs)
+		 int nr_heads, struct ref **to_fetch)
 {
 	struct helper_data *data = transport->data;
 	int i, count;
 
 	if (process_connect(transport, 0)) {
 		do_take_over(transport);
-		return transport->vtable->fetch(transport, nr_heads, to_fetch,
-						fetched_refs);
+		return transport->vtable->fetch(transport, nr_heads, to_fetch);
 	}
 
 	count = 0;
diff --git a/transport-internal.h b/transport-internal.h
index eeb6c340e..1cde6258a 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -36,18 +36,11 @@ struct transport_vtable {
 	 * Fetch the objects for the given refs. Note that this gets
 	 * an array, and should ignore the list structure.
 	 *
-	 * The transport *may* provide, in fetched_refs, the list of refs that
-	 * it fetched.  If the transport knows anything about the fetched refs
-	 * that the caller does not know (for example, shallow status), it
-	 * should provide that list of refs and include that information in the
-	 * list.
-	 *
 	 * If the transport did not get hashes for refs in
 	 * get_refs_list(), it should set the old_sha1 fields in the
 	 * provided refs now.
 	 **/
-	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs,
-		     struct ref **fetched_refs);
+	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
 
 	/**
 	 * Push the objects and refs. Send the necessary objects, and
diff --git a/transport.c b/transport.c
index fdd813f68..af6e692db 100644
--- a/transport.c
+++ b/transport.c
@@ -151,8 +151,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 }
 
 static int fetch_refs_from_bundle(struct transport *transport,
-			       int nr_heads, struct ref **to_fetch,
-			       struct ref **fetched_refs)
+			       int nr_heads, struct ref **to_fetch)
 {
 	struct bundle_transport_data *data = transport->data;
 	return unbundle(&data->header, data->fd,
@@ -288,8 +287,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 }
 
 static int fetch_refs_via_pack(struct transport *transport,
-			       int nr_heads, struct ref **to_fetch,
-			       struct ref **fetched_refs)
+			       int nr_heads, struct ref **to_fetch)
 {
 	int ret = 0;
 	struct git_transport_data *data = transport->data;
@@ -357,12 +355,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 	if (report_unmatched_refs(to_fetch, nr_heads))
 		ret = -1;
 
-	if (fetched_refs)
-		*fetched_refs = refs;
-	else
-		free_refs(refs);
-
 	free_refs(refs_tmp);
+	free_refs(refs);
 	free(dest);
 	return ret;
 }
@@ -1222,31 +1216,19 @@ const struct ref *transport_get_remote_refs(struct transport *transport,
 	return transport->remote_refs;
 }
 
-int transport_fetch_refs(struct transport *transport, struct ref *refs,
-			 struct ref **fetched_refs)
+int transport_fetch_refs(struct transport *transport, struct ref *refs)
 {
 	int rc;
 	int nr_heads = 0, nr_alloc = 0, nr_refs = 0;
 	struct ref **heads = NULL;
-	struct ref *nop_head = NULL, **nop_tail = &nop_head;
 	struct ref *rm;
 
 	for (rm = refs; rm; rm = rm->next) {
 		nr_refs++;
 		if (rm->peer_ref &&
 		    !is_null_oid(&rm->old_oid) &&
-		    !oidcmp(&rm->peer_ref->old_oid, &rm->old_oid)) {
-			/*
-			 * These need to be reported as fetched, but we don't
-			 * actually need to fetch them.
-			 */
-			if (fetched_refs) {
-				struct ref *nop_ref = copy_ref(rm);
-				*nop_tail = nop_ref;
-				nop_tail = &nop_ref->next;
-			}
+		    !oidcmp(&rm->peer_ref->old_oid, &rm->old_oid))
 			continue;
-		}
 		ALLOC_GROW(heads, nr_heads + 1, nr_alloc);
 		heads[nr_heads++] = rm;
 	}
@@ -1264,11 +1246,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs,
 			heads[nr_heads++] = rm;
 	}
 
-	rc = transport->vtable->fetch(transport, nr_heads, heads, fetched_refs);
-	if (fetched_refs && nop_head) {
-		*nop_tail = *fetched_refs;
-		*fetched_refs = nop_head;
-	}
+	rc = transport->vtable->fetch(transport, nr_heads, heads);
 
 	free(heads);
 	return rc;
diff --git a/transport.h b/transport.h
index 7a9a7fcaf..c057c44d3 100644
--- a/transport.h
+++ b/transport.h
@@ -229,8 +229,7 @@ int transport_push(struct transport *connection,
 const struct ref *transport_get_remote_refs(struct transport *transport,
 					    const struct argv_array *ref_prefixes);
 
-int transport_fetch_refs(struct transport *transport, struct ref *refs,
-			 struct ref **fetched_refs);
+int transport_fetch_refs(struct transport *transport, struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
-- 
2.18.0.597.ga71716f1ad-goog

