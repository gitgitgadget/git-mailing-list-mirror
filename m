Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5794A1F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeEQWwj (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:52:39 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35770 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbeEQWwf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:35 -0400
Received: by mail-pl0-f67.google.com with SMTP id i5-v6so3402701plt.2
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TS1Ic7gWAH92dgFYfGV/F8squFgJfZ14sbLpCRuCryY=;
        b=BUur/1GO35er4eGU+NCy3xkSk0rag8dGE5zOAgH3FuwmlQWGFosWt7xPJ1l+2cmTSA
         O1VlqYt6EqPfZGZ7xCL1bPwFgzUHOVkIseqJGU4RfxGH3gc5YHojOj0LRXCoqLvzGI0O
         vdj8QQJVyWYBkvM8dFSTCa3IsA5kAfeZiJ/XtgAB1F3yolTFUKcM4iHf18OSYiW1LrvR
         dljipnzkXPgYw2zws9BZyz3XP88mbLxC1G9lMv0Yyyvm3CDWFCi4y7C5TZSPmhEL1Sim
         TXR5VcO5fuO2nBqmo9p5rCQHtl4yHv7L//DbW3OZ97WsDAB0cdiafrgoe/ERR7mZJmQ7
         gwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TS1Ic7gWAH92dgFYfGV/F8squFgJfZ14sbLpCRuCryY=;
        b=Co0vEnx2ODjScd5S3rOSKKJMIgj42azHH0Dfx0Gql4m5IFo12oowoTqF5MvoUAcvYo
         e1d0SA3931OwNnCY9+g1f1f3h6Wejx/9U3Acc1We0LhWpmG8iLGUNplbPe71NhohYIdp
         U8/pPsnDK7GLaMQeW4aKGRnzUbut7v0XTTG/ES1yeKA7N9LKSxYy9N+nycfp9ktR7eCb
         9ZaNAULCAT6hFe1YB370Cq36BpZ4X11GdgiIAgFiHSPOQgrOeeXGBWOhVMU/aZl2Ceh4
         ECh4/Zj9LggywUZoovTKIRc4Zziw6CKX0LBWKrcUR0IOEwdXuNZmrSJ19Lm16+5ev9vt
         vuug==
X-Gm-Message-State: ALKqPwc/eitbkB2HIlCqQ1s8lPkMBIe8sfsE6/OiwzpmsYTpKYKcZiQK
        QTUiCXlTrZju+r3RzvaLA9l1wA==
X-Google-Smtp-Source: AB8JxZrBTABlWZvV+t/e3ZvjG/0yaXGxRfPaZor1Aq0ChLj6t+mVM264EdRLuJmyCK92jCjQzBwptA==
X-Received: by 2002:a17:902:622:: with SMTP id 31-v6mr6925806plg.135.1526597554845;
        Thu, 17 May 2018 15:52:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id j1-v6sm9815426pfh.95.2018.05.17.15.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Subject: [PATCH 17/19] shallow: migrate shallow information into the object parser
Date:   Thu, 17 May 2018 15:51:52 -0700
Message-Id: <20180517225154.9200-18-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517225154.9200-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
 <20180517225154.9200-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We need to convert the shallow functions all at the same time
as we move the data structures they operate on into the repository.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.h  |  9 +++------
 object.c  |  3 +++
 object.h  |  4 ++++
 shallow.c | 50 +++++++++++++++++++++++---------------------------
 4 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/commit.h b/commit.h
index d04bbed81cf..45114a95b25 100644
--- a/commit.h
+++ b/commit.h
@@ -190,18 +190,15 @@ extern struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n,
 
 struct oid_array;
 struct ref;
-#define register_shallow(r, o) register_shallow_##r(o);
-extern int register_shallow_the_repository(const struct object_id *oid);
+extern int register_shallow(struct repository *r, const struct object_id *oid);
 extern int unregister_shallow(const struct object_id *oid);
 extern int for_each_commit_graft(each_commit_graft_fn, void *);
-#define is_repository_shallow(r) is_repository_shallow_##r()
-extern int is_repository_shallow_the_repository(void);
+extern int is_repository_shallow(struct repository *r);
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
diff --git a/object.c b/object.c
index 0116ed6529a..30b8a721cf6 100644
--- a/object.c
+++ b/object.c
@@ -464,6 +464,9 @@ struct parsed_object_pool *parsed_object_pool_new(void)
 	o->tag_state = allocate_alloc_state();
 	o->object_state = allocate_alloc_state();
 
+	o->is_shallow = -1;
+	o->shallow_stat = xcalloc(1, sizeof(*o->shallow_stat));
+
 	return o;
 }
 
