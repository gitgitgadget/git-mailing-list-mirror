Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7551420899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbdHIBYD (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:24:03 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:38022 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752519AbdHIBXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:16 -0400
Received: by mail-pg0-f51.google.com with SMTP id l64so21493137pge.5
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=F/QxWFKbM7168No7CoHJS/18pqDHNfTb5iWXB36m02U=;
        b=C2vNvnWysDriPHjhAqbuZNaFHjSrwHFyp+fJPqGm9NT2w8ipDzYROyrMTBvwFDOtTU
         gdvhtOqMIs+aKVEoRXHGS04t6+CebS1XRz79fufpDSNKvc07zHhP7o7SKy07WeEJyhYP
         XqiFXXl0HrRBh5I8fOV7qdXSSjwA2+nwZlLo/UEWigmrLZ4nEl9W7siGPpZJKysO9JP3
         jgwu/RKbQfUrtKBX7FOH7BttLfePreOtF08WqIyfEB4KbWeQZULnI4kr9iQzikSabOeZ
         YsDBVRScF9p+e7n+C4iSCNd/SfAE5bXN/VhZNFETHx3ahtuAXShkC9E9mlVc9XA/D3xn
         y+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=F/QxWFKbM7168No7CoHJS/18pqDHNfTb5iWXB36m02U=;
        b=tnW/k19j6JduT8z2D46tvTCz64/QzmSKN8tXIrFlPNV2rmA1lkGsm0fe5hhIfLeEBw
         OhLoMQgGQeLBstkxvmWry/9JQ0TATC8XYJIJlwfgBvfDeyQQJ5jtGk9I7pnY5IvdY4sh
         q/bHRYEuyhyUWRCQNyj0+HTvoTDIEgZ1hsIOaj7CGG+ABHB0n0FZ0BIhL01dxFu3O8ku
         dmlkDPUOuStFgHzIH4F/+ZE+dJG87ECjeSLvBbUnioXuO1Le0rb55p9hvWSMovUqIXzg
         tamzdI5gyDqN4K16vejFM3exMT/slqsepCj9xJyqE5T8D4bCa35Yc2E+aNlbjrohBi+s
         qeTw==
X-Gm-Message-State: AHYfb5jWy/i63qUSJpwqt5RuaaGb8khSMiNpWGTcHruK5mPqxb0Ztmyt
        7ZmVtG3FoOyEz+nKbvHs8g==
X-Received: by 10.98.65.194 with SMTP id g63mr6588608pfd.196.1502241795133;
        Tue, 08 Aug 2017 18:23:15 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:14 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 11/25] pack: move {,re}prepare_packed_git and approximate_object_count
Date:   Tue,  8 Aug 2017 18:22:43 -0700
Message-Id: <fdca294375815839448148d8454ddb4aaa855b66.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/gc.c   |   1 +
 cache.h        |  15 ----
 http-backend.c |   1 +
 pack.h         |  15 ++++
 packfile.c     | 216 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 path.c         |   1 +
 server-info.c  |   1 +
 sha1_file.c    | 214 --------------------------------------------------------
 8 files changed, 235 insertions(+), 229 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e6b84475a..f4fe023d3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -19,6 +19,7 @@
 #include "sigchain.h"
 #include "argv-array.h"
 #include "commit.h"
+#include "pack.h"
 
 #define FAILED_RUN "failed to run %s"
 
diff --git a/cache.h b/cache.h
index 41562dc0b..f020dfade 100644
--- a/cache.h
+++ b/cache.h
@@ -1603,21 +1603,6 @@ struct pack_entry {
 	struct packed_git *p;
 };
 
-/* A hook to report invalid files in pack directory */
-#define PACKDIR_FILE_PACK 1
-#define PACKDIR_FILE_IDX 2
-#define PACKDIR_FILE_GARBAGE 4
-extern void (*report_garbage)(unsigned seen_bits, const char *path);
-
-extern void prepare_packed_git(void);
-extern void reprepare_packed_git(void);
-
-/*
- * Give a rough count of objects in the repository. This sacrifices accuracy
- * for speed.
- */
-unsigned long approximate_object_count(void);
-
 extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 					 struct packed_git *packs);
 
