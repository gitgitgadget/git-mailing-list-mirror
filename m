Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 559511F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeBFA1N (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:27:13 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33354 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752283AbeBFA1J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:27:09 -0500
Received: by mail-pl0-f68.google.com with SMTP id t4so141296plo.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yf9rlQymq15PZNeVfvMGtGSkFR+aAsR5DZC7IZ8nt0s=;
        b=izM6y1VS0gdKXrkbyKfazgDmzMGdjS7OXSQY5l9yZoho1UAA6j14GKpJdL3gEiPrUS
         WFTmOJYzE+q4Z+bds8bz61IobkQaqCoe4/H6UjYT1qDzcHYLUn65wLb+inLfHgUMZrpa
         L8Txp8JD1qbP4wGhNDU4ms6q6QI+YzScZZ6DURP6/FYEJgKaKI+sbCoytjZyaZ47iVJd
         rmPz3RQ+3WAqhugqsNPbfOgNTR7NM0lZBvT058TvFRjVklI5eZX55iJEZFTWctC1i+Fm
         EuQtOfELzjGyg83GS0dju1ZDnAAcsKUwN8tu8IG6LivU0B+gkxQUF+KaOsJSmiBKjaRz
         mhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yf9rlQymq15PZNeVfvMGtGSkFR+aAsR5DZC7IZ8nt0s=;
        b=fjcKs3BI954/26YaHSoo6CIbVwoKvDzRPWStNAVsJUeQJqc4x59OQCw1OkeU/pmGBn
         yRCzoTvoZI6MwHLuTViCMR31ORgJ6e6/cRjKHQa+HBkKvj7RwCF2jLsiXTtgNwbQc51v
         g4LYAFLtcanUFPbC/qYD136u2SDDVEiko9oZffNGOF1MJ6XTrFuIT12NggJaTeRSp0qA
         1DGm8R/mdhgkwyu/yN+4XZgFwTgAQoQ90ebSZIh810XA9EqoBsmTZ0T3RGU9fOwwihzQ
         wUQNjJsPS84WBFRBU8kTWRTHd2d9+m23LjPoKcVfiBOaWKQx94FEovjpFnv7YgEi+X2E
         XavQ==
X-Gm-Message-State: APf1xPBOv1zCtpK2vNHoEI0Sl9tzfStVwSmeL2UGk3qNjS9Sngvoq7JM
        Ncw6ceJBzIakyWjjY9o8xgpfZh2XdJg=
X-Google-Smtp-Source: AH8x224EF9lFyQlncuK98ugqz5q7qbwgC/qVPi1x0Dxdj5yKwhgz9ddj62Wy4ww4kzup2rnfVWESuw==
X-Received: by 2002:a17:902:8f90:: with SMTP id z16-v6mr570428plo.370.1517876828743;
        Mon, 05 Feb 2018 16:27:08 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w12sm17914733pfd.86.2018.02.05.16.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:27:08 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 157/194] shallow: migrate shallow information into the object parser
Date:   Mon,  5 Feb 2018 16:17:12 -0800
Message-Id: <20180206001749.218943-59-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.h     | 11 ++++-------
 object.h     |  6 ++++++
 repository.c |  4 ++++
 shallow.c    | 52 +++++++++++++++++++++++++---------------------------
 4 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/commit.h b/commit.h
index 06795f0684..cdd12ad75d 100644
--- a/commit.h
+++ b/commit.h
@@ -196,19 +196,16 @@ extern struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n,
 
 struct oid_array;
 struct ref;
-#define register_shallow(r, o) register_shallow_##r(o);
-extern int register_shallow_the_repository(const struct object_id *oid);
+extern int register_shallow(struct repository *r, const struct object_id *oid);
 extern int unregister_shallow(const struct object_id *oid);
 extern int for_each_commit_graft(each_commit_graft_fn, void *);