diff --git a/object.h b/object.h
index ec908f9bcc1..a314331acaf 100644
--- a/object.h
+++ b/object.h
@@ -16,6 +16,10 @@ struct parsed_object_pool {
 	/* parent substitutions from .git/info/grafts and .git/shallow */
 	struct commit_graft **grafts;
 	int grafts_alloc, grafts_nr;
+
+	int is_shallow;
+	struct stat_validity *shallow_stat;
+	char *alternate_shallow_file;
 };
 
 struct parsed_object_pool *parsed_object_pool_new(void);
diff --git a/shallow.c b/shallow.c
index a0e338459f9..9f6ee351319 100644
--- a/shallow.c
+++ b/shallow.c
@@ -14,22 +14,19 @@
 #include "commit-slab.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "repository.h"
 
-static int is_shallow = -1;
-static struct stat_validity shallow_stat;
-static char *alternate_shallow_file;
-
-void set_alternate_shallow_file_the_repository(const char *path, int override)
+void set_alternate_shallow_file(struct repository *r, const char *path, int override)
 {
-	if (is_shallow != -1)
+	if (r->parsed_objects->is_shallow != -1)
 		die("BUG: is_repository_shallow must not be called before set_alternate_shallow_file");
-	if (alternate_shallow_file && !override)
+	if (r->parsed_objects->alternate_shallow_file && !override)
 		return;
-	free(alternate_shallow_file);
-	alternate_shallow_file = xstrdup_or_null(path);
+	free(r->parsed_objects->alternate_shallow_file);
+	r->parsed_objects->alternate_shallow_file = xstrdup_or_null(path);
 }
 
-int register_shallow_the_repository(const struct object_id *oid)
+int register_shallow(struct repository *r, const struct object_id *oid)
 {
 	struct commit_graft *graft =
 		xmalloc(sizeof(struct commit_graft));
@@ -39,41 +36,41 @@ int register_shallow_the_repository(const struct object_id *oid)
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
+	const char *path = r->parsed_objects->alternate_shallow_file;
 
-	if (is_shallow >= 0)
-		return is_shallow;
+	if (r->parsed_objects->is_shallow >= 0)
+		return r->parsed_objects->is_shallow;
 
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
+		stat_validity_clear(r->parsed_objects->shallow_stat);
+		r->parsed_objects->is_shallow = 0;
+		return r->parsed_objects->is_shallow;
 	}
-	stat_validity_update(&shallow_stat, fileno(fp));
-	is_shallow = 1;
+	stat_validity_update(r->parsed_objects->shallow_stat, fileno(fp));
+	r->parsed_objects->is_shallow = 1;
 
 	while (fgets(buf, sizeof(buf), fp)) {
 		struct object_id oid;
 		if (get_oid_hex(buf, &oid))
 			die("bad shallow line: %s", buf);
-		register_shallow(the_repository, &oid);
+		register_shallow(r, &oid);
 	}
 	fclose(fp);
-	return is_shallow;
+	return r->parsed_objects->is_shallow;
 }
 
 struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
@@ -217,13 +214,12 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 	return result;
 }
 
-#define check_shallow_file_for_update(r) check_shallow_file_for_update_##r()
-static void check_shallow_file_for_update_the_repository(void)
+static void check_shallow_file_for_update(struct repository *r)
 {
-	if (is_shallow == -1)
+	if (r->parsed_objects->is_shallow == -1)
 		die("BUG: shallow must be initialized by now");
 
-	if (!stat_validity_check(&shallow_stat, git_path_shallow(the_repository)))
+	if (!stat_validity_check(r->parsed_objects->shallow_stat, git_path_shallow(the_repository)))
 		die("shallow file has changed since we read it");
 }
 
-- 
2.17.0.582.gccdcbd54c44.dirty