diff --git a/http-backend.c b/http-backend.c
index 519025d2c..12f7d421f 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -9,6 +9,7 @@
 #include "string-list.h"
 #include "url.h"
 #include "argv-array.h"
+#include "pack.h"
 
 static const char content_type[] = "Content-Type";
 static const char content_length[] = "Content-Length";
diff --git a/pack.h b/pack.h
index 576c4fc7c..cad5ed488 100644
--- a/pack.h
+++ b/pack.h
@@ -152,4 +152,19 @@ extern struct packed_git *add_packed_git(const char *path, size_t path_len, int
 
 extern void install_packed_git(struct packed_git *pack);
 
+/* A hook to report invalid files in pack directory */
+#define PACKDIR_FILE_PACK 1
+#define PACKDIR_FILE_IDX 2
+#define PACKDIR_FILE_GARBAGE 4
+extern void (*report_garbage)(unsigned seen_bits, const char *path);
+
+extern void prepare_packed_git(void);
+extern void reprepare_packed_git(void);
+
+/*
+ * Give a rough count of objects in the repository. This sacrifices accuracy
+ * for speed.
+ */
+unsigned long approximate_object_count(void);
+
 #endif
diff --git a/packfile.c b/packfile.c
index 4eb65e460..a517172f7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "mru.h"
 #include "pack.h"
+#include "dir.h"
+#include "mergesort.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -667,3 +669,217 @@ void install_packed_git(struct packed_git *pack)
 	pack->next = packed_git;
 	packed_git = pack;
 }
