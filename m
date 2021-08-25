Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3098C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE7961165
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbhHYCXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 22:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbhHYCXP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 22:23:15 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA17C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so3122840pjw.2
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qK0K62voAt5415f3QcetEjG6uyZTTo2UZTa/IL+Gmnc=;
        b=a0/p1jdee7S4LkDMAp0AZOHqxRYhjEs6oeZzYFktCj3IfbyFtjBS3kTrGRknUsXqcw
         9B9h0w8DuDlDK5UakRZZ5xSN6ZBWDhpGhj6RaBwLYkmrt4FXLF7idZasBKjDxPJzq3EP
         uk3kvIhYnbZB4BuCzYsIH1RVln3rL9EnYJNdhxI51fCbmJQyHPwmA2x33+46RO17TdW7
         34+2NMU+DsVjPW8nmmKGiwP1WE74fy9YqWW6Y7CLmUR1IeKJV2HtN6K9g9VFnGfV3zhx
         cG6BFk4TqpVApo16Eyjir3XFkiZ4B8UqopI3zmd4lkh+MujjXhgedGoXx0pI0ZGQlUsC
         X69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qK0K62voAt5415f3QcetEjG6uyZTTo2UZTa/IL+Gmnc=;
        b=WXjjGldmJ4NT5qoHFNIuQzd13lZgs/5ujzhGDCWQ5BlyU6F+MweYRh9z2v1BqFCkgu
         wMdrMhnt1d0TLZ1F51bmCdZ+X1IogYxQOVsIeTgv/9N4fxcWQkOtg8ltdsGI0oZucyss
         0EBMUtYVA0DZUzd2ipuSLS6JUp6h4LbnltOJcG6Gd/oGkuPkqggoKFKwWE5f6TmUvtPM
         qvvWuL0+d2tFShxoc5fMiFTz32YJw9o1gpFG3AlzailVFdONgnhtTU6qGcCOe0u0o8vL
         cbKSpJ2z/SM0zrvkmYSPikA1080RMCGGCURZ8FPDsIa9Fq93khIdCzxPpDKL+3RpUDd0
         GwPA==
X-Gm-Message-State: AOAM532rMu2lteyPsXgQCn6D7FdAn1LFclvBkQTx6IR32w7RSV8vXEMf
        i8cacg6zIPPvW9kQdzd1gkJWd6VczYHfk+Wx
X-Google-Smtp-Source: ABdhPJyeZro+ucbzJZ5D0tTBq790cZJb0yPohodCs9SQMBPSux3ShZ+DKV9mXn3AphDQdNgJlMIeHg==
X-Received: by 2002:a17:90a:c89:: with SMTP id v9mr7986150pja.175.1629858148589;
        Tue, 24 Aug 2021 19:22:28 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id e14sm3628683pjg.40.2021.08.24.19.22.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 19:22:28 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com, dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v5 08/14] Add new parameter "carry_data" for "show_commit function
Date:   Wed, 25 Aug 2021 10:21:52 +0800
Message-Id: <19f767038486e53a3d12e38aea3bba51e6541e7d.1629805396.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.gec51e24953
In-Reply-To: <cover.1629805395.git.dyroneteng@gmail.com>
References: <cover.1629805395.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/describe.c     | 4 ++--
 builtin/pack-objects.c | 6 +++---
 builtin/rev-list.c     | 4 ++--
 bundle.c               | 4 ++--
 list-objects.c         | 2 +-
 list-objects.h         | 2 +-
 pack-bitmap.c          | 6 +++---
 reachable.c            | 2 +-
 shallow.c              | 4 ++--
 9 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 045da79b5c..8fb99bbda5 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -479,9 +479,9 @@ struct process_commit_data {
 	struct rev_info *revs;
 };
 
-static void process_commit(struct commit *commit, void *data)
+static void process_commit(struct commit *commit, void *show_data, void *carry_data)
 {
-	struct process_commit_data *pcd = data;
+	struct process_commit_data *pcd = show_data;
 	pcd->current_commit = commit->object.oid;
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4ff12ec525..d38b24e375 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3080,7 +3080,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 	return 0;
 }
 
-static void show_commit_pack_hint(struct commit *commit, void *_data)
+static void show_commit_pack_hint(struct commit *commit, void *show_data, void *carry_data)
 {
 	/* nothing to do; commits don't have a namehash */
 }
@@ -3258,7 +3258,7 @@ static void read_object_list_from_stdin(void)
 /* Remember to update object flag allocation in object.h */
 #define OBJECT_ADDED (1u<<20)
 
