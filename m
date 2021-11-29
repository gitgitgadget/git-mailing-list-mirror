Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B44C433FE
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 19:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243669AbhK2TjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 14:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242534AbhK2ThC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 14:37:02 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BE2C09B191
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:52:52 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so12763392wmb.0
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nEih7G58FeXZR7VfCiUcLv0bmQevEM54qXiHHW/Vpvo=;
        b=airA1qfQCqHzXo0I3eMn3m2p6JMZhcbcCtlIZRL5SL/0B3BUbHa91fpEAD+uVhqxZS
         cB3v+h8/XveaoXAnNeN2pqvAYEeN+pQ8vgQQIa1HRRrHbJ0U2DDyb6bqqa1JEy0EJ5kz
         43zCaZw0/W2cyal2/Aux6Ymi78/4+va5oC0hsEwDEubDQeKayOaNYTkqTxRV7elByi2a
         AslHjTc/Y/8eJq7TXYTzSYLRt+ddSbRLhw8HTcXjiRIfHgwR31HuuSkbY4XN3h90dJmH
         H8Non8K/Ed2lGoLX8RzItCHGAmoc9YCjdEz4QZY7tqexX553R1MmyAgIZ1LmepMIiAl6
         BmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nEih7G58FeXZR7VfCiUcLv0bmQevEM54qXiHHW/Vpvo=;
        b=EGhftzKjZzQYddHB4WEZjgVbmdk4DgcnCKLdDBrZfQ6M1gPGpisBVicnJBTPAsRDPb
         IGG1jZLPXk0yXYwJRyb1HKyxB3QcJno7Xxr9mHoe7KiCCPDXyWr1ioDvjYPnzyX0sS6V
         40xgFwIU5s8s3fljPYG1rECYWn9YzbJC42jc0fbq/mXMgqYufYgevTVztF96pDSu3g3x
         WoTWXqnIIvz/19IfZgxAaO0BRjuSzFXx/veqdRLjgrhYsH9bUNWMkjsExh5NhK3RSJwr
         RqXeLRUZoep4bItZr6EFYnD4sVmT7sidu0i/wywQmJY63DvifvkHiENrXWTQncSq/Xrt
         heIQ==
X-Gm-Message-State: AOAM530l6De31k2zWCzEE4znDVq4WYj6qoA2lsqy5B7peVXpwma9PIm2
        uiWc8UNwldhc8vgvanlP2itfWskgPLk=
X-Google-Smtp-Source: ABdhPJzkFL909civf7qPEZ4re/sRPgOYyiHaowP7yOcIOBRnWVp4ITYL2RnDxkd8Q2Yq7miz7KcCNQ==
X-Received: by 2002:a05:600c:294c:: with SMTP id n12mr37487102wmd.71.1638201170497;
        Mon, 29 Nov 2021 07:52:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13sm14180972wrr.47.2021.11.29.07.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:52:50 -0800 (PST)
Message-Id: <ddd97fb2837135b49ea3c681bcdc06908cfc47c4.1638201164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
References: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
        <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 15:52:43 +0000
Subject: [PATCH v6 8/8] unpack-trees: improve performance of next_cache_entry
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

To find the first non-unpacked cache entry, `next_cache_entry` iterates
through index, starting at `cache_bottom`. The performance of this in full
indexes is helped by `cache_bottom` advancing with each invocation of
`mark_ce_used` (called by `unpack_index_entry`). However, the presence of
sparse directories can prevent the `cache_bottom` from advancing in a sparse
index case, effectively forcing `next_cache_entry` to search from the
beginning of the index each time it is called.

The `cache_bottom` must be preserved for the sparse index (see 17a1bb570b
(unpack-trees: preserve cache_bottom, 2021-07-14)). Therefore, to retain the
benefit `cache_bottom` provides in non-sparse index cases, a separate `hint`
position indicates the first position `next_cache_entry` should search,
updated each execution with a new position.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 unpack-trees.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 8ea0a542da8..b94733de6be 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -645,17 +645,24 @@ static void mark_ce_used_same_name(struct cache_entry *ce,
 	}
 }
 
-static struct cache_entry *next_cache_entry(struct unpack_trees_options *o)
+static struct cache_entry *next_cache_entry(struct unpack_trees_options *o, int *hint)
 {
 	const struct index_state *index = o->src_index;
 	int pos = o->cache_bottom;
 
+	if (*hint > pos)
+		pos = *hint;
+
 	while (pos < index->cache_nr) {
 		struct cache_entry *ce = index->cache[pos];
-		if (!(ce->ce_flags & CE_UNPACKED))
+		if (!(ce->ce_flags & CE_UNPACKED)) {
+			*hint = pos + 1;
 			return ce;
+		}
 		pos++;
 	}
+
+	*hint = pos;
 	return NULL;
 }
 
@@ -1365,12 +1372,13 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 
 	/* Are we supposed to look at the index too? */
 	if (o->merge) {
+		int hint = -1;
 		while (1) {
 			int cmp;
 			struct cache_entry *ce;
 
 			if (o->diff_index_cached)
-				ce = next_cache_entry(o);
+				ce = next_cache_entry(o, &hint);
 			else
 				ce = find_cache_entry(info, p);
 
@@ -1690,7 +1698,7 @@ static int verify_absent(const struct cache_entry *,
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
 {
 	struct repository *repo = the_repository;
-	int i, ret;
+	int i, hint, ret;
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
 	int free_pattern_list = 0;
@@ -1763,13 +1771,15 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		info.pathspec = o->pathspec;
 
 		if (o->prefix) {
+			hint = -1;
+
 			/*
 			 * Unpack existing index entries that sort before the
 			 * prefix the tree is spliced into.  Note that o->merge
 			 * is always true in this case.
 			 */
 			while (1) {
-				struct cache_entry *ce = next_cache_entry(o);
+				struct cache_entry *ce = next_cache_entry(o, &hint);
 				if (!ce)
 					break;
 				if (ce_in_traverse_path(ce, &info))
@@ -1790,8 +1800,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	/* Any left-over entries in the index? */
 	if (o->merge) {
+		hint = -1;
 		while (1) {
-			struct cache_entry *ce = next_cache_entry(o);
+			struct cache_entry *ce = next_cache_entry(o, &hint);
 			if (!ce)
 				break;
 			if (unpack_index_entry(ce, o) < 0)
-- 
gitgitgadget