+
+void (*report_garbage)(unsigned seen_bits, const char *path);
+
+static void report_helper(const struct string_list *list,
+			  int seen_bits, int first, int last)
+{
+	if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX))
+		return;
+
+	for (; first < last; first++)
+		report_garbage(seen_bits, list->items[first].string);
+}
+
+static void report_pack_garbage(struct string_list *list)
+{
+	int i, baselen = -1, first = 0, seen_bits = 0;
+
+	if (!report_garbage)
+		return;
+
+	string_list_sort(list);
+
+	for (i = 0; i < list->nr; i++) {
+		const char *path = list->items[i].string;
+		if (baselen != -1 &&
+		    strncmp(path, list->items[first].string, baselen)) {
+			report_helper(list, seen_bits, first, i);
+			baselen = -1;
+			seen_bits = 0;
+		}
+		if (baselen == -1) {
+			const char *dot = strrchr(path, '.');
+			if (!dot) {
+				report_garbage(PACKDIR_FILE_GARBAGE, path);
+				continue;
+			}
+			baselen = dot - path + 1;
+			first = i;
+		}
+		if (!strcmp(path + baselen, "pack"))
+			seen_bits |= 1;
+		else if (!strcmp(path + baselen, "idx"))
+			seen_bits |= 2;
+	}
+	report_helper(list, seen_bits, first, list->nr);
+}
+
+static void prepare_packed_git_one(char *objdir, int local)
+{
+	struct strbuf path = STRBUF_INIT;
+	size_t dirnamelen;
+	DIR *dir;
+	struct dirent *de;
+	struct string_list garbage = STRING_LIST_INIT_DUP;
+
+	strbuf_addstr(&path, objdir);
+	strbuf_addstr(&path, "/pack");
+	dir = opendir(path.buf);
+	if (!dir) {
+		if (errno != ENOENT)
+			error_errno("unable to open object pack directory: %s",
+				    path.buf);
+		strbuf_release(&path);
+		return;
+	}
+	strbuf_addch(&path, '/');
+	dirnamelen = path.len;
+	while ((de = readdir(dir)) != NULL) {
+		struct packed_git *p;
+		size_t base_len;
+
+		if (is_dot_or_dotdot(de->d_name))
+			continue;
+
+		strbuf_setlen(&path, dirnamelen);
+		strbuf_addstr(&path, de->d_name);
+
+		base_len = path.len;
+		if (strip_suffix_mem(path.buf, &base_len, ".idx")) {
+			/* Don't reopen a pack we already have. */
+			for (p = packed_git; p; p = p->next) {
+				size_t len;
+				if (strip_suffix(p->pack_name, ".pack", &len) &&
+				    len == base_len &&
+				    !memcmp(p->pack_name, path.buf, len))
+					break;
+			}
+			if (p == NULL &&
+			    /*
+			     * See if it really is a valid .idx file with
+			     * corresponding .pack file that we can map.
+			     */
+			    (p = add_packed_git(path.buf, path.len, local)) != NULL)
+				install_packed_git(p);
+		}
+
+		if (!report_garbage)
+			continue;
+
+		if (ends_with(de->d_name, ".idx") ||
+		    ends_with(de->d_name, ".pack") ||
+		    ends_with(de->d_name, ".bitmap") ||
+		    ends_with(de->d_name, ".keep"))
+			string_list_append(&garbage, path.buf);
+		else
+			report_garbage(PACKDIR_FILE_GARBAGE, path.buf);
+	}
+	closedir(dir);
+	report_pack_garbage(&garbage);
+	string_list_clear(&garbage, 0);
+	strbuf_release(&path);
+}
+
+static int approximate_object_count_valid;
+
+/*
+ * Give a fast, rough count of the number of objects in the repository. This
+ * ignores loose objects completely. If you have a lot of them, then either
+ * you should repack because your performance will be awful, or they are
+ * all unreachable objects about to be pruned, in which case they're not really
+ * interesting as a measure of repo size in the first place.
+ */
+unsigned long approximate_object_count(void)
+{
+	static unsigned long count;
+	if (!approximate_object_count_valid) {
+		struct packed_git *p;
+
+		prepare_packed_git();
+		count = 0;
+		for (p = packed_git; p; p = p->next) {
+			if (open_pack_index(p))
+				continue;
+			count += p->num_objects;
+		}
+	}
+	return count;
+}
+
+static void *get_next_packed_git(const void *p)
+{
+	return ((const struct packed_git *)p)->next;
+}
+
+static void set_next_packed_git(void *p, void *next)
+{
+	((struct packed_git *)p)->next = next;
+}
+
+static int sort_pack(const void *a_, const void *b_)
+{
+	const struct packed_git *a = a_;
+	const struct packed_git *b = b_;
+	int st;
+
+	/*
+	 * Local packs tend to contain objects specific to our
+	 * variant of the project than remote ones.  In addition,
+	 * remote ones could be on a network mounted filesystem.
+	 * Favor local ones for these reasons.
+	 */
+	st = a->pack_local - b->pack_local;
+	if (st)
+		return -st;
+
+	/*
+	 * Younger packs tend to contain more recent objects,
+	 * and more recent objects tend to get accessed more
+	 * often.
+	 */
+	if (a->mtime < b->mtime)
+		return 1;
+	else if (a->mtime == b->mtime)
+		return 0;
+	return -1;
+}
+
+static void rearrange_packed_git(void)
+{
+	packed_git = llist_mergesort(packed_git, get_next_packed_git,
+				     set_next_packed_git, sort_pack);
+}
+
+static void prepare_packed_git_mru(void)
+{
+	struct packed_git *p;
+
+	mru_clear(packed_git_mru);
+	for (p = packed_git; p; p = p->next)
+		mru_append(packed_git_mru, p);
+}
+
+static int prepare_packed_git_run_once = 0;
+void prepare_packed_git(void)
+{
+	struct alternate_object_database *alt;
+
+	if (prepare_packed_git_run_once)
+		return;
+	prepare_packed_git_one(get_object_directory(), 1);
+	prepare_alt_odb();
+	for (alt = alt_odb_list; alt; alt = alt->next)
+		prepare_packed_git_one(alt->path, 0);
+	rearrange_packed_git();
+	prepare_packed_git_mru();
+	prepare_packed_git_run_once = 1;
+}
+
+void reprepare_packed_git(void)
+{
+	approximate_object_count_valid = 0;
+	prepare_packed_git_run_once = 0;
+	prepare_packed_git();
+}
diff --git a/path.c b/path.c
index e485f9f93..ae3f2f65f 100644
--- a/path.c
+++ b/path.c
@@ -9,6 +9,7 @@
 #include "worktree.h"
 #include "submodule-config.h"
 #include "path.h"
