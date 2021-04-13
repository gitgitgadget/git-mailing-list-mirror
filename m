Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BC0C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7961B61206
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbhDMOCG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 10:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbhDMOCC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 10:02:02 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2265EC061756
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h4so7553462wrt.12
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gXqdqUJHSvZv+ScIN0sMWzSKjWEIqKfVgAWYeNbLixQ=;
        b=TcjuTas1N5MhZwbVOqJyrgLiB3Ti1QImbBBC7lp0NC+MZu6lW8ko4mEGaoqz1v/nUZ
         MB8UoGxNGvqTV2DVhetuFLNvd+PRqbLeMOllVuHP48KN/Gi/oBWDu9p2IV7YU8XDumYr
         YpqrYzRJYbEcDmQF+o18leTj+OGAH2uAdFDrbSXepcLBrijx5owk/tUFmo1DCQlvLQGx
         vo1TKHcgXIlqVduO9WaUuUrTpnazCvZyHw8O+9BlI8MQHvyM/ShoFScIFTplqu79KOHI
         ugh3c57+QbZcmluf6kRDVoY5j+Oh+kg4iFvsgWp7CChgRkPHnQDvDTj72l4VIabIsV0a
         buYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gXqdqUJHSvZv+ScIN0sMWzSKjWEIqKfVgAWYeNbLixQ=;
        b=gGsqTr3yh7z9YlPpaxll/nqKc7CRTEmOQ5cH+8qlBzLJtuY3UMlzgI6dmbXVhfaynN
         q9p8fB3ZrQOfXmYC855biTWd//q1wzZXGCCHAkRBwfu9sRLEx1NY5M3vkcx6wmQr4vpQ
         CLqHHjhDmq1L9yXvJ/ITLaCHq+Xuldy8/mjLwGoL3yWV71ntZ6sEPRORsaXmoKRTzWUF
         R9o/1wXnGmY9sizXa9J1wbzBm/0qzCr0aR903ow7WbGXIg/HRopwNR0MYlRt5lrvOytL
         svnr5f6aVBr9FnEIeMPs3yzUSIOn8dJWZehwQl4M/SDY/49ZEiWudjvYOZ3CO9CMcnM3
         5wcQ==
X-Gm-Message-State: AOAM532i4gadMWQVi34yMOrJQt0vupYYSEU9AHm3YCc/ofolmRGupnha
        DqieHGiPZPQ4v+EtswOW18IzVhFg1Ns=
X-Google-Smtp-Source: ABdhPJynQBdQ72XVgSNVW9NQmOH7Edx1kX7F9S3+5DUIwrAahN/aGxVN597UgPLT7j+31+AtSGO05w==
X-Received: by 2002:a5d:65ca:: with SMTP id e10mr36714929wrw.331.1618322500739;
        Tue, 13 Apr 2021 07:01:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm2668193wmc.24.2021.04.13.07.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:01:40 -0700 (PDT)
Message-Id: <0a3892d2ec9e4acd4cba1c1d0390acc60dc6e50f.1618322497.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.git.1618322497.gitgitgadget@gmail.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Apr 2021 14:01:29 +0000
Subject: [PATCH 02/10] unpack-trees: make sparse aware
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As a first step to integrate 'git status' and 'git add' with the sparse
index, we must start integrating unpack_trees() with sparse directory
entries. These changes are currently impossible to trigger because
unpack_trees() calls ensure_full_index() if command_requires_full_index
is true. This is the case for all commands at the moment. As we expand
more commands to be sparse-aware, we might find that more changes are
required to unpack_trees(). The current changes will suffice for
'status' and 'add'.

unpack_trees() calls the traverse_trees() API using unpack_callback()
to decide if we should recurse into a subtree. We must add new abilities
to skip a subtree if it corresponds to a sparse directory entry.

