Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE1D320281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbdI2UMW (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:12:22 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:48931 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbdI2UMR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:12:17 -0400
Received: by mail-pf0-f172.google.com with SMTP id n24so337012pfk.5
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=chjyOsoeI2ht1W/GU1WRfVmGz2iCixbI4nLmQJsLOWo=;
        b=TUyX+fWngPyfN//6LHoXvlfEiXWXElBg3UXhFb7ooZLb3T0m9ut25SpxIPMYGyax6P
         RIEe9k82PfRs81+uxUCsGXI93VOYb7cHr35OJaEF43Uekfr2ebGdN7Wb6Y0fBTuGVp7L
         ywFnzmeQuRX/cBrEOm49GTB+CNMmTu1GnUEt5t02AZVoAaIta8ICEBuFHVvvfSgmT6wy
         hSThmflEKnAalFh+RzyEo22/tFFqjpZCuUgGtf0OIZJpZxU9nvPIO8gWaCsgc0mWg8RS
         D4Xmo3hdddH9mdsA6vxwQFJbo+xVaoLroChWSGzMnX97G56TcPWkq753CzEEMc8nLq57
         Tt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=chjyOsoeI2ht1W/GU1WRfVmGz2iCixbI4nLmQJsLOWo=;
        b=Nb5P2+bNAsSbtItpo5uw4teOhIkU38pqJzH4NnsCPvaSlLrfj7n5CRNyRbkpF0ZjUM
         xv9s8qF9K/pnKMpbr3W6VQpxwgON7GmKj1I+tijreP2IpFwPWTYYjqh1kM9Eox2phzfY
         9yMAlm/hv8qOAOYWslfAoo3xAxz4oMRQc92l11h4a71Vw0HUXZlmC4nxAq2vHPqc5i/A
         zJdEhhHmk7rPhQpdDj9dDhLXm0PDCPWr33JB9hyHtZOmKinjTcC22ljDzOUFevpzkCCI
         O3EXPgDT940ko0fvrCPKOmq6qNLaEyRmo0OpkbxBFZs1oX+9twjf+AoqIVIS1pYQ3Unu
         hBqA==
X-Gm-Message-State: AHPjjUhVDrNb4KhI1RZBkfywgBn2swJ703GYnxvggwwjDsgZbzR5+B0Q
        NJpiSEuOUDa6RJDFVzDi3b5IrEhXBXc=
X-Google-Smtp-Source: AOwi7QBQmQ2KdnRsXn2PsYK3tqT/jlnUR94Zz38CnWKD4t7OSVmBMlJt1Ocp3B5Txtz0mspxAzQJfw==
X-Received: by 10.98.102.149 with SMTP id s21mr8721135pfj.294.1506715936421;
        Fri, 29 Sep 2017 13:12:16 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id g5sm9280561pgo.66.2017.09.29.13.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 13:12:15 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 07/18] sha1_file: support lazily fetching missing objects
Date:   Fri, 29 Sep 2017 13:11:43 -0700
Message-Id: <5a9242024013345d7a3b0f63580360cdc8cc1c43.1506714999.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.748.g20475d2c7
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach sha1_file to fetch objects from the remote configured in
extensions.partialClone whenever an object is requested but missing.

The fetching of objects can be suppressed through a global variable.
This is used by fsck and index-pack.

However, by default, such fetching is not suppressed. This is meant as a
temporary measure to ensure that all Git commands work in such a
situation. Future patches will update some commands to either tolerate
missing objects (without fetching them) or be more efficient in fetching
them.

In order to determine the code changes in sha1_file.c necessary, I
investigated the following:
 (1) functions in sha1_file.c that take in a hash, without the user
     regarding how the object is stored (loose or packed)
 (2) functions in packfile.c (because I need to check callers that know
     about the loose/packed distinction and operate on both differently,
     and ensure that they can handle the concept of objects that are
     neither loose nor packed)

(1) is handled by the modification to sha1_object_info_extended().

