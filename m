Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D42A52035A
	for <e@80x24.org>; Tue, 11 Jul 2017 19:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934182AbdGKTst (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 15:48:49 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35370 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934181AbdGKTsp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 15:48:45 -0400
Received: by mail-pf0-f171.google.com with SMTP id c73so1100388pfk.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 12:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DTvwwbdxtjKg2VlRJMrvRs6hJy2awLzXgcvN7ZC96z0=;
        b=AiF/qUWBTjEB9znNqkC4ianqN/qKxDeT5AAyN9pzMbq+6b0/4l8fVpO3s0YA0MtL5F
         2yKNojL4QOYd2PofonSY/4OLSV8qy8uWTUZ1ZQ1mxj6x4MZ7p6H+s4uuwE2e3ss89Qo1
         QT8lyJF48Mq2tdzctEpi10Qc2Zdu1Vx2ulpwJP2ZcWdNyla3Cy8Lax3tY8UYCT5txYTt
         +4qbenG0cewBeI90K6e2AJWjvlS0HWmS337coqKRLxlomaMlraZ4QiyA9JIRPrmnVPMn
         bo3DxF6v4pPMOtKaTexm5YXKOfJ328Bffu0/0wk1z4qGWBJYUU+yGr/5ArDZPFENMCm0
         KR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=DTvwwbdxtjKg2VlRJMrvRs6hJy2awLzXgcvN7ZC96z0=;
        b=teDAT4PjgIVzDXni8luG0kKkjnAAmOR9JVLdth/qCwoVPHPfzz5ZtRb9x6i7gFywPw
         TSd4nj+6vfupSW/A46GcRRmoBSOQFrWnyr+suXgWxG0XxWWCjqdon4zXvuh61YvrAZE4
         PQhUxYOzbeDMPFntQAYobhD4oM4MgP+cLkneVXFLrjM1gMEh3xP4RJDR9HqkFGx7RT/g
         21FZ0Z5PTIMiqrLbLx+Z+CH3QCbHdANFw0+QX8UYdAzfTJqxCA99T0emAS7JOZ45bXwl
         shNaR7bg8Dd3clooWUaZs+meRN+yB5+ynkKqmOCxVDKEF22p7otft3dc8/7g0nE5Wobc
         /RdQ==
X-Gm-Message-State: AIVw113egopVifVXQyGBYgFt1SBj3BJZF1lyED5r+dzaXbxfrdsnBsED
        kiFM8DiofDavPHZnXGJBRg==
X-Received: by 10.99.47.66 with SMTP id v63mr85368pgv.4.1499802524286;
        Tue, 11 Jul 2017 12:48:44 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id 85sm227557pfr.90.2017.07.11.12.48.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 12:48:43 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 3/3] sha1_file: add promised blob hook support
Date:   Tue, 11 Jul 2017 12:48:32 -0700
Message-Id: <34efd9e9936fdab331655f5a33a098a72dc134f4.1499800530.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
In-Reply-To: <cover.1499800530.git.jonathantanmy@google.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
In-Reply-To: <cover.1499800530.git.jonathantanmy@google.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach sha1_file to invoke a hook whenever a blob is requested and
unavailable but is promised. The hook is a shell command that can be
configured through "git config"; this hook takes in a list of hashes and
writes (if successful) the corresponding objects to the repo's local
storage.

This is meant as a temporary measure to ensure that all Git commands
work in such a situation. Future patches will update some commands to
either tolerate promised blobs (without invoking the hook) or be more
efficient in invoking the promised blob hook.

In order to determine the code changes in sha1_file.c necessary, I
investigated the following:
 (1) functions in sha1_file that take in a hash, without the user
     regarding how the object is stored (loose or packed)
 (2) functions in sha1_file that operate on packed objects (because I
     need to check callers that know about the loose/packed distinction
     and operate on both differently, and ensure that they can handle
     the concept of objects that are neither loose nor packed)

(1) is handled by the modification to sha1_object_info_extended().

