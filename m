Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521FEC32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2153B22522
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="UqhsC6AE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgAPCku (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:40:50 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40120 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbgAPCku (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 21:40:50 -0500
Received: by mail-qk1-f195.google.com with SMTP id c17so17791723qkg.7
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 18:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6LYcJBHmXYf9p+4kb9IBV0jKLhs5G/9NZ/Y/r+BqrnI=;
        b=UqhsC6AEkqimuEXcOdRPc6pySfyiy2sRbUNWZnJB6RFtd5rqii31wflNpsawbJSFIF
         FfpX92Nx5CUmU66ZsIKPDn6AjX24NOTP8MaKl6ExDc1TcHkii+4pVu2dJXbdP9pRif4s
         koY2w3+giBB2cE9JiueYXiMEJP9/2c2mih/PpzuB+DZFx63dGt9o1LU+R3tpLwLbnXCe
         aBAdvRKAQvJRHlC6BEGYmYjZ52yp/405ss6R8Jox3WIfH+KjIu8GAZlbtzKGfr81oRN/
         j0onGtjOiZlkDqpnw1OdJVd2HNZG62Bki9/w4tkdcpBrWRuBa4pY/Be4tLWUAEiAq/0p
         u99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6LYcJBHmXYf9p+4kb9IBV0jKLhs5G/9NZ/Y/r+BqrnI=;
        b=n8tvcZYQnkk4Y5FX1R78bQpju6LGFlQExxPpdh4OXsvmlGxeM12uY+wpWxAvN5GJUU
         83SXKOLeYO944z7tse7Sm8i+jqyuUKMPtEG837lALbriUhCfKNZyKECG/OS6jqU9Yerf
         rhhD+wmU7iCpSnoJ+ctShCR87YgxPgJc9rLs5DB8ZWuVaEGskTshSEauKQN64RW4O68W
         Qi94XBj19ReNGOfrfCNsTBDSE+lnVYRhNRR5qsykvcB6OyL3ID1R3uD0jNMMWesbmQwO
         Zh9iW+XoIwu0otPmABcFvCl/4YsqLDXsPQhKuFuighkl2eq6frbqe/ktdgKpAlQxCQLe
         tZDg==
X-Gm-Message-State: APjAAAXoZ6u5GB5lEP3z7TGsTiDSqGFBhL7AmSUdhr+bGmUBqLFQpvx1
        XpUmsk4uB6A3QOfciE+8SAviZ+83j88=
X-Google-Smtp-Source: APXvYqztcMFDa1Sgy9I1n4pkdrmpp6qHZE6kjus80k4vHF0P0MR4kSe0ot5YreqpxB0zWky++g/d9A==
X-Received: by 2002:a37:a9d1:: with SMTP id s200mr30864400qke.110.1579142448354;
        Wed, 15 Jan 2020 18:40:48 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id u24sm9381289qkm.40.2020.01.15.18.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 18:40:47 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        olyatelezhnaya@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com, peff@peff.net,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH v3 04/12] replace-object: make replace operations thread-safe
Date:   Wed, 15 Jan 2020 23:39:52 -0300
Message-Id: <d7f739bc57b6f59cab7c718300c28b8c6b0a61a8.1579141989.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1579141989.git.matheus.bernardino@usp.br>
References: <cover.1579141989.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

replace-object functions are very close to being thread-safe: the only
current racy section is the lazy initialization at
prepare_replace_object(). The following patches will protect some object
reading operations to be called threaded, but before that, replace
functions must be protected. To do so, add a mutex to struct
raw_object_store and acquire it before lazy initializing the
replace_map. This won't cause any noticeable performance drop as the
mutex will no longer be used after the replace_map is initialized.

Later, when the replace functions are called in parallel, thread
debuggers might point our use of the added replace_map_initialized flag
as a data race. However, as this boolean variable is initialized as
false and it's only updated once, there's no real harm. It's perfectly
fine if the value is updated right after a thread read it in
replace-map.h:lookup_replace_object() (there'll only be a performance
penalty for the affected threads at that moment). We could cease the
debugger warning protecting the variable reading at the said function.
However, this would negatively affect performance for all threads
calling it, at any time, so it's not really worthy since the warning
doesn't represent a real problem. Instead, to make sure we don't get
false positives (at ThreadSanitizer, at least) an entry for the
respective function is added to .tsan-suppressions.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 .tsan-suppressions |  6 ++++++
 object-store.h     |  2 ++
 object.c           |  2 ++
 replace-object.c   | 11 ++++++++++-
 replace-object.h   |  7 ++++++-
 5 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/.tsan-suppressions b/.tsan-suppressions
