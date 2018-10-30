Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A119A1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeJaHEn (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:43 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:45197 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbeJaHEm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:42 -0400
Received: by mail-vk1-f202.google.com with SMTP id 80so6289264vki.12
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=suUvYMkFhHxpFyjcRNjnXkTTU2MrTIKqbpAuOttG/dA=;
        b=kDFXR3zLGuR8KbgU0iaTq5SM2ffTuLddpqSvn5ct1ZUWLhmoZ6tMW7f/4lhbyIm5ZP
         zkh7gEb2vv9FmuQIsB736OOzLtSQ338Bwle5VUUaxowXUHGQM3329D831zvbSJsw+98n
         ueRzF+VaRGYVcVVm16nGUukF3mS9WnqN1TahERxGT54i1KzwBHIzO1g6s2F+rmASdEsf
         Ok7pKmP3Z7pssXutJIaCG3ZEVRNUY7FShZKod3oC4XFidl0hSO0XaRBWBjUfpP5m200r
         qMhUJu0ifsc9tu4keTzv+Bnn3aWyv5u4W9IOZ2qvUOhu18GJEhOP52vO771XC+3TAQrW
         EJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=suUvYMkFhHxpFyjcRNjnXkTTU2MrTIKqbpAuOttG/dA=;
        b=P1wppIGcv9YQYq5cCKcjIX3Yt4GRRnf/ts8B8VAjg5GNKK/pv6tILmUJKGtMXiPq5e
         OCYjXqqtXN3vhrbruaBDcEEXgW7Erz5969dO8q1PGtTJiPpvCklj+bMMOra4jAb9WKfR
         JtH/pFutbO0DiB4z/5xA+Z3rAEyGY3hwI7g+dwEk9PejqZdQbfo4eReLrsIlYAU93mZ+
         UNiLa3XYT2UmCJ1AMc58LrlTvqemcye+T3oZCA72bwaHy9f4uNZdCR/iWSzTLzjOV79b
         3sRYY21AHi2lYVQSJ0MRDpxiLibEQlFW3649v668ql91/rtz1kIeOEik7cW5/2RQY22d
         KDwg==
X-Gm-Message-State: AGRZ1gKu18PpDuY8yHT18cPMXzPu+jrB9twSSB6I4D532ixOPXCuB6ox
        k3O54clCi9sW+INxZ44HSq/Kqxg8R1/ntsw6ozOUpCltsmL93aF+26cN4xCLoAD2KlfOTpAF2L0
        zqrSlx9BYcjetwrIXCXt7tqYNAdL1lh/k8C0O6TRTjxz0Ys85VyH1mcsyTdYJ
X-Google-Smtp-Source: AJdET5dEPrhYDcYd84pEqmVH2/cqRcMb6Gmiu2XiXPxzkRYznwubQRgNYUzxdyVqWxP8HMxSTU5ccujSnkdV
X-Received: by 2002:a1f:8ac4:: with SMTP id m187mr510857vkd.3.1540937366948;
 Tue, 30 Oct 2018 15:09:26 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:08:15 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-23-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 22/24] commit: make free_commit_buffer and release_commit_memory
 repository agnostic
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the object pool to free_commit_buffer and release_commit_memory,
such that we can eliminate access to 'the_repository'.

Also remove the TODO in release_commit_memory, as commit->util was
removed in 9d2c97016f (commit.h: delete 'util' field in struct commit,
2018-05-19)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fsck.c     | 3 ++-
 builtin/log.c      | 6 ++++--
 builtin/rev-list.c | 3 ++-
 commit.c           | 9 ++++-----
 commit.h           | 4 ++--
 object.c           | 2 +-
 6 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 06eb421720..c476ac6983 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -382,7 +382,8 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 	if (obj->type == OBJ_TREE)
 		free_tree_buffer((struct tree *)obj);
 	if (obj->type == OBJ_COMMIT)
-		free_commit_buffer((struct commit *)obj);
+		free_commit_buffer(the_repository->parsed_objects,
+				   (struct commit *)obj);
 	return err;
 }
 
