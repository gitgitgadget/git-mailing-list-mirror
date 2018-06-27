Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 846B31F516
	for <e@80x24.org>; Wed, 27 Jun 2018 22:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966491AbeF0War (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 18:30:47 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:49593 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966433AbeF0Wao (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 18:30:44 -0400
Received: by mail-io0-f201.google.com with SMTP id x13-v6so2722327iog.16
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 15:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=L0g+K1VEgJrZjOBH4TQvlwBnzeXblyxnanpVrNZnHYM=;
        b=JLyrYBquQJGHd3Ge0lfS7cBaUv0ciHNlw78TESLtb9jA7ewLrc3n3i34rznTLntqrg
         NnZgwDPRsoeFig3XKW8tzGZTnszLWKSLIWDSJfLFf2Wz5Mfnd+1YWHcqKJcgRQ+4h5/0
         xLtSlVbWb6+7KHQ2gffNm++yUFRB9J7HF6SzNlyjF60toP/FksXnUPXZu1xrWarSfxsR
         Ng24FgIFCiQR5tu6odjFVQsxEP3PaY3XiECkQUUVY5AVejyvzx3uOAgT/nfmgj99KX4R
         1ZihXwUO0nzlLlfZkZ00o/rdc6uQVLkPk662Aea7RFeHH2XBfnmN15uZJLfc6NyNz/st
         9URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=L0g+K1VEgJrZjOBH4TQvlwBnzeXblyxnanpVrNZnHYM=;
        b=O1iCQkUeLoqR2otynplSTBohPrRvtILRktcmzpKAN5kE3jv0+F3OQU2Oauyg5hsGyA
         R25R6lSbWmXUyyNBQSp99E0mNfe0tnno4IhYVmkjE2lm800h8OnqI8VWjlTQ6G4qkPsT
         M5qbsU2T8OCNWgiQrP+Gp3l5pC2IepOmOlnEwFUXRTFtrW+FruL2kCMxW/vKejrADtX3
         Zz8b6moKX77i9JvrE5xS/a2D/ty9jrdlfnvqbPJUAuFnahWcQtx9XTPW7Bfy+acClHYT
         RLlB6DbNNbMf6qIZpQtAVPxEMIbHnJaA/6ebM+z+j2wQ0VY03QBOF5qdW1i8oSpr2kaG
         NONg==
X-Gm-Message-State: APt69E3VxkikreLOKOcSsh68AGJTRQOmC/F8P43VqX4metmB5AzNKBYg
        RL82fFTLre7ptqeonhlX4P8qLn/xKI7q2ExoZJEWQNt51WxtSnAhaHPje71j1Ib+iyVIeDwlwBJ
        IRo+fgcYKqK7x13c8oaEZlGvbRFAZf89cW/jbeSyXs081Zp1LPLSULr1B7w==
X-Google-Smtp-Source: AAOMgpcLeyy13Db5QVXX4czeHD3KGNcLQv7DN4iev7A8hScM4adDIEXf4+RlJGllAvFJG5ZoXSS6/WpRLgw=
MIME-Version: 1.0
X-Received: by 2002:a24:39c1:: with SMTP id l184-v6mr2989916ita.18.1530138643635;
 Wed, 27 Jun 2018 15:30:43 -0700 (PDT)
Date:   Wed, 27 Jun 2018 15:30:22 -0700
In-Reply-To: <20180627223023.49659-1-bmwill@google.com>
Message-Id: <20180627223023.49659-8-bmwill@google.com>
References: <20180626205438.110764-1-bmwill@google.com> <20180627223023.49659-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v6 7/8] fetch-pack: put shallow info in output parameter
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
        jrnieder@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Expand the transport fetch method signature, by adding an output
parameter, to allow transports to return information about the refs they
have fetched.  Then communicate shallow status information through this
mechanism instead of by modifying the input list of refs.

This does require clients to sometimes generate the ref map twice: once
from the list of refs provided by the remote (as is currently done) and
potentially once from the new list of refs that the fetch mechanism
provides.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/clone.c      |  4 ++--
 builtin/fetch.c      | 28 ++++++++++++++++++++++++----
 fetch-object.c       |  2 +-
 fetch-pack.c         | 15 ++++++++-------
 transport-helper.c   |  6 ++++--
 transport-internal.h |  9 ++++++++-
 transport.c          | 34 ++++++++++++++++++++++++++++------
 transport.h          |  3 ++-
 8 files changed, 77 insertions(+), 24 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 99e73dae8..8f86d99c5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1155,7 +1155,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			}
 
 		if (!is_local && !complete_refs_before_fetch)
