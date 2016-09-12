Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE16220985
	for <e@80x24.org>; Mon, 12 Sep 2016 21:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932429AbcILVIy (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 17:08:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36471 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755546AbcILVIv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 17:08:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id z194so3072026wmd.3
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 14:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9KFbJIHE1dCLYA4uJrql2FelD3z64lWF03aeiYV1nSQ=;
        b=q99Jf78o5Y+j1Qdp8Y7VYkoPrkENdd1iVFi6jayOBvIG/aS4i7sBOrijI36R7b6P9F
         JDWpUH/SxSLkFIy+dzDqmJODub3LzFTNoR1JaiqVeu6zPghcyi8ENrElC1diOY/k4HAw
         curNrnwLQ3FI8TB4Gz+caDsSxMr3HYlN0Rpy4KkTOLBBKp39B2G4JtsDhsLJSVNaXWst
         eaMS1Fi2wqwQ6eo8vRugSMh6hz/d6lv0M2Jey+glZrf8HGWsvB7Q8vpMM3bUD9Pvn7Up
         BkCxddWiyzhyEQebPGi9+NgnB/dzk/vhkTxuzMKbBdxYWn1bk7yoGuV04pN/Y4de8TMJ
         VCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9KFbJIHE1dCLYA4uJrql2FelD3z64lWF03aeiYV1nSQ=;
        b=DrJvTT4Gc3PLmFRlIBUJUKlE+12Ivve5z02ZagxYrKMQIKzMOqASBG3y3drqG6QaID
         m0CJpwLook7lSgDgcUmzSpvvb6x6SREzExOKDtdOWNiC5B2sX+bNFv8t+dJHELCav4OM
         T0zDMMqqiFQLWNQp+pKoSxWe9GaqDAs3FgFRFUGQNFMp39HdT0fMvY3JrfRy3/a1up1z
         q5qQOZxNCsxvpikAfUqXCvbHOWwsA3HgypM+zCj5v9fv1JCq3ZadTLlosaiUAiRq6J6+
         oqs2vGtkjVYTj1qWU4F9Sgr02I31lcvArxi5sg46QNnGqjrgvBHLBXpacMb6quBSan4w
         u92Q==
X-Gm-Message-State: AE9vXwOfG0AddYt1wNdQ8Mf3196UCiO1fqR9sTVd2f9HJ8eY0LwTDYyTqg9EMSZCLcXvfA==
X-Received: by 10.194.123.228 with SMTP id md4mr16140062wjb.78.1473714529434;
        Mon, 12 Sep 2016 14:08:49 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id g184sm1985803wme.15.2016.09.12.14.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Sep 2016 14:08:48 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        =?UTF-8?q?Ingo=20Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 3/4] read-cache: introduce chmod_index_entry
Date:   Mon, 12 Sep 2016 22:08:17 +0100
Message-Id: <20160912210818.26282-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484
In-Reply-To: <20160912210818.26282-1-t.gummerer@gmail.com>
References: <20160911103028.5492-1-t.gummerer@gmail.com>
 <20160912210818.26282-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As there are chmod options for both add and update-index, introduce a
new chmod_index_entry function to do the work.  Use it in update-index,
while it will be used in add in the next patch.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/update-index.c |  8 +-------
 cache.h                |  2 ++
 read-cache.c           | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 6d6cddd..809ce97 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -423,20 +423,14 @@ static void chmod_path(int force_mode, const char *path)
 {
 	int pos;
 	struct cache_entry *ce;
-	unsigned int mode;
 	char flip = force_mode == 0777 ? '+' : '-';
 
 	pos = cache_name_pos(path, strlen(path));
 	if (pos < 0)
 		goto fail;
 	ce = active_cache[pos];
-	mode = ce->ce_mode;
-	if (!S_ISREG(mode))
+	if (chmod_cache_entry(ce, force_mode) < 0)
 		goto fail;
-	ce->ce_mode = create_ce_mode(force_mode);
-	cache_tree_invalidate_path(&the_index, path);
-	ce->ce_flags |= CE_UPDATE_IN_BASE;
-	active_cache_changed |= CE_ENTRY_CHANGED;
 
 	report("chmod %cx '%s'", flip, path);
 	return;
diff --git a/cache.h b/cache.h
index b780a91..44a4f76 100644
--- a/cache.h
+++ b/cache.h
@@ -369,6 +369,7 @@ extern void free_name_hash(struct index_state *istate);
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
 #define add_to_cache(path, st, flags) add_to_index(&the_index, (path), (st), (flags), 0)
 #define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags), 0)
+#define chmod_cache_entry(ce, force_mode) chmod_index_entry(&the_index, (ce), (force_mode))
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
@@ -584,6 +585,7 @@ extern int remove_file_from_index(struct index_state *, const char *path);
 extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags, int force_mode);
 extern int add_file_to_index(struct index_state *, const char *path, int flags, int force_mode);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, unsigned int refresh_options);
+extern int chmod_index_entry(struct index_state *, struct cache_entry *ce, int force_mode);
 extern int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
 extern void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
 extern int index_name_is_other(const struct index_state *, const char *, int);
diff --git a/read-cache.c b/read-cache.c
index 491e52d..367be57 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -756,6 +756,25 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 	return ret;
 }
 
+/*
+ * Change the mode of an index entry to force_mode, where force_mode can
+ * either be 0777 or 0666.
+ * Returns -1 if the chmod for the particular cache entry failed (if it's
+ * not a regular file), 0 otherwise.
+ */
+int chmod_index_entry(struct index_state *istate, struct cache_entry *ce,
+		       int force_mode)
+{
+	if (!S_ISREG(ce->ce_mode))
+		return -1;
+	ce->ce_mode = create_ce_mode(force_mode);
+	cache_tree_invalidate_path(istate, ce->name);
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