diff --git a/builtin/log.c b/builtin/log.c
index 061d4fd864..64c2649c7c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -395,7 +395,8 @@ static int cmd_log_walk(struct rev_info *rev)
 			 * We may show a given commit multiple times when
 			 * walking the reflogs.
 			 */
-			free_commit_buffer(commit);
+			free_commit_buffer(the_repository->parsed_objects,
+					   commit);
 			free_commit_list(commit->parents);
 			commit->parents = NULL;
 		}
@@ -1922,7 +1923,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		    open_next_file(rev.numbered_files ? NULL : commit, NULL, &rev, quiet))
 			die(_("Failed to create output files"));
 		shown = log_tree_commit(&rev, commit);
-		free_commit_buffer(commit);
+		free_commit_buffer(the_repository->parsed_objects,
+				   commit);
 
 		/* We put one extra blank line between formatted
 		 * patches and this flag is used by log-tree code
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 5064d08e1b..a8867f0c4b 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -197,7 +197,8 @@ static void finish_commit(struct commit *commit, void *data)
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
 	}
-	free_commit_buffer(commit);
+	free_commit_buffer(the_repository->parsed_objects,
+			   commit);
 }
 
 static inline void finish_object__ma(struct object *obj)
diff --git a/commit.c b/commit.c
index 7d2f3a9a93..4fe74aa4bc 100644
--- a/commit.c
+++ b/commit.c
@@ -328,10 +328,10 @@ void repo_unuse_commit_buffer(struct repository *r,
 		free((void *)buffer);
 }
 
-void free_commit_buffer(struct commit *commit)
+void free_commit_buffer(struct parsed_object_pool *pool, struct commit *commit)
 {
 	struct commit_buffer *v = buffer_slab_peek(
-		the_repository->parsed_objects->buffer_slab, commit);
+		pool->buffer_slab, commit);
 	if (v) {
 		FREE_AND_NULL(v->buffer);
 		v->size = 0;
@@ -354,13 +354,12 @@ struct object_id *get_commit_tree_oid(const struct commit *commit)
 	return &get_commit_tree(commit)->object.oid;
 }
 
-void release_commit_memory(struct commit *c)
+void release_commit_memory(struct parsed_object_pool *pool, struct commit *c)
 {
 	c->maybe_tree = NULL;
 	c->index = 0;
-	free_commit_buffer(c);
+	free_commit_buffer(pool, c);
 	free_commit_list(c->parents);
-	/* TODO: what about commit->util? */
 
 	c->object.parsed = 0;
 }
diff --git a/commit.h b/commit.h
index 2e6b799b26..d2779a23f6 100644
--- a/commit.h
+++ b/commit.h
@@ -140,7 +140,7 @@ void repo_unuse_commit_buffer(struct repository *r,
 /*
  * Free any cached object buffer associated with the commit.
  */
-void free_commit_buffer(struct commit *);
+void free_commit_buffer(struct parsed_object_pool *pool, struct commit *);
 
 struct tree *get_commit_tree(const struct commit *);
 struct object_id *get_commit_tree_oid(const struct commit *);
@@ -149,7 +149,7 @@ struct object_id *get_commit_tree_oid(const struct commit *);
  * Release memory related to a commit, including the parent list and
  * any cached object buffer.
  */
-void release_commit_memory(struct commit *c);
+void release_commit_memory(struct parsed_object_pool *pool, struct commit *c);
 
 /*
  * Disassociate any cached object buffer from the commit, but do not free it.
diff --git a/object.c b/object.c
index 003f870484..c4170d2d0c 100644
--- a/object.c
+++ b/object.c
@@ -540,7 +540,7 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
 		if (obj->type == OBJ_TREE)
 			free_tree_buffer((struct tree*)obj);
 		else if (obj->type == OBJ_COMMIT)
-			release_commit_memory((struct commit*)obj);
+			release_commit_memory(o, (struct commit*)obj);
 		else if (obj->type == OBJ_TAG)
 			release_tag_memory((struct tag*)obj);
 	}
-- 
2.19.1.930.g4563a0d9d0-goog

