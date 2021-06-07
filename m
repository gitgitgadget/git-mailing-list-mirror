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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83D3C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95689610E7
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhFGMgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhFGMgX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:36:23 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B49C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 05:34:20 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so12592920wmk.1
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 05:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aKwPLFNBrCYiHtXh8ZOrMRw+NjjP+1mq7q+qzlZYbgs=;
        b=YWF+LgzZqsNX4HpEnwRHG5OiIAVoyz3mowVbJcRCUtf4MSN7wzqMa9YpoajvJbyDyd
         +5coHroyIyWtISCNO5F8H00HWT7JdEstKAhlm1GIGPdDXlt45l0/EH6CMn4uPCZEHHKD
         Y+wVuj7ssS0fDzW2C/sNlnctMWOqBjb0Yqp1w8VEnoZ/qd2g2zGy4HnbcV8hNelENFlS
         1wKCe/oTVYVg3vLlrYE+Wi74gZaXtcx2FAQATLZPZRzF3DpJUlYz3F9xrDNovdQb8DQm
         f+m1RXcTtc2pjE3rrcaiA4mKGkW/4z376Rf4trit9Ga/bNTzjskyoI8GmZ5L1WBh8aSF
         PrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aKwPLFNBrCYiHtXh8ZOrMRw+NjjP+1mq7q+qzlZYbgs=;
        b=ILkWlC+vvbNkxs1XWMTAT8SBVLN9xdgkG6bm1cUATuNYW0YJ+xl+kCYzce2H4Pq9AG
         OVnVwX77YgvDuuww7ai8TsM5GjkugZI1bZ/oCjY07lv5KCoprg1zz/a6g2IvzlPn25pi
         wumQQwnueIHSVLzcfPnhg7srcGGSzhKc/pB7KU2lrs/sx/J8ZLkmj5EaeOsdyLyanSvJ
         xBteV80cji5re1YfPanme7c/nSZwbz0AiSYHBhKW6+IYwDLT81siTlXDpjJwIvRu3P7H
         VE3idc8IQ6+/Yvwx0yu1ZTTJ5sPbvCSCQLvikOyVuCcMG245GeO+PEPQYJ/l8ol9QQzH
         iADw==
X-Gm-Message-State: AOAM531dhvQX8amqpyCLEQKuc2209oPBijJzbkaZqljPRaLsKtIpttci
        /s6KjUya2ssmDNgvCLhOUGMcxroVfe4=
X-Google-Smtp-Source: ABdhPJwhM1y+MjHhqq108j1/D4wkpEVs48cg8dyXMLj1Jwza37gPxAVZrX2WtALvJ7nWVk5hIFTN5Q==
X-Received: by 2002:a1c:e91a:: with SMTP id q26mr16945505wmc.170.1623069259010;
        Mon, 07 Jun 2021 05:34:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3sm16878478wrl.13.2021.06.07.05.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 05:34:18 -0700 (PDT)
Message-Id: <724194eef9f6d5514bcd7761daf0eb2bb87c0619.1623069252.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
        <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 12:34:06 +0000
Subject: [PATCH v5 08/14] unpack-trees: unpack sparse directory entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

During unpack_callback(), index entries are compared against tree
entries. These are matched according to names and types. One goal is to
decide if we should recurse into subtrees or simply operate on one index
entry.

In the case of a sparse-directory entry, we do not want to recurse into
that subtree and instead simply compare the trees. In some cases, we
might want to perform a merge operation on the entry, such as during
'git checkout <commit>' which wants to replace a sparse tree entry with
the tree for that path at the target commit. We extend the logic within
unpack_nondirectories() to create a sparse-directory entry in this case,
and then that is sent to call_unpack_fn().

There are some subtleties in this process. For instance, we need to
update find_cache_entry() to allow finding a sparse-directory entry that
exactly matches a given path.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 101 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 91 insertions(+), 10 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index ef6a2b1c951c..ff448ee8424e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1037,13 +1037,15 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 	const struct name_entry *n,
 	int stage,
 	struct index_state *istate,
-	int is_transient)
+	int is_transient,
+	int is_sparse_directory)
 {
 	size_t len = traverse_path_len(info, tree_entry_len(n));
+	size_t alloc_len = is_sparse_directory ? len + 1 : len;
 	struct cache_entry *ce =
 		is_transient ?
-		make_empty_transient_cache_entry(len) :
-		make_empty_cache_entry(istate, len);
+		make_empty_transient_cache_entry(alloc_len) :
+		make_empty_cache_entry(istate, alloc_len);
 
 	ce->ce_mode = create_ce_mode(n->mode);
 	ce->ce_flags = create_ce_flags(stage);
@@ -1052,6 +1054,13 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 	/* len+1 because the cache_entry allocates space for NUL */
 	make_traverse_path(ce->name, len + 1, info, n->path, n->pathlen);
 
+	if (is_sparse_directory) {
+		ce->name[len] = '/';
+		ce->name[len + 1] = 0;
+		ce->ce_namelen++;
+		ce->ce_flags |= CE_SKIP_WORKTREE;
+	}
+
 	return ce;
 }
 
