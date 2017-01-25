Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96EB41F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbdAYWDe (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:03:34 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33276 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751720AbdAYWDb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:03:31 -0500
Received: by mail-pg0-f53.google.com with SMTP id 204so67749528pge.0
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3cFv1UEVVCQE9vzF/zPHgDOeIBXSkFffkffNLJdvRcg=;
        b=FD2+qizxANv/90174w6fEC+WOSdFAO68JpsCRT9hj3eastAvkkyXlEQYfiZfAXNZdV
         CgoyMQEuniJ8ymD+hz/WqkI8bpywIbeLaiP+PDdawoVlhsxcXcdQkIz0fmGUA2T93I+M
         VO0Ac/febFetqu574QScWzSJwGMMGBiNtwn/F92xIjInY8HK/NStZGm0SGBK9jwr3Juc
         46qzeUpiPn926ibJi8JiAe/Bz10Gs6OCrCVGpPaVwJuzByEvbkzQgZ/27KKRWUcmgxNE
         VleLN0gOeI56ThislxEOkfnpfh6xfntgAoXX8/R9PS8kHdQfiFPsHm5w2xFa2Ylf/6jD
         feeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3cFv1UEVVCQE9vzF/zPHgDOeIBXSkFffkffNLJdvRcg=;
        b=djhDkCHWiBVGdKoNBXhRT2JPJorm3DgPi9soj4njLrTxN7kNGU8g7hSjalc8GvEYTS
         icOpQu3beF5hbw30GsPLSjE1ZtcinjyL06Yh6cFrhPFTwRm/eCFqlH04GIZt4J8QmKLT
         kDvU/rmjFPWC58BaANhnVih8vqT36jbJFoHbjnSRIWp/+Ho9CdHmGcT+A+obIuYIc8UQ
         RmR1wyO7HSDHjBObuCht6ZonvqdjiRCnGSGi2/FYWQw3OskhNij0kNXJuqd2Xi7KjyQ+
         Pnh/K7Uec0eYhljx78RFOA8YbSFFDxPoKxNFkLNrgobR9yffs1tQHmuIzm2H5oswxIEk
         zGqA==
X-Gm-Message-State: AIkVDXLKYlbMzglZUUZ5v+BML63bi2lHM89x35+iHv/PuDPEJTejXDcLK3oZ8vAtS41NCpC7
X-Received: by 10.84.196.131 with SMTP id l3mr6919169pld.150.1485381809972;
        Wed, 25 Jan 2017 14:03:29 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id o24sm3357308pfj.78.2017.01.25.14.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 14:03:29 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 13/14] fetch: send want-ref and receive fetched refs
Date:   Wed, 25 Jan 2017 14:03:06 -0800
Message-Id: <eef2b77d88df0db08e4a1505b06e0af2d40143d5.1485381677.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach fetch to send refspecs to the underlying transport, and teach all
components used by the HTTP transport (remote-curl, transport-helper,
fetch-pack) to understand and propagate the names and SHA-1s of the refs
fetched.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/clone.c                    |   4 +-
 builtin/fetch-pack.c               |   8 ++-
 builtin/fetch.c                    | 100 ++++++++++++++++++++++++++++++-------
 remote-curl.c                      |  91 ++++++++++++++++++++-------------
 t/t5552-upload-pack-ref-in-want.sh |   4 +-
 transport-helper.c                 |  74 +++++++++++++++++++++------
 transport.c                        |  10 ++--
 transport.h                        |  20 +++++---
 8 files changed, 229 insertions(+), 82 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 3191da391..765a3a3b6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1078,7 +1078,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			}
 
 		if (!is_local && !complete_refs_before_fetch) {
-			transport_fetch_refs(transport, mapped_refs,
+			transport_fetch_refs(transport, NULL, 0, mapped_refs,
 					     &new_remote_refs);
 			if (new_remote_refs) {
 				refs = new_remote_refs;
@@ -1124,7 +1124,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (is_local)
 		clone_local(path, git_dir);
 	else if (refs && complete_refs_before_fetch)
-		transport_fetch_refs(transport, mapped_refs, NULL);
+		transport_fetch_refs(transport, NULL, 0, mapped_refs, NULL);
 
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
 			   branch_top.buf, reflog_msg.buf, transport, !is_local);
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 24af3b7c5..ed1608c12 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -35,6 +35,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	struct fetch_pack_args args;
 	struct sha1_array shallow = SHA1_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
+	int always_print_refs = 0;
 
 	packet_trace_identity("fetch-pack");
 
@@ -126,6 +127,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.update_shallow = 1;
 			continue;
 		}
+		if (!strcmp("--always-print-refs", arg)) {
+			always_print_refs = 1;
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
 	if (deepen_not.nr)
@@ -218,7 +223,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		ret = 1;
 	}
 
-	if (args.stateless_rpc)
+	if (args.stateless_rpc && !always_print_refs)
 		goto cleanup;
 
 	while (ref) {
@@ -226,6 +231,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		       oid_to_hex(&ref->old_oid), ref->name);
 		ref = ref->next;
 	}
