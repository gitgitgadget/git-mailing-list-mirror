Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70A0C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA32120708
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bbapj/pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgEGNRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 09:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726776AbgEGNRr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 09:17:47 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D2CC05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 06:17:47 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so6467917wmj.3
        for <git@vger.kernel.org>; Thu, 07 May 2020 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WrrjA/SgYyXFHBt9gbXWdPSiiDxOhuTGU9CTQ9nrm/w=;
        b=Bbapj/pebRfOpjuVp3h86M5vqU8oEJ1ZSyHeJgAOUMdh4pfvhMwT6g/f5vispwX7pH
         0Czy2/AXCGp+2SkjJ9LgUEeT9xkz7o71K5lTrnOhufp4hLL1tooo4Iq+cr/vevllP9sj
         lqHAcVf+qinBtahQO1FQbG5vSferg958T2vjbmjagoERcTdHciiqGOegvARy4/wi/vK3
         mSFKSBC1bis79xrLnHaopcCujxcyO5m3/BZ5DOY4UjA9p2Dy5IAA3wV13d3OhZnnKl2d
         JnC4zEIDMi7ZX5gkwy14oOcA/XClZGG1DjzcSugjfLbggxPUlz9+8nYu1+iXEU37KYSG
         eIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WrrjA/SgYyXFHBt9gbXWdPSiiDxOhuTGU9CTQ9nrm/w=;
        b=KflBCtIxP97wJkcaFgZAaCj8w9x5MvV/h5daQezXn6twU0APSnB4FsloN17ZSBfCUD
         ZWn8+sb/7y2PQrf0kAORLFGSvuly2hE00bGB3SmeaJCsGncq3x7Cv3Tcov8txVIgs1F5
         AkPXFPX7SPoxixH3Gay2fyTmEeiMhvGl0asRQ7P9ZVqwFUQiASN8uawptuQNZ6ZkK6k9
         ZVbj3R4DtGYV9JDrL9/+2Rlhc5y091TBZmO5h6nRpaJ0x6/ujVAIHk5hFv2AsAEEh1RU
         vsJjkdWfiA/R+NXNnNr1hIY5beRf8IY2kbZRuo/fleSrLqkRYWTRjAbslIWSjV4GBZGb
         XAdw==
X-Gm-Message-State: AGi0PuZxt/7t7hUwY3mevnafhxe4+pyIpf/aCTtdv2GEAIPG5mS9C38y
        JOckz7w7J3hYZZYUskD3OPCrO10/
X-Google-Smtp-Source: APiQypKqNE0AuKnAI/K0HfS4YvIZsWbGsSTuNA2I8FZYPUc0ggBEBpBjEG1/orLjWK0n8m+zc4jogw==
X-Received: by 2002:a7b:ce89:: with SMTP id q9mr11052500wmj.185.1588857465152;
        Thu, 07 May 2020 06:17:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b82sm8447026wmh.1.2020.05.07.06.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 06:17:44 -0700 (PDT)
Message-Id: <0181a134bfb6986dc0e54ae624c478446a1324a9.1588857462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.627.git.1588857462.gitgitgadget@gmail.com>
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 13:17:34 +0000
Subject: [PATCH 02/10] sparse-checkout: move code from builtin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmaill.com, peff@peff.net, me@ttaylorr.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In anticipation of some new features in the sparse-checkout space,
create a new sparse-checkout.c file at root to store the implementation
of these features. Several helper methods from builtin/sparse-checkout.c
are moved to this file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile                  |   1 +
 builtin/sparse-checkout.c | 225 +-----------------------------------
 sparse-checkout.c         | 233 ++++++++++++++++++++++++++++++++++++++
 sparse-checkout.h         |  16 +++
 4 files changed, 251 insertions(+), 224 deletions(-)
 create mode 100644 sparse-checkout.c
 create mode 100644 sparse-checkout.h

