Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C119F1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbeBUByv (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:54:51 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46247 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeBUByo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:54:44 -0500
Received: by mail-pf0-f194.google.com with SMTP id z24so50245pfh.13
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FwenyvBBIK5eJVb76CIrdaxnrYYxeyGZ0ni/ua78Ol0=;
        b=rQHa66rIwnJafTKWr1tpG0HT87M2IOcPqwFmhjg2UfqVxXqNcxf2idtg0Z7KVMvwP2
         YDvl1oD0K98o9wgLTXJiJzWGIaodM6ZSbHhTxA6KjWNRb0igKFVlcd7VMpxnTqXppvCT
         r9gSnA/BgQvl4gN8Hp7WLggeJ+hlOWPhiUoZqYXOnfUTbqONS/SBM8qnPQS3PMqwfjTE
         eai1MYHpZlsdhdDqSFoh5+IgMRK/pPsqvc5qrlK3g58uIWRxONmNRflaCcvxBknLBgwT
         e4n9lwsD4jYsVLU6WH/rYgG3GEz0wFRZVS9GJF8kk2dNNqTksTyT7En5/ll4bak1dLuH
         Fx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FwenyvBBIK5eJVb76CIrdaxnrYYxeyGZ0ni/ua78Ol0=;
        b=bZw/OGMPk8JLMx0egsEGGZb850CrGfuPB0K8TW0jIdnmvkDCn8iTM9nl0u3E1mr0+/
         e4JS66rlQwLnlnkC4tqYijPnLFoj2oxKJL3SMJBiuBll7zU2up95vznRkBkYX9Cv8ufi
         pHNBW33mwnx1ieBcutZO3N1GEA1Bs2zeMbjZFls9asaokISOsJMp4imxXVMC2lqaPCop
         W4LXG9GEmcH3WFrhaZfuR6AnEhsQxZZ0EmR6NihsxevtKRFVjEPlEq9Icm7ChpAWcnhR
         JcEfVTkT4UO5pNVmHWICY0ESpcmr4iZ/Qqhp0EdhxRK1vGQ8qiBxj5zMy6zNxB4NrN7G
         EjAg==
X-Gm-Message-State: APf1xPBh0dVyO6clqsnaYnsh2+1+ZGx4Q48t59CinXu+311hMHIsF3xd
        4JjbrVZ3zRIbMFJW9bPAW/7JGPvfZxs=
X-Google-Smtp-Source: AH8x226qtz/d52CPy9iTY4RF4DY36zHKVN/LUwYXbasmUclo9s2UV3u5SsGtIprVQ/e1iVVhZOY3Fw==
X-Received: by 10.101.91.3 with SMTP id y3mr1325891pgq.149.1519178083830;
        Tue, 20 Feb 2018 17:54:43 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id z7sm7808700pgp.55.2018.02.20.17.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:54:43 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/27] object-store: move alt_odb_list and alt_odb_tail to object store
Date:   Tue, 20 Feb 2018 17:54:06 -0800
Message-Id: <20180221015430.96054-4-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a process with multiple repositories open, alternates should be
associated to a single repository and not shared globally. Move
alt_odb_list and alt_odb_tail into the_repository and adjust callers
to reflect this.

Now that the alternative object data base is per repository, we're
leaking its memory upon freeing a repository. The next patch plugs
this hole.

No functional change intended.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/fsck.c |  4 +++-
 object-store.h |  9 ++++++---
 packfile.c     |  3 ++-
 sha1_file.c    | 25 ++++++++++++-------------
 sha1_name.c    |  3 ++-
 5 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 7a8a679d4f..908e4f092a 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "commit.h"
 #include "tree.h"
@@ -716,7 +717,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		fsck_object_dir(get_object_directory());
 
 		prepare_alt_odb();
