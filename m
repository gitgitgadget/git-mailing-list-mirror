Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C09C4727D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12073206A5
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="jytwaKku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgIVWvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgIVWvM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:51:12 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC52BC061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:12 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b2so17052579qtp.8
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQQfrIVtMpimuOF0RigPUVD9jmZYRZ7hqXsqIZy33Y4=;
        b=jytwaKkuM839n+tja9nItU/AiieWgSyF+0FlRjwuTlebpNblxxlhex65Nq2vQ3KeqH
         r9FV4jiuoCjKSd0/7oZcqFjFzJSAVhWgrMnOjJvWva8KTxff2yZ/XQMBzoGedLi1ZrM7
         nYUbscqf/n5xziBmy43+W/Imc1RerS+iWZ+XagBrzhXY3SObQJVyz0atQCkJgea/EyH9
         z4J4ZQg8vkPC0+AH7g2UTfFkXkW6n8Q+aHkOLBeCUZ0NliaDMsHNMbcqFICQtcU+IPcC
         vwnyuCRHwuH6YyhfpI+887khT/uDAy9wfYme8VoSvl7K1lNMMQpbIM8D71OUyVl9sS04
         2Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQQfrIVtMpimuOF0RigPUVD9jmZYRZ7hqXsqIZy33Y4=;
        b=RGPuH1NoHtaYXbY0XfWQgfBkkva8QPbu7kL7HJscvvQoYx+YEkbcZlfv36mjl8IpIp
         20+RZbL+5TeXhnFRhzDQQIqvQH5Z2SsyuDo5b+85poNZX8hUqq/hMZXYXCMjV6Zx2gU+
         GBf2ndKScn/ixwH0fAW8XAsJsJcUuli+kAbXt4U1fqxi6Yeta/3bhotTrANKpFtcfW11
         KtVILjwKlGo57haCJUDInHuIvjVfnag03szdyD90n3r2hUgzdVexfUpOjtXt3cg6MJJ4
         RE3ZAHlcFgWmzURRJgZ87JtwxjSc7XYWaWl4qU8lUqkQ5kcmjzfSUqIoMYsqeIJu+Ssl
         dliQ==
X-Gm-Message-State: AOAM531hS8wu7Ug7sa8sDCxi12WtInKmU4uUvucDhHzsGvyQ3qCGRQ03
        anPeqM/rs4DnsrHim2TR7BrdoFzpybQ+wQ==
X-Google-Smtp-Source: ABdhPJyo8zsBMvrcexlHunj8xU5ZKO3MOkDf9lOG6CJ2Dq5WXlSxp5SOO1pvm09hOWMFbmTmU2Z9bg==
X-Received: by 2002:ac8:f23:: with SMTP id e32mr7181735qtk.168.1600815071650;
        Tue, 22 Sep 2020 15:51:11 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id p187sm12342359qkd.129.2020.09.22.15.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:51:10 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH v2 13/19] make_transient_cache_entry(): optionally alloc from mem_pool
Date:   Tue, 22 Sep 2020 19:49:27 -0300
Message-Id: <f13b4c17f4829911b7b8274fd0161a6b7784e9fb.1600814153.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600814153.git.matheus.bernardino@usp.br>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow make_transient_cache_entry() to optionally receive a mem_pool
struct in which it should allocate the entry. This will be used in the
following patch, to store some transient entries which should persist
until parallel checkout finishes.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/checkout--helper.c |  2 +-
 builtin/checkout.c         |  2 +-
 builtin/difftool.c         |  2 +-
 cache.h                    | 10 +++++-----
 read-cache.c               | 12 ++++++++----
 unpack-trees.c             |  2 +-
 6 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout--helper.c b/builtin/checkout--helper.c
index 67fe37cf11..9646ed9eeb 100644
--- a/builtin/checkout--helper.c
+++ b/builtin/checkout--helper.c
@@ -38,7 +38,7 @@ static void packet_to_pc_item(char *line, int len,
 	}
 
 	memset(pc_item, 0, sizeof(*pc_item));
