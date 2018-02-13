Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C24B1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933124AbeBMBWx (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:22:53 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35462 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933027AbeBMBWt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:22:49 -0500
Received: by mail-pg0-f65.google.com with SMTP id l131so3220924pga.2
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vLBYpW6fzwZmC4RrOhHMZv4+Mxhgi/kOwtmid21vkMA=;
        b=ucIAjeMF+Aa1E7V29l2Q5eDV88nLev6NwpJVoXncjYjh2WDnUTeDyOH/SWtCYGKkSQ
         RtwXjeAWalkFkgsUr6obKqOVhZaN5jmZKJ2yMOT3wneskNFZajs0iSDtoC8bDV7u9Pkk
         bcYQAtKAPOcS/DwjfvSflbkdjSyAl5+JQL8r4QOG3l2tG3CeOW4Yvno5Zin2fLR6LPua
         uFSvPV5unf9BAe/khYxF1oNNPPIkLUvXsUWv+32hllfXUou9+zUPWUZuRGJqTSxF0aQB
         6nwtVhaZUdDNZNXjCbw7n8I4shcui87jDF36A5mZGmO17uWyaP3vfY8fS7XPQhjCNZnZ
         KCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vLBYpW6fzwZmC4RrOhHMZv4+Mxhgi/kOwtmid21vkMA=;
        b=r+ilwS6Rw7/Dw9I5yU7cnLys7CH1Sg//Uy3YcuH0LsPL3HCV0x+K1C+8eD9XgCYgqi
         G6ZbwKwC4nhpfmv16V8CKWUPL0TR8Z6YBLUIIObVyw3T9HOjwIfyWML9qW+2eaiBufBf
         kppH78rDRx7jRyhuxI5ZeehY+JO2HoZDH0epcOjSSP0t1cxkrndtW0wbsiw4EFdUZe4D
         AaA5TYaPfPJi1ajwjgE5SmShS7CNFPUdNSj4tgd6qDMhTOM+SF+iPrSD3nIS6293yuLe
         vRjYUmbiomOnRyjR3sqmjRiFj1bmlGzEG9baWJgaujf1B0PthDmn2elyFYOG3ZoGMeTo
         VXtA==
X-Gm-Message-State: APf1xPB92b64yjN1C0OPOaIgtmf0rRUDuOOQf+SWhXn8I/sQ+yrgA27l
        mHXQhGb5o52/FKdmpNiRDmz+9w==
X-Google-Smtp-Source: AH8x22428il/TWI2aKPWuzhYInDPKD0Sg6d/hKTc6qyL66nfBQyexq7SA6krC/dmaZrLw8sctOuJDQ==
X-Received: by 10.101.78.143 with SMTP id b15mr3580039pgs.229.1518484968509;
        Mon, 12 Feb 2018 17:22:48 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id e82sm64091pfk.114.2018.02.12.17.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:22:47 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/26] object-store: move alt_odb_list and alt_odb_tail to object store
Date:   Mon, 12 Feb 2018 17:22:17 -0800
Message-Id: <20180213012241.187007-3-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
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
 cache.h        |  4 ++--
 object-store.h |  7 ++++++-
 packfile.c     |  3 ++-
 sha1_file.c    | 25 ++++++++++++-------------
 sha1_name.c    |  3 ++-
 6 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 04846d46f9..1048255da1 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "commit.h"
 #include "tree.h"
@@ -694,7 +695,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		fsck_object_dir(get_object_directory());
 
 		prepare_alt_odb();
-		for (alt = alt_odb_list; alt; alt = alt->next)
+		for (alt = the_repository->objects.alt_odb_list;
+				alt; alt = alt->next)
 			fsck_object_dir(alt->path);
 
 		if (check_full) {
diff --git a/cache.h b/cache.h
index d8b975a571..918c2f15b4 100644
--- a/cache.h
+++ b/cache.h
@@ -1573,7 +1573,7 @@ extern int has_dirs_only_path(const char *name, int len, int prefix_len);
 extern void schedule_dir_for_removal(const char *name, int len);
 extern void remove_scheduled_dirs(void);
 
-extern struct alternate_object_database {
+struct alternate_object_database {
 	struct alternate_object_database *next;
 
 	/* see alt_scratch_buf() */
@@ -1591,7 +1591,7 @@ extern struct alternate_object_database {
 	struct oid_array loose_objects_cache;
 
 	char path[FLEX_ARRAY];
-} *alt_odb_list;
+};
 extern void prepare_alt_odb(void);
 extern char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
diff --git a/object-store.h b/object-store.h
index cf35760ceb..44b8f84753 100644
--- a/object-store.h
+++ b/object-store.h
@@ -1,14 +1,19 @@
 #ifndef OBJECT_STORE_H
 #define OBJECT_STORE_H
 
+#include "cache.h"
+
 struct raw_object_store {
 	/*
 	 * Path to the repository's object store.
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
index 4a5fe7ab18..d61076faaf 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "mru.h"
 #include "pack.h"
+#include "repository.h"
 #include "dir.h"
 #include "mergesort.h"
 #include "packfile.h"
@@ -880,7 +881,7 @@ void prepare_packed_git(void)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
 	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next)
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
 	prepare_packed_git_mru();
diff --git a/sha1_file.c b/sha1_file.c
index 3da70ac650..2826d5d6ed 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -22,6 +22,7 @@
 #include "pack-revindex.h"
 #include "sha1-lookup.h"
 #include "bulk-checkin.h"
+#include "repository.h"
 #include "streaming.h"
 #include "dir.h"
 #include "mru.h"
@@ -346,9 +347,6 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 	return buf->buf;
 }
 
-struct alternate_object_database *alt_odb_list;
-static struct alternate_object_database **alt_odb_tail;
-
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
@@ -368,7 +366,7 @@ static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		if (!fspathcmp(path->buf, alt->path))
 			return 0;
 	}
@@ -428,8 +426,8 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	ent = alloc_alt_odb(pathbuf.buf);
 
 	/* add the alternate entry */
-	*alt_odb_tail = ent;
-	alt_odb_tail = &(ent->next);
+	*the_repository->objects.alt_odb_tail = ent;
+	the_repository->objects.alt_odb_tail = &(ent->next);
 	ent->next = NULL;
 
 	/* recursively add alternates */
@@ -563,7 +561,7 @@ void add_to_alternates_file(const char *reference)
 		fprintf_or_die(out, "%s\n", reference);
 		if (commit_lock_file(&lock))
 			die_errno("unable to move new alternates file into place");
-		if (alt_odb_tail)
+		if (the_repository->objects.alt_odb_tail)
 			link_alt_odb_entries(reference, '\n', NULL, 0);
 	}
 	free(alts);
@@ -661,7 +659,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	int r = 0;
 
 	prepare_alt_odb();
-	for (ent = alt_odb_list; ent; ent = ent->next) {
+	for (ent = the_repository->objects.alt_odb_list; ent; ent = ent->next) {
 		r = fn(ent, cb);
 		if (r)
 			break;
@@ -673,12 +671,13 @@ void prepare_alt_odb(void)
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
@@ -717,7 +716,7 @@ static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 {
 	struct alternate_object_database *alt;
 	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		const char *path = alt_sha1_path(alt, sha1);
 		if (check_and_freshen_file(path, freshen))
 			return 1;
@@ -873,7 +872,7 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 
 	prepare_alt_odb();
 	errno = ENOENT;
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		if (!lstat(*path, st))
 			return 0;
@@ -899,7 +898,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
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
2.16.1.73.ga2c3e9663f.dirty

