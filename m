Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A4241F516
	for <e@80x24.org>; Mon,  2 Jul 2018 22:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753555AbeGBWIw (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 18:08:52 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:53754 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbeGBWIs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 18:08:48 -0400
Received: by mail-vk0-f74.google.com with SMTP id x138-v6so7252977vkd.20
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 15:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=tzrZiAAdz5s+5jAoORhr491O4FBAoJEtG44J7L8nvag=;
        b=RI4qj0j5T5dHHkEMk9OzEPCy3/ee6Yns2y7q3oqNJAC0OiooGJ1nvdpGqRMEXgG/gU
         +2zlRpYgWolnZD9M2W+lDgl4YE5QXH7Ev0iM9nWLSC6FqPtIHPWT6srX3XZG8IO6OgW1
         C5XytqrSyTdD8NIUKu/+ZEQGnEoHKFRxoDOkMt6qchoDWyCyjR5CGZdqaCEzhqFWBvS0
         N4IPwnSGSY+BXDnQTiJprZud9jtYJOABdPk/EAr1C+7HnhyPAxOWmgqL7n2ayGWucq+Q
         9ZXQvPdg3GsFa4r2m3dzSRm8t7F1skE8Vw/rA/Fewj6AM5dTrhtXTUoti/aF8BqqmVZc
         Ic/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=tzrZiAAdz5s+5jAoORhr491O4FBAoJEtG44J7L8nvag=;
        b=rTH35C7sYftBPYub7vyEQaSPINqPchp2ZF2CflTFyaAt/wt5JcBLbrGnNNhCroqsAt
         xL1nr1BQQM/iEDPJ6GaLVlBNSUBpLdyQ7CI80qsR2JwrmDorpRRVPZ11R/CBBLFvoseT
         oo/ja3DkU2A9ySfNaSZjj1DMZ2JhtVX+AUsX/JM84s/AGC1h3Z7wwp5FylYG8nd4MS0a
         mNYyYiEe4cJ79YM7gqP6o9lKXqBFpKWpBQJ8GGxs3Ai9WaC4l8/GTVYdn4RE+qU8SH2D
         v+oSj3w4Ur+ssf0I3zIl0dT1a4xHkszbLGS6H31u17Q4wbJCu9o7msmJYfqEu9fR/JXv
         +05A==
X-Gm-Message-State: APt69E1iLVzTVW7OD8tZ6wxDSTU2KbD6QjIrBXSNbRLulZmBBZu+6Pdm
        t8QaDFCpVvL5pqGRW/7rMZwR28xmbE6liE5nqJa+sowaDTqLyjatQ11srg8YrEABje7fIE/U98A
        M3ytbopTzK1CUGocN+Ot2gmBzjATBgGy26hQkc2l+VDuDYQ+HSMeq2IcfVt8vJTFmegdTiF/SAG
        DY
X-Google-Smtp-Source: AAOMgpf08BU0XyAGOn8B9Z1Gp/q7Z9NKF0SNNozYWL0aRY18GQWVlJilWnrUa1hAx/NUyqOP0DwQAjyaTvfQQYV8Iq52
MIME-Version: 1.0
X-Received: by 2002:a1f:81c6:: with SMTP id c189-v6mr11791852vkd.98.1530569327654;
 Mon, 02 Jul 2018 15:08:47 -0700 (PDT)
Date:   Mon,  2 Jul 2018 15:08:43 -0700
Message-Id: <20180702220843.260595-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH] fetch-pack: write shallow, then check connectivity
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fetching, connectivity is checked after the shallow file is
updated. There are 2 issues with this: (1) the connectivity check is
only performed up to ancestors of existing refs (which is not thorough
enough if we were deepening an existing ref in the first place), and (2)
there is no rollback of the shallow file if the connectivity check
fails.

To solve (1), update the connectivity check to check the ancestry chain
completely in the case of a deepening fetch by refraining from passing
"--not --all" when invoking rev-list in connected.c.

To solve (2), have fetch_pack() perform its own connectivity check
before updating the shallow file. To support existing use cases in which
"git fetch-pack" is used to download objects without much regard as to
the connectivity of the resulting objects with respect to the existing
repository, the connectivity check is only done if necessary (that is,
the fetch is not a clone, and the fetch involves shallow/deepen
functionality). "git fetch" still performs its own connectivity check,
preserving correctness but sometimes performing redundant work. This
redundancy is mitigated by the fact that fetch_pack() reports if it has
performed a connectivity check itself, and if the transport supports
connect or stateless-connect, it will bubble up that report so that "git
fetch" knows not to perform the connectivity check in such a case.