-		for (alt = alt_odb_list; alt; alt = alt->next)
+		for (alt = the_repository->objects.alt_odb_list;
+				alt; alt = alt->next)
 			fsck_object_dir(alt->path);
 
 		if (check_full) {
diff --git a/object-store.h b/object-store.h
index 5678aa1136..e78eea1dde 100644
--- a/object-store.h
+++ b/object-store.h
@@ -1,7 +1,7 @@
 #ifndef OBJECT_STORE_H
 #define OBJECT_STORE_H
 
-extern struct alternate_object_database {
+struct alternate_object_database {
 	struct alternate_object_database *next;
 
 	/* see alt_scratch_buf() */
@@ -19,7 +19,7 @@ extern struct alternate_object_database {
 	struct oid_array loose_objects_cache;
 
 	char path[FLEX_ARRAY];
-} *alt_odb_list;
+};
 void prepare_alt_odb(void);
 char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
@@ -58,8 +58,11 @@ struct raw_object_store {
 	 * Cannot be NULL after initialization.
 	 */
 	char *objectdir;
+
+	struct alternate_object_database *alt_odb_list;
+	struct alternate_object_database **alt_odb_tail;
 };
-#define RAW_OBJECT_STORE_INIT { NULL }
+#define RAW_OBJECT_STORE_INIT { NULL, NULL, NULL }
 
 void raw_object_store_clear(struct raw_object_store *o);
 
diff --git a/packfile.c b/packfile.c
index 7dbe8739d1..216ea836ee 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "list.h"
 #include "pack.h"
+#include "repository.h"
 #include "dir.h"
 #include "mergesort.h"
 #include "packfile.h"
@@ -891,7 +892,7 @@ void prepare_packed_git(void)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
 	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next)
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
 	prepare_packed_git_mru();
diff --git a/sha1_file.c b/sha1_file.c
index 831d9e7343..1348dce68f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -22,6 +22,7 @@
 #include "pack-revindex.h"
 #include "sha1-lookup.h"
 #include "bulk-checkin.h"
+#include "repository.h"
 #include "streaming.h"
 #include "dir.h"
 #include "list.h"
@@ -342,9 +343,6 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 	return buf->buf;
 }
 
-struct alternate_object_database *alt_odb_list;
-static struct alternate_object_database **alt_odb_tail;
-
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
@@ -364,7 +362,7 @@ static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		if (!fspathcmp(path->buf, alt->path))
 			return 0;
 	}
@@ -424,8 +422,8 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	ent = alloc_alt_odb(pathbuf.buf);
 
 	/* add the alternate entry */
-	*alt_odb_tail = ent;
-	alt_odb_tail = &(ent->next);
+	*the_repository->objects.alt_odb_tail = ent;
+	the_repository->objects.alt_odb_tail = &(ent->next);
 	ent->next = NULL;
 
 	/* recursively add alternates */
@@ -559,7 +557,7 @@ void add_to_alternates_file(const char *reference)
 		fprintf_or_die(out, "%s\n", reference);
 		if (commit_lock_file(&lock))
 			die_errno("unable to move new alternates file into place");
-		if (alt_odb_tail)
+		if (the_repository->objects.alt_odb_tail)
 			link_alt_odb_entries(reference, '\n', NULL, 0);
 	}
 	free(alts);
@@ -657,7 +655,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	int r = 0;
 
 	prepare_alt_odb();
-	for (ent = alt_odb_list; ent; ent = ent->next) {
+	for (ent = the_repository->objects.alt_odb_list; ent; ent = ent->next) {
 		r = fn(ent, cb);
 		if (r)
 			break;
@@ -669,12 +667,13 @@ void prepare_alt_odb(void)
 {
 	const char *alt;
 
-	if (alt_odb_tail)
+	if (the_repository->objects.alt_odb_tail)
 		return;
 
 	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
 
-	alt_odb_tail = &alt_odb_list;
+	the_repository->objects.alt_odb_tail =
+			&the_repository->objects.alt_odb_list;
 	link_alt_odb_entries(alt, PATH_SEP, NULL, 0);
 
 	read_info_alternates(get_object_directory(), 0);
@@ -718,7 +717,7 @@ static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 {
 	struct alternate_object_database *alt;
 	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		const char *path = alt_sha1_path(alt, sha1);
 		if (check_and_freshen_file(path, freshen))
 			return 1;
@@ -878,7 +877,7 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 
 	prepare_alt_odb();
 	errno = ENOENT;
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		if (!lstat(*path, st))
 			return 0;
@@ -908,7 +907,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 	most_interesting_errno = errno;
 
 	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
 		if (fd >= 0)
diff --git a/sha1_name.c b/sha1_name.c
index 611c7d24dd..957ce25680 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -10,6 +10,7 @@
 #include "dir.h"
 #include "sha1-array.h"
 #include "packfile.h"
+#include "repository.h"
 
 static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
 
@@ -104,7 +105,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 		 */
 		fakeent = alloc_alt_odb(get_object_directory());
 	}
-	fakeent->next = alt_odb_list;
+	fakeent->next = the_repository->objects.alt_odb_list;
 
 	for (alt = fakeent; alt && !ds->ambiguous; alt = alt->next) {
 		int pos;
-- 
2.16.1.291.g4437f3f132-goog

