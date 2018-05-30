Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F1B11F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968598AbeE3Aty (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:49:54 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40391 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968521AbeE3AtD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:49:03 -0400
Received: by mail-pg0-f67.google.com with SMTP id l2-v6so7319247pgc.7
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y5LzRthSLnPaCalyznXA4VSo1nz1xhc306vS1Cl0+dc=;
        b=MYM8sSc1fRPlxX6joY19JmTalTQdf+M+ax7hHT3x9aCXL/6/jRMcmXDO6Zntcbn+W2
         U14hyStOO2Kth/rZcCk/2uYWKZPz5Lm7kdqWjTYioaZO1Ny91vY8bj2CnRbL/359F2T+
         t1WI3bHQNGFq4wt5/exZ4n6l6fXX3DTiMP7lQuO5cYnv4O6S73rKdscVYgsqv0CLkQFC
         wWH6R+xfovv87jXye4QIx7V0iXtuTd5bMSyx4bRttHOZno21z71GMl+vPxs/KbDyJ67I
         45jjxsL+EQzMgVxf3n1/BOwUw3WQCIpScl0kMJCyjxRZw1SnDBCmF/Gqim09MprTEEI4
         39tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y5LzRthSLnPaCalyznXA4VSo1nz1xhc306vS1Cl0+dc=;
        b=mZEtz/d71erQoMGKTGNrsTM/Y3UpymngOInux3Us9il03CoTcm5wS/L6K19gJ4rcg7
         CVS0mUcJCXXpTPTjZui00PRrifs3d3h0gn0/pCFlv77YmExGt5CMZWAk5OU95fuABcr4
         QiCMoW7bVuTtWpxl2kQy/MsRRvenxXydER4Sb0LTTeg2ME8L0P8ocnjeQN9ZWJVZCifZ
         /aFc1QHaNjcwT57mwHFJn5kaYl6eKEuNdmj0v579cH0zoUJlgo7SzodiIA8gRUYt1Yub
         g9C3Fwk8nQcLYrmGnARuRM7WeSmUu7d0XhlIe3Vk5+L8XfHRVjbcg40gpK4xUaweXLeP
         eY6w==
X-Gm-Message-State: ALKqPwdU8O4zshDYpSNDRGQdmvwNLP3UA6WZmCrdw1iSbqcXyecJGu+h
        Zqfd5Zrn9a+i3Imrh/uZ3xVvURB8bUk=
X-Google-Smtp-Source: ADUXVKLsXP8phCK0r3DuTYGetGASg0WJFBNYH2UThpYQwi+fsQW1Lr6lYFSyGiv3k0eJKNxAgM1cjg==
X-Received: by 2002:a63:b506:: with SMTP id y6-v6mr477564pge.213.1527641341853;
        Tue, 29 May 2018 17:49:01 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v16-v6sm100765825pfk.164.2018.05.29.17.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:49:00 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 28/35] commit.c: migrate the commit buffer to the parsed object store
Date:   Tue, 29 May 2018 17:48:03 -0700
Message-Id: <20180530004810.30076-29-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 29 +++++++++++++++++++++++------
 commit.h |  2 ++
 object.c |  5 +++++
 object.h |  2 ++
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index fd31c453fdc..45dbf6f1453 100644
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
index 536fa03955f..df199498bfb 100644
--- a/commit.h
+++ b/commit.h
@@ -81,6 +81,8 @@ static inline int parse_commit_the_repository(struct commit *item)
 }
 void parse_commit_or_die(struct commit *item);
 
+struct buffer_slab *allocate_commit_buffer_slab(void);
+void free_commit_buffer_slab(struct buffer_slab *bs);
 /*
  * Associate an object buffer with the commit. The ownership of the
  * memory is handed over to the commit, and must be free()-able.
diff --git a/object.c b/object.c
index 03180f84b2a..ce29601c6c2 100644
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
index 6adc8323ca4..45e22282101 100644
--- a/object.h
+++ b/object.h
@@ -22,6 +22,8 @@ struct parsed_object_pool {
 	char *alternate_shallow_file;
 
 	int commit_graft_prepared;
+
+	struct buffer_slab *buffer_slab;
 };
 
 struct parsed_object_pool *parsed_object_pool_new(void);
-- 
2.17.0.582.gccdcbd54c44.dirty

