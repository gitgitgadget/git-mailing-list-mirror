Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27466C433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 21:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C974822AB9
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 21:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgLVVzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 16:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgLVVzI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 16:55:08 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DEEC061793
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 13:54:28 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id a11so11204336qto.16
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 13:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8hRYiZgnD4U9WJlbCZQMfSk2xHF6YKyfG+8FiL7eVCo=;
        b=ETG4u3dg92gFmDXgLcYQ7617V2q7DvUQaSOfWXxk1+oG56tNyIyNTVTvU2G1A4xiug
         EV4t9ZI1DJFXRjxZXp3cvAbuWS4K/xt6Ob+aeaGecywolwnLQU35vqR4Py1jX/CDjb4h
         bipi7h7MQLBhwpJ/KvyyeOfcDsUOXHyu/owVRH2+wO6uXdUO8fLWnkmZfnRHRjlxY5kF
         fM9tfZgsMDWOM7dCPSMd8Si8cHWV5SheZv1OVHdzY66dUJQ5BIt6PutdzSMO4V6AX0oP
         dLO1WZrGzXz60FHuocldA6ed6H6bsKMtvqnT5pZS1JzRgkEYGnKwE0KqMXjydNoH7PQ2
         KrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8hRYiZgnD4U9WJlbCZQMfSk2xHF6YKyfG+8FiL7eVCo=;
        b=mpsTjLEX/oLfSCqFV23z/S76fKDYRZij1SBH/OedM8RT+c3fZXoufUK53KBCE7TqrW
         e4TyZbWwUjNOJ8EnILRfy8b/MK7Kev4fd6DPgqJur260lPEX36Thp6IICwYgIMno4pTJ
         uVjLQORL5lwlisse/66GFgddVDBm3aZUgD1HgRnVE05kAyRdtkC+IgRFOXNnTOq0otrZ
         akHtgy39IPj06qPLK2eoaohSmJK7XYgT9uC4XUz7MifgGRcA6Z/oRQUZHEr9E9YM0w9a
         lanbKRM7uZHA66ci1LrbAziWTUQ56bfFlexBVw9tyDtMASo4u/TJXQ+sQydS50j9r+b0
         10bw==
X-Gm-Message-State: AOAM533eqRr5ayi4BIAXW04wVhaynEcjQkBJrcuz2VxJaXzA8I5Abmqi
        VQJboz5mRC+mbyjqIanhQCHdJPNL3ENec3LqTYsJqGIRZAiL3u2snS/4zKgdOBkShOS9sgfU7oW
        g0fMrXQb0bIIh5ai2mNWvEiNIssefBHnwkfiHTSEK7cqD/XU6P3LP4FmSefq1vFJlB2Eb/H+fEl
        U3
X-Google-Smtp-Source: ABdhPJzCuPWM96TnBZ2FabmxwKKwAGzR0DJ0O4P46SFDHyLzHn10tfvXjOQhBH3iRLL1zoJS0tFlup7TS55tz6aLK/2A
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:83e1:: with SMTP id
 k88mr24123515qva.60.1608674067119; Tue, 22 Dec 2020 13:54:27 -0800 (PST)
Date:   Tue, 22 Dec 2020 13:54:19 -0800
In-Reply-To: <cover.1608673963.git.jonathantanmy@google.com>
Message-Id: <14f3962adc0ce03505fbef2c40434400c539c40d.1608673963.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201211210508.2337494-1-jonathantanmy@google.com> <cover.1608673963.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v4 2/3] connect, transport: add no-op arg for future patch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch we plan to return the name of an unborn current branch
from deep in the callchain to a caller via a new pointer parameter that
points at a variable in the caller when the caller calls
get_remote_refs() and transport_get_remote_refs(). Add the parameter to
functions involved in the callchain, but no caller passes an actual
argument yet in this step. Thus, the future patch only needs to concern
itself with new logic.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/clone.c      |  2 +-
 builtin/fetch-pack.c |  3 ++-
 builtin/fetch.c      |  2 +-
 builtin/ls-remote.c  |  2 +-
 builtin/remote.c     |  2 +-
 connect.c            |  5 ++++-
 remote.h             |  3 ++-
 transport-helper.c   |  7 +++++--
 transport-internal.h | 13 +++++--------
 transport.c          | 29 ++++++++++++++++++-----------
 transport.h          |  7 ++++++-
 11 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a0841923cf..70f9450db4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1264,7 +1264,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (!option_no_tags)
 		strvec_push(&ref_prefixes, "refs/tags/");
 