+#include "pack.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
diff --git a/server-info.c b/server-info.c
index 5ec5b1d82..e9bc18a8c 100644
--- a/server-info.c
+++ b/server-info.c
@@ -3,6 +3,7 @@
 #include "object.h"
 #include "commit.h"
 #include "tag.h"
+#include "pack.h"
 
 /*
  * Create the file "path" by writing to a temporary file and renaming
diff --git a/sha1_file.c b/sha1_file.c
index b956ca0c9..bbce60f1c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -717,220 +717,6 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
-void (*report_garbage)(unsigned seen_bits, const char *path);
-
-static void report_helper(const struct string_list *list,
-			  int seen_bits, int first, int last)
-{
-	if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX))
-		return;
-
-	for (; first < last; first++)
-		report_garbage(seen_bits, list->items[first].string);
-}
-
-static void report_pack_garbage(struct string_list *list)
-{
-	int i, baselen = -1, first = 0, seen_bits = 0;
-
-	if (!report_garbage)
-		return;
-
-	string_list_sort(list);
-
-	for (i = 0; i < list->nr; i++) {
-		const char *path = list->items[i].string;
-		if (baselen != -1 &&
-		    strncmp(path, list->items[first].string, baselen)) {
-			report_helper(list, seen_bits, first, i);
-			baselen = -1;
-			seen_bits = 0;
-		}
-		if (baselen == -1) {
-			const char *dot = strrchr(path, '.');
-			if (!dot) {
-				report_garbage(PACKDIR_FILE_GARBAGE, path);
-				continue;
-			}
-			baselen = dot - path + 1;
-			first = i;
-		}
-		if (!strcmp(path + baselen, "pack"))
-			seen_bits |= 1;
-		else if (!strcmp(path + baselen, "idx"))
-			seen_bits |= 2;
-	}
-	report_helper(list, seen_bits, first, list->nr);
-}
-
-static void prepare_packed_git_one(char *objdir, int local)
-{
-	struct strbuf path = STRBUF_INIT;
-	size_t dirnamelen;
-	DIR *dir;
-	struct dirent *de;
-	struct string_list garbage = STRING_LIST_INIT_DUP;
-
-	strbuf_addstr(&path, objdir);
-	strbuf_addstr(&path, "/pack");
-	dir = opendir(path.buf);
-	if (!dir) {
-		if (errno != ENOENT)
-			error_errno("unable to open object pack directory: %s",
-				    path.buf);
-		strbuf_release(&path);
-		return;
-	}
-	strbuf_addch(&path, '/');
-	dirnamelen = path.len;
-	while ((de = readdir(dir)) != NULL) {
-		struct packed_git *p;
-		size_t base_len;
-
-		if (is_dot_or_dotdot(de->d_name))
-			continue;
-
-		strbuf_setlen(&path, dirnamelen);
-		strbuf_addstr(&path, de->d_name);
-
-		base_len = path.len;
-		if (strip_suffix_mem(path.buf, &base_len, ".idx")) {
-			/* Don't reopen a pack we already have. */
-			for (p = packed_git; p; p = p->next) {
-				size_t len;
-				if (strip_suffix(p->pack_name, ".pack", &len) &&
-				    len == base_len &&
-				    !memcmp(p->pack_name, path.buf, len))
-					break;
-			}
-			if (p == NULL &&
-			    /*
-			     * See if it really is a valid .idx file with
-			     * corresponding .pack file that we can map.
-			     */
-			    (p = add_packed_git(path.buf, path.len, local)) != NULL)
-				install_packed_git(p);
-		}
-
-		if (!report_garbage)
-			continue;
-
-		if (ends_with(de->d_name, ".idx") ||
-		    ends_with(de->d_name, ".pack") ||
-		    ends_with(de->d_name, ".bitmap") ||
-		    ends_with(de->d_name, ".keep"))
-			string_list_append(&garbage, path.buf);
-		else
-			report_garbage(PACKDIR_FILE_GARBAGE, path.buf);
-	}
-	closedir(dir);
-	report_pack_garbage(&garbage);
-	string_list_clear(&garbage, 0);
-	strbuf_release(&path);
-}
-
-static int approximate_object_count_valid;
-
-/*
- * Give a fast, rough count of the number of objects in the repository. This
- * ignores loose objects completely. If you have a lot of them, then either
- * you should repack because your performance will be awful, or they are
- * all unreachable objects about to be pruned, in which case they're not really
- * interesting as a measure of repo size in the first place.
- */
-unsigned long approximate_object_count(void)
-{
-	static unsigned long count;
-	if (!approximate_object_count_valid) {
-		struct packed_git *p;
-
-		prepare_packed_git();
-		count = 0;
-		for (p = packed_git; p; p = p->next) {
-			if (open_pack_index(p))
-				continue;
-			count += p->num_objects;
-		}
-	}
-	return count;
-}
-
-static void *get_next_packed_git(const void *p)
-{
-	return ((const struct packed_git *)p)->next;
-}
-
-static void set_next_packed_git(void *p, void *next)
-{
-	((struct packed_git *)p)->next = next;
-}
-
-static int sort_pack(const void *a_, const void *b_)
-{
-	const struct packed_git *a = a_;
-	const struct packed_git *b = b_;
-	int st;
-
-	/*
-	 * Local packs tend to contain objects specific to our
-	 * variant of the project than remote ones.  In addition,
-	 * remote ones could be on a network mounted filesystem.
-	 * Favor local ones for these reasons.
-	 */
-	st = a->pack_local - b->pack_local;
-	if (st)
-		return -st;
-
-	/*
-	 * Younger packs tend to contain more recent objects,
-	 * and more recent objects tend to get accessed more
-	 * often.
-	 */
-	if (a->mtime < b->mtime)
-		return 1;
-	else if (a->mtime == b->mtime)
-		return 0;
-	return -1;
-}
-
-static void rearrange_packed_git(void)
-{
-	packed_git = llist_mergesort(packed_git, get_next_packed_git,
-				     set_next_packed_git, sort_pack);
-}
-
-static void prepare_packed_git_mru(void)
-{
-	struct packed_git *p;
-
-	mru_clear(packed_git_mru);
-	for (p = packed_git; p; p = p->next)
-		mru_append(packed_git_mru, p);
-}
-
-static int prepare_packed_git_run_once = 0;
-void prepare_packed_git(void)
-{
-	struct alternate_object_database *alt;
-
-	if (prepare_packed_git_run_once)
-		return;
-	prepare_packed_git_one(get_object_directory(), 1);
-	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next)
-		prepare_packed_git_one(alt->path, 0);
-	rearrange_packed_git();
-	prepare_packed_git_mru();
-	prepare_packed_git_run_once = 1;
-}
-
-void reprepare_packed_git(void)
-{
-	approximate_object_count_valid = 0;
-	prepare_packed_git_run_once = 0;
-	prepare_packed_git();
-}
-
 static void mark_bad_packed_object(struct packed_git *p,
 				   const unsigned char *sha1)
 {
-- 
2.14.0.434.g98096fd7a8-goog