-			transport_fetch_refs(transport, mapped_refs);
+			transport_fetch_refs(transport, mapped_refs, NULL);
 
 		remote_head = find_ref_by_name(refs, "HEAD");
 		remote_head_points_at =
@@ -1197,7 +1197,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (is_local)
 		clone_local(path, git_dir);
 	else if (refs && complete_refs_before_fetch)
-		transport_fetch_refs(transport, mapped_refs);
+		transport_fetch_refs(transport, mapped_refs, NULL);
 
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
 			   branch_top.buf, reflog_msg.buf, transport,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index bda00e826..0347cf016 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -946,11 +946,13 @@ static int quickfetch(struct ref *ref_map)
 	return check_connected(iterate_ref_map, &rm, &opt);
 }
 
-static int fetch_refs(struct transport *transport, struct ref *ref_map)
+static int fetch_refs(struct transport *transport, struct ref *ref_map,
+		      struct ref **updated_remote_refs)
 {
 	int ret = quickfetch(ref_map);
 	if (ret)
-		ret = transport_fetch_refs(transport, ref_map);
+		ret = transport_fetch_refs(transport, ref_map,
+					   updated_remote_refs);
 	if (!ret)
 		/*
 		 * Keep the new pack's ".keep" file around to allow the caller
@@ -1112,7 +1114,7 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
-	if (!fetch_refs(transport, ref_map))
+	if (!fetch_refs(transport, ref_map, NULL))
 		consume_refs(transport, ref_map);
 
 	if (gsecondary) {
@@ -1128,6 +1130,7 @@ static int do_fetch(struct transport *transport,
 	int autotags = (transport->remote->fetch_tags == 1);
 	int retcode = 0;
 	const struct ref *remote_refs;
+	struct ref *updated_remote_refs = NULL;
 	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 
 	if (tags == TAGS_DEFAULT) {
@@ -1178,7 +1181,24 @@ static int do_fetch(struct transport *transport,
 				   transport->url);
 		}
 	}
-	if (fetch_refs(transport, ref_map) || consume_refs(transport, ref_map)) {
+
+	if (fetch_refs(transport, ref_map, &updated_remote_refs)) {
+		free_refs(ref_map);
+		retcode = 1;
+		goto cleanup;
+	}
+	if (updated_remote_refs) {
+		/*
+		 * Regenerate ref_map using the updated remote refs.  This is
+		 * to account for additional information which may be provided
+		 * by the transport (e.g. shallow info).
+		 */
+		free_refs(ref_map);
+		ref_map = get_ref_map(transport->remote, updated_remote_refs, rs,
+				      tags, &autotags);
+		free_refs(updated_remote_refs);
+	}
+	if (consume_refs(transport, ref_map)) {
 		free_refs(ref_map);
 		retcode = 1;
 		goto cleanup;
diff --git a/fetch-object.c b/fetch-object.c
index 853624f81..48fe63dd6 100644
--- a/fetch-object.c
+++ b/fetch-object.c
@@ -19,7 +19,7 @@ static void fetch_refs(const char *remote_name, struct ref *ref)
 
 	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
 	transport_set_option(transport, TRANS_OPT_NO_DEPENDENTS, "1");
-	transport_fetch_refs(transport, ref);
+	transport_fetch_refs(transport, ref, NULL);
 	fetch_if_missing = original_fetch_if_missing;
 }
 
