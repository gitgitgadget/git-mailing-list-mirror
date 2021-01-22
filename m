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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C90C43381
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DC34206A4
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbhAVNK3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 08:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbhAVNEu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 08:04:50 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CFBC061788
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 05:04:04 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a9so5009639wrt.5
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 05:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=11GVRZ1uX92OrDukLEJw+fr6Pd0hb/0vgREeqfoK+sw=;
        b=LexsxBUYxXIRzQITs9K3PVyrxAw5n1pYwrLjcNuD2IHw3Kikc2YLS1P16tec9ZtPzN
         eGE6wkkiZey7c/wl9ngmLq6ktSHO7fv0wITBEQRlJfBNX30ognN/cfDxIk/bHQInD/eH
         C4FpkrtF29G0EBH+v0WkFjf8H8os6mJD8dM+uTRKi1NX908GwRc8byezOlg+fpnzNk8l
         5pMjvSQG+o+Lx/P4T8bBXmFXc2OvpRju11vb8tT7mqoUXEKEIjCEP/C7nii221a9o2T5
         n+drI/dnVFUknr3QDEvSwGYsiUiIh82WUglaoKGK2ouqv+rN2YuxS9iTkMABXZLwXt5a
         P32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=11GVRZ1uX92OrDukLEJw+fr6Pd0hb/0vgREeqfoK+sw=;
        b=QLg0/hFPc1VenQ7qb59hmZXiW4h2wxgzj3kIjl3NMfToSIkPRkKb0um2jb96vnA0SP
         EYy37zUCIlZIcgB4hXPJQBZ+4geOQHquBGgnP3+gOV795D3RAd4vlmVT+mtkLMN0vsCJ
         /PI0v1sdXtPJSInHuytz8hybpN7M/8CPyT1kbaYD+K7+kqZyTZqYcLjBzNuRHCFu4ErR
         yCSwuK1/SaOKcbnv9PQmPsS6vKNO+9ovmbOfFdEciZ1p2SPFFZiPS0tkk/gajPNZP3O/
         32zKqNcImLQrIQGHk+8a2iJl2BxTzHGKl2EZjJEsvyPdoZ/UvkpY7ItF0B6EmuKR5ZqK
         P8xA==
X-Gm-Message-State: AOAM532wtCpAs15Qd4+yqiMFcRdg3/tNjMC2mIjg/yY1uv+eTy38lgmB
        wX9R+OQrEpuOflVNypQLgR5kgP8GYYA=
X-Google-Smtp-Source: ABdhPJwosK/dppfEmlt8qvOAhM/IPMTiYWVwO4AZYBYoqcarcmeAZu7Ik961oryEsfrHuBnthD20gQ==
X-Received: by 2002:a05:6000:104d:: with SMTP id c13mr4370463wrx.127.1611320643139;
        Fri, 22 Jan 2021 05:04:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a184sm11980021wme.35.2021.01.22.05.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 05:04:02 -0800 (PST)
Message-Id: <84323e04d0885d2bb12329e7bd16582d66989c7f.1611320639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
        <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 13:03:53 +0000
Subject: [PATCH v2 2/8] cache-tree: extract subtree_pos()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <stolee@gmail.com>,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This method will be helpful to use outside of cache-tree.c in a later
feature. The implementation is subtle due to subtree_name_cmp() sorting
by length and then lexicographically.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c | 6 +++---
 cache-tree.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index c1e49901c17..2b130dd5e19 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -45,7 +45,7 @@ static int subtree_name_cmp(const char *one, int onelen,
 	return memcmp(one, two, onelen);
 }
 
-static int subtree_pos(struct cache_tree *it, const char *path, int pathlen)
+int cache_tree_subtree_pos(struct cache_tree *it, const char *path, int pathlen)
 {
 	struct cache_tree_sub **down = it->down;
 	int lo, hi;
@@ -72,7 +72,7 @@ static struct cache_tree_sub *find_subtree(struct cache_tree *it,
 					   int create)
 {
 	struct cache_tree_sub *down;
-	int pos = subtree_pos(it, path, pathlen);
+	int pos = cache_tree_subtree_pos(it, path, pathlen);
 	if (0 <= pos)
 		return it->down[pos];
 	if (!create)
@@ -123,7 +123,7 @@ static int do_invalidate_path(struct cache_tree *it, const char *path)
 	it->entry_count = -1;
 	if (!*slash) {
 		int pos;
-		pos = subtree_pos(it, path, namelen);
+		pos = cache_tree_subtree_pos(it, path, namelen);
 		if (0 <= pos) {
 			cache_tree_free(&it->down[pos]->cache_tree);
 			free(it->down[pos]);
diff --git a/cache-tree.h b/cache-tree.h
index 639bfa5340e..8efeccebfc9 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -27,6 +27,8 @@ void cache_tree_free(struct cache_tree **);
 void cache_tree_invalidate_path(struct index_state *, const char *);
 struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
 
+int cache_tree_subtree_pos(struct cache_tree *it, const char *path, int pathlen);
+
 void cache_tree_write(struct strbuf *, struct cache_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 
-- 
gitgitgadget

