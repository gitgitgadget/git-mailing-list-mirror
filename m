Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EA3F1FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 21:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1765661AbcINVHv (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 17:07:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34590 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764136AbcINVHr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 17:07:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id g141so4275217wmd.1
        for <git@vger.kernel.org>; Wed, 14 Sep 2016 14:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1I9cgur0SI/nga7BSiRn7IKrJwfQrUbVn7pIS2dfm00=;
        b=LJpuaqYe133fpfD+2BbTOqOllYHA3x2MG9+0bKQEQ4QBGLJTB5cAXAa/ByQks9KBzx
         rgs1ezPlqpDUBAkam5fzzI+F3HX29/Pm/oQTpyFDOzcmusvLMBmcruPjGb3JKbeCaQs9
         eS5Yn3o0wRABUJ62nLxH/GpTofqLgbF7x74DCKrokk5kVpukVd8ub7cuDntBNrUgJy+N
         sxPKw5d2ArMyqQ+zEtVq0oaIlrEGS8pnADf09hpFT7pvjTYAsrOButiCY94vUxHkCFn9
         r5I4yF6IoC12kP25GCypGAIABq0EgMxuAoE4W2tlJq5vx40pSQSGna5ZT3CM7iSeLr0t
         lQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1I9cgur0SI/nga7BSiRn7IKrJwfQrUbVn7pIS2dfm00=;
        b=j7CXN/HNWyVxmsk1c98gBD3gJdfnvR66M2kHb0tbT/FKp/HrRe5gpDkqXEBW4XmQtW
         CKluUTcUXEM4qHf294HKcmBBkP5+xX7LC6OgRJKxlEKQnQuNnkbQNE8AAj5KPPAqKxL3
         ThtZHwJb+oe6pR8FBrjO1f0H3oq4JWaFdhZR1NI3mK62GhVL0GvF8/4G90tfVM/Wva6Z
         WfKLqvwo8GXmhq5y5HAkl5eXBL7cgwdXmS/dd4YGNCqpBcLOkib3lkh0PWb+7xgy36id
         5cVqXg0or38RZlwNVBmnHoCy3sr/Uhw/aLVwLi35EMHUdD0i18PA/jgOeiojRIbflDE2
         GNOw==
X-Gm-Message-State: AE9vXwPavlzclK0Q2SqOVHu/qDPbAZ0O7eZx1rt1yw1nm6S9NZXNapxdha1TLMlUiGZOoA==
X-Received: by 10.194.95.105 with SMTP id dj9mr4926438wjb.20.1473887265143;
        Wed, 14 Sep 2016 14:07:45 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id pj2sm135872wjb.8.2016.09.14.14.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Sep 2016 14:07:44 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        =?UTF-8?q?Ingo=20Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 3/4] read-cache: introduce chmod_index_entry
Date:   Wed, 14 Sep 2016 22:07:46 +0100
Message-Id: <20160914210747.15485-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484
In-Reply-To: <20160914210747.15485-1-t.gummerer@gmail.com>
References: <20160912210818.26282-1-t.gummerer@gmail.com>
 <20160914210747.15485-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As there are chmod options for both add and update-index, introduce a
new chmod_index_entry function to do the work.  Use it in update-index,
while it will be used in add in the next patch.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/update-index.c | 16 ++--------------
 cache.h                |  2 ++
 read-cache.c           | 29 +++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index bbdf0d9..9e9e040 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -423,26 +423,14 @@ static void chmod_path(char flip, const char *path)
 {
 	int pos;
 	struct cache_entry *ce;
-	unsigned int mode;
 
 	pos = cache_name_pos(path, strlen(path));
 	if (pos < 0)
 		goto fail;
 	ce = active_cache[pos];
-	mode = ce->ce_mode;
-	if (!S_ISREG(mode))
-		goto fail;
-	switch (flip) {
-	case '+':
-		ce->ce_mode |= 0111; break;
-	case '-':
-		ce->ce_mode &= ~0111; break;
-	default:
+	if (chmod_cache_entry(ce, flip) < 0)
 		goto fail;
-	}
-	cache_tree_invalidate_path(&the_index, path);
-	ce->ce_flags |= CE_UPDATE_IN_BASE;
-	active_cache_changed |= CE_ENTRY_CHANGED;
+
 	report("chmod %cx '%s'", flip, path);
 	return;
  fail:
diff --git a/cache.h b/cache.h
index 6738050..35c8d1c 100644
--- a/cache.h
+++ b/cache.h
@@ -369,6 +369,7 @@ extern void free_name_hash(struct index_state *istate);
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
 #define add_to_cache(path, st, flags) add_to_index(&the_index, (path), (st), (flags), 0)
 #define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags), 0)
+#define chmod_cache_entry(ce, flip) chmod_index_entry(&the_index, (ce), (flip))
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
@@ -584,6 +585,7 @@ extern int remove_file_from_index(struct index_state *, const char *path);
 extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags, int force_mode);
 extern int add_file_to_index(struct index_state *, const char *path, int flags, int force_mode);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, unsigned int refresh_options);
+extern int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
 extern int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
 extern void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
 extern int index_name_is_other(const struct index_state *, const char *, int);
diff --git a/read-cache.c b/read-cache.c
index 491e52d..8924f2e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -756,6 +756,35 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 	return ret;
 }
 
+/*
+ * Chmod an index entry with either +x or -x.
+ *
+ * Returns -1 if the chmod for the particular cache entry failed (if it's
+ * not a regular file), -2 if an invalid flip argument is passed in, 0
+ * otherwise.
+ */
+int chmod_index_entry(struct index_state *istate, struct cache_entry *ce,
+		      char flip)
+{
+	if (!S_ISREG(ce->ce_mode))
+		return -1;
+	switch (flip) {
+	case '+':
+		ce->ce_mode |= 0111;
+		break;
+	case '-':
+		ce->ce_mode &= ~0111;
+		break;
+	default:
+		return -2;
+	}
+	cache_tree_invalidate_path(&the_index, ce->name);
+	ce->ce_flags |= CE_UPDATE_IN_BASE;
+	istate->cache_changed |= CE_ENTRY_CHANGED;
+
+	return 0;
+}
+
 int ce_same_name(const struct cache_entry *a, const struct cache_entry *b)
 {
 	int len = ce_namelen(a);
-- 
2.10.0.304.gf2ff484