+	fflush(stdout);
 
 cleanup:
 	close(fd[0]);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 19e3f40a0..87de00e49 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -302,10 +302,75 @@ static void find_non_local_tags(const struct ref *refs,
 	string_list_clear(&remote_refs, 0);
 }
 
+static void get_effective_refspecs(struct refspec **e_rs, int *e_rs_nr,
+				   const struct remote *remote,
+				   const struct refspec *cli_rs, int cli_rs_nr,
+				   int tags, int *autotags)
+{
+	static struct refspec head_refspec;
+
+	const struct refspec *base_rs;
+	int base_rs_nr;
+	struct branch *merge_branch = NULL;
+	int i;
+
+	struct refspec *rs;
+	int nr, alloc;
+
+	if (cli_rs_nr) {
+		base_rs = cli_rs;
+		base_rs_nr = cli_rs_nr;
+	} else if (refmap_array) {
+		die("--refmap option is only meaningful with command-line refspec(s).");
+	} else {
+		/* Use the defaults */
+		struct branch *branch = branch_get(NULL);
+		int has_merge = branch_has_merge_config(branch);
+		/* Note: has_merge implies non-NULL branch->remote_name */
+		if (has_merge && !strcmp(branch->remote_name, remote->name))
+			/*
+			 * if the remote we're fetching from is the same
+			 * as given in branch.<name>.remote, we add the
+			 * ref given in branch.<name>.merge, too.
+			 */
+			merge_branch = branch;
+		if (remote &&
+		    (remote->fetch_refspec_nr || merge_branch)) {
+			base_rs = remote->fetch;
+			base_rs_nr = remote->fetch_refspec_nr;
+		} else {
+			head_refspec.src = "HEAD";
+			base_rs = &head_refspec;
+			base_rs_nr = 1;
+		}
+	}
+
+	for (i = 0; i < base_rs_nr; i++)
+		if (base_rs[i].dst && base_rs[i].dst[0]) {
+			*autotags = 1;
+			break;
+		}
+
+	alloc = base_rs_nr +
+		(merge_branch ? merge_branch->merge_nr : 0) +
+		(tags == TAGS_SET);
+	rs = xcalloc(alloc, sizeof(*rs));
+	memcpy(rs, base_rs, base_rs_nr * sizeof(*rs));
+	nr = base_rs_nr;
+	if (merge_branch)
+		for (i = 0; i < merge_branch->merge_nr; i++)
+			rs[nr++].src = merge_branch->merge[i]->src;
+	if (tags == TAGS_SET)
+		rs[nr++] = *tag_refspec;
+
+	*e_rs = rs;
+	*e_rs_nr = nr;
+}
+
 static struct ref *get_ref_map(const struct remote *remote,
 			       const struct ref *remote_refs,
 			       struct refspec *refspecs, int refspec_count,
-			       int tags, int *autotags)
+			       int tags, int autotags)
 {
 	int i;
 	struct ref *rm;
@@ -321,11 +386,8 @@ static struct ref *get_ref_map(const struct remote *remote,
 		struct refspec *fetch_refspec;
 		int fetch_refspec_nr;
 
-		for (i = 0; i < refspec_count; i++) {
+		for (i = 0; i < refspec_count; i++)
 			get_fetch_map(remote_refs, &refspecs[i], &tail, 0);
-			if (refspecs[i].dst && refspecs[i].dst[0])
-				*autotags = 1;
-		}
 		/* Merge everything on the command line (but not --tags) */
 		for (rm = ref_map; rm; rm = rm->next)
 			rm->fetch_head_status = FETCH_HEAD_MERGE;
@@ -372,9 +434,6 @@ static struct ref *get_ref_map(const struct remote *remote,
 		     (has_merge && !strcmp(branch->remote_name, remote->name)))) {
 			for (i = 0; i < remote->fetch_refspec_nr; i++) {
 				get_fetch_map(remote_refs, &remote->fetch[i], &tail, 0);
-				if (remote->fetch[i].dst &&
-				    remote->fetch[i].dst[0])
-					*autotags = 1;
 				if (!i && !has_merge && ref_map &&
 				    !remote->fetch[0].pattern)
 					ref_map->fetch_head_status = FETCH_HEAD_MERGE;
@@ -401,7 +460,7 @@ static struct ref *get_ref_map(const struct remote *remote,
 	if (tags == TAGS_SET)
 		/* also fetch all tags */
 		get_fetch_map(remote_refs, tag_refspec, &tail, 0);
-	else if (tags == TAGS_DEFAULT && *autotags)
+	else if (tags == TAGS_DEFAULT && autotags)
 		find_non_local_tags(remote_refs, &ref_map, &tail);
 
 	/* Now append any refs to be updated opportunistically: */
@@ -911,13 +970,14 @@ static int quickfetch(struct ref *ref_map)
 	return check_connected(iterate_ref_map, &rm, &opt);
 }
 
-static int fetch_refs(struct transport *transport, struct ref *ref_map,
-		      struct ref **updated_remote_refs)
+static int fetch_refs(struct transport *transport,
+		      struct refspec *refspecs, int refspec_nr,
+		      struct ref *ref_map, struct ref **updated_remote_refs)
 {
 	int ret = quickfetch(ref_map);
 	if (ret)
-		ret = transport_fetch_refs(transport, ref_map,
-					   updated_remote_refs);
+		ret = transport_fetch_refs(transport, refspecs, refspec_nr,
+					   ref_map, updated_remote_refs);
 	if (ret)
 		transport_unlock_pack(transport);
 	return ret;
@@ -1068,7 +1128,7 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
-	if (!fetch_refs(transport, ref_map, NULL))
+	if (!fetch_refs(transport, NULL, 0, ref_map, NULL))
 		consume_refs(transport, ref_map);
 
 	if (gsecondary) {
@@ -1083,6 +1143,10 @@ static int do_fetch(struct transport *transport,
 	struct ref *ref_map;
 	int autotags = (transport->remote->fetch_tags == 1);
 	int retcode = 0;
+
+	struct refspec *e_rs;
+	int e_rs_nr;
+
 	const struct ref *remote_refs;
 	struct ref *new_remote_refs = NULL;
 
@@ -1103,9 +1167,11 @@ static int do_fetch(struct transport *transport,
 			goto cleanup;
 	}
 
+	get_effective_refspecs(&e_rs, &e_rs_nr, transport->remote,
+			       refs, ref_count, tags, &autotags);
 	remote_refs = transport_get_remote_refs(transport);
 	ref_map = get_ref_map(transport->remote, remote_refs, refs, ref_count,
-			      tags, &autotags);
+			      tags, autotags);
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
@@ -1126,7 +1192,7 @@ static int do_fetch(struct transport *transport,
 				   transport->url);
 		}
 	}
-	if (fetch_refs(transport, ref_map, &new_remote_refs)) {
+	if (fetch_refs(transport, e_rs, e_rs_nr, ref_map, &new_remote_refs)) {
 		free_refs(ref_map);
 		retcode = 1;
 		goto cleanup;
@@ -1134,7 +1200,7 @@ static int do_fetch(struct transport *transport,
 	if (new_remote_refs) {
 		free_refs(ref_map);
 		ref_map = get_ref_map(transport->remote, new_remote_refs,
-				      refs, ref_count, tags, &autotags);
+				      refs, ref_count, tags, autotags);
 		free_refs(new_remote_refs);
 	}
 
diff --git a/remote-curl.c b/remote-curl.c
index 34a97e732..e78959d47 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -12,6 +12,7 @@
 #include "credential.h"
 #include "sha1-array.h"
 #include "send-pack.h"
+#include "refs.h"
 
 static struct remote *remote;
 /* always ends with a trailing slash */
@@ -31,7 +32,8 @@ struct options {
 		thin : 1,
 		/* One of the SEND_PACK_PUSH_CERT_* constants. */
 		push_cert : 2,
-		deepen_relative : 1;
+		deepen_relative : 1,
+		echo_refs : 1;
 };
 static struct options options;
 static struct string_list cas_options = STRING_LIST_INIT_DUP;
@@ -139,6 +141,14 @@ static int set_option(const char *name, const char *value)
 		else
 			return -1;
 		return 0;
+	} else if (!strcmp(name, "echo-refs")) {
+		if (!strcmp(value, "true"))
+			options.echo_refs = 1;
+		else if (!strcmp(value, "false"))
+			options.echo_refs = 0;
+		else
+			return -1;
+		return 0;
 
 #if LIBCURL_VERSION_NUM >= 0x070a08
 	} else if (!strcmp(name, "family")) {
@@ -750,7 +760,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	return err;
 }
 
-static int fetch_dumb(int nr_heads, struct ref **to_fetch)
+static int fetch_dumb(int nr_heads, const struct ref **to_fetch)
 {
 	struct walker *walker;
 	char **targets;
@@ -775,11 +785,24 @@ static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 		free(targets[i]);
 	free(targets);
 
+	if (options.echo_refs) {
+		struct strbuf sb = STRBUF_INIT;
+		for (i = 0; i < nr_heads; i++) {
+			strbuf_reset(&sb);
+			strbuf_addf(&sb,
+				    "%s %s\n",
+				    oid_to_hex(&to_fetch[i]->old_oid),
+				    to_fetch[i]->name);
+			write_or_die(1, sb.buf, sb.len);
+		}
+	}
+
 	return ret ? error("fetch failed.") : 0;
 }
 
 static int fetch_git(struct discovery *heads,
-	int nr_heads, struct ref **to_fetch)
+	int nr_refspec, const struct refspec *refspecs,
+	int nr_heads, const struct ref **to_fetch)
 {
 	struct rpc_state rpc;
 	struct strbuf preamble = STRBUF_INIT;
@@ -811,10 +834,15 @@ static int fetch_git(struct discovery *heads,
 				 options.deepen_not.items[i].string);
 	if (options.deepen_relative && options.depth)
 		argv_array_push(&args, "--deepen-relative");
+	if (options.echo_refs)
+		argv_array_push(&args, "--always-print-refs");
 	argv_array_push(&args, url.buf);
 
-	for (i = 0; i < nr_heads; i++) {
-		struct ref *ref = to_fetch[i];
+	if (refspecs) {
+		for (i = 0; i < nr_refspec; i++)
+			packet_buf_write(&preamble, "%s\n", refspecs[i].src);
+	} else {
+		const struct ref *ref = to_fetch[i];
 		if (!*ref->name)
 			die("cannot fetch by sha1 over smart http");
 		packet_buf_write(&preamble, "%s %s\n",
@@ -837,46 +865,38 @@ static int fetch_git(struct discovery *heads,
 	return err;
 }
 
-static int fetch(int nr_heads, struct ref **to_fetch)
+static int fetch(int nr_refspec, const struct refspec *refspecs)
 {
+	const struct ref **to_fetch;
+	int nr;
+	int ret, i;
 	struct discovery *d = discover_refs("git-upload-pack", 0);
+	get_ref_array(&to_fetch, &nr, d->refs, refspecs, nr_refspec);
+
 	if (d->proto_git)
-		return fetch_git(d, nr_heads, to_fetch);
+		ret = fetch_git(d, nr_refspec, refspecs, nr, to_fetch);
 	else
-		return fetch_dumb(nr_heads, to_fetch);
+		ret = fetch_dumb(nr, to_fetch);
+
+	for (i = 0; i < nr; i++) {
+		free((void *) to_fetch[i]);
+	}
+	free(to_fetch);
+
+	return ret;
 }
 
 static void parse_fetch(struct strbuf *buf)
 {
-	struct ref **to_fetch = NULL;
-	struct ref *list_head = NULL;
-	struct ref **list = &list_head;
-	int alloc_heads = 0, nr_heads = 0;
+	struct refspec *to_fetch = NULL;
+	int alloc = 0, nr = 0;
 
 	do {
 		const char *p;
 		if (skip_prefix(buf->buf, "fetch ", &p)) {
-			const char *name;
-			struct ref *ref;
-			struct object_id old_oid;
-
-			if (get_oid_hex(p, &old_oid))
-				die("protocol error: expected sha/ref, got %s'", p);
-			if (p[GIT_SHA1_HEXSZ] == ' ')
-				name = p + GIT_SHA1_HEXSZ + 1;
-			else if (!p[GIT_SHA1_HEXSZ])
-				name = "";
-			else
-				die("protocol error: expected sha/ref, got %s'", p);
-
-			ref = alloc_ref(name);
-			oidcpy(&ref->old_oid, &old_oid);
-
-			*list = ref;
-			list = &ref->next;
-
-			ALLOC_GROW(to_fetch, nr_heads + 1, alloc_heads);
-			to_fetch[nr_heads++] = ref;
+			nr++;
+			ALLOC_GROW(to_fetch, nr, alloc);
+			parse_ref_or_pattern(&to_fetch[nr - 1], p);
 		}
 		else
 			die("http transport does not support %s", buf->buf);
@@ -888,10 +908,8 @@ static void parse_fetch(struct strbuf *buf)
 			break;
 	} while (1);
 
-	if (fetch(nr_heads, to_fetch))
+	if (fetch(nr, to_fetch))
 		exit(128); /* error already reported */
-	free_refs(list_head);
-	free(to_fetch);
 
 	printf("\n");
 	fflush(stdout);
@@ -1084,6 +1102,7 @@ int cmd_main(int argc, const char **argv)
 			printf("option\n");
 			printf("push\n");
 			printf("check-connectivity\n");
+			printf("echo-refs\n");
 			printf("\n");
 			fflush(stdout);
 		} else {
diff --git a/t/t5552-upload-pack-ref-in-want.sh b/t/t5552-upload-pack-ref-in-want.sh
index 80cf2263a..26e785f3b 100755
--- a/t/t5552-upload-pack-ref-in-want.sh
+++ b/t/t5552-upload-pack-ref-in-want.sh
@@ -345,7 +345,7 @@ test_expect_success 'server is initially ahead - no ref in want' '
 	grep "ERR upload-pack: not our ref" err
 '
 
-test_expect_failure 'server is initially ahead - ref in want' '
+test_expect_success 'server is initially ahead - ref in want' '
 	git -C "$REPO" config uploadpack.advertiseRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
@@ -369,7 +369,7 @@ test_expect_success 'server is initially behind - no ref in want' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'server is initially behind - ref in want' '
+test_expect_success 'server is initially behind - ref in want' '
 	git -C "$REPO" config uploadpack.advertiseRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
diff --git a/transport-helper.c b/transport-helper.c
index be0aa6d39..fcd9edcdc 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -28,7 +28,8 @@ struct helper_data {
 		signed_tags : 1,
 		check_connectivity : 1,
 		no_disconnect_req : 1,
-		no_private_update : 1;
+		no_private_update : 1,
+		echo_refs : 1;
 	char *export_marks;
 	char *import_marks;
 	/* These go from remote name (as in "list") to private name */
@@ -195,6 +196,8 @@ static struct child_process *get_helper(struct transport *transport)
 			data->import_marks = xstrdup(arg);
 		} else if (starts_with(capname, "no-private-update")) {
 			data->no_private_update = 1;
+		} else if (!strcmp(capname, "echo-refs")) {
+			data->echo_refs = 1;
 		} else if (mandatory) {
 			die("Unknown mandatory capability %s. This remote "
 			    "helper probably needs newer version of Git.",
@@ -383,27 +386,49 @@ static int release_helper(struct transport *transport)
 	return res;
 }
 
+static struct ref *copy_ref_array(struct ref **array, int nr)
+{
+	struct ref *head = NULL, **tail = &head;
+	int i;
+	for (i = 0; i < nr; i++) {
+		*tail = copy_ref(array[i]);
+		tail = &(*tail)->next;
+	}
+	return head;
+}
+
 static int fetch_with_fetch(struct transport *transport,
-			    int nr_heads, const struct ref **to_fetch)
+			    int nr_refspec, const struct refspec *refspecs,
+			    int nr_heads, const struct ref **to_fetch,
+			    struct ref **fetched_refs)
 {
 	struct helper_data *data = transport->data;
 	int i;
 	struct strbuf buf = STRBUF_INIT;
-
-	for (i = 0; i < nr_heads; i++) {
-		const struct ref *posn = to_fetch[i];
-		if (posn->status & REF_STATUS_UPTODATE)
-			continue;
-
-		strbuf_addf(&buf, "fetch %s %s\n",
-			    oid_to_hex(&posn->old_oid),
-			    posn->symref ? posn->symref : posn->name);
+	int use_echo_refs = data->echo_refs && refspecs;
+	struct ref *fetched = NULL;
+
+	if (use_echo_refs) {
+		set_helper_option(transport, "echo-refs", "true");
+		for (i = 0; i < nr_refspec; i++)
+			strbuf_addf(&buf, "fetch %s\n", refspecs[i].src);
+	} else {
+		for (i = 0; i < nr_heads; i++) {
+			const struct ref *posn = to_fetch[i];
+			if (posn->status & REF_STATUS_UPTODATE)
+				continue;
+
+			strbuf_addf(&buf, "fetch %s %s\n",
+				    oid_to_hex(&posn->old_oid),
+				    posn->symref ? posn->symref : posn->name);
+		}
 	}
 
 	strbuf_addch(&buf, '\n');
 	sendline(data, &buf);
 
 	while (1) {
+		struct object_id oid;
 		if (recvline(data, &buf))
 			exit(128);
 
@@ -418,12 +443,29 @@ static int fetch_with_fetch(struct transport *transport,
 			 data->transport_options.check_self_contained_and_connected &&
 			 !strcmp(buf.buf, "connectivity-ok"))
 			data->transport_options.self_contained_and_connected = 1;
-		else if (!buf.len)
+		else if (use_echo_refs && !get_oid_hex(buf.buf, &oid)
+			 && buf.buf[GIT_SHA1_HEXSZ] == ' ') {
+			struct ref *ref = alloc_ref(buf.buf + GIT_SHA1_HEXSZ + 1);
+			oidcpy(&ref->old_oid, &oid);
+			ref->next = fetched;
+			fetched = ref;
+		} else if (!buf.len)
 			break;
 		else
 			warning("%s unexpectedly said: '%s'", data->name, buf.buf);
 	}
 	strbuf_release(&buf);
+
+	if (use_echo_refs) {
+		if (fetched_refs)
+			*fetched_refs = fetched;
+	} else {
+		assert(fetched == NULL);
+		if (fetched_refs)
+			*fetched_refs = copy_ref_array((struct ref **) to_fetch,
+						       nr_heads);
+	}
+
 	return 0;
 }
 
@@ -657,6 +699,7 @@ static int connect_helper(struct transport *transport, const char *name,
 }
 
 static int fetch(struct transport *transport,
+		 int nr_refspec, const struct refspec *refspecs,
 		 int nr_heads, const struct ref **to_fetch,
 		 struct ref **fetched_refs)
 {
@@ -665,8 +708,8 @@ static int fetch(struct transport *transport,
 
 	if (process_connect(transport, 0)) {
 		do_take_over(transport);
-		return transport->fetch(transport, nr_heads, to_fetch,
-					fetched_refs);
+		return transport->fetch(transport, nr_refspec, refspecs,
+					nr_heads, to_fetch, fetched_refs);
 	}
 
 	count = 0;
@@ -688,7 +731,8 @@ static int fetch(struct transport *transport,
 		set_helper_option(transport, "update-shallow", "true");
 
 	if (data->fetch)
-		return fetch_with_fetch(transport, nr_heads, to_fetch);
+		return fetch_with_fetch(transport, nr_refspec, refspecs,
+					nr_heads, to_fetch, fetched_refs);
 
 	if (data->import)
 		return fetch_with_import(transport, nr_heads, to_fetch, fetched_refs);
diff --git a/transport.c b/transport.c
index 85a4c5369..734c605b1 100644
--- a/transport.c
+++ b/transport.c
@@ -95,6 +95,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport, int for_pus
 }
 
 static int fetch_refs_from_bundle(struct transport *transport,
+			       int nr_refspec, const struct refspec *refspecs,
 			       int nr_heads, const struct ref **to_fetch,
 			       struct ref **fetched_refs)
 {
@@ -203,6 +204,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 }
 
 static int fetch_refs_via_pack(struct transport *transport,
+			       int nr_refspec, const struct refspec *refspecs,
 			       int nr_heads, const struct ref **to_fetch,
 			       struct ref **fetched_refs)
 {
@@ -1096,8 +1098,9 @@ const struct ref *transport_get_remote_refs(struct transport *transport)
 	return transport->remote_refs;
 }
 
-int transport_fetch_refs(struct transport *transport, struct ref *refs,
-			 struct ref **fetched_refs)
+int transport_fetch_refs(struct transport *transport,
+			 const struct refspec *refspecs, int refspec_nr,
+			 struct ref *refs, struct ref **fetched_refs)
 {
 	int rc;
 	int nr_heads = 0, nr_alloc = 0, nr_refs = 0;
@@ -1136,7 +1139,8 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs,
 			heads[nr_heads++] = rm;
 	}
 
-	rc = transport->fetch(transport, nr_heads, heads, fetched_refs);
+	rc = transport->fetch(transport, refspec_nr, refspecs,
+			      nr_heads, heads, fetched_refs);
 	if (nop_head) {
 		*nop_tail = *fetched_refs;
 		*fetched_refs = nop_head;
diff --git a/transport.h b/transport.h
index 326ff9bd6..d7a007d21 100644
--- a/transport.h
+++ b/transport.h
@@ -82,13 +82,20 @@ struct transport {
 	 * Fetch the objects for the given refs. Note that this gets
 	 * an array, and should ignore the list structure.
 	 *
+	 * The user may provide the array of refspecs used to generate the
+	 * given refs. If provided, the transport should prefer the refspecs if
+	 * possible (but may still use the refs for pre-fetch optimizations,
+	 * for example).
+	 *
 	 * The transport *may* provide, in fetched_refs, the list of refs that
-	 * it fetched. If the transport knows anything about the fetched refs
-	 * that the caller does not know (for example, shallow status or ref
-	 * hashes), it should provide that list of refs and include that
-	 * information in the list.
+	 * it fetched, and must do so if it is different from the given refs.
+	 * If the transport knows anything about the fetched refs that the
+	 * caller does not know (for example, shallow status or ref hashes), it
+	 * should provide that list of refs and include that information in the
+	 * list.
 	 **/
 	int (*fetch)(struct transport *transport,
+		     int refspec_nr, const struct refspec *refspecs,
 		     int refs_nr, const struct ref **refs,
 		     struct ref **fetched_refs);
 
@@ -234,8 +241,9 @@ int transport_push(struct transport *connection,
 
 const struct ref *transport_get_remote_refs(struct transport *transport);
 
-int transport_fetch_refs(struct transport *transport, struct ref *refs,
-			 struct ref **fetched_refs);
+int transport_fetch_refs(struct transport *transport,
+			 const struct refspec *refspecs, int refspec_nr,
+			 struct ref *refs, struct ref **fetched_refs);
 void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
-- 
2.11.0.483.g087da7b7c-goog