-	refs = transport_get_remote_refs(transport, &ref_prefixes);
+	refs = transport_get_remote_refs(transport, &ref_prefixes, NULL);
 
 	if (refs) {
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 58b7c1fbdc..9f921dfab4 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -220,7 +220,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	version = discover_version(&reader);
 	switch (version) {
 	case protocol_v2:
-		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL, args.stateless_rpc);
+		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL,
+				args.stateless_rpc, NULL);
 		break;
 	case protocol_v1:
 	case protocol_v0:
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ecf8537605..a7ef59acfc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1393,7 +1393,7 @@ static int do_fetch(struct transport *transport,
 
 	if (must_list_refs) {
 		trace2_region_enter("fetch", "remote_refs", the_repository);
-		remote_refs = transport_get_remote_refs(transport, &ref_prefixes);
+		remote_refs = transport_get_remote_refs(transport, &ref_prefixes, NULL);
 		trace2_region_leave("fetch", "remote_refs", the_repository);
 	} else
 		remote_refs = NULL;
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 092917eca2..4cf3f60b1b 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -118,7 +118,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (server_options.nr)
 		transport->server_options = &server_options;
 
-	ref = transport_get_remote_refs(transport, &ref_prefixes);
+	ref = transport_get_remote_refs(transport, &ref_prefixes, NULL);
 	if (ref) {
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 		repo_set_hash_algo(the_repository, hash_algo);
diff --git a/builtin/remote.c b/builtin/remote.c
index d11a5589e4..9a547240ab 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -950,7 +950,7 @@ static int get_remote_ref_states(const char *name,
 	if (query) {
 		transport = transport_get(states->remote, states->remote->url_nr > 0 ?
 			states->remote->url[0] : NULL);
-		remote_refs = transport_get_remote_refs(transport, NULL);
+		remote_refs = transport_get_remote_refs(transport, NULL, NULL);
 		transport_disconnect(transport);
 
 		states->queried = 1;
diff --git a/connect.c b/connect.c
index 8b8f56cf6d..99d9052365 100644
--- a/connect.c
+++ b/connect.c
@@ -455,7 +455,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
 			     const struct strvec *ref_prefixes,
 			     const struct string_list *server_options,
-			     int stateless_rpc)
+			     int stateless_rpc,
+			     char **unborn_head_target)
 {
 	int i;
 	const char *hash_name;
@@ -496,6 +497,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 
 	/* Process response from server */
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
+		if (unborn_head_target)
+			BUG("NEEDSWORK: provide unborn HEAD target to caller while reading refs");
 		if (!process_ref_v2(reader, &list))
 			die(_("invalid ls-refs response: %s"), reader->line);
 	}
diff --git a/remote.h b/remote.h
index 3211abdf05..967f2178d8 100644
--- a/remote.h
+++ b/remote.h
@@ -198,7 +198,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
 			     const struct strvec *ref_prefixes,
 			     const struct string_list *server_options,
-			     int stateless_rpc);
+			     int stateless_rpc,
+			     char **unborn_head_target);
 
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 
diff --git a/transport-helper.c b/transport-helper.c
index 5f6e0b3bd8..5d97eba935 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1162,13 +1162,16 @@ static int has_attribute(const char *attrs, const char *attr)
 }
 
 static struct ref *get_refs_list(struct transport *transport, int for_push,
-				 const struct strvec *ref_prefixes)
+				 const struct strvec *ref_prefixes,
+				 char **unborn_head_target)
 {
 	get_helper(transport);
 
 	if (process_connect(transport, for_push)) {
 		do_take_over(transport);
-		return transport->vtable->get_refs_list(transport, for_push, ref_prefixes);
+		return transport->vtable->get_refs_list(transport, for_push,
+							ref_prefixes,
+							unborn_head_target);
 	}
 
 	return get_refs_list_using_list(transport, for_push);
diff --git a/transport-internal.h b/transport-internal.h
index 27c9daffc4..5037f6197d 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -18,19 +18,16 @@ struct transport_vtable {
 	 * the transport to try to share connections, for_push is a
 	 * hint as to whether the ultimate operation is a push or a fetch.
 	 *
-	 * If communicating using protocol v2 a list of prefixes can be
-	 * provided to be sent to the server to enable it to limit the ref
-	 * advertisement.  Since ref filtering is done on the server's end, and
-	 * only when using protocol v2, this list will be ignored when not
-	 * using protocol v2 meaning this function can return refs which don't
-	 * match the provided ref_prefixes.
-	 *
 	 * If the transport is able to determine the remote hash for
 	 * the ref without a huge amount of effort, it should store it
 	 * in the ref's old_sha1 field; otherwise it should be all 0.
+	 *
+	 * See transport_get_remote_refs() for information on ref_prefixes and
+	 * unborn_head_target.
 	 **/
 	struct ref *(*get_refs_list)(struct transport *transport, int for_push,
-				     const struct strvec *ref_prefixes);
+				     const struct strvec *ref_prefixes,
+				     char **unborn_head_target);
 
 	/**
 	 * Fetch the objects for the given refs. Note that this gets
diff --git a/transport.c b/transport.c
index 679a35e7c1..396a601d78 100644
--- a/transport.c
+++ b/transport.c
@@ -127,7 +127,8 @@ struct bundle_transport_data {
 
 static struct ref *get_refs_from_bundle(struct transport *transport,
 					int for_push,
-					const struct strvec *ref_prefixes)
+					const struct strvec *ref_prefixes,
+					char **unborn_head_target)
 {
 	struct bundle_transport_data *data = transport->data;
 	struct ref *result = NULL;
@@ -163,7 +164,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	int ret;
 
 	if (!data->get_refs_from_bundle_called)
-		get_refs_from_bundle(transport, 0, NULL);
+		get_refs_from_bundle(transport, 0, NULL, NULL);
 	ret = unbundle(the_repository, &data->header, data->fd,
 			   transport->progress ? BUNDLE_VERBOSE : 0);
 	transport->hash_algo = data->header.hash_algo;
@@ -281,7 +282,7 @@ static void die_if_server_options(struct transport *transport)
  */
 static struct ref *handshake(struct transport *transport, int for_push,
 			     const struct strvec *ref_prefixes,
-			     int must_list_refs)
+			     int must_list_refs, char **unborn_head_target)
 {
 	struct git_transport_data *data = transport->data;
 	struct ref *refs = NULL;
@@ -305,7 +306,8 @@ static struct ref *handshake(struct transport *transport, int for_push,
 			get_remote_refs(data->fd[1], &reader, &refs, for_push,
 					ref_prefixes,
 					transport->server_options,
-					transport->stateless_rpc);
+					transport->stateless_rpc,
+					unborn_head_target);
 		break;
 	case protocol_v1:
 	case protocol_v0:
@@ -334,9 +336,11 @@ static struct ref *handshake(struct transport *transport, int for_push,
 }
 
 static struct ref *get_refs_via_connect(struct transport *transport, int for_push,
-					const struct strvec *ref_prefixes)
+					const struct strvec *ref_prefixes,
+					char **unborn_head_target)
 {
-	return handshake(transport, for_push, ref_prefixes, 1);
+	return handshake(transport, for_push, ref_prefixes, 1,
+			 unborn_head_target);
 }
 
 static int fetch_refs_via_pack(struct transport *transport,
@@ -380,7 +384,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 				break;
 			}
 		}
