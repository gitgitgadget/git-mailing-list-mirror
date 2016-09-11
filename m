Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BBEF20985
	for <e@80x24.org>; Sun, 11 Sep 2016 10:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755600AbcIKKaf (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:30:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33164 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755407AbcIKKac (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:30:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id b187so9367514wme.0
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 03:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IFYf/KiD4vy0+HepxKHlAFjSLSi30nPsokDDj5pGV+k=;
        b=sOdZ27tM1cxt9H2hcYuR9O2uaidbQ0pICS0H6JkJ8XifuQzsM3iMHDjjRkLyScmKJo
         Pzedp0V/wXohSLcasnTpqF8DkybS/XA6ggjnZPmJ26F4n5ebNHq1nXdkiYNuYBKPuIpk
         UJSgYLR+u+YGegpAqkU9iNjvEv9LYp3IH/2UJy/yHOvlZ4B7RRrlGgREzpsL0BPOXtNp
         Dl86ceTJBa88RezEaD68ORfsp1m+FGSOAuIz753u8uhGxzRk8xTNEn0mgSL/kS+0DoZV
         L18Rzio2UxuYKXZ3UbMDOal/mQ/e4Ts3Apu8qzbGy6haDFOUDcYv5zsVXJ0CLciTQTpH
         zbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IFYf/KiD4vy0+HepxKHlAFjSLSi30nPsokDDj5pGV+k=;
        b=Wk6Ch1DPuGTQsIJsgCAfNSP1lglrA+Gxx3fGMjTJ3pXydF4i7zaDIZLCoZodPVLH5i
         j3dhF/PjV2EKuCLH41KyPEC+RUCcgpVzUrve4rDIXMh893EwwQgxN4CxifxhDmuVqdoj
         jhF/TCR2R+jtarK2I+Ucp/z8Om3w2wmIDYLopGTA1V90QjP1MHI05Mn3a1ozI0UPy84s
         boKy1rplKzOnNHXeo0h87/cYYfNUgcJ5+FEKjqiSlY5Vc8buddbWwuHXBhVo+KSyBwXN
         VGoEY7615otK8jstrFa1p5NpkApZfr4ki4XehhLMUwV2DOXOKqQo7e1UIz9vyzKNs9qV
         z7Pg==
X-Gm-Message-State: AE9vXwONBnUWWwzKrFRb2IgMaq6WODVfyOwVe+NaLC07+kNSen+e3EH0ymug9olYGSvCOw==
X-Received: by 10.28.52.210 with SMTP id b201mr6410615wma.32.1473589830483;
        Sun, 11 Sep 2016 03:30:30 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id z17sm12293074wmz.23.2016.09.11.03.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Sep 2016 03:30:29 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        =?UTF-8?q?Ingo=20Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 3/4] read-cache: introduce chmod_index_entry
Date:   Sun, 11 Sep 2016 11:30:27 +0100
Message-Id: <20160911103028.5492-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484
In-Reply-To: <20160911103028.5492-1-t.gummerer@gmail.com>
References: <20160904113954.21697-1-t.gummerer@gmail.com>
 <20160911103028.5492-1-t.gummerer@gmail.com>
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
index 85a57db..1569c81 100644
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