This was noticed when a user tried to deepen an existing repository by
fetching with --no-shallow from a server that did not send all necessary
objects - the connectivity check as run by "git fetch" succeeded, but a
subsequent "git fsck" failed.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is on bw/ref-in-want because I wanted to use its one-time-sed
functionality.

This supersedes the version in [1], which handled issue (1) but not
issue (2).

[1] https://public-inbox.org/git/20180627173237.25620-1-jonathantanmy@google.com/
---
 builtin/fetch.c          | 15 +++++++++-----
 connected.c              |  6 ++++--
 connected.h              |  7 +++++++
 fetch-pack.c             | 31 +++++++++++++++++++++++++++++
 fetch-pack.h             | 15 ++++++++++++++
 t/t5537-fetch-shallow.sh | 43 ++++++++++++++++++++++++++++++++++++++++
 transport.c              |  1 +
 transport.h              | 11 ++++++++++
 8 files changed, 122 insertions(+), 7 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8362a97a2e..f8c68d7844 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -769,7 +769,7 @@ static int iterate_ref_map(void *cb_data, struct object_id *oid)
 }
 
 static int store_updated_refs(const char *raw_url, const char *remote_name,
-		struct ref *ref_map)
+			      int connectivity_checked, struct ref *ref_map)
 {
 	FILE *fp;
 	struct commit *commit;
@@ -791,10 +791,12 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	else
 		url = xstrdup("foreign");
 
-	rm = ref_map;
-	if (check_connected(iterate_ref_map, &rm, NULL)) {
-		rc = error(_("%s did not send all necessary objects\n"), url);
-		goto abort;
+	if (!connectivity_checked) {
+		rm = ref_map;
+		if (check_connected(iterate_ref_map, &rm, NULL)) {
+			rc = error(_("%s did not send all necessary objects\n"), url);
+			goto abort;
+		}
 	}
 
 	prepare_format_display(ref_map);
@@ -960,8 +962,11 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map,
 
 static int consume_refs(struct transport *transport, struct ref *ref_map)
 {
+	int connectivity_checked = transport->smart_options
+		? transport->smart_options->connectivity_checked : 0;
 	int ret = store_updated_refs(transport->url,
 				     transport->remote->name,
+				     connectivity_checked,
 				     ref_map);
 	transport_unlock_pack(transport);
 	return ret;
diff --git a/connected.c b/connected.c
index 91feb78815..1bba888eff 100644
--- a/connected.c
+++ b/connected.c
@@ -58,8 +58,10 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	argv_array_push(&rev_list.args, "--stdin");
 	if (repository_format_partial_clone)
 		argv_array_push(&rev_list.args, "--exclude-promisor-objects");
-	argv_array_push(&rev_list.args, "--not");
-	argv_array_push(&rev_list.args, "--all");
+	if (!opt->is_deepening_fetch) {
+		argv_array_push(&rev_list.args, "--not");
+		argv_array_push(&rev_list.args, "--all");
+	}
 	argv_array_push(&rev_list.args, "--quiet");
 	if (opt->progress)
 		argv_array_pushf(&rev_list.args, "--progress=%s",
diff --git a/connected.h b/connected.h
index a53f03a61a..322dc76372 100644
--- a/connected.h
+++ b/connected.h
@@ -38,6 +38,13 @@ struct check_connected_options {
 	 * Insert these variables into the environment of the child process.
 	 */
 	const char **env;
+
+	/*
+	 * If non-zero, check the ancestry chain completely, not stopping at
+	 * any existing ref. This is necessary when deepening existing refs
+	 * during a fetch.
+	 */
+	unsigned is_deepening_fetch : 1;
 };
 
 #define CHECK_CONNECTED_INIT { 0 }
diff --git a/fetch-pack.c b/fetch-pack.c
index 681b440615..fb8d27f614 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -19,6 +19,7 @@
 #include "sha1-array.h"
 #include "oidset.h"
 #include "packfile.h"
+#include "connected.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -1593,6 +1594,18 @@ static void update_shallow(struct fetch_pack_args *args,
 	oid_array_clear(&ref);
 }
 
+static int iterate_ref_map(void *cb_data, struct object_id *oid)
+{
+	struct ref **rm = cb_data;
+	struct ref *ref = *rm;
+
+	if (!ref)
+		return -1; /* end of the list */
+	*rm = ref->next;
+	oidcpy(oid, &ref->old_oid);
+	return 0;
+}
+
 struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
@@ -1621,7 +1634,25 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
 					&si, pack_lockfile);
 	reprepare_packed_git(the_repository);
+
+	if (!args->cloning && args->deepen) {
+		struct check_connected_options opt = CHECK_CONNECTED_INIT;
+		struct ref *iterator = ref_cpy;
+		opt.shallow_file = alternate_shallow_file;
+		if (args->deepen)
+			opt.is_deepening_fetch = 1;
+		if (check_connected(iterate_ref_map, &iterator, &opt)) {
+			error(_("remote did not send all necessary objects"));
+			free_refs(ref_cpy);
+			ref_cpy = NULL;
+			rollback_lock_file(&shallow_lock);
+			goto cleanup;
+		}
+		args->connectivity_checked = 1;
+	}
+
 	update_shallow(args, ref_cpy, &si);
+cleanup:
 	clear_shallow_info(&si);
 	return ref_cpy;
 }
diff --git a/fetch-pack.h b/fetch-pack.h
index bb45a366a8..2160be9164 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -41,6 +41,21 @@ struct fetch_pack_args {
 	 * regardless of which object flags it uses (if any).
 	 */
 	unsigned no_dependents:1;
+
+	/*
+	 * Because fetch_pack() overwrites the shallow file upon a
+	 * successful deepening non-clone fetch, if this struct
+	 * specifies such a fetch, fetch_pack() needs to perform a
+	 * connectivity check before deciding if a fetch is successful
+	 * (and overwriting the shallow file). fetch_pack() sets this
+	 * field to 1 if such a connectivity check was performed.
+	 *
+	 * This is different from check_self_contained_and_connected
+	 * in that the former allows existing objects in the
+	 * repository to satisfy connectivity needs, whereas the
+	 * latter doesn't.
+	 */
+	unsigned connectivity_checked:1;
 };
 
 /*
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index df8d2f095a..a7afb66049 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -186,4 +186,47 @@ EOF
 	test_cmp expect actual
 '
 
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+REPO="$HTTPD_DOCUMENT_ROOT_PATH/repo"
+
+test_expect_success 'shallow fetches check connectivity before writing shallow file' '
+	rm -rf "$REPO" client &&
+
+	git init "$REPO" &&
+	test_commit -C "$REPO" one &&
+	test_commit -C "$REPO" two &&
+	test_commit -C "$REPO" three &&
+
+	git init client &&
+
+	# Use protocol v2 to ensure that shallow information is sent exactly
+	# once by the server, since we are planning to manipulate it.
+	git -C "$REPO" config protocol.version 2 &&
+	git -C client config protocol.version 2 &&
+
+	git -C client fetch --depth=2 "$HTTPD_URL/one_time_sed/repo" master:a_branch &&
+
+	# Craft a situation in which the server sends back an unshallow request
+	# with an empty packfile. This is done by refetching with a shorter
+	# depth (to ensure that the packfile is empty), and overwriting the
+	# shallow line in the response with the unshallow line we want.
+	printf "s/0034shallow %s/0036unshallow %s/" \
+	       "$(git -C "$REPO" rev-parse HEAD)" \
+	       "$(git -C "$REPO" rev-parse HEAD^)" \
+	       >"$HTTPD_ROOT_PATH/one-time-sed" &&
+	test_must_fail git -C client fetch --depth=1 "$HTTPD_URL/one_time_sed/repo" \
+		master:a_branch &&
+
+	# Ensure that the one-time-sed script was used.
+	! test -e "$HTTPD_ROOT_PATH/one-time-sed" &&
+
+	# Ensure that the resulting repo is consistent, despite our failure to
+	# fetch.
+	git -C client fsck
+'
+
+stop_httpd
+
 test_done
diff --git a/transport.c b/transport.c
index 39d8c2fa55..fdd813f684 100644
--- a/transport.c
+++ b/transport.c
@@ -350,6 +350,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	data->got_remote_heads = 0;
 	data->options.self_contained_and_connected =
 		args.self_contained_and_connected;
+	data->options.connectivity_checked = args.connectivity_checked;
 
 	if (refs == NULL)
 		ret = -1;
diff --git a/transport.h b/transport.h
index 3dff767a87..7a9a7fcaf3 100644
--- a/transport.h
+++ b/transport.h
@@ -18,6 +18,17 @@ struct git_transport_options {
 	unsigned deepen_relative : 1;
 	unsigned from_promisor : 1;
 	unsigned no_dependents : 1;
+
+	/*
+	 * If this transport supports connect or stateless-connect,
+	 * the corresponding field in struct fetch_pack_args is copied
+	 * here after fetching.
+	 *
+	 * See the definition of connectivity_checked in struct
+	 * fetch_pack_args for more information.
+	 */
+	unsigned connectivity_checked:1;
+
 	int depth;
 	const char *deepen_since;
 	const struct string_list *deepen_not;
-- 
2.18.0.399.gad0ab374a1-goog

