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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B86EC433E6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FAA064EE7
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhBBCPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 21:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhBBCPw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 21:15:52 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282E0C061756
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 18:15:12 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id w4so12798974pgc.7
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 18:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fpFYBWWcFL4809MKQJpr9Xe8M++GWLDFFj3NKw6THe0=;
        b=l5o5kjTwbpaWto6YL3P4FSLDKtEJzcKMnYW7zkerXDDcnWruuCeqOC3huwNeiKxHRm
         xGJd3MDy5l6P/k44VG06jVe5DFp50dDuKkTRPL74ZAgtyE5MnUC6eebgwKwTt7fT4pqI
         V0MDIfzRDoI2AU/+RB14AgEsvnJi6nQKt5fE98oG9G3R8RMjIxgc7zSk90Rz2njkemlK
         6TEDqGgOd87JT5crAQ852I7ryyq/93ybZZ+WmOj+fa/eaqkSQn0ZfxVJ9/uZ2gpG4nHk
         4IK3Y2mPFPqg/4WnMFbQF6UbrV3G42k9OMC/CsAgH2uvQC9XvPtbqHUIY0oQMHe0Ax33
         GlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fpFYBWWcFL4809MKQJpr9Xe8M++GWLDFFj3NKw6THe0=;
        b=QpuPH9LIEfaqBPPGL5f7Fdyy171Ec2kwWlBU2jJgppjZ1Ir28rRDSB4LOS/x9CVLvu
         wlDrxj9ob9dorkhXv8KerqFJNOXXshxVEL94kVfMkbTbxl8uVIlADwN1GTiU7kgdTExI
         teAp9Vv16bfq8wmOuWtOYwHNwGFqil/AEF2kpZsECKJlAhnZPsryksYt2lXgZkV9fQj7
         aJqOcA4n7Xweu9y90Q+j7D2ce4yyb6K+Genxzi7OmN7b8ocVnL6r8TGoHp01VTUB1S50
         j2myVjc6X8rXoItJih5ASIZNVVYWoGYHfOGHxnjkjV+A4jZKGTKNDiGjW3R81H5B2dW2
         +Wzg==
X-Gm-Message-State: AOAM532PQwcpvGYb/fT1tLEwOsYF+cgONBmqZu0J1l2prL98lrlsa8jt
        sNewJex5d0HYu3pSCMvlrwASzjMEAkewjjaPw7XC5Oy8ydolVgUpCv9NTTX3u5V1HXebQIGdEkx
        48+yuPaJO9fmStmLMuS/2+4SZ2zn5R/jVKn23GRiFEEqNAGeoovZT0j4FSIs3ofbMY+V3dKzzsT
        +W
X-Google-Smtp-Source: ABdhPJz3OS/ze5znw56EG/jv/vjFNaJFGVCeXan5dBeG7Q7vrsULkcNkw2AjzrSk+x9dipDDe5rjgrn2nd6T8toYmeOj
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:c94d:b029:de:9b70:d886 with
 SMTP id i13-20020a170902c94db02900de9b70d886mr19760323pla.5.1612232111593;
 Mon, 01 Feb 2021 18:15:11 -0800 (PST)
Date:   Mon,  1 Feb 2021 18:15:00 -0800
In-Reply-To: <cover.1612231707.git.jonathantanmy@google.com>
Message-Id: <fad1ebe6b6b25e6caac6b9d1b3d7b3f8d5dca1d3.1612231707.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201208013121.677494-1-jonathantanmy@google.com> <cover.1612231707.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v6 2/3] connect, transport: encapsulate arg in struct
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch we plan to return the name of an unborn current branch
from deep in the callchain to a caller via a new pointer parameter that
points at a variable in the caller when the caller calls
get_remote_refs() and transport_get_remote_refs().

In preparation for that, encapsulate the existing ref_prefixes
parameter into a struct. The aforementioned unborn current branch will
go into this new struct in the future patch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clone.c      | 18 +++++++++++-------
 builtin/fetch-pack.c |  3 ++-
 builtin/fetch.c      | 18 +++++++++++-------
 builtin/ls-remote.c  |  9 +++++----
 connect.c            |  4 +++-
 remote.h             |  4 +++-
 transport-helper.c   |  5 +++--
 transport-internal.h | 10 ++--------
 transport.c          | 23 ++++++++++++-----------
 transport.h          | 21 ++++++++++++++-------
 10 files changed, 66 insertions(+), 49 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a5630337e4..211d4f54b0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -979,7 +979,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
 
