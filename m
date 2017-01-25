Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2A7B1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbdAYWDk (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:03:40 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33268 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbdAYWDb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:03:31 -0500
Received: by mail-pg0-f51.google.com with SMTP id 204so67749121pge.0
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2+FPJrSvXQVd42ZwY8Zl5A3G3yKCGUzUrgZnSzTT03U=;
        b=KwNGJz4KLEIrkW5KjYJtk4qum/deWU2OxEv5yzMBHzzD+V+NsNSVQFwP+GiRFT6ZhK
         cCaXlUcbze9+x9N4gXZNJncqSV1a+Qo0sDJW5O2+/jJMrZPXGD1z6WnCB/dS5tPAAn4s
         8ql5gmRQXxJcAf+FvdeW4rnQMgir9N7CyNf2cQjcQAgW2UkCj7UbyEzPAWH/RlFZDnna
         9OqoNQmmNE4z+OjaIhS7xCUtHo3eSIakJIzyHIirsPKcMmoxoHwC8eJk4kraI3lutC6O
         ntwtL1A/QHepxmKb2dq8iv9VKipsAuu4Gm+Phm2P5T/jzpza3PjOJQkIxfwOdvIUgttm
         2FMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2+FPJrSvXQVd42ZwY8Zl5A3G3yKCGUzUrgZnSzTT03U=;
        b=KcPrWDcWKIKxHFRkeHq+MPMhOM2u8a9B5nXefevtxNIvgfg8+0gMASNLZhL7NW+sab
         5tvjddH4tQeAf2Usz4oteXuqeo4HC4zTBN/6Vvi7EfHK8KNH4mRaJzqgCJX/WptAMZ72
         ijawnrQ6sMW7E0z9wnDOOaHHF07odxpPLPhG8LUl4yisK0C1Vz3zaOJ+Bn6XMm4Hkso2
         /tyCALZEKaAEej3nkW0yEFvcnuZkwEWKqkoriSTkUxrhGr8B6Pcgz5ys0tgKDNYXJSZy
         ped3HMdiZ7uJPiNaxbbk+d5noPgXUy/PzoKk1uPafyhgc72VkMOw+Hpo8DXzYqT0LP4i
         91Nw==
X-Gm-Message-State: AIkVDXLnIasxpe+/flBagcZvUqDn0XNBQYtGEXiWuNlS50Ce+3U+PWPvLtw0eywVmcFt1QAC
X-Received: by 10.84.216.86 with SMTP id f22mr6893304plj.117.1485381804850;
        Wed, 25 Jan 2017 14:03:24 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id o24sm3357308pfj.78.2017.01.25.14.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 14:03:23 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 07/14] fetch-pack: put shallow info in out param
Date:   Wed, 25 Jan 2017 14:03:00 -0800
Message-Id: <86a128c5fb710a41791e7183207c4d64889f9307.1485381677.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Expand the transport fetch method signature, by adding an out parameter,
to allow transports to return information about the refs they have
fetched. Then communicate shallow status information through this
mechanism instead of by modifying the input list of refs.

This does require clients to sometimes generate the ref map twice: one
generation from the list of refs provided by the remote (as is currently
done) and potentially one regeneration from the new list of refs that
the fetch mechanism provides (added in this patch). The double
generation may result in duplicate error messages when a remote-tracking
branch seems to track more than one remote branch.

This is the 1st of 3 patches to eliminate using input refs to
communicate information obtained by the fetch mechanism.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/clone.c            |  4 ++--
 builtin/fetch.c            | 23 +++++++++++++++++++----
 fetch-pack.c               | 18 +++++++++++-------
 remote.c                   | 12 +++++++++++-
 remote.h                   |  1 +
 t/t5536-fetch-conflicts.sh |  2 ++
 transport-helper.c         |  5 +++--
 transport.c                | 32 ++++++++++++++++++++++++++------
 transport.h                | 12 ++++++++++--
 9 files changed, 85 insertions(+), 24 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5ef81927a..0135c5f1c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1076,7 +1076,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			}
 
 		if (!is_local && !complete_refs_before_fetch)
-			transport_fetch_refs(transport, mapped_refs);
+			transport_fetch_refs(transport, mapped_refs, NULL);
 
 		remote_head = find_ref_by_name(refs, "HEAD");
 		remote_head_points_at =
@@ -1115,7 +1115,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (is_local)
 		clone_local(path, git_dir);
 	else if (refs && complete_refs_before_fetch)
-		transport_fetch_refs(transport, mapped_refs);
+		transport_fetch_refs(transport, mapped_refs, NULL);
 
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
 			   branch_top.buf, reflog_msg.buf, transport, !is_local);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ae7c6daa1..19e3f40a0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -911,11 +911,13 @@ static int quickfetch(struct ref *ref_map)
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
 	if (ret)
 		transport_unlock_pack(transport);
 	return ret;
