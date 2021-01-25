Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65331C433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A48B22B3B
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbhAYSAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731119AbhAYR4V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:56:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E20C061223
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:34 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id c12so13833314wrc.7
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uWvh1uq57/MSzGVd3Bb90wwkbavYqjng6CV9Jz8ctUk=;
        b=fRdRPaJoxPS2sVIKBGbYA3YLHTWQjPZfXovB4Ph1pnEKhr7TLy6z5ToqbvNnHKvi0O
         EVmuiBfq9oHzUNPdNunVnUvNCNycUp2cQgt6XbO9soxnwjAAqi7p7ICIFkiDBPYAe7w1
         xZf/QYKX4oqtGNrAxaCbzsoFz/PKmUZ1PqRxYLmNVcGf9QQDT3BcPd/q7C2NM8dVElgQ
         IyaBU9uE5Ewkm/pl/zLaMZOBTX8RFFwe1mm4SwXFjqi64LPgWVkD2y5ewmwJmoJ9ilf9
         4jL04GVT8Zc+Rw5CpINkBW30wg6mbHRs8fw8N81Iza6nA0asn4PFj75CW/BeYpgq8/xr
         o7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uWvh1uq57/MSzGVd3Bb90wwkbavYqjng6CV9Jz8ctUk=;
        b=cvJLfC7QQhdxgrz3lla5a0aODz1nzYMZSvn5fq4k0HAVThCVtQoNh2r6yVI4TJkoga
         T54pplaylSaQkoFKyhpZDjg6Y4VYpbD4Q20nNHhUpwBICQLASmxJi1O8iNd5C1GMLJWn
         Lpm1ue715soE2nBS4OR9OY0MLQ3GP20pEcNU+iJgKn53xm+miKU7sRVwlV00TBm2ucUO
         8RXC1bsYfc0C79CqzhAQItVFB+AgLDvjWPqGU6w+T6t6ErUz4azcKlQB/tkGoAxPrPGu
         6x0lsYvJOS0jx28dPIguWcgvkcmhoaUNmS5wOL8mC317UruI3O7+YXMjiajF8sTrdSz+
         YVeA==
X-Gm-Message-State: AOAM531XI8odNdhWvm4ImOap5zczyFs6FSEp7N2O+bNNAdzEaItbEKef
        L3aUG0UG8VQ5WzKMJUc1X6TcFsWuE+g=
X-Google-Smtp-Source: ABdhPJyfs0uCZGKkK1S6chYf4knT54wVcC3F5Ftm9cB6I3lf95CHTYEzToh1fgfvCJNaStwYgSP0Vw==
X-Received: by 2002:adf:b257:: with SMTP id y23mr2175449wra.371.1611596553284;
        Mon, 25 Jan 2021 09:42:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h1sm20454046wrr.73.2021.01.25.09.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:32 -0800 (PST)
Message-Id: <ba8e25502f2f466da73c292cdff7a0f90400f2be.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:42:06 +0000
Subject: [PATCH 20/27] sparse-index: expand_to_path() trivial implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before we check if a specific file or directory exists in the index, it
would be good to see if a leading directory is a sparse-directory. If
so, we will want to expand the index _just enough_ to be sure that the
paths we are interested in are in the index.

The actually-interesting implementation will follow in a later change.
For now, simply call ensure_full_index() to expand every directory
simultaneously.

Calls like index_dir_exists(), adjust_dirname_case(), and
index_file_exists() in name-hash.c can trust the name hash if the index
was properly expanded for the requested names. These methods can
transition from ensure_full_index() to expand_to_path().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 name-hash.c    | 10 ++++------
 sparse-index.c |  7 +++++++
 sparse-index.h | 12 ++++++++++++
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index 0f6d4fcca5a..641f6900a7c 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "thread-utils.h"
 #include "trace2.h"
+#include "sparse-index.h"
 
 struct dir_entry {
 	struct hashmap_entry ent;
@@ -679,9 +680,8 @@ int index_dir_exists(struct index_state *istate, const char *name, int namelen)
 {
 	struct dir_entry *dir;
 
-	ensure_full_index(istate);
-
 	lazy_init_name_hash(istate);
+	expand_to_path(istate, name, namelen, 0);
 	dir = find_dir_entry(istate, name, namelen);
 	return dir && dir->nr;
 }
@@ -691,9 +691,8 @@ void adjust_dirname_case(struct index_state *istate, char *name)
 	const char *startPtr = name;
 	const char *ptr = startPtr;
 
-	ensure_full_index( istate);
-
 	lazy_init_name_hash(istate);
+	expand_to_path(istate, name, strlen(name), 0);
 	while (*ptr) {
 		while (*ptr && *ptr != '/')
 			ptr++;
@@ -716,9 +715,8 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
 	struct cache_entry *ce;
 	unsigned int hash = memihash(name, namelen);
 
-	ensure_full_index(istate);
-
 	lazy_init_name_hash(istate);
+	expand_to_path(istate, name, namelen, icase);
 
 	ce = hashmap_get_entry_from_hash(&istate->name_hash, hash, NULL,
 					 struct cache_entry, ent);
diff --git a/sparse-index.c b/sparse-index.c
index 3552f88fb03..dd1a06dfdd3 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -280,3 +280,10 @@ void ensure_full_index(struct index_state *istate)
 
 	trace2_region_leave("index", "ensure_full_index", istate->repo);
 }
+
+void expand_to_path(struct index_state *istate,
+		    const char *path, size_t pathlen, int icase)
+{
+	/* for now, do the obviously-correct, slow thing */
+	ensure_full_index(istate);
+}
diff --git a/sparse-index.h b/sparse-index.h
index ca936e95d11..549e4171f1a 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -4,6 +4,18 @@
 struct index_state;
 void ensure_full_index(struct index_state *istate);
 int convert_to_sparse(struct index_state *istate);
+/*
+ * Some places in the codebase expect to search for a specific path.
+ * This path might be outside of the sparse-checkout definition, in
+ * which case a sparse-index may not contain a path for that index.
+ *
+ * Given an index and a path, check to see if a leading directory for
+ * 'path' exists in the index as a sparse directory. In that case,
+ * expand that sparse directory to a full range of cache entries and
+ * populate the index accordingly.
+ */
+void expand_to_path(struct index_state *istate,
+		    const char *path, size_t pathlen, int icase);
 
 struct repository;
 int set_sparse_index_config(struct repository *repo, int enable);
-- 
gitgitgadget