-extern int is_repository_shallow(void);
-#define is_repository_shallow(r) is_repository_shallow_##r()
-extern int is_repository_shallow_the_repository(void);
+extern int is_repository_shallow(struct repository *r);
+extern int for_each_commit_graft_the_repository(each_commit_graft_fn, void *);
 extern struct commit_list *get_shallow_commits(struct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
 extern struct commit_list *get_shallow_commits_by_rev_list(
 		int ac, const char **av, int shallow_flag, int not_shallow_flag);
-#define set_alternate_shallow_file(r, p, o) set_alternate_shallow_file_##r(p, o)
-extern void set_alternate_shallow_file_the_repository(const char *path, int override);
+extern void set_alternate_shallow_file(struct repository *r, const char *path, int override);
 extern int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
 				 const struct oid_array *extra);
 extern void setup_alternate_shallow(struct lock_file *shallow_lock,
diff --git a/object.h b/object.h
index 65b5326e0f..369295c7c1 100644
--- a/object.h
+++ b/object.h
@@ -11,6 +11,10 @@ struct object_parser {
 	struct commit_graft **grafts;
 	int grafts_alloc, grafts_nr;
 
+	int is_shallow;
+	struct stat_validity *shallow_stat;
+	char *alternate_shallow_file;
+
 	struct alloc_state *blob_state;
 	struct alloc_state *tree_state;
 	struct alloc_state *commit_state;
@@ -20,6 +24,7 @@ struct object_parser {
 };
 
 extern struct buffer_slab the_repository_buffer_slab;
+extern struct stat_validity the_repository_shallow_stat;
 extern struct alloc_state the_repository_blob_state;
 extern struct alloc_state the_repository_tree_state;
 extern struct alloc_state the_repository_commit_state;
@@ -27,6 +32,7 @@ extern struct alloc_state the_repository_tag_state;
 extern struct alloc_state the_repository_object_state;
 #define OBJECT_PARSER_INIT { NULL, 0, 0, &the_repository_buffer_slab, \
 	NULL, 0, 0, \
+	-1, &the_repository_shallow_stat, NULL, \
 	&the_repository_blob_state, \
 	&the_repository_tree_state, \
 	&the_repository_commit_state, \
diff --git a/repository.c b/repository.c
index 3ee47b4c5d..64fb6d8b34 100644
--- a/repository.c
+++ b/repository.c
@@ -185,6 +185,10 @@ int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
+	repo->parsed_objects.is_shallow = -1;
+	repo->parsed_objects.shallow_stat = xcalloc(1, sizeof(
+		*repo->parsed_objects.shallow_stat));
+
 	ALLOC_GROW(open_repos, open_repos_nr + 1, open_repos_alloc);
 	open_repos[open_repos_nr++] = repo;
 
diff --git a/shallow.c b/shallow.c
index 2849046477..64a4fcb57f 100644
--- a/shallow.c
+++ b/shallow.c
@@ -14,66 +14,65 @@
 #include "commit-slab.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "repository.h"
 
-static int is_shallow = -1;
-static struct stat_validity shallow_stat;
-static char *alternate_shallow_file;
+struct stat_validity the_repository_shallow_stat;
 
-void set_alternate_shallow_file_the_repository(const char *path, int override)
+void set_alternate_shallow_file(struct repository *r, const char *path, int override)
 {
-	if (is_shallow != -1)
+	if (r->parsed_objects.is_shallow != -1)
 		die("BUG: is_repository_shallow must not be called before set_alternate_shallow_file");
-	if (alternate_shallow_file && !override)
+	if (r->parsed_objects.alternate_shallow_file && !override)
 		return;
-	free(alternate_shallow_file);
-	alternate_shallow_file = xstrdup_or_null(path);
+	free(r->parsed_objects.alternate_shallow_file);
+	r->parsed_objects.alternate_shallow_file = xstrdup_or_null(path);
 }
 
-int register_shallow_the_repository(const struct object_id *oid)
+int register_shallow(struct repository *r, const struct object_id *oid)
 {
 	struct commit_graft *graft =
 		xmalloc(sizeof(struct commit_graft));
-	struct commit *commit = lookup_commit(the_repository, oid);
+	struct commit *commit = lookup_commit(r, oid);
 
 	oidcpy(&graft->oid, oid);
 	graft->nr_parent = -1;
 	if (commit && commit->object.parsed)
 		commit->parents = NULL;
-	return register_commit_graft(the_repository, graft, 0);
+	return register_commit_graft(r, graft, 0);
 }
 
-int is_repository_shallow_the_repository(void)
+int is_repository_shallow(struct repository *r)
 {
 	FILE *fp;
 	char buf[1024];
-	const char *path = alternate_shallow_file;
+	const char *path = r->parsed_objects.alternate_shallow_file;
 
-	if (is_shallow >= 0)
-		return is_shallow;
+	if (r->parsed_objects.is_shallow >= 0)
+		return r->parsed_objects.is_shallow;
 
 	if (!path)
-		path = git_path_shallow(the_repository);
+		path = git_path_shallow(r);
 	/*
 	 * fetch-pack sets '--shallow-file ""' as an indicator that no
 	 * shallow file should be used. We could just open it and it
 	 * will likely fail. But let's do an explicit check instead.
 	 */
 	if (!*path || (fp = fopen(path, "r")) == NULL) {
-		stat_validity_clear(&shallow_stat);
-		is_shallow = 0;
-		return is_shallow;
+		stat_validity_clear(r->parsed_objects.shallow_stat);
+		r->parsed_objects.is_shallow = 0;
+		return r->parsed_objects.is_shallow;
 	}
-	stat_validity_update(&shallow_stat, fileno(fp));
-	is_shallow = 1;
+	stat_validity_update(r->parsed_objects.shallow_stat, fileno(fp));
+	r->parsed_objects.is_shallow = 1;
 
 	while (fgets(buf, sizeof(buf), fp)) {
 		struct object_id oid;
 		if (get_oid_hex(buf, &oid))
 			die("bad shallow line: %s", buf);
-		register_shallow(the_repository, &oid);
+		register_shallow(r, &oid);
 	}
 	fclose(fp);
-	return is_shallow;
+	return r->parsed_objects.is_shallow;
 }
 
 struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
@@ -219,13 +218,12 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 	return result;
 }
 
-#define check_shallow_file_for_update(r) check_shallow_file_for_update_##r()
-static void check_shallow_file_for_update_the_repository(void)
+static void check_shallow_file_for_update(struct repository *r)
 {
-	if (is_shallow == -1)
+	if (r->parsed_objects.is_shallow == -1)
 		die("BUG: shallow must be initialized by now");
 
-	if (!stat_validity_check(&shallow_stat, git_path_shallow(the_repository)))
+	if (!stat_validity_check(r->parsed_objects.shallow_stat, git_path_shallow(the_repository)))
 		die("shallow file has changed since we read it");
 }
 
-- 
2.15.1.433.g936d1b9894.dirty