@@ -1066,7 +1068,7 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
-	if (!fetch_refs(transport, ref_map))
+	if (!fetch_refs(transport, ref_map, NULL))
 		consume_refs(transport, ref_map);
 
 	if (gsecondary) {
@@ -1082,6 +1084,7 @@ static int do_fetch(struct transport *transport,
 	int autotags = (transport->remote->fetch_tags == 1);
 	int retcode = 0;
 	const struct ref *remote_refs;
+	struct ref *new_remote_refs = NULL;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1123,7 +1126,19 @@ static int do_fetch(struct transport *transport,
 				   transport->url);
 		}
 	}
-	if (fetch_refs(transport, ref_map) || consume_refs(transport, ref_map)) {
+	if (fetch_refs(transport, ref_map, &new_remote_refs)) {
+		free_refs(ref_map);
+		retcode = 1;
+		goto cleanup;
+	}
+	if (new_remote_refs) {
+		free_refs(ref_map);
+		ref_map = get_ref_map(transport->remote, new_remote_refs,
+				      refs, ref_count, tags, &autotags);
+		free_refs(new_remote_refs);
+	}
+
+	if (consume_refs(transport, ref_map)) {
 		free_refs(ref_map);
 		retcode = 1;
 		goto cleanup;
diff --git a/fetch-pack.c b/fetch-pack.c
index 601f0779a..9a87ddd3d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -974,12 +974,13 @@ static int remove_duplicates_in_refs(struct ref **ref, int nr)
 }
 
 static void update_shallow(struct fetch_pack_args *args,
-			   struct ref **sought, int nr_sought,
+			   struct ref *refs,
 			   struct shallow_info *si)
 {
 	struct sha1_array ref = SHA1_ARRAY_INIT;
 	int *status;
 	int i;
+	struct ref *r;
 
 	if (args->deepen && alternate_shallow_file) {
 		if (*alternate_shallow_file == '\0') { /* --unshallow */
@@ -1021,8 +1022,8 @@ static void update_shallow(struct fetch_pack_args *args,
 	remove_nonexistent_theirs_shallow(si);
 	if (!si->nr_ours && !si->nr_theirs)
 		return;
-	for (i = 0; i < nr_sought; i++)
-		sha1_array_append(&ref, sought[i]->old_oid.hash);
+	for (r = refs; r; r = r->next)
+		sha1_array_append(&ref, r->old_oid.hash);
 	si->ref = &ref;
 
 	if (args->update_shallow) {
@@ -1056,12 +1057,15 @@ static void update_shallow(struct fetch_pack_args *args,
 	 * remote is also shallow, check what ref is safe to update
 	 * without updating .git/shallow
 	 */
-	status = xcalloc(nr_sought, sizeof(*status));
+	status = xcalloc(ref.nr, sizeof(*status));
 	assign_shallow_commits_to_refs(si, NULL, status);
 	if (si->nr_ours || si->nr_theirs) {
-		for (i = 0; i < nr_sought; i++)
+		i = 0;
+		for (r = refs; r; r = r->next) {
 			if (status[i])
-				sought[i]->status = REF_STATUS_REJECT_SHALLOW;
+				r->status = REF_STATUS_REJECT_SHALLOW;
+			i++;
+		}
 	}
 	free(status);
 	sha1_array_clear(&ref);
@@ -1090,7 +1094,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 	ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
 				&si, pack_lockfile);
 	reprepare_packed_git();
-	update_shallow(args, sought, nr_sought, &si);
+	update_shallow(args, ref_cpy, &si);
 	clear_shallow_info(&si);
 	return ref_cpy;
 }
diff --git a/remote.c b/remote.c
index d5eaec737..725a2d39a 100644
--- a/remote.c
+++ b/remote.c
@@ -929,7 +929,7 @@ struct ref *alloc_ref(const char *name)
 	return alloc_ref_with_prefix("", 0, name);
 }
 
-struct ref *copy_ref(const struct ref *ref)
+struct ref *copy_ref_peerless(const struct ref *ref)
 {
 	struct ref *cpy;
 	size_t len;
@@ -941,6 +941,16 @@ struct ref *copy_ref(const struct ref *ref)
 	cpy->next = NULL;
 	cpy->symref = xstrdup_or_null(ref->symref);
 	cpy->remote_status = xstrdup_or_null(ref->remote_status);
+	cpy->peer_ref = NULL;
+	return cpy;
+}
+
+struct ref *copy_ref(const struct ref *ref)
+{
+	struct ref *cpy;
+	if (!ref)
+		return NULL;
+	cpy = copy_ref_peerless(ref);
 	cpy->peer_ref = copy_ref(ref->peer_ref);
 	return cpy;
 }
diff --git a/remote.h b/remote.h
index 924881169..57d059431 100644
--- a/remote.h
+++ b/remote.h
@@ -131,6 +131,7 @@ struct ref {
 extern struct ref *find_ref_by_name(const struct ref *list, const char *name);
 
 struct ref *alloc_ref(const char *name);
+struct ref *copy_ref_peerless(const struct ref *ref);
 struct ref *copy_ref(const struct ref *ref);
 struct ref *copy_ref_list(const struct ref *ref);
 void sort_ref_list(struct ref **, int (*cmp)(const void *, const void *));
diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
index 2e42cf331..0cb380795 100755
--- a/t/t5536-fetch-conflicts.sh
+++ b/t/t5536-fetch-conflicts.sh
@@ -93,6 +93,8 @@ test_expect_success 'fetch conflict: criss-cross args' '
 		verify_stderr <<-\EOF
 		warning: refs/remotes/origin/branch1 usually tracks refs/heads/branch1, not refs/heads/branch2
 		warning: refs/remotes/origin/branch2 usually tracks refs/heads/branch2, not refs/heads/branch1
+		warning: refs/remotes/origin/branch1 usually tracks refs/heads/branch1, not refs/heads/branch2
+		warning: refs/remotes/origin/branch2 usually tracks refs/heads/branch2, not refs/heads/branch1
 		EOF
 	)
 '
diff --git a/transport-helper.c b/transport-helper.c
index 91aed35eb..f3d78bb9e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -646,14 +646,15 @@ static int connect_helper(struct transport *transport, const char *name,
 }
 
 static int fetch(struct transport *transport,
-		 int nr_heads, struct ref **to_fetch)
+		 int nr_heads, struct ref **to_fetch, struct ref **fetched_refs)
 {
 	struct helper_data *data = transport->data;
 	int i, count;
 
 	if (process_connect(transport, 0)) {
 		do_take_over(transport);
-		return transport->fetch(transport, nr_heads, to_fetch);
+		return transport->fetch(transport, nr_heads, to_fetch,
+					fetched_refs);
 	}
 
 	count = 0;
diff --git a/transport.c b/transport.c
index c86ba2eb8..80e007f2f 100644
--- a/transport.c
+++ b/transport.c
@@ -95,7 +95,8 @@ static struct ref *get_refs_from_bundle(struct transport *transport, int for_pus
 }
 
 static int fetch_refs_from_bundle(struct transport *transport,
-			       int nr_heads, struct ref **to_fetch)
+			       int nr_heads, struct ref **to_fetch,
+			       struct ref **fetched_refs)
 {
 	struct bundle_transport_data *data = transport->data;
 	return unbundle(&data->header, data->fd,
@@ -202,7 +203,8 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 }
 
 static int fetch_refs_via_pack(struct transport *transport,
-			       int nr_heads, struct ref **to_fetch)
+			       int nr_heads, struct ref **to_fetch,
+			       struct ref **fetched_refs)
 {
 	struct git_transport_data *data = transport->data;
 	struct ref *refs;
@@ -250,8 +252,12 @@ static int fetch_refs_via_pack(struct transport *transport,
 	data->options.self_contained_and_connected =
 		args.self_contained_and_connected;
 
+	if (fetched_refs)
+		*fetched_refs = refs;
+	else
+		free_refs(refs);
+
 	free_refs(refs_tmp);
-	free_refs(refs);
 	free(dest);
 	return (refs ? 0 : -1);
 }
@@ -1090,19 +1096,29 @@ const struct ref *transport_get_remote_refs(struct transport *transport)
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
+			/* These need to be reported as fetched, but we do not
+			 * actually need to fetch them. */
+			if (fetched_refs) {
+				struct ref *nop_ref = copy_ref_peerless(rm);
+				*nop_tail = nop_ref;
+				nop_tail = &nop_ref->next;
+			}
 			continue;
+		}
 		ALLOC_GROW(heads, nr_heads + 1, nr_alloc);
 		heads[nr_heads++] = rm;
 	}
@@ -1120,7 +1136,11 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 			heads[nr_heads++] = rm;
 	}
 
-	rc = transport->fetch(transport, nr_heads, heads);
+	rc = transport->fetch(transport, nr_heads, heads, fetched_refs);
+	if (nop_head) {
+		*nop_tail = *fetched_refs;
+		*fetched_refs = nop_head;
+	}
 
 	free(heads);
 	return rc;
diff --git a/transport.h b/transport.h
index 9820f10b8..b9e7e4656 100644
--- a/transport.h
+++ b/transport.h
@@ -82,11 +82,18 @@ struct transport {
 	 * Fetch the objects for the given refs. Note that this gets
 	 * an array, and should ignore the list structure.
 	 *
+	 * The transport *may* provide, in fetched_refs, the list of refs that
+	 * it fetched. If the transport knows anything about the fetched refs
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
@@ -230,7 +237,8 @@ int transport_push(struct transport *connection,
 
 const struct ref *transport_get_remote_refs(struct transport *transport);
 
-int transport_fetch_refs(struct transport *transport, struct ref *refs);
+int transport_fetch_refs(struct transport *transport, struct ref *refs,
+			 struct ref **fetched_refs);
 void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
-- 
2.11.0.483.g087da7b7c-goog