For (2), I looked at for_each_packed_object and others.  For
for_each_packed_object, the callers either already work or are fixed in
this patch:
 - reachable - only to find recent objects
 - builtin/fsck - already knows about missing objects
 - builtin/cat-file - warning message added in this commit

Callers of the other functions do not need to be changed:
 - parse_pack_index
   - http - indirectly from http_get_info_packs
   - find_pack_entry_one
     - this searches a single pack that is provided as an argument; the
       caller already knows (through other means) that the sought object
       is in a specific pack
 - find_sha1_pack
   - fast-import - appears to be an optimization to not store a file if
     it is already in a pack
   - http-walker - to search through a struct alt_base
   - http-push - to search through remote packs
 - has_sha1_pack
   - builtin/fsck - already knows about promisor objects
   - builtin/count-objects - informational purposes only (check if loose
     object is also packed)
   - builtin/prune-packed - check if object to be pruned is packed (if
     not, don't prune it)
   - revision - used to exclude packed objects if requested by user
   - diff - just for optimization

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/cat-file.c       |  2 ++
 builtin/fetch-pack.c     |  2 ++
 builtin/fsck.c           |  3 +++
 builtin/index-pack.c     |  6 ++++++
 cache.h                  |  8 ++++++++
 fetch-object.c           |  3 +++
 sha1_file.c              | 38 ++++++++++++++++++++++++------------
 t/t0410-partial-clone.sh | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 100 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4ccbfaac3..7aa1159ce 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -474,6 +474,8 @@ static int batch_objects(struct batch_options *opt)
 
 		for_each_loose_object(batch_loose_object, &sa, 0);
 		for_each_packed_object(batch_packed_object, &sa, 0);
+		if (repository_format_partial_clone)
+			warning("This repository has extensions.partialClone set. Some objects may not be loaded.");
 
 		cb.opt = opt;
 		cb.expand = &data;
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 9f303cf98..9a7ebf6e9 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -53,6 +53,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	struct oid_array shallow = OID_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 
+	fetch_if_missing = 0;
+
 	packet_trace_identity("fetch-pack");
 
 	memset(&args, 0, sizeof(args));
diff --git a/builtin/fsck.c b/builtin/fsck.c
index f6cb4d755..155ca663b 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -683,6 +683,9 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	int i;
 	struct alternate_object_database *alt;
 
+	/* fsck knows how to handle missing promisor objects */
+	fetch_if_missing = 0;
+
 	errors_found = 0;
 	check_replace_refs = 0;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 14ebb2f17..440558046 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1657,6 +1657,12 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	unsigned foreign_nr = 1;	/* zero is a "good" value, assume bad */
 	int report_end_of_input = 0;
 
+	/*
+	 * index-pack never needs to fetch missing objects, since it only
+	 * accesses the repo to do hash collision checks
+	 */
+	fetch_if_missing = 0;
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
 
diff --git a/cache.h b/cache.h
index 437206d06..58d3f8986 100644
--- a/cache.h
+++ b/cache.h
@@ -1721,6 +1721,14 @@ struct object_info {
 #define OBJECT_INFO_QUICK 8
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
 
+/*
+ * Set this to 0 to prevent sha1_object_info_extended() from fetching missing
+ * blobs. This has a difference only if extensions.partialClone is set.
+ *
+ * Its default value is 1.
+ */
+extern int fetch_if_missing;
+
 /* Dumb servers support */
 extern int update_server_info(int);
 
diff --git a/fetch-object.c b/fetch-object.c
index f89dbba75..369b61c0e 100644
--- a/fetch-object.c
+++ b/fetch-object.c
@@ -9,7 +9,9 @@ void fetch_object(const char *remote_name, const unsigned char *sha1)
 	struct remote *remote;
 	struct transport *transport;
 	struct ref *ref;
+	int original_fetch_if_missing = fetch_if_missing;
 
+	fetch_if_missing = 0;
 	remote = remote_get(remote_name);
 	if (!remote->url[0])
 		die(_("Remote with no URL"));
@@ -20,4 +22,5 @@ void fetch_object(const char *remote_name, const unsigned char *sha1)
 	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
 	transport_set_option(transport, TRANS_OPT_NO_HAVES, "1");
 	transport_fetch_refs(transport, ref);
+	fetch_if_missing = original_fetch_if_missing;
 }
diff --git a/sha1_file.c b/sha1_file.c
index b4a67bb83..77aa0ffdf 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -29,6 +29,7 @@
 #include "mergesort.h"
 #include "quote.h"
 #include "packfile.h"
+#include "fetch-object.h"
 
 const unsigned char null_sha1[GIT_MAX_RAWSZ];
 const struct object_id null_oid;
@@ -1149,6 +1150,8 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	return (status < 0) ? status : 0;
 }
 
