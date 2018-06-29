Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A0461F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030377AbeF2BXd (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:33 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:40842 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030241AbeF2BXa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:30 -0400
Received: by mail-it0-f74.google.com with SMTP id m131-v6so441163itm.5
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=oyFvhn4O3+YMqWwC2NiwzgxxF+kDnUnCmrGdAl1HO1s=;
        b=gsjAOLK1P5T0V9QR51EJIxSsBcj5Hz22cNhyJ0eOR9hQiesozMxNZegOoMHwSNeD1f
         p+1DlbmoiEBnIHAD0i2RZT6gtWWmAxyOURpgoZ8BmbZ+AlaMx5WHbBkDmN/mi2MHOb5t
         8AqBdH0SNBsfpUzHwyRa8//ziEuIrvyWkioe/Td5Xnn8ITYIdsgyI3x4/P7w60Lt6A8W
         6cK/4VI3b3bd5y3SYuP/5IJ6zEWYvOqOAEdsU6gQhlQ0rsMWHNl9DjAAB7BIXdbXlgIL
         Zm8oqnyXbOhrevZdyw3g9T6i//I3ATsDkASejMFuX9IHnJ53qz/SCWNagzWyst/utdCK
         jswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=oyFvhn4O3+YMqWwC2NiwzgxxF+kDnUnCmrGdAl1HO1s=;
        b=eYwPLIkJAZK4SzGLDg6A+X+6nWuS8GDtzxJ8lqKaIDfbXHap83uneUsAwhG/3/FfNh
         60FPFdexf4b0o0cbZE1oZJZ1CA9fEGU8C0d3DxhOz239c5CWPBKWoxjaVUrwJRS6Lhow
         C9hbVU8PWEhoXD+c9Kr0wEcxDRjU+gwRGoVh6hxsn8OIbn0mZ/8p8PRUKsQMlFOH7Piv
         nwshRrgDEMXxp5rrJNM6V8TFCTkmjwVJxXDt//Y6in5bcKX4tS0IeiFRtOm64JkReoGy
         C3akdgwbKM9p0/61O13ZBsv+XePbZ/5Kc/h1B9/YAyoZu3ZIklXuMZZGXeFrkkNkWUJ4
         zY/w==
X-Gm-Message-State: APt69E3Wx9P3h4K93LUXFzCSjXvZ0os3ZyPh1XwN61zaILMdYYmCfZkY
        x0oI6NFI2RJ75PXGALtVRc1MPZzkvBuekFCJ70q8+SGhgGTpffqTXl3Sj3UGeVFX4k4/scSeWMV
        FUHTtAVTES4Z2AEbwTO5UeWWJzOQ8qqXQ+tRULbbXocK9c/PcpfqoPgF2LCyn
X-Google-Smtp-Source: AAOMgpe8RR5yo7H2qDWHmvDWLMV6ijbOUflSg0ROy57vstlBrJPhNyk08+imAfst6H/iNXDsm1CTOXItvSGT
MIME-Version: 1.0
X-Received: by 2002:a24:74d0:: with SMTP id o199-v6mr79704itc.11.1530235410062;
 Thu, 28 Jun 2018 18:23:30 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:15 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-26-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 25/32] commit.c: migrate the commit buffer to the parsed
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
index 41d23352098..1baac77861f 100644
--- a/commit.c
+++ b/commit.c
@@ -261,18 +261,32 @@ struct commit_buffer {
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
@@ -304,14 +318,16 @@ const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
 
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
@@ -347,7 +363,8 @@ void release_commit_memory(struct commit *c)
 
 const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 {
-	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
+	struct commit_buffer *v = buffer_slab_peek(
+		the_repository->parsed_objects->buffer_slab, commit);
 	void *ret;
 
 	if (!v) {
diff --git a/commit.h b/commit.h
index e9cb5aaaae9..bea5e015b28 100644
--- a/commit.h
+++ b/commit.h
@@ -89,6 +89,10 @@ static inline int parse_commit(struct commit *item)
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
index 9d74de95f5b..9d588448192 100644
--- a/object.c
+++ b/object.c
@@ -467,6 +467,8 @@ struct parsed_object_pool *parsed_object_pool_new(void)
 	o->is_shallow = -1;
 	o->shallow_stat = xcalloc(1, sizeof(*o->shallow_stat));
 
+	o->buffer_slab = allocate_commit_buffer_slab();
+
 	return o;
 }
 
@@ -541,6 +543,9 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
 	FREE_AND_NULL(o->obj_hash);
 	o->obj_hash_size = 0;
 
+	free_commit_buffer_slab(o->buffer_slab);
+	o->buffer_slab = NULL;
+
 	clear_alloc_state(o->blob_state);
 	clear_alloc_state(o->tree_state);
 	clear_alloc_state(o->commit_state);
diff --git a/object.h b/object.h
index 0d7d74129b6..f54a892bd10 100644
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
2.18.0.399.gad0ab374a1-goog