diff --git a/Makefile b/Makefile
index 9804a0758b2..2e8029b8026 100644
--- a/Makefile
+++ b/Makefile
@@ -985,6 +985,7 @@ LIB_OBJS += sha1-name.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
+LIB_OBJS += sparse-checkout.o
 LIB_OBJS += split-index.o
 LIB_OBJS += stable-qsort.o
 LIB_OBJS += strbuf.o
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 95d08824172..fd247e428e4 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -9,11 +9,11 @@
 #include "string-list.h"
 #include "cache.h"
 #include "cache-tree.h"
-#include "lockfile.h"
 #include "resolve-undo.h"
 #include "unpack-trees.h"
 #include "wt-status.h"
 #include "quote.h"
+#include "sparse-checkout.h"
 
 static const char *empty_base = "";
 
@@ -22,30 +22,6 @@ static char const * const builtin_sparse_checkout_usage[] = {
 	NULL
 };
 
-static char *get_sparse_checkout_filename(void)
-{
-	return git_pathdup("info/sparse-checkout");
-}
-
-static void write_patterns_to_file(FILE *fp, struct pattern_list *pl)
-{
-	int i;
-
-	for (i = 0; i < pl->nr; i++) {
-		struct path_pattern *p = pl->patterns[i];
-
-		if (p->flags & PATTERN_FLAG_NEGATIVE)
-			fprintf(fp, "!");
-
-		fprintf(fp, "%s", p->pattern);
-
-		if (p->flags & PATTERN_FLAG_MUSTBEDIR)
-			fprintf(fp, "/");
-
-		fprintf(fp, "\n");
-	}
-}
-
 static int sparse_checkout_list(int argc, const char **argv)
 {
 	struct pattern_list pl;
@@ -92,153 +68,6 @@ static int sparse_checkout_list(int argc, const char **argv)
 	return 0;
 }
 
-static int update_working_directory(struct pattern_list *pl)
-{
-	enum update_sparsity_result result;
-	struct unpack_trees_options o;
-	struct lock_file lock_file = LOCK_INIT;
-	struct repository *r = the_repository;
-
-	memset(&o, 0, sizeof(o));
-	o.verbose_update = isatty(2);
-	o.update = 1;
-	o.head_idx = -1;
-	o.src_index = r->index;
-	o.dst_index = r->index;
-	o.skip_sparse_checkout = 0;
-	o.pl = pl;
-
-	setup_work_tree();
-
-	repo_hold_locked_index(r, &lock_file, LOCK_DIE_ON_ERROR);
-
-	setup_unpack_trees_porcelain(&o, "sparse-checkout");
-	result = update_sparsity(&o);
-	clear_unpack_trees_porcelain(&o);
-
-	if (result == UPDATE_SPARSITY_WARNINGS)
-		/*
-		 * We don't do any special handling of warnings from untracked
-		 * files in the way or dirty entries that can't be removed.
-		 */
-		result = UPDATE_SPARSITY_SUCCESS;
-	if (result == UPDATE_SPARSITY_SUCCESS)
-		write_locked_index(r->index, &lock_file, COMMIT_LOCK);
-	else
-		rollback_lock_file(&lock_file);
-
-	return result;
-}
-
-static char *escaped_pattern(char *pattern)
-{
-	char *p = pattern;
-	struct strbuf final = STRBUF_INIT;
-
-	while (*p) {
-		if (is_glob_special(*p))
-			strbuf_addch(&final, '\\');
-
-		strbuf_addch(&final, *p);
-		p++;
-	}
-
-	return strbuf_detach(&final, NULL);
-}
-
-static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
-{
-	int i;
-	struct pattern_entry *pe;
-	struct hashmap_iter iter;
-	struct string_list sl = STRING_LIST_INIT_DUP;
-	struct strbuf parent_pattern = STRBUF_INIT;
-
-	hashmap_for_each_entry(&pl->parent_hashmap, &iter, pe, ent) {
-		if (hashmap_get_entry(&pl->recursive_hashmap, pe, ent, NULL))
-			continue;
-
-		if (!hashmap_contains_parent(&pl->recursive_hashmap,
-					     pe->pattern,
-					     &parent_pattern))
-			string_list_insert(&sl, pe->pattern);
-	}
-
-	string_list_sort(&sl);
-	string_list_remove_duplicates(&sl, 0);
-
-	fprintf(fp, "/*\n!/*/\n");
-
-	for (i = 0; i < sl.nr; i++) {
-		char *pattern = escaped_pattern(sl.items[i].string);
-
-		if (strlen(pattern))
-			fprintf(fp, "%s/\n!%s/*/\n", pattern, pattern);
-		free(pattern);
-	}
-
-	string_list_clear(&sl, 0);
-
-	hashmap_for_each_entry(&pl->recursive_hashmap, &iter, pe, ent) {
-		if (!hashmap_contains_parent(&pl->recursive_hashmap,
-					     pe->pattern,
-					     &parent_pattern))
-			string_list_insert(&sl, pe->pattern);
-	}
-
-	strbuf_release(&parent_pattern);
-
-	string_list_sort(&sl);
-	string_list_remove_duplicates(&sl, 0);
-
-	for (i = 0; i < sl.nr; i++) {
-		char *pattern = escaped_pattern(sl.items[i].string);
-		fprintf(fp, "%s/\n", pattern);
-		free(pattern);
-	}
-}
-
-static int write_patterns_and_update(struct pattern_list *pl)
-{
-	char *sparse_filename;
-	FILE *fp;
-	int fd;
-	struct lock_file lk = LOCK_INIT;
-	int result;
-
-	sparse_filename = get_sparse_checkout_filename();
-
-	if (safe_create_leading_directories(sparse_filename))
-		die(_("failed to create directory for sparse-checkout file"));
-
-	fd = hold_lock_file_for_update(&lk, sparse_filename,
-				      LOCK_DIE_ON_ERROR);
-
-	result = update_working_directory(pl);
-	if (result) {
-		rollback_lock_file(&lk);
-		free(sparse_filename);
-		clear_pattern_list(pl);
-		update_working_directory(NULL);
-		return result;
-	}
-
-	fp = xfdopen(fd, "w");
-
-	if (core_sparse_checkout_cone)
-		write_cone_to_file(fp, pl);
-	else
-		write_patterns_to_file(fp, pl);
-
-	fflush(fp);
-	commit_lock_file(&lk);
-
-	free(sparse_filename);
-	clear_pattern_list(pl);
-
-	return 0;
-}
-
 enum sparse_checkout_mode {
 	MODE_NO_PATTERNS = 0,
 	MODE_ALL_PATTERNS = 1,
@@ -339,58 +168,6 @@ static int sparse_checkout_init(int argc, const char **argv)
 	return write_patterns_and_update(&pl);
 }
 