diff --git a/fetch-pack.c b/fetch-pack.c
index a320ce987..73890b894 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1470,12 +1470,13 @@ static int remove_duplicates_in_refs(struct ref **ref, int nr)
 }
 
 static void update_shallow(struct fetch_pack_args *args,
-			   struct ref **sought, int nr_sought,
+			   struct ref *refs,
 			   struct shallow_info *si)
 {
 	struct oid_array ref = OID_ARRAY_INIT;
 	int *status;
 	int i;
+	struct ref *r;
 
 	if (args->deepen && alternate_shallow_file) {
 		if (*alternate_shallow_file == '\0') { /* --unshallow */
@@ -1517,8 +1518,8 @@ static void update_shallow(struct fetch_pack_args *args,
 	remove_nonexistent_theirs_shallow(si);
 	if (!si->nr_ours && !si->nr_theirs)
 		return;
-	for (i = 0; i < nr_sought; i++)
-		oid_array_append(&ref, &sought[i]->old_oid);
+	for (r = refs; r; r = r->next)
+		oid_array_append(&ref, &r->old_oid);
 	si->ref = &ref;
 
 	if (args->update_shallow) {
@@ -1552,12 +1553,12 @@ static void update_shallow(struct fetch_pack_args *args,
 	 * remote is also shallow, check what ref is safe to update
 	 * without updating .git/shallow
 	 */
-	status = xcalloc(nr_sought, sizeof(*status));
+	status = xcalloc(ref.nr, sizeof(*status));
 	assign_shallow_commits_to_refs(si, NULL, status);
 	if (si->nr_ours || si->nr_theirs) {
-		for (i = 0; i < nr_sought; i++)
+		for (r = refs, i = 0; r; r = r->next, i++)
 			if (status[i])
-				sought[i]->status = REF_STATUS_REJECT_SHALLOW;
+				r->status = REF_STATUS_REJECT_SHALLOW;
 	}
 	free(status);
 	oid_array_clear(&ref);
@@ -1591,7 +1592,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
 					&si, pack_lockfile);
 	reprepare_packed_git(the_repository);
-	update_shallow(args, sought, nr_sought, &si);
+	update_shallow(args, ref_cpy, &si);
 	clear_shallow_info(&si);
 	return ref_cpy;
 }
diff --git a/transport-helper.c b/transport-helper.c
index 1f8ff7e94..8b5abca29 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -651,14 +651,16 @@ static int connect_helper(struct transport *transport, const char *name,
 }
 
 static int fetch(struct transport *transport,
-		 int nr_heads, struct ref **to_fetch)
+		 int nr_heads, struct ref **to_fetch,
+		 struct ref **fetched_refs)
 {
 	struct helper_data *data = transport->data;
 	int i, count;
 
 	if (process_connect(transport, 0)) {
 		do_take_over(transport);
-		return transport->vtable->fetch(transport, nr_heads, to_fetch);
+		return transport->vtable->fetch(transport, nr_heads, to_fetch,
+						fetched_refs);
 	}
 
 	count = 0;
diff --git a/transport-internal.h b/transport-internal.h
index 1cde6258a..eeb6c340e 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -36,11 +36,18 @@ struct transport_vtable {
 	 * Fetch the objects for the given refs. Note that this gets
 	 * an array, and should ignore the list structure.
 	 *
+	 * The transport *may* provide, in fetched_refs, the list of refs that
+	 * it fetched.  If the transport knows anything about the fetched refs
+	 * that the caller does not know (for example, shallow status), it
+	 * should provide that list of refs and include that information in the
+	 * list.
+	 *
 	 * If the transport did not get hashes for refs in
 	 * get_refs_list(), it should set the old_sha1 fields in the
 	 * provided refs now.
 	 **/
-	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
+	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs,
+		     struct ref **fetched_refs);
 
 	/**
 	 * Push the objects and refs. Send the necessary objects, and
diff --git a/transport.c b/transport.c
index a32da30de..39d8c2fa5 100644
--- a/transport.c
+++ b/transport.c
@@ -151,7 +151,8 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 }
 
 static int fetch_refs_from_bundle(struct transport *transport,
-			       int nr_heads, struct ref **to_fetch)
+			       int nr_heads, struct ref **to_fetch,
+			       struct ref **fetched_refs)
 {
 	struct bundle_transport_data *data = transport->data;
 	return unbundle(&data->header, data->fd,
@@ -287,7 +288,8 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 }
 
 static int fetch_refs_via_pack(struct transport *transport,
-			       int nr_heads, struct ref **to_fetch)
+			       int nr_heads, struct ref **to_fetch,
+			       struct ref **fetched_refs)
 {
 	int ret = 0;
 	struct git_transport_data *data = transport->data;
@@ -354,8 +356,12 @@ static int fetch_refs_via_pack(struct transport *transport,
 	if (report_unmatched_refs(to_fetch, nr_heads))
 		ret = -1;
 
+	if (fetched_refs)
+		*fetched_refs = refs;
+	else
+		free_refs(refs);
+
 	free_refs(refs_tmp);
-	free_refs(refs);
 	free(dest);
 	return ret;
 }
@@ -1215,19 +1221,31 @@ const struct ref *transport_get_remote_refs(struct transport *transport,
 	return transport->remote_refs;
 }
 
-int transport_fetch_refs(struct transport *transport, struct ref *refs)
+int transport_fetch_refs(struct transport *transport, struct ref *refs,
+			 struct ref **fetched_refs)
 {
 	int rc;
 	int nr_heads = 0, nr_alloc = 0, nr_refs = 0;
 	struct ref **heads = NULL;
+	struct ref *nop_head = NULL, **nop_tail = &nop_head;
 	struct ref *rm;
 
 	for (rm = refs; rm; rm = rm->next) {
 		nr_refs++;
 		if (rm->peer_ref &&
 		    !is_null_oid(&rm->old_oid) &&
-		    !oidcmp(&rm->peer_ref->old_oid, &rm->old_oid))
+		    !oidcmp(&rm->peer_ref->old_oid, &rm->old_oid)) {
+			/*
+			 * These need to be reported as fetched, but we don't
+			 * actually need to fetch them.
+			 */
+			if (fetched_refs) {
+				struct ref *nop_ref = copy_ref(rm);
+				*nop_tail = nop_ref;
+				nop_tail = &nop_ref->next;
+			}
 			continue;
+		}
 		ALLOC_GROW(heads, nr_heads + 1, nr_alloc);
 		heads[nr_heads++] = rm;
 	}
@@ -1245,7 +1263,11 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 			heads[nr_heads++] = rm;
 	}
 
-	rc = transport->vtable->fetch(transport, nr_heads, heads);
+	rc = transport->vtable->fetch(transport, nr_heads, heads, fetched_refs);
+	if (fetched_refs && nop_head) {
+		*nop_tail = *fetched_refs;
+		*fetched_refs = nop_head;
+	}
 
 	free(heads);
 	return rc;
diff --git a/transport.h b/transport.h
index 7792b0858..3dff767a8 100644
--- a/transport.h
+++ b/transport.h
@@ -218,7 +218,8 @@ int transport_push(struct transport *connection,
 const struct ref *transport_get_remote_refs(struct transport *transport,
 					    const struct argv_array *ref_prefixes);
 
-int transport_fetch_refs(struct transport *transport, struct ref *refs);
+int transport_fetch_refs(struct transport *transport, struct ref *refs,
+			 struct ref **fetched_refs);
 void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
-- 
2.18.0.399.gad0ab374a1-goog

