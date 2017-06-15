Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D392E20401
	for <e@80x24.org>; Thu, 15 Jun 2017 20:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbdFOUjy (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 16:39:54 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35609 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752573AbdFOUju (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 16:39:50 -0400
Received: by mail-pf0-f171.google.com with SMTP id l89so12480601pfi.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 13:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=B7aIAMFcnqTOuR7LgAMZHUty0BEb7qb0WDQa8Gb31Rg=;
        b=e3bCIflch9o1cSAY2CJ66wL8/MpWfG3sI7yZWRlFLVqHAx5PDmy26cn8xXgPvCbq/E
         7V6h8sos11v2znjotg/KsvtpyEClL54qJfupTO8qITkTiDKhrbBn3UudsZt19wMeqvye
         gWk7e2vwpIzagg1HB7vbFIuzUjFEVLvJLp5gWM0ctIoSFL8I+sy8d/d1l0oh6dKx4ziM
         7dAClJbxxWSSxHjCoOEdYtftBWXB7UXbqeNfzOIWbbgNJnmMod5lp/+o05dASGz891QS
         Yg0HAoDn+8Hk3sHLOq07+oQfmMIDs25EdsDN8+ZvIT2GjjEKyjfcEFl+lb7+aY8pMPpV
         E3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=B7aIAMFcnqTOuR7LgAMZHUty0BEb7qb0WDQa8Gb31Rg=;
        b=tOgR3eK6aFqS7vis6Y8hDIU15266818+lpWEWG9iiBQBbgdtEQELYvAPfab3G/QJK4
         IwWH+K0zmCkklyXPMF0L+dYS2KccY5In/AqG+7rvWVTsX14oS5ZjrM7NJ5hd3L75/3tt
         MZZZKBWpG3RnxLuxJFcft34ExtmMEsj1DEPF+w6fSKpweRuz7tkjhL6qkAgNf73OK+mx
         FdRTF1GY4cmR3cqfjnQSxJYOo6+Crk3+ojCFXtl3wkBq41x+MrYBR1cpjuotw8HiuKDd
         EnryelTOuGSRuFGOXsc5j5ih0CpD6WZdH/bUgDmdkMW/U2yupBZZnZrq6m4XAPgLLvht
         ULVw==
X-Gm-Message-State: AKS2vOzOwqrigSaI6bB158K7vy0nhsGTTDsZBQZdUF+4uh5c01QOBd0E
        b42iW4MU4X3BPagSqeDKLw==
X-Received: by 10.84.131.74 with SMTP id 68mr7048970pld.287.1497559184077;
        Thu, 15 Jun 2017 13:39:44 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id i2sm274226pfe.89.2017.06.15.13.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 13:39:42 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 4/4] sha1_file, fsck: add missing blob support
Date:   Thu, 15 Jun 2017 13:39:31 -0700
Message-Id: <b917a463f0ad4ce0ab115203b3f24894961a2e75.1497558851.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <cover.1497558850.git.jonathantanmy@google.com>
References: <cover.1497558850.git.jonathantanmy@google.com>
In-Reply-To: <cover.1497558850.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1497558850.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, Git does not support repos with very large numbers of blobs
or repos that wish to minimize manipulation of certain blobs (for
example, because they are very large) very well, even if the user
operates mostly on part of the repo, because Git is designed on the
assumption that every blob referenced by a tree object is available
somewhere in the repo storage.

As a first step to reducing this problem, add rudimentary support for
missing blobs by teaching sha1_file to invoke a hook whenever a blob is
requested and unavailable but registered to be missing, and by updating
fsck to tolerate such blobs.  The hook is a shell command that can be
configured through "git config"; this hook takes in a list of hashes and
writes (if successful) the corresponding objects to the repo's local
storage.

This commit does not include support for generating such a repo; neither
has any command (other than fsck) been modified to either tolerate
missing blobs (without invoking the hook) or be more efficient in
invoking the missing blob hook. Only a fallback is provided in the form
of sha1_file invoking the missing blob hook when necessary.

In order to determine the code changes in sha1_file.c necessary, I
investigated the following:
 (1) functions in sha1_file that take in a hash, without the user
     regarding how the object is stored (loose or packed)
 (2) functions in sha1_file that operate on packed objects (because I
     need to check callers that know about the loose/packed distinction
     and operate on both differently, and ensure that they can handle
     the concept of objects that are neither loose nor packed)

(1) is handled by the modification to sha1_object_info_extended() and
has_sha1_file_with_flags().

For (2), I looked through the same functions as in (1) and also
for_each_packed_object. The ones that are relevant are:
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
   - builtin/fsck - fixed in this commit
   - builtin/count-objects - informational purposes only (check if loose
     object is also packed)
   - builtin/prune-packed - check if object to be pruned is packed (if
     not, don't prune it)
   - revision - used to exclude packed objects if requested by user
   - diff - just for optimization
 - for_each_packed_object
   - reachable - only to find recent objects
   - builtin/fsck - fixed in this commit
   - builtin/cat-file - see below

As described in the list above, builtin/fsck has been updated. I have
left builtin/cat-file alone; this means that cat-file
--batch-all-objects will only operate on objects physically in the repo.

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
 Documentation/config.txt |  10 +++
 builtin/fsck.c           |   7 ++
 cache.h                  |   7 ++
 sha1_file.c              | 171 +++++++++++++++++++++++++++++++++++++++++++----
 t/t3907-missing-blob.sh  |  69 +++++++++++++++++++
 5 files changed, 250 insertions(+), 14 deletions(-)
 create mode 100755 t/t3907-missing-blob.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dd4beec39..10da5fde1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -390,6 +390,16 @@ The default is false, except linkgit:git-clone[1] or linkgit:git-init[1]
 will probe and set core.ignoreCase true if appropriate when the repository
 is created.
 
+core.missingBlobCommand::
+	If set, whenever a blob in the local repo is attempted to be
+	read but is missing, invoke this shell command to generate or
+	obtain that blob before reporting an error. This shell command
+	should take one or more hashes, each terminated by a newline, as
+	standard input, and (if successful) should write the
+	corresponding objects to the local repo (packed or loose).
++
+If set, fsck will not treat a missing blob as an error condition.
+
 core.precomposeUnicode::
 	This option is only used by Mac OS implementation of Git.
 	When core.precomposeUnicode=true, Git reverts the unicode decomposition
diff --git a/builtin/fsck.c b/builtin/fsck.c
index cb2ba6cd1..b447bd5f9 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -37,6 +37,7 @@ static int verbose;
 static int show_progress = -1;
 static int show_dangling = 1;
 static int name_objects;
+static int missing_blob_ok;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
@@ -93,6 +94,9 @@ static int fsck_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.missingblobcommand"))
+		missing_blob_ok = 1;
+
 	return git_default_config(var, value, cb);
 }
 
@@ -222,6 +226,9 @@ static void check_reachable_object(struct object *obj)
 	if (!(obj->flags & HAS_OBJ)) {
 		if (has_sha1_pack(obj->oid.hash))
 			return; /* it is in pack - forget about it */
+		if (missing_blob_ok && obj->type == OBJ_BLOB &&
+		    in_missing_blob_manifest(obj->oid.hash, NULL))
+			return;
 		printf("missing %s %s\n", printable_type(obj),
 			describe_object(obj));
 		errors_found |= ERROR_REACHABLE;
diff --git a/cache.h b/cache.h
index 63a73af17..dd69c75f5 100644
--- a/cache.h
+++ b/cache.h
@@ -1870,6 +1870,13 @@ struct object_info {
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
 extern int packed_object_info(struct packed_git *pack, off_t offset, struct object_info *);
 
+/*
+ * Returns 1 if sha1 is the hash of a known missing blob. If size is not NULL,
+ * also returns its size.
+ */
+extern int in_missing_blob_manifest(const unsigned char *sha1,
+				    unsigned long *size);
+
 /* Dumb servers support */
 extern int update_server_info(int);
 
diff --git a/sha1_file.c b/sha1_file.c
index 60b487c70..7ef239907 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -27,6 +27,9 @@
 #include "list.h"
 #include "mergesort.h"
 #include "quote.h"
+#include "iterator.h"
+#include "dir-iterator.h"
+#include "sha1-lookup.h"
 
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
@@ -1624,6 +1627,72 @@ static const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
 	return NULL;
 }
 
+struct missing_blob_manifest {
+	struct missing_blob_manifest *next;
+	const char *data;
+};
+static struct missing_blob_manifest *missing_blobs;
+static int missing_blobs_initialized;
+
+static void prepare_missing_blobs(void)
+{
+	int ok;
+	char *dirname;
+	struct dir_iterator *iter;
+
+	if (missing_blobs_initialized)
+		return;
+
+	missing_blobs_initialized = 1;
+
+	dirname = xstrfmt("%s/missing", get_object_directory());
+	iter = dir_iterator_begin(dirname);
+
+	while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
+		int fd;
+		const char *data;
+		struct missing_blob_manifest *m;
+		if (!S_ISREG(iter->st.st_mode))
+			continue;
+		fd = git_open(iter->path.buf);
+		data = xmmap(NULL, iter->st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+		close(fd);
+
+		m = xmalloc(sizeof(*m));
+		m->next = missing_blobs;
+		m->data = data;
+		missing_blobs = m;
+	}
+
+	if (ok != ITER_DONE) {
+		/* do something */
+	}
+
+	free(dirname);
+}
+
+int in_missing_blob_manifest(const unsigned char *sha1, unsigned long *size)
+{
+	struct missing_blob_manifest *m;
+	prepare_missing_blobs();
+	for (m = missing_blobs; m; m = m->next) {
+		uint64_t nr_nbo, nr;
+		int result;
+		memcpy(&nr_nbo, m->data, sizeof(nr_nbo));
+		nr = htonll(nr_nbo);
+		result = sha1_entry_pos(m->data, GIT_SHA1_RAWSZ + 8, 8, 0, nr, nr, sha1);
+		if (result >= 0) {
+			if (size) {
+				uint64_t size_nbo;
+				memcpy(&size_nbo, m->data + 8 + result * (GIT_SHA1_RAWSZ + 8) + GIT_SHA1_RAWSZ, sizeof(size_nbo));
+				*size = ntohll(size_nbo);
+			}
+			return 1;
+		}
+	}
+	return 0;
+}
+
 /*
  * With an in-core object data in "map", rehash it to make sure the
  * object name actually matches "sha1" to detect object corruption.
@@ -2975,12 +3044,57 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	return (status < 0) ? status : 0;
 }
 
+static char *missing_blob_command;
+static int missing_blob_config(const char *conf_key, const char *value,
+			       void *cb)
+{
+	if (!strcmp(conf_key, "core.missingblobcommand")) {
+		missing_blob_command = xstrdup(value);
+	}
+	return 0;
+}
+
+static void ensure_missing_blob_configured(void)
+{
+	static int configured;
+	if (configured)
+		return;
+
+	git_config(missing_blob_config, NULL);
+	configured = 1;
+}
+
+static void handle_missing_blob(const unsigned char *sha1)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	const char *argv[] = {missing_blob_command, NULL};
+	char input[GIT_MAX_HEXSZ + 1];
+
+	memcpy(input, sha1_to_hex(sha1), 40);
+	input[40] = '\n';
+
+	cp.argv = argv;
+	cp.env = local_repo_env;
+	cp.use_shell = 1;
+
+	if (pipe_command(&cp, input, sizeof(input), NULL, 0, NULL, 0)) {
+		die("failed to load blob %s", sha1_to_hex(sha1));
+	}
+
+	/*
+	 * The command above may have updated packfiles, so update our record
+	 * of them.
+	 */
+	reprepare_packed_git();
+}
+
 int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
 {
 	struct cached_object *co;
 	struct pack_entry e;
 	int rtype;
 	const unsigned char *real = lookup_replace_object_extended(sha1, flags);
+	int already_retried = 0;
 
 	co = find_cached_object(real);
 	if (co) {
@@ -3000,19 +3114,35 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		return 0;
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
-		reprepare_packed_git();
-		if (!find_pack_entry(real, &e))
-			return -1;
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
+	/* Try the missing blobs */
+	if (!already_retried) {
+		ensure_missing_blob_configured();
+		if (missing_blob_command &&
+		    in_missing_blob_manifest(real, NULL)) {
+			already_retried = 1;
+			handle_missing_blob(real);
+			goto retry;
+		}
 	}
 
+	return -1;
+
+found_packed:
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
@@ -3475,17 +3605,30 @@ int has_sha1_pack(const unsigned char *sha1)
 int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
 {
 	struct pack_entry e;
+	int already_retried = 0;
 
 	if (!startup_info->have_repository)
 		return 0;
+retry:
 	if (find_pack_entry(sha1, &e))
 		return 1;
 	if (has_loose_object(sha1))
 		return 1;
-	if (flags & HAS_SHA1_QUICK)
-		return 0;
-	reprepare_packed_git();
-	return find_pack_entry(sha1, &e);
+	if (!(flags & HAS_SHA1_QUICK)) {
+		reprepare_packed_git();
+		if (find_pack_entry(sha1, &e))
+			return 1;
+	}
+	if (!already_retried) {
+		ensure_missing_blob_configured();
+		if (missing_blob_command &&
+		    in_missing_blob_manifest(sha1, NULL)) {
+			already_retried = 1;
+			handle_missing_blob(sha1);
+			goto retry;
+		}
+	}
+	return 0;
 }
 
 int has_object_file(const struct object_id *oid)
diff --git a/t/t3907-missing-blob.sh b/t/t3907-missing-blob.sh
new file mode 100755
index 000000000..7962414cb
--- /dev/null
+++ b/t/t3907-missing-blob.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+test_description='core.missingblobcommand option'
+
+. ./test-lib.sh
+
+pack () {
+	perl -e '$/ = undef; $input = <>; print pack("H*", $input)'
+}
+
+test_expect_success 'sha1_object_info_extended and read_sha1_file (through git cat-file -p)' '
+	rm -rf server client &&
+
+	git init server &&
+	test_commit -C server 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	HASH=$(git hash-object server/1.t) &&
+
+	git init client &&
+	test_config -C client core.missingblobcommand \
+		"git -C \"$(pwd)/server\" pack-objects --stdout | git unpack-objects" &&
+
+	# does not work if missing blob is not registered
+	test_must_fail git -C client cat-file -p "$HASH" &&
+
+	mkdir -p client/.git/objects/missing &&
+	printf "%016x%s%016x" 1 "$HASH" "$(wc -c <server/1.t)" |
+		pack >client/.git/objects/missing/x &&
+
+	# works when missing blob is registered
+	git -C client cat-file -p "$HASH"
+'
+
+test_expect_success 'has_sha1_file (through git cat-file -e)' '
+	rm -rf server client &&
+
+	git init server &&
+	test_commit -C server 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	HASH=$(git hash-object server/1.t) &&
+
+	git init client &&
+	test_config -C client core.missingblobcommand \
+		"git -C \"$(pwd)/server\" pack-objects --stdout | git unpack-objects" &&
+	mkdir -p client/.git/objects/missing &&
+	printf "%016x%s%016x" 1 "$HASH" "$(wc -c <server/1.t)" |
+		pack >client/.git/objects/missing/x &&
+	git -C client cat-file -e "$HASH"
+'
+
+test_expect_success 'fsck' '
+	rm -rf server client &&
+
+	git init server &&
+	test_commit -C server 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	HASH=$(git hash-object server/1.t) &&
+	echo hash is $HASH &&
+
+	cp -r server client &&
+	test_config -C client core.missingblobcommand "this-command-is-not-actually-run" &&
+	mkdir -p client/.git/objects/missing &&
+	printf "%016x%s%016x" 1 "$HASH" "$(wc -c <server/1.t)" |
+		pack >client/.git/objects/missing/x &&
+	rm client/.git/objects/$(echo $HASH | cut -c1-2)/$(echo $HASH | cut -c3-40) &&
+	git -C client fsck
+'
+
+test_done
-- 
2.13.1.518.g3df882009-goog