-static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path)
-{
-	struct pattern_entry *e = xmalloc(sizeof(*e));
-	e->patternlen = path->len;
-	e->pattern = strbuf_detach(path, NULL);
-	hashmap_entry_init(&e->ent,
-			   ignore_case ?
-			   strihash(e->pattern) :
-			   strhash(e->pattern));
-
-	hashmap_add(&pl->recursive_hashmap, &e->ent);
-
-	while (e->patternlen) {
-		char *slash = strrchr(e->pattern, '/');
-		char *oldpattern = e->pattern;
-		size_t newlen;
-
-		if (slash == e->pattern)
-			break;
-
-		newlen = slash - e->pattern;
-		e = xmalloc(sizeof(struct pattern_entry));
-		e->patternlen = newlen;
-		e->pattern = xstrndup(oldpattern, newlen);
-		hashmap_entry_init(&e->ent,
-				   ignore_case ?
-				   strihash(e->pattern) :
-				   strhash(e->pattern));
-
-		if (!hashmap_get_entry(&pl->parent_hashmap, e, ent, NULL))
-			hashmap_add(&pl->parent_hashmap, &e->ent);
-	}
-}
-
-static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
-{
-	strbuf_trim(line);
-
-	strbuf_trim_trailing_dir_sep(line);
-
-	if (strbuf_normalize_path(line))
-		die(_("could not normalize path %s"), line->buf);
-
-	if (!line->len)
-		return;
-
-	if (line->buf[0] != '/')
-		strbuf_insertstr(line, 0, "/");
-
-	insert_recursive_pattern(pl, line);
-}
-
 static char const * const builtin_sparse_checkout_set_usage[] = {
 	N_("git sparse-checkout (set|add) (--stdin | <patterns>)"),
 	NULL
diff --git a/sparse-checkout.c b/sparse-checkout.c
new file mode 100644
index 00000000000..5ada307b42c
--- /dev/null
+++ b/sparse-checkout.c
@@ -0,0 +1,233 @@
+#include "cache.h"
+#include "config.h"
+#include "dir.h"
+#include "lockfile.h"
+#include "quote.h"
+#include "repository.h"
+#include "sparse-checkout.h"
+#include "strbuf.h"
+#include "string-list.h"
+#include "unpack-trees.h"
+
+char *get_sparse_checkout_filename(void)
+{
+	return git_pathdup("info/sparse-checkout");
+}
+
+void write_patterns_to_file(FILE *fp, struct pattern_list *pl)
+{
+	int i;
+
+	for (i = 0; i < pl->nr; i++) {
+		struct path_pattern *p = pl->patterns[i];
+
+		if (p->flags & PATTERN_FLAG_NEGATIVE)
+			fprintf(fp, "!");
+
+		fprintf(fp, "%s", p->pattern);
+
+		if (p->flags & PATTERN_FLAG_MUSTBEDIR)
+			fprintf(fp, "/");
+
+		fprintf(fp, "\n");
+	}
+}
+
+int update_working_directory(struct pattern_list *pl)
+{
+	enum update_sparsity_result result;
+	struct unpack_trees_options o;
+	struct lock_file lock_file = LOCK_INIT;
+	struct repository *r = the_repository;
+
+	memset(&o, 0, sizeof(o));
+	o.verbose_update = isatty(2);
+	o.update = 1;
+	o.head_idx = -1;
+	o.src_index = r->index;
+	o.dst_index = r->index;
+	o.skip_sparse_checkout = 0;
+	o.pl = pl;
+
+	setup_work_tree();
+
+	repo_hold_locked_index(r, &lock_file, LOCK_DIE_ON_ERROR);
+
+	setup_unpack_trees_porcelain(&o, "sparse-checkout");
+	result = update_sparsity(&o);
+	clear_unpack_trees_porcelain(&o);
+
+	if (result == UPDATE_SPARSITY_WARNINGS)
+		/*
+		 * We don't do any special handling of warnings from untracked
+		 * files in the way or dirty entries that can't be removed.
+		 */
+		result = UPDATE_SPARSITY_SUCCESS;
+	if (result == UPDATE_SPARSITY_SUCCESS)
+		write_locked_index(r->index, &lock_file, COMMIT_LOCK);
+	else
+		rollback_lock_file(&lock_file);
+
+	return result;
+}
+
+static char *escaped_pattern(char *pattern)
+{
+	char *p = pattern;
+	struct strbuf final = STRBUF_INIT;
+
+	while (*p) {
+		if (is_glob_special(*p))
+			strbuf_addch(&final, '\\');
+
+		strbuf_addch(&final, *p);
+		p++;
+	}
+
+	return strbuf_detach(&final, NULL);
+}
+
+static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
+{
+	int i;
+	struct pattern_entry *pe;
+	struct hashmap_iter iter;
+	struct string_list sl = STRING_LIST_INIT_DUP;
+	struct strbuf parent_pattern = STRBUF_INIT;
+
+	hashmap_for_each_entry(&pl->parent_hashmap, &iter, pe, ent) {
+		if (hashmap_get_entry(&pl->recursive_hashmap, pe, ent, NULL))
+			continue;
+
+		if (!hashmap_contains_parent(&pl->recursive_hashmap,
+					     pe->pattern,
+					     &parent_pattern))
+			string_list_insert(&sl, pe->pattern);
+	}
+
+	string_list_sort(&sl);
+	string_list_remove_duplicates(&sl, 0);
+
+	fprintf(fp, "/*\n!/*/\n");
+
+	for (i = 0; i < sl.nr; i++) {
+		char *pattern = escaped_pattern(sl.items[i].string);
+
+		if (strlen(pattern))
+			fprintf(fp, "%s/\n!%s/*/\n", pattern, pattern);
+		free(pattern);
+	}
+
+	string_list_clear(&sl, 0);
+
+	hashmap_for_each_entry(&pl->recursive_hashmap, &iter, pe, ent) {
+		if (!hashmap_contains_parent(&pl->recursive_hashmap,
+					     pe->pattern,
+					     &parent_pattern))
+			string_list_insert(&sl, pe->pattern);
+	}
+
+	strbuf_release(&parent_pattern);
+
+	string_list_sort(&sl);
+	string_list_remove_duplicates(&sl, 0);
+
+	for (i = 0; i < sl.nr; i++) {
+		char *pattern = escaped_pattern(sl.items[i].string);
+		fprintf(fp, "%s/\n", pattern);
+		free(pattern);
+	}
+}
+
+int write_patterns_and_update(struct pattern_list *pl)
+{
+	char *sparse_filename;
+	FILE *fp;
+	int fd;
+	struct lock_file lk = LOCK_INIT;
+	int result;
+
+	sparse_filename = get_sparse_checkout_filename();
+
+	if (safe_create_leading_directories(sparse_filename))
+		die(_("failed to create directory for sparse-checkout file"));
+
+	fd = hold_lock_file_for_update(&lk, sparse_filename,
+				      LOCK_DIE_ON_ERROR);
+
+	result = update_working_directory(pl);
+	if (result) {
+		rollback_lock_file(&lk);
+		free(sparse_filename);
+		clear_pattern_list(pl);
+		update_working_directory(NULL);
+		return result;
+	}
+
+	fp = xfdopen(fd, "w");
+
+	if (core_sparse_checkout_cone)
+		write_cone_to_file(fp, pl);
+	else
+		write_patterns_to_file(fp, pl);
+
+	fflush(fp);
+	commit_lock_file(&lk);
+
+	free(sparse_filename);
+	clear_pattern_list(pl);
+
+	return 0;
+}
+
+void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path)
+{
+	struct pattern_entry *e = xmalloc(sizeof(*e));
+	e->patternlen = path->len;
+	e->pattern = strbuf_detach(path, NULL);
+	hashmap_entry_init(&e->ent,
+			   ignore_case ?
+			   strihash(e->pattern) :
+			   strhash(e->pattern));
+
+	hashmap_add(&pl->recursive_hashmap, &e->ent);
+
+	while (e->patternlen) {
+		char *slash = strrchr(e->pattern, '/');
+		char *oldpattern = e->pattern;
+		size_t newlen;
+
+		if (slash == e->pattern)
+			break;
+
+		newlen = slash - e->pattern;
+		e = xmalloc(sizeof(struct pattern_entry));
+		e->patternlen = newlen;
+		e->pattern = xstrndup(oldpattern, newlen);
+		hashmap_entry_init(&e->ent,
+				   ignore_case ?
+				   strihash(e->pattern) :
+				   strhash(e->pattern));
+
+		if (!hashmap_get_entry(&pl->parent_hashmap, e, ent, NULL))
+			hashmap_add(&pl->parent_hashmap, &e->ent);
+	}
+}
+
+void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
+{
+	strbuf_trim(line);
+
+	strbuf_trim_trailing_dir_sep(line);
+
+	if (strbuf_normalize_path(line))
+		die(_("could not normalize path %s"), line->buf);
+
+	if (!line->len)
+		return;
+
+	if (line->buf[0] != '/')
+		strbuf_insertstr(line, 0, "/");
+
+	insert_recursive_pattern(pl, line);
+}
diff --git a/sparse-checkout.h b/sparse-checkout.h
new file mode 100644
index 00000000000..4148832760d
--- /dev/null
+++ b/sparse-checkout.h
@@ -0,0 +1,16 @@
+#ifndef SPARSE_CHECKOUT_H
+#define SPARSE_CHECKOUT_H
+
+#include "cache.h"
+#include "repository.h"
+
+struct pattern_list;
+
+char *get_sparse_checkout_filename(void);
+void write_patterns_to_file(FILE *fp, struct pattern_list *pl);
+int update_working_directory(struct pattern_list *pl);
+int write_patterns_and_update(struct pattern_list *pl);
+void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path);
+void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl);
+
+#endif
-- 
gitgitgadget