index 8c85014a0a..5ba86d6845 100644
--- a/.tsan-suppressions
+++ b/.tsan-suppressions
@@ -8,3 +8,9 @@
 # in practice it (hopefully!) doesn't matter.
 race:^want_color$
 race:^transfer_debug$
+
+# A boolean value, which tells whether the replace_map has been initialized or
+# not, is read racily with an update. As this variable is written to only once,
+# and it's OK if the value change right after reading it, this shouldn't be a
+# problem.
+race:^lookup_replace_object$
diff --git a/object-store.h b/object-store.h
index 55ee639350..33739c9dee 100644
--- a/object-store.h
+++ b/object-store.h
@@ -125,6 +125,8 @@ struct raw_object_store {
 	 * (see git-replace(1)).
 	 */
 	struct oidmap *replace_map;
+	unsigned replace_map_initialized : 1;
+	pthread_mutex_t replace_mutex; /* protect object replace functions */
 
 	struct commit_graph *commit_graph;
 	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
diff --git a/object.c b/object.c
index 142ef69399..b4e1d3db3c 100644
--- a/object.c
+++ b/object.c
@@ -480,6 +480,7 @@ struct raw_object_store *raw_object_store_new(void)
 	memset(o, 0, sizeof(*o));
 	INIT_LIST_HEAD(&o->packed_git_mru);
 	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
+	pthread_mutex_init(&o->replace_mutex, NULL);
 	return o;
 }
 
@@ -507,6 +508,7 @@ void raw_object_store_clear(struct raw_object_store *o)
 
 	oidmap_free(o->replace_map, 1);
 	FREE_AND_NULL(o->replace_map);
+	pthread_mutex_destroy(&o->replace_mutex);
 
 	free_commit_graph(o->commit_graph);
 	o->commit_graph = NULL;
diff --git a/replace-object.c b/replace-object.c
index e295e87943..7bd9aba6ee 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -34,14 +34,23 @@ static int register_replace_ref(struct repository *r,
 
 void prepare_replace_object(struct repository *r)
 {
-	if (r->objects->replace_map)
+	if (r->objects->replace_map_initialized)
 		return;
 
+	pthread_mutex_lock(&r->objects->replace_mutex);
+	if (r->objects->replace_map_initialized) {
+		pthread_mutex_unlock(&r->objects->replace_mutex);
+		return;
+	}
+
 	r->objects->replace_map =
 		xmalloc(sizeof(*r->objects->replace_map));
 	oidmap_init(r->objects->replace_map, 0);
 
 	for_each_replace_ref(r, register_replace_ref, NULL);
+	r->objects->replace_map_initialized = 1;
+
+	pthread_mutex_unlock(&r->objects->replace_mutex);
 }
 
 /* We allow "recursive" replacement. Only within reason, though */
diff --git a/replace-object.h b/replace-object.h
index 04ed7a85a2..3fbc32eb7b 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -24,12 +24,17 @@ const struct object_id *do_lookup_replace_object(struct repository *r,
  * name (replaced recursively, if necessary).  The return value is
  * either sha1 or a pointer to a permanently-allocated value.  When
  * object replacement is suppressed, always return sha1.
+ *
+ * Note: some thread debuggers might point a data race on the
+ * replace_map_initialized reading in this function. However, we know there's no
+ * problem in the value being updated by one thread right after another one read
+ * it here (and it should be written to only once, anyway).
  */
 static inline const struct object_id *lookup_replace_object(struct repository *r,
 							    const struct object_id *oid)
 {
 	if (!read_replace_refs ||
-	    (r->objects->replace_map &&
+	    (r->objects->replace_map_initialized &&
 	     r->objects->replace_map->map.tablesize == 0))
 		return oid;
 	return do_lookup_replace_object(r, oid);
-- 
2.24.1