It is important to be careful about the trailing directory separator
that exists in the sparse directory entries but not in the subtree
paths.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.h           |  2 +-
 preload-index.c |  2 ++
 read-cache.c    |  3 +++
 unpack-trees.c  | 24 ++++++++++++++++++++++--
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/dir.h b/dir.h
index 51cb0e217247..9d6666f520f3 100644
--- a/dir.h
+++ b/dir.h
@@ -503,7 +503,7 @@ static inline int ce_path_match(struct index_state *istate,
 				char *seen)
 {
 	return match_pathspec(istate, pathspec, ce->name, ce_namelen(ce), 0, seen,
-			      S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
+			      S_ISSPARSEDIR(ce->ce_mode) || S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
 }
 
 static inline int dir_path_match(struct index_state *istate,
diff --git a/preload-index.c b/preload-index.c
index e5529a586366..35e67057ca9b 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -55,6 +55,8 @@ static void *preload_thread(void *_data)
 			continue;
 		if (S_ISGITLINK(ce->ce_mode))
 			continue;
+		if (S_ISSPARSEDIR(ce->ce_mode))
+			continue;
 		if (ce_uptodate(ce))
 			continue;
 		if (ce_skip_worktree(ce))
diff --git a/read-cache.c b/read-cache.c
index 29ffa9ac5db9..6308234b4838 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1594,6 +1594,9 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		if (ignore_skip_worktree && ce_skip_worktree(ce))
 			continue;
 
+		if (istate->sparse_index && S_ISSPARSEDIR(ce->ce_mode))
+			continue;
+
 		if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
 			filtered = 1;
 
diff --git a/unpack-trees.c b/unpack-trees.c
index dddf106d5bd4..9a62e823928a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -586,6 +586,13 @@ static void mark_ce_used(struct cache_entry *ce, struct unpack_trees_options *o)
 {
 	ce->ce_flags |= CE_UNPACKED;
 
+	/*
+	 * If this is a sparse directory, don't advance cache_bottom.
+	 * That will be advanced later using the cache-tree data.
+	 */
+	if (S_ISSPARSEDIR(ce->ce_mode))
+		return;
+
 	if (o->cache_bottom < o->src_index->cache_nr &&
 	    o->src_index->cache[o->cache_bottom] == ce) {
 		int bottom = o->cache_bottom;
@@ -984,6 +991,9 @@ static int do_compare_entry(const struct cache_entry *ce,
 	ce_len -= pathlen;
 	ce_name = ce->name + pathlen;
 
+	/* remove directory separator if a sparse directory entry */
+	if (S_ISSPARSEDIR(ce->ce_mode))
+		ce_len--;
 	return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, mode);
 }
 
@@ -993,6 +1003,10 @@ static int compare_entry(const struct cache_entry *ce, const struct traverse_inf
 	if (cmp)
 		return cmp;
 
+	/* If ce is a sparse directory, then allow equality here. */
+	if (S_ISSPARSEDIR(ce->ce_mode))
+		return 0;
+
 	/*
 	 * Even if the beginning compared identically, the ce should
 	 * compare as bigger than a directory leading up to it!
@@ -1243,6 +1257,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
 	struct unpack_trees_options *o = info->data;
 	const struct name_entry *p = names;
+	unsigned recurse = 1;
 
 	/* Find first entry with a real name (we could use "mask" too) */
 	while (!p->mode)
@@ -1284,12 +1299,16 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 					}
 				}
 				src[0] = ce;
+
+				if (S_ISSPARSEDIR(ce->ce_mode))
+					recurse = 0;
 			}
 			break;
 		}
 	}
 
-	if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
+	if (recurse &&
+	    unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
 		return -1;
 
 	if (o->merge && src[0]) {
@@ -1319,7 +1338,8 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 			}
 		}
 
-		if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
+		if (recurse &&
+		    traverse_trees_recursive(n, dirmask, mask & ~dirmask,
 					     names, info) < 0)
 			return -1;
 		return mask;
-- 
gitgitgadget