@@ -1064,16 +1073,24 @@ static int unpack_nondirectories(int n, unsigned long mask,
 				 unsigned long dirmask,
 				 struct cache_entry **src,
 				 const struct name_entry *names,
-				 const struct traverse_info *info)
+				 const struct traverse_info *info,
+				 int sparse_directory)
 {
 	int i;
 	struct unpack_trees_options *o = info->data;
 	unsigned long conflicts = info->df_conflicts | dirmask;
 
-	/* Do we have *only* directories? Nothing to do */
 	if (mask == dirmask && !src[0])
 		return 0;
 
+	/* no-op if our cache entry doesn't match the expectations. */
+	if (sparse_directory) {
+		if (src[0] && !S_ISSPARSEDIR(src[0]->ce_mode))
+			BUG("expected sparse directory entry");
+	} else if (src[0] && S_ISSPARSEDIR(src[0]->ce_mode)) {
+		return 0;
+	}
+
 	/*
 	 * Ok, we've filled in up to any potential index entry in src[0],
 	 * now do the rest.
@@ -1103,7 +1120,9 @@ static int unpack_nondirectories(int n, unsigned long mask,
 		 * not stored in the index.  otherwise construct the
 		 * cache entry from the index aware logic.
 		 */
-		src[i + o->merge] = create_ce_entry(info, names + i, stage, &o->result, o->merge);
+		src[i + o->merge] = create_ce_entry(info, names + i, stage,
+						    &o->result, o->merge,
+						    sparse_directory);
 	}
 
 	if (o->merge) {
@@ -1210,13 +1229,44 @@ static int find_cache_pos(struct traverse_info *info,
 static struct cache_entry *find_cache_entry(struct traverse_info *info,
 					    const struct name_entry *p)
 {
+	struct cache_entry *ce;
 	int pos = find_cache_pos(info, p->path, p->pathlen);
 	struct unpack_trees_options *o = info->data;
 
 	if (0 <= pos)
 		return o->src_index->cache[pos];
-	else
+
+	/*
+	 * Check for a sparse-directory entry named "path/".
+	 * Due to the input p->path not having a trailing
+	 * slash, the negative 'pos' value overshoots the
+	 * expected position by one, hence "-2" here.
+	 */
+	pos = -pos - 2;
+
+	if (pos < 0 || pos >= o->src_index->cache_nr)
+		return NULL;
+
+	ce = o->src_index->cache[pos];
+
+	if (!S_ISSPARSEDIR(ce->ce_mode))
 		return NULL;
+
+	/*
+	 * Compare ce->name to info->name + '/' + p->path + '/'
+	 * if info->name is non-empty. Compare ce->name to
+	 * p-.path + '/' otherwise.
+	 */
+	if (info->namelen) {
+		if (ce->ce_namelen == info->namelen + p->pathlen + 2 &&
+		    ce->name[info->namelen] == '/' &&
+		    !strncmp(ce->name, info->name, info->namelen) &&
+		    !strncmp(ce->name + info->namelen + 1, p->path, p->pathlen))
+			return ce;
+	} else if (ce->ce_namelen == p->pathlen + 1 &&
+		   !strncmp(ce->name, p->path, p->pathlen))
+		return ce;
+	return NULL;
 }
 
 static void debug_path(struct traverse_info *info)
@@ -1251,6 +1301,32 @@ static void debug_unpack_callback(int n,
 		debug_name_entry(i, names + i);
 }
 
+/*
+ * Returns true if and only if the given cache_entry is a
+ * sparse-directory entry that matches the given name_entry
+ * from the tree walk at the given traverse_info.
+ */
+static int is_sparse_directory_entry(struct cache_entry *ce, struct name_entry *name, struct traverse_info *info)
+{
+	size_t expected_len, name_start;
+
+	if (!ce || !name || !S_ISSPARSEDIR(ce->ce_mode))
+		return 0;
+
+	if (info->namelen)
+		name_start = info->namelen + 1;
+	else
+		name_start = 0;
+	expected_len = name->pathlen + 1 + name_start;
+
+	if (ce->ce_namelen != expected_len ||
+	    strncmp(ce->name, info->name, info->namelen) ||
+	    strncmp(ce->name + name_start, name->path, name->pathlen))
+		return 0;
+
+	return 1;
+}
+
 /*
  * Note that traverse_by_cache_tree() duplicates some logic in this function
  * without actually calling it. If you change the logic here you may need to
@@ -1307,7 +1383,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 		}
 	}
 
-	if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
+	if (unpack_nondirectories(n, mask, dirmask, src, names, info, 0) < 0)
 		return -1;
 
 	if (o->merge && src[0]) {
@@ -1337,9 +1413,14 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 			}
 		}
 
-		if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
-					     names, info) < 0)
+		if (is_sparse_directory_entry(src[0], names, info)) {
+			if (unpack_nondirectories(n, dirmask, mask & ~dirmask, src, names, info, 1) < 0)
+				return -1;
+		} else if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
+						    names, info) < 0) {
 			return -1;
+		}
+
 		return mask;
 	}
 
-- 
gitgitgadget