-	struct strvec ref_prefixes = STRVEC_INIT;
+	struct transport_ls_refs_options transport_ls_refs_options =
+		TRANSPORT_LS_REFS_OPTIONS_INIT;
 
 	packet_trace_identity("clone");
 
@@ -1257,14 +1258,17 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
 
-	strvec_push(&ref_prefixes, "HEAD");
-	refspec_ref_prefixes(&remote->fetch, &ref_prefixes);
+	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+	refspec_ref_prefixes(&remote->fetch,
+			     &transport_ls_refs_options.ref_prefixes);
 	if (option_branch)
-		expand_ref_prefix(&ref_prefixes, option_branch);
+		expand_ref_prefix(&transport_ls_refs_options.ref_prefixes,
+				  option_branch);
 	if (!option_no_tags)
-		strvec_push(&ref_prefixes, "refs/tags/");
+		strvec_push(&transport_ls_refs_options.ref_prefixes,
+			    "refs/tags/");
 
-	refs = transport_get_remote_refs(transport, &ref_prefixes);
+	refs = transport_get_remote_refs(transport, &transport_ls_refs_options);
 
 	if (refs) {
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
@@ -1380,6 +1384,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&key);
 	junk_mode = JUNK_LEAVE_ALL;
 
-	strvec_clear(&ref_prefixes);
+	strvec_clear(&transport_ls_refs_options.ref_prefixes);
 	return err;
 }
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 58b7c1fbdc..c2d96f4c89 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -220,7 +220,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	version = discover_version(&reader);
 	switch (version) {
 	case protocol_v2:
-		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL, args.stateless_rpc);
+		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL,
+				args.stateless_rpc);
 		break;
 	case protocol_v1:
 	case protocol_v0:
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ecf8537605..837382ef4f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1349,7 +1349,8 @@ static int do_fetch(struct transport *transport,
 	int autotags = (transport->remote->fetch_tags == 1);
 	int retcode = 0;
 	const struct ref *remote_refs;
-	struct strvec ref_prefixes = STRVEC_INIT;
+	struct transport_ls_refs_options transport_ls_refs_options =
+		TRANSPORT_LS_REFS_OPTIONS_INIT;
 	int must_list_refs = 1;
 
 	if (tags == TAGS_DEFAULT) {
@@ -1369,7 +1370,7 @@ static int do_fetch(struct transport *transport,
 	if (rs->nr) {
 		int i;
 
-		refspec_ref_prefixes(rs, &ref_prefixes);
+		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 
 		/*
 		 * We can avoid listing refs if all of them are exact
@@ -1383,22 +1384,25 @@ static int do_fetch(struct transport *transport,
 			}
 		}
 	} else if (transport->remote && transport->remote->fetch.nr)
-		refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
+		refspec_ref_prefixes(&transport->remote->fetch,
+				     &transport_ls_refs_options.ref_prefixes);
 
 	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
 		must_list_refs = 1;
-		if (ref_prefixes.nr)
-			strvec_push(&ref_prefixes, "refs/tags/");
+		if (transport_ls_refs_options.ref_prefixes.nr)
+			strvec_push(&transport_ls_refs_options.ref_prefixes,
+				    "refs/tags/");
 	}
 
 	if (must_list_refs) {
 		trace2_region_enter("fetch", "remote_refs", the_repository);
-		remote_refs = transport_get_remote_refs(transport, &ref_prefixes);
+		remote_refs = transport_get_remote_refs(transport,
+							&transport_ls_refs_options);
 		trace2_region_leave("fetch", "remote_refs", the_repository);
 	} else
 		remote_refs = NULL;
 
-	strvec_clear(&ref_prefixes);
+	strvec_clear(&transport_ls_refs_options.ref_prefixes);
 
 	ref_map = get_ref_map(transport->remote, remote_refs, rs,
 			      tags, &autotags);
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 092917eca2..ef604752a0 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -45,7 +45,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	int show_symref_target = 0;
 	const char *uploadpack = NULL;
 	const char **pattern = NULL;
-	struct strvec ref_prefixes = STRVEC_INIT;
+	struct transport_ls_refs_options transport_options =
+		TRANSPORT_LS_REFS_OPTIONS_INIT;
 	int i;
 	struct string_list server_options = STRING_LIST_INIT_DUP;
 
@@ -94,9 +95,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	}
 
 	if (flags & REF_TAGS)
-		strvec_push(&ref_prefixes, "refs/tags/");
+		strvec_push(&transport_options.ref_prefixes, "refs/tags/");
 	if (flags & REF_HEADS)
-		strvec_push(&ref_prefixes, "refs/heads/");
+		strvec_push(&transport_options.ref_prefixes, "refs/heads/");
 
 	remote = remote_get(dest);
 	if (!remote) {
@@ -118,7 +119,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (server_options.nr)
 		transport->server_options = &server_options;
 
-	ref = transport_get_remote_refs(transport, &ref_prefixes);
+	ref = transport_get_remote_refs(transport, &transport_options);
 	if (ref) {
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 		repo_set_hash_algo(the_repository, hash_algo);
diff --git a/connect.c b/connect.c
index 8b8f56cf6d..328c279250 100644
--- a/connect.c
+++ b/connect.c
@@ -453,12 +453,14 @@ void check_stateless_delimiter(int stateless_rpc,
 
 struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
-			     const struct strvec *ref_prefixes,
+			     struct transport_ls_refs_options *transport_options,
 			     const struct string_list *server_options,
 			     int stateless_rpc)
 {
 	int i;
 	const char *hash_name;
+	struct strvec *ref_prefixes = transport_options ?
+		&transport_options->ref_prefixes : NULL;
 	*list = NULL;
 
 	if (server_supports_v2("ls-refs", 1))
diff --git a/remote.h b/remote.h
index 3211abdf05..4ae676a11b 100644
--- a/remote.h
+++ b/remote.h
@@ -6,6 +6,8 @@
 #include "hashmap.h"
 #include "refspec.h"
 
+struct transport_ls_refs_options;
+
 /**
  * The API gives access to the configuration related to remotes. It handles
  * all three configuration mechanisms historically and currently used by Git,
@@ -196,7 +198,7 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 /* Used for protocol v2 in order to retrieve refs from a remote */
 struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
-			     const struct strvec *ref_prefixes,
+			     struct transport_ls_refs_options *transport_options,
 			     const struct string_list *server_options,
 			     int stateless_rpc);
 
diff --git a/transport-helper.c b/transport-helper.c
index 5f6e0b3bd8..49b7fb4dcb 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1162,13 +1162,14 @@ static int has_attribute(const char *attrs, const char *attr)
 }
 
 static struct ref *get_refs_list(struct transport *transport, int for_push,
-				 const struct strvec *ref_prefixes)
+				 struct transport_ls_refs_options *transport_options)
 {
 	get_helper(transport);
 
 	if (process_connect(transport, for_push)) {
 		do_take_over(transport);
-		return transport->vtable->get_refs_list(transport, for_push, ref_prefixes);
+		return transport->vtable->get_refs_list(transport, for_push,
+							transport_options);
 	}
 
 	return get_refs_list_using_list(transport, for_push);
diff --git a/transport-internal.h b/transport-internal.h
index 27c9daffc4..b60f1ba907 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -4,6 +4,7 @@
 struct ref;
 struct transport;
 struct strvec;
+struct transport_ls_refs_options;
 
 struct transport_vtable {
 	/**
@@ -18,19 +19,12 @@ struct transport_vtable {
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
 	 **/
 	struct ref *(*get_refs_list)(struct transport *transport, int for_push,
-				     const struct strvec *ref_prefixes);
+				     struct transport_ls_refs_options *transport_options);
 
 	/**
 	 * Fetch the objects for the given refs. Note that this gets
diff --git a/transport.c b/transport.c
index 679a35e7c1..b13fab5dc3 100644
--- a/transport.c
+++ b/transport.c
@@ -127,7 +127,7 @@ struct bundle_transport_data {
 
 static struct ref *get_refs_from_bundle(struct transport *transport,
 					int for_push,
-					const struct strvec *ref_prefixes)
+					struct transport_ls_refs_options *transport_options)
 {
 	struct bundle_transport_data *data = transport->data;
 	struct ref *result = NULL;
@@ -280,7 +280,7 @@ static void die_if_server_options(struct transport *transport)
  * remote refs.
  */
 static struct ref *handshake(struct transport *transport, int for_push,
-			     const struct strvec *ref_prefixes,
+			     struct transport_ls_refs_options *options,
 			     int must_list_refs)
 {
 	struct git_transport_data *data = transport->data;
@@ -303,7 +303,7 @@ static struct ref *handshake(struct transport *transport, int for_push,
 			trace2_data_string("transfer", NULL, "server-sid", server_sid);
 		if (must_list_refs)
 			get_remote_refs(data->fd[1], &reader, &refs, for_push,
-					ref_prefixes,
+					options,
 					transport->server_options,
 					transport->stateless_rpc);
 		break;
@@ -334,9 +334,9 @@ static struct ref *handshake(struct transport *transport, int for_push,
 }
 
 static struct ref *get_refs_via_connect(struct transport *transport, int for_push,
-					const struct strvec *ref_prefixes)
+					struct transport_ls_refs_options *options)
 {
-	return handshake(transport, for_push, ref_prefixes, 1);
+	return handshake(transport, for_push, options, 1);
 }
 
 static int fetch_refs_via_pack(struct transport *transport,
@@ -1252,19 +1252,20 @@ int transport_push(struct repository *r,
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
 		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
 		int push_ret, ret, err;
-		struct strvec ref_prefixes = STRVEC_INIT;
+		struct transport_ls_refs_options transport_options =
+			TRANSPORT_LS_REFS_OPTIONS_INIT;
 
 		if (check_push_refs(local_refs, rs) < 0)
 			return -1;
 
-		refspec_ref_prefixes(rs, &ref_prefixes);
+		refspec_ref_prefixes(rs, &transport_options.ref_prefixes);
 
 		trace2_region_enter("transport_push", "get_refs_list", r);
 		remote_refs = transport->vtable->get_refs_list(transport, 1,
-							       &ref_prefixes);
+							       &transport_options);
 		trace2_region_leave("transport_push", "get_refs_list", r);
 
-		strvec_clear(&ref_prefixes);
+		strvec_clear(&transport_options.ref_prefixes);
 
 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
@@ -1380,12 +1381,12 @@ int transport_push(struct repository *r,
 }
 
 const struct ref *transport_get_remote_refs(struct transport *transport,
-					    const struct strvec *ref_prefixes)
+					    struct transport_ls_refs_options *transport_options)
 {
 	if (!transport->got_remote_refs) {
 		transport->remote_refs =
 			transport->vtable->get_refs_list(transport, 0,
-							 ref_prefixes);
+							 transport_options);
 		transport->got_remote_refs = 1;
 	}
 
diff --git a/transport.h b/transport.h
index 24558c027d..1f5b60e4d3 100644
--- a/transport.h
+++ b/transport.h
@@ -233,17 +233,24 @@ int transport_push(struct repository *repo,
 		   struct refspec *rs, int flags,
 		   unsigned int * reject_reasons);
 
+struct transport_ls_refs_options {
+	/*
+	 * Optionally, a list of ref prefixes can be provided which can be sent
+	 * to the server (when communicating using protocol v2) to enable it to
+	 * limit the ref advertisement.  Since ref filtering is done on the
+	 * server's end (and only when using protocol v2),
+	 * transport_get_remote_refs() could return refs which don't match the
+	 * provided ref_prefixes.
+	 */
+	struct strvec ref_prefixes;
+};
+#define TRANSPORT_LS_REFS_OPTIONS_INIT { STRVEC_INIT }
+
 /*
  * Retrieve refs from a remote.
- *
- * Optionally a list of ref prefixes can be provided which can be sent to the
- * server (when communicating using protocol v2) to enable it to limit the ref
- * advertisement.  Since ref filtering is done on the server's end (and only
- * when using protocol v2), this can return refs which don't match the provided
- * ref_prefixes.
  */
 const struct ref *transport_get_remote_refs(struct transport *transport,
-					    const struct strvec *ref_prefixes);
+					    struct transport_ls_refs_options *transport_options);
 
 /*
  * Fetch the hash algorithm used by a remote.
-- 
2.30.0.365.g02bc693789-goog