-static void show_commit(struct commit *commit, void *data)
+static void show_commit(struct commit *commit, void *show_data, void *carry_data)
 {
 	add_object_entry(&commit->object.oid, OBJ_COMMIT, NULL, 0, NULL);
 	commit->object.flags |= OBJECT_ADDED;
@@ -3572,7 +3572,7 @@ static void record_recent_object(struct object *obj,
 	oid_array_append(&recent_objects, &obj->oid);
 }
 
-static void record_recent_commit(struct commit *commit, void *data)
+static void record_recent_commit(struct commit *commit, void *show_data, void *carry_data)
 {
 	oid_array_append(&recent_objects, &commit->object.oid);
 }
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 1cad33d9e8..b5e7ba6e83 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -94,9 +94,9 @@ static off_t get_object_disk_usage(struct object *obj)
 }
 
 static void finish_commit(struct commit *commit);
-static void show_commit(struct commit *commit, void *data)
+static void show_commit(struct commit *commit, void *show_data, void *carry_data)
 {
-	struct rev_list_info *info = data;
+	struct rev_list_info *info = show_data;
 	struct rev_info *revs = info->revs;
 
 	display_progress(progress, ++progress_counter);
diff --git a/bundle.c b/bundle.c
index 693d619551..143e45ce0c 100644
--- a/bundle.c
+++ b/bundle.c
@@ -437,9 +437,9 @@ struct bundle_prerequisites_info {
 	int fd;
 };
 
-static void write_bundle_prerequisites(struct commit *commit, void *data)
+static void write_bundle_prerequisites(struct commit *commit, void *show_data, void *carry_data)
 {
-	struct bundle_prerequisites_info *bpi = data;
+	struct bundle_prerequisites_info *bpi = show_data;
 	struct object *object;
 	struct pretty_print_context ctx = { 0 };
 	struct strbuf buf = STRBUF_INIT;
diff --git a/list-objects.c b/list-objects.c
index 49f177cb56..2e53a01458 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -384,7 +384,7 @@ static void do_traverse(struct traversal_context *ctx)
 			die(_("unable to load root tree for commit %s"),
 			      oid_to_hex(&commit->object.oid));
 		}
-		ctx->show_commit(commit, ctx->show_data);
+		ctx->show_commit(commit, ctx->show_data, NULL);
 
 		if (ctx->revs->tree_blobs_in_commit_order)
 			/*
diff --git a/list-objects.h b/list-objects.h
index ab946d34db..838b8c78c9 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -5,7 +5,7 @@ struct commit;
 struct object;
 struct rev_info;
 
-typedef void (*show_commit_fn)(struct commit *, void *);
+typedef void (*show_commit_fn)(struct commit *, void *, void *);
 typedef void (*show_object_fn)(struct object *, const char *, void *, void *);
 void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 516eb235da..81cf14ef8e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -473,7 +473,7 @@ static void show_object(struct object *object, const char *name, void *show_data
 	bitmap_set(data->base, bitmap_pos);
 }
 
-static void show_commit(struct commit *commit, void *data)
+static void show_commit(struct commit *commit, void *show_data, void *carry_data)
 {
 }
 
@@ -1281,9 +1281,9 @@ static void test_show_object(struct object *object, const char *name,
 	display_progress(tdata->prg, ++tdata->seen);
 }
 
-static void test_show_commit(struct commit *commit, void *data)
+static void test_show_commit(struct commit *commit, void *show_data, void *carry_data)
 {
-	struct bitmap_test_data *tdata = data;
+	struct bitmap_test_data *tdata = show_data;
 	int bitmap_pos;
 
 	bitmap_pos = bitmap_position(tdata->bitmap_git,
diff --git a/reachable.c b/reachable.c
index 521b39edef..d38c31ae45 100644
--- a/reachable.c
+++ b/reachable.c
@@ -52,7 +52,7 @@ static void mark_object(struct object *obj, const char *name, void *show_data, v
 	update_progress(show_data);
 }
 
-static void mark_commit(struct commit *c, void *show_data)
+static void mark_commit(struct commit *c, void *show_data, void *carry_data)
 {
 	mark_object(&c->object, NULL, show_data, NULL);
 }
diff --git a/shallow.c b/shallow.c
index 9ed18eb884..33f878565c 100644
--- a/shallow.c
+++ b/shallow.c
@@ -185,9 +185,9 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 	return result;
 }
 
-static void show_commit(struct commit *commit, void *data)
+static void show_commit(struct commit *commit, void *show_data, void *carry_data)
 {
-	commit_list_insert(commit, data);
+	commit_list_insert(commit, show_data);
 }
 
 /*
-- 
2.31.1.456.gec51e24953