+int fetch_if_missing = 1;
+
 int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
 {
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
@@ -1157,6 +1160,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
 				    lookup_replace_object(sha1) :
 				    sha1;
+	int already_retried = 0;
 
 	if (!oi)
 		oi = &blank_oi;
@@ -1181,28 +1185,36 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		}
 	}
 
-	if (!find_pack_entry(real, &e)) {
-		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi, flags))
-			return 0;
+retry:
+	if (find_pack_entry(real, &e))
+		goto found_packed;
 
-		/* Not a loose object; someone else may have just packed it. */
-		if (flags & OBJECT_INFO_QUICK) {
-			return -1;
-		} else {
-			reprepare_packed_git();
-			if (!find_pack_entry(real, &e))
-				return -1;
-		}
+	/* Most likely it's a loose object. */
+	if (!sha1_loose_object_info(real, oi, flags))
+		return 0;
+
+	/* Not a loose object; someone else may have just packed it. */
+	reprepare_packed_git();
+	if (find_pack_entry(real, &e))
+		goto found_packed;
+
+	/* Check if it is a missing object */
+	if (fetch_if_missing && repository_format_partial_clone &&
+	    !already_retried) {
+		fetch_object(repository_format_partial_clone, real);
+		already_retried = 1;
+		goto retry;
 	}
 
+	return -1;
+
+found_packed:
 	if (oi == &blank_oi)
 		/*
 		 * We know that the caller doesn't actually need the
 		 * information below, so return early.
 		 */
 		return 0;
-
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index e96f436b0..8a90f6ab3 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -138,4 +138,55 @@ test_expect_success 'missing CLI object, but promised, passes fsck' '
 	git -C repo fsck "$A"
 '
 
+test_expect_success 'fetching of missing objects' '
+	rm -rf repo &&
+	test_create_repo server &&
+	test_commit -C server foo &&
+	git -C server repack -a -d --write-bitmap-index &&
+
+	git clone "file://$(pwd)/server" repo &&
+	HASH=$(git -C repo rev-parse foo) &&
+	rm -rf repo/.git/objects/* &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "origin" &&
+	git -C repo cat-file -p "$HASH" &&
+
+	# Ensure that the .promisor file is written, and check that its
+	# associated packfile contains the object
+	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
+	test_line_count = 1 promisorlist &&
+	IDX=$(cat promisorlist | sed "s/promisor$/idx/") &&
+	git verify-pack --verbose "$IDX" | grep "$HASH"
+'
+
+LIB_HTTPD_PORT=12345  # default port, 410, cannot be used as non-root
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'fetching of missing objects from an HTTP server' '
+	rm -rf repo &&
+	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	test_create_repo "$SERVER" &&
+	test_commit -C "$SERVER" foo &&
+	git -C "$SERVER" repack -a -d --write-bitmap-index &&
+
+	git clone $HTTPD_URL/smart/server repo &&
+	HASH=$(git -C repo rev-parse foo) &&
+	rm -rf repo/.git/objects/* &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "origin" &&
+	git -C repo cat-file -p "$HASH" &&
+
+	# Ensure that the .promisor file is written, and check that its
+	# associated packfile contains the object
+	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
+	test_line_count = 1 promisorlist &&
+	IDX=$(cat promisorlist | sed "s/promisor$/idx/") &&
+	git verify-pack --verbose "$IDX" | grep "$HASH"
+'
+
+stop_httpd
+
 test_done
-- 
2.14.2.822.g60be5d43e6-goog