For (2), I looked at for_each_packed_object and at the packed-related
functions that take in a hash. For for_each_packed_object, the callers
either already work or are fixed in this patch:
 - reachable - only to find recent objects
 - builtin/fsck - already knows about promised blobs
 - builtin/cat-file - fixed in this commit

Callers of the other functions do not need to be changed:
 - parse_pack_index
   - http - indirectly from http_get_info_packs
 - find_pack_entry_one
   - this searches a single pack that is provided as an argument; the
     caller already knows (through other means) that the sought object
     is in a specific pack
 - find_sha1_pack
   - fast-import - appears to be an optimization to not store a
     file if it is already in a pack
   - http-walker - to search through a struct alt_base
   - http-push - to search through remote packs
 - has_sha1_pack
   - builtin/fsck - already knows about promised blobs
   - builtin/count-objects - informational purposes only (check if loose
     object is also packed)
   - builtin/prune-packed - check if object to be pruned is packed (if
     not, don't prune it)
   - revision - used to exclude packed objects if requested by user
   - diff - just for optimization

An alternative design that I considered but rejected:

 - Adding a hook whenever a packed blob is requested, not on any blob.
   That is, whenever we attempt to search the packfiles for a blob, if
   it is missing (from the packfiles and from the loose object storage),
   to invoke the hook (which must then store it as a packfile), open the
   packfile the hook generated, and report that the blob is found in
   that new packfile. This reduces the amount of analysis needed (in
   that we only need to look at how packed blobs are handled), but
   requires that the hook generate packfiles (or for sha1_file to pack
   whatever loose objects are generated), creating one packfile for each
   missing blob and potentially very many packfiles that must be
   linearly searched. This may be tolerable now for repos that only have
   a few missing blobs (for example, repos that only want to exclude
   large blobs), and might be tolerable in the future if we have
   batching support for the most commonly used commands, but is not
   tolerable now for repos that exclude a large amount of blobs.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/config.txt               |  8 ++++
 Documentation/gitrepository-layout.txt |  8 ++++
 builtin/cat-file.c                     |  9 ++++
 promised-blob.c                        | 75 ++++++++++++++++++++++++++++++++++
 promised-blob.h                        | 13 ++++++
 sha1_file.c                            | 44 +++++++++++++-------
 t/t3907-promised-blob.sh               | 36 ++++++++++++++++
 7 files changed, 179 insertions(+), 14 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d5c9c4cab..c293ac921 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -393,6 +393,14 @@ The default is false, except linkgit:git-clone[1] or linkgit:git-init[1]
 will probe and set core.ignoreCase true if appropriate when the repository
 is created.
 
+core.promisedBlobCommand::
+	If set, whenever a blob in the local repo is attempted to be read, but
+	is both missing and a promised blob, invoke this shell command to
+	generate or obtain that blob before reporting an error. This shell
+	command should take one or more hashes, each terminated by a newline,
+	as standard input, and (if successful) should write the corresponding
+	objects to the local repo (packed or loose).
+
 core.precomposeUnicode::
 	This option is only used by Mac OS implementation of Git.
 	When core.precomposeUnicode=true, Git reverts the unicode decomposition
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index f51ed4e37..0ef9312fa 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -47,6 +47,10 @@ use with dumb transports but otherwise is OK as long as
 `objects/info/alternates` points at the object stores it
 borrows from.
 +
+. You could have blobs that are merely promised by another source. When
+Git requires those blobs, it will invoke the command in the
+`core.promisedBlobCommand` configuration variable.
++
 This directory is ignored if $GIT_COMMON_DIR is set and
 "$GIT_COMMON_DIR/objects" will be used instead.
 
@@ -91,6 +95,10 @@ objects/info/http-alternates::
 	this object store borrows objects from, to be used when
 	the repository is fetched over HTTP.
 
+objects/promisedblob::
+	This file records the sha1 object names and sizes of promised
+	blobs.
+
 refs::
 	References are stored in subdirectories of this
 	directory.  The 'git prune' command knows to preserve
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 96b786e48..3df00bf91 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -12,6 +12,7 @@
 #include "streaming.h"
 #include "tree-walk.h"
 #include "sha1-array.h"
+#include "promised-blob.h"
 
 struct batch_options {
 	int enabled;
@@ -432,6 +433,13 @@ static int batch_packed_object(const struct object_id *oid,
 	return 0;
 }
 
+static int batch_promised_blob(const struct object_id *oid,
+			       void *data)
+{
+	oid_array_append(data, oid);
+	return 0;
+}
+
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -473,6 +481,7 @@ static int batch_objects(struct batch_options *opt)
 
 		for_each_loose_object(batch_loose_object, &sa, 0);
 		for_each_packed_object(batch_packed_object, &sa, 0);
+		for_each_promised_blob(batch_promised_blob, &sa);
 
 		cb.opt = opt;
 		cb.expand = &data;
diff --git a/promised-blob.c b/promised-blob.c
index 493808ed2..0fe04daf2 100644
--- a/promised-blob.c
+++ b/promised-blob.c
@@ -2,6 +2,9 @@
 #include "promised-blob.h"
 #include "sha1-lookup.h"
 #include "strbuf.h"
+#include "run-command.h"
+#include "sha1-array.h"
+#include "config.h"
 
 #define ENTRY_SIZE (GIT_SHA1_RAWSZ + 8)
 /*
@@ -93,3 +96,75 @@ int for_each_promised_blob(each_promised_blob_fn cb, void *data)
 	}
 	return 0;
 }
+
+static char *promised_blob_command;
+
+static int promised_blob_config(const char *conf_key, const char *value,
+				void *cb)
+{
+	if (!strcmp(conf_key, "core.promisedblobcommand")) {
+		promised_blob_command = xstrdup(value);
+	}
+	return 0;
+}
+
+static void ensure_promised_blob_configured(void)
+{
+	static int configured;
+	if (configured)
+		return;
+	git_config(promised_blob_config, NULL);
+	configured = 1;
+}
+
+int request_promised_blobs(const struct oid_array *blobs)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	const char *argv[] = {NULL, NULL};
+	const char *env[] = {"GIT_IGNORE_PROMISED_BLOBS=1", NULL};
+	int blobs_requested = 0;
+	int i;
+
+	for (i = 0; i < blobs->nr; i++) {
+		if (is_promised_blob(&blobs->oid[i], NULL))
+			break;
+	}
+
+	if (i == blobs->nr)
+		/* Nothing to fetch */
+		return 0;
+
+	ensure_promised_blob_configured();
+	if (!promised_blob_command)
+		die("some promised blobs need to be fetched, but\n"
+		    "no core.promisedblobcommand configured");
+
+	argv[0] = promised_blob_command;
+	cp.argv = argv;
+	cp.env = env;
+	cp.use_shell = 1;
+	cp.in = -1;
+
+	if (start_command(&cp))
+		die("failed to start <%s>", promised_blob_command);
+
+	for (; i < blobs->nr; i++) {
+		if (is_promised_blob(&blobs->oid[i], NULL)) {
+			write_in_full(cp.in, oid_to_hex(&blobs->oid[i]),
+				      GIT_SHA1_HEXSZ);
+			write_in_full(cp.in, "\n", 1);
+			blobs_requested++;
+		}
+	}
+	close(cp.in);
+
+	if (finish_command(&cp))
+		die("failed to finish <%s>", promised_blob_command);
+
+	/*
+	 * The command above may have updated packfiles, so update our record
+	 * of them.
+	 */
+	reprepare_packed_git();
+	return blobs_requested;
+}
diff --git a/promised-blob.h b/promised-blob.h
index a303ea1ff..34b1d3f9e 100644
--- a/promised-blob.h
+++ b/promised-blob.h
@@ -1,6 +1,8 @@
 #ifndef PROMISED_BLOB_H
 #define PROMISED_BLOB_H
 
+#include "sha1-array.h"
+
 /*
  * Returns 1 if oid is the name of a promised blob. If size is not NULL, also
  * returns its size.
@@ -11,4 +13,15 @@ extern int is_promised_blob(const struct object_id *oid,
 typedef int each_promised_blob_fn(const struct object_id *oid, void *data);
 int for_each_promised_blob(each_promised_blob_fn, void *);
 
+/*
+ * If any of the given blobs are promised blobs, invokes
+ * core.promisedblobcommand with those blobs and returns the number of blobs
+ * requested. No check is made as to whether the invocation actually populated
+ * the repository with the promised blobs.
+ *
+ * If none of the given blobs are promised blobs, this function does not invoke
+ * anything and returns 0.
+ */
+int request_promised_blobs(const struct oid_array *blobs);
+
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 5862386cd..5778a6dbd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -28,6 +28,11 @@
 #include "list.h"
 #include "mergesort.h"
 #include "quote.h"
+#include "iterator.h"
+#include "dir-iterator.h"
+#include "sha1-lookup.h"
+#include "promised-blob.h"
+#include "sha1-array.h"
 
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
@@ -2983,6 +2988,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
 				    lookup_replace_object(sha1) :
 				    sha1;
+	int already_retried = 0;
 
 	if (!oi)
 		oi = &blank_oi;
@@ -3007,30 +3013,40 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		}
 	}
 