-		refs_tmp = handshake(transport, 0, NULL, must_list_refs);
+		refs_tmp = handshake(transport, 0, NULL, must_list_refs, NULL);
 	}
 
 	if (data->version == protocol_unknown_version)
@@ -775,7 +779,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 		return -1;
 
 	if (!data->got_remote_heads)
-		get_refs_via_connect(transport, 1, NULL);
+		get_refs_via_connect(transport, 1, NULL, NULL);
 
 	memset(&args, 0, sizeof(args));
 	args.send_mirror = !!(flags & TRANSPORT_PUSH_MIRROR);
@@ -1261,7 +1265,8 @@ int transport_push(struct repository *r,
 
 		trace2_region_enter("transport_push", "get_refs_list", r);
 		remote_refs = transport->vtable->get_refs_list(transport, 1,
-							       &ref_prefixes);
+							       &ref_prefixes,
+							       NULL);
 		trace2_region_leave("transport_push", "get_refs_list", r);
 
 		strvec_clear(&ref_prefixes);
@@ -1380,12 +1385,14 @@ int transport_push(struct repository *r,
 }
 
 const struct ref *transport_get_remote_refs(struct transport *transport,
-					    const struct strvec *ref_prefixes)
+					    const struct strvec *ref_prefixes,
+					    char **unborn_head_target)
 {
 	if (!transport->got_remote_refs) {
 		transport->remote_refs =
 			transport->vtable->get_refs_list(transport, 0,
-							 ref_prefixes);
+							 ref_prefixes,
+							 unborn_head_target);
 		transport->got_remote_refs = 1;
 	}
 
diff --git a/transport.h b/transport.h
index 24558c027d..65de0c9c00 100644
--- a/transport.h
+++ b/transport.h
@@ -241,9 +241,14 @@ int transport_push(struct repository *repo,
  * advertisement.  Since ref filtering is done on the server's end (and only
  * when using protocol v2), this can return refs which don't match the provided
  * ref_prefixes.
+ *
+ * If unborn_head_target is not NULL, and the remote reports HEAD as pointing
+ * to an unborn branch, this function stores the unborn branch in
+ * unborn_head_target. It should be freed by the caller.
  */
 const struct ref *transport_get_remote_refs(struct transport *transport,
-					    const struct strvec *ref_prefixes);
+					    const struct strvec *ref_prefixes,
+					    char **unborn_head_target);
 
 /*
  * Fetch the hash algorithm used by a remote.
-- 
2.29.2.729.g45daf8777d-goog

