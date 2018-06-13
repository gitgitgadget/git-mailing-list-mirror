Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2801F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936044AbeFMXGq (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:46 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:44300 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935953AbeFMXGb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:31 -0400
Received: by mail-qt0-f202.google.com with SMTP id n10-v6so3109330qtp.11
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=HY9qgH4FDJx8bW6pedEA3jOn+fPXUDnA/qttHIazhF4=;
        b=gXhEORH688198KOmhoDkHMmbMc44OC4eMgkfLDh/d1FY/9nqzgCLMRLZyfllKRdm2c
         HjZWqwH+NV+oGg1ozpH8wFgc7KuMzf3esTfgFnSKauw728TgGyUwPkJK296PoAAKkuo5
         vs9Lcu63HbiqKSfx7ssa/p3Pgf6p7+7xOitAsCRd82yCff5jLSA+QOGGVjN3NeBIeo/7
         foeKJJnkA956Mb5e6WCX2m+H6iHCJujjHEX4MULcI0PirnaphaEMYWhLdIZwGkZX98DT
         fZYG3vFJVhb8VO5enNgWZKAFDjDmJZ0kcuyD+Kfm41KX80x9BZjrg2XUiFaeoWzflusc
         3FAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=HY9qgH4FDJx8bW6pedEA3jOn+fPXUDnA/qttHIazhF4=;
        b=IMQ5WyaNjS017B/5BQM0Y37DkX2b7eaDVxo0CBKERT7k1Cu8QsAGUg5wS18CkX84vE
         PHRCRwCykFyBmuzVrEILUMKb0Uy7ZgSDzYMdvYFzwpVrKqh+nw50RW0VMoSTYvSw8e4l
         Lvsdt3eOqBqFT1KaTtjaIMLi6cUPlNwxBErFXg3oxerNlGWhbOkCJjEo6irNJo7cgW8T
         fO4j54uAKRAo5x+0idxk09DZ12Y0+X6mtAFT1/bK8z3+mrlLrKTGHmcFvTcmJDtVWIJE
         /bDKEl+A/m60G3BZrycpnu3U4p86RdgNv3znAUPLLKIHpymEY2w433VZSxc3bv6bEP4m
         Wyqw==
X-Gm-Message-State: APt69E1Yonnl94RjVNLZCHojOi/iWJVsZlvR2Y7WZylB1F+SP3Ng9gmL
        nBVk/vp/ZGoIzYl74o1qQWR/IZQsqIXRqXLUCJgoaa7xqLh5to/VPPw4Kro+bMaPte8Z288b2JQ
        dWu2xbpn6UnA2AkcG40Ke9b4G/y6wlUTGPyOwE2wlc1rovpyuH9ePjguBYLHY
X-Google-Smtp-Source: ADUXVKLRRdFWYsGgbcMVmFFjYz7LvqHgFHnyrLZsWMYRabVrVGMrjOeGn3L15r8recmtV35ZFaC8F0TY/fKO
MIME-Version: 1.0
X-Received: by 2002:a0c:b0b6:: with SMTP id o51-v6mr91668qvc.9.1528931190864;
 Wed, 13 Jun 2018 16:06:30 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:15 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-25-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 24/31] commit.c: migrate the commit buffer to the parsed
 object store
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 29 +++++++++++++++++++++++------
 commit.h |  4 ++++
 object.c |  5 +++++
 object.h |  4 ++++
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index fe3b6ff216f..e9b22268997 100644
--- a/commit.c
+++ b/commit.c
@@ -248,18 +248,32 @@ struct commit_buffer {
 	unsigned long size;
 };
 define_commit_slab(buffer_slab, struct commit_buffer);