-	pc_item->ce = make_empty_transient_cache_entry(fixed_portion->name_len);
+	pc_item->ce = make_empty_transient_cache_entry(fixed_portion->name_len, NULL);
 	pc_item->ce->ce_namelen = fixed_portion->name_len;
 	pc_item->ce->ce_mode = fixed_portion->ce_mode;
 	memcpy(pc_item->ce->name, variant, pc_item->ce->ce_namelen);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b18b9d6f3c..c0bf5e6711 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -291,7 +291,7 @@ static int checkout_merged(int pos, const struct checkout *state, int *nr_checko
 	if (write_object_file(result_buf.ptr, result_buf.size, blob_type, &oid))
 		die(_("Unable to add merge result for '%s'"), path);
 	free(result_buf.ptr);
-	ce = make_transient_cache_entry(mode, &oid, path, 2);
+	ce = make_transient_cache_entry(mode, &oid, path, 2, NULL);
 	if (!ce)
 		die(_("make_cache_entry failed for path '%s'"), path);
 	status = checkout_entry(ce, state, NULL, nr_checkouts);
diff --git a/builtin/difftool.c b/builtin/difftool.c
index dfa22b67eb..5e7a57c8c2 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -323,7 +323,7 @@ static int checkout_path(unsigned mode, struct object_id *oid,
 	struct cache_entry *ce;
 	int ret;
 
-	ce = make_transient_cache_entry(mode, oid, path, 0);
+	ce = make_transient_cache_entry(mode, oid, path, 0, NULL);
 	ret = checkout_entry(ce, state, NULL, NULL);
 
 	discard_cache_entry(ce);
diff --git a/cache.h b/cache.h
index 17350cafa2..a394263f0e 100644
--- a/cache.h
+++ b/cache.h
@@ -355,16 +355,16 @@ struct cache_entry *make_empty_cache_entry(struct index_state *istate,
 					   size_t name_len);
 
 /*
- * Create a cache_entry that is not intended to be added to an index.
- * Caller is responsible for discarding the cache_entry
- * with `discard_cache_entry`.
+ * Create a cache_entry that is not intended to be added to an index. If mp is
+ * not NULL, the entry is allocated within the given memory pool. Caller is
+ * responsible for discarding the cache_entry with `discard_cache_entry`.
  */
 struct cache_entry *make_transient_cache_entry(unsigned int mode,
 					       const struct object_id *oid,
 					       const char *path,
-					       int stage);
+					       int stage, struct mem_pool *mp);
 
-struct cache_entry *make_empty_transient_cache_entry(size_t name_len);
+struct cache_entry *make_empty_transient_cache_entry(size_t len, struct mem_pool *mp);
 
 /*
  * Discard cache entry.
diff --git a/read-cache.c b/read-cache.c
index ecf6f68994..f9bac760af 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -813,8 +813,10 @@ struct cache_entry *make_empty_cache_entry(struct index_state *istate, size_t le
 	return mem_pool__ce_calloc(find_mem_pool(istate), len);
 }
 
-struct cache_entry *make_empty_transient_cache_entry(size_t len)
+struct cache_entry *make_empty_transient_cache_entry(size_t len, struct mem_pool *mp)
 {
+	if (mp)
+		return mem_pool__ce_calloc(mp, len);
 	return xcalloc(1, cache_entry_size(len));
 }
 
@@ -848,8 +850,10 @@ struct cache_entry *make_cache_entry(struct index_state *istate,
 	return ret;
 }
 
-struct cache_entry *make_transient_cache_entry(unsigned int mode, const struct object_id *oid,
-					       const char *path, int stage)
+struct cache_entry *make_transient_cache_entry(unsigned int mode,
+					       const struct object_id *oid,
+					       const char *path, int stage,
+					       struct mem_pool *mp)
 {
 	struct cache_entry *ce;
 	int len;
@@ -860,7 +864,7 @@ struct cache_entry *make_transient_cache_entry(unsigned int mode, const struct o
 	}
 
 	len = strlen(path);
-	ce = make_empty_transient_cache_entry(len);
+	ce = make_empty_transient_cache_entry(len, mp);
 
 	oidcpy(&ce->oid, oid);
 	memcpy(ce->name, path, len);
diff --git a/unpack-trees.c b/unpack-trees.c
index e05e6ceff2..dcb40dc8fa 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1031,7 +1031,7 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 	size_t len = traverse_path_len(info, tree_entry_len(n));
 	struct cache_entry *ce =
 		is_transient ?
-		make_empty_transient_cache_entry(len) :
+		make_empty_transient_cache_entry(len, NULL) :
 		make_empty_cache_entry(istate, len);
 
 	ce->ce_mode = create_ce_mode(n->mode);
-- 
2.28.0