-	if (!find_pack_entry(real, &e)) {
-		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi, flags)) {
-			oi->whence = OI_LOOSE;
-			return 0;
-		}
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
+	/* Most likely it's a loose object. */
+	if (!sha1_loose_object_info(real, oi, flags)) {
+		oi->whence = OI_LOOSE;
+		return 0;
+	}
+
+	/* Not a loose object; someone else may have just packed it. */
+	reprepare_packed_git();
+	if (find_pack_entry(real, &e))
+		goto found_packed;
+
+	/* Check if it is a promised blob */
+	if (!already_retried) {
+		struct oid_array promised = OID_ARRAY_INIT;
+		oid_array_append_sha1(&promised, real);
+		if (request_promised_blobs(&promised)) {
+			already_retried = 1;
+			goto retry;
 		}
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
diff --git a/t/t3907-promised-blob.sh b/t/t3907-promised-blob.sh
index 827072004..778afd1f6 100755
--- a/t/t3907-promised-blob.sh
+++ b/t/t3907-promised-blob.sh
@@ -26,4 +26,40 @@ test_expect_success '...but fails again with GIT_IGNORE_PROMISED_BLOBS' '
 	unset GIT_IGNORE_PROMISED_BLOBS
 '
 
+test_expect_success 'sha1_object_info_extended (through git cat-file)' '
+	rm -rf server client &&
+
+	git init server &&
+	test_commit -C server 1 1.t abcdefgh &&
+	HASH=$(git hash-object server/1.t) &&
+
+	git init client &&
+	git -C client config core.promisedblobcommand \
+		"git -C \"$(pwd)/server\" pack-objects --stdout |
+		 git unpack-objects" &&
+	
+	test_must_fail git -C client cat-file -p "$HASH"
+'
+
+test_expect_success '...succeeds if it is a promised blob' '
+	printf "%s%016x" "$HASH" "$(wc -c <server/1.t)" |
+		hex_pack >client/.git/objects/promisedblob &&
+	git -C client cat-file -p "$HASH"
+'
+
+test_expect_success 'cat-file --batch-all-objects with promised blobs' '
+	rm -rf client &&
+
+	git init client &&
+	git -C client config core.promisedblobcommand \
+		"git -C \"$(pwd)/server\" pack-objects --stdout |
+		 git unpack-objects" &&
+	printf "%s%016x" "$HASH" "$(wc -c <server/1.t)" |
+		hex_pack >client/.git/objects/promisedblob &&
+
+	# Verify that the promised blob is printed
+	git -C client cat-file --batch --batch-all-objects | tee out |
+		grep abcdefgh
+'
+
 test_done
-- 
2.13.2.932.g7449e964c-goog