-static struct buffer_slab buffer_slab = COMMIT_SLAB_INIT(1, buffer_slab);
+
+struct buffer_slab *allocate_commit_buffer_slab(void)
+{
+	struct buffer_slab *bs = xmalloc(sizeof(*bs));
+	init_buffer_slab(bs);
+	return bs;
+}
+
+void free_commit_buffer_slab(struct buffer_slab *bs)
+{
+	clear_buffer_slab(bs);
+	free(bs);
+}
 
 void set_commit_buffer_the_repository(struct commit *commit, void *buffer, unsigned long size)
 {
-	struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
+	struct commit_buffer *v = buffer_slab_at(
+		the_repository->parsed_objects->buffer_slab, commit);
 	v->buffer = buffer;
 	v->size = size;
 }
 
 const void *get_cached_commit_buffer_the_repository(const struct commit *commit, unsigned long *sizep)
 {
-	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
+	struct commit_buffer *v = buffer_slab_peek(
+		the_repository->parsed_objects->buffer_slab, commit);
 	if (!v) {
 		if (sizep)
 			*sizep = 0;
@@ -291,14 +305,16 @@ const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
 
 void unuse_commit_buffer(const struct commit *commit, const void *buffer)
 {
-	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
+	struct commit_buffer *v = buffer_slab_peek(
+		the_repository->parsed_objects->buffer_slab, commit);
 	if (!(v && v->buffer == buffer))
 		free((void *)buffer);
 }
 
 void free_commit_buffer(struct commit *commit)
 {
-	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
+	struct commit_buffer *v = buffer_slab_peek(
+		the_repository->parsed_objects->buffer_slab, commit);
 	if (v) {
 		FREE_AND_NULL(v->buffer);
 		v->size = 0;
@@ -318,7 +334,8 @@ void release_commit_memory(struct commit *c)
 
 const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 {
-	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
+	struct commit_buffer *v = buffer_slab_peek(
+		the_repository->parsed_objects->buffer_slab, commit);
 	void *ret;
 
 	if (!v) {
diff --git a/commit.h b/commit.h
index 66aabb80068..a417f99ad4f 100644
--- a/commit.h
+++ b/commit.h
@@ -79,6 +79,10 @@ static inline int parse_commit(struct commit *item)
 }
 void parse_commit_or_die(struct commit *item);
 
+struct buffer_slab;
+struct buffer_slab *allocate_commit_buffer_slab(void);
+void free_commit_buffer_slab(struct buffer_slab *bs);
+
 /*
  * Associate an object buffer with the commit. The ownership of the
  * memory is handed over to the commit, and must be free()-able.
diff --git a/object.c b/object.c
index c1c1cbc1f53..7a7b078e4d0 100644
--- a/object.c
+++ b/object.c
@@ -467,6 +467,8 @@ struct parsed_object_pool *parsed_object_pool_new(void)
 	o->is_shallow = -1;
 	o->shallow_stat = xcalloc(1, sizeof(*o->shallow_stat));
 
+	o->buffer_slab = allocate_commit_buffer_slab();
+
 	return o;
 }
 
@@ -538,6 +540,9 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
 	FREE_AND_NULL(o->obj_hash);
 	o->obj_hash_size = 0;
 
+	free_commit_buffer_slab(o->buffer_slab);
+	o->buffer_slab = NULL;
+
 	clear_alloc_state(o->blob_state);
 	clear_alloc_state(o->tree_state);
 	clear_alloc_state(o->commit_state);
diff --git a/object.h b/object.h
index 66e0b7b93dc..876480c933c 100644
--- a/object.h
+++ b/object.h
@@ -1,6 +1,8 @@
 #ifndef OBJECT_H
 #define OBJECT_H
 
+struct buffer_slab;
+
 struct parsed_object_pool {
 	struct object **obj_hash;
 	int nr_objs, obj_hash_size;
@@ -22,6 +24,8 @@ struct parsed_object_pool {
 	char *alternate_shallow_file;
 
 	int commit_graft_prepared;
+
+	struct buffer_slab *buffer_slab;
 };
 
 struct parsed_object_pool *parsed_object_pool_new(void);
-- 
2.18.0.rc1.244.gcf134e6275-goog

