Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17C9A1FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 11:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753425AbcIDLkR (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 07:40:17 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34536 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbcIDLkO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 07:40:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id v143so9136032wmv.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 04:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IFYf/KiD4vy0+HepxKHlAFjSLSi30nPsokDDj5pGV+k=;
        b=nzXeSd0ksZDrm1IUQHbQUP69+v+1UYILNKZuiHDO8hKK/mxXRoV/U6kXkfDSqzbz7T
         9rjN00oJfogFaQ/UXIWoPeUyW9TXRJO2c/ZcKJSlUdyZiwuqD7KTnZcrUv1fsXabSjtd
         bmWPZxyHSXS8ZRsGVhUAwcEZxyc0biBmVM7Ry4ziRoR9K2VSsXOwCyYLJqhcl8/rMbFa
         qVBsii1QW7h//yCx1mwfvIE0bSu3LIzrFGoxwyerZRnfCp2A/QJxHL5KdztJXXxDzb7y
         lDLT//ekJ31Z8lo9IPUAcYNFAXjqohb5VTQW7pvCejhu4PxrU0NzixU9pW6vofH9oMC2
         ngMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IFYf/KiD4vy0+HepxKHlAFjSLSi30nPsokDDj5pGV+k=;
        b=YulZtpcx+vbpCGu9/yCzczg5Hz7yeEhCRcNJmMEgUYSHV7alAOJPdJ1WBYfLX1E3Ie
         g+/1Vbi45D25dq6eQcS473iYEHTEKY4a8Z+VDXxCr4mzl72wkPu5K6XcwGHOE2LG/kQ2
         DSG1dN7Z9kMzrZWeEgu/Df1aqDYfgWKkbOWLjIapqu1YtVSAdfYXMcuN16y160A+ykP6
         mhDkAzGHsx8g+WhI+4otue+LIO+t+kVwZ8PC2LmEjU/5D+sLqlPTPQBU9yfIPYTDqJNw
         +cnwfIkt89/K+JsO6KlFBv3zLISFbEDm/y0P47IlU/l4VV0Vx4tIFPTStLo5aqhtFo48
         vlqA==
X-Gm-Message-State: AE9vXwNCXGvdPbeNyl7i+ct/W+lvx28n/9aA/98QRGe1+ifO4YBftJDxYRHYiVLxnyA+Lg==
X-Received: by 10.28.132.16 with SMTP id g16mr10408250wmd.97.1472989212565;
        Sun, 04 Sep 2016 04:40:12 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id q139sm13892332wmb.18.2016.09.04.04.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Sep 2016 04:40:11 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        git@vger.kernel.org,
        =?UTF-8?q?Ingo=20Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 3/4] read-cache: introduce chmod_index_entry
Date:   Sun,  4 Sep 2016 12:39:53 +0100
Message-Id: <20160904113954.21697-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484
In-Reply-To: <20160904113954.21697-1-t.gummerer@gmail.com>
References: <xmqq4m5zutyc.fsf@gitster.mtv.corp.google.com>
 <20160904113954.21697-1-t.gummerer@gmail.com>
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

